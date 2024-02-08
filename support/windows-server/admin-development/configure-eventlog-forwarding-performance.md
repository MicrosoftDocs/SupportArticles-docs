---
title: Best practice of configuring EventLog forwarding performance
description: This article introduces the best practice of configuration of EventLog forwarding in a large environment.
ms.date: 03/04/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, gbrag, raackley, leofa
ms.custom: sap:windows-management-instrumentation-wmi, csstroubleshoot
---
# Best practice for configuring EventLog forwarding in Windows Server 2012 R2

This article introduces the best practice for configuring EventLog forwarding in a large environment  in Windows Server 2012 R2.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4494356

## Summary

There are important scalability fixes that have been rolled out to Windows Server 2016, Windows Server 2019 in the February 25, 2020 cumulative updates.

See "Improves Event Forwarding scalability to ensure thread safety and increase resources." bullet in the following two articles:

- [February 25, 2020-KB4537806 (OS Build 14393.3542)](https://support.microsoft.com/help/4537806/)

- [February 25, 2020-KB4537818 (OS Build 17763.1075)](https://support.microsoft.com/help/4537818)

## Events latency

As soon as events are generated on the client, the Event Forwarding mechanism takes some time to forward them to the collector.

This delay may be caused by the subscription configuration, such as the **DeliveryMaxLatency** parameter, the performance of the collector, the forwarder, or the network.

> [!NOTE]
> Make sure that the events are not overwritten on the client before they are forwarded. We usually have to manage this issue only when the clients generate a large amount of events, such as a busy server or the DC forwarding the Security log.

## Limitation and system requirement

You deploy EventLog Forwarding in a large environment. For example, you deploy 40,000 to 100,000 source computers. In this situation, we recommend that you deploy more than one collector that has 2,000 to not more than 4,000 clients per collector.

Additionally, we recommend that you install at least 16 GB of RAM and four (4) processors on the collector to support an average load of 2,000 to 4,000 clients that have one or two subscriptions configured.

Fast disks are recommended, and the ForwardedEvents log can be put onto another disk for better performance.

The memory usage of the Windows Event Collector service depends on the number of connections that are received by the client. The number of connections depends on the following factors:

- The frequency of the connections
- The number of subscriptions
- The number of clients
- The operating system of the clients

For example, for the default values of 4,000 clients and five to seven subscriptions, the memory that is used by the Windows Event Collector service may quickly exceed 4 GB and continue to grow. This can make the computer unresponsive.

## Frequency of the client connections

Three parameters control the frequency of the client connections:

- **Refresh=** (specified in the configuration URL of the GPO)
- **DeliveryMaxLatency** (specified in the subscription)
- **HeartbeatInterval**  (specified in the subscription)

### The Refresh= parameter in the GPO

This parameter is measured in seconds. It controls how frequently the client connects to the **/WEC** URL to enumerate the available subscriptions.

The collector responds by providing a list of the subscriptions that are enabled for the client. The response includes the bookmarks for each channel and the Xpath query.
As soon as the client receives the information, it starts to send the events or the heartbeat packets to the /Subscriptions URL. If the subscriptions don't change frequently, this parameter can be configured to check every few hours or even less often.

### DeliveryMaxLatency

Controls the frequency of the client connections. For a large deployment, you can create a subscription for urgent events set to a 5-minute frequency, and another for less urgent events set to a 2-hour frequency.

### HeartbeatInterval

Controls the Inactive status in the Runtime status window of the console. Can be set to the same value as **DeliveryMaxLatency** or a larger value to give clients additional time before they are marked as Inactive.

### Custom parameters

To configure custom parameters, you must use the command line to run Wecutil. For more information, see [Wecutil.exe](/windows/desktop/wec/wecutil).

- You can list the configured subscription as `wecutil es`.  
- You must first switch the subscription to "Custom":

    ```console
    wecutil ss <SubscriptionName> /cm:"Custom"
    ```

- Then, set the DeliveryMaxLatency parameter:

    ```console
    wecutil ss <SubscriptionName> /dmlt:7200000
    ```

    (Value is in milliseconds: 7200000 = 2 hours)

- Adjust **HeartbeatInterval** to the same value. This setting affects the "Inactive" status for each client in the console:

    ```console
    wecutil ss <SubscriptionName> /hi:7200000
    ```

## Subscription delivery optimization

The clients are sending the events to the /subscriptions URL. These connections are very important for collectors memory usage.

The following preconfigured modes are available.

- **Normal**  
  - Provides reliable delivery of events, and does not try to conserve bandwidth.
  - The appropriate choice unless you require tighter control over bandwidth usage or you require that forwarded events be delivered as quickly as possible.
  - Uses pull delivery mode, batches five items at a time, and sets a batch time-out of 15 minutes.

- **Minimize Bandwidth**  
  - Makes sure that the use of network bandwidth for event delivery is strictly controlled.
  - The appropriate choice if you want to limit the frequency of network connections to deliver events.
  - Uses push delivery mode, and sets a batch time-out of 6 hours and a heartbeat interval of 6 hours.

- **Minimize Latency**  
  - Makes sure that events are delivered by having minimal delay.
  - The appropriate choice if you collect alerts or critical events.
  - Uses push delivery mode, and sets a batch time-out of 30 seconds.

The client connects to the collector at the specified frequency to either send the events or send a heartbeat.
The default "Normal" settings can cause high memory usage by having 2,000 to 4,000 clients per collector.

## Configure the collector name

You can configure the collector name on the client by configuring the following Group Policy Object (GPO):  
Computer Configuration/Administative Templates/Windows Components/ Event Forwarding/ Configure Target Subscription Manager

Alternatively, you can make registry settings in the following subkey:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager`

The GPOs that assign the collector to each client can be filtered by using either the security setting on the GPO itself or a WMI filter.
For example, if the computer name always ends in a numeral (such as computer1, computer2, and so on), we can create GPOs to point the clients to 10 different collectors.

## Consolidation of the subscriptions

Configuring multiple subscriptions increases the number of connections. The considerations that are discussed earlier in this article apply to each subscription.

We recommend that you configure the subscription by editing the Xpath query and putting multiple queries into the same subscription.
