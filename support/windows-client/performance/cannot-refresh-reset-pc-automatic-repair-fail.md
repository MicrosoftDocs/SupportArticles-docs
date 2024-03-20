---
title: Can't refresh or reset PC after Automatic Repair fails in Windows 8
description: Fixes an issue in which you can't refresh or reset your PC after Automatic Repair fails in Windows 8.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:System Performance\Startup or Pre-logon Reliability (crash, errors, bug check or Blue Screen), csstroubleshoot
---
# Unable to refresh or reset PC after Automatic Repair fails in Windows 8

This article fixes an issue in which you cannot refresh or reset the PC after Automatic Repair fails.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2823223

## Symptoms

Consider the following scenario:

- You have Windows 8 or Windows 8 Pro installed on your PC.
- Your PC fails to boot into Windows and launches Automatic Repair to attempt to repair Windows.
- Automatic Repair is unable to repair your PC and you select **Advanced options**.
- After selecting **Troubleshoot**, you choose to either **Refresh your PC** or **Reset your PC**.

In this scenario, recovery may fail and you're returned back to the main WinRE screen.

## Cause

This issue may occur if the System or Software registry hives have become damaged or corrupted.

## Resolution

To attempt to resolve this issue, follow the steps below.

> [!NOTE]
> These steps should only be used if you're attempting to use the **Refresh your PC** or **Reset your PC** options in Windows RE because your system is in a non-bootable state.

1. After Automatic Repair fails to repair your PC, select **Advanced options** and then **Troubleshoot**.
2. Select **Advanced options** and then select Command Prompt.
3. If prompted, enter in the password for the user name.
4. At the Command Prompt, go to the \windows\system32\config folder by typing the following command:

    ```console
    cd %windir%\system32\config
    ```

5. Rename the System and Software registry hives to System.001 and Software.001 by using the following commands:

    ```console
    ren system system.001  
    ren software software.001
    ```

    > [!NOTE]
    > Renaming the Software hive won't allow you to use the "Refresh your PC" option. If you want to use the "Refresh your PC" option, only rename the System hive. If the Software hive is also corrupt, you may not be able to use the "Refresh your PC" option.
6. Type *exit* without the quotes to exit the Command Prompt and reboot the PC back to the Automatic Repair screen.
7. After selecting **Advanced options** and then **Troubleshoot**, select either **Refresh your PC** or **Reset your PC**.

## More information

Using the **Reset your PC** option will remove all of the files on your hard drive and resets your PC back to the version of Windows 8 that was preinstalled by the OEM on your PC. All new applications that were installed on your PC after you purchased it will need to be reinstalled.
