---
title: Upgrade Fails and Generates Error Code 0xC1900101-0x20017
description: Provides steps to resolve Windows upgrade failures that generate error code 0xC1900101-0x20017.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-tappelgate
ms.custom:
- sap:windows setup,upgrade and deployment\installing or upgrading windows
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Upgrade fails and generates error code 0xC1900101-0x20017

This article discusses how to resolve Windows upgrade failures that generate error code 0xC1900101-0x20017. This error can affect both Windows Client and Windows Server editions.

## Symptoms

When you try to upgrade Windows, you see either of the following behaviors occur:

- The Windows upgrade process fails during the SAFE_OS or BOOT phases, or while it cleans up external drivers. In this situation, Windows rolls back to the previous version.
- The Windows upgrade appears to finish. However, the computer doesn't restart.

Additionally, you might see other error codes get returned, such as 0x00000005.

## Cause

This error typically results from driver or hardware configuration issues, or conflicts with third-party software. Such issues include the following examples:

- Outdated or incompatible drivers, especially drivers for network adapters, storage controllers, or external devices. For example, PVSCSI controllers are known to cause this issue.
- Conflicts with third-party software, including antivirus programs and security tools such as CrowdStrike.
- Incorrect driver settings, such as CSagent altitude configurations in CrowdStrike.
- Hardware configurations or dynamic update settings that interfere with the upgrade process.

## Resolution

> [!IMPORTANT]  
> Establish a robust backup and recovery plan before you upgrade the operating system, particularly in production environments.

### Step 1: Make sure that the computer satisfies the upgrade prerequisites

To verify that your computer meets the requirements for Windows or Windows Server, see the following articles:

- [Windows 11 requirements](/windows/whats-new/windows-11-requirements)
- [Hardware requirements for Windows Server](/windows-server/get-started/hardware-requirements)

### Step 2: Review event logs

Use Event Viewer to review the system logs. In particular, look for any events that might be related to driver or hardware issues.

If you identify an issue that you can fix, fix that issue and then try again to upgrade.

### Step 3: Make sure that Windows and third-party drivers are up to date

1. Use the Windows Update **Check for updates** function to make sure that any available Important updates, hardware updates, and driver updates were installed. To make sure that you installed all these updates, you might have to check for updates several times.
1. Check third-party drivers and download any updates. You can find third-party drivers and installation instructions for any hardware you added to your device on the manufacturer's website.

### Step 4: Check Device Manager for errors

1. Open Device Manager (devmgmt.msc). In the list of devices, look for any device that's marked by a yellow exclamation mark. These devices have driver errors.  

   > [!NOTE]  
   > You might have to select each category to expand the list of devices.

1. To repair a driver error, right-click the marked device, and then select either **Update Driver Software** or **Uninstall**.  

After you resolve all the errors in Device Manager, try to upgrade again.

### Step 5: Check the BIOS

Make sure that the BIOS and firmware for the device are up to date. If it's necessary, check the device manufacturer's website.

### Step 6: Repair or remove unsigned drivers

Check for any unsigned drivers, and repair or remove them. Drivers might not be properly signed in the following circumstances:

- You disabled driver signature verification (highly not recommended).
- A catalog file (file that has a *.cat extension) that's used to sign a driver is corrupted or missing. If a catalog file is corrupted or missing, the driver appears to be unsigned, even though it should be signed.

To check your system for unsigned drivers, follow these steps:  

1. Open an administrative Command Prompt window, and run the `sigverif` command.
1. In the File signature Verification tool, select **Start**.
1. After the tool runs, it provides a list of the names, locations, and versions of any unsigned drivers that it found. To see the log that the tool created, select **Advanced** > **View Log** (the log includes the unsigned driver information, and might also list the associated catalog files).
1. Check whether the identified drivers have problems. In some cases, the problem might be related to the catalog file instead of the driver itself. To perform a detailed driver check, download [sigcheck.zip](https://download.sysinternals.com/files/Sigcheck.zip), and extract the tool to a directory on your computer, for example: C:\sigcheck.
1. At the command prompt, change to the sigcheck directory (for example, run `cd c:\sigcheck`).
1. For each of the drivers that the File Signature Verification Tool lists, run `sigcheck`. For example, run the following command for each driver:  

   ```console
   sigcheck64 -i <DriverPath>
   ```

   > [!NOTE]  
   >
   > - In this command, \<DriverPath> is the driver path that the File Signature Verification Tool identified.
   > - If you run `sigcheck` on a 32-bit operating system, use `sigcheck -i` instead of `sigcheck64 -i`.  
   > - Optionally, you can use the `driverquery` tool that's included in Windows to inspect drivers. For more information, see [Two Minute Drill: DriverQuery.exe](https://techcommunity.microsoft.com/t5/ask-the-performance-team/two-minute-drill-driverquery-exe/ba-p/374977).

If you find unsigned drivers, follow these steps to repair them:  

- Check for updated versions of the drivers, and install the updates.
- Uninstall and then reinstall the drivers.
- To restore a catalog file, reinstall the driver or copy the catalog file from another device. You might have to analyze another device to identify the catalog file that's associated with the unsigned driver.

If none of these remedies succeed, uninstall the affected driver, and then try again to upgrade.

### Step 7: Remove conflicting software

1. Try to disable any third-party anti-virus and anti-malware applications
1. Reconfigure or remove software that's known to cause conflicts, such as CrowdStrike.
1. Try again to upgrade.

### Step 8: Perform a clean restart

When you start Windows by using a normal startup, several applications and services start automatically, and then run in the background. These programs include basic system processes, antivirus software, system utility applications, and other software. These applications and services can interfere with the update process.  

A clean restart, also known as a _clean boot_, starts Windows without these background applications and services. Follow these steps:  

1. Sign in to the affected computer as administrator.
1. In the search box, type **msconfig**, and then select **System Configuration**.
1. In System Configuration, select **Services** > **Hide all Microsoft services** > **Disable all**.
1. Select **Startup** > **Open Task Manager**.
1. Under **Startup** in Task Manager, select each startup item in turn, and then select **Disable**.
1. Close Task Manager.
1. In System Configuration, select **Startup** > **OK**.
1. Restart the computer.  

After the computer restarts, try again to update or upgrade it.  

> [!IMPORTANT]  
> If you see the **Download and install updates** option during the installation process, make sure that you select it.

### Step 9: Remove all nonessential external hardware

Disconnect all peripheral devices that are connected to the system, except for the mouse, keyboard, and display devices. Such devices include external storage devices and drives, docks, and other hardware that might be plugged into your device that isn't needed for basic functionality. Additionally, disconnect or disable any network adapters that you don't use for the upgrade.

After you disconnect all nonessential hardware, try again to upgrade.

> [!IMPORTANT]  
> To avoid potential driver conflicts for the disabled or removed devices, if you see the **Download and install updates** option during the installation process, make sure that it's disabled.

### Step 10: Check the number of local accounts

To check the number of user accounts that are local to the computer, follow these steps:

1. Open the Computer Management MMC snap-in (in the Search box, enter **compmgmt.msc**).
1. Select **Computer Configuration** > **System Tools** > **Local Users and Groups** > **Users**.
1. If any user accounts aren't used or are extraneous, remove them.

### Step 11: Replace the computer

If the issue persists, consider replacing the computer.

## Collect data for advanced troubleshooting and support

For troubleshooting assistance, contact Microsoft support. To provide supplemental information about your issue, collect the following information:

- The contents of the CBS log folder (%windir%\Logs\CBS).
- SetupAct.log and SetupErr.log (C:\Windows and C:$WINDOWS.~BT\Sources\Panther).
- TroubleshootingScript (TSS) tool logs. For more information, see the ["Scenario: Installing or upgrading Windows"](../windows-tss/collect-data-analyze-troubleshoot-windows-servicing-scenarios.md#scenario-installing-or-upgrading-windows) section of "Collect data to analyze and troubleshoot Windows servicing, Updates, and Features on Demand scenarios."
