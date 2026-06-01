---
title: Stop error when Windows tries to repair a drive while restarting
description: This article describes an issue in which a Windows device displays a drive repair prompt when it restarts, and the system experiences a stop error.
ms.date: 02/12/2026
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

When you restart a Windows device, you see a prompt to repair a drive. If you choose to repair the drive, the system displays a stop error (blue screen) that indicates that disk initialization failed. If you cancel the repair, Windows starts, but the device experiences drive errors.

This article describes the symptoms that characterize this issue, explains the cause, and provides step-by-step guidance to fix the issue.

## Symptoms

When Windows restarts, you see a pop-up message that prompts you to repair a drive. You perform one of the following actions:

- You select **Repair**. The device restarts, and then starts repairing the disk. The device experiences a stop error, and reports that the disk initialization failed.
- You select **Cancel**. The device starts. Then, if you run the Check Disk tool (`chkdsk`), the tool reports errors and unmounts the drive.

After either action, the system might become stuck in a cycle of repair attempts followed by blue screen errors.

## Cause

Typically, this issue indicates file system corruption or disk integrity problems. The corruption prevents the disk repair process from finishing successfully. In turn, the failed repair process causes system instability and repeated blue screen errors.

## Resolution

To resolve this issue, follow these steps:

1. Back up all data on the affected drive.
1. To check the health of the affected drive, open a Windows Command Prompt window on the device, and then run the following command:

   ```console
   chkdsk <X>: /scan
   ```

   > [!NOTE]  
   >
   > - In this command. \<X> represents the letter of the affected drive.
   > - If `chkdsk` doesn't find any issues but the symptoms persist, contact Microsoft Support for further assistance.

1. To fix the drive errors, run the following command at the command prompt:

   ```console
   chkdsk <X>: /F
   ```

1. If `chkdsk` can't repair the drive because the drive is mounted, unmount the drive, and then attach it to another Windows device. Run `chkdsk` at a command prompt on the new device.
1. If the issue persists after the repairs finish, see [Data corruption and disk errors troubleshooting guidance](troubleshoot-data-corruption-and-disk-errors.md), or contact Microsoft Support.

## Data collection

Before you contact Microsoft Support, you can gather the following information about your issue. Include this information in your support request.

- Windows version and edition (for example, Windows 11 Pro, version 23H2)
- Device model and hardware specifications
- Exact error message that you receive during the blue screen
- Steps that you took before the issue occurred
- Output from running chkdsk on the affected drive
- Any recent changes to hardware or software, including updates and installations

## References

- [Check Disk (chkdsk) - Microsoft Docs](/windows-server/administration/windows-commands/chkdsk)
