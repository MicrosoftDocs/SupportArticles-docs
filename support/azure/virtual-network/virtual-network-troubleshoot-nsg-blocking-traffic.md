---
title: Troubleshoot NSG misconfigurations that block traffic in Azure Virtual Network
description: Learn how to diagnose and resolve common Network Security Group (NSG) misconfigurations that block expected traffic in Azure virtual networks.
services: virtual-network
author: asudbring
ms.author: allensu
manager: dcscontentpm
ms.service: azure-virtual-network
ms.topic: troubleshooting
ms.date: 03/17/2026
ms.custom: 
  - sap:Connectivity
  - sap:Creating and troubleshooting Network Security Groups
# Customer intent: "As a network administrator, I want to identify and fix NSG misconfigurations that are blocking expected traffic, so that my Azure virtual network resources can communicate correctly."
---

# Troubleshoot network security group misconfigurations blocking traffic in Azure virtual networks

## Summary

This article helps you diagnose and resolve common network security group (NSG) misconfigurations that block expected traffic in Azure virtual networks. Use this guide when traffic like Remote Desktop Protocol (RDP) (port 3389), Secure Shell (SSH) (port 22), HTTP/HTTPS, or custom application traffic is unexpectedly blocked.

## Prerequisites

- An Azure account that has an active subscription
- [Network Watcher](/azure/network-watcher/network-watcher-create) enabled in the region of your virtual network

## How NSG rule evaluation works

To diagnose blocking problems, it's important to understand how Azure evaluates NSG rules.

### Rule processing order

Azure evaluates NSG rules by priority, from lowest number (highest priority) to highest number (lowest priority) as follows:

- Azure evaluates inbound and outbound rules separately.
- For inbound traffic, Azure first evaluates the subnet-level NSG, then the NIC-level NSG.
- For outbound traffic, Azure first evaluates the NIC-level NSG, then the subnet-level NSG.
- Within each NSG, Azure evaluates rules in priority order (lowest number first).
- When Azure finds a matching rule, evaluation stops. Azure doesn't process any additional rules.

### Subnet-level and NIC-level NSG interaction

When you apply NSGs at both the subnet and NIC (network adapter) levels, *both* NSGs must allow the traffic in order for the traffic to flow successfully. If either NSG has a deny rule that matches the traffic, the traffic is blocked.

**Example** 

A successful inbound RDP connection to a VM works like this:

- Traffic arrives at the subnet. The subnet-level NSG is evaluated first.
- If the subnet-level NSG allows the traffic, the NIC-level NSG is evaluated next.
- If the NIC-level NSG also allows the traffic, the traffic reaches the VM.
- If either NSG denies the traffic, the connection fails.

### Default security rules

Every NSG includes the following default rules that you can't delete.

| Priority | Name | Direction | Action | Description |
|----------|------|-----------|--------|-------------|
| 65000 | AllowVnetInBound | Inbound | Allow | Allow traffic from the virtual network. |
| 65001 | AllowAzureLoadBalancerInBound | Inbound | Allow | Allow traffic from the Azure load balancer. |
| 65500 | DenyAllInBound | Inbound | Deny | Deny all other inbound traffic. |
| 65000 | AllowVnetOutBound | Outbound | Allow | Allow traffic to the virtual network. |
| 65001 | AllowInternetOutBound | Outbound | Allow | Allow outbound traffic to the internet. |
| 65500 | DenyAllOutBound | Outbound | Deny | Deny all other outbound traffic. |

The `DenyAllInBound` rule (priority 65500) blocks all inbound traffic that isn't explicitly allowed by a higher-priority rule. You must add explicit allow rules that have a priority number that's less than 65500 for any traffic that you want to permit.

## Common NSG misconfigurations

### Priority conflicts

A higher-priority deny rule (lower-priority number) overrides a lower-priority allow rule (higher-priority number).

#### Symptom

**Example** 

