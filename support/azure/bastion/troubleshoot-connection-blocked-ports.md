---
title: Troubleshoot Azure Bastion connection failures 
description: Resolve Azure Bastion connection failures from blocked NSG, firewall, and VM port rules on 443, 22, 3389, 8080, and 5701—follow these steps now.
ms.service: azure-bastion
ms.topic: troubleshooting
ms.custom: Connectivity
ms.author: kaushika
ms.reviewer: chadmat
ms.date: 07/13/2026
author: ryanberg-aquent
ai.hint.symptom-tags:
  - bastion-connection-failed
  - nsg-blocked-port
  - rdp-blocked
  - ssh-blocked
  - port-443-blocked
  - port-3389-blocked
  - port-22-blocked
  - bastion-subnet-nsg
  - custom-port-connection
  - proxy-tls-inspection
ai.hint.scope: resource-level
ai.hint.required-permissions:
  - Microsoft.Network/bastionHosts/read
  - Microsoft.Network/virtualNetworks/subnets/read
  - Microsoft.Network/networkSecurityGroups/read
  - Microsoft.Network/networkSecurityGroups/securityRules/read
  - Microsoft.Network/networkSecurityGroups/securityRules/write
  - Microsoft.Network/networkInterfaces/read
ai.hint.context-required:
  - SUBSCRIPTION_ID
  - RESOURCE_GROUP
  - RESOURCE_NAME
  - VM_NAME
---

# Troubleshoot Azure Bastion connection failures caused by blocked ports

## Summary

This article provides step-by-step diagnostics to resolve Azure Bastion connection failures caused by missing or blocking NSG, firewall, or target-VM port rules on 443, 22, 3389, 8080, or 5701. It also covers custom connection ports and corporate perimeter devices that block the browser's HTTPS (443) path to Bastion.

Azure Bastion connection failures most often trace back to a port that a network security group (NSG), Azure Firewall, or guest-OS firewall is blocking somewhere along the session path. The most common reasons are: 

- The `AzureBastionSubnet` NSG is missing one or more required inbound or outbound rules (like 443, 8080, 5701, or for outbound, 22 or 3389). 
- The target virtual machine (VM) subnet or guest firewall blocks Remote Desktop Protocol (RDP) (3389) or Secure Shell (SSH) (22) from the Azure Bastion subnet. 
- A custom connection port was configured on the VM but not opened on the NSG. 
- A corporate perimeter device blocks the browser's HTTPS (443) path to Azure Bastion. 

If either `AzureBastionSubnet` or the target VM subnet omits a required rule, Azure Bastion looks unhealthy even when the VM itself is fine.

## Symptoms

You might experience one or more of the following items:

