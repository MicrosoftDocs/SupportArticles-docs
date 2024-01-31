---
title: Suspend BitLocker protection for non-Microsoft software updates
description: Describes how to suspend and resume BitLocker protection for non-Microsoft software updates using Control Panel and PowerShell.
ms.date: 12/18/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika, v-jefen, xingrli
ms.custom: sap:windows-security, csstroubleshoot
ms.subservice: windows-security
---
# Suspend BitLocker protection for non-Microsoft software updates

_Applies to:_ &nbsp; Windows 10

You must temporarily disable BitLocker protection by using the **Suspend protection** feature for non-Microsoft software updates such as:

- Computer manufacturer firmware updates
- TPM firmware updates
- Non-Microsoft application updates that modify boot components

> [!Important]
> If BitLocker protection isn't suspended, the system won't recognize the BitLocker key and you'll be prompted to enter the recovery key to proceed next time the system restarts. Not having a recovery key will cause data loss or an unnecessary operating system reinstallation. This will happen every time you restart the system.

Suspending BitLocker protection on a system drive prevents certain problems and allows successful firmware and hardware updates. You can suspend BitLocker protection and resume it at any time by using the **Control Panel** or **PowerShell**.

> [!Note]
> BitLocker protection will remain disabled for a particular drive until you manually resume it.

## Suspend and resume BitLocker protection by using the Control Panel

Here's how to suspend BitLocker protection:

1. Open **Control Panel**.
2. Select **System and Security** > **BitLocker Drive Encryption** > **Suspend protection**.
3. Select **Yes**.

Here's how to resume BitLocker protection:
  
1. Open **Control Panel**.
2. Select **System and Security** > **BitLocker Drive Encryption** > **Resume protection**.
3. Select **Yes**.

## Suspend and resume BitLocker protection by using PowerShell

Here's how to suspend BitLocker protection:

1. Go to Start.
2. Go to Search, enter the word *PowerShell*, press and hold (or right-click) **Windows PowerShell**, and then select **Run as administrator**.
3. In the **Administrator: Windows PowerShell** window, enter the following command and press Enter:

    ```powershell
    Suspend-BitLocker -MountPoint "C:" -RebootCount 0 
    ```

   > [!Note]
   > In this command, the -RebootCount allows you to determine how many times your computer can restart before BitLocker protection is automatically re-enabled. You can use values from 0 to 15. A value of 0 will suspend BitLocker protection until you resume the protection manually.

Here's how to resume BitLocker protection:

1. Go to Start.
2. Go to Search, enter the word *PowerShell*, press and hold (or right-click) **Windows PowerShell**, and then select **Run as administrator**.
3. In the **Administrator: Windows PowerShell** window, enter the following command and press Enter:

    ```powershell
    Resume-BitLocker -MountPoint "C:" 
    ```

    The encryption protection feature is now enabled on your device.