You create an allow rule for RDP (port 3389) with priority 1000, but a deny rule for all traffic exists at priority 500. The deny rule at priority 500 is evaluated first and blocks the traffic before the allow rule at priority 1000 is reached.

#### Resolution

1. Review all rules in the NSG to identify deny rules that have a lower priority number than your allow rule has.
2. Either remove the conflicting deny rule or change the priority of the allow rule to a lower number than the deny rule has.

### NSG applied at both subnet and NIC with conflicting rules

#### Symptom

One NSG allows traffic but the other NSG blocks it. The effective result is that traffic is denied.

**Example**

The subnet-level NSG allows SSH (port 22), but the NIC-level NSG has the default `DenyAllInBound` rule and no explicit allow rule for SSH.

#### Resolution

1. Use the **Effective security rules** view to see the combined rules from both NSGs. In the Azure portal, go to the VM's **Networking** settings, and select the network interface to view effective security rules.
2. Add matching allow rules in both the subnet-level and NIC-level NSGs.

### Source IP address restrictions

#### Symptom

Traffic from certain sources is blocked, while traffic from other sources in the same virtual network works.

**Example**

An NSG rule allows RDP from source `10.0.1.0/24`, but the connecting VM is in subnet `10.0.2.0/24`. The source IP doesn't match the rule, so traffic is subject to the default deny rule.

#### Resolution

1. Verify the source IP address of the connecting machine.
2. Update the rule's source IP address range to include the correct address, or use a service tag like `VirtualNetwork`.

### Service tag misunderstandings

Service tags represent groups of IP address prefixes. Understanding what each tag includes is important.

| Service tag | Includes |
|-------------|----------|
| `VirtualNetwork` | Virtual network address space, all connected on-premises address spaces, peered virtual networks, virtual networks connected to a virtual network gateway, the virtual IP address of the host, and address prefixes used on user-defined routes. |
| `Internet` | All IP addresses outside the virtual network address space that are reachable by the public internet, including Azure public-facing services. |
| `AzureLoadBalancer` | The Azure infrastructure load balancer IP. |
| `AzureCloud` | All Azure datacenter public IP addresses. |

**Examples**

- Incorrectly using `Internet` as the source when you intend to allow traffic from other Azure resources. Instead, use `VirtualNetwork` or a specific service tag.
- Assuming that `VirtualNetwork` includes only the local VNet. Actually, it also includes peered networks and on-premises connections through gateways.

For the full list of service tags, see [Virtual network service tags](/azure/virtual-network/service-tags-overview).

### Application security group (ASG) misconfigurations

#### Symptom

NSG rules that reference ASGs don't work as expected.

**Examples**

- The source or destination VM isn't a member of the referenced ASG.
- The ASG and the NSG are in different virtual networks. Network interfaces in an ASG and the NSG that references them must exist in the same virtual network.
- Rules mixing ASGs with IP address ranges in the same rule. A single rule can't combine ASG references with IP address ranges for the same source or destination.

#### Resolution

1. Verify VM membership in the ASG. In the Azure portal, go to the VM's **Networking** settings and check the **Application Security Groups** section.
2. Verify the ASG and NSG are in the same virtual network.
3. Use separate rules if you need to combine ASG and IP-based rules.

### Default deny rules blocking expected traffic

#### Symptom

No custom deny rules exist, but traffic is still blocked.

#### Cause

The default `DenyAllInBound` rule (priority 65500) blocks all inbound traffic that isn't matched by a higher-priority allow rule.

#### Resolution

1. Add an explicit allow rule for the required protocol and port with a priority number lower than 65500.
2. For common scenarios, use the following rules:

   - **RDP**: Allow TCP port 3389.
   - **SSH**: Allow TCP port 22.
   - **HTTP**: Allow TCP port 80.
   - **HTTPS**: Allow TCP port 443.
   - **Custom application**: Allow the specific protocol and port used by your application.

## Diagnose NSG blocking problems

### Use Azure Network Watcher IP flow verify

