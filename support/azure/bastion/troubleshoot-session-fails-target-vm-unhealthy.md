---
title: Troubleshoot Azure Bastion session failures due to unhealthy target virtual machines
description: Diagnose and fix Azure Bastion session failures caused by stopped VMs, firewall blocks, or unhealthy services. Get step-by-step troubleshooting guidance to restore connectivity.
ms.service: azure-bastion
ms.topic: troubleshooting
ms.date: 6/17/2026
ms.custom: sap:Configuration and setup
ai.hint.symptom-tags:
  - bastion-session-failure
  - target-vm-unhealthy
  - rdp-service-stopped
  - ssh-daemon-not-running
  - vm-stopped-deallocated
  - guest-firewall-blocking
  - vm-agent-unhealthy
  - nla-misconfiguration
  - os-disk-full
  - connection-timeout
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/bastionHosts/read
  - Microsoft.Compute/virtualMachines/read
  - Microsoft.Compute/virtualMachines/instanceView/read
  - Microsoft.Compute/virtualMachines/runCommand/action
  - Microsoft.Compute/virtualMachines/start/action
  - Microsoft.Network/networkInterfaces/read
  - Microsoft.Network/networkInterfaces/effectiveNetworkSecurityGroups/action
  - Microsoft.Network/networkSecurityGroups/read
  - Microsoft.Network/networkSecurityGroups/write
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - BASTION_RESOURCE_GROUP
  - BASTION_NAME
  - VM_RESOURCE_GROUP
  - VM_NAME
---

# Troubleshoot Azure Bastion session failures due to unhealthy target VMs

## Summary

This article provides step-by-step guidance to diagnose and resolve Azure Bastion session failures caused by problems on the target virtual machine (VM). It covers common root causes such as stopped or deallocated VMs, guest OS firewall blocks, crashed Remote Desktop Protocol (RDP) or Secure Shell (SSH) services, unhealthy VM agents, and Network Level Authentication (NLA) misconfiguration.

Azure Bastion session failures frequently occur because of problems on the target VM rather than the Azure Bastion host itself. The most common reasons are: 

- The VM is stopped or deallocated. 
- The RDP service (Windows) or SSH daemon (Linux) isn't running. 
- The guest OS firewall blocks port 3389 or 22. 
- A network security group (NSG) rule blocks Azure Bastion-to-VM connectivity. 
- The VM agent is unhealthy. 
- NLA is misconfigured on Windows. 

## Symptoms

You might encounter one or more of the following symptoms:

