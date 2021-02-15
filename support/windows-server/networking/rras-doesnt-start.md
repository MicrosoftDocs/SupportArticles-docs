---
title: Routing and Remote Access service doesn't start when there's no network connectivity
description: Describes that the Routing and Remote Access service doesn't start if there's no network connectivity.
ms.date: 09/14/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, aanandr
ms.prod-support-area-path: Remote access
ms.technology: networking
---
# The Routing and Remote Access service doesn't start in Windows 7 or in Windows Server 2008 R2 when there's no network connectivity

This article provides a solution to an issue where the Routing and Remote Access service (RRAS) doesn't start when there's no network connectivity.

_Original product version:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 973990

## Symptoms

On a computer that is running Windows 7 or Windows Server 2008 R2, the Routing and Remote Access service (RRAS) doesn't start when there's no network connectivity. For example, RRAS doesn't start when all wired network connectivity is unplugged or when wireless connectivity is shut off.

Additionally, you can't create new incoming connections when there's no network connectivity. This is because incoming connections require that RRAS is started.

## Cause

When RRAS starts, it tries to initialize certain functions in Internet Authentication Service (IAS) for authentication. The IAS initialization fails when there's no network connectivity. Therefore, RRAS doesn't start. In Windows 7 and on Windows Server 2008 R2, IAS initialization failure is by design when there is no network connectivity. Then, you see the behavior that is mentioned in the [Symptoms](#symptoms) section.

## Workaround

To start RRAS to create a new incoming connection, your computer needs to be connected to a network. After RRAS starts, you can still create a new incoming connection after you disconnect from the network.

To check the status of RRAS, check the state of the RemoteAccess service (Routing and Remote Access) under the **Services** tab in Windows Task Manager.

## Status

This behavior is by design.
