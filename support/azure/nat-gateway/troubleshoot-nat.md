---
title: Troubleshoot Azure NAT Gateway
titleSuffix: Azure NAT Gateway
description: Troubleshoot Azure NAT Gateway configuration, deployment, and connectivity issues. Learn how to fix common errors and restore outbound internet access today.
services: virtual-network
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.reviewer: malaikanazim
ms.service: azure-nat-gateway
ms.topic: troubleshooting
ms.date: 11/11/2026
ms.customs: sap:Connectivity,references_regions
# Customer intent: "As a network engineer, I want to troubleshoot configuration and connectivity issues with the NAT gateway, so that I can ensure reliable outbound internet access for my virtual network resources."
ai-usage: ai-assisted
---

# Troubleshoot Azure NAT Gateway

## Summary

This article provides guidance on how to correctly configure your NAT gateway and troubleshoot common configuration and deployment related issues.  

- [Add or remove NAT gateway](#add-or-remove-nat-gateway) 

- [Add or remove subnet](#add-or-remove-subnet) 

- [Add or remove public IPs](#add-or-remove-public-ip-addresses)

## NAT gateway configuration basics

Check these settings to enable outbound traffic through a NAT gateway.

### Standard NAT gateway 

- NAT gateway has at least one public IP address or one public IP prefix attached. It must have at least one public IP address associated to provide outbound connectivity. 

- At least one subnet is attached to a NAT gateway. You can attach multiple subnets to a NAT gateway for going outbound, but those subnets must exist within the same virtual network. NAT gateway can't span beyond a single virtual network. 

- No [Network Security Group (NSG) rules](/azure/virtual-network/network-security-groups-overview#outbound) or User Defined Routes (UDR) block NAT gateway from directing traffic outbound to the internet.

### StandardV2 NAT gateway

- At least one public IP address or one public IP prefix is attached to NAT gateway. At least one public IP address must be associated with the NAT gateway for it to provide outbound connectivity.

- NAT gateway has at least one subnet attached. You can attach multiple subnets to a NAT gateway for outbound connectivity, but those subnets must exist within the same virtual network. NAT gateway can't span beyond a single virtual network. 

- No [Network Security Group (NSG) rules](/azure/virtual-network/network-security-groups-overview#outbound) or User Defined Routes (UDR) are blocking NAT gateway from directing traffic outbound to the internet.

### StandardV2 NAT gateway availability

StandardV2 NAT Gateway isn't available in the following Azure regions: 
- Canada East
- Sweden South
- West India

### Validate NAT gateway connectivity

[NAT gateway](/azure/nat-gateway/nat-overview#azure-nat-gateway-basics) supports User Datagram Protocol (UDP), Transmission Control Protocol (TCP), and Internet Control Message Protocol (ICMP) Echo Request and Echo Reply.

> [!NOTE]
> Azure StandardV2 NAT Gateway supports outbound ICMP Echo Request and Echo Reply traffic (ping) for IPv4 and IPv6 scenarios. Other ICMP message types aren't supported. 

 #### Validate outbound connectivity by using ICMP (ping)

To validate basic outbound connectivity, run an ICMP ping from a workload deployed in a subnet associated with the StandardV2 NAT gateway:

1. Connect to the workload (for example, a virtual machine).

1. Run the following command: `ping 8.8.8.8`

1. Review the result:

  * If the ping succeeds: Outbound connectivity through the NAT gateway is functioning as expected.
    
    ```bash
    azureuser@vm-1:~$ ping 8.8.8.8
    PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
    64 bytes from 8.8.8.8: icmp_seq=1 ttl=115 time=7.87 ms
    64 bytes from 8.8.8.8: icmp_seq=2 ttl=115 time=5.67 ms
    64 bytes from 8.8.8.8: icmp_seq=3 ttl=115 time=5.64 ms
    
    --- 8.8.8.8 ping statistics ---
    3 packets transmitted, 3 received, 0% packet loss
    ```

  * If the ping times out:
      * Subnet isn't associated with a NAT gateway
      * Outbound ICMP is blocked by NSG
      * Routing issues
      * Upstream firewall restrictions

For more information about ICMP support in Azure StandardV2 NAT Gateway, see [ICMP Support for Azure StandardV2 NAT Gateway](https://aka.ms/nat-icmp).

To validate end-to-end connectivity of NAT gateway, follow these steps: 

1. Validate outbound connectivity for StandardV2 NAT Gateway by using ICMP Echo Request and Echo Reply (ping) from a workload deployed in a subnet associated with the NAT gateway.

1. Validate that your [NAT gateway public IP address is being used](/azure/nat-gateway/quickstart-create-nat-gateway-portal#test-nat-gateway).

1. Conduct TCP connection tests and UDP-specific application layer tests.

1. Review NSG flow logs to analyze outbound traffic flows from NAT gateway.

Refer to the following table for tools to use to validate NAT gateway connectivity.

| Operating system | ICMP validation | Generic TCP connection test | TCP application layer test | UDP |
|---|---|---|---|---|
| Linux | `ping` | `nc` (generic connection test) | `curl` (TCP application layer test) | application specific |
| Windows | `ping` | [PsPing](/sysinternals/downloads/psping) | PowerShell [Invoke-WebRequest](/powershell/module/microsoft.powershell.utility/invoke-webrequest) | application specific |

### Analyze outbound connectivity with NAT gateway

To analyze outbound traffic from Standard NAT gateway, use virtual network (VNet) flow logs. VNet flow logs provide connection information for your virtual machines. The connection information contains the source IP and port, the destination IP and port, and the state of the connection. The logs also include the traffic flow direction and the size of the traffic in number of packets and bytes sent. The source IP and port specified in the VNet flow log is for the virtual machine and not the NAT gateway.

* To learn more about VNet flow logs, see [Virtual network flow logs overview](/azure/network-watcher/vnet-flow-logs-overview).

* For guides on how to enable VNet flow logs, see [Manage virtual network flow logs](/azure/network-watcher/vnet-flow-logs-portal).

* Access log data on [Log Analytics workspaces](/azure/azure-monitor/logs/log-analytics-overview) to query and filter the data for outbound traffic. To learn more about using Log Analytics, see [Log Analytics tutorial](/azure/azure-monitor/logs/log-analytics-tutorial).

* For more information on the VNet flow log schema, see [Traffic analytics schema and data aggregation](/azure/network-watcher/traffic-analytics-schema).

StandardV2 NAT Gateway supports NAT gateway flow logs through Azure Monitor. NAT gateway flow logs provide visibility into the traffic flowing through the NAT Gateway. For more information, see [Analyze NAT Gateway traffic with flow logs](/azure/nat-gateway/nat-gateway-flow-logs).

## Configure Azure RBAC permissions for NAT gateway updates

Before updating an existing NAT gateway, verify that the identity performing the operation has the applicable Azure RBAC permissions on every affected resource. These permissions apply when you:

- Update a NAT gateway.
  
- Associate a public IP address or public IP prefix.
  
- Associate the NAT gateway with a virtual network subnet.

### Permissions by resource

| **Permission** | **Required scope** | **Purpose** |
|----|----|----|
| `Microsoft.Network/natGateways/write` | NAT gateway | Creates or updates the NAT gateway configuration. |
| `Microsoft.Network/publicIPAddresses/join/action` | Public IP address | Creates or updates the NAT gateway configuration. |
| `Microsoft.Network/publicIPPrefixes/join/action` | Public IP prefix | Associates a public IP prefix with the NAT gateway. |
| `Microsoft.Network/virtualNetworks/write` | Virtual network | Updates the subnet configuration stored on the virtual network. |
| `Microsoft.Network/virtualNetworks/subnets/write` | Subnet | Updates the subnet configuration stored on the virtual network. |
| `Microsoft.Network/virtualNetworks/subnets/write` | NAT gateway | Allows a subnet to use the NAT gateway.  |

> [!NOTE]
> To locate or inspect resources in the Azure portal, grant Reader access or the corresponding read permissions in addition to the four required actions. 
   
### Option 1: Assign Network Contributor

The simplest supported approach is to assign the built-in Network Contributor role. This role includes `Microsoft.Network/*` and therefore covers the required write and join actions. Assign it at the narrowest scope that includes all affected resources. 

> [!IMPORTANT]
> Assigning a role requires `Microsoft.Authorization/roleAssignments/write`, available through roles such as Role Based Access Control Administrator or User Access Administrator.

# [**Azure portal**](#tab/manage-nat-portal)

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the Azure portal, open the resource group containing the NAT gateway, public IP address, and virtual network.
   
1. Select **Access control (IAM)**. 

1. Select **Add**, and then select **Add role assignment**. 

1. Select the **Network Contributor** role. 

1. Select the user, group, service principal, or managed identity that performs the operation. 

1. Select **Review + assign**.

> [!IMPORTANT]
> If the resources are in different resource groups, assign the role at each relevant resource group or directly on each resource. Subscription-level assignment also works but grants substantially broader access and isn't preferred unless operationally necessary.

---

> [!NOTE]
> Azure role changes can take several minutes to propagate. Retry the operation after the assignment becomes effective.

### Option 2: Create a least-privilege custom role

If Network Contributor grants more access than desired, create a custom role containing only the six required actions. The following definition can be imported through the Azure portal custom-role editor. Replace `<subscription-id>` with the applicable subscription ID.

> [!IMPORTANT]
> Creating a custom role requires appropriate administrative access, such as Owner or User Access Administrator.

# [**Azure portal**](#tab/manage-nat-portal)

**Create and assign the custom role**

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Open the subscription in the Azure portal and select Access control (IAM). 

1. Select Add, and then select Add custom role. 

1. Choose Start from JSON and upload the role definition.

```json
{ 
  "properties": { 
    "roleName": "NAT Gateway Association Operator", 
    "description": "Allows an identity to update a NAT Gateway, associate Public IP addresses or prefixes, and attach the NAT Gateway to virtual network subnets.", 
    "assignableScopes": [ 
      "/subscriptions/<subscription-id>" 
    ], 
    "permissions": [ 
      { 
        "actions": [ 
          "Microsoft.Network/natGateways/write", 
          "Microsoft.Network/publicIPAddresses/join/action", 
          "Microsoft.Network/publicIPPrefixes/join/action", 
          "Microsoft.Network/virtualNetworks/write", 
          "Microsoft.Network/virtualNetworks/subnets/write", 
          "Microsoft.Network/natGateways/join/action" 
        ], 
        "notActions": [], 
        "dataActions": [], 
        "notDataActions": [] 
      } 
    ] 
  } 
} 
```

1. Review the permissions and assignable scope, and then create the role. 

1. Assign the role to the deployment identity at the narrowest scope covering the NAT Gateway, Public IP address, and virtual network.

> [!IMPORTANT]
> Assigning a role requires `Microsoft.Authorization/roleAssignments/write`, available through roles such as Role Based Access Control Administrator or User Access Administrator.

---

### Scope and administrative considerations

- NAT Gateway scope: `Microsoft.Network/natGateways/write` and `Microsoft.Network/natGateways/join/action` must be effective on the NAT Gateway. 

- Public IP scope: `Microsoft.Network/publicIPAddresses/join/action` must be effective on every Public IP address being associated. 

- Public IP Prefix scope: `Microsoft.Network/publicIPPrefixes/join/action` must be effective on every Public IP Prefix being associated. 

- Virtual network scope: `Microsoft.Network/virtualNetworks/write` must be effective on the virtual network containing the target subnet. 

- Subnet scope: `Microsoft.Network/virtualNetworks/subnets/write` must be effective when the operation updates the subnet as a child resource by setting `properties.natGateway.id`. 

- If one resource group contains all resources, a single resource-group assignment is usually the clearest option. 

- If resources are distributed across resource groups, assign the role at each applicable resource group or resource. Avoid subscription scope unless necessary. 

## NAT gateway in a failed state

You can experience outbound connectivity failure if your NAT gateway resource is in a failed state. To get your NAT gateway out of a failed state, follow these instructions:

1. Identify the resource that is in a failed state. Go to [Azure Resource Explorer](https://resources.azure.com/) and identify the resource in this state. 

1. Update the toggle on the right-hand top corner to Read/Write. 

1. Select **Edit** for the resource in failed state.

1. Select **PUT** followed by **GET** to ensure the provisioning state was updated to **Succeeded**.

## Virtual network or NAT gateway in a failed state with StandardV2 NAT gateway

If you associate a StandardV2 NAT Gateway to an empty subnet that you created before April 2025 and that doesn't contain any virtual machines, either the virtual network or the NAT gateway might go into a failed state. To resolve the issue, follow these steps:
1. Remove the StandardV2 NAT gateway from the subnet or virtual network.
1. Create a virtual machine in the subnet.
1. Reattach the StandardV2 NAT gateway to the subnet or virtual network.

## Add or remove NAT gateway 

### Can't delete NAT gateway

You must detach the NAT gateway from all subnets within a virtual network before you can remove or delete the resource. For step-by-step guidance, see [Remove NAT gateway from an existing subnet and delete the resource](/azure/nat-gateway/manage-nat-gateway?tabs=manage-nat-portal#remove-a-nat-gateway-from-an-existing-subnet-and-delete-the-resource).

## Add or remove subnet 

### Can't attach NAT gateway to subnet already attached to another NAT gateway 

You can't attach more than one NAT gateway to a subnet within a virtual network for connecting outbound to the internet. You can associate an individual NAT gateway resource to multiple subnets within the same virtual network. A NAT gateway can't span beyond a single virtual network. 

### Basic resources can't exist in the same subnet as NAT gateway

NAT gateway isn't compatible with basic resources, such as Basic Load Balancer or Basic Public IP. You must place basic resources on a subnet that isn't associated with a NAT Gateway. You can upgrade Basic Load Balancer and Basic Public IP to standard to work with NAT gateway. 

- To upgrade a basic load balancer to standard, see [upgrade from basic public to standard public load balancer](/azure/load-balancer/upgrade-basic-standard).

- To upgrade a basic public IP to standard, see [upgrade from basic public to standard public IP](/azure/virtual-network/ip-services/public-ip-upgrade-portal).

- To upgrade a basic public IP with an attached virtual machine to standard, see [Upgrade public IP addresses attached to VM from Basic to Standard](/azure/virtual-network/ip-services/public-ip-upgrade-vm).

### NAT gateway can't be attached to a gateway subnet

You can't deploy a NAT gateway in a gateway subnet. A VPN gateway uses a gateway subnet to send encrypted traffic between an Azure virtual network and an on-premises location. To learn more about how VPN gateway uses gateway subnets, see [VPN gateway overview](/azure/vpn-gateway/vpn-gateway-about-vpngateways). To use a NAT gateway, attach it to any other subnet within the same virtual network.

### Can't attach NAT gateway to a subnet that contains a virtual machine network interface in a failed state

When you associate a NAT gateway to a subnet that contains a virtual machine network interface (network interface) in a failed state, you receive an error message indicating that you can't perform this action. You must first resolve the virtual machine network interface failed state before you can attach a NAT gateway to the subnet.

To get your virtual machine network interface out of a failed state, use one of the following methods. 

#### Use PowerShell to get your virtual machine network interface out of a failed state

1. Determine the provisioning state of your network interfaces by using the [Get-AzNetworkInterface PowerShell command](/powershell/module/az.network/get-aznetworkinterface#example-2-get-all-network-interfaces-with-a-specific-provisioning-state) and setting the value of the "provisioningState" to "Succeeded."

1. Perform [GET/SET PowerShell commands](/powershell/module/az.network/set-aznetworkinterface#example-1-configure-a-network-interface) on the network interface. The PowerShell commands update the provisioning state.

1. Check the results of this operation by checking the provisioning state of your network interfaces again (follow commands from step 1).

#### Use Azure Resource Explorer to get your virtual machine network interface out of a failed state 

1. Go to [Azure Resource Explorer](https://resources.azure.com/) (use Microsoft Edge browser). 

1. Expand **Subscriptions** (takes a few seconds to appear).

1. Expand your subscription that contains the virtual machine network interface in the failed state.

1. Expand **resourceGroups**.

1. Expand the resource group that contains the virtual machine network interface in the failed state.

1. Expand **providers**.

1. Expand **Microsoft.Network**. 

1. Expand **networkInterfaces**.

1. Select the network interface that's in the failed provisioning state.

1. Select the **Read/Write** button at the top.

1. Select the green **GET** button.

1. Select the blue **EDIT** button.

1. Select the green **PUT** button.

1. Select **Read Only** button at the top.

1. The virtual machine network interface is now in a succeeded provisioning state. You can close your browser.

## Add or remove public IP addresses

### Can't exceed 16 public IP addresses on Standard NAT gateway 

You can't associate a Standard SKU NAT gateway with more than 16 IPv4 public IP addresses. You can use any combination of public IP addresses and prefixes with NAT gateway up to a total of 16 IP addresses. To add or remove a public IP, see [add or remove a public IP address](/azure/virtual-network/nat-gateway/manage-nat-gateway?tabs=manage-nat-portal#add-or-remove-a-public-ip-address). 

You can use the following IP prefix sizes with NAT gateway: 

- /28 (16 addresses) 

- /29 (8 addresses) 

- /30 (4 addresses) 

- /31 (2 addresses) 

### IPv6 coexistence

Standard SKU [NAT gateway](/azure/nat-gateway/nat-overview) supports IPv4 UDP and TCP protocols. You can't associate a Standard SKU NAT gateway with an IPv6 Public IP address or IPv6 Public IP Prefix. 

### Can't add Standard SKU public IPs to StandardV2 SKU NAT Gateway
Standard SKU public IPs aren't supported with StandardV2 SKU NAT Gateway. You can add only StandardV2 SKU public IPs to StandardV2 NAT Gateway.  

### Can't add StandardV2 SKU public IPs to Standard SKU NAT Gateway
StandardV2 SKU public IPs aren't supported with Standard SKU NAT Gateway or any other Azure resources. You can add only Standard SKU public IPs to Standard NAT Gateway.

### Can't use basic public IPs with NAT gateway 

NAT gateway can't be used with basic resources, including basic public IP addresses. You can upgrade your basic public IP address in order to use with your NAT gateway using the following guidance: [Upgrade a public IP address.](/azure/virtual-network/ip-services/public-ip-upgrade-portal) 

### Can't use custom IP prefixes (BYOIP) with StandardV2 NAT Gateway
StandardV2 NAT Gateway doesn't support custom IP prefixes (BYOIP public IPs). It supports only StandardV2 SKU Azure public IPs.  

Custom IPs work with Standard NAT Gateway.

### Can't use public IPs with internet routing preference together with NAT gateway

When you configure NAT gateway with a public IP address, traffic routes through the [Microsoft network](/azure/virtual-network/ip-services/routing-preference-overview#routing-via-microsoft-global-network). You can't associate NAT gateway with public IPs that have the routing preference set to **Internet**. You can associate NAT gateway only with public IPs that have the routing preference set to **Microsoft Global Network**. For a list of all Azure services that support public IPs with the Internet routing preference, see [supported services](/azure/virtual-network/ip-services/routing-preference-overview#supported-services).

### Can't mismatch zones of public IP addresses and Standard NAT gateway 

You can designate Standard NAT gateway to a specific zone (a [zonal resource](/azure/reliability/reliability-nat-gateway)) or to "no zone." When you place NAT gateway in "no zone," Azure places the NAT gateway into a zone for you, but you don't have visibility into which zone the NAT gateway is located.  

You can use Standard NAT gateway with Standard public IP addresses designated to a specific zone, no zone, or all zones (zone-redundant) depending on its own availability zone configuration.

| NAT gateway availability zone designation | Public IP address or prefix designation that you can use |
|---|---|
| No zone | Zone-redundant, no zone, or zonal (the public IP zone designation can be any zone within a region to work with a no zone NAT gateway) |
| Designated to a specific zone | Zone-redundant or zonal public IPs |

> [!NOTE]
> To know the zone that your NAT gateway resides in, designate it to a specific availability zone. Or use a zone-redundant StandardV2 NAT gateway.

### Can't use DDoS protected public IPs with NAT gateway 

NAT gateway doesn't support public IP addresses with DDoS protection enabled. DDoS protected IPs are more critical for inbound traffic, since most DDoS attacks are designed to overwhelm the target's resources by flooding them with a large volume of incoming traffic. To learn more about DDoS protection, review the following articles:  
* [Azure DDoS Protection features](/azure/ddos-protection/ddos-protection-features)
* [Azure DDoS Protection best practices](/azure/ddos-protection/fundamental-best-practices)
* [Types of attacks Azure DDoS protection mitigates](/azure/ddos-protection/types-of-attacks)

## Default outbound access

### Virtual machine NICs still have default outbound IPs despite NAT gateway is present

A NIC-level parameter, `defaultOutboundConnectivityEnabled`, tracks if a default outbound IP is allocated to a virtual machine or virtual machine scale set instance.

In some cases, a default outbound IP is still assigned to virtual machines in a non-private subnet, even when you configure an explicit outbound method such as a NAT Gateway or a UDR directing traffic to an NVA or firewall. The virtual machines don't use default outbound IPs for egress unless you remove those explicit methods. To remove the default outbound IPs, make the subnet private and stop and deallocate the virtual machines.

## More troubleshooting guidance

If this article doesn't address the issue you're experiencing, refer to the following NAT gateway troubleshooting articles:

- [Troubleshoot outbound connectivity with NAT Gateway](/azure/nat-gateway/troubleshoot-nat-connectivity).

- [Troubleshoot outbound connectivity with NAT Gateway and other Azure services](/azure/nat-gateway/troubleshoot-nat-and-azure-services).

## Next steps

If you experience issues with NAT gateway that this article doesn't list or resolve, submit feedback through GitHub via the bottom of this page. We address your feedback as soon as possible to improve the experience of our customers.

To learn more about NAT gateway, see:

- [What is Azure NAT Gateway?](/azure/nat-gateway/nat-overview)

- [Azure NAT gateway resource](/azure/nat-gateway/nat-gateway-resource).

- [Manage a NAT gateway](/azure/nat-gateway/manage-nat-gateway).

- [Metrics and alerts for NAT gateway resources](/azure/nat-gateway/nat-metrics).