- The Azure Bastion session from the [Azure portal](https://portal.azure.com) fails with a connection error or timeout.
- The portal shows **Unable to connect to the virtual machine** when connecting through Azure Bastion.
- The Azure Bastion host is provisioned and shows **Succeeded** but sessions to a specific VM fail.
- Connection attempts stop responding and eventually time out.
- RDP or SSH session connects through Azure Bastion but immediately disconnects.
- Azure Bastion works for other VMs in the same virtual network (VNet) but fails for one specific VM.

## Prerequisites

- **Permissions required:** `Reader` permissions on the Azure Bastion host resource group and `Virtual Machine Contributor` permissions on the target VM resource group (for `runCommand` and `start` operations).
- **Tools:** Azure CLI 2.x or an AI agent with Azure CLI access.
- **Required variables and examples of those variables, as shown in the following table:**

| Variable | Description | Example |
|---|---|---|
| `SUBSCRIPTION` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `BASTION_RG` | Resource group containing the Azure Bastion host | `bastion-rg` |
| `BASTION_NAME` | Azure Bastion host resource name | `myBastionHost` |
| `VM_RG` | Resource group containing the target VM | `vm-rg` |
| `VM_NAME` | Target VM name | `myVM` |

> **TIP:** Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check whether the Azure Bastion host is provisioned and healthy. If Azure Bastion isn't healthy, the problem is on the Azure Bastion side and this guidance doesn't apply.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:        " SUBSCRIPTION
[ -z "$BASTION_RG" ] && read -rp "Bastion Resource Group:  " BASTION_RG
[ -z "$BASTION_NAME" ] && read -rp "Bastion Host Name:      " BASTION_NAME

az network bastion show \
  --name "$BASTION_NAME" \
  --resource-group "$BASTION_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{name:name, provisioningState:provisioningState, sku:sku.name}" \
  --output table
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `provisioningState: Succeeded`. | Azure Bastion host is healthy. | Perform [Step 2](#step-2). |
| `provisioningState: Failed` or `Updating`. | Azure Bastion host itself has a problem. | This guidance covers VM-side issues only. See [Troubleshoot Azure Bastion host deployment failures](troubleshoot-host-deployment-failures.md). |
| `ResourceNotFound` error. | Azure Bastion name or resource group is incorrect. | Verify your variables and re-run. |

### Step 2

Check whether the target VM is running and whether the VM agent is healthy. A stopped or deallocated VM can't accept Azure Bastion connections. An unhealthy VM agent prevents the remote command execution needed for guest OS diagnostics in later steps.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm get-instance-view \
  --name "$VM_NAME" \
  --resource-group "$VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{powerState:statuses[?starts_with(code,'PowerState/')].displayStatus|[0], agentStatus:vmAgent.statuses[0].displayStatus, agentVersion:vmAgent.vmAgentVersion}" \
  --output table
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `powerState: VM running` and `agentStatus: Ready`. | VM is running and agent is healthy. | Perform [Step 3](#step-3). |
| `powerState: VM stopped` or `VM deallocated`. | VM isn't running. Azure Bastion can't connect. | Perform [Resolution A](#resolution-a). |
| `powerState: VM running` and `agentStatus` is empty or `Not Ready`. | VM is running but agent is unhealthy. Guest OS diagnostics [Steps 5a](#step-5a) and [5b](#step-5b) won't work. | Perform [Resolution E](#resolution-e). |
| `agentVersion` and `agentStatus` are both empty. | VM agent isn't installed. Skip [Steps 5a](#step-5a) and [5b](#step-5b). | Perform [Step 3](#step-3) and then [Step 4](#step-4) only. |

### Step 3

Check the VM's OS type (Windows or Linux) and its primary network interface card (NIC) ID. The OS type determines which guest diagnostics to run later. The NIC ID is needed for the NSG check in [Step 4](#step-4).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm show \
  --name "$VM_NAME" \
  --resource-group "$VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{osType:storageProfile.osDisk.osType, nicId:networkProfile.networkInterfaces[0].id}" \
  --output json
```

### Interpret the results

Record both values as you need them in subsequent steps:

| Field | What to record |
|---|---|
| `osType` | `Windows` or `Linux` determines which guest diagnostics to run. |
| `nicId` | Full resource ID of the primary NIC needed for [Step 4](#step-4). |

| If you see... | Next step |
|---|---|
| `osType: Windows`. | Perform [Step 4](#step-4) and then [Step 5a](#step-5a). |
| `osType: Linux`. | Perform [Step 4](#step-4) and then [Step 5b](#step-5b). |

### Step 4

Check whether NSG rules on the VM's NIC or subnet block inbound traffic from the Azure Bastion subnet on the connection port (3389 for Windows and RDP, 22 for Linux and SSH). Azure Bastion connects to the VM's private IP from the `AzureBastionSubnet`.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

# Get the VM's primary NIC ID
NIC_ID=$(az vm show \
  --name "$VM_NAME" \
  --resource-group "$VM_RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv)

# Get NIC-level NSG (if any)
NIC_NSG=$(az network nic show --ids "$NIC_ID" \
  --query "networkSecurityGroup.id" --output tsv 2>/dev/null)

# Get subnet ID and subnet-level NSG (if any)
SUBNET_ID=$(az network nic show --ids "$NIC_ID" \
  --query "ipConfigurations[0].subnet.id" --output tsv)
SUBNET_NSG=$(az network vnet subnet show --ids "$SUBNET_ID" \
  --query "networkSecurityGroup.id" --output tsv 2>/dev/null)

echo "NIC NSG:    ${NIC_NSG:-None}"
echo "Subnet NSG: ${SUBNET_NSG:-None}"

# Show inbound rules for each NSG
for NSG_ID in $NIC_NSG $SUBNET_NSG; do
  if [ -n "$NSG_ID" ] && [ "$NSG_ID" != "None" ]; then
    echo ""
    echo "=== NSG: $(basename $NSG_ID) ==="
    az network nsg show --ids "$NSG_ID" \
      --query "securityRules[?direction=='Inbound'].{Name:name, Priority:priority, Access:access, Source:sourceAddressPrefix, DestPort:destinationPortRange}" \
      --output table
  fi
done

if [ -z "$NIC_NSG" ] && [ -z "$SUBNET_NSG" ]; then
  echo "No NSG is applied to the VM NIC or subnet — network traffic is not filtered."
fi
```

### Interpret the results

Review the output for rules that affect port 3389 (Windows and RDP) or 22 (Linux and SSH). NSG rules are evaluated in priority order. The lowest priority number is evaluated first.

| If you see... | Meaning | Next steps |
|---|---|---|
| No NSG applied to NIC or subnet, | Traffic isn't filtered at the NSG level. | Perform [Step 5a](#step-5a) for Windows or [Step 5b](#step-5b) for Linux. |
| An `Allow` rule for port 3389 or 22 at a lower priority number than any `Deny` rule for that port. | Traffic is allowed. | Perform [Step 5a](#step-5a) for Windows or [Step 5b](#step-5b) for Linux. |
| A `Deny` rule for port 3389, 22, or `*` at a lower priority number than any `Allow` rule for that port. | NSG is blocking Azure Bastion-to-VM connectivity. | Perform [Resolution B](#resolution-b). |
| A `Deny` rule for port 3389, 22, or `*` with no corresponding `Allow` rule at a lower priority. | NSG is blocking Azure Bastion-to-VM connectivity. | Perform [Resolution B](#resolution-b). |

### Step 5a

Check Windows-specific guest OS health, including: 

- Whether the RDP service (TermService) is running. 
- Whether RDP is enabled in the registry. 
- Whether Windows Firewall allows RDP connections. 
- Whether NLA settings are compatible with Azure Bastion. 
- Whether the OS disk has free space. 

This step requires a healthy VM agent (confirmed in [Step 2](#step-2)).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm run-command invoke \
  --resource-group "$VM_RG" \
  --name "$VM_NAME" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunPowerShellScript \
  --scripts \
    'Write-Output "=== RDP Service (TermService) ==="' \
    '$svc = Get-Service TermService -ErrorAction SilentlyContinue' \
    'if ($svc) { Write-Output "Status: $($svc.Status)" } else { Write-Output "Status: NOT FOUND" }' \
    'Write-Output ""' \
    'Write-Output "=== RDP Enabled ==="' \
    '$deny = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -ErrorAction SilentlyContinue).fDenyTSConnections' \
    'Write-Output "fDenyTSConnections: $deny (0=enabled, 1=disabled)"' \
    'Write-Output ""' \
    'Write-Output "=== Windows Firewall - RDP Inbound Rules ==="' \
    'Get-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction SilentlyContinue | Where-Object { $_.Direction -eq "Inbound" } | Select-Object DisplayName, Enabled, Action | Format-Table -AutoSize | Out-String' \
    'Write-Output "=== NLA Setting ==="' \
    '$nla = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -ErrorAction SilentlyContinue).UserAuthentication' \
    'Write-Output "UserAuthentication: $nla (1=NLA required, 0=NLA not required)"' \
    'Write-Output ""' \
    'Write-Output "=== OS Disk Free Space ==="' \
    'Get-PSDrive C -ErrorAction SilentlyContinue | Select-Object @{N="FreeGB";E={[math]::Round($_.Free/1GB,2)}} | Format-Table -AutoSize | Out-String' \
  --query "value[0].message" \
  --output tsv
```

### Interpret the results

| Section | If you see... | Meaning | Next steps |
|---|---|---|---|
| RDP Service | `Status: Running`. | TermService is running. | Check the next section. |
| RDP Service | `Status: Stopped` or `NOT FOUND`. | RDP listener is down. Azure Bastion sessions can't connect. | Perform [Resolution C](#resolution-c). |
| RDP Enabled | `fDenyTSConnections: 0`. | RDP is enabled. | Check the next section. |
| RDP Enabled | `fDenyTSConnections: 1`. | RDP is disabled at the OS level. | Perform [Resolution C](#resolution-c). |
| Firewall | `Enabled: True` and `Action: Allow` for RDP rules. | Windows Firewall allows RDP. | Check the next section. |
| Firewall | `Enabled: False` or no rules listed. | Windows Firewall is blocking RDP. | Perform [Resolution D](#resolution-d). |
| NLA Setting | `UserAuthentication: 0`. | NLA is not required. | Check next section |
| NLA Setting | `UserAuthentication: 1` and sessions drop immediately after connection. | NLA handshake is failing. | Perform [Resolution F](#resolution-f) |
| Disk | `FreeGB` greater than one. | Sufficient disk space. | If all sections are healthy, file an Azure support request. |
| Disk | `FreeGB` is 0 or less than 0.5. | OS disk is full. OS might be unresponsive. | Free disk space up through run-command or extend the OS disk. See [Troubleshoot a Windows VM by attaching the OS disk to a recovery VM](/azure/virtual-machines/troubleshooting/troubleshoot-recovery-disks-windows). |

### Step 5b

Check Linux-specific guest OS health, including: 

- Whether the SSH daemon is running. 
- Port 22 is listening. 
- Host-level firewall rules (`iptables` and `firewalld`) allow SSH connections. 

This step requires a healthy VM agent (confirmed in [Step 2](#step-2)).

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm run-command invoke \
  --resource-group "$VM_RG" \
  --name "$VM_NAME" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts \
    'echo "=== SSH Daemon Status ==="' \
    'systemctl is-active sshd 2>/dev/null || systemctl is-active ssh 2>/dev/null || echo "INACTIVE"' \
    'echo ""' \
    'echo "=== SSH Port Listening ==="' \
    'ss -tlnp 2>/dev/null | grep -E ":22\b" || echo "Nothing listening on port 22"' \
    'echo ""' \
    'echo "=== iptables Rules (INPUT chain) ==="' \
    'iptables -L INPUT -n --line-numbers 2>/dev/null | head -20 || echo "iptables not available"' \
    'echo ""' \
    'echo "=== firewalld Status ==="' \
    'if systemctl is-active firewalld >/dev/null 2>&1; then firewall-cmd --list-services 2>/dev/null; else echo "firewalld not active"; fi' \
    'echo ""' \
    'echo "=== OS Disk Free Space ==="' \
    'df -h / 2>/dev/null | tail -1' \
  --query "value[0].message" \
  --output tsv
```

### Interpret the results

| Section | If you see... | Meaning | Next steps |
|---|---|---|---|
| SSH Daemon | `active`. | SSH daemon is running. | Check the next section. |
| SSH Daemon | `INACTIVE` or `inactive`. | SSH daemon isn't running. Azure Bastion sessions can't connect. | Perform [Resolution C](#resolution-c). |
| SSH Port | A line showing `:22` with `sshd`. | Port 22 is listening. | Check the next section. |
| SSH Port | `Nothing listening on port 22`. | SSH daemon isn't listening. It might be configured on a different port or not running. | Perform [Resolution C](#resolution-c). |
| iptables | No `DROP` or `REJECT` rules targeting port 22 or all ports. | `iptables` isn't blocking SSH. | Check the next section. |
| iptables | A `DROP` or `REJECT` rule matching port 22 or all ports. | `iptables` is blocking SSH. | Perform [Resolution D](#resolution-d). |
| firewalld | Output includes `ssh` in the services list. | `firewalld` allows SSH. | Check the next section. |
| firewalld | `firewalld not active`. | `firewalld` isn't filtering traffic. | Check the next section. |
| firewalld | `firewalld` is active but `ssh` is not listed | `firewalld` is blocking SSH | Perform [Resolution D](#resolution-d). |
| Disk | Usage below 95 percent. | Sufficient disk space. | If all sections are healthy, file an Azure support request. |
| Disk | Usage at 100 percent or no output. | OS disk is full. OS might be unresponsive. | Free disk space through run-command or extend the OS disk. See [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM](/azure/virtual-machines/troubleshooting/troubleshoot-recovery-disks-linux). |


Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| Azure Bastion provisioning state isn't `Succeeded`. | Troubleshoot the Azure Bastion host (out of scope for this guidance). |
| VM is stopped or deallocated. | Perform [Resolution A](#resolution-a). |
| VM agent is unhealthy or not ready. | Perform [Resolution E](#resolution-e). |
| NSG deny rule blocks inbound on port 3389 or 22 from Azure Bastion subnet. | Perform [Resolution B](#resolution-b). |
| Windows: TermService stopped or RDP disabled (`fDenyTSConnections: 1`). | Perform [Resolution C](#resolution-c). |
| Linux: SSH daemon not running or not listening on port 22. | Perform [Resolution C](#resolution-c). |
| Windows: Windows Firewall blocking RDP. | Perform [Resolution D](#resolution-d). |
| Linux: `iptables` or `firewalld`blocking SSH. | Perform [Resolution D](#resolution-d). |
| Windows: Azure Bastion connects but session drops immediately after authentication (NLA issue). | Perform [Resolution F](#resolution-f). |
| All diagnostics pass but sessions still fail. | File an Azure support request. |

## Resolution A

The target VM is stopped or deallocated. A VM must be in the `Running` power state to accept Azure Bastion connections.

Run the following commands in Azure CLI.

1. Start the VM.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm start \
  --name "$VM_NAME" \
  --resource-group "$VM_RG" \
  --subscription "$SUBSCRIPTION"
```

1. Wait 1–2 minutes for the VM to finish booting, and then re-run [Step 2](#step-2). The power state should show `VM running`.

Retry the Azure Bastion connection. If it still fails, go to [Step 3](#step-3) to check guest OS health.

## Resolution B

An NSG rule on the VM's NIC or subnet blocks inbound traffic on port 3389 (RDP) or 22 (SSH) from the Azure Bastion subnet.

Run the following commands in Azure CLI.

1. Identify the blocking rule from the [Step 4](#step-4) output. Note the NSG name, the rule name, and the rule priority.
1. Add an allow rule for Azure Bastion-to-VM connectivity. Set the priority to a number lower than the blocking deny rule so it's evaluated first.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:             " SUBSCRIPTION
[ -z "$NSG_RG" ] && read -rp "NSG Resource Group:          " NSG_RG
[ -z "$NSG_NAME" ] && read -rp "NSG Name (from Step 4):      " NSG_NAME
[ -z "$BASTION_SUBNET_CIDR" ] && read -rp "Bastion Subnet CIDR:         " BASTION_SUBNET_CIDR
[ -z "$CONNECTION_PORT" ] && read -rp "Connection Port (3389 or 22): " CONNECTION_PORT

az network nsg rule create \
  --nsg-name "$NSG_NAME" \
  --resource-group "$NSG_RG" \
  --subscription "$SUBSCRIPTION" \
  --name Allow-Bastion-Inbound \
  --priority 100 \
  --direction Inbound \
  --source-address-prefix "$BASTION_SUBNET_CIDR" \
  --destination-port-range "$CONNECTION_PORT" \
  --protocol Tcp \
  --access Allow
```

Adjust `--priority` if 100 conflicts with an existing rule. The value must be lower than the blocking `Deny` rule's priority.

3. Re-run [Step 4](#step-4). The new allow rule appears at a lower priority than the `Deny` rule.  

Retry the Azure Bastion connection.

## Resolution C

The RDP service (Windows) or SSH daemon (Linux) on the target VM isn't running or isn't listening on the expected port.

Run the following commands in Azure CLI.

1. For Windows, enable RDP and restart TermService.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm run-command invoke \
  --resource-group "$VM_RG" \
  --name "$VM_NAME" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunPowerShellScript \
  --scripts \
    'Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Value 0' \
    'Set-Service TermService -StartupType Automatic' \
    'Start-Service TermService' \
    'Write-Output "TermService status: $((Get-Service TermService).Status)"' \
  --query "value[0].message" \
  --output tsv
```

2. For Linux, enable and restart the SSH daemon.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm run-command invoke \
  --resource-group "$VM_RG" \
  --name "$VM_NAME" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts \
    'systemctl enable sshd 2>/dev/null || systemctl enable ssh 2>/dev/null' \
    'systemctl restart sshd 2>/dev/null || systemctl restart ssh 2>/dev/null' \
    'echo "sshd status: $(systemctl is-active sshd 2>/dev/null || systemctl is-active ssh 2>/dev/null)"' \
  --query "value[0].message" \
  --output tsv
```

3. Re-run [Step 5a](#step-5a) for Windows or [Step 5b](#step-5b) for Linux to confirm the service is running and listening. 

Retry the Azure Bastion connection.

## Resolution D

The guest OS firewall (Windows Firewall, `iptables`, or `firewalld`) blocks inbound connections on the RDP or SSH port.

Run the following commands in Azure CLI.

1. For Windows, enable the RDP firewall rules.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm run-command invoke \
  --resource-group "$VM_RG" \
  --name "$VM_NAME" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunPowerShellScript \
  --scripts \
    'Enable-NetFirewallRule -DisplayGroup "Remote Desktop"' \
    'Get-NetFirewallRule -DisplayGroup "Remote Desktop" | Where-Object { $_.Direction -eq "Inbound" } | Select-Object DisplayName, Enabled, Action | Format-Table -AutoSize | Out-String' \
  --query "value[0].message" \
  --output tsv
```

2. For Linux, allow SSH through `iptables` or `firewalld`.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm run-command invoke \
  --resource-group "$VM_RG" \
  --name "$VM_NAME" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts \
    'if systemctl is-active firewalld >/dev/null 2>&1; then' \
    '  firewall-cmd --permanent --add-service=ssh' \
    '  firewall-cmd --reload' \
    '  echo "firewalld: SSH service added"' \
    'else' \
    '  iptables -I INPUT 1 -p tcp --dport 22 -j ACCEPT' \
    '  echo "iptables: SSH allow rule added"' \
    'fi' \
    'ss -tlnp | grep ":22" || echo "Port 22 still not listening — check sshd"' \
  --query "value[0].message" \
  --output tsv
```

3. Re-run [Step 5a](#step-5a) (Windows) or [Step 5b](#step-5b) (Linux) to confirm the firewall now allows the connection. 

Retry the Azure Bastion connection.

## Resolution E

The VM agent (`waagent` on Linux, `WindowsAzureGuestAgent` on Windows) is unhealthy or unresponsive. Without a healthy agent, Azure can't perform run-commands on the VM and some Azure Bastion connectivity scenarios might be impacted.

Run the following commands in Azure CLI.

1. Restart the VM to attempt agent recovery.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm restart \
  --name "$VM_NAME" \
  --resource-group "$VM_RG" \
  --subscription "$SUBSCRIPTION"
```

2. Wait 2–3 minutes, and then re-run [Step 2](#step-2). If `agentStatus` shows `Ready`, go to [Step 3](#step-3) to continue diagnostics.

If the agent remains unhealthy after restart, see [Troubleshoot Azure Windows VM Agent issues](../virtual-machines/windows/windows-azure-guest-agent.md) for manual agent repair steps.

## Resolution F

NLA is enabled on the Windows VM and is rejecting the Azure Bastion connection. Azure Bastion Standard SKU supports NLA, but mismatched Credential Security Support Provider (CredSSP) or transport layer security (TLS) settings can cause NLA handshake failures that appear as immediate session disconnects.

Run the following commands in Azure CLI.

1. Temporarily disable NLA to test if it's the cause.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID:    " SUBSCRIPTION
[ -z "$VM_RG" ] && read -rp "VM Resource Group:  " VM_RG
[ -z "$VM_NAME" ] && read -rp "VM Name:            " VM_NAME

az vm run-command invoke \
  --resource-group "$VM_RG" \
  --name "$VM_NAME" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunPowerShellScript \
  --scripts \
    'Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" -Name UserAuthentication -Value 0' \
    '$nla = (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp").UserAuthentication' \
    'Write-Output "NLA disabled. UserAuthentication is now: $nla"' \
  --query "value[0].message" \
  --output tsv
```

2. Retry the Azure Bastion connection. If it now succeeds, NLA was the issue.

To re-enable NLA after confirming connectivity, investigate CredSSP and TLS settings on the VM, or verify the Azure Bastion SKU is Standard (which has broader NLA compatibility). For more information, see [Azure Bastion and NLA](/azure/bastion/bastion-nsg#nla).

## References

- [Azure Bastion FAQ](/azure/bastion/bastion-faq)
- [Troubleshoot Azure Bastion](/azure/bastion/troubleshoot)
- [NSG access and Azure Bastion](/azure/bastion/bastion-nsg)
- [Troubleshoot Azure Windows VM Agent issues](../virtual-machines/windows/windows-azure-guest-agent.md)
- [Reset VM credentials using the Azure CLI](/cli/azure/vm/user)
- [Troubleshoot a Windows VM by attaching the OS disk to a recovery VM](/azure/virtual-machines/troubleshooting/troubleshoot-recovery-disks-windows)
- [Troubleshoot a Linux VM by attaching the OS disk to a recovery VM](/azure/virtual-machines/troubleshooting/troubleshoot-recovery-disks-linux)
