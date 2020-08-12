---
title: ActiveSync clients cannot connect or delayed
description: Describers an issue in which ActiveSync clients cannot connect or they experience delays when synchronizing in an Exchange Server environment. Provides a workaround.
ms.date: 08/10/2020
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: bilong
appliesto:
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2013 Enterprise
search.appverid: MET150
---
# ActiveSync clients cannot connect or synchronizing is delayed in an Exchange Server environment

This article provides a workaround for the issue that ActiveSync clients cannot connect or they experience delays when synchronizing a mobile device in Microsoft Exchange Server 2016 or Exchange Server 2013.

_Original KB number:_ &nbsp; 4337638

## Symptoms

In an Exchange Server 2016 or Exchange Server 2013 environment, ActiveSync clients cannot connect or they experience delays when users synchronize their mobile device. This issue occurs after the ActiveSync application pool runs for some time, usually for several weeks. Additionally, you may experience the following behavior:

- The ActiveSync application pool consumes lots of memories.
- The **.NET CLR Memory/% Time in GC** counter for the w3wp instance that corresponds to the ActiveSync application pool is unusually high.
- TCP port exhaustion occurs because of the high number of requests in ActiveSync.
- The **W3SVC_W3WP/Active Requests** counter for the **MSExchangeSyncAppPool** instance shows a steadily increasing value over several days or weeks.
- The `netstat -anob` command may show many connections in a **CLOSE_WAIT** state.

## Cause

This is a known issue that occurs when ActiveSync Ping commands become stranded in the application pool.

## Workaround

To work around this issue, periodically cycle the ActiveSync application pool to release the stranded commands.

For more information about how to configure an application pool to automatically recycle at regular intervals, see [Recycling Settings for an Application Pool \<recycling>](https://docs.microsoft.com/iis/configuration/system.applicationhost/applicationpools/add/recycling/).
