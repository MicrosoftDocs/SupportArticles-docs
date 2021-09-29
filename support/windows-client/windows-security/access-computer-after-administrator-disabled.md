---
title: Access computer after administrator account is disabled
description: Describes how to access your computer by using the Administrator account after you disable the local Administrator account.
ms.date: 09/23/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:account-lockouts, csstroubleshoot
ms.technology: windows-client-security
---
# How to access the computer after you disable the administrator account

This article describes how to access your Microsoft Windows Server 2003-based computer by using the Administrator account after you disable the local Administrator account.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 814777

## Summary

You can use Windows Server 2003 to disable the local Administrator account. This feature is included to provide an additional level of security in your organization. Additionally, the default Remote Installation Services (RIS) installation disables the local Administrator account on the destination computer.

## Log on to Windows by using Safe mode

To log on to Windows by using the disabled local Administrator account, start Windows in Safe mode. Even when the Administrator account is disabled, you are not prevented from logging on as Administrator in Safe mode. When you have logged on successfully in Safe mode, re-enable the Administrator account, and then log on again. To do this, follow these steps:

1. Start the computer, and then press the F8 key when the Power On Self Test (POST) is complete.
2. From the **Windows Advanced Options** menu, use the ARROW keys to select **Safe Mode**, and then press ENTER.
3. Select the operating system that you want to start, and then press ENTER.
4. Log on to Windows as Administrator. If you are prompted to do so, click to select an item in the **Why did the computer shut down unexpectedly** list, and then click **OK**.
5. On the message that states Windows is running in safe mode, click **OK**.
6. Click **Start**, right-click **My Computer**, and then click **Manage**.
7. Expand **Local Users and Groups**, click **Users**, right-click **Administrator** in the right pane, and then click **Properties**.
8. Click to clear the **Account is disabled** check box, and then click **OK**.

If the server is a domain controller, the Local Users and Groups are not available in **Computer Management**. To enable the Administrator account, follow these steps:

1. Start your computer to Safe mode with networking support.
2. Log on as the administrator.
3. Click **Start**, click **Run**, type *cmd*, and then press Enter.
4. At the command prompt, type the following command, and then press Enter:

    ```console
    net user administrator /active:yes
    ```

## Log on to Windows by using Recovery Console

You can use the recovery console to access the computer even if the local Administrator account is disabled. Disabling the local Administrator account does not prevent you from logging on to the recovery console as Administrator.
