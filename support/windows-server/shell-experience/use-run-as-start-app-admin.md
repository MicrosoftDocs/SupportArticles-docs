---
title: Use Run as to start an app as an admin
description: Describes how to use the Run as command to start an application as an administrator.
ms.date: 09/28/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, BOBQIN
ms.prod-support-area-path: Desktop Shell
ms.technology: windows-server-shell-experience
---
# How to use Run as to start an application as an administrator in Windows Server 2003  

This article describes how to use the `Run as` command to start an application as an administrator.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 325362

## Summary

You can use `Run as` to start an application as an administrator if you want to perform administrative tasks when you are logged on as a member of another group, such as the Users or Power Users group.

## Steps to start an application as an administrator

To use `Run as` to start an application as an administrator, follow these steps:

1. Locate the application that you want to start in Windows Explorer, the Microsoft Management Console (MMC), or Control Panel.
2. Press and hold down the SHIFT key while you right-click the executable file or the icon for the application, and then select **Run as**.
3. Select **The following user**.
4. In the **User name** and **Password** boxes, type the administrator account and password, and then select **OK**.

> [!NOTE]
>
> - Some applications may not support the use of the `Run as` command.
> - You may not be able to start an application, MMC console, or Control Panel tool from a network location by using the `Run as` command if the credentials that are used to connect to the network share are different from those used to start the application. The credentials that are used to run the application may not permit you access to the same network share.
> - You can also use the `Run as` command from the command line. For more information, select **Start**, and then select **Run**. In the Open box type cmd, and then select **OK**. At the command prompt, type runas /?, and then press **ENTER**.
