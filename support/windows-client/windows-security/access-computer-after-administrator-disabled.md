---
title: Access computer after administrator account is disabled
description: Describes how to access your computer by using the Administrator account after you disable the local Administrator account.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:account-lockouts, csstroubleshoot
---
# How to access the computer after you disable the administrator account

You can disable the local administrator account in Windows Server in order to provide an additional level of security in your organization. Additionally, the default Remote Installation Services (RIS) installation disables the local Administrator account on the destination computer.

This article describes how to access your Windows Server-based computer by using the local administrator account when the local administrator account is disabled.

_Original KB number:_ &nbsp; 814777

## Log on to Windows by using Safe mode

To log on to Windows by using the disabled local Administrator account, start Windows in Safe mode. Even when the Administrator account is disabled, you are not prevented from logging on as Administrator in Safe mode. When you have logged on successfully in Safe mode, re-enable the local administrator account, and then log on again in normal mode. To do this, follow these steps:

1. Start the computer, and then press the F8 key when the power-on self-test (POST) is complete.
2. From the **Windows Advanced Options** menu, use the arrow keys to select **Safe Mode**, and then press Enter.
3. Select the operating system that you want to start, and then press Enter.
4. Log on to Windows as Administrator. If you are prompted to do so, click to select an item in the **Why did the computer shut down unexpectedly** list, and then click **OK**.
5. On the message that states Windows is running in safe mode, click **OK**.
6. Click **Start**, search for **Computer Management**, and open it.
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
