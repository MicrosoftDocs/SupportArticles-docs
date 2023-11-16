---
title: Windows 10 upgrade quick fixes
description: Learn how to quickly resolve many problems, which may come up during a Windows 10 upgrade.
ms.date: 04/28/2023
manager: dcscontentpm
ms.author: aaroncz
ms.custom: sap:setup, csstroubleshoot
ms.prod: windows-client
author: aczechowski
ms.topic: troubleshooting
ms.technology: windows-client-deployment
ms.reviewer: dougeby
audience: itpro
localization_priority: medium
---

# Windows 10 upgrade quick fixes

_Applies to:_ &nbsp; Windows 10

> [!NOTE]
> This is a 100 level topic (basic).
>
> For IT professionals, check more information in [Resolve Windows 10 upgrade errors](/windows/deployment/upgrade/resolve-windows-10-upgrade-errors).

The following list of fixes can resolve many Windows upgrade problems. You should try these steps before contacting Microsoft support, or attempting a more advanced analysis of a Windows upgrade failure. Also review information at [Windows 10 help](https://support.microsoft.com/products/windows?os=windows-10).

The Microsoft Virtual Agent provided by [Microsoft Support](https://support.microsoft.com/contactus/) can help you to analyze and correct some Windows upgrade errors.

> [!TIP]
> You might also wish to try a new tool available from Microsoft that helps to diagnose many Windows upgrade errors. For more information and to download this tool, see [SetupDiag](/windows/deployment/upgrade/setupdiag). The topic is more advanced (300 level) because several advanced options are available for using the tool. However, you can now just download and then double-click the tool to run it. By default when you click Save, the tool is saved in your *Downloads* folder. Double-click the tool in the folder and wait until it finishes running (it might take a few minutes), then double-click the *SetupDiagResults.log* file and open it using Notepad to see the results of the analysis.

## List of fixes

Here are the step-by-step instructions:

1. [Remove nonessential external hardware, such as docks and USB devices](#remove-external-hardware).
2. [Check the system drive for errors and attempt repairs](#repair-the-system-drive).
3. [Run the Windows Update troubleshooter](#windows-update-troubleshooter).
4. [Attempt to restore and repair system files](#repair-system-files).
5. [Update Windows so that all available recommended updates are installed, and ensure the computer is rebooted if it is necessary to complete installation of an update](#update-windows).
6. [Temporarily uninstall non-Microsoft antivirus software](#uninstall-non-microsoft-antivirus-software).
7. [Uninstall all nonessential software](#uninstall-non-essential-software).
8. [Update firmware and drivers](#update-firmware-and-drivers).
9. [Ensure that "Download and install updates (recommended)" is accepted at the start of the upgrade process](#ensure-that-download-and-install-updates-is-selected).
10. [Verify at least 16 GB of free space is available to upgrade a 32-bit OS, or 20 GB for a 64-bit OS](#verify-disk-space).

### Remove external hardware

If the computer is portable and it's currently in a docking station, [undock the computer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754084(v=ws.11)).

Unplug nonessential external hardware devices from the computer, such as:

- Headphones
- Joysticks
- Printers
- Plotters
- Projectors
- Scanners
- Speakers
- USB flash drives
- Portable hard drives
- Portable CD/DVD/Blu-ray drives
- Microphones
- Media card readers
- Cameras/Webcams
- Smart phones
- Secondary monitors, keyboards, mice

For more information about disconnecting external devices, see [Safely remove hardware in Windows 10](https://support.microsoft.com/help/4051300/windows-10-safely-remove-hardware)

### Repair the system drive

The system drive is the drive that contains the [system partition](/windows-hardware/manufacture/desktop/hard-drives-and-partitions#span-idpartitionsspanspan-idpartitionsspanspan-idpartitionsspanpartitions). It is usually the C: drive.

To check and repair errors on the system drive:

1. Select **Start**.
2. Type *command*.
3. Right-click **Command Prompt** and then select **Run as administrator**.
4. If you're prompted by UAC, select **Yes**.
5. Type `chkdsk /F` and press Enter.
6. When you're prompted to schedule a check the next time the system restarts, type `Y`.
7. See the following example.

    ```console
    C:\WINDOWS\system32>chkdsk /F
    The type of the file system is NTFS.
    Cannot lock current drive.
    
    Chkdsk cannot run because the volume is in use by another
    process.  Would you like to schedule this volume to be
    checked the next time the system restarts? (Y/N) Y

    This volume will be checked the next time the system restarts.
    ```

8. Restart the computer. The computer will pause before loading Windows and perform a repair of your hard drive.

### Windows Update Troubleshooter

The Windows Update Troubleshooter tool will automatically analyze and fix problems with Windows Update, such as a corrupted download. It will also tell you if there's a pending reboot that is preventing Windows from updating.

[Download the tool for Windows 10](https://aka.ms/wudiag).

To run the tool, select the appropriate link above. Your web browser will prompt you to save or open the file. Select **open** and the tool will automatically start. The tool will walk you through analyzing and fixing some common problems.

You can also download the Windows Update Troubleshooter by starting the Microsoft [Virtual Agent](https://support.microsoft.com/contact/virtual-agent/), typing *update Windows*, selecting the version of Windows you're running, and then answering **Yes** when asked "Do you need help troubleshooting Windows Update?"

If any errors are displayed in the Windows Update Troubleshooter, use the Microsoft [Virtual Agent](https://support.microsoft.com/contact/virtual-agent/) to ask about these errors. The Virtual Agent will perform a search and provide a list of helpful links.

### Repair system files

This fix is also described in detail at [answers.microsoft.com](https://answers.microsoft.com/EN-US/windows/forum/all/sfc-scannow/bc609315-da1f-4775-812c-695b60477a93).

To check and repair system files:

1. Select **Start**.
2. Type *command*.
3. Right-click **Command Prompt** and then select **Run as administrator**.
4. If you're prompted by UAC, select **Yes**.
5. Type `sfc /scannow` and press Enter. See the following example:

    ```console
    C:\>sfc /scannow

    Beginning system scan.  This process will take some time.

    Beginning verification phase of system scan.
    Verification 100% complete.

    Windows Resource Protection did not find any integrity violations.
    ```

6. If you're running Windows 8.1 or later, type `DISM.exe /Online /Cleanup-image /Restorehealth` and press Enter (the `DISM` command options aren't available for Windows 7). See the following example:

    ```console
    C:\>DISM.exe /Online /Cleanup-image /Restorehealth

    Deployment Image Servicing and Management tool
    Version: 10.0.16299.15

    Image Version: 10.0.16299.309

    [==========================100.0%==========================] The restore operation completed successfully.
    The operation completed successfully.

    ```

    > [!NOTE]
    > It may take several minutes for the command operations to be completed. For more information, see [Repair a Windows Image](/windows-hardware/manufacture/desktop/repair-a-windows-image) and [Use the System File Checker tool](https://support.microsoft.com/help/929833/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system).

### Update Windows

You should ensure that all important updates are installed before attempting to upgrade. This includes updates to hardware drivers on your computer.

The Microsoft [Virtual Agent](https://support.microsoft.com/contact/virtual-agent/) can walk you through the process of making sure that Windows is updated.

Start the [Virtual Agent](https://support.microsoft.com/contact/virtual-agent/) and then type *update windows*.

Answer questions that the agent asks, and follow instructions to ensure that Windows is up to date. You can also run the [Windows Update Troubleshooter](#windows-update-troubleshooter) described above.

Select **Start**, select **Power Options**, and then restart the computer.

### Uninstall non-Microsoft antivirus software

Use Windows Defender for protection during the upgrade.

Verify compatibility information, and if desired reinstall antivirus applications after the upgrade. If you plan to reinstall the application after upgrading, be sure that you have the installation media and all required activation information before removing the program.

To remove the application, go to **Control Panel** > **Programs** > **Programs and Features** and select the antivirus application, then select **Uninstall**. Choose **Yes** when you're asked to confirm program removal.

For more information, see [Windows 7 - How to properly uninstall programs](https://support.microsoft.com/help/2601726) or [Repair or remove programs in Windows 10](https://support.microsoft.com/help/4028054/windows-repair-or-remove-programs-in-windows-10).

### Uninstall non-essential software

Outdated applications can cause problems with a Windows upgrade. Removing old or non-essential applications from the computer can therefore help.

If you plan to reinstall the application later, be sure that you have the installation media and all required activation information before removing it.

To remove programs, use the same steps as are provided [above](#uninstall-non-microsoft-antivirus-software) for uninstalling non-Microsoft antivirus software, but instead of removing the antivirus application repeat the steps for all your non-essential, unused, or out-of-date software.

### Update firmware and drivers

Updating firmware (such as the BIOS) and installing hardware drivers is an advanced task.  Don't attempt to update BIOS if you aren't familiar with BIOS settings or aren't sure how to restore the previous BIOS version if there are problems. Most BIOS updates are provided as a "flash" update. Your manufacturer might provide a tool to perform the update, or you might be required to enter the BIOS and update it manually. Be sure to save your working BIOS settings, since some updates can reset your configuration and make the computer fail to boot if (for example) a RAID configuration is changed.

Most BIOS and other hardware updates can be obtained from a website maintained by your computer manufacturer. For example, Microsoft Surface device drivers can be obtained at: [Download the latest firmware and drivers for Surface devices](/surface/manage-surface-driver-and-firmware-updates).

To obtain the proper firmware drivers, search for the most updated driver version provided by your computer manufacturer. Install these updates and reboot the computer after installation. Request assistance from the manufacturer if you have any questions.

### Ensure that "Download and install updates" is selected

When you begin a Windows Update, the setup process will ask you to **Get important updates**. Answer **Yes** if the computer you're updating is connected to the Internet. See the following example:

:::image type="content" source="media/windows-10-upgrade-quick-fixes/get-important-updates.png" alt-text="Screenshot of Window 10 Setup window which shows Get important updates." border="false":::

### Verify disk space

You can see a list of requirements for Windows 10 at [Windows 10 Specifications & System Requirements](https://www.microsoft.com/windows/windows-10-specifications). One of the requirements is that enough hard drive space be available for the installation to take place. At least 16 GB of free space must be available on the system drive to upgrade a 32-bit OS, or 20 GB for a 64-bit OS.

To view how much hard drive space is available on your computer, open [File Explorer](https://support.microsoft.com/help/4026617/windows-windows-explorer-has-a-new-name). In Windows 7, this was called Windows Explorer.

In **File Explorer**, select **Computer** or **This PC** on the left, then look under **Hard Disk Drives** or under **Devices and drives**. If there are multiple drives listed, the system drive is the drive that includes a Microsoft Windows logo above the drive icon.

The amount of space available on the system drive will be displayed under the drive. See the following example:

:::image type="content" source="media/windows-10-upgrade-quick-fixes/system-drive-space-available.png" alt-text="Screenshot of the system drive with the amount of available space.":::

In the previous example, there's 703 GB of available free space on the system drive (C:).

To free up more space on the system drive, begin by running Disk Cleanup. You can access Disk Cleanup by right-clicking the hard drive icon and then clicking Properties. See the following example:

:::image type="content" source="media/windows-10-upgrade-quick-fixes/disk-cleanup-option.png" alt-text="Screenshot of the system drive properties with the disk cleanup option on the general tab.":::

For instructions to run Disk Cleanup and other suggestions to free up hard drive space, see [Tips to free up drive space on your PC](https://support.microsoft.com/help/17421/windows-free-up-drive-space).

When you run Disk Cleanup and enable the option to Clean up system files, you can remove previous Windows installations, which can free a large amount of space. You should only do this if you don't plan to restore the old OS version.

### Open an elevated command prompt

> [!TIP]
> It is no longer necessary to open an elevated command prompt to run the [SetupDiag](/windows/deployment/upgrade/setupdiag) tool. However, this is still the optimal way to run the tool.

To launch an elevated command prompt, press the Windows key on your keyboard, type *cmd*, press Ctrl+Shift+Enter, and then select **Yes** to confirm the elevation prompt. For more information about screenshots and other steps to open an elevated command prompt, see [Command Prompt (Admin) Windows 7](https://answers.microsoft.com/EN-US/windows/forum/windows_7-security/command-prompt-admin-windows-7/6a188166-5e23-461f-b468-f325688ec8c7).

> [!NOTE]
> When you open an elevated command prompt, you will usually start in the *C:\\WINDOWS\\system32* directory. To run a program that you recently downloaded, you must change to the directory where the program is located. Alternatively, you can move or copy the program to a directory in your PATH variable. These directories are automatically searched. Type `echo %PATH%` to see the directories in your PATH variable.

Another option is to use File Explorer to create a new folder under C: with a short name such as "new" then copy or move the programs you want to run (like SetupDiag) to this folder using File Explorer. When you open an elevated command prompt, change to this directory by typing `cd c:\new`, and now you can run the programs in that folder.

If you downloaded the *SetupDiag.exe* program to your computer, then copied it to the folder *C:\new*, and you opened an elevated command prompt then typed `cd c:\new` to change to this directory, you can just type `setupdiag` and press Enter to run the program. This program will analyze the files on your computer to see why a Windows Upgrade failed and if the reason was a common one, it will report this reason. It will not fix the problem for you but knowing why the upgrade failed enables you to take steps to fix the problem.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).

## Reference

- [Windows 10 FAQ for IT professionals](/windows/deployment/planning/windows-10-enterprise-faq-itpro)
- [Windows 10 Enterprise system requirements](https://technet.microsoft.com/windows/dn798752.aspx)
- [Windows 10 Specifications](https://www.microsoft.com/windows/Windows-10-specifications)
- [Windows 10 IT pro forums](https://social.technet.microsoft.com/Forums/en-US/home?category=Windows10ITPro)
- [Fix Windows Update errors by using the DISM or System Update Readiness tool](../../windows-server/deployment/fix-windows-update-errors.md)
