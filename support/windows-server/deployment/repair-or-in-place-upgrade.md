---
title: How to do an in-place upgrade
description: This article introduces how to do a repair/in-place upgrade of the existing installation for Windows 7 Service Pack 1.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Setup
ms.technology: windows-server-deployment
---
# How to do an in-place upgrade on Windows 7

After you've done the emergency repair process, the computer still doesn't operate normally. In this situation, you may want to do a repair or in-place upgrade of the existing installation.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2255099

## More information

An in-place upgrade is the final alternative before you have to reinstall the operating system.

> [!NOTE]
> It takes the same amount of time to do the upgrade as to reinstall the operating system. Also, some of your customized Windows settings may be lost through this process.

## How to do a repair installation of Windows 7

A repair installation will restore the current Windows installation to the version of the installation DVD. It also requires the installation of all updates that aren't included on the installation DVD.

> [!NOTE]
> A repair installation won't damage files and applications that are currently installed on your computer.

To do a repair installation of Windows 7, follow these steps:

1. Close all the running applications.
2. Insert the Windows 7 DVD in the computer's DVD drive.
3. In the **Setup** window, select **Install Now**.

    > [!NOTE]
    > If Windows does not automatically detect the DVD, follow these steps:

      1. Select **Start**, and then type *`Drive:\setup.exe`* in the **Start Search** box.

         > [!NOTE]
         > The *Drive* placeholder is the drive letter of the computer's DVD drive.

      2. In the Programs list, select **Setup.exe**.
      3. In the **Setup** window, select **Install Now**.

4. Select **Go online to obtain the latest updates for installation (recommended)**.
5. Type the CD key if you're prompted.
6. Select the operating system in **Install Windows** page you want to **Upgrade** or **Inplace**.
7. select **Yes** to accept the Microsoft Software License Terms.
8. On the **Which type of installation do you want?** screen, select **Upgrade**.
9. When the installation is complete, restart your computer.
