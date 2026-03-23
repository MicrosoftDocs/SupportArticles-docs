---
title: Troubleshoot SSH connectivity blocked by network security group misconfiguration in Azure
description: "Diagnose and fix SSH connection failures caused by NSG misconfigurations on Azure Linux VMs. Follow step-by-step guidance to restore SSH access."
author: asudbring
ms.author: allensu
ms.service: azure-virtual-network
ms.date: 03/17/2026
ms.topic: troubleshooting
ms.custom: 
  - sap:Connectivity
  - sap:Creating and troubleshooting Network Security Groups
---

# Troubleshoot SSH connectivity blocked by network security group misconfiguration in Azure

**Applies to:** :heavy_check_mark: Linux VMs

## Summary

This article helps you diagnose and resolve Secure Shell (SSH) connection failures that are caused by network security group (NSG) misconfigurations when you try to connect to Azure Linux virtual machines (VMs).

## Symptoms

You experience one or more of the following symptoms when you connect to an Azure Linux VM over SSH:

- SSH connection times out when you connect to the VM's public or private IP address.

- SSH client returns `Connection refused` or `Connection timed out` error messages.

- You can ping the VM but can't establish an SSH session on port 22.

- SSH works from some source IP addresses but not others.

- SSH stops working after NSG rule changes are applied.

## How NSG rules affect SSH traffic

Evaluate NSG rules by priority within each direction (inbound and outbound). Lower priority numbers are evaluated first. When a rule matches the traffic, the evaluation stops. This evaluation process means that a deny rule that has a higher priority (lower number) blocks SSH traffic even if an allow rule exists at a lower priority (higher number).

When you apply NSGs at both the subnet and the network interface (NIC) levels, evaluation occurs as follows:

- **Inbound traffic**: Evaluate the subnet NSG first. If the subnet NSG allows the traffic, evaluate the NIC NSG.

- **Outbound traffic**: Evaluate the NIC NSG first. If the NIC NSG allows the traffic, evaluate the subnet NSG.

To reach the VM, both NSGs must allow SSH traffic. A denial at either level blocks the connection.

### Default NSG rules that affect SSH connectivity

Every NSG includes default rules. You can't delete default rules, but you can override them by using higher-priority rules. The following default rules affect SSH connectivity.

| Priority | Name | Direction | Action | Description |
|----------|------|-----------|--------|-------------|
| 65000 | AllowVNetInBound | Inbound | Allow | Allows all inbound traffic within the virtual network. |
| 65001 | AllowAzureLoadBalancerInBound | Inbound | Allow | Allows traffic from Azure Load Balancer. |
| 65500 | DenyAllInBound | Inbound | Deny | Denies all other inbound traffic. |
| 65000 | AllowVnetOutBound | Outbound | Allow | Allows all outbound traffic within the virtual network. |
| 65001 | AllowInternetOutBound | Outbound | Allow | Allows outbound traffic to the internet. |
| 65500 | DenyAllOutBound | Outbound | Deny | Denies all other outbound traffic. |

The `DenyAllInBound` rule at priority 65500 blocks all inbound SSH traffic from the internet unless a higher-priority allow rule exists.

## Common NSG misconfigurations that block SSH connections

### Missing allow rule for port 22

The most common cause of SSH failure is that no inbound rule allows traffic on TCP port 22. When you create a VM without selecting SSH as an allowed inbound port, the default `DenyAllInBound` rule blocks all SSH connections from outside the virtual network.

**Verify**: Check whether an inbound allow rule exists for TCP port 22.

### Deny rule has higher priority than allow rule

An NSG deny rule that has a lower priority number (higher priority) can override an existing SSH allow rule. For example:

| Priority | Name | Port | Action | Result |
|----------|------|------|--------|--------|
| 100 | DenyAll | * | Deny | Blocks all traffic, including SSH .|
| 200 | AllowSSH | 22 | Allow | Never evaluated - blocked by priority 100. |

**Verify**: To check for conflicting deny rules, review all rules that have a lower priority number than your SSH allow rule.

### Source IP address restriction

An NSG rule might allow SSH only from specific IP addresses. If your current IP address doesn't match the configured source, the connection is blocked.

**Common causes**

- The allow rule uses a specific IP address or range that doesn't include your current IP.

- Your public IP address changed (common for dynamic IP assignments from ISPs).

- The rule uses a service tag that doesn't include your source network.

**Verify**: Verify your current public IP address, and compare it to the source field in the NSG rule.

### Subnet-level and NIC-level NSG conflict

If you apply NSGs at both the subnet level and NIC (network adapter) level, both must allow the traffic. A common misconfiguration is an allow rule at one level and a missing or conflicting rule at the other level. For example:

- **Subnet NSG**: Allows TCP port 22 from any source.
- **NIC NSG**: Has no allow rule for port 22, so the `DenyAllInBound` default blocks SSH.

**Verify**: Check effective security rules to see the combined effect of both NSGs.

### Custom SSH port not accounted for

If the Linux VM's SSH daemon (`sshd`) listens on a nonstandard port (for example, 2222 instead of 22), the NSG rule must allow traffic on that custom port, not port 22.

**Verify**: Check the VM's `/etc/ssh/sshd_config` file for the `Port` directive and ensure the NSG allows traffic on that port.

## Diagnose NSG problems that block SSH connectivity

### Use IP flow verify in the Azure portal

The Azure Network Watcher feature, IP flow verify, tests whether traffic is allowed or denied to or from a VM. IP flow verify also reports which security rule caused the decision. To perform this task, follow these steps:

1. Go to the [Azure portal](https://portal.azure.com), and select **Network Watcher**.

2. Select **IP flow verify** under **Network diagnostic tools**.

3. Configure the test:
    - **Virtual machine**: Select the affected Linux VM.
    - **Direction**: Select **Inbound**.
    - **Protocol**: Select **TCP**.
    - **Local port**: Enter **22** (or the custom SSH port).
    - **Remote IP address**: Enter the IP address of the SSH client.
    - **Remote port**: Enter any value (for example, **60000**).
    - **Local IP address**: This value is the VM's private IP (auto-populated).

4. Select **Check**. The result shows **Access allowed** or **Access denied** and the name of the security rule.

### Use IP flow verify together with Azure CLI

Run the following command:

```azurecli
az network watcher test-ip-flow \
    --direction Inbound \
    --protocol TCP \
    --local 10.0.0.4:22 \
    --remote <source-ip>:60000 \
    --vm <vm-name> \
    --resource-group <resource-group> \
    --out table
```

### Use IP flow verify together with Azure PowerShell

Run the following command:

```azurepowershell
$vm = Get-AzVM -ResourceGroupName "<resource-group>" -Name "<vm-name>"

Test-AzNetworkWatcherIPFlow `
    -NetworkWatcherName "NetworkWatcher_<region>" `
    -ResourceGroupName "NetworkWatcherRG" `
    -Direction Inbound `
    -Protocol TCP `
    -LocalPort 22 `
    -RemotePort 60000 `
    -LocalIPAddress 10.0.0.4 `
    -RemoteIPAddress <source-ip> `
    -TargetVirtualMachineId $vm.Id
```

### View effective security rules

Effective security rules show the combined view of all NSG rules that are applied to a network interface. The view includes subnet-level and NIC-level NSGs that are combined by using default rules.

#### Azure portal

To use the Azure portal to view effective security rules, run the following command:

1. Go to the [Azure portal](https://portal.azure.com), and select **Virtual machines**.
2. Select the affected VM.
3. Select **Networking** > **Network settings**.
4. Select the network interface.
5. Select **Effective security rules**.
6. Look for rules that affect TCP port 22 traffic from your source IP.

#### Azure CLI

To use Azure CLI to view effective security rules, run the following command:

```azurecli
az network nic list-effective-nsg \
    --name <nic-name> \
    --resource-group <resource-group> \
    --output table
```

#### Azure PowerShell

To use Azure PowerShell to view effective security rules, run the following command:

```azurepowershell
Get-AzEffectiveNetworkSecurityGroup `
    -NetworkInterfaceName "<nic-name>" `
    -ResourceGroupName "<resource-group>"
```

### Use Connection Troubleshoot

The Network Watcher feature, connection troubleshoot, checks connectivity from the VM, and identifies the blocking component.

To do so:

1. Open **Network Watcher** in the Azure portal.
2. Select **Connection troubleshoot** under **Network diagnostic tools**.
3. Configure the test:
    - **Source**: Select the source VM or your connection point.
    - **Destination**: Enter the target VM's IP address.
    - **Destination port**: Enter **22**.
    - **Protocol**: Select **TCP**.
4. Select **Check**. The results show the connectivity status and any blocking NSG rules.

### Check flow logs

> [!IMPORTANT]
> NSG flow logs are scheduled to retire on September 30, 2027. You can't create new NSG flow logs. [Migrate to virtual network flow logs](/azure/network-watcher/nsg-flow-logs-migrate) to overcome the limitations of NSG flow logs.

Virtual network (VNet) flow logs record information about IP traffic that flows through your virtual network. Use flow logs to identify blocked SSH traffic patterns.

#### Azure CLI

To use Azure CLI to check VNet flow logs, run the following command:

```azurecli
# Query VNet flow logs from Log Analytics workspace
az monitor log-analytics query \
    --workspace <workspace-id> \
    --analytics-query "NTANetAnalytics | where DestPort_d == 22 and FlowStatus_s == 'D' | project TimeGenerated, SrcIp_s, DestIp_s, DestPort_d, NSGRule_s | order by TimeGenerated desc | take 20" \
    --output table
```

## Resolve SSH connection failures caused by NSG rules

### Allow SSH traffic on port 22

Create or modify an inbound NSG rule that allows TCP port 22 traffic from the desired source.

#### Azure portal

To use Azure portal to create an NSG rule that allows SSH traffic, follow these steps:

1. Go to the [Azure portal](https://portal.azure.com), and select **Virtual machines**.
2. Select the affected VM.
3. Select **Networking** > **Network settings**.
4. Select **Create port rule** > **Inbound port rule**.
5. Configure the rule.

    | Setting | Value |
    |---------|-------|
    | **Source** | Select the appropriate source (IP address, service tag, or Any) |
    | **Source port ranges** | * |
    | **Destination** | Any |
    | **Destination port ranges** | 22 |
    | **Protocol** | TCP |
    | **Action** | Allow |
    | **Priority** | A value less than any conflicting deny rule (for example, 300) |
    | **Name** | AllowSSH |

6. Select **Add**.

#### Azure CLI

To use Azure CLI to create an NSG rule that allows SSH traffic, run the following command:

```azurecli
az network nsg rule create \
    --resource-group <resource-group> \
    --nsg-name <nsg-name> \
    --name AllowSSH \
    --priority 300 \
    --direction Inbound \
    --access Allow \
    --protocol Tcp \
    --destination-port-ranges 22 \
    --source-address-prefixes <source-ip-or-range> \
    --destination-address-prefixes '*' \
    --source-port-ranges '*'
```

#### Azure PowerShell

To use Azure PowerShell to create an NSG rule that allows SSH traffic, run the following command:

```azurepowershell
$nsg = Get-AzNetworkSecurityGroup `
    -ResourceGroupName "<resource-group>" `
    -Name "<nsg-name>"

$nsg | Add-AzNetworkSecurityRuleConfig `
    -Name "AllowSSH" `
    -Priority 300 `
    -Direction Inbound `
    -Access Allow `
    -Protocol Tcp `
    -DestinationPortRange 22 `
    -SourceAddressPrefix "<source-ip-or-range>" `
    -DestinationAddressPrefix "*" `
    -SourcePortRange "*"

$nsg | Set-AzNetworkSecurityGroup
```

### Fix priority conflicts

If a deny rule blocks SSH before the allow rule is evaluated, adjust rule priorities so that the allow rule has a lower priority number:

1. Identify the blocking deny rule and its priority number.
2. Change the SSH allow rule priority to a lower number than the deny rule has.

You can also change the deny rule to a higher priority number or modify it to exclude port 22.

### Fix subnet and NIC NSG conflicts

Make sure that both subnet-level and NIC-level NSGs allow SSH:

1. View effective security rules to identify which NSG blocks the traffic.
2. Add an allow rule for TCP port 22 in the blocking NSG.
3. Use IP flow verify to verify that traffic is allowed after the change is made.

### Allow a custom SSH port

If `sshd` uses a nonstandard port:

1. Check the SSH port on the VM: `grep -i port /etc/ssh/sshd_config`.
2. Update the NSG rule destination port to match the configured SSH port.
3. Update any automation scripts or connection strings so that they use the custom port.

## Secure alternatives to exposing SSH port 22 publicly

Instead of exposing port 22 to the internet, use more secure connection methods for production environments:

- **Azure Bastion**: Provides SSH connectivity through the Azure portal over TLS without exposing a public IP address on the VM. For more information, see [What is Azure Bastion?](/azure/bastion/bastion-overview).

- **Just-in-time (JIT) VM access**: Allows temporary NSG rules that open SSH access for a limited time period from approved IP addresses. For more information, see [Understanding just-in-time (JIT) VM access](/azure/defender-for-cloud/just-in-time-access-overview).

- **Azure VPN Gateway or Azure ExpressRoute**: Connects to VMs over private IP addresses through a VPN or private connection. This setup eliminates the need to expose SSH to the internet.

- **Azure Private Link**: Enables access to Azure services over a private endpoint in your virtual network.

## Related content

- [How network security groups filter network traffic](/azure/virtual-network/network-security-group-how-it-works)
- [Troubleshoot connectivity problems between Azure VMs](virtual-network-troubleshoot-connectivity-problem-between-vms.md)
- [Diagnose a virtual machine network traffic filter problem](diagnose-network-traffic-filter-problem.md)
- [Network security groups overview](/azure/virtual-network/network-security-groups-overview)
- [Detailed troubleshoot SSH connection to an Azure Linux VM](/azure/virtual-machines/troubleshooting/detailed-troubleshoot-ssh-connection)