- The Azure Bastion connection in the portal stops responding at `Connecting...` and then fails.
- Error: `Failed to connect to the VM. Please try again or check the documentation.`
- Error: `Your session has ended. Bastion will try to reconnect...` followed by repeated reconnect loops.
- RDP or SSH sessions never establish, but the VM shows as running and healthy in the [Azure portal](https://portal.azure.com).
- The Azure Bastion session window is blank or returns a generic `connection error`.
- Connections succeed for some VMs but fail for VMs in a specific subnet.
- Connections fail only when a non-default (custom) RDP or SSH port is specified.

> [!NOTE]
> These symptoms are identical to those caused by routing issues like user-defined routes (UDRs), forced tunneling, or Azure Route Server default-route injection. If this article's diagnostics all pass without finding a cause, see [Troubleshoot Azure Bastion connection failures caused by routing and forced tunneling](troubleshoot-connection-fails-routing-forced-tunneling.md).

## Prerequisites

To troubleshoot this problem, you need the following items:

- **Permissions required:** `Reader` permissions on the Azure Bastion host and target VM for diagnostics, and `Network Contributor` permissions on the affected NSGs to apply fixes (`Microsoft.Network/networkSecurityGroups/securityRules/write`).
- **Tools:** Azure CLI 2.x or an AI agent with Azure MCP or CLI access. The `bastion` command-line interface (CLI) extension is installed automatically on first use.
- **Required variables and examples of those variables, as shown in the following table:**

| Variable | Description | Example |
|---|---|---|
| `{SUBSCRIPTION_ID}` | Azure subscription ID | `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx` |
| `{RESOURCE_GROUP}` | Resource group containing the Azure Bastion host | `myResourceGroup` |
| `{RESOURCE_NAME}` | Azure Bastion host resource name | `myBastion` |
| `{VM_NAME}` | Target VM you are trying to connect to | `myVM` |

> [!TIP]
> Each script that's provided in the following sections prompts you for the required values interactively. To open Cloud Shell and answer the prompts, select **Try It**. The values are cached for that session. Therefore, you enter them only one time.

## Diagnostic steps

> [!NOTE]
> These steps are strictly for discovery ("read-only"). They don't make changes to your environment.

### Step 1

Check whether the Azure Bastion host is provisioned successfully and locate the `AzureBastionSubnet` and its address range to use in later network rule verification steps.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME

az network bastion show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{provisioningState:provisioningState, sku:sku.name, dnsName:dnsName, bastionSubnetId:ipConfigurations[0].subnet.id}" \
  --output json
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `provisioningState: "Succeeded"`. | The Azure Bastion host is healthy. The failure is in the network path. | Perform [Step 2](#step-2). |
| `provisioningState: "Failed"` or `"Updating"`. | The Azure Bastion host has a deployment-level problem, not a port problem. | This guidance doesn't cover deployment failures. See [Troubleshoot Azure Bastion host deployment failures](troubleshoot-host-deployment-failures.md) for more details. Return to this article if the connections still fail. |
| `sku` is `Basic` and you intend to use a custom port or native client. | Custom-port and native-client connections require the `Standard` Azure Bastion SKU. | Perform [Resolution C](#resolution-c). |
| `ResourceNotFound` error. | Subscription, resource group, or Azure Bastion name is incorrect. | Verify your variables and re-run. |

Record the `bastionSubnetId` value as you need it for the next command.

Resolve the Azure Bastion subnet range.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$BASTION_SUBNET_ID" ] && read -rp "Bastion Subnet ID (from above): " BASTION_SUBNET_ID

az network vnet subnet show \
  --ids "$BASTION_SUBNET_ID" \
  --query "{prefix:addressPrefix, prefixes:addressPrefixes, nsg:networkSecurityGroup.id}" \
  --output json
```

Record the address prefix (the `AzureBastionSubnet` classless internet domain routing (CIDR)). Name it `$BASTION_SUBNET_CIDR` and record the NSG ID attached to the Azure Bastion subnet (if any).

| If you see... | Meaning | Next steps |
|---|---|---|
| `nsg` is `null`. | No NSG is attached to `AzureBastionSubnet`. Its rules aren't the cause. | Perform [Step 3](#step-3). |
| `nsg` references an NSG. | An NSG is attached and might be missing or blocking a required rule. | Perform [Step 2](#step-2). |

### Step 2

Check whether the NSG attached to `AzureBastionSubnet` contains every rule Azure Bastion requires. A missing inbound port 443 (from `Internet` or `GatewayManager`), missing internal ports 8080 or 5701, or missing outbound ports 22, 3389, 443, or 80 breaks connections even when the VM is healthy.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$BASTION_NSG" ] && read -rp "Bastion Subnet NSG Name (from Step 1): " BASTION_NSG

az network nsg rule list \
  --nsg-name "$BASTION_NSG" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --include-default \
  --query "sort_by([].{Priority:priority, Name:name, Direction:direction, Access:access, Proto:protocol, SourcePort:sourcePortRange, DestPort:destinationPortRange, DestPorts:destinationPortRanges, Source:sourceAddressPrefix, Dest:destinationAddressPrefix}, &Priority)" \
  --output json
```

### Interpret the results

Compare the returned rules against the required `AzureBastionSubnet` rule set in the following table:

| Required rule | Direction | Source-to-Destination | Ports |
|---|---|---|---|
| Allow HTTPS from clients | Inbound | `Internet`-to-`AzureBastionSubnet` | 443 |
| Allow control plane | Inbound | `GatewayManager`-to-`AzureBastionSubnet` | 443 |
| Allow health probes | Inbound | `AzureLoadBalancer`-to-`AzureBastionSubnet` | 443 |
| Allow data-plane comms | Inbound | `VirtualNetwork`-to-`VirtualNetwork` | 8080, 5701 |
| Allow RDP or SSH to VMs | Outbound | `*`-to-`VirtualNetwork` | 3389, 22 |
| Allow data-plane comms | Outbound | `VirtualNetwork`-to-`VirtualNetwork` | 8080, 5701 |
| Allow Azure dependencies | Outbound | `*`-to-`AzureCloud` | 443 |
| Allow session or diagnostics | Outbound | `*`-to-`Internet` | 80 |

| If you see... | Meaning | Next steps |
|---|---|---|
| Any required rule above is missing, or a `Deny` rule with lower priority shadows it. | The Azure Bastion subnet NSG is incomplete or has a blocking rule. | Perform [Resolution A](#resolution-a). |
| A `Deny` rule on 443 inbound, or on 8080 or 5701 inbound or outbound. | The data plane or control plane is blocked. | Perform [Resolution A](#resolution-a). |
| All required rules are present and no `Deny` rule shadows them. | The Azure Bastion subnet NSG is correct. | Perform [Step 3](#step-3). |

### Step 3

Check whether the target VM's subnet allows inbound RDP (3389) or SSH (22) from the Azure Bastion subnet. Azure Bastion connects to the VM from the `AzureBastionSubnet` range, so the VM subnet NSG must permit that source on the connection port.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Target VM Name:  " VM_NAME

# Resolve the VM's NIC, its subnet, and the NSG protecting that subnet
NIC_ID=$(az vm show \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "networkProfile.networkInterfaces[0].id" \
  --output tsv)

SUBNET_ID=$(az network nic show \
  --ids "$NIC_ID" \
  --query "ipConfigurations[0].subnet.id" \
  --output tsv)

echo "VM subnet: $SUBNET_ID"

az network vnet subnet show \
  --ids "$SUBNET_ID" \
  --query "{subnetNsg:networkSecurityGroup.id}" \
  --output json
```

Check whether an NSG is applied directly to the VM's network interface card (NIC):

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$NIC_ID" ] && read -rp "VM NIC ID (from above): " NIC_ID

az network nic show \
  --ids "$NIC_ID" \
  --query "{nicNsg:networkSecurityGroup.id}" \
  --output json
```

### Interpret the results

Record the effective NSG name (subnet NSG, NIC NSG, or both. Name it `$VM_NSG`) and then list its rules:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NSG" ] && read -rp "VM NSG Name:     " VM_NSG

az network nsg rule list \
  --nsg-name "$VM_NSG" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --include-default \
  --query "sort_by([].{Priority:priority, Name:name, Direction:direction, Access:access, DestPort:destinationPortRange, DestPorts:destinationPortRanges, Source:sourceAddressPrefix}, &Priority)" \
  --output json
```

| If you see... | Meaning | Next steps |
|---|---|---|
| No inbound `Allow` for 3389 (Windows) or 22 (Linux) from the Azure Bastion subnet CIDR or `VirtualNetwork` and a `Deny` rule blocks it. | The VM subnet or NIC NSG blocks the connection port from Azure Bastion. | Perform [Resolution B](#resolution-b). |
| Inbound 3389 or 22 from `VirtualNetwork` is allowed but you connect on a non-default port (for example, 50000). | The connection uses a custom port that isn't opened. | Perform [Step 4](#step-4). |
| Inbound 3389 (Windows) or 22 (Linux) from the Azure Bastion subnet or `VirtualNetwork` is allowed and not shadowed by a `Deny` rule. | The VM subnet NSG permits Azure Bastion on the default port. | Perform [Step 4](#step-4). |

### Step 4

Check whether the connection uses a custom (non-default) port. Standard SKU Azure Bastion can connect to a VM on a port other than 3389 (Windows) or 22 (Linux), but that exact port must be open on the VM subnet NSG and listening inside the guest OS.

Run the following commands in Azure CLI:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$CONNECT_PORT" ] && read -rp "Port you connect on (default 3389 Windows / 22 Linux): " CONNECT_PORT
CONNECT_PORT=${CONNECT_PORT:-3389}
echo "Checking connectivity on port $CONNECT_PORT"
```

Confirm the guest OS is actually listening on that port. Run an in-guest port check through Run Command (read-only inside the guest):

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Target VM Name:  " VM_NAME
[ -z "$CONNECT_PORT" ] && read -rp "Port to check:   " CONNECT_PORT

# Linux guest: confirm the port is listening
az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "ss -tlnp | grep \":$CONNECT_PORT \" || echo NOT_LISTENING" \
  --output json
```

> For a Windows guest, use `--command-id RunPowerShellScript` and the script `Get-NetTCPConnection -State Listen -LocalPort $CONNECT_PORT -ErrorAction SilentlyContinue | Format-Table; if (-not (Get-NetTCPConnection -State Listen -LocalPort $CONNECT_PORT -ErrorAction SilentlyContinue)) { 'NOT_LISTENING' }`.

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `CONNECT_PORT` is `3389` or `22` and the port is listening. | The default port is in use and the guest is listening. The block is the network path. | Perform [Step 5](#step-5). |
| `CONNECT_PORT` is a custom port and the VM subnet NSG doesn't allow it from the Azure Bastion subnet. | The custom port is blocked at the NSG. | Perform [Resolution C](#resolution-c). |
| Output contains `NOT_LISTENING`. | The guest OS isn't listening on the expected port (guest firewall or service down). | Perform [Resolution C](#resolution-c). |
| The default port, listening, and VM subnet NSG allows the port. | The Azure-side path is clear. The issue is on the client or perimeter side. | Perform [Step 5](#step-5). |

### Step 5

Check whether a corporate proxy, firewall, or Transport Layer Security (TLS)-inspection device blocks the browser's HTTPS (443) path to the Azure Bastion endpoint. Run this check only when every Azure-side rule in [Step 2](#step-2)-[Step 4](#step-4) is correct but connections still fail.

Run the following commands in Azure CLI or Azure PowerShell.

Because this check is a client-side reachability probe, run these commands from the workstation where the failing browser session originates and not from Cloud Shell.

**Bash (run on the client workstation)**

```bash
# ── Collect inputs (cached if already set in this session) ──
[ -z "$BASTION_DNS" ] && read -rp "Bastion dnsName (from Step 1): " BASTION_DNS

# Confirm the TLS handshake to the Bastion endpoint completes on 443
openssl s_client -connect "${BASTION_DNS}:443" -servername "$BASTION_DNS" </dev/null 2>/dev/null \
  | openssl x509 -noout -issuer -subject 2>/dev/null \
  || echo "TLS_HANDSHAKE_FAILED"
```

**Azure PowerShell (run on the client workstation)**

```powershell
# ── Collect inputs (cached if already set in this session) ──
if (-not $env:BASTION_DNS) { $env:BASTION_DNS = Read-Host "Bastion dnsName (from Step 1)" }

$tcpClient = $null
$sslStream = $null

try {
  $tcpClient = [System.Net.Sockets.TcpClient]::new()
  $tcpClient.Connect($env:BASTION_DNS, 443)

  $sslStream = [System.Net.Security.SslStream]::new(
    $tcpClient.GetStream(),
    $false,
    { param($sender, $certificate, $chain, $sslPolicyErrors) $true }
  )
  $sslStream.AuthenticateAsClient($env:BASTION_DNS)

  $certificate = [System.Security.Cryptography.X509Certificates.X509Certificate2]::new($sslStream.RemoteCertificate)
  "issuer=$($certificate.Issuer)"
  "subject=$($certificate.Subject)"
}
catch {
  "TLS_HANDSHAKE_FAILED"
}
finally {
  if ($sslStream) { $sslStream.Dispose() }
  if ($tcpClient) { $tcpClient.Dispose() }
}
```

### Interpret the results

| If you see... | Meaning | Next steps |
|---|---|---|
| `issuer=` shows a Microsoft or Azure Certificate Authority (CA) and the subject matches the Azure Bastion endpoint. | The 443 port path is clean. Recheck the browser session or try a clean profile. | Perform [Resolution D](#resolution-d). |
| `issuer=` shows a corporate or internal CA. | A TLS-inspection proxy is intercepting the Azure Bastion session. | Perform [Resolution D](#resolution-d). |
| `TLS_HANDSHAKE_FAILED` or a connection timeout. | A perimeter firewall or proxy blocks outbound port 443 to the Azure Bastion endpoint. | Perform [Resolution D](#resolution-d). |

## Decision map

Use the following decision map table to determine the appropriate next steps based on your diagnostic results.

| Diagnostic result | Next actions |
|---|---|
| `AzureBastionSubnet` NSG is missing a required rule or a `Deny` rule shadows one. | Perform [Resolution A](#resolution-a). |
| Azure Bastion data plane is blocked (8080 or 5701 inbound or outbound denied). | Perform [Resolution A](#resolution-a). |
| VM subnet or NIC NSG blocks 3389 or 22 from the Azure Bastion subnet. | Perform [Resolution B](#resolution-b). |
| Custom connection port isn't opened on NSG or the guest isn't listening. | Perform [Resolution C](#resolution-c). |
| Azure-side rules are both correct but the client 443 path is blocked or TLS-intercepted. | Perform [Resolution D](#resolution-d). |

## Resolution A

The NSG attached to `AzureBastionSubnet` is missing one or more required rules, or a `Deny` rule with a lower priority shadows them. Azure Bastion requires a specific inbound and outbound rule set. If any of these rules is absent, the host can't accept client sessions or reach target VMs.

Run the following commands in Azure CLI. 

1. Capture the current rule set so you have a record before changing anything.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$BASTION_NSG" ] && read -rp "Bastion Subnet NSG Name: " BASTION_NSG

az network nsg rule list \
  --nsg-name "$BASTION_NSG" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --output table
```

Identify which of the eight required rules from [Step 2](#step-2) are missing or shadowed. Create only the rules you are missing in the next step.

2. Create the required inbound rules.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. Review them to better understand what each command does. These commands add rules to your Azure Bastion subnet NSG.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$BASTION_NSG" ] && read -rp "Bastion Subnet NSG Name:  " BASTION_NSG
[ -z "$BASTION_SUBNET_CIDR" ] && read -rp "AzureBastionSubnet CIDR (from Step 1): " BASTION_SUBNET_CIDR

# Inbound: HTTPS from public clients
az network nsg rule create \
  --nsg-name "$BASTION_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowHttpsInbound --priority 120 --direction Inbound --access Allow --protocol Tcp \
  --source-address-prefixes Internet --source-port-ranges '*' \
  --destination-address-prefixes "$BASTION_SUBNET_CIDR" --destination-port-ranges 443

# Inbound: Bastion control plane
az network nsg rule create \
  --nsg-name "$BASTION_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowGatewayManagerInbound --priority 130 --direction Inbound --access Allow --protocol Tcp \
  --source-address-prefixes GatewayManager --source-port-ranges '*' \
  --destination-address-prefixes "$BASTION_SUBNET_CIDR" --destination-port-ranges 443

# Inbound: Azure Load Balancer health probes
az network nsg rule create \
  --nsg-name "$BASTION_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowAzureLoadBalancerInbound --priority 140 --direction Inbound --access Allow --protocol Tcp \
  --source-address-prefixes AzureLoadBalancer --source-port-ranges '*' \
  --destination-address-prefixes "$BASTION_SUBNET_CIDR" --destination-port-ranges 443

# Inbound: Bastion data-plane host communication
az network nsg rule create \
  --nsg-name "$BASTION_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowBastionHostCommunication --priority 150 --direction Inbound --access Allow --protocol '*' \
  --source-address-prefixes VirtualNetwork --source-port-ranges '*' \
  --destination-address-prefixes VirtualNetwork --destination-port-ranges 8080 5701
```

Create the required outbound rules.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$BASTION_NSG" ] && read -rp "Bastion Subnet NSG Name: " BASTION_NSG

# Outbound: SSH and RDP to target VMs
az network nsg rule create \
  --nsg-name "$BASTION_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowSshRdpOutbound --priority 100 --direction Outbound --access Allow --protocol '*' \
  --source-address-prefixes '*' --source-port-ranges '*' \
  --destination-address-prefixes VirtualNetwork --destination-port-ranges 22 3389

# Outbound: Azure control-plane dependencies
az network nsg rule create \
  --nsg-name "$BASTION_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowAzureCloudOutbound --priority 110 --direction Outbound --access Allow --protocol Tcp \
  --source-address-prefixes '*' --source-port-ranges '*' \
  --destination-address-prefixes AzureCloud --destination-port-ranges 443

# Outbound: Bastion data-plane host communication
az network nsg rule create \
  --nsg-name "$BASTION_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowBastionCommunicationOutbound --priority 120 --direction Outbound --access Allow --protocol '*' \
  --source-address-prefixes VirtualNetwork --source-port-ranges '*' \
  --destination-address-prefixes VirtualNetwork --destination-port-ranges 8080 5701

# Outbound: session and certificate-validation traffic
az network nsg rule create \
  --nsg-name "$BASTION_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowHttpOutbound --priority 130 --direction Outbound --access Allow --protocol '*' \
  --source-address-prefixes '*' --source-port-ranges '*' \
  --destination-address-prefixes Internet --destination-port-ranges 80
```

If a misconfigured `Deny` rule was shadowing these rules, delete it:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$BASTION_NSG" ] && read -rp "Bastion Subnet NSG Name: " BASTION_NSG
[ -z "$DENY_RULE_NAME" ] && read -rp "Deny rule to remove (from A.1): " DENY_RULE_NAME

az network nsg rule delete \
  --nsg-name "$BASTION_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name "$DENY_RULE_NAME"
```

3. Re-run [Step 2](#step-2). All eight required rules should now be present with no `Deny` rule shadowing them. 

Retry the Azure Bastion connection. If the connection still fails, go to [Resolution B](#resolution-b).

## Resolution B

The target VM's subnet NSG or NIC NSG blocks the inbound RDP port (3389) or SSH port (22) from the Azure Bastion subnet. Azure Bastion initiates the session from the `AzureBastionSubnet` range, so the VM-side NSG must allow that source on the connection port.

Run the following commands in Azure CLI.

1. Confirm which port the VM expects: 3389 for Windows (RDP), 22 for Linux (SSH).

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Target VM Name:  " VM_NAME

az vm show \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{osType:storageProfile.osDisk.osType}" \
  --output json
```

2. Add an inbound allow rule on the VM's NSG permitting the Azure Bastion subnet to reach the VM on the connection port. Use `VirtualNetwork` as the source if you prefer not to scope to the exact Azure Bastion CIDR.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NSG" ] && read -rp "VM NSG Name:     " VM_NSG
[ -z "$BASTION_SUBNET_CIDR" ] && read -rp "AzureBastionSubnet CIDR (from Step 1): " BASTION_SUBNET_CIDR
[ -z "$CONNECT_PORT" ] && read -rp "Connection port (3389 Windows / 22 Linux): " CONNECT_PORT
CONNECT_PORT=${CONNECT_PORT:-3389}

az network nsg rule create \
  --nsg-name "$VM_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowBastionToVm --priority 200 --direction Inbound --access Allow --protocol Tcp \
  --source-address-prefixes "$BASTION_SUBNET_CIDR" --source-port-ranges '*' \
  --destination-address-prefixes '*' --destination-port-ranges "$CONNECT_PORT"
```

3. Confirm the guest-OS firewall isn't dropping the session. Check the in-guest firewall state (read-only):

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Target VM Name:  " VM_NAME

# Linux guest: show the inbound SSH/firewall posture
az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "sudo iptables -L INPUT -n --line-numbers 2>/dev/null | head -n 20; echo '---'; sudo systemctl is-active ssh 2>/dev/null || sudo systemctl is-active sshd 2>/dev/null" \
  --output json
```

> For a Windows guest, use `--command-id RunPowerShellScript` with `Get-NetFirewallRule -Direction Inbound -Enabled True | Where-Object DisplayName -match 'Remote Desktop' | Format-Table DisplayName, Action, Enabled`.

If the guest firewall blocks the port, allow it inside the guest (Linux example):

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them. 

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Target VM Name:  " VM_NAME

az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "sudo systemctl enable --now ssh 2>/dev/null || sudo systemctl enable --now sshd" \
  --output json
```

4. Retry the Azure Bastion connection. If RDP or SSH still fails and you connect on a non-default port, go to [Resolution C](#resolution-c).

## Resolution C

You configured a custom (non-default) connection port for the VM, but the VM subnet NSG still only allows the default port, the guest OS isn't listening on the custom port, or the Azure Bastion SKU or connection flow doesn't specify the custom port. Custom-port connections require the Standard Azure Bastion SKU.

Run the following commands in Azure CLI.

1. Confirm the Bastion SKU supports custom ports:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME

az network bastion show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{sku:sku.name}" \
  --output json
```

**Interpret the results**

| If you see... | Meaning | Next steps |
|---|---|---|
| `sku: "Standard"` (or higher). | Custom ports are supported. Continue to the next step. | Perform the next step.|
| `sku: "Basic"`. | Custom ports and native-client connections aren't supported for Azure Bastion Basic. | Upgrade the Azure Bastion host to `Standard`, then continue to the next step. |

2. Open the actual custom port on the VM subnet NSG, sourced from the Azure Bastion subnet.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NSG" ] && read -rp "VM NSG Name:     " VM_NSG
[ -z "$BASTION_SUBNET_CIDR" ] && read -rp "AzureBastionSubnet CIDR (from Step 1): " BASTION_SUBNET_CIDR
[ -z "$CUSTOM_PORT" ] && read -rp "Custom port (e.g. 50000): " CUSTOM_PORT

az network nsg rule create \
  --nsg-name "$VM_NSG" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --name AllowBastionCustomPort --priority 210 --direction Inbound --access Allow --protocol Tcp \
  --source-address-prefixes "$BASTION_SUBNET_CIDR" --source-port-ranges '*' \
  --destination-address-prefixes '*' --destination-port-ranges "$CUSTOM_PORT"
```

3. Confirm the guest OS listens on the custom port and open it in the guest firewall (if needed):

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Target VM Name:  " VM_NAME
[ -z "$CUSTOM_PORT" ] && read -rp "Custom port:     " CUSTOM_PORT

az vm run-command invoke \
  --name "$VM_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "ss -tlnp | grep \":$CUSTOM_PORT \" || echo NOT_LISTENING" \
  --output json
```

If the output is `NOT_LISTENING`, configure the in-guest service (for example, SSH) to listen on the custom port and restart it before retrying. For a Linux guest using SSH, add the port with a drop-in and then restart.

> [!IMPORTANT]
> The following commands are all write operations that require your approval before you can run them.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$VM_NAME" ] && read -rp "Target VM Name:  " VM_NAME
[ -z "$CUSTOM_PORT" ] && read -rp "Custom port:     " CUSTOM_PORT

az vm run-command invoke \
  --name "$VM_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --command-id RunShellScript \
  --scripts "printf 'Port 22\nPort $CUSTOM_PORT\n' | sudo tee /etc/ssh/sshd_config.d/customport.conf; sudo systemctl restart ssh 2>/dev/null || sudo systemctl restart sshd" \
  --output json
```

4. Verify the connection to the custom port from Azure Bastion.

Reconnect and specify the custom port. With the native client, pass the port explicitly:

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME
[ -z "$VM_NAME" ] && read -rp "Target VM Name:  " VM_NAME
[ -z "$CUSTOM_PORT" ] && read -rp "Custom port:     " CUSTOM_PORT

TARGET_VM_ID=$(az vm show \
  --name "$VM_NAME" --resource-group "$RG" --subscription "$SUBSCRIPTION" \
  --query "id" --output tsv)

az network bastion ssh \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --target-resource-id "$TARGET_VM_ID" \
  --resource-port "$CUSTOM_PORT" \
  --auth-type AAD
```

`--auth-type` accepts `AAD`, `password`, or `ssh-key`. With `AAD` (Microsoft Entra ID) no `--username` is required, but the target VM must have Microsoft Entra login enabled (the `AADSSHLoginForLinux` or `AADLoginForWindows` extension). Otherwise, the tunnel connects but in-guest authentication fails with `Permission denied (publickey)`. For a VM without Microsoft Entra sign-in permissions, use `--auth-type ssh-key` (add `--username` and `--ssh-key <path>`) or `--auth-type password` (add `--username`). The native-client commands have the following prerequisites. 

> [!IMPORTANT]
> Don't run any commands for these prerequisites in Cloud Shell.

- **The Azure Bastion host must be Standard SKU (or higher)**.
- **Native Client support (tunneling) must be enabled on the Azure Bastion host**. Standard SKU alone isn't enough. Enable it once with `az network bastion update --name "$RESOURCE_NAME" --resource-group "$RG" --enable-tunneling true`. Without it, the command fails with `Bastion Host SKU must be Standard or Premium and Native Client must be enabled`.
- **Both the local Azure CLI `bastion` and `ssh` extensions must be installed**. This includes `az extension add -n bastion` and `az extension add -n ssh`. Without the `ssh` extension, `az network bastion ssh` fails with `ExtensionNotInstalledException: The extension ssh is not installed`.

In the portal connection flow, enter the same custom port in the **Port** field instead of accepting the default 3389 or 22 values.

## Resolution D

All Azure-side NSG and port rules are correct, but a corporate perimeter firewall, web proxy, or TLS-inspection appliance blocks or intercepts the browser's outbound HTTPS (443) session to the Azure Bastion endpoint.

Run the following commands in Azure CLI.

1. Confirm the Azure Bastion endpoint hostname.

```azurecli-interactive
# ── Collect inputs (cached if already set in this session) ──
[ -z "$SUBSCRIPTION" ] && read -rp "Subscription ID: " SUBSCRIPTION
[ -z "$RG" ] && read -rp "Resource Group:  " RG
[ -z "$RESOURCE_NAME" ] && read -rp "Bastion Name:    " RESOURCE_NAME

az network bastion show \
  --name "$RESOURCE_NAME" \
  --resource-group "$RG" \
  --subscription "$SUBSCRIPTION" \
  --query "{dnsName:dnsName}" \
  --output json
```

2. Allow the Azure Bastion session path through the corporate perimeter with the following configuration:

- Permit outbound TCP 443 from client workstations to the Azure Bastion `dnsName` and to the `AzureCloud` service tag for the Azure Bastion region.
- Exclude the Azure Bastion endpoint from TLS or Secure Socket Layer (SSL) inspection. Azure Bastion uses WebSocket tunneling over port 443, which inspection proxies frequently break.
- Confirm no proxy rewrites or strips of the `Upgrade: websocket` header.

3. Retest from a clean network path or browser profile using the following steps:

a. Connect from a workstation outside the corporate proxy (for example, a home network or hotspot) to isolate the perimeter as the cause.
b. Open the Azure Bastion session in a private or incognito browser window with browser extensions disabled to rule out client-side interference.

If the connection succeeds from a clean path but fails through the corporate network, the block is in the perimeter device and must be corrected by your network team. If it still fails from a clean path with all prior steps passing, routing might be the root cause. Try the guidance for [Troubleshoot Azure Bastion connection failures caused by routing or forced tunneling](troubleshoot-connection-fails-routing-forced-tunneling.md). If this fix doesn't resolve the problem, file an Azure support request.

## References

- [Troubleshoot Azure Bastion connection failures caused by routing or forced tunneling](troubleshoot-connection-fails-routing-forced-tunneling.md)
- [Azure Bastion NSG guidance](/azure/bastion/bastion-nsg)
- [Configure NSG rules for Azure Bastion](/azure/bastion/bastion-nsg)
- [Connect to a VM using a specified custom port](/azure/bastion/connect-vm-native-client-windows)
- [Azure Bastion FAQ](/azure/bastion/bastion-faq)
