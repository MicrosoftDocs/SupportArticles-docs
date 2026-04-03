---
title: Troubleshoot virtual network peering route propagation and sync problems
description: Troubleshoot route propagation delays, peering sync failures, DNS resolution, and peering health monitoring for Azure virtual network peering. Use this guide to restore connectivity between peered virtual networks.
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-virtual-network
ms.topic: troubleshooting
ms.date: 03/17/2026
ms.custom: sap:issues configuring azure virtual network (vnet) peering
# Customer intent: As a network engineer, I want to troubleshoot route propagation and sync problems in virtual network peering so that I can restore connectivity between peered virtual networks.
---

# Troubleshoot virtual network peering route propagation and sync problems

## Summary

This article helps you diagnose and resolve common route propagation, peering synchronization, Domain Name System (DNS) resolution, and monitoring problems with Azure [virtual network peering](/azure/virtual-network/virtual-network-peering-overview). For general peering troubleshooting including configuration, connectivity, and error messages, see [Troubleshoot virtual network peering problems](virtual-network-troubleshoot-peering-issues.md).

## Prerequisites

- An Azure account with an active subscription
- [Azure CLI](/cli/azure/install-azure-cli) or [Azure PowerShell](/powershell/azure/install-azure-powershell) installed
- [Azure Network Watcher](/azure/network-watcher/network-watcher-create) enabled in the regions where your virtual networks are deployed
- Network Contributor role or equivalent permissions on both virtual networks

## Cause 1: Route propagation delays after peering creation or modification

After you create or modify a virtual network peering setup, Azure automatically adds system routes that use the next hop type, **Virtual network peering**, for each address range in the peered virtual network. These route updates don't take effect instantly. Propagation can take a few minutes to process.

### Symptoms

- Virtual machines (VMs) in a newly peered virtual network can't reach one another immediately after the peering is created.
- After you modify a peering setting (such as enabling **Allow forwarded traffic** or **Allow gateway transit**), traffic doesn't behave as expected.
- The effective routes on a VM's network interface don't show the peered virtual network's address space.

### Solution: Verify effective routes and wait for propagation

1. Wait two-to-five minutes after the peering operation finishes. Most route propagation finishes within this window.

2. Check the effective routes on a VM's network interface to verify that the peering routes appear. 

