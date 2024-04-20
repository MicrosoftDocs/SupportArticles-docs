---
title: Can't start Windows 11 in S mode from a recovery drive
description: Provides workarounds to an issue in which you can't start Windows 11 in S mode from a recovery drive.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, themar, degranit
ms.custom: sap:System Performance\Startup or Pre-logon Reliability (crash, errors, bug check or Blue Screen), csstroubleshoot
---
# Can't start Windows 11 in S mode from a recovery drive

Windows 11 in S mode has security policies that ensure the system runs securely. When you try to start Windows 11 in S mode from a recovery drive, the system may fail to start because of a missing policy. To work around this issue, you can copy the policy file to a designated location of the drive by using one of the following methods.

## Copy the policy file from the recovery drive

Follow these steps to check whether the recovery drive includes the policy file, and then copy the file to a designated location of the drive.

1. Insert or connect the recovery drive to your computer.
2. Open **File Explorer**, go to the *\<Recovery Drive\>:\\EFI\\Microsoft\\Boot* folder, and check if the *winsipolicy.p7b* file is in the folder.
3. If the *winsipolicy.p7b* file is in the folder, copy the file to the *\<Recovery Drive\>:\\EFI\\Boot* folder.

## Copy the policy file from another Windows computer

If the recovery drive doesn't include the policy file, copy the file from another Windows computer.

1. Insert or connect the recovery drive to another Windows computer.
2. Open **File Explorer**, go to the *C:\\Windows\\Boot\\EFI* folder, and copy the *winsipolicy.p7b* file to the *\<Recovery Drive\>:\\EFI\\Boot* folder.

## Status

This issue will be resolved in a future Windows servicing update, and this article will be updated when the servicing update is released.
