---
title: Troubleshoot connectivity problems between Azure VMs
description: Learn how to troubleshoot and resolve the connectivity problems that you might experience between Azure virtual machines (VMs).
services: virtual-network
author: asudbring
ms.author: allensu
manager: dcscontentpm
ms.service: azure-virtual-network
ms.topic: troubleshooting
ms.date: 03/05/2026
ms.custom: = sap:Connectivity
# Customer intent: "As a cloud administrator, I want to troubleshoot connectivity issues between Azure virtual machines, so that I can ensure optimal communication and functionality within my cloud infrastructure."
---

# Troubleshooting connectivity problems between Azure VMs

## Summary

You might experience connectivity problems between Azure virtual machines (VMs). This article provides troubleshooting steps to help you resolve this problem. 

If your Azure issue is not addressed in this article, visit the Azure forums on [Microsoft Q & A](https://azure.microsoft.com/support/forums) and [Stack Overflow](https://stackoverflow.com/questions/tagged/azure). You can post your issue in these forums, or post to [@AzureSupport](https://twitter.com/AzureSupport) on Twitter. You also can submit an Azure support request. To submit a support request, on the [Azure support page](https://azure.microsoft.com/support), select **Get support**.

## Symptom

One Azure VM can't connect to another Azure VM.

## Troubleshooting guidance 

1. [Check whether NIC is misconfigured](#step-1-check-whether-nic-is-misconfigured)
2. [Check whether network traffic is blocked by NSG or UDR](#step-2-check-whether-network-traffic-is-blocked-by-nsg-or-udr)
3. [Check whether network traffic is blocked by VM firewall](#step-3-check-whether-network-traffic-is-blocked-by-vm-firewall)
4. [Check whether VM app or service is listening on the port](#step-4-check-whether-vm-app-or-service-is-listening-on-the-port)
5. [Check whether the problem is caused by SNAT](#step-5-check-whether-the-problem-is-caused-by-snat)
6. [Check whether traffic is blocked by ACLs for the classic VM](#step-6-check-whether-traffic-is-blocked-by-acls-for-the-classic-vm)
7. [Check whether the endpoint is created for the classic VM](#step-7-check-whether-the-endpoint-is-created-for-the-classic-vm)
8. [Try to connect to a VM network share](#step-8-try-to-connect-to-a-vm-network-share)
9. [Check Inter-VNet connectivity](#step-9-check-inter-vnet-connectivity)

> [!NOTE]  
> You can also use Test-NetConnection module in PowerShell to diagnose information for a connection.
> 
## Troubleshooting steps

Follow these steps to troubleshoot the problem. After you complete each step, check whether the problem is resolved. 

### Step 1: Check whether NIC is misconfigured

Follow the steps in [How to reset network interface for Azure Windows VM](/troubleshoot/azure/virtual-machines/reset-network-interface). 

If the problem occurs after you modify the network interface (NIC), follow these steps:

**Multi-NIC VMs**

1. Add a NIC.
2. Fix the problems in the bad NIC or remove the bad NIC.  Then add the NIC again.

For more information, see [Add network interfaces to or remove from virtual machines](/azure/virtual-network/virtual-network-network-interface-vm).

**Single-NIC VM** 

- [Redeploy Windows VM](/troubleshoot/azure/virtual-machines/redeploy-to-new-node-windows)
- [Redeploy Linux VM](/troubleshoot/azure/virtual-machines/redeploy-to-new-node-linux)

### Step 2: Check whether network traffic is blocked by NSG or UDR

Network Security Groups (NSGs) and User-Defined Routes (UDRs) can interfere with traffic flow between VMs. NSGs can be applied at both the subnet level and the network interface (NIC) level, and traffic must pass through both. Use the following substeps to diagnose NSG or UDR-related blocking.

#### Use Network Watcher IP Flow Verify

IP Flow Verify quickly identifies which NSG rule is allowing or denying traffic to or from a VM.

1. In the Azure portal, go to **Network Watcher** > **IP flow verify**.
2. Select the subscription and resource group of the source VM.
3. Enter:
   - **Direction**: Inbound or Outbound
   - **Protocol**: TCP or UDP
   - **Local port**: The destination port on the VM (for example, 3389 for RDP, 22 for SSH)
   - **Remote IP address**: The IP of the connecting VM
   - **Remote port**: The source port (or use `*` for any)
4. Select **Check** to see which NSG rule is allowing or denying the traffic.

You can also use the Azure CLI or Azure PowerShell:

```azurecli
az network watcher test-ip-flow \
  --direction Inbound \
  --protocol TCP \
  --local 10.0.0.4:3389 \
  --remote 10.0.1.4:* \
  --vm <vm-resource-id> \
  --nic <nic-name>
```

```azurepowershell
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

For more information, see [Network Watcher IP Flow Verify overview](/azure/network-watcher/ip-flow-verify-overview).

#### Use Connection Troubleshoot

[Connection Troubleshoot](/azure/network-watcher/connection-troubleshoot-overview) tests the connection between a source VM and a destination. It identifies whether the connection succeeds or fails and which NSG rule or configuration is causing the issue.

1. In the Azure portal, go to **Network Watcher** > **Connection troubleshoot**.
2. Select the source VM and destination (VM, URI, FQDN, or IP address).
3. Specify the destination port and protocol.
4. Select **Check** to view the results, including the specific NSG rules evaluated along the path.

#### View effective security rules

The effective security rules view shows all NSG rules applied to a network interface, including rules inherited from the subnet-level NSG.

1. In the Azure portal, go to the VM's **Networking** settings.
2. Select the network interface.
3. Select **Effective security rules** to see the combined rules from both the NIC-level and subnet-level NSGs.

Alternatively, use the Azure CLI:

```azurecli
az network nic list-effective-nsg --resource-group <resource-group> --name <nic-name>
```

For more information, see [Diagnose a VM network traffic filter problem](/azure/virtual-network/diagnose-network-traffic-filter-problem).

#### Check NSG rules at both subnet and NIC levels

Traffic between VMs must pass through both the subnet-level NSG and the NIC-level NSG. A rule that allows traffic at the subnet level can still be blocked at the NIC level, and vice versa. Verify rules at both levels:

1. In the Azure portal, go to the VM's **Networking** settings to see NIC-level NSG rules.
2. Go to the subnet configuration in the virtual network to see subnet-level NSG rules.
3. Verify that both NSGs have allow rules for the required protocol and port.

#### Common NSG misconfigurations

- **Priority conflicts**: A higher-priority deny rule (lower number) overrides a lower-priority allow rule. Verify rule priorities to ensure allow rules aren't being shadowed.
- **Missing inbound rules on both NSGs**: Inbound allow rules may be needed on both the subnet-level NSG and the NIC-level NSG.
- **Source IP restrictions**: Rules that restrict source IP addresses may inadvertently block traffic from VMs in different subnets or virtual networks. Verify the source IP or use appropriate service tags.
- **Default deny rules**: The default `DenyAllInbound` rule (priority 65500) blocks all inbound traffic not explicitly allowed. Add explicit allow rules with a lower priority number.
- **Service tag misunderstandings**: Service tags like `VirtualNetwork` include the virtual network address space, peered networks, and on-premises networks connected via gateways. Verify that the service tag in your rules matches the expected traffic source.

#### Analyze traffic with flow logs

If the issue is intermittent or difficult to reproduce, use flow logs to analyze traffic patterns:

- **VNet flow logs** (recommended): VNet flow logs provide per-flow state and throughput data at the virtual network level, capturing traffic for all workloads. For more information, see [VNet flow logs overview](/azure/network-watcher/vnet-flow-logs-overview).
- **NSG flow logs**: NSG flow logs capture information about IP traffic flowing through an NSG. For more information, see [NSG flow logs overview](/azure/network-watcher/nsg-flow-logs-overview).

Use [Traffic Analytics](/azure/network-watcher/traffic-analytics) to visualize flow log data and identify blocked traffic patterns.

#### Check User-Defined Routes (UDRs)

If NSG rules appear correct, check whether a UDR is redirecting traffic to an unexpected next hop (such as a network virtual appliance) that may be dropping or filtering the traffic.

1. In the Azure portal, go to the VM's **Networking** settings.
2. Select the network interface, then select **Effective routes**.
3. Look for routes that may be sending traffic to a network virtual appliance (NVA) or unexpected next hop.

For more information, see [Virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview).

### Step 3: Check whether network traffic is blocked by VM firewall

Disable the firewall, and then test the result. If the problem is resolved, verify the firewall settings, and then re-enable the firewall.

### Step 4: Check whether VM app or service is listening on the port

You can use one of the following methods to check whether the VM app or service is listening on the port.

- Run the following commands to check whether the server is listening on that port.

**Windows VM**

```console
netstat –ano
```

**Linux VM**

```console
netstat -l
```

- Run the **telnet** command on the virtual machine itself to test the port. If the test fails, the application or service isn't configured to listen on that port.

### Step 5: Check whether the problem is caused by SNAT

In some scenarios, the VM is placed behind a load balance solution that has a dependency on resources outside of Azure. In these scenarios, if you experience intermittent connection problems, the problem may be caused by [SNAT port exhaustion](/azure/load-balancer/load-balancer-outbound-connections). To resolve the issue, create a VIP (or ILPIP for classic) for each VM that is behind the load balancer and secure with NSG or ACL. 

### Step 6: Check whether traffic is blocked by ACLs for the classic VM

An  access control list (ACL) provides the ability to selectively permit or deny traffic for a virtual machine endpoint. For more information, see [Manage the ACL on an endpoint](/previous-versions/azure/virtual-machines/windows/classic/setup-endpoints#manage-the-acl-on-an-endpoint).

### Step 7: Check whether the endpoint is created for the classic VM

All VMs that you create in Azure by using the classic deployment model can automatically communicate over a private network channel with other virtual machines in the same cloud service or virtual network. However, computers on other virtual networks require endpoints to direct the inbound network traffic to a virtual machine. For more information, see [How to set up endpoints](/previous-versions/azure/virtual-machines/windows/classic/setup-endpoints).

### Step 8: Try to connect to a VM network share

If you can't connect to a VM network share, the problem may be caused by unavailable NICs in the VM. To delete the unavailable NICs, see [How to delete the unavailable NICs](/troubleshoot/azure/virtual-machines/reset-network-interface#delete-the-unavailable-nics)

### Step 9: Check Inter-VNet connectivity

Use [Network Watcher IP Flow Verify](/azure/network-watcher/ip-flow-verify-overview) to determine whether an NSG or UDR is interfering with traffic flow. Use [VNet flow logs](/azure/network-watcher/vnet-flow-logs-overview) (recommended) or [NSG flow logs](/azure/network-watcher/nsg-flow-logs-overview) to analyze traffic patterns between virtual networks. You can also verify your Inter-VNet configuration [here](https://support.microsoft.com/en-us/help/4032151/configuring-and-validating-vnet-or-vpn-connections).

### Need help? Contact support

If you still need help, [contact support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade) to get your issue resolved quickly.