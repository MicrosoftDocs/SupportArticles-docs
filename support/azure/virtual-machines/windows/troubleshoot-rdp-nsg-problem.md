---
title: Troubleshoot RDP blocked by NSG rules on Azure VMs
description: Learn how to troubleshoot Remote Desktop Protocol (RDP) connectivity issues caused by network security group (NSG) misconfigurations on Azure Windows VMs, including rule priority conflicts and subnet vs. NIC-level NSG interactions.
services: virtual-machines
documentationCenter: ''
author: asudbring
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.tgt_pltfrm: vm-windows
ms.workload: infrastructure
ms.date: 03/17/2026
ms.author: allensu
ms.custom: sap:Cannot connect to my VM
---
# Troubleshoot RDP blocked by NSG rules on Azure Windows VMs

**Applies to:** :heavy_check_mark: Windows VMs

This article explains how to troubleshoot Remote Desktop Protocol (RDP) connectivity problems caused by network security group (NSG) misconfigurations on Azure Windows virtual machines (VMs). Common causes include missing allow rules, rule priority conflicts, and conflicting rules between subnet-level and NIC-level NSGs.

## Symptoms

You experience one or more of the following symptoms when connecting to an Azure Windows VM through RDP:

- RDP connection times out or is refused.
- You receive "Remote Desktop can't connect to the remote computer" errors.
- RDP works from one source IP but not another.
- RDP stops working after NSG rule changes.
- A new VM is unreachable through RDP immediately after deployment.

## Prerequisites

