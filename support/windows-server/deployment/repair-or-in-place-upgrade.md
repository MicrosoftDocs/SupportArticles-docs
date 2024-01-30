---
title: How to do an in-place upgrade
description: This article introduces how to do a repair/in-place upgrade of the existing installation for Windows.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
ms.subservice: deployment
---
# How to do an in-place upgrade on Windows

After you've done the emergency repair process, the computer still doesn't operate normally. In this situation, you may want to do a repair in-place upgrade or an in-place upgrade to a newer operating system version. A repair in-place upgrade means performing an in-place upgrade to the same OS version as the existing one.

_Applies to:_ &nbsp; All Windows versions  
_Original KB number:_ &nbsp; 2255099

## More information

An in-place upgrade is the final alternative before you have to reinstall the operating system.

> [!NOTE]
> It takes the same amount of time to do the upgrade as to reinstall the operating system. Also, some of your customized Windows settings may be lost through this process.

## How to do a repair installation of Windows

A repair installation will restore the current Windows installation to the version of the installation DVD. It also requires the installation of all updates that aren't included on the installation DVD.

> [!NOTE]
> A repair installation won't damage files and applications that are currently installed on your computer.

To do a repair installation of Windows, follow these steps:

1. Close all the running applications.
2. Insert the Windows DVD in the computer's DVD drive.
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

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
