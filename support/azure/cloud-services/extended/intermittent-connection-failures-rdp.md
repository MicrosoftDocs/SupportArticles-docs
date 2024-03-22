---
title: Intermittent connection failures using Remote Desktop Protocol
description: Resolve intermittent failures to connect to Azure Cloud Services (extended support) when you use the Remote Desktop Protocol (RDP).
ms.date: 09/26/2022
editor: v-jsitser
ms.reviewer: v-maallu, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-extended-support
#Customer intent: As an Azure Cloud Services administrator, I want to be able to prevent intermittent failures that occur when I use Remote Desktop Protocol (RDP) so that my customers can connect to my cloud services apps without experiencing connection problems.
---

# Intermittent connection failures when using Remote Desktop Protocol

This article discusses intermittent failures that occur when you try to connect to an Azure Cloud Services (extended support) application by using Remote Desktop Protocol (RDP).

## Symptoms

When you use RDP to try to connect to Azure Cloud Services (extended support), you occasionally receive the following error message:

> Remote Desktop Connection
>
> This computer can't connect to the remote computer.
>
> Try connecting again. If the problem continues, contact the owner of the remote computer or your network administrator.

## Background

The RDP session connects to the load balancer of the tenant. The load balancer can then connect to a target role instance by using either of the following methods:

- Directly through port 3389

- Through port 3389 to an intermediate role instance that then forwards the RDP request through port 20000 to the target role instance

## Cause

For Azure Cloud Services (extended support), network security group (NSG) inbound rules are configured to allow only inbound communication through port 3389. Those rules don't allow communication between the role instances through port 20000. Because of this situation, RDP communication will succeed if the load balancer routes traffic through the first method. However, it will fail if the load balancer tries to route traffic through the second method. For more information, see [NSG intra-subnet traffic](/azure/virtual-network/network-security-group-how-it-works#intra-subnet-traffic).

To view the NSG inbound rules, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Network security groups**.

1. In the list of network security groups, select the name of your NSG.

1. In the menu pane for your NSG, select **Inbound security rules**.

The following table contains a sample list of inbound rules for your cloud service-connected NSG that cause the intermittent RDP connection failures. The **AllowLocalRDP** rule has a priority number of 300. (A smaller priority number indicates greater importance.) This rule opens ports 3389 and 20000 to your local IP addresses. The **DenyAll** rule doesn't allow internal communication between different role instances. However, it has a priority number of 400.

| Priority | Name                          | Port       | Protocol | Source            | Destination    | Action |
|----------|-------------------------------|------------|----------|-------------------|----------------|--------|
| 200      | AllowLB                       | Any        | Any      | AzureLoadBalancer | Any            | Allow  |
| 300      | AllowLocalRDP                 | 3389,20000 | TCP      | 172.16.0.0        | 10.1.0.0/24    | Allow  |
| 400      | DenyAll                       | Any        | Any      | Any               | Any            | Deny   |
| 65000    | AllowVnetInBound              | Any        | Any      | VirtualNetwork    | VirtualNetwork | Allow  |
| 65001    | AllowAzureLoadBalancerInBound | Any        | Any      | AzureLoadBalancer | Any            | Allow  |
| 65500    | DenyAllInBound                | Any        | Any      | Any               | Any            | Deny   |

## Solution

Configure the network security group (NSG) inbound rules to reflect the following behavior:

- Port 3389 allows communication between a client computer and a role instance.
- Port 20000 allows communication between role instances.

The following table shows the updated list of sample NSG inbound rules. The list contains a new **AllowInstances** rule. This rule lets role instances communicate through ports 3389 and 20000 over the TCP protocol by using the **10.1.0.0/24** range of IP addresses. Because the **AllowInstances** rule has a priority number of 350, it's rated as less important than the **AllowLocalRDP** rule, but more important than the **DenyAll** rule.

| Priority | Name                          | Port           | Protocol | Source            | Destination     | Action    |
|----------|-------------------------------|----------------|----------|-------------------|-----------------|-----------|
| 200      | AllowLB                       | Any            | Any      | AzureLoadBalancer | Any             | Allow     |
| 300      | AllowLocalRDP                 | 3389,20000     | TCP      | 172.16.0.0        | 10.1.0.0/24     | Allow     |
| **350**  | **AllowInstances**            | **3389,20000** | **TCP**  | **10.1.0.0/24**   | **10.1.0.0/24** | **Allow** |
| 400      | DenyAll                       | Any            | Any      | Any               | Any             | Deny      |
| 65000    | AllowVnetInBound              | Any            | Any      | VirtualNetwork    | VirtualNetwork  | Allow     |
| 65001    | AllowAzureLoadBalancerInBound | Any            | Any      | AzureLoadBalancer | Any             | Allow     |
| 65500    | DenyAllInBound                | Any            | Any      | Any               | Any             | Deny      |

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
