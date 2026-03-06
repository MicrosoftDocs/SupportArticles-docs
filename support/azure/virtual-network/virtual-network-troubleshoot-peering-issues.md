---
title: Troubleshoot virtual network peering issues
description: Steps to help resolve most virtual network peering issues.
services: virtual-network
author: JarrettRenshaw
ms.author: jarrettr
manager: dcscontentpm
ms.assetid: 1a3d1e84-f793-41b4-aa04-774a7e8f7719
ms.service: azure-virtual-network
ms.topic: troubleshooting
ms.date: 03/05/2026
ms.custom: 
  - sfi-image-nochange
  - = sap:Connectivity
# Customer intent: As a network engineer, I want to troubleshoot virtual network peering issues, so that I can ensure proper connectivity between Azure virtual networks in both the same and different subscriptions or regions.
---

# Troubleshoot virtual network peering issues

## Summary

This troubleshooting guide provides steps to help you resolve most [virtual network peering](/azure/virtual-network/virtual-network-peering-overview) issues.

:::image type="content" source="media/virtual-network-troubleshoot-peering-issues/4489538-en-1.png" alt-text="Diagram of virtual network peering" lightbox="media/virtual-network-troubleshoot-peering-issues/4489538-en-1.png":::


## Configure virtual network peering between two virtual networks

Are the virtual networks in the same subscription or in different subscriptions?

### The virtual networks are in the same subscription

To configure virtual network peering for the virtual networks that are in the same subscription, use the methods in the following articles:

* If the virtual networks are in the *same region*, see [Create a peering](/azure/virtual-network/virtual-network-manage-peering#create-a-peering).
* If the virtual networks are in the *different regions*, see [Virtual network peering](/azure/virtual-network/virtual-network-peering-overview). 

> [!IMPORTANT]
> Azure Basic Load Balancer was [retired on September 30, 2025](/azure/load-balancer/load-balancer-basic-upgrade-guidance). Resources that used Basic internal load balancer SKUs don't work over global virtual network peering. If you haven't migrated yet, [upgrade to Standard Load Balancer](/azure/load-balancer/load-balancer-basic-upgrade-guidance). For more information about global peering constraints, see [requirements and constraints](/azure/virtual-network/virtual-network-peering-overview#requirements-and-constraints).

### The virtual networks are in different subscriptions or Active Directory tenants

To configure virtual network peering for virtual networks in different subscriptions or Active Directory tenants, see [Create a virtual network peering between different subscriptions](/azure/virtual-network/create-peering-different-subscriptions).

> [!Note]
> To configure network peering, you must have **Network Contributor** permissions in both subscriptions. For more information, see [Peering permissions](/azure/virtual-network/virtual-network-manage-peering#permissions).

## Configure virtual network peering with hub-spoke topology that uses on-premises resources

:::image type="content" source="media/virtual-network-troubleshoot-peering-issues/4488712-en-1a.png" alt-text="Diagram of virtual network peering with on-premises spoke" lightbox="media/virtual-network-troubleshoot-peering-issues/4488712-en-1a.png":::

### For a site-to-site connection or an ExpressRoute connection

Follow the steps in: [Configure VPN gateway transit for virtual network peering](/azure/vpn-gateway/vpn-gateway-peering-gateway-transit).

### For point-to-site connections

1. Follow the steps in: [Configure VPN gateway transit for virtual network peering](/azure/vpn-gateway/vpn-gateway-peering-gateway-transit).
2. After virtual network peering is established or changed, download and reinstall the point-to-site package so that the point-to-site clients get the updated routes to the spoke virtual network.

## Configure virtual network peering with hub-spoke topology virtual network

:::image type="content" source="media/virtual-network-troubleshoot-peering-issues/4488712-en-1b.png" alt-text="Diagram of virtual network peering with a virtual network spoke" lightbox="media/virtual-network-troubleshoot-peering-issues/4488712-en-1b.png":::

### The virtual networks are in the same region

1. In the hub virtual network, configure a network virtual appliance (NVA).
1. In the spoke virtual networks, have user-defined routes with the next hop type "network virtual appliance" applied.

For more information, see [Service chaining](/azure/virtual-network/virtual-network-peering-overview#service-chaining).

> [!Note]
> If you require help to set up an NVA, [contact the NVA vendor](https://mskb.pkisolutions.com/kb/2984655).

For help with troubleshooting the NVA device setup and routing, see [Network virtual appliance issues in Azure](/azure/virtual-network/virtual-network-troubleshoot-nva).

### The virtual networks are in different regions

Transit over global virtual network peering is now supported.

> [!IMPORTANT]
> Azure Basic Load Balancer was [retired on September 30, 2025](/azure/load-balancer/load-balancer-basic-upgrade-guidance). Resources that used Basic internal load balancer SKUs don't work over global virtual network peering. If you haven't migrated yet, [upgrade to Standard Load Balancer](/azure/load-balancer/load-balancer-basic-upgrade-guidance). For more information about global peering constraints, see [requirements and constraints](/azure/virtual-network/virtual-network-peering-overview#requirements-and-constraints).

## Troubleshoot a connectivity issue between two peered virtual networks

Sign in to the [Azure portal](https://portal.azure.com) with an account that has the necessary [roles and permissions](/azure/virtual-network/virtual-network-manage-peering#permissions). Select the virtual network, select **Peering**, and then check the **Status** field. What is the status?

### The peering status is "Connected"

To troubleshoot this issue:

1. Check the network traffic flows:

   Use [Connection Troubleshoot](/azure/network-watcher/network-watcher-connectivity-overview) and [IP flow verify](/azure/network-watcher/network-watcher-ip-flow-verify-overview) from the source VM to the destination VM to determine whether there is an NSG or UDR that is causing interference in traffic flows.

   If you're using a firewall or NVA: 
   1. Document the UDR parameters so that you can restore them after this step is complete.
   2. Remove the UDR from the source VM subnet or NIC that points to the NVA as the next hop. Verify connectivity from the source VM directly to the destination that is bypassing the NVA. If this step doesn't work, see the [NVA troubleshooter](/azure/virtual-network/virtual-network-troubleshoot-nva).
2. Take a network trace: 
   1. Start a network trace on the destination VM. For Windows, you can use **Netsh**. For Linux, use **TCPDump**.
   2. Run **TcpPing** or **PsPing** from the source to the destination IP.

      This is an example of a **TcpPing** command: `tcping64.exe -t <destination VM address> 3389`

   3. After the **TcpPing** is complete, stop the network trace on the destination.
   4. If packets arrive from the source, there is no networking issue. Examine both the VM firewall and the application listening on that port to locate the configuration issue.

   > [!IMPORTANT]
   > Azure Basic Load Balancer was [retired on September 30, 2025](/azure/load-balancer/load-balancer-basic-upgrade-guidance). Resources that used Basic internal load balancer SKUs don't work over global virtual network peering. If you haven't migrated yet, [upgrade to Standard Load Balancer](/azure/load-balancer/load-balancer-basic-upgrade-guidance). For more information about global peering constraints, see [requirements and constraints](/azure/virtual-network/virtual-network-peering-overview#requirements-and-constraints).

### The peering status is "Disconnected"

A **Disconnected** peering status means that one of the two peering links was deleted. Traffic can't flow between the virtual networks until peering is reestablished.

#### Common causes

- **Manual deletion**: A peering link was deleted from one side but not the other. When one link is removed, the remaining link transitions to **Disconnected**.
- **Address space changes**: If the address space of a peered virtual network was modified and the peering wasn't synced, the peering can enter a **Disconnected** state. For information about syncing after address space changes, see [Update the address space for a peered virtual network](/azure/virtual-network/update-virtual-network-peering-address-space).
- **Subscription or tenant changes**: Moving a virtual network to a different subscription or tenant can break existing peering connections.
- **Azure Policy enforcement**: An Azure Policy that restricts peering or network configurations might cause a peering to be removed or blocked.

#### Diagnose asymmetric peering states

The peering status can become asymmetric between the two virtual networks. For example, one side shows **Connected** while the other shows **Initiated** or **Disconnected**. To check the peering state on both sides:

1. In the [Azure portal](https://portal.azure.com), go to each virtual network and select **Peering**.
2. Compare the **Status** field for the peering on both sides.
3. To check via Azure CLI, run the following command for each virtual network:

   ```azurecli
   az network vnet peering show --resource-group <resource-group> --vnet-name <vnet-name> --name <peering-name> --query peeringState
   ```

The possible peering states are:

| State | Description |
|---|---|
| **Initiated** | Only the first peering link was created. Create the peering from the second virtual network to complete the connection. |
| **Connected** | Both peering links exist and traffic can flow. |
| **Disconnected** | One peering link was deleted. Both links must be deleted and re-created. |

#### Resolution

1. Delete the remaining peering link from both virtual networks. In the Azure portal, go to each virtual network, select **Peering**, and delete the peering entry.

   To delete via Azure CLI:

   ```azurecli
   az network vnet peering delete --resource-group <resource-group> --vnet-name <vnet-name> --name <peering-name>
   ```

2. Re-create the peering from both virtual networks. Ensure that the correct settings for **Allow forwarded traffic**, **Allow gateway transit**, and **Use remote gateways** are configured on each side.

3. Verify that the peering status shows **Connected** on both sides after re-creation.

> [!NOTE]
> You can't re-create a peering while one side is in a **Disconnected** state. You must delete the peering from both virtual networks first, and then create new peering links.

## Troubleshoot a connectivity issue between a hub-spoke virtual network and an on-premises resource

Does your network use a third-party NVA or VPN gateway?

### My network uses a third-party NVA or VPN gateway

To troubleshoot connectivity issues that affect a third-party NVA or VPN gateway, see the following articles:

* [NVA troubleshooter](/azure/virtual-network/virtual-network-troubleshoot-nva)
* [Service chaining](/azure/virtual-network/virtual-network-peering-overview#service-chaining)

### My network does not use a third-party NVA or VPN gateway

Do the hub virtual network and the spoke virtual network have a VPN gateway?

#### Both the hub virtual network and the spoke virtual network have a VPN gateway

Using a remote gateway isn't supported.

If the spoke virtual network already has a VPN gateway, the **Use remote gateway** option isn't supported on the spoke virtual network. This is because of a virtual network peering limitation.

#### Both the hub virtual network and the spoke virtual network do not have a VPN gateway

For site-to-site or Azure ExpressRoute connections, check the following primary causes of connectivity issues to the remote virtual network from on-premises:

* On the virtual network that has a gateway, verify that the **Allow forwarded traffic** check box is selected.
* On the virtual network that doesn't have a gateway, verify that the **Use remote gateway** check box is selected.
* Have your network administrator check your on-premises devices to verify that they all have the remote virtual network address space added.

For point-to-site connections:

* On the virtual network that has a gateway, verify that the **Allow forwarded traffic** check box is selected.
* On the virtual network that doesn't have a gateway, verify that the **Use remote gateway** check box is selected.
* Download and reinstall the point-to-site client package. Virtual network routes that are newly peered don't automatically add routes to point-to-site clients.

## Troubleshoot peering sync failures

When you modify the address space of a peered virtual network, you must sync the peering for each remote peered virtual network to pick up the changes. If the sync isn't performed, traffic might not route correctly between the peered virtual networks.

### Verify peering state on both sides

1. In the [Azure portal](https://portal.azure.com), go to each virtual network and select **Peering**. Verify that the **Status** shows **Connected** for both sides.

2. To check the peering state and address prefixes via Azure CLI:

   ```azurecli
   az network vnet peering show \
     --resource-group <resource-group> \
     --vnet-name <vnet-name> \
     --name <peering-name> \
     --query "{state:peeringState, remoteAddressSpace:remoteAddressSpace.addressPrefixes}"
   ```

3. To check via Azure PowerShell:

   ```azurepowershell
   Get-AzVirtualNetworkPeering -ResourceGroupName <resource-group> -VirtualNetworkName <vnet-name> | Select-Object Name, PeeringState, RemoteVirtualNetworkAddressSpace
   ```

### Common sync issues

| Issue | Symptom | Resolution |
|---|---|---|
| Address space not updated after resize | Peered virtual network doesn't reflect modified address ranges. Routes for the new address space are missing. | In the Azure portal, go to the virtual network, select **Peering**, select the peering, and then select **Sync**. Repeat for each remote peer. For more information, see [Update the address space for a peered virtual network](/azure/virtual-network/update-virtual-network-peering-address-space). |
| Peering state stuck on "Initiated" | Only one peering link was created. The second virtual network doesn't have a corresponding peering. | Create the peering from the second virtual network to the first. Both links are required for the status to change to **Connected**. |
| Routes not propagating after new peering | The effective routes on VMs in the virtual network don't show the peered virtual network's address space. | Wait a few minutes for Azure to propagate the routes. Then check the effective routes on a network interface. See [Diagnose a virtual machine routing problem](/azure/virtual-network/diagnose-network-routing-problem). |
| Peering sync fails across tenants | Sync operation fails or address changes aren't visible to the remote peer in a different tenant. | Ensure that the account performing the sync has the required permissions in both tenants. For cross-tenant peering, see [Create a virtual network peering between different subscriptions](/azure/virtual-network/create-peering-different-subscriptions). |

### Sync the peering after address space changes

After you add, modify, or delete address ranges in a peered virtual network, sync the peering:

1. In the Azure portal, go to the virtual network where the address space was changed.
2. Select **Peering**, and then select the checkbox for the peering connection.
3. Select **Sync**.
4. Repeat for each remote peered virtual network.

To sync via Azure CLI:

```azurecli
az network vnet peering sync --resource-group <resource-group> --vnet-name <vnet-name> --name <peering-name>
```

> [!IMPORTANT]
> Run the sync operation after every resize address space change, rather than batching multiple resize operations before syncing. Address space sync isn't supported when the virtual network is peered with a classic virtual network.

## Troubleshoot route table conflicts across peered virtual networks

User-defined routes (UDRs) can override the default system routes that Azure creates for peered virtual networks. This override can cause asymmetric routing or dropped traffic in hub-spoke topologies.

### How UDRs interact with peering routes

When you create a virtual network peering, Azure automatically adds system routes with the next hop type **VNet peering** for each address space in the peered virtual network. If a UDR in a route table has the same address prefix as a peering route, the UDR takes precedence and overrides the peering system route. This behavior can cause traffic to be routed to an NVA or dropped instead of flowing directly to the peered virtual network.

For more information about route selection priority, see [How Azure selects a route](/azure/virtual-network/virtual-networks-udr-overview#how-azure-selects-a-route).

### Diagnose asymmetric routing in hub-spoke topologies

In hub-spoke topologies where an NVA in the hub inspects traffic, UDRs in the spoke subnets typically route traffic through the NVA. If the return path from the destination doesn't follow the same route through the NVA, this creates asymmetric routing that can cause connection failures.

To diagnose asymmetric routing:

1. Check the effective routes on the network interface of a VM in the spoke subnet:
   - In the Azure portal, go to the VM, select **Networking**, select the network interface, and then select **Effective routes**.
   - Look for routes with the next hop type **VNet peering** and compare them with any UDR entries that might override them.

2. To view effective routes via Azure CLI:

   ```azurecli
   az network nic show-effective-route-table --resource-group <resource-group> --name <nic-name> --output table
   ```

3. Verify that UDRs in both the source and destination subnets create a symmetric path through the NVA. If the NVA only sees traffic in one direction, the stateful firewall might drop the return traffic.

### Common route table conflict scenarios

| Scenario | Symptom | Resolution |
|---|---|---|
| UDR overrides peering route | Traffic to a peered virtual network is sent to an NVA or dropped instead of flowing directly to the peer. | Review the route table associated with the subnet. Remove or adjust the UDR that conflicts with the peering address space. |
| Missing UDR for return traffic | Traffic flows to the destination through an NVA, but the return traffic bypasses the NVA, causing the connection to fail. | Add a UDR to the destination subnet that routes return traffic back through the same NVA. |
| BGP route overrides peering route | A BGP route advertised from an on-premises network overlaps with a peered virtual network address space. | Check the BGP routes learned by the virtual network gateway. Adjust the on-premises advertisement or use a more specific UDR to direct traffic correctly. |

> [!TIP]
> Use Network Watcher [next hop](/azure/network-watcher/network-watcher-next-hop-overview) to verify the next hop for a specific traffic flow between VMs in peered virtual networks. This helps you confirm whether a UDR is overriding the expected peering route.

## Troubleshoot overlapping address spaces in peered virtual networks

Azure doesn't allow virtual network peering between two virtual networks that have overlapping address spaces. If you attempt to create a peering with overlapping CIDR ranges, the operation fails.

### Common error messages

When you try to create a peering with overlapping address spaces, you might see errors such as:

- *"Virtual network address space \<address-space\> overlaps with the address space of the already peered virtual network."*
- *"Cannot create or update peering because address space of virtual networks overlap."*

### Identify overlapping CIDR ranges

To identify overlapping address spaces:

1. In the Azure portal, go to each virtual network and select **Address space** under **Settings**.
2. Compare the address ranges between the two virtual networks to find any CIDR ranges that overlap.
3. To list address spaces via Azure CLI:

   ```azurecli
   az network vnet show --resource-group <resource-group> --name <vnet-name> --query "addressSpace.addressPrefixes"
   ```

Two CIDR ranges overlap if any portion of the IP address ranges intersects. For example, `10.0.0.0/16` and `10.0.1.0/24` overlap because `10.0.1.0/24` is a subset of `10.0.0.0/16`.

### Resolution

To resolve overlapping address spaces, choose one of the following approaches:

- **Resize one of the virtual networks**: Remove or modify the overlapping address range so that the two virtual networks don't share any CIDR ranges. For more information, see [Update the address space for a peered virtual network](/azure/virtual-network/update-virtual-network-peering-address-space).

  > [!IMPORTANT]
  > Before removing an address range, ensure that no subnets or resources are deployed within that range.

- **Use Azure Virtual Network Manager**: If you manage multiple peered virtual networks, use [Azure Virtual Network Manager](/azure/virtual-network-manager/overview) with the `ConnectedGroupAddressOverlap` property set to **Disallowed** to prevent overlapping address spaces in mesh topologies.

- **Plan address spaces before peering**: Review the address allocation of all virtual networks involved before establishing peering. Use a centralized IP address management (IPAM) solution to avoid future conflicts.

## Troubleshoot a hub-spoke network connectivity issue between spoke virtual networks in the same region

A hub network must include an NVA. Configure UDRs in spokes that have an NVA set as the next hop, and enable **Allow forwarded traffic** in the hub virtual network.

For more information, see [Service chaining](/azure/virtual-network/virtual-network-peering-overview#service-chaining), and discuss these requirements with the [NVA vendor](https://mskb.pkisolutions.com/kb/2984655) of your choice.

## Troubleshoot a hub-spoke network connectivity issue between spoke virtual networks in different regions

Transit over global virtual network peering is now supported.

> [!IMPORTANT]
> Azure Basic Load Balancer was [retired on September 30, 2025](/azure/load-balancer/load-balancer-basic-upgrade-guidance). Resources that used Basic internal load balancer SKUs don't work over global virtual network peering. If you haven't migrated yet, [upgrade to Standard Load Balancer](/azure/load-balancer/load-balancer-basic-upgrade-guidance). For more information about global peering constraints, see [requirements and constraints](/azure/virtual-network/virtual-network-peering-overview#requirements-and-constraints).

For more information, see [Different VPN Topologies](/archive/blogs/igorpag/hubspoke-daisy-chain-and-full-mesh-vnet-topologies-in-azure-arm-v2).

## Troubleshoot a hub-spoke network connectivity issue between a web app and the spoke virtual network

To troubleshoot this issue:

1. Sign in to the Azure portal. 
1. In the web app, select **networking**, and then select **VNet Integration**.
1. Check whether you can see the remote virtual network. Manually enter the remote virtual network address space (**Sync Network** and **Add Routes**).

For more information, see the following articles:

* [Integrate your app with an Azure virtual network](/azure/app-service/overview-vnet-integration)
* [About Point-to-Site VPN routing](/azure/vpn-gateway/vpn-gateway-about-point-to-site-routing)

## Troubleshoot a virtual network peering configuration error message 

### Current tenant `<TENANT ID>` isn't authorized to access linked subscription

To resolve this issue, see [Create a virtual network peering between different subscriptions](/azure/virtual-network/create-peering-different-subscriptions).

### Not connected

To resolve this issue, delete the peering from both virtual networks, and then recreate them.

### Failed to peer a Databricks virtual network

To resolve this issue, configure the virtual network peering under **Azure Databricks**, and then specify the target virtual network by using **Resource ID**. For more information, see [Peer a Databricks virtual network to a remote virtual network](/azure/databricks/administration-guide/cloud-configurations/azure/vnet-peering#id2).

### The remote virtual network lacks a gateway

This issue occurs when you peer virtual networks from different tenants and later want to configure `Use Remote Gateways`. A limitation of the Azure portal is that it can't validate the presence of a virtual network gateway in another tenant's virtual network.

There are two ways to resolve the issue:

 * Delete the peerings and activate the `Use Remote Gateways` option when you create a new peering.
 * Use PowerShell or CLI, instead of the Azure portal, to enable `Use Remote Gateways`.

## Next steps

* [Troubleshooting connectivity problems between Azure VMs](/azure/virtual-network/virtual-network-troubleshoot-connectivity-problem-between-vms)
* [Network Watcher overview](/azure/network-watcher/network-watcher-monitoring-overview) - Use Connection Troubleshoot, IP flow verify, next hop, and effective routes to diagnose peering connectivity issues.