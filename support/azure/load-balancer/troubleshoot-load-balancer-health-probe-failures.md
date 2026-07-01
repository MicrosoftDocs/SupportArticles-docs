---
title: Troubleshoot health probe failures in Azure Load Balancer
description: Follow step-by-step diagnostics to resolve health probe failures in Azure Load Balancer, restore healthy backends, and start troubleshooting now.
ms.service: azure-load-balancer
ms.topic: troubleshooting
ms.date: 6/12/2026
ms.custom: sap:No connectivity to backend pool
ai.hint.symptom-tags:
  - health-probe-failure
  - backend-unhealthy
  - probe-down
  - all-instances-unreachable
  - nsg-blocking-probe
  - ghosted-nic
  - probe-timeout
  - probe-port-mismatch
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/loadBalancers/read
  - Microsoft.Network/loadBalancers/backendAddressPools/read
  - Microsoft.Network/networkInterfaces/read
  - Microsoft.Network/networkSecurityGroups/read
  - Microsoft.Compute/virtualMachines/runCommands/write
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - LB_NAME
---

# Troubleshoot health probe failures in Azure Load Balancer

## Summary

This article provides step-by-step guidance to diagnose and resolve health probe failures in Azure Load Balancer. 

Health probe failures in Azure Load Balancer cause backends to be marked as unhealthy and removed from rotation, resulting in connectivity loss or degraded service. The most common root causes are: 

- The backend isn't listening on the probe port. 
- Network security group (NSG) rules block the probe source IP (168.63.129.16).
- Ghosted network interface cards (NICs) are in the backend pool.
- Probe port or path mismatch. 
- A backend application timeout exceeding the probe threshold.

## Symptoms

You might encounter one or more of the following symptoms:

