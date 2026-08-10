---
title: Troubleshoot Azure Load Balancer resource health, frontend, and backend availability problems
description: Troubleshoot Azure Load Balancer resource health, frontend, and backend availability problems with key metrics to restore connectivity—start diagnosing now.
services: load-balancer
ms.service: azure-load-balancer
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 08/05/2026
ms.reviewer: duau
ms.custom: sap:Connectivity-Inbound
# Customer intent: "As a network administrator, I want to diagnose issues impacting the availability of Azure Load Balancer resources, so that I can ensure reliable backend connectivity and optimal performance for my applications."
---

# Troubleshoot Azure Load Balancer resource health and inbound availability problems

## Summary

This article helps you troubleshoot Azure Load Balancer frontend IP and backend resource availability problems so you can restore reliable connectivity.

Use the *resource health* feature in Azure Load Balancer to check the health of your load balancer. It analyzes the Data Path Availability metric to determine whether the load-balancing endpoints, the frontend IP, and frontend port combinations with load-balancing rules are available.

> [!NOTE]
> Basic Load Balancer doesn't support the resource health feature.

The following table describes the logic for determining the health status of your load balancer.

| Resource health status | Description |
| --- | --- |
| **Available** | Your load balancer resource is healthy and available. |
| **Degraded** | Your load balancer has platform or user-initiated events that affect performance. The Data Path Availability metric reported less than 90% but greater than 25% health for at least two minutes. You might be experiencing moderate to severe performance degradation. |
| **Unavailable** | Your load balancer resource isn't healthy. The Data Path Availability metric reported less than 25% health for at least two minutes. You might be experiencing significant performance degradation or a lack of availability for inbound connectivity. User or platform events might be causing unavailability. |
| **Unknown** | Resource health status for your load balancer resource isn't updated or received Data Path Availability information in the last 10 minutes. This state might be transient, or your load balancer might not support the resource health feature. |

## Monitor your load balancer's availability

Azure Load Balancer uses two metrics to check resource health: *Data Path Availability* and *Health Probe Status*. To get the right insights, you need to understand what these metrics mean.

### Data Path Availability

Every 25 seconds, a TCP ping generates the Data Path Availability metric on all frontend ports where you configured load-balancing rules. This TCP ping routes to any of the healthy (probed up) backend instances. The metric is an aggregated percentage success rate of TCP pings on each frontend IP/port combination for each of your load-balancing rules, across a sample period of time.

### Health Probe Status

The Health Probe Status metric comes from a ping of the protocol you define in the health probe. This ping goes to each instance in the backend pool and uses the port you set in the health probe. For HTTP and HTTPS probes, a successful ping needs an `HTTP 200 OK` response. For TCP probes, any response counts as successful.

Azure Load Balancer determines the health of each backend instance when the probe reaches the number of consecutive successes or failures that you configured for the probe threshold property. The health status of each backend instance determines whether or not the backend instance is allowed to receive traffic.

Like the Data Path Availability metric, the Health Probe Status metric aggregates the average successful and total pings during the sampling interval. The Health Probe Status value indicates the backend health in isolation from your load balancer by probing your backend instances without sending traffic through the frontend.

> [!IMPORTANT]
> Health Probe Status samples happen every minute. This sampling can cause minor fluctuations in an otherwise steady value.
>
> For example, think about active/passive scenarios where there are two backend instances, one probed up and one probed down. The health probe service might capture seven samples for the healthy instance and six for the unhealthy instance. This situation causes a previously steady value of 50 to show as 46.15 for a one-minute interval.

## Diagnose degraded and unavailable load balancers

