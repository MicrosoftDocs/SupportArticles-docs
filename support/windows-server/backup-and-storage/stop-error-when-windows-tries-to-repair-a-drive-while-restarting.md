---
title: Stop Error When Windows Tries to Repair a Drive While Restarting
description: This article describes an issue where a Windows device displays a drive repair prompt when it restarts. If you select the repair option, the system tries to repair the disk, but encounters a Stop error (also known as a blue screen error or bug check error). The error indicates that disk initialization failed. If you cancel the repair, the system starts successfully. Afterwards, other issues might appear.
ms.date: 01/22/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:backup, recovery, disk, and storage\data corruption and disk errors
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Stop error when Windows tries to repair a drive while restarting

## Summary

When you restart a Windows device, you might see a prompt to repair a drive. If you choose to repair the drive, the system might display a stop error (blue screen) that indicates that disk initialization failed. If you cancel the repair, Windows starts, but the device might experience drive errors.

This article describes the symptoms that characterize this issue, explains the cause, and provides step-by-step guidance to fix the issue.

## Symptoms

When Windows restarts, you see a pop-up message that prompts you to repair a drive. You perform one of the following actions:

- You select **Repair**. The device restarts, and then starts repairing the disk. The device experiences a stop error and reports that the disk initialization failed.
- You select **Cancel**. The device starts. Afterwards, if you run the Check Disk tool (`chkdsk`), the tool reports errors and then unmounts the drive.

The system might become stuck in a cycle of repair attempts followed by blue screen errors.

## Cause

This issue is typically caused by file system corruption or disk integrity problems. The corruption prevents the disk repair process from completing successfully, leading to system instability and repeated blue screen errors.

## Resolution

To resolve this issue, follow these steps:

1. Back up all data on the affected drive.
1. To check the health of the affected drive, open a Windows Command Prompt window on the device and then run the following command:

   ```console
   chkdsk <X>: /scan
   ```

   > [!NOTE]  
   >
   > - In this command. /<X> represents the letter of the affected drive.
   > - If `chkdsk` doesn't find any issues but the symptoms persist, contact Microsoft Support for further assistance.

1. To fix the drive errors, run the following command at the command prompt:

   ```console
   chkdsk <x>: /F
   ```

1. If `chkdsk` can't repair the drive because it's mounted, unmount the drive and then attach it to another Windows device. Run `chkdsk` from a command prompt on the new device.
1. If the issue persists after the repairs finish, see [Data corruption and disk errors troubleshooting guidance](troubleshoot-data-corruption-and-disk-errors.md), or contact Microsoft Support.

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue. Include this information in your support request.

- Windows version and edition (for example, Windows 11 Pro, version 23H2)
- Device model and hardware specifications
- Exact error message displayed during the blue screen
- Steps that you took before the issue occurred
- Output from running chkdsk on the affected drive
- Any recent changes to hardware or software, including updates or installations

## References

- [Check Disk (chkdsk) - Microsoft Docs](/windows-server/administration/windows-commands/chkdsk)