To use the [Azure portal](https://portal.azure.com):

   1. Go to the virtual machine, and select **Networking**.
   2. Select the network interface.
   3. Select **Effective routes**, and look for entries that have the **Virtual network peering** next hop type and the address prefix of the peered virtual network.

For Azure CLI, run the following command:

   ```azurecli
   az network nic show-effective-route-table \
     --resource-group <resource-group> \
     --name <nic-name> \
     --output table
   ```

For Azure PowerShell, run the following command:

   ```azurepowershell
   Get-AzEffectiveRouteTable -ResourceGroupName <resource-group> -NetworkInterfaceName <nic-name>
   ```

3. If the peering routes don't appear after five minutes:

   - Verify that the peering status is **Connected** on both virtual networks.
   - Verify that the address spaces on both virtual networks are correct and don't overlap.
   - Check that no [Azure Policy](/azure/governance/policy/overview) is blocking the route propagation.

If the routes appear but connectivity still fails, check for user-defined routes (UDRs) or network security groups (NSGs) that might be overriding or blocking the peering traffic. For more information, see [Troubleshoot virtual network peering problems](virtual-network-troubleshoot-peering-issues.md).

## Cause 2: Peering sync required after address space changes

When you add, modify, or remove address ranges in a peered virtual network, the peering must sync to update the remote peer's routing information. If you skip or delay the sync, the remote peered virtual network continues to use the old address space. This behavior can cause routing failures.

### Symptoms

- Traffic to newly added address ranges in a peered virtual network fails.
- The effective routes on a VM's network interface still show the old address prefixes for the peered virtual network.
- The peering status shows **Connected**, but the remote address space that's listed in the peering details doesn't match the actual address space of the peer.

### Solution: Sync the peering and verify the updated routes

1. Check whether the remote address space in the peering matches the actual address space of the peered virtual network. Use Azure CLI to run the following command:

   ```azurecli
   # Check the peering's view of the remote address space
   az network vnet peering show \
     --resource-group <resource-group> \
     --vnet-name <local-vnet-name> \
     --name <peering-name> \
     --query "remoteAddressSpace.addressPrefixes"

   # Check the actual address space of the remote virtual network
   az network vnet show \
     --resource-group <remote-resource-group> \
     --name <remote-vnet-name> \
     --query "addressSpace.addressPrefixes"
   ```

2. If the values don't match, sync the peering.

To use Azure portal:

   1. Go to the virtual network where you changed the address space.
   2. Select **Peering**, and then select the checkbox next to the peering.
   3. Select **Sync**.
   4. Repeat for each remote peered virtual network.

For Azure CLI, run the following command:

   ```azurecli
   az network vnet peering sync \
     --resource-group <resource-group> \
     --vnet-name <vnet-name> \
     --name <peering-name>
   ```

3. After the sync, verify that the remote address space is updated. Use Azure CLI to run the following command:

   ```azurecli
   az network vnet peering show \
     --resource-group <resource-group> \
     --vnet-name <local-vnet-name> \
     --name <peering-name> \
     --query "{state:peeringState, remoteAddressSpace:remoteAddressSpace.addressPrefixes}"
   ```

4. Check the effective routes on VMs in the peered virtual network to verify that the new address ranges are present.

> [!IMPORTANT]
> Run the sync operation after every address space change. Don't batch multiple address space changes before you sync. Address space sync isn't supported if the virtual network is peered with a classic virtual network.

## Cause 3: DNS resolution failures across peered virtual networks

Virtual network peering provides network-layer connectivity between peered virtual networks, but it doesn't automatically enable DNS name resolution across peers. VMs in one virtual network can't resolve the private DNS names of VMs in a peered virtual network by using only the default Azure-provided DNS.

### Symptoms

- A VM in one peered virtual network can ping the private IP address of a VM in the other virtual network, but DNS name resolution with the hostname fails.
- `nslookup <hostname>` or `Resolve-DnsName <hostname>` returns `NXDOMAIN` or a public IP address instead of the private IP.
- Applications that rely on DNS names to connect to resources in a peered virtual network fail, even though the peering status is **Connected**.

### Solution 1: Use Azure Private DNS zones

[Azure Private DNS](/azure/dns/private-dns-overview) provides name resolution for VMs across peered virtual networks without a custom DNS server.

1. [Create a private DNS zone](/azure/dns/private-dns-getstarted-portal) (for example, `contoso.internal`).

2. [Link the private DNS zone](/azure/dns/private-dns-virtual-network-links) to both peered virtual networks by having auto-registration enabled. Use Azure CLI to run the following command:

   ```azurecli
   # Link to the first virtual network with auto-registration
   az network private-dns link vnet create \
     --resource-group <resource-group> \
     --zone-name contoso.internal \
     --name link-vnet1 \
     --virtual-network <vnet1-resource-id> \
     --registration-enabled true

   # Link to the second virtual network with auto-registration
   az network private-dns link vnet create \
     --resource-group <resource-group> \
     --zone-name contoso.internal \
     --name link-vnet2 \
     --virtual-network <vnet2-resource-id> \
     --registration-enabled true
   ```

After you create both links, VMs in either virtual network can resolve one another's names by using the `<hostname>.contoso.internal` format.

### Solution 2: Configure custom DNS forwarding

If you already use a custom DNS server, configure conditional forwarding for the peered virtual network's DNS zone:

1. On your DNS server, create a conditional forwarder for the peered virtual network's DNS zone. Point it to the Azure DNS recursive resolver at **168.63.129.16**.

2. Configure each virtual network's DNS settings to point to the custom DNS server. Go to the virtual network, select **DNS servers**, and enter the private IP address of your DNS server.

3. Restart the VMs or renew their Dynamic Host Configuration Protocol (DHCP) lease to pick up the DNS changes.

> [!NOTE]
> The Azure-provided DNS at **168.63.129.16** resolves names for only VMs within the same virtual network or linked private DNS zones. A custom DNS server or Azure Private DNS zones is required for cross-VNet name resolution.

## Cause 4: Border Gateway Protocol route conflicts with peering routes

In hybrid environments that use VPN gateways or ExpressRoute with Border Gateway Protocol (BGP), routes that are advertised from on-premises can appear to conflict with virtual network peering routes. System routes for peered virtual networks take precedence over BGP-learned routes, even when BGP advertises a more specific prefix. However, a user-defined route (UDR) might override both peering and BGP system routes. This behavior can inadvertently redirect peering traffic through a gateway or virtual appliance.

### Symptoms

- Traffic to a peered virtual network routes to the VPN gateway or Azure ExpressRoute circuit instead of directly through the peering.
- The effective routes on a VM's network interface show a BGP route that has the same or more specific prefix than the peered virtual network's address space.
- Connectivity to the peered virtual network works intermittently or has higher latency than expected. Traffic goes through the on-premises path.

### Solution: Identify and resolve BGP route conflicts

1. To identify conflicting routes, check the effective routes on the affected VM's network interface. Use Azure CLI to run the following command:

   ```azurecli
   az network nic show-effective-route-table \
     --resource-group <resource-group> \
     --name <nic-name> \
     --output table
   ```

2. Look for routes where the address prefix overlaps with the peered virtual network's address space. Compare the next hop type column:

   - **Virtual network peering** routes are system routes that are added by the peering.
   - **VirtualNetworkGateway** routes are learned from BGP.
   - **User** routes are UDRs from an associated route table.

3. If traffic is routed incorrectly, consider the following approaches:

   - **Remove conflicting UDRs**: If a user-defined route overrides the peering route, remove or modify the UDR. System peering routes already take precedence over BGP routes, so you don't need a UDR to maintain peering connectivity. Review the route table that's associated with the subnet. Remove any UDR that inadvertently directs peering traffic to a gateway or virtual appliance. You can't specify **Virtual network peering** as the next hop type in a UDR.
   - **Filter the BGP advertisement**: On the on-premises router, stop advertising the address range that overlaps with the peered virtual network's address space. Although system peering routes take precedence over BGP, removing unnecessary overlapping advertisements simplifies routing and troubleshooting.
   - **Redesign the address space**: Plan an address space migration to eliminate the conflict if the overlap exists because on-premises and a peered virtual network share the same address range.

4. Verify the routes that are learned by the virtual network gateway. Use Azure CLI to run the following command:

   ```azurecli
   az network vnet-gateway list-learned-routes \
     --resource-group <resource-group> \
     --name <gateway-name> \
     --output table
   ```

   To identify overlaps, compare these learned routes against the peered virtual network address spaces.

## Cause 5: Peering state desynchronization in multi-peering topologies

In complex topologies that include multiple peered virtual networks (such as hub-spoke that has multiple spokes or mesh topologies), individual peering connections can become desynchronized. This scenario is common if you apply address space changes to the hub but don't sync them to all spoke peerings.

### Symptoms

- Some spoke virtual networks can communicate with the hub, but others can't.
- Routes for the hub virtual network appear in some spokes but are missing in others.
- After an address space change on the hub, some peerings show the updated address space and others show the old address space.

### Solution: Audit and sync all peering connections

1. List all peerings for the hub virtual network, and check their sync status. Use Azure CLI to run the following command:

   ```azurecli
   az network vnet peering list \
     --resource-group <resource-group> \
     --vnet-name <hub-vnet-name> \
     --query "[].{Name:name, State:peeringState, RemoteAddressSpace:remoteAddressSpace.addressPrefixes, PeeringSyncLevel:peeringSyncLevel}" \
     --output table
   ```

2. Identify peerings for which the `PeeringSyncLevel` isn't **FullyInSync** or where the remote address space doesn't match the expected values.

3. Use Azure CLI to sync each out-of-sync peering:

   ```azurecli
   az network vnet peering sync \
     --resource-group <resource-group> \
     --vnet-name <hub-vnet-name> \
     --name <peering-name>
   ```

4. To verify that the peering to the hub also shows the correct address space, repeat the check on each spoke virtual network.

5. For large environments that have many peerings, use a script in Azure CLI to automate the audit:

   ```azurecli
   # List all peerings that need syncing
   az network vnet peering list \
     --resource-group <resource-group> \
     --vnet-name <hub-vnet-name> \
     --query "[?peeringSyncLevel!='FullyInSync'].{Name:name, SyncLevel:peeringSyncLevel}" \
     --output table
   ```

## Monitor peering health by using Azure Monitor

Proactive monitoring helps you detect peering problems before they affect connectivity. Azure Monitor provides metrics and alerts for virtual network peering.

### Available peering metrics

| Metric | Description |
|---|---|
| **Round trip time for pings to a VM** (`PingMeshAverageRoundtripMs`) | Average round trip time for pings sent between VMs, including VMs in peered virtual networks. A sudden increase can indicate peering connectivity problems. |
| **Failed pings to a VM** (`PingMeshProbesFailedPercent`) | Percentage of failed pings to a destination VM. A spike can indicate that peering routes are missing or that traffic is blocked. |

> [!NOTE]
> The peering state (**Connected**, **Disconnected**, or **Initiated**) is a resource property, not an Azure Monitor metric. To check the peering state, use `az network vnet peering show` or view the peering details in the Azure portal (**Settings** > **Peerings**).

### Set up alerts for peering problems

1. In the Azure portal, go to your virtual network.
2. Select **Monitoring** > **Metrics**.
3. Select the **Failed Pings to a VM** or **Round trip time for Pings to a VM** metric, and review the traffic pattern.
4. To create an alert for sudden traffic drops:
   1. Select **New alert rule**.
   2. Set the condition to trigger when **Failed Pings to a VM** (`PingMeshProbesFailedPercent`) exceeds a threshold that indicates a connectivity failure, or when **Round trip time for Pings to a VM** (`PingMeshAverageRoundtripMs`) exceeds an acceptable latency.
   3. Configure the action group to notify your operations team.

### Use Azure Network Watcher for peering diagnostics

[Azure Network Watcher](/azure/network-watcher/network-watcher-monitoring-overview) provides tools to diagnose peering connectivity, including the following features:

- **[Connection troubleshoot](/azure/network-watcher/network-watcher-connectivity-overview)**: Test connectivity between VMs in peered virtual networks, and identify where the connection fails (NSG, UDR, or routing problem).
- **[Next hop](/azure/network-watcher/network-watcher-next-hop-overview)**: Verify the next hop for traffic between VMs in peered virtual networks. This check confirms whether traffic uses the peering route or is redirected by a UDR.
- **[Effective routes](/azure/virtual-network/diagnose-network-routing-problem)**: View the effective routes on a network interface to verify that peering routes are present and aren't overridden.
- **[IP flow verify](/azure/network-watcher/network-watcher-ip-flow-verify-overview)**: Check whether NSG rules are blocking traffic between peered virtual networks.

## Next steps

- [Troubleshoot virtual network peering problems](virtual-network-troubleshoot-peering-issues.md)
- [Virtual network peering overview](/azure/virtual-network/virtual-network-peering-overview)
- [Update the address space for a peered virtual network](/azure/virtual-network/update-virtual-network-peering-address-space)
- [Diagnose a virtual machine routing problem](/azure/virtual-network/diagnose-network-routing-problem)
- [Network Watcher overview](/azure/network-watcher/network-watcher-monitoring-overview)