As explained in [this article about resource health](/azure/load-balancer/load-balancer-standard-diagnostics#resource-health-status), a degraded load balancer shows between 25% and 90% for Data Path Availability. An unavailable load balancer is one with less than 25% for Data Path Availability over a two-minute period.

You can take the same steps to investigate the failure that you see in any Health Probe Status or Data Path Availability alerts that you set up. The following steps explore what to do if you check your resource health and find your load balancer is unavailable with a Data Path Availability value of 0%. Your service is down.

1. In the Azure portal, go to the detailed metrics view of the page for your load balancer insights. Access the view from the page for your load balancer resource or from the link in your resource health message.

1. Go to the tab for frontend and backend availability, and review a 30-minute window of the time period when the degraded or unavailable state occurred. If the Data Path Availability value is 0%, you know that something is preventing traffic for all of your load-balancing rules. You can also see how long this problem lasted.

1. Check your Health Probe Status metric to find out if your data path is unavailable because you have no healthy backend instances to serve traffic. If you have at least one healthy backend instance for all of your load-balancing and inbound rules, this problem often indicates an Azure platform problem. Although platform problems are rare, they trigger an automated alert to our team for rapid resolution. If Data Path Availability stays unavailable despite healthy backend instances, also check for asymmetric routing, described in the next section, before concluding the problem is platform-side.

### Diagnose asymmetric routing causing return-path failures

Your Health Probe Status might show healthy backend instances, but clients still can't complete inbound connections through your load balancer's public frontend. In this case, the return traffic from your backend instances might not take the same path it arrived on. This asymmetric routing problem commonly occurs when a backend subnet learns a Border Gateway Protocol (BGP)-advertised default route (`0.0.0.0/0`). The subnet typically learns this route from a private connectivity circuit, such as an ExpressRoute or VPN connection. The learned route overrides the subnet's default internet route. As a result, the private circuit, not the internet, carries outbound traffic from your backend instances, including return traffic for connections that came in through the load balancer. The client's request never receives a response, and the connection times out.

1. In the Azure portal, go to the network interface (NIC) attached to the affected backend instance and view its effective routes. For steps, see [Diagnose a virtual machine routing problem](/azure/virtual-network/diagnose-network-routing-problem#diagnose-using-azure-portal). Alternatively, retrieve effective routes with the [Get-AzEffectiveRouteTable](/powershell/module/az.network/get-azeffectiveroutetable) PowerShell cmdlet or the [az network nic show-effective-route-table](/cli/azure/network/nic#az-network-nic-show-effective-route-table) Azure CLI command. Azure reports effective routes per NIC, not per subnet, so if the backend pool has multiple instances, check each instance's NIC.

1. In the effective routes list, look for a route with the `0.0.0.0/0` address prefix whose source is your virtual network gateway rather than the default Azure-created route with a next hop type of **Internet**. A `0.0.0.0/0` route sourced from the gateway confirms that a private connectivity circuit advertises a default route over BGP.

1. Understand why this route breaks connectivity: Azure prioritizes a BGP-learned route over the default system route for internet-bound traffic. When a private circuit advertises `0.0.0.0/0`, Azure sends all outbound traffic from the subnet, including return traffic for inbound load-balanced connections, through that circuit instead of to the internet. For more information about route priority, see [How Azure selects routes for traffic routing](/azure/virtual-network/virtual-networks-udr-overview#how-azure-selects-routes-for-traffic-routing).

   > [!IMPORTANT]
   > A BGP-advertised `0.0.0.0/0` route is often deliberate. Forced tunneling through a VPN or ExpressRoute connection is a common, intentional design that redirects all internet-bound traffic on-premises for security inspection and compliance auditing. Before you override this route, confirm with the team that owns your network and security policy that exempting the backend subnet from forced tunneling is acceptable. If it isn't, work with that team to find an alternative, such as inspecting the return traffic on-premises instead of routing it directly to the internet.

1. If exempting the backend subnet from forced tunneling is acceptable, restore the internet return path for that subnet only. Create a user-defined route (UDR) for the `0.0.0.0/0` address prefix with a next hop type of **Internet**, and associate the route table with the backend subnet. A user-defined route takes priority over a BGP-learned route, so this override lets the backend subnet reach the internet directly while other subnets continue to use the private circuit. This UDR-based exception matches the pattern for [routing internet-bound traffic for specific subnets](/azure/vpn-gateway/site-to-site-tunneling#udr) under forced tunneling, and for [enabling internet connectivity for specific ExpressRoute-connected subnets](/azure/expressroute/expressroute-routing#advertising-default-routes). For UDR creation steps, see [Create a route](/azure/virtual-network/manage-route-table#create-a-route).

1. After you add the UDR, retest inbound connectivity to your load balancer's frontend on the affected port to confirm that Data Path Availability recovers.

For general guidance on virtual network traffic routing, see [Virtual network traffic routing](/azure/virtual-network/virtual-networks-udr-overview).

## Diagnose health probe failures

If the Health Probe Status metric shows that your backend instances are unhealthy, use the following checklist to rule out common configuration errors:

* Check the CPU utilization for your resources to see if they're under high load.

  You can check by viewing the resource's Percentage CPU metric in the **Metrics** page. For more information, see [Troubleshoot high-CPU issues for Azure Windows virtual machines](/troubleshoot/azure/virtual-machines/troubleshoot-high-cpu-issues-azure-windows-vm).
* If you're using an HTTP or HTTPS probe, check if the application is healthy and responsive.

  Validate that your application is functional by directly accessing it through the private IP address or instance-level public IP address that's associated with your backend instance.
* Review the network security groups (NSGs) applied to your backend resources. Make sure that no rules with higher priority than `AllowAzureLoadBalancerInBound` block the health probe.

  To complete this task, go to the network settings of your backend VMs or virtual machine scale sets. If you find that this NSG problem is the case, move the existing `Allow` rule or create a new high-priority rule to allow Azure Load Balancer traffic.
* Check your OS. Ensure that your VMs are listening on the probe port. Also review the OS firewall rules for the VMs to make sure they aren't blocking the probe traffic originating from IP address `168.63.129.16`.

  You can check listening ports by running `netstat -a` from a Windows command prompt or `netstat -l` from a Linux terminal.
* Make sure that you're using the right protocol. For example, a probe that uses HTTP to probe a port listening for a non-HTTP application fails.
* Don't place Azure Firewall in the backend pool of load balancers. For more information, see [Integrate Azure Firewall with Azure Standard Load Balancer](/azure/firewall/integrate-lb).

## Related content

* [Learn more about Azure Load Balancer health probes](/azure/load-balancer/load-balancer-custom-probe-overview)
* [Learn more about Azure Load Balancer metrics](/azure/load-balancer/load-balancer-standard-diagnostics)