- The [Azure portal](https://portal.azure.com) shows backend pool instances with a health status of **Down** or **Degraded**.
- Load Balancer metrics show `Health Probe Status` at 0 percent for one or more backend instances.
- Clients experience connection timeouts or `connection refused` errors when accessing the load-balanced endpoint.
- Traffic routes only to a subset of backend instances (uneven distribution).
- Alert: `All backend instances for load balancer are probed down`.

## Prerequisites

To troubleshoot health probe failures, you need the following items:

- **Permissions required:** `Network Contributor` role on the load balancer resource group, plus `Virtual Machine Contributor` permissions if you need to run commands on backend virtual machines (VMs).
- **Tools:** Azure CLI 2.x or an AI agent with Azure MCP or CLI access.
- **Required variables and examples of those variables, as shown in the following table**

| Variable | Description | Example |
|---|---|---|
| `$SUBSCRIPTION` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `$RG` | Resource group containing the Load Balancer | `myResourceGroup` |
| `$LB_NAME` | Load Balancer resource name | `myLoadBalancer` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check the overall probe health status for each backend instance in the pool and identify which specific backends are failing probes.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME

az network lb show \
  --name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, sku:sku.name, probes:probes[].{name:name, protocol:protocol, port:port, intervalInSeconds:intervalInSeconds, numberOfProbes:numberOfProbes, requestPath:requestPath}, backendPools:backendAddressPools[].{name:name, backendCount:length(backendAddresses || loadBalancerBackendAddresses || backendIPConfigurations || \`[]\`)}}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `probes` array is empty. | No health probe is configured. Load Balancer uses a default probe on the rule port. | Perform [Step 2](#step-2) and check probe port alignment. |
| `backendCount` is 0 for a pool. | Backend pool has no members configured. | Perform [Resolution C](#resolution-c) and fix ghosted NICs or an empty pool. |
| Probe `protocol` is `Http` or `Https` with a `requestPath`. | Custom HTTP or HTTPS probe is configured. | Perform [Step 2](#step-2) and check probe configuration details. |
| Probe `protocol` is `Tcp` with no `requestPath`. | TCP probe checks port reachability only. | Perform [Step 2](#step-2). |
| `ResourceNotFound` error. | Subscription, resource group, or Load Balancer name is incorrect. | Verify your variables and re-run. |

### Step 2

Check whether the probe configuration (port, protocol, and path) matches what the backend application is actually serving.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME

az network lb probe list \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output json
```

### Interpret the results

Record the following values from the output:

- **Probe port**: The port the probe checks on each backend.
- **Protocol**: `Tcp`, `Http`, or `Https`.
- **Path**: For HTTP or HTTPS probes, the Uniform Resource Identifier (URI) path is checked (for example, `/health`).
- **Interval** and **numberOfProbes**: How often and how many failures happen before marking down.

| If you see... | Meaning | Next steps |
|---|---|---|
| Probe port doesn't match the port your application listens on. | Port mismatch. The probe is checking the wrong port. | Perform [Resolution D](#resolution-d). |
| Probe protocol is `Http` or `Https` and `requestPath` returns non-`200` response. | Path mismatch. The probe path returns an error. | Perform [Resolution D](#resolution-d). |
| `intervalInSeconds` is less than or equal to five and `numberOfProbes` is less than or equal to one (or `probeThreshold` is less than or equal to one). | Aggressive probe timing. A single slow response can mark the backend down within one interval. Record these values. [Step 5](#step-5) compares observed latency against them. | Perform [Step 3](#step-3) and continue, but carry `PROBE_INTERVAL` and `PROBE_PROTOCOL` or `PROBE_PATH` forward. |
| Probe port and path look correct and `intervalInSeconds` is greater than five or `numberOfProbes` is greater than one. | Configuration is aligned and timing isn't aggressive. | Perform [Step 3](#step-3) and check backend pool members. |

> [!NOTE]
> Record `intervalInSeconds`, `numberOfProbes` (or `probeThreshold`), `protocol`, `port`, and `requestPath` from this step. [Step 5](#step-5) prompts you to enter `intervalInSeconds` as `PROBE_INTERVAL` and uses it as the threshold that distinguishes a slow backend from a healthy one.

### Step 3

Check whether the backend pool contains valid NIC references and whether those NICs are in a healthy provisioning state.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME
[ -z "$BACKEND_POOL_NAME" ] && read -rp "Backend Pool Name: " BACKEND_POOL_NAME

az network lb address-pool show \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$BACKEND_POOL_NAME" \
  --output json
```

### Interpret the results

Examine the `backendIPConfigurations` or `loadBalancerBackendAddresses` array. Each entry represents a backend member.

| If you see... | Meaning | Next steps |
|---|---|---|
| `backendIPConfigurations` contains NIC IDs that reference deleted or deallocated VMs. | Ghosted NICs. NIC removed from VM but still in pool. | Perform [Resolution C](#resolution-c). |
| All entries have valid NIC references. | Pool membership is correct. | Perform [Step 4](#step-4) and check NSG rules. |
| `loadBalancerBackendAddresses` shows IP addresses with no virtual network reference. | IP-based pool member with missing virtual network (VNet) link. | Perform [Resolution C](#resolution-c). |

Then check the power state of the VM for each NIC in the pool:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NIC_NAME" ] && read -rp "NIC Name to check (from above output): " NIC_NAME
[ -z "$NIC_RG" ] && read -rp "NIC Resource Group: " NIC_RG

VM_ID=$(az network nic show \
  --name "$NIC_NAME" \
  --resource-group "$NIC_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "virtualMachine.id" \
  --output tsv 2>/dev/null)

if [ -z "$VM_ID" ]; then
  echo "NO_VM: NIC has no associated VM (ghosted NIC)"
else
  VM_RG=$(echo "$VM_ID" | awk -F'/' '{for(i=1;i<=NF;i++) if ($i=="resourceGroups") print $(i+1)}')
  VM_NAME=$(basename "$VM_ID")
  echo "VM_NAME=$VM_NAME"
  az vm get-instance-view \
    --name "$VM_NAME" \
    --resource-group "$VM_RG" \
    --subscription "$SUBSCRIPTION" \
    --query "{vmName:name, powerState:instanceView.statuses[?starts_with(code,'PowerState/')].displayStatus|[0], agentStatus:instanceView.vmAgent.statuses[0].displayStatus}" \
    --output json
fi
```

| If you see... | Meaning | Next steps |
|---|---|---|
| `NO_VM` message. | NIC exists but has no associated VM (a ghosted NIC). | Perform [Resolution C](#resolution-c). |
| `powerState` is `VM deallocated` or `VM stopped`. | VM is off and the backend can't accept connections so all probes fail. | Start the VM if it should be active. If decommissioned, remove it from the pool with [Resolution C](#resolution-c). |
| `agentStatus` isn't `Ready` or is null. | VM is starting up or in a failed state. | Wait for the agent to become ready. If it stays unhealthy, check VM health in the portal. |
| `powerState` is `VM running` AND `agentStatus` is `Ready`. | VM is on and healthy from the platform perspective. | Record `VM_NAME` for use in [Step 4](#step-4). |

### Step 4

Check whether any NSG rule on the backend VM's NIC or subnet is blocking inbound traffic from the Azure health probe source IP (`168.63.129.16`) on the probe port. `az network nic list-effective-nsg` returns all effective inbound rules from both the NIC-level and subnet-level NSGs in a single call, letting you scan for any `Deny` rule that blocks the probe before it reaches the backend.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Backend VM Name (from Step 3): " VM_NAME

# Auto-derive NIC name from VM
NIC_ID=$(az vm show \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv 2>/dev/null)
NIC_NAME=$(basename "$NIC_ID")
NIC_RG=$(echo "$NIC_ID" | awk -F'/' '{for(i=1;i<=NF;i++) if ($i=="resourceGroups") print $(i+1)}')

echo "Listing effective NSG rules for NIC: $NIC_NAME"

az network nic list-effective-nsg \
  --name "$NIC_NAME" \
  --resource-group "$NIC_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "value[].effectiveSecurityRules[?direction=='Inbound'].{priority:priority, access:access, name:name, sourceAddressPrefix:sourceAddressPrefix, destinationPortRange:destinationPortRange}" \
  --output json
```

### Interpret the results

Scan each rule in both arrays of the JSON output (NIC-level rules and subnet-level rules). Evaluate the following table in order by priority number (lower number means higher precedence).

| If you see... | Meaning | Next steps |
|---|---|---|
| Any rule with `"access": "Deny"` whose `sourceAddressPrefix` is `168.63.129.16`, `168.63.129.16/32`, `AzureLoadBalancer`, or `*`, and whose `destinationPortRange` covers the probe port, with a lower `priority` number than any `Allow` rule for the same source and port | NSG `Deny` rule blocks the health probe and the `name` field identifies the exact rule. | Perform [Resolution B](#resolution-b). |
| No `Deny` rules covering the probe port from `168.63.129.16` or `AzureLoadBalancer` appear with lower priority than the corresponding `Allow` rules. | NSG permits the health probe flow. | Perform [Step 5](#step-5) and check backend application. |
| `ResourceNotFound` error. | VM or NIC name is incorrect. | Verify the values from [Step 3](#step-3) and re-run. |

### Step 5

Check whether the backend application is listening on the probe port and whether it responds within the probe interval. The response-time samples are the indicator that distinguishes a slow application ([Resolution E](#resolution-e)) from a healthy backend with a network-level block ([Step 4](#step-4)) and from an HTTP path that returns errors ([Resolution D](#resolution-d)). Without this information, the choice between these solutions can't be made from terminal output alone.

> [!NOTE]
> Enter the following from [Step 2](#step-2): `PROBE_INTERVAL` (the `intervalInSeconds` you recorded), `PROBE_PROTOCOL` (`Tcp`, `Http`, or `Https`), and `PROBE_PATH` (blank for TCP probes). The interpretation table compares observed latency against the `PROBE_INTERVAL`.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Backend VM Name: " VM_NAME
[ -z "$PROBE_PORT" ] && read -rp "Probe Port (from Step 2): " PROBE_PORT
[ -z "$PROBE_INTERVAL" ] && read -rp "Probe intervalInSeconds (from Step 2): " PROBE_INTERVAL
[ -z "$PROBE_PROTOCOL" ] && read -rp "Probe Protocol from Step 2 (Tcp/Http/Https): " PROBE_PROTOCOL
[ -z "$PROBE_PATH" ] && read -rp "Probe Path from Step 2 (blank for TCP): " PROBE_PATH

az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "
set +e
echo '=== Listening ports (all TCP sockets) ==='
ss -tlnp 2>/dev/null || netstat -tlnp 2>/dev/null || echo 'ss/netstat not available'
echo ''
if ss -tlnp 2>/dev/null | grep -qE ':$PROBE_PORT[[:space:]]'; then
  echo 'LISTEN_ON_PROBE_PORT=yes'
else
  echo 'LISTEN_ON_PROBE_PORT=no'
fi
echo ''
echo '=== Service status (top 20 running) ==='
systemctl list-units --type=service --state=running --no-pager 2>/dev/null | head -20 || echo 'systemctl not available'
echo ''
echo \"=== TCP connect-time samples (10 attempts, probe interval = ${PROBE_INTERVAL}s) ===\"
for i in 1 2 3 4 5 6 7 8 9 10; do
  T=\$(curl -s -o /dev/null -w '%{time_connect}' --connect-timeout $PROBE_INTERVAL telnet://127.0.0.1:$PROBE_PORT 2>/dev/null)
  RC=\$?
  if [ \$RC -ne 0 ] || [ -z \"\$T\" ]; then
    echo \"Sample \$i: TIMEOUT (>${PROBE_INTERVAL}s, exit=\$RC)\"
  else
    echo \"Sample \$i: connect=\${T}s\"
  fi
done
PROTO_LOWER=\$(echo '$PROBE_PROTOCOL' | tr '[:upper:]' '[:lower:]')
if [ \"\$PROTO_LOWER\" = 'http' ] || [ \"\$PROTO_LOWER\" = 'https' ]; then
  echo ''
  echo \"=== HTTP probe-path response samples (10 attempts, probe interval = ${PROBE_INTERVAL}s) ===\"
  MAX_T=\$(( PROBE_INTERVAL * 2 ))
  for i in 1 2 3 4 5 6 7 8 9 10; do
    OUT=\$(curl -sk -o /dev/null -w 'HTTP %{http_code} total=%{time_total}s' --connect-timeout $PROBE_INTERVAL --max-time \$MAX_T \"\${PROTO_LOWER}://127.0.0.1:$PROBE_PORT$PROBE_PATH\" 2>/dev/null)
    RC=\$?
    if [ \$RC -ne 0 ] || [ -z \"\$OUT\" ]; then
      echo \"Sample \$i: FAILED (timeout or connection error, exit=\$RC)\"
    else
      echo \"Sample \$i: \$OUT\"
    fi
  done
fi
"
```

For Windows VMs, use:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Backend VM Name: " VM_NAME
[ -z "$PROBE_PORT" ] && read -rp "Probe Port (from Step 2): " PROBE_PORT
[ -z "$PROBE_INTERVAL" ] && read -rp "Probe intervalInSeconds (from Step 2): " PROBE_INTERVAL
[ -z "$PROBE_PROTOCOL" ] && read -rp "Probe Protocol from Step 2 (Tcp/Http/Https): " PROBE_PROTOCOL
[ -z "$PROBE_PATH" ] && read -rp "Probe Path from Step 2 (blank for TCP): " PROBE_PATH

az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunPowerShellScript \
  --scripts "
Write-Output '=== Listening ports (all TCP sockets) ==='
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Sort-Object LocalPort | Format-Table -AutoSize LocalAddress, LocalPort, OwningProcess
if (Get-NetTCPConnection -LocalPort $PROBE_PORT -State Listen -ErrorAction SilentlyContinue) {
  Write-Output 'LISTEN_ON_PROBE_PORT=yes'
} else {
  Write-Output 'LISTEN_ON_PROBE_PORT=no'
}
Write-Output \"=== TCP connect-time samples (10 attempts, probe interval = ${PROBE_INTERVAL}s) ===\"
for (\$i = 1; \$i -le 10; \$i++) {
  \$sw = [System.Diagnostics.Stopwatch]::StartNew()
  try {
    \$c = New-Object System.Net.Sockets.TcpClient
    \$task = \$c.ConnectAsync('127.0.0.1', $PROBE_PORT)
    if (\$task.Wait([TimeSpan]::FromSeconds($PROBE_INTERVAL))) {
      \$sw.Stop()
      Write-Output (\"Sample {0}: connect={1:N3}s\" -f \$i, (\$sw.Elapsed.TotalSeconds))
    } else {
      Write-Output (\"Sample {0}: TIMEOUT (>${PROBE_INTERVAL}s)\" -f \$i)
    }
    \$c.Close()
  } catch {
    Write-Output (\"Sample {0}: FAILED ({1})\" -f \$i, \$_.Exception.Message)
  }
}
\$proto = '$PROBE_PROTOCOL'.ToLower()
if (\$proto -eq 'http' -or \$proto -eq 'https') {
  Write-Output \"=== HTTP probe-path response samples (10 attempts, probe interval = ${PROBE_INTERVAL}s) ===\"
  \$url = \"\${proto}://127.0.0.1:$PROBE_PORT$PROBE_PATH\"
  for (\$i = 1; \$i -le 10; \$i++) {
    try {
      \$sw = [System.Diagnostics.Stopwatch]::StartNew()
      \$r = Invoke-WebRequest -Uri \$url -UseBasicParsing -TimeoutSec ($PROBE_INTERVAL * 2) -SkipCertificateCheck -ErrorAction Stop
      \$sw.Stop()
      Write-Output (\"Sample {0}: HTTP {1} total={2:N3}s\" -f \$i, \$r.StatusCode, (\$sw.Elapsed.TotalSeconds))
    } catch {
      Write-Output (\"Sample {0}: FAILED ({1})\" -f \$i, \$_.Exception.Message)
    }
  }
}
"
```

### Interpret the results

Evaluate the following table in order. The first matching row takes precedence.

| If you see... | Meaning | Next steps |
|---|---|---|
| `LISTEN_ON_PROBE_PORT=no` and the listening-ports output shows a process bound to a different TCP port (for example port 80, 443, 5000, 8000, or any other non-system application port). | Application is listening on a different port than the probe. There's a probe port mismatch. | Perform [Resolution D](#resolution-d). |
| `LISTEN_ON_PROBE_PORT=no` and no other application-style TCP listener is present (only system services like `sshd` on port 22, `systemd-resolved` on 127.0.0.53:53, Remote Procedure Call (RPC) endpoint mapper on port 135, Remote Desktop Protocol (RDP) on port 3389). | Application isn't running or not bound to any port. | Perform [Resolution A](#resolution-a). |
| Any TCP connect-time sample shows `TIMEOUT` or any HTTP sample shows `FAILED`. | Backend can't complete a probe within one interval. There's a slow or saturated app or kernel. | Perform [Resolution E](#resolution-e). |
| Any HTTP sample shows a status code that isn't `200`–`299` (for example `HTTP 404 total=...` or `HTTP 500 total=...`). | Probe path returns an error response. The path or app health endpoint is wrong. | Perform [Resolution D](#resolution-d). |
| Any HTTP sample shows `total=Xs` where `X` is greater than or equal to 50 percent of `PROBE_INTERVAL`, or any TCP sample shows `connect=Xs` where `X` is greater than or equal to 50 percent of `PROBE_INTERVAL`. | Observed response time is at or above half the probe interval. The probe is at imminent risk of timing out. | Perform [Resolution E](#resolution-e). |
| All samples succeed and all observed times are less than `PROBE_INTERVAL` and [Step 2](#step-2) recorded `intervalInSeconds` less than or equal to five and `numberOfProbes` is less than or equal to one. | Backend is fast at this moment, but probe timing is aggressive. The normal variance is enough to cause flapping. | Perform [Resolution E](#resolution-e). |
| All samples succeed and all observed times are less than 50 percent of `PROBE_INTERVAL` and probe timing isn't aggressive (like `intervalInSeconds` is greater than five or `numberOfProbes` is greater than one). | Backend is healthy from inside the VM and probe headroom is adequate. The issue is network-level between Load Balancer and VM. | Perform [Step 4](#step-4) and re-run `list-effective-nsg`. |

---

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| Backend pool is empty or has zero members. | Perform [Resolution C](#resolution-c). |
| Probe port doesn't match application listening port. | Perform [Resolution Dh](#resolution-d). |
| HTTP or HTTPS probe path returns non-`200` status (observed in [Step 5](#step-5) samples). | Perform [Resolution D](#resolution-d). |
| NSG `Deny` rule blocks 168.63.129.16 or `AzureLoadBalancer` on probe port. | Perform [Resolution B](#resolution-b). |
| Application not listening on probe port (service stopped or crashed). | Perform [Resolution A](#resolution-a). |
| NIC in pool references deleted or deallocated VM. | Perform [Resolution C](#resolution-c). |
| [Step 5](#step-5) samples show any TCP `TIMEOUT`, any HTTP `FAILED`, or any sample time greater than or equal to `intervalInSeconds`. | Perform [Resolution E](#resolution-e). |
| All [Step 5](#step-5) samples succeed and are fast, but probe configuration is aggressive (`intervalInSeconds` is less than or equal to five AND `numberOfProbes` is less than or equal to one). | Perform [Resolution E](#resolution-e). |

## Resolution A

The backend application isn't listening on the port that the health probe checks. The service might have crashed, stopped, or failed to start after a reboot.

Common causes include:

- Application service crashed or stopped.
- Application binds to `localhost` (127.0.0.1) instead of all interfaces (0.0.0.0).
- Application startup dependency failed (database, certificate, or configuration).
- VM restarted and application service isn't configured to auto-start.

Run the following commands in Azure CLI.

1. Verify the application service status on the backend VM:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Backend VM Name: " VM_NAME
[ -z "$PROBE_PORT" ] && read -rp "Probe Port: " PROBE_PORT

az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "echo '=== Processes on port $PROBE_PORT ==='; ss -tlnp | grep ':$PROBE_PORT'; echo ''; echo '=== All listening ports ==='; ss -tlnp | grep LISTEN; echo ''; echo '=== Failed services ==='; systemctl --failed 2>/dev/null || echo 'systemctl not available'"
```

Record which service should be listening on the probe port. If no process is listening, identify the expected service name.

2. Start or restart the application service.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Backend VM Name: " VM_NAME
[ -z "$SERVICE_NAME" ] && read -rp "Service name to restart (e.g., nginx, httpd, webapp): " SERVICE_NAME

az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "systemctl start $SERVICE_NAME && systemctl enable $SERVICE_NAME && echo 'Service started and enabled' || echo 'FAILED to start service - check logs with: journalctl -u $SERVICE_NAME --no-pager -n 50'"
```

For Windows VMs:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Backend VM Name: " VM_NAME
[ -z "$SERVICE_NAME" ] && read -rp "Windows Service name (e.g., W3SVC, nginx): " SERVICE_NAME

az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunPowerShellScript \
  --scripts "Start-Service '$SERVICE_NAME' -ErrorAction Stop; Set-Service '$SERVICE_NAME' -StartupType Automatic; Write-Output 'Service started and set to Automatic'"
```

3. Verify the fix by confirming the probe port is now listening:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Backend VM Name: " VM_NAME
[ -z "$PROBE_PORT" ] && read -rp "Probe Port: " PROBE_PORT

az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "timeout 5 bash -c \"echo > /dev/tcp/127.0.0.1/$PROBE_PORT\" 2>&1 && echo 'SUCCESS: Port $PROBE_PORT is now listening' || echo 'FAIL: Port $PROBE_PORT still not listening'"
```

The health probe recovers within one probe interval (typically 5–15 seconds). Re-run [Step 1](#step-1) to confirm the backend shows as `healthy` in Load Balancer metrics.

If the service keeps crashing, investigate application logs on the VM and resolve the underlying application problems before proceeding.

## Resolution B

An NSG rule on the backend subnet or NIC blocks inbound health probe traffic from Azure's probe source IP (168.63.129.16) on the probe port.

Load Balancer health probes originate from IP address `168.63.129.16` regardless of your configured source range. The backend must allow this IP inbound on the probe port.

Run the following commands in Azure CLI.

1. Identify the blocking NSG rule:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NSG_NAME" ] && read -rp "NSG Name: " NSG_NAME
[ -z "$NSG_RG" ] && read -rp "NSG Resource Group: " NSG_RG
[ -z "$PROBE_PORT" ] && read -rp "Probe Port: " PROBE_PORT

az network nsg rule list \
  --nsg-name "$NSG_NAME" \
  --resource-group "$NSG_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[?direction=='Inbound' && access=='Deny'].{name:name, priority:priority, sourceAddress:sourceAddressPrefix, destPort:destinationPortRange, protocol:protocol}" \
  --output table
```

Look for `Deny` rules with priority lower than any `Allow` rule for `168.63.129.16` or `AzureLoadBalancer` on the probe port.

2. Add an `Allow` rule for the health probe source IP with a priority lower (higher precedence) than the blocking `Deny` rule.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NSG_NAME" ] && read -rp "NSG Name: " NSG_NAME
[ -z "$NSG_RG" ] && read -rp "NSG Resource Group: " NSG_RG
[ -z "$PROBE_PORT" ] && read -rp "Probe Port: " PROBE_PORT
[ -z "$RULE_PRIORITY" ] && read -rp "Rule Priority (must be lower number than blocking Deny rule): " RULE_PRIORITY

az network nsg rule create \
  --nsg-name "$NSG_NAME" \
  --resource-group "$NSG_RG" \
  --subscription "$SUBSCRIPTION" \
  --name Allow-AzureLB-HealthProbe \
  --priority "$RULE_PRIORITY" \
  --direction Inbound \
  --source-address-prefixes 168.63.129.16 \
  --destination-port-ranges "$PROBE_PORT" \
  --protocol Tcp \
  --access Allow
```

> [!NOTE]
> NSG rule priorities must be between 100 and 4096. If the blocking `Deny` rule is already at priority 100 (the minimum), you can't add a higher-precedence `Allow` rule. In this case, delete the `Deny` rule instead by using `az network nsg rule delete --nsg-name "$NSG_NAME" --resource-group "$NSG_RG" --name <deny-rule-name>`.

3. Verify the NSG now allows probe traffic:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NSG_NAME" ] && read -rp "NSG Name: " NSG_NAME
[ -z "$NSG_RG" ] && read -rp "NSG Resource Group: " NSG_RG

az network nsg rule list \
  --nsg-name "$NSG_NAME" \
  --resource-group "$NSG_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "sort_by([?direction=='Inbound'], &priority)[].{name:name, priority:priority, access:access, sourceAddress:sourceAddressPrefix, destPort:destinationPortRange}" \
  --output table
```

Confirm the `Allow` rule for `168.63.129.16` appears with a lower priority number than any `Deny` rule covering the same port. The probe should recover within one interval. Re-run [Step 1](#step-1) to confirm.

## Resolution C

The backend pool contains references to NICs that you no longer attached to running VMs (ghosted NICs), or the pool is empty because you removed members without replacement.

Common causes include:

- You deleted a VM but didn't remove its NIC from the backend pool.
- You deallocated a VM and dissociated its NIC.
- You scaled in a scale set but didn't clean up pool references.
- IP-based backend addresses have stale entries.

Run the following commands in Azure CLI.

1. List the current backend pool members and their provisioning state:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME
[ -z "$BACKEND_POOL_NAME" ] && read -rp "Backend Pool Name: " BACKEND_POOL_NAME

az network lb address-pool show \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$BACKEND_POOL_NAME" \
  --query "{name:name, backendIPConfigurations:backendIPConfigurations[].id, loadBalancerBackendAddresses:loadBalancerBackendAddresses[].{name:name, ip:ipAddress, subnet:subnet.id, nicId:networkInterfaceIPConfiguration.id}}" \
  --output json
```

For each NIC ID listed, verify it still exists:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NIC_NAME" ] && read -rp "NIC Name to check: " NIC_NAME
[ -z "$NIC_RG" ] && read -rp "NIC Resource Group: " NIC_RG

az network nic show \
  --name "$NIC_NAME" \
  --resource-group "$NIC_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, provisioningState:provisioningState, vmId:virtualMachine.id, primary:primary}" \
  --output json
```

**Interpret the results**

| If you see... | Meaning |
|---|---|
| `vmId` is null. | NIC exists but isn't attached to any VM (ghosted). |
| `ResourceNotFound` error. | NIC was deleted but is still referenced in the pool. |
| `provisioningState` isn't `Succeeded`. | NIC is in a failed state. |

2. Remove the ghosted or invalid NIC from the backend pool. For NIC-based pools, disassociate the NIC from the load balancer.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NIC_NAME" ] && read -rp "Ghosted NIC Name: " NIC_NAME
[ -z "$NIC_RG" ] && read -rp "NIC Resource Group: " NIC_RG
[ -z "$IP_CONFIG_NAME" ] && read -rp "IP Config Name (usually ipconfig1): " IP_CONFIG_NAME

az network nic ip-config address-pool remove \
  --nic-name "$NIC_NAME" \
  --resource-group "$NIC_RG" \
  --subscription "$SUBSCRIPTION" \
  --ip-config-name "$IP_CONFIG_NAME" \
  --lb-name "$LB_NAME" \
  --address-pool "$BACKEND_POOL_NAME"
```

For IP-based backend pools, remove the stale address:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME
[ -z "$BACKEND_POOL_NAME" ] && read -rp "Backend Pool Name: " BACKEND_POOL_NAME
[ -z "$ADDRESS_NAME" ] && read -rp "Backend Address Name (from C.1): " ADDRESS_NAME

az network lb address-pool address remove \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --pool-name "$BACKEND_POOL_NAME" \
  --name "$ADDRESS_NAME"
```

3. Verify the pool now contains only valid members. Re-run [Step 3](#step-3) and confirm no ghosted references remain. Then re-run [Step 1](#step-1) to verify remaining backends show healthy probes.

If the pool is now empty and you need to add new backends, add healthy VMs back to the pool:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$NIC_NAME" ] && read -rp "NIC Name of healthy VM: " NIC_NAME
[ -z "$NIC_RG" ] && read -rp "NIC Resource Group: " NIC_RG
[ -z "$IP_CONFIG_NAME" ] && read -rp "IP Config Name (usually ipconfig1): " IP_CONFIG_NAME

az network nic ip-config address-pool add \
  --nic-name "$NIC_NAME" \
  --resource-group "$NIC_RG" \
  --subscription "$SUBSCRIPTION" \
  --ip-config-name "$IP_CONFIG_NAME" \
  --lb-name "$LB_NAME" \
  --address-pool "$BACKEND_POOL_NAME"
```

## Resolution D

You configured the health probe with a port or HTTP path that doesn't match what the backend application serves. As a result, the probe gets connection refused, timeout, or non-`200` HTTP responses.

Common causes include:

- Probe checks port 80 but application listens on port 8080.
- HTTP probe path is `/health` but application health endpoint is `/healthz` or `/api/health`.
- Application returns 404 errors on the configured probe path.
- HTTPS probe is active but backend only serves HTTP (or vice versa).

Run the following commands in Azure CLI.

1. Confirm the current probe configuration and the actual application listening state:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME

az network lb probe list \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, protocol:protocol, port:port, requestPath:requestPath, intervalInSeconds:intervalInSeconds, numberOfProbes:numberOfProbes}" \
  --output table
```

Compare the probe port and path against what the backend application actually serves (from the [Step 5](#step-5) results).

2. Update the probe to use the correct port and path.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME
[ -z "$PROBE_NAME" ] && read -rp "Probe Name: " PROBE_NAME
[ -z "$CORRECT_PORT" ] && read -rp "Correct probe port (port app listens on): " CORRECT_PORT
[ -z "$CORRECT_PATH" ] && read -rp "Correct probe path (e.g., / or /health, leave blank for TCP): " CORRECT_PATH

if [ -n "$CORRECT_PATH" ]; then
  az network lb probe update \
    --lb-name "$LB_NAME" \
    --resource-group "$RG" \
    --subscription "$SUBSCRIPTION" \
    --name "$PROBE_NAME" \
    --port "$CORRECT_PORT" \
    --path "$CORRECT_PATH"
else
  az network lb probe update \
    --lb-name "$LB_NAME" \
    --resource-group "$RG" \
    --subscription "$SUBSCRIPTION" \
    --name "$PROBE_NAME" \
    --port "$CORRECT_PORT"
fi
```

3. Verify the fix. Re-run [Step 2](#step-2) to confirm the probe configuration now matches the application. Then wait one probe interval and re-run [Step 1](#step-1) to confirm backends become healthy.

## Resolution E

The backend application responds to health probes too slowly, exceeding the probe timeout threshold. After the configured number of consecutive failures (`numberOfProbes`), the instance is marked as unhealthy.

Common causes include:

- Application startup takes longer than the probe timeout (cold start).
- Application health endpoint depends on a slow downstream service.
- Probe interval and threshold are too aggressive for the application's response time.
- Application under heavy load can't respond to probes within the timeout.

Run the following commands in Azure CLI.

1. Check the current probe timeout and threshold configuration.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME

az network lb probe list \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "[].{name:name, protocol:protocol, port:port, intervalInSeconds:intervalInSeconds, numberOfProbes:numberOfProbes, probeThreshold:probeThreshold}" \
  --output table
```

For Standard Load Balancer, the `probeThreshold` value determines how many consecutive successful probes are needed to mark an instance back as healthy.

| Parameter | Recommended minimum for slow applications |
|---|---|
| `intervalInSeconds` | 15–30 seconds. |
| `numberOfProbes` | 2–4 (number of failures before marking down). |
| `probeThreshold` | 1–2 (consecutive successes needed to mark up). |

2. Verify the backend application response time:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Backend VM Name: " VM_NAME
[ -z "$PROBE_PORT" ] && read -rp "Probe Port: " PROBE_PORT
[ -z "$PROBE_PATH" ] && read -rp "Probe Path (e.g., / or /health): " PROBE_PATH

az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "echo '=== Response time test (3 attempts) ==='; for i in 1 2 3; do echo \"Attempt \$i:\"; time curl -s -o /dev/null -w 'HTTP %{http_code} in %{time_total}s\n' http://127.0.0.1:$PROBE_PORT$PROBE_PATH; sleep 1; done"
```

If the response time exceeds the current probe timeout (default is roughly five seconds for TCP, configurable for HTTP), the probe times out.

3. Increase the probe interval and threshold to accommodate the application's response time.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$LB_NAME" ] && read -rp "Load Balancer Name: " LB_NAME
[ -z "$PROBE_NAME" ] && read -rp "Probe Name: " PROBE_NAME

az network lb probe update \
  --lb-name "$LB_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --name "$PROBE_NAME" \
  --interval 15 \
  --probe-threshold 2
```

> [!NOTE]
> The `--probe-threshold` parameter controls how many consecutive probe successes and failures are needed to change backend health status. The older `--threshold` (which sets `numberOfProbes`) is deprecated and then no longer recognized by Load Balancer. Use `--probe-threshold` exclusively. Adjust `--interval` and `--probe-threshold` based on the response times measured in step E.2. The interval should be at least twice the worst-case response time observed.

4. Verify the fix. Wait 2–3 probe intervals (30–45 seconds with the updated settings) then re-run [Step 1](#step-1). Backends should transition from `Down` to `healthy` as probes succeed within the new timeout window.

If the application consistently takes more than 30 seconds to respond to health checks, the underlying application performance issue should be investigated separately. Probe tuning is a workaround, not a fix.

## References 

- [Troubleshoot Azure Load Balancer health probe status](/azure/load-balancer/load-balancer-troubleshoot-health-probe-status)
- [Azure Load Balancer health probes](/azure/load-balancer/load-balancer-custom-probe-overview)
- [What is Azure Load Balancer?](/azure/load-balancer/load-balancer-overview)
- [NSG service tags — AzureLoadBalancer](/azure/virtual-network/service-tags-overview)
- [Manage backend pools](/azure/load-balancer/backend-pool-management)
