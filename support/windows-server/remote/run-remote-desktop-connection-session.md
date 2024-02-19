---
title: Run a Remote Desktop Connection session
description: Describes Microsoft support for running a Remote Desktop Connection session within another Remote Desktop Connection session.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# Running a Remote Desktop Connection session within another Remote Desktop Connection session is supported with Remote Desktop Protocol 8.0 for specific scenarios

This article describes Microsoft support for Nesting Remote Desktop Connections.

_Applies to:_ &nbsp; Windows 11 - all editions, Windows 10 - all editions, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, Windows Server 2022  
_Original KB number:_ &nbsp; 2754550

## Summary

Running a Remote Desktop Connection session within another Remote Desktop Connection session is supported provided the following conditions are met.

|Client Computer version|Remote Desktop version|Nested Remote Desktop version|Supported RDP feature for the nested Remote Desktop connection|Supported Remote Desktop connection type|
|---|---|---|---|---|
|<ul><li>Windows 11 </li><li>Windows 10 </li> <li>Windows Server 2012 R2 </li>|<ul><li>Windows 11 </li><li>Windows 10 </li> <li>Windows Server 2012 R2 </li>|<ul><li>Windows 11 </li><li>Windows 10 </li> <li>Windows Server 2012 R2 </li>|<ul><li>Basic graphics (Display) </li> <li>Keyboard and mouse input</li>|<ul><li>Full Remote Desktop</li> <li>RemoteApp</li>|

For example, the following scenarios are supported for basic graphics and keyboard and mouse input:

1. Users connecting to a Windows Server 2016 Remote Desktop Session Host (RD Session Host) server for their desktop environment, and then connecting to another Windows Server 2016 RD Session Host server for RemoteApp programs.
2. Users connecting to a Windows 11 or Windows 10 virtual desktop for their desktop environment, and then connecting to a Windows Server 2012 RD Session Host server for RemoteApp programs.

## More information

> [!NOTE]
>
> - Windows 7 and Windows Server 2008 R2 don't support running a Remote Desktop Connection session within another Remote Desktop Connection session.
> - Only one level of nested Remote Desktop connection is supported. Establishing a Remote Desktop connection from inside a nested Remote Desktop connection isn't supported.
> - Remote Desktop Protocol (RDP) features other than graphics, keyboard, and mouse input aren't supported (including but not limited to Smart Card redirection, Clipboard redirection, Device redirection, and Audio redirection).
> - All RDP features can be used with the first RDP connection; that is, the connection between the user's client computer and the first Remote Desktop computer.
> - Users can use the Remote Desktop Web Access portal in the first Remote Desktop to launch RemoteApp programs or Remote Desktop connections.
