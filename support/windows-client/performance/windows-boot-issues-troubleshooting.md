---
title: Windows boot issues troubleshooting
description: Learn to troubleshoot when Windows can't boot. This article includes advanced troubleshooting techniques intended for use by support agents and IT professionals.
ms.date: 02/08/2023
ms.service: windows-client
ms.subservice: performance
author: aczechowski
ms.author: aaroncz
manager: dcscontentpm
ms.topic: troubleshooting
ms.collection: highpri
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
ms.reviewer: dougeby
audience: itpro
localization_priority: medium
---
# Advanced troubleshooting for Windows boot problems

<p class="alert is-flex is-primary"><span class="has-padding-left-medium has-padding-top-extra-small"><a class="button is-primary" href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=boot" target='_blank'><b>Try our Virtual Agent</b></a></span><span class="has-padding-small"> - It can help you quickly identify and fix common Windows boot issues.</span>

> [!NOTE]
> This article is intended for use by support agents and IT professionals. If you're looking for more general information about recovery options, see [Recovery options in Windows 10](https://support.microsoft.com/windows/recovery-options-in-windows-31ce2444-7de3-818c-d626-e3b5a3024da5).

_Applies to:_ &nbsp; Windows 10

## Summary

There are several reasons why a Windows-based computer may have problems during startup. To troubleshoot boot problems, first determine in which of the following phases the computer gets stuck:

|   Phase   |     Boot Process     |                BIOS                |               UEFI                |
|-----------|----------------------|------------------------------------|-----------------------------------|
|     1     |       PreBoot        |      MBR/PBR (Bootstrap Code)      |           UEFI Firmware           |
|     2     | Windows Boot Manager |       %SystemDrive%\bootmgr        | \EFI\Microsoft\Boot\bootmgfw.efi  |
|     3     |  Windows OS Loader   | %SystemRoot%\system32\winload.exe  | %SystemRoot%\system32\winload.efi |
|     4     | Windows NT OS Kernel | %SystemRoot%\system32\ntoskrnl.exe |                                   |

1. PreBoot: The PC's firmware initiates a power-on self test (POST) and loads firmware settings. This pre-boot process ends when a valid system disk is detected. Firmware reads the master boot record (MBR), and then starts Windows Boot Manager.
2. Windows Boot Manager: Windows Boot Manager finds and starts the Windows loader (Winload.exe) on the Windows boot partition.
3. Windows operating system loader: Essential drivers required to start the Windows kernel are loaded and the kernel starts to run.
4. Windows NT OS Kernel: The kernel loads into memory the system registry hive and other drivers that are marked as BOOT_START.

    The kernel passes control to the session manager process (Smss.exe) which initializes the system session, and loads and starts the devices and drivers that aren't marked BOOT_START.

<a name="boot-sequence"></a>

Here's a summary of the boot sequence, what will be seen on the display, and typical boot problems at that point in the sequence. Before you start troubleshooting, you have to understand the outline of the boot process and display status to ensure that the issue is properly identified at the beginning of the engagement. Select the thumbnail to view it larger.

:::image type="content" source="media/windows-boot-issues-troubleshooting/boot-sequence-thumb.png" alt-text="Diagram of the boot sequence flowchart." border="false" lightbox="media/windows-boot-issues-troubleshooting/boot-sequence-thumb-expanded.png":::

Each phase has a different approach to troubleshooting. This article provides troubleshooting techniques for problems that occur during the first three phases.

> [!NOTE]
> If the computer repeatedly boots to the recovery options, run the following command at a command prompt to break the cycle:
>
> `Bcdedit /set {default} recoveryenabled no`
>
> If the F8 options don't work, run the following command:
>
> `Bcdedit /set {default} bootmenupolicy legacy`

## BIOS phase

To determine whether the system has passed the BIOS phase, follow these steps:

1. If there are any external peripherals connected to the computer, disconnect them.
2. Check whether the hard disk drive light on the physical computer is working. If it's not working, this dysfunction indicates that the startup process is stuck at the BIOS phase.
3. Press the NumLock key to see whether the indicator light toggles on and off. If it doesn't toggle, this dysfunction indicates that the startup process is stuck at BIOS.

   If the system is stuck at the BIOS phase, there may be a hardware problem.

