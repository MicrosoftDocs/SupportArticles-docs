---
title: ActiveSync clients can't connect
description: Fixes an issue in which Exchange ActiveSync clients can't connect or they experience delays when synchronizing in an Exchange Server environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: balinger, christys, wsvexse, v-zht, v-lmengy, Bilong, paololin, v-six
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with Active Sync Device
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
---
# ActiveSync clients cannot connect or synchronizing is delayed in an Exchange Server environment

_Original KB number:_ &nbsp; 4456227, 4337638

## Symptoms

In an Exchange Server 2016 or Exchange Server 2013 environment, Exchange ActiveSync clients can't connect or they experience delays when users synchronize their mobile devices. Besides these problems, all functions of the CAS role will stop to work. This issue occurs after the Exchange ActiveSync application pool runs for some time, usually for several weeks. Additionally, you may experience the following behavior:

- Event ID 4227 is logged in the System log of the Event Viewer.
- The Exchange ActiveSync application pool consumes lots of memories.
- The **.NET CLR Memory/% Time in GC** counter for the **w3wp** instance that corresponds to the Exchange ActiveSync application pool is unusually high.
- TCP port exhaustion occurs because of the large number of requests in Exchange ActiveSync.
- The **W3SVC_W3WP/Active Requests** counter for the **MSExchangeSyncAppPool** instance shows a steadily increasing value over several days or weeks.
- The `netstat -anob` command may show many connections in a **CLOSE_WAIT** state.

## Cause

This is a known issue that occurs when Exchange ActiveSync Ping commands become stranded in the application pool.

## Workaround

For Exchange Server 2013, to work around this issue, periodically cycle the Exchange ActiveSync application pool for all the servers to release the stranded commands. For more information about how to configure an application pool to automatically recycle at regular intervals, see [Recycling Settings for an Application Pool \<recycling>](/iis/configuration/system.applicationhost/applicationpools/add/recycling/).

## Resolution

For Exchange Server 2016, to resolve this issue, install [Cumulative Update 11](https://support.microsoft.com/help/4134118) for Exchange Server 2016 or [a later cumulative update](/Exchange/new-features/build-numbers-and-release-dates) for Exchange Server 2016.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in **Applies to**.

## References

Learn about the [terminology](https://support.microsoft.com/help/824684) that Microsoft uses to describe software updates.
