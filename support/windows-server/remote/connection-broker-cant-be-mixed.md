---
title: Connection Broker can't be mixed
description: Remote Desktop Service can't be used in a mixed environment where Remote Desktop Connection Broker is installed on a Windows Server 2012/2012 R2 and a Remote Desktop Session Host is installed on Windows Server 2008 R2 or versions earlier.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Connection Broker on Windows Server 2012 or 2012 R2 and Session Host on Windows Server 2008 or 2008 R2 cannot be mixed in Remote Desktop Service environment

This article provides a solution to an issue that Remote Desktop Service can't be used in a mixed environment.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3007168

## Symptoms

Remote Desktop Service can't be used in a mixed environment where Remote Desktop Connection Broker is installed on a Windows Server 2012/2012 R2 and a Remote Desktop Session Host is installed on Windows Server 2008 R2 or versions earlier.

An error will occur in the compatibility verification process when adding a Windows Server 2008, or earlier, Remote Desktop Session Host to a Windows Server 2012/ 2012 R2 Remote Desktop Connection Broker.

## Cause

Windows Server 2008 R2 or versions earlier cannot be registered as a Collection in Windows Server 2012/2012 R2.

On Window Server 2008 R2, Remote Desktop (RD) Connection Broker manages in terms of "farms" that is a concept no longer in existence after Windows Server 2012.

A new concept of "collections" has been introduced in Windows Server 2012 that the RD Connection Broker manages in.

For the reasons above, RD Service cannot be used in a mixed environment where RD Connection Broker is installed on a Windows Server 2012/2012 R2 and an RD Session Host is installed on Windows Server 2008 R2 or versions earlier.

## Resolution

It is recommended to have a unified environment under the same OS version.

## Workaround

None
