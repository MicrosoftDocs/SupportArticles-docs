---
title: Start an application as an administrator account
description: Describes how to start an application as an administrator account.
ms.date: 06/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, BOBQIN
ms.custom: sap:desktop-shell, csstroubleshoot
ms.subservice: shell-experience
---
# How to use Run as to start an application as an administrator account

This article introduce how to start an application as an administrator account. For example, you can perform administrative tasks when you are logged on as a member of another group, such as the Users or Power Users group.

> [!NOTE]
> Some applications may not support running as a different user.

_Applies to:_ &nbsp; All supported versions of Windows  
_Original KB number:_ &nbsp; 325362

## Steps to start an application as an administrator account

1. Locate the application that you want to start.
2. Press and hold down the Shift key, and then right-click the executable file or the shortcut for the application, and then select **Run as different user**.
3. In the **Windows Security** window, type the administrator account's user name and password, and then select **OK**.

> [!NOTE]
>
> You may be unable to start an application, MMC console, or Control Panel tool from a network location as a different user if the credentials that are used to connect to the network share are different from those used to start the application. The credentials that are used to run the application may not permit you access to the same network share.

## More information

You can also start an application as a different user from the command line. For more information, see [Runas](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771525%28v=ws.11%29).