- Access to the [Azure portal](https://portal.azure.com) with at least **Network Contributor** role on the affected resource group.
- [Azure CLI](/cli/azure/install-azure-cli) or [Azure PowerShell](/powershell/azure/install-azure-powershell) installed for command-line troubleshooting.
- The VM must be in a **Running** state.

## How NSG rule evaluation works

Before troubleshooting, understand how Azure evaluates NSG rules:

- **Azure evaluates rules by priority.** Azure processes rules in priority order, with the lowest number representing the highest priority. Evaluation stops when Azure finds a matching rule.
- **Azure evaluates inbound and outbound rules separately.** RDP connectivity requires an inbound allow rule on port 3389.
- **You can apply NSGs at the subnet level and the network interface (NIC) level.** When NSGs exist at both levels, inbound traffic must be allowed by **both** NSGs to reach the VM.
- **Every NSG contains default rules that you can't delete.** The default `DenyAllInBound` rule (priority 65500) blocks all inbound traffic that isn't matched by a higher-priority rule.

For more information, see [How network security groups filter network traffic](/azure/virtual-network/network-security-groups-overview#how-network-security-groups-filter-network-traffic).

## Identify the blocking NSG rule

### Use Network Watcher IP flow verify

IP flow verify is the fastest way to determine which NSG rule blocks RDP traffic.

1. In the Azure portal, search for and select **Network Watcher**.
2. Under **Network diagnostic tools**, select **IP flow verify**.
3. Configure the test:
    - **Virtual machine**: Select the affected VM.
    - **Network interface**: Select the VM's primary NIC.
    - **Protocol**: TCP
    - **Direction**: Inbound
    - **Local port**: 3389
    - **Local IP address**: The VM's private IP.
    - **Remote IP address**: The IP address you're connecting from.
    - **Remote port**: Any available port (for example, 60000).
4. Select **Check**.

The result shows whether traffic is **Allowed** or **Denied**, and the name of the NSG rule responsible.

You can also run IP flow verify with Azure CLI:

```azurecli
az network watcher test-ip-flow \
    --resource-group myResourceGroup \
    --vm myVM \
    --direction Inbound \
    --protocol TCP \
    --local 10.0.0.4:3389 \
    --remote 203.0.113.50:60000
```

Or with Azure PowerShell:

```azurepowershell
Test-AzNetworkWatcherIPFlow `
    -NetworkWatcher $networkWatcher `
    -TargetVirtualMachineId $vm.Id `
    -Direction Inbound `
    -Protocol TCP `
    -LocalIPAddress 10.0.0.4 `
    -LocalPort 3389 `
    -RemoteIPAddress 203.0.113.50 `
    -RemotePort 60000
```

### View effective security rules

View the effective (combined) security rules applied to the VM's network interface to see how subnet-level and NIC-level NSG rules merge:

1. In the Azure portal, go to **Virtual Machines** and select your VM.
2. Expand **Networking** and select **Network settings**.
3. Select the network interface name.
4. Under **Help**, select **Effective security rules**.

Look for rules that affect port 3389 TCP inbound. Verify that an **Allow** rule exists with a higher priority (lower number) than any **Deny** rule that matches the same traffic.

Use Azure CLI:

```azurecli
az network nic list-effective-nsg \
    --resource-group myResourceGroup \
    --name myVMNic
```

Use Azure PowerShell:

```azurepowershell
Get-AzEffectiveNetworkSecurityGroup `
    -NetworkInterfaceName myVMNic `
    -ResourceGroupName myResourceGroup
```

## Common NSG misconfigurations

### RDP port 3389 not allowed in NSG

When you create a new VM, the default setting blocks all inbound traffic from the Internet unless you select to open RDP during deployment.

To add a rule to allow RDP:

1. In the Azure portal, go to **Virtual Machines** and select the VM.
2. Expand **Networking** and select **Network settings**.
3. Select **Create port rule** > **Inbound port rule**.
4. Configure the rule:

    | Setting | Value |
    |---|---|
    | **Source** | Your IP address or range |
    | **Source port ranges** | * |
    | **Destination** | Any |
    | **Destination port ranges** | 3389 |
    | **Protocol** | TCP |
    | **Action** | Allow |
    | **Priority** | 300 (or another value lower than any conflicting deny rule) |
    | **Name** | Allow-RDP |

5. Select **Add**.

### Rule priority conflict

A higher-priority deny rule blocks RDP even when an allow rule exists. For example:

| Priority | Name | Port | Action | Result |
|----------|------|------|--------|--------|
| 100 | DenyAll | * | Deny | **Blocks all traffic, including RDP** |
| 200 | AllowRDP | 3389 | Allow | Never evaluated (blocked by priority 100) |

**Resolution**: Change the priority of the allow rule to a value lower than the deny rule, or narrow the deny rule to exclude port 3389.

### Subnet-level and NIC-level NSG conflict

When you apply NSGs at both levels, traffic must pass through both. A common misconfiguration is:

- **Subnet NSG**: Allows RDP (port 3389).
- **NIC NSG**: Has no allow rule for port 3389 (default `DenyAllInBound` blocks it).

Or the reverse:

- **NIC NSG**: Allows RDP (port 3389).
- **Subnet NSG**: Has a deny rule blocking port 3389.

**Resolution**: Ensure an allow rule for port 3389 TCP exists in **both** NSGs. Verify by using the [effective security rules](#view-effective-security-rules) to see the combined result.

### Source IP address restriction

If the allow rule specifies a source IP address or range, RDP connections from IP addresses outside that range are blocked.

**Resolution**: Verify that the source IP address of your RDP client is included in the rule's source. Use a service like [checkip.azure.com](https://checkip.azure.com) to confirm your public IP.

### Service tag misconfiguration

Service tags represent groups of IP address prefixes. Using the wrong service tag can inadvertently block or allow traffic:

- **Internet**: All public IP addresses. Allows RDP from any internet source.
- **VirtualNetwork**: Addresses within the virtual network, peered virtual networks, and VPN-connected networks. Doesn't include public internet IPs.
- **AzureLoadBalancer**: Azure infrastructure health probes. Doesn't include user RDP traffic.

**Resolution**: If you intend to allow RDP from the internet, use the **Internet** service tag or a specific IP range as the source. Don't rely on **VirtualNetwork** for internet-based RDP access.

For more information about service tags, see [Virtual network service tags](/azure/virtual-network/service-tags-overview).

## Verify NSG rules with CLI and PowerShell

### List NSG rules applied to a NIC

```azurecli
az network nic show \
    --resource-group myResourceGroup \
    --name myVMNic \
    --query "networkSecurityGroup.id" \
    --output tsv
```

```azurecli
az network nsg rule list \
    --resource-group myResourceGroup \
    --nsg-name myNSG \
    --output table
```

### List NSG rules applied to a subnet

```azurecli
az network vnet subnet show \
    --resource-group myResourceGroup \
    --vnet-name myVNet \
    --name mySubnet \
    --query "networkSecurityGroup.id" \
    --output tsv
```

### Add an RDP allow rule using CLI

```azurecli
az network nsg rule create \
    --resource-group myResourceGroup \
    --nsg-name myNSG \
    --name AllowRDP \
    --priority 300 \
    --direction Inbound \
    --access Allow \
    --protocol Tcp \
    --destination-port-ranges 3389 \
    --source-address-prefixes 203.0.113.50 \
    --description "Allow RDP from specific IP"
```

### Add an RDP allow rule using PowerShell

```azurepowershell
$nsg = Get-AzNetworkSecurityGroup `
    -ResourceGroupName myResourceGroup `
    -Name myNSG

$nsg | Add-AzNetworkSecurityRuleConfig `
    -Name AllowRDP `
    -Priority 300 `
    -Direction Inbound `
    -Access Allow `
    -Protocol Tcp `
    -DestinationPortRange 3389 `
    -SourceAddressPrefix 203.0.113.50 `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -Description "Allow RDP from specific IP"

$nsg | Set-AzNetworkSecurityGroup
```

## Secure RDP access for production environments

> [!IMPORTANT]
> Exposing RDP port 3389 directly to the internet is a security risk and isn't recommended for production environments.

Use one of the following alternatives for secure remote access:

| Method | Description |
|--------|-------------|
| [Azure Bastion](/azure/bastion/bastion-overview) | Provides secure RDP/SSH access through the Azure portal over TLS. No public IP required on the VM. |
| [Just-in-time (JIT) VM access](/azure/defender-for-cloud/enable-just-in-time-access) | Opens RDP port only when needed and for a limited time. Requires Microsoft Defender for Cloud. |
| [VPN gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways) | Connects through a site-to-site or point-to-site VPN tunnel. RDP traffic stays on a private connection. |
| [Azure Private Link](/azure/private-link/private-link-overview) | Access VMs through private endpoints without exposing them to the public internet. |

## Related content

- [Diagnose a VM network traffic filter problem](/troubleshoot/azure/virtual-network/diagnose-network-traffic-filter-problem)
- [Troubleshoot connectivity problems between Azure VMs](/troubleshoot/azure/virtual-network/virtual-network-troubleshoot-connectivity-problem-between-vms)
- [Network security groups overview](/azure/virtual-network/network-security-groups-overview)
- [Troubleshoot an RDP general error in Azure VM](./troubleshoot-rdp-general-error.md)

