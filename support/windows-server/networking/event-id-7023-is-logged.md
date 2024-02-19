---
title: Event ID 7023 is logged when Windows Server 2012 starts
description: Describes an issue in which Event ID 7023 is logged when you start Windows Server 2012. You can safely ignore these events.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, danesc
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Event ID 7023 is logged when Windows Server 2012 starts

This article describes an issue where Event ID 7023 is logged when you start Windows Server 2012.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2768910

## Symptoms

When you start a computer that is running Windows Server 2012, Event ID 7023 is logged in the System log.

## Cause

This issue occurs because the IP Helper service can't start when the Network list service that it depends on isn't started yet. This situation occurs when Windows starts for the first time after a clean installation process.

After Windows starts, both the IP Helper service and the Network list service should start.

## Resolution

You can safely ignore the event.

## More information

For more information about other Windows Server 2012 startup errors, see [Event ID 46 is logged when you start a computer](../performance/event-id-46-start-a-computer.md).