## Boot loader phase

If the screen is black except for a blinking cursor, or if you receive one of the following error codes, this status indicates that the boot process is stuck in the Boot Loader phase:

- Boot Configuration Data (BCD) missing or corrupted
- Boot file or MBR corrupted
- Operating system Missing
- Boot sector missing or corrupted
- Bootmgr missing or corrupted
- Unable to boot due to system hive missing or corrupted

To troubleshoot this problem, use Windows installation media to start the computer, press Shift+F10 for a command prompt, and then use any of the following methods.

### Method 1: Startup repair tool

The Startup Repair tool automatically fixes many common problems. The tool also lets you quickly diagnose and repair more complex startup problems. When the computer detects a startup problem, the computer starts the Startup Repair tool. When the tool starts, it performs diagnostics. These diagnostics include analyzing startup log files to determine the cause of the problem. When the Startup Repair tool determines the cause, the tool tries to fix the problem automatically.

To do this task of invoking the Startup Repair tool, follow these steps.

> [!NOTE]
> For additional methods to start WinRE, see [Windows Recovery Environment (Windows RE)](/windows-hardware/manufacture/desktop/windows-recovery-environment--windows-re--technical-reference#entry-points-into-winre).

1. Start the system to the installation media for the installed version of Windows. For more information, see [Create installation media for Windows](https://support.microsoft.com/windows/create-installation-media-for-windows-99a58364-8c02-206f-aa6f-40c3b507420d).
2. On the **Install Windows** screen, select **Next** > **Repair your computer**.
3. On the **Choose an option** screen, select **Troubleshoot**.
4. On the **Advanced options** screen, select **Startup Repair**.
5. After Startup Repair, select **Shutdown**, then turn on your PC to see if Windows can boot properly.

The Startup Repair tool generates a log file to help you understand the startup problems and the repairs that were made. You can find the log file in the following location:

*%windir%\\System32\\LogFiles\\Srt\\Srttrail.txt*

For more information, see [Troubleshoot blue screen errors](https://support.microsoft.com/sbs/windows/troubleshoot-blue-screen-errors-5c62726c-6489-52da-a372-3f73142c14ad).

### Method 2: Repair boot codes

To repair boot codes, run the following command:

```console
BOOTREC /FIXMBR
```

To repair the boot sector, run the following command:

```console
BOOTREC /FIXBOOT
```

> [!NOTE]
> Running `BOOTREC` together with `Fixmbr` overwrites only the master boot code. If the corruption in the MBR affects the partition table, running `Fixmbr` may not fix the problem.

### Method 3: Fix BCD errors

If you receive BCD-related errors, follow these steps:

1. Scan for all the systems that are installed. To do this step, run the following command:

   ```console
   Bootrec /ScanOS
   ```

2. Restart the computer to check whether the problem is fixed.
3. If the problem isn't fixed, run the following commands:

    ```console
    bcdedit /export c:\bcdbackup
    
    attrib c:\boot\bcd -r -s -h
    
    ren c:\boot\bcd bcd.old
    
    bootrec /rebuildbcd
    ```

4. Restart the system.

### Method 4: Replace Bootmgr

If methods 1, 2 and 3 don't fix the problem, replace the Bootmgr file from drive C to the System Reserved partition. To do this replacement, follow these steps:

1. At a command prompt, change the directory to the System Reserved partition.
2. Run the `attrib` command to unhide the file:

    ```console
    attrib -r -s -h
    ```

3. Navigate to the system drive and run the same command:

    ```console
    attrib -r -s -h
    ```

4. Rename the bootmgr file as *bootmgr.old*:

    ```console
    ren c:\bootmgr bootmgr.old
    ```

5. Navigate to the system drive.
6. Copy the bootmgr file, and then paste it to the System Reserved partition.
7. Restart the computer.

### Method 5: Restore system hive

If Windows can't load the system registry hive into memory, you must restore the system hive. To do this step, use the Windows Recovery Environment or use the Emergency Repair Disk (ERD) to copy the files from the *C:\\Windows\\System32\\config\\RegBack* directory to *C:\\Windows\\System32\\config*.

If the problem persists, you may want to restore the system state backup to an alternative location, and then retrieve the registry hives to be replaced.

> [!NOTE]
> Starting in Windows 10, version 1803, Windows no longer automatically backs up the system registry to the RegBack folder.This change is by design, and is intended to help reduce the overall disk footprint size of Windows. To recover a system with a corrupt registry hive, Microsoft recommends that you use a system restore point. For more information, see [The system registry is no longer backed up to the RegBack folder starting in Windows 10 version 1803](../deployment/system-registry-no-backed-up-regback-folder.md).

## Kernel phase

If the system gets stuck during the kernel phase, you experience multiple symptoms or receive multiple error messages. These error messages include, but aren't limited to, the following examples:

- A Stop error appears after the splash screen (Windows Logo screen).
- Specific error code is displayed. For example, `0x00000C2`, `0x0000007B`, or `inaccessible boot device`.
  - [Advanced troubleshooting for Stop error 7B or Inaccessible_Boot_Device](./stop-error-7b-or-inaccessible-boot-device-troubleshooting.md)
  - [Advanced troubleshooting for Event ID 41 "The system has rebooted without cleanly shutting down first"](/windows/client-management/troubleshoot-event-id-41-restart)
- The screen is stuck at the "spinning wheel" (rolling dots) "system busy" icon.
- A black screen appears after the splash screen.

To troubleshoot these problems, try the following recovery boot options one at a time.

### Scenario 1: Try to start the computer in Safe mode or Last Known Good Configuration

On the **Advanced Boot Options** screen, try to start the computer in **Safe Mode** or **Safe Mode with Networking**. If either of these options works, use Event Viewer to help identify and diagnose the cause of the boot problem. To view events that are recorded in the event logs, follow these steps:

1. Use one of the following methods to open Event Viewer:

    - Go to the **Start** menu, select **Administrative Tools**, and then select **Event Viewer**.
    - Start the Event Viewer snap-in in Microsoft Management Console (MMC).

2. In the console tree, expand Event Viewer, and then select the log that you want to view. For example, choose **System log** or **Application log**.

3. In the details pane, open the event that you want to view.

4. On the **Edit** menu, select **Copy**. Open a new document in the program in which you want to paste the event. For example, Microsoft Word. Then select **Paste**.

5. Use the up arrow or down arrow key to view the description of the previous or next event.

### Clean boot

To troubleshoot problems that affect services, do a clean boot by using System Configuration (`msconfig`).
Select **Selective startup** to test the services one at a time to determine which one is causing the problem. If you can't find the cause, try including system services. However, in most cases, the problematic service is third-party.

Disable any service that you find to be faulty, and try to start the computer again by selecting **Normal startup**.

For detailed instructions, see [How to perform a clean boot in Windows](https://support.microsoft.com/topic/how-to-perform-a-clean-boot-in-windows-da2f9573-6eec-00ad-2f8a-a97a1807f3dd).

If the computer starts in Disable Driver Signature mode, start the computer in Disable Driver Signature Enforcement mode, and then follow the steps that are documented in the following article to determine which drivers or files require driver signature enforcement:
[Troubleshooting boot problem caused by missing driver signature (x64)](/archive/blogs/askcore/troubleshooting-boot-issues-due-to-missing-driver-signature-x64)

> [!NOTE]
> If the computer is a domain controller, try Directory Services Restore mode (DSRM).
>
> This method is an important step if you encounter Stop error "0xC00002E1" or "0xC00002E2"

#### Examples

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

> Error code INACCESSIBLE_BOOT_DEVICE (STOP 0x7B)

To troubleshoot this Stop error, follow these steps to filter the drivers:

1. Go to Windows Recovery Environment (WinRE) by putting an ISO disk of the system in the disk drive. The ISO should be of the same version of Windows or a later version.
2. Open the registry.
3. Load the system hive, and name it *test*.
4. Under the following registry subkey, check for lower filter and upper filter items for non-Microsoft drivers:

    `HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class`

5. For each third-party driver that you locate, select the upper or lower filter, and then delete the value data.
6. Search through the whole registry for similar items. Process as appropriate, and then unload the registry hive.
7. Restart the server in Normal mode.

For more troubleshooting steps, see [Advanced troubleshooting for Stop error 7B or Inaccessible_Boot_Device](./stop-error-7b-or-inaccessible-boot-device-troubleshooting.md).

To fix problems that occur after you install Windows updates, check for pending updates by using these steps:

1. Open a Command Prompt window in WinRE.
2. Run the command:

    ```console
    DISM /image:C:\ /get-packages
    ```

3. If there are any pending updates, uninstall them by running the following commands:

    ```console
    DISM /image:C:\ /remove-package /packagename: name of the package

    DISM /Image:C:\ /Cleanup-Image /RevertPendingActions
    ```

    Try to start the computer.

If the computer doesn't start, follow these steps:

1. Open a command prompt window in WinRE, and start a text editor, such as Notepad.
2. Navigate to the system drive, and search for *windows\\winsxs\\pending.xml*.
3. If the *pending.xml* file is found, rename the file as *pending.xml.old*.
4. Open the registry, and then load the component hive in HKEY_LOCAL_MACHINE as test.
5. Highlight the loaded test hive, and then search for the pendingxmlidentifier value.
6. If the pendingxmlidentifier value exists, delete it.
7. Unload the test hive.
8. Load the system hive, name it *test*.
9. Navigate to the following subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\TrustedInstaller`

10. Change the **Start** value from **1** to **4**.
11. Unload the hive.
12. Try to start the computer.

If the Stop error occurs late in the startup process, or if the Stop error is still being generated, you can capture a memory dump. A good memory dump can help determine the root cause of the Stop error. For more information, see [Generate a kernel or complete crash dump](./generate-a-kernel-or-complete-crash-dump.md).

For more information about page file problems in Windows 10 or Windows Server 2016, see [Introduction to page files](./introduction-to-the-page-file.md).

For more information about Stop errors, see [Advanced troubleshooting for Stop error or blue screen error issue](./stop-error-or-blue-screen-error-troubleshooting.md).

Sometimes the dump file shows an error that's related to a driver. For example, *windows\\system32\\drivers\\stcvsm.sys* is missing or corrupted. In this instance, follow these guidelines:

- Check the functionality that's provided by the driver. If the driver is a third-party boot driver, make sure that you understand what it does.
- If the driver isn't important and has no dependencies, load the system hive, and then disable the driver.
- If the stop error indicates system file corruption, run the system file checker in offline mode.

  - To do this action, open WinRE, open a command prompt, and then run the following command:

    ```console
    SFC /Scannow /OffBootDir=C:\ /OffWinDir=C:\Windows
    ```

    For more information, see [Using system file checker (SFC) to fix issues](/archive/blogs/askcore/using-system-file-checker-sfc-to-fix-issues).

  - If there's disk corruption, run the check disk command:

    ```console
    chkdsk /f /r
    ```

- If the Stop error indicates general registry corruption, or if you believe that new drivers or services were installed, follow these steps:

  1. Start WinRE, and open a command prompt window.
  2. Start a text editor, such as Notepad.
  3. Navigate to *C:\\Windows\\System32\\Config\\*.
  4. Rename the all five hives by appending `.old` to the name.
  5. Copy all the hives from the *Regback* folder, paste them in the *Config* folder, and then try to start the computer in Normal mode.

> [!NOTE]
> Starting in Windows 10, version 1803, Windows no longer automatically backs up the system registry to the RegBack folder.This change is by design, and is intended to help reduce the overall disk footprint size of Windows. To recover a system with a corrupt registry hive, Microsoft recommends that you use a system restore point. For more information, see [The system registry is no longer backed up to the RegBack folder starting in Windows 10 version 1803](../deployment/system-registry-no-backed-up-regback-folder.md).
