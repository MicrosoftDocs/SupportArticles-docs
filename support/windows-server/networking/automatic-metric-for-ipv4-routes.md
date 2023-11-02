---
title: The Automatic Metric feature for IPv4 routes
description: Introduces the Automatic Metric feature in Windows for IPv4 routes.
ms.date: 04/01/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.technology: networking
---
# An explanation of the Automatic Metric feature for IPv4 routes

This article describes the Automatic Metric feature that is used in Windows for Internet Protocol IPv4 routes.

_Original KB number:_ &nbsp; 299540

## Summary

A metric is a value that's assigned to an IP route for a particular network interface. It identifies the cost that's associated with using that route. For example, the metric can be valued in terms of link speed, hop count, or time delay. Automatic Metric is a new feature in Windows that automatically configures the metric for the local routes that are based on link speed. The Automatic Metric feature is enabled by default, and it can also be manually configured to assign a specific metric.

The Automatic Metric feature can be useful when the routing table contains multiple routes for the same destination. For example, if you have a computer with a 10 megabits (Mb) network interface and a 100-Mb network interface, and the computer has a default gateway that's configured on both network interfaces, the Automatic Metric feature assigns a higher metric to the slower network interface. This feature can force all traffic that's destined for the Internet to use the fastest network interface that's available.

> [!NOTE]
> Typically, Microsoft doesn't recommend that you add default gateways across disjoint networks. For example, edge servers, such as, Network Address Translation (NAT) and proxy servers, are typically configured to connect two or more disjoint networks: The public Internet and one or more private intranets. In this situation, you should not assign the default gateways on the private interfaces, as doing so may result in improper routing on your network.

## Routes

The following table outlines the criteria that is used by Windows to assign metrics for routes that are bound to network interfaces of various speeds.

|Link Speed|Metric|
|---|---|
|Greater than or equal to 2 Gb|5|
|Greater than 200 Mb|10|
|Greater than 20 Mb, and less than or equal to 200 Mb|20|
|Greater than 4 Mb, and less than or equal to 20 Mb|30|
|Greater than 500 kilobits (Kb), and less than or equal to 4 Mb|40|
|Less than or equal to 500 Kb|50|
  
The following table lists the link speeds and assigned metrics for computers that run Windows XP Service Pack 2 and newer versions of Windows operating systems.

|Link Speed|Metric|
|---|---|
|Greater than or equal to 2 Gb|5|
|Greater than 200 Mb|10|
|Greater than 80 Mb, and less than or equal to 200 Mb|20|
|Greater than 20 Mb, and less than or equal to 80 Mb|25|
|Greater than 4 Mb, and less than or equal to 20 Mb|30|
|Greater than 500 Kb, and less than or equal to 4 Mb|40|
|Less than or equal to 500 Kb|50|
  
The following table lists the link speeds and assigned metrics for computers that run Windows 10 and newer versions of Windows operating systems:

For interfaces with physical medium types NdisPhysicalMediumWirelessLan, NdisPhysicalMediumWirelessWan, NdisPhysicalMediumNative802_11:

|Link Speed|Metric|
|---|---|
|Greater than or equal to 2 Gb|25|
|Greater than or equal to 500 Mb and less than 2 Gb|30|
|Greater than or equal to 200 Mb and less than 500 Mb|35|
|Greater than or equal to 150 Mb and less than 200 Mb|40|
|Greater than or equal to 80 Mb and less than 150 Mb|45|
|Greater than or equal to 50 Mb and less 80 Mb|50|
|Greater than or equal to 20 Mb and less than 50 Mb|55|
|Greater than or equal to 10 Mb and less than 20 Mb|60|
|Greater than or equal to 4 Mb and less than 10 Mb|65|
|Greater than or equal to 2 Mb and less than 4 Mb|70|
|Greater than or equal to 500 Kb and less than 2 Mb|75|
|Greater than or equal to 200 Kb and less than 500 Kb|80|
|Less than 200 Kb|85|
  
For other interfaces types:

|Link Speed|Metric|
|---|---|
|Greater than or equal to 100 Gb|5|
|Greater than or equal to 40 Gb and less than 100 Gb|10|
|Greater than or equal to 10 Gb and less than 40 Gb|15|
|Greater than or equal to 2 Gb and less than 10 Gb|20|
|Greater than or equal to 200 Mb and less than 2 Gb|25|
|Greater than or equal to 80 Mb and less than 200 Mb|35|
|Greater than or equal to 20 Mb and less 80 Mb|45|
|Greater than or equal to 4 Mb and less than 20 Mb|55|
|Greater than or equal to 500 Kb and less than 4 Mb|65|
|Less than 500 Kb|75|
  
## More information

The Automatic Metric feature is configured independently for each network interface in the network. This feature is useful in situations where you have more than one network interface of the same speed, for example, when each network interface has been assigned a default gateway. In this situation, you may want to manually configure the metric on one network interface, and enable the Automatic Metric feature to configure the metric of the other network interface. This setup can enable you to control the network interface that is used first in the routing of IP traffic.

In addition, the metric that's assigned to specific default gateways can be configured independently for each gateway. This setup enables a further level of control over the metric that's used for the local routes. For example, it's possible to enable the Automatic Metric feature to configure the routes that are assigned to the network interface. And at the same time you can manually configure the metric that's assigned to the default gateways.

> [!NOTE]
> If a metric is specified at the network interface level, but a gateway is added and configured for the Automatic Metric feature, the gateway can inherit the metric that is assigned to the network interface. For example, if you assign a metric of five at the network interface level, and then you add a gateway and leave the Automatic Metric feature checked for the gateway, the gateway is also assigned a metric of five. For half-duplex interfaces, such as wireless, the effective speed is half of the advertised speed.

The Automatic Metric feature is different from the Dead Gateway Detection feature that can force the network to switch the default gateways that are based on Transmission Control Protocol (TCP) retransmissions. Also, the Routing and Remote Access feature doesn't activate the Dead Gateway Detection feature. This activation is performed by the TCP/IP stack on the computer that initiates the TCP session.

To configure the Automatic Metric feature:

1. In Control Panel, double-click **Network Connections**.
2. Right-click a network interface, and then select **Properties**.
3. Click Internet Protocol (TCP/IP), and then select **Properties**.
4. On the **General** tab, select **Advanced**.
5. To specify a metric, on the **IP Settings** tab, clear the **Automatic metric** check box, and then enter the metric that you want in the **Interface Metric** field.

## References

[IPv4 Routing](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc732974%28v=ws.10%29)
[Download PDF version of TCP/IP Fundamentals for Microsoft Windows](https://www.microsoft.com/en-us/download/details.aspx?id=8781)