The IP flow verify feature checks whether a packet is allowed or denied to or from a VM and identifies which NSG rule is responsible.

#### Azure portal

To use IP flow verify in the Azure portal:

1. Go to **Network Watcher** > **IP flow verify**.
2. Select the subscription, resource group, VM, and network interface.
3. Enter the packet details:
   - **Direction**: Inbound or Outbound
   - **Protocol**: TCP or UDP
   - **Local port**: The port on the VM (for example, `3389` for RDP)
   - **Remote IP address**: The IP of the source or destination
   - **Remote port**: The source or destination port
4. Select **Check**. The result shows whether traffic is **Allowed** or **Denied** and which NSG rule made the decision.

#### Azure CLI

To use IP flow verify in Azure CLI, run the following command:

```azurecli
az network watcher test-ip-flow \
  --direction Inbound \
  --protocol TCP \
  --local 10.0.0.4:3389 \
  --remote 10.0.1.4:* \
  --vm <vm-resource-id> \
  --nic <nic-name>
```

#### Azure PowerShell

To use IP flow verify in Azure PowerShell, run the following command:

```azurepowershell
$networkWatcher = Get-AzNetworkWatcher -Name <network-watcher-name> -ResourceGroupName <resource-group>

Test-AzNetworkWatcherIPFlow `
  -NetworkWatcher $networkWatcher `
  -Direction Inbound `
  -Protocol TCP `
  -LocalIPAddress 10.0.0.4 `
  -LocalPort 3389 `
  -RemoteIPAddress 10.0.1.4 `
  -RemotePort * `
  -TargetVirtualMachineId <vm-resource-id>
```

For more information, see [IP flow verify overview](/azure/network-watcher/ip-flow-verify-overview).

### View effective security rules

The effective security rules view shows the combined rules from all NSGs applied to a network interface, including default rules and rules inherited from the subnet-level NSG.

#### Azure portal

To view effective security rules in the Azure portal:

1. Go to the VM in the Azure portal.
2. Select **Networking** > **Network settings**.
3. Select the network interface.
4. Select **Effective security rules** to see all rules in effect.

#### Azure CLI

To view effective security rules in Azure CLI, run the following command:

```azurecli
az network nic list-effective-nsg \
  --resource-group <resource-group> \
  --name <nic-name>
```

#### Azure PowerShell

To view effective security rules in Azure PowerShell, run the following command:

```azurepowershell
Get-AzEffectiveNetworkSecurityGroup `
  -NetworkInterfaceName <nic-name> `
  -ResourceGroupName <resource-group>
```

For more information, see [Diagnose a VM network traffic filter problem](/azure/virtual-network/diagnose-network-traffic-filter-problem).

### Azure Network Watcher connection troubleshoot

The connection troubleshoot feature tests the full connection path between a source and destination, including NSG rule evaluation along the route. To use connection troubleshoot:

1. Go to **Network Watcher** > **Connection troubleshoot**.
2. Select the source VM and destination (VM, URI, FQDN, or IP address).
3. Specify the destination port and protocol.
4. Select **Check**. The results show each hop in the path and whether the connection succeeded or failed, including which NSG rules were evaluated.

For more information, see [Connection troubleshoot overview](/azure/network-watcher/connection-troubleshoot-overview).

### Analyze traffic by using flow logs

Use flow logs to analyze traffic patterns and identify blocked flows, especially for intermittent problems.

#### VNet flow logs (recommended)

VNet flow logs provide per-flow state and throughput data at the virtual network level. They capture traffic for all workloads within the virtual network. VNet flow logs are the recommended option for new deployments.

For more information, see [VNet flow logs overview](/azure/network-watcher/vnet-flow-logs-overview).

#### NSG flow logs

> [!IMPORTANT]
> Azure retires NSG flow logs on September 30, 2027. As part of this retirement, you can't create new NSG flow logs after June 30, 2025. [Migrate](/azure/network-watcher/nsg-flow-logs-migrate) to [virtual network flow logs](/azure/network-watcher/vnet-flow-logs-overview) which overcome the limitations of NSG flow logs.

