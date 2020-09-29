---
title: Event ID 7023 is logged
description: Describes an issue in which events that have Event ID 7023 are logged when you start Windows Server 2012. You can safely ignore these events.
ms.date: 09/16/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, danesc
ms.prod-support-area-path: TCP/IP communications
ms.technology: Networking
---
# Event ID 7023 is logged when Windows Server 2012 starts

This article provides a solution to an issue where events that have Event ID 7023 are logged when you start Windows Server 2012.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2768910

## Symptoms

When you start a computer that is running Windows Server 2012, the following events are logged in the System log:

## Cause

This issue occurs because the IP Helper service can't start when the Network list service that it depends on isn't started yet. This situation occurs when Windows starts for the first time after a clean installation process.

After Windows starts, both the IP Helper service and the Network list service should start.

## Resolution

You can safely ignore these events.

## More information

For more information about other Windows Server 2012 startup errors, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[2756313](https://support.microsoft.com/help/2756313 ) Event ID 46 logged when you start a computer

[2002317](https://support.microsoft.com/help/2002317)  Event ID 46 and 7023 logged during startup of Windows Server 2008 R2 or Windows Server 2012
