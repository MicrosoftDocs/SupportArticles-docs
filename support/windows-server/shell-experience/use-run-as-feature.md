---
title: Enable and use the Run As feature
description: Describes how to enable and use the Run as feature in Microsoft Windows Server 2003.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Desktop and Shell Experience\Desktop (Shell, Explorer.exe init, themes, colors, icons, recycle bin), csstroubleshoot
---
# Enable and use the Run As feature in Windows Server 2003

This article describes how to enable and use the Run as feature in Microsoft Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 325859

## Summary

You can use the Run as feature to run a program, MMC console, or Control Panel tool by using the credentials of a user other than the currently logged on user. This makes it possible for a user with multiple accounts to run a program as a different user. For example, you can use the Run as feature to start a program as an administrator if you want to perform administrative tasks when you are logged on as a member of another group, such as the Users or Power Users group.

To use the Run as feature, the Secondary Logon service must be running.

## Enable the Secondary Logon service

By default, the Secondary Logon service starts automatically when you start Windows. However, an administrator can disable the service. To enable the service if it is disabled:

1. Log on as Administrator or as a member of the Administrators group.
2. Click **Start**, point to **Administrative Tools**, and then click **Computer Management**.
3. Expand **Services and Applications**, and then click **Services**.
4. In the right pane, right-click **Secondary Logon**, and then click **Properties**.
5. Click the **General** tab.
6. In the **Startup type** box, click **Automatic**, and then click **Start** under **Service status**.
7. Click **OK**, and then close the **Computer Management** window.

## Use Run As to start a program as another user

To use the Run as feature to start a program as another user:

1. Locate the program that you want to start in Windows Explorer, the Microsoft Management Console (MMC), or Control Panel.
2. Press and hold down the SHIFT key while you right-click the .exe file or icon for the program, and then click **Run as**.
3. Click **The following user**.
4. In the **User name** and Password boxes, type the user name and password of the user whose credentials you want to use to run the program, and then click **OK**.

> [!NOTE]
> You can also use the `runas` command from a command prompt. For more information, click **Start**, and then click **Run**. In the **Open** box, type *cmd*, and then click **OK**. At the command prompt, type `runas /?`, and then press ENTER.

## Troubleshooting

- Some programs may not support the use of the `runas` command.
- The `runas` command does not function correctly when you run it by using the LocalSystem account.
- You may not be able to start a program, MMC console, or Control Panel tool from a network location by using the Run as feature if the credentials you use to connect to the network share are different from the credentials you use to start the program. The credentials that are used to run the program may not be able to gain access to the same network share.

For more information about how to use the Run as feature, see [How To Use Run as to Start an Application as an Administrator in Windows Server 2003](https://support.microsoft.com/help/325362).