NSG flow logs capture information about IP traffic flowing through an NSG. Use NSG flow logs when you need to analyze traffic at the NSG level.

For more information, see [NSG flow logs overview](/azure/network-watcher/nsg-flow-logs-overview).

#### Network Watcher traffic analytics

Use Network Watcher [traffic analytics](/azure/network-watcher/traffic-analytics) to visualize flow log data in a dashboard. Traffic analytics helps you identify:

- Top blocked flows and the NSG rules responsible for them
- Traffic patterns between virtual networks and subnets
- Unusual traffic volumes that might indicate misconfigurations

## Resolution patterns

### Allow specific port traffic

To allow inbound traffic on a specific port, like RDP on port 3389:

1. Identify which NSGs are applied to the VM, including both subnet-level and NIC-level NSGs.
2. In **each** NSG, add an inbound allow rule with the following settings:
   - **Source**: The appropriate source, such as a specific IP address, CIDR range, or service tag.
   - **Source port ranges**: `*`
   - **Destination**: The VM's IP address or `VirtualNetwork`.
   - **Destination port ranges**: The required port, such as `3389`.
   - **Protocol**: TCP or as required.
   - **Action**: Allow.
   - **Priority**: A number lower than any deny rule that might match.
3. Verify the change by using IP flow verify.

### Resolve priority conflicts

To resolve priority conflicts where a deny rule is blocking traffic that an allow rule is supposed to permit:

1. List all rules in the NSG sorted by priority.
2. Identify deny rules with a lower priority number (higher priority) than your allow rule.
3. Choose one of the following options:
   - Change the allow rule's priority to a lower number than the conflicting deny rule.
   - Remove or modify the conflicting deny rule.
   - Narrow the scope of the deny rule so it doesn't match your desired traffic.

### Fix subnet and NIC NSG conflicts

To fix conflicts between subnet-level and NIC-level NSGs:

1. Use the effective security rules view to identify which NSG is blocking the traffic.
2. Add a matching allow rule to the blocking NSG.
3. To simplify the configuration, remove the NSG from either the subnet or the NIC if you don't need dual NSGs.

## Best practices for NSG rule management

- **Use descriptive rule names**: Name rules to reflect their purpose (for example, `Allow-RDP-from-Management-Subnet`).
- **Use service tags**: Use service tags instead of hard-coded IP addresses where possible for easier maintenance.
- **Document your rules**: Maintain documentation of NSG rules and their business justification.
- **Use Azure Bastion or just-in-time (JIT) access**: Instead of opening RDP/SSH ports permanently, use [Azure Bastion](/azure/bastion/bastion-overview) or [just-in-time (JIT) VM access](/azure/defender-for-cloud/enable-just-in-time-access) for secure management access.
- **Minimize the number of NSGs**: Apply NSGs at the subnet level when possible to reduce complexity. Use NIC-level NSGs only when VMs in the same subnet require different security policies.
- **Review rules regularly**: Use [Microsoft Defender for Cloud](/azure/defender-for-cloud/defender-for-cloud-introduction) recommendations to identify overly permissive rules.
- **Enable flow logs**: Enable VNet flow logs or NSG flow logs with Traffic Analytics for ongoing visibility into traffic patterns.

## Related content

- [Diagnose a VM network traffic filter problem](/azure/virtual-network/diagnose-network-traffic-filter-problem)
- [Troubleshoot connectivity problems between Azure VMs](virtual-network-troubleshoot-connectivity-problem-between-vms.md)
- [Cannot connect to VM because RDP port is not enabled in NSG](/troubleshoot/azure/virtual-machines/windows/troubleshoot-rdp-nsg-problem)
- [Diagnostic resource logging for a network security group](virtual-network-nsg-manage-log.md)
- [Virtual network service tags](/azure/virtual-network/service-tags-overview)
- [Network security groups overview](/azure/virtual-network/network-security-groups-overview)
