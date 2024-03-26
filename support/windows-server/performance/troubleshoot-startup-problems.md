---
title: Troubleshoot startup problems
description: Describes procedures that you can use to troubleshoot startup problems in Windows Server 2003.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:System Performance\Startup or Pre-logon Performance (slow, unresponsive, spinning circle, blank screen), csstroubleshoot
---
# How to troubleshoot startup problems in Windows Server 2003

This article describes procedures that you can use to troubleshoot startup problems in Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 325375

> [!NOTE]
> For a Windows XP version of this article, see [308041](https://support.microsoft.com/help/308041).

## Summary

A successful Windows startup includes the following phases:  

- Initial phase
- Boot loader phase
- Kernel phase
- Logon phase

If a problem occurs during any of these phases, Windows may not start correctly, and you may experience the following problems:

- The computer stops responding (hangs).
- You receive an error message.

Assume that a startup problem occurs after you select **Microsoft Windows Server 2003** on the boot loader menu, or when you receive the "Please select the operating system to start" message. In this situation, files that the operating system needs may be missing or damaged.

Windows provides several options that you can use to troubleshoot this issue, including:

- Safe mode
- The Recovery Console
- An Automated System Recovery

## How to start the computer by using the last known good configuration

If the startup problem occurs immediately after you make a change to the computer (for example, after you install a new driver), try to start the computer by using the Last Known Good Configuration feature.

When you use the Last Known Good Configuration feature, you start your computer by using the most recent settings that worked. This feature restores registry information and driver settings that were in effect the last time that the computer started successfully. Use this feature when you can't start Windows after you make a change to the computer. For example, after you install or upgrade a device driver.

To start the computer by using Last Known Good Configuration, follow these steps:  

1. Select **Start** > **Shut Down**.
2. Select **Restart**, and then select **OK**.
3. When you see the "Please select the operating system to start" message, press the F8 key.
4. Use the arrow keys to select **Last Known Good Configuration**, and then press Enter.

    > [!NOTE]
    > NUM LOCK must be off before the arrow keys on the numeric keypad will function.  

5. If you're running other operating systems on the computer, select **Microsoft Windows Server 2003** on the list, and then press Enter.

    > [!NOTE]
    >
    > - By selecting Last Known Good Configuration, you can recover from problems such as a newly added driver that may be incorrect for your hardware. This feature doesn't solve problems caused by corrupted or missing drivers or files.
    > - When you select Last Known Good Configuration, only the information in the following registry key is restored: `HKLM\System\CurrentControlSet` Any changes that you have made in other registry keys remain.  

If you can start your computer by using the Last Known Good Configuration feature, the last change that you made to the computer (for example, the installation of a driver) may be the cause of the incorrect startup behavior. We recommend you either remove or update the driver or program, and then test Windows to see if it starts correctly.  

## How to start the computer in safe mode

When you start the computer in safe mode, Windows loads only the drivers and computer services that you need. You can use safe mode when you have to identify and resolve problems that are caused by faulty drivers, programs, or services that start automatically.

If the computer starts successfully in safe mode but it doesn't start in normal mode, the computer may have a conflict with the hardware settings or the resources. There may be incompatibilities with programs, services, or drivers, or there may be registry damage. In safe mode, you can disable or remove a program, service, or device driver that may prevent the computer from starting correctly.

To troubleshoot startup problems in safe mode, follow these steps:  

1. Select Start > Shut Down.
2. Select Restart, and then select OK.
3. When you see the "Please select the operating system to start" message, press F8.
4. On the **Windows Advanced Option Menu**, use the arrow keys to select Safe Mode, and then press Enter.

    > [!NOTE]
    > Num Lock must be off before the arrow keys on the numeric keypad will function.  

5. If you're running other operating systems on the computer, select **Microsoft Windows Server 2003** on the list, and then press Enter.  
6. Take one of the following actions:  

    - If the computer doesn't start in safe mode, try starting the computer by using the Recovery Console. If you still can't start the computer, look for possible hardware problems, such as defective devices, installation problems, cabling problems, or connector problems. Remove any hardware that was added recently, and then restart the computer to see if the problem is resolved.
    - If the computer starts in safe mode, go to the next section to continue to troubleshoot the startup issue.  

## Use Event Viewer to identify the cause of the startup problem

View the event logs in Event Viewer for information that can help you identify and diagnose the cause of the startup problem. To view events that are recorded in the event logs, follow these steps.  

1. Take one of the following actions:
   - Select **Start**, point to **Administrative Tools**, and then select Event Viewer.
   - Start the Event Viewer snap-in in Microsoft Management Console (MMC).
2. In the console tree, expand Event Viewer, and then select the log that you want to view. For example, select **System log** or **Application log**.
3. In the details pane, double-click the event that you want to view.

    To copy the details of the event, select Copy, open a new document in the program in which you want to paste the event (for example, Microsoft Word), and then select Paste on the Edit menu.
4. To view the description of the previous event or the next event, press the UP ARROW key or the DOWN ARROW key.  

## Use System Information to identify the cause of the startup problem

The System Information tool displays a comprehensive view of the computer's hardware, the system components, and the software environment. Use this tool to help identify possible problem devices and device conflicts by following these steps.  

1. Select **Start** > **Run**.
2. In the Open box, type msinfo32, and then select **OK**.
3. Look for problem devices or device conflicts by following these steps:
   1. In the console tree, expand Components, and then select Problem Devices.

        > [!NOTE]
        > Any devices that are listed in the right pane.

   2. In the console tree, expand Hardware Resources, and then select Conflicts/Sharing.

        > [!NOTE]
        > Any resource conflicts that are listed in the right pane.

   3. If you identify a problem device, perform the appropriate action. For example, remove, disable, or reconfigure the device, or update the driver. Then restart the computer in normal mode.

        You can use Device Manager to remove or disable devices and their drivers.

        If the computer starts correctly, that particular device may be the cause of the startup problem.

        If you disabled a device to resolve the problem, make sure that the device is listed on the Windows Server 2003 Hardware Compatibility List (HCL), and that it's installed correctly. Also, contact the manufacturer to report the behavior and to obtain information about possible updates that can resolve the startup problem.

        Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.  

4. If no problem devices or device conflicts are reported by the System Information tool, look for programs that start automatically when Windows starts. To do so, follow these steps:
   1. In the console tree, expand Software Environment, and then select Startup Programs.

      Programs that start automatically when Windows starts are listed in the right pane.
   2. Disable the programs, and then restart the computer.

      For information about how to disable the program, see the program documentation or contact the manufacturer.
   3. If you disable the startup programs and the startup problem is resolved, enable the programs again, one at a time.

        Shut down and restart the computer every time that you enable a program, and note if the incorrect startup behavior occurs. If the behavior occurs, the last program that you enabled may be causing the incorrect startup behavior.  

## View the safe mode boot log file

To troubleshoot startup issues, view the Ntbtlog.txt boot log file, and then make a note of the drivers and services that didn't load when you started your computer in safe mode.

This log file is located in the %SystemRoot% folder (by default, this is the Windows folder). The log file lists devices and services that load (and don't load) when you start the computer in safe mode. You can use any text editor, such as Notepad, to open and view the log file.

Use the list of drivers and services that didn't load at startup to help identify the possible cause of the startup problem.

> [!NOTE]
> Some startup problems may occur early in the startup process. In this scenario, Windows may not save the boot log file to the hard disk.  

## Use Device Manager to identify the cause of the startup problem

Device Manager displays a graphical view of the hardware that is installed on your computer. Use this tool to resolve any possible device conflicts or to identify incompatible devices that may be the cause of the startup problem.

To start Device Manager, follow these steps.  

1. Select Start, right-click My Computer, and then select Manage.
2. Expand System Tools, and then select Device Manager.

    The devices that are installed on your computer are listed in the right pane. If a symbol is displayed next to a device, there may be a problem with the device. For example, a black exclamation point (!) on a yellow field indicates that the device is in a problem state.

    > [!NOTE]
    > To disable a device in Device Manager, right-click the device, and then select Disable .
3. Investigate possible device conflicts. To do so, double-click the device in the right pane, and then select the Resources tab.

    If a device conflict exists, it's listed under **Conflicting device list**.

    Note the **Use automatic settings** check box. If Windows successfully detects a device, this check box is selected, and the device functions correctly. However, if the resource settings are based on Basic Configuration **n** (where **n** is any number from 0 to 9), you may have to change the configuration. To do so, either select a different basic configuration from the list or manually change the resource settings.
    > [!WARNING]
    > This procedure may require you to change the computer's complementary metal oxide semiconductor (CMOS) settings and the basic input/output system (BIOS) settings. Incorrect changes to the BIOS of the computer can result in serious problems. Change the computer's CMOS settings at your own risk.

    If Windows can't resolve a resource conflict, verify that the computer is configured to allow Windows to enumerate the devices in the computer. To do so, enable the **Plug and Play OS** setting in the Setup tool of the computer's BIOS. To change the computer's BIOS settings, see the computer documentation or contact your computer manufacturer.

4. If you identify a problem device, disable it, and then restart the computer in normal mode.

    If the computer starts correctly, the device that you disabled may be the cause of the startup problem.

    Make sure that the device is listed on the Windows Server 2003 Hardware Compatibility List (HCL) and it's installed correctly. Also, contact the manufacturer to report the behavior and to obtain information about possible updates that can resolve the startup problem.  

For more information about how to configure devices in Device Manager, see [How to use Device Manager to configure devices in Windows Server 2003](https://support.microsoft.com/help/323423).   

## How to use System Configuration Utility  

System Configuration Utility (Msconfig.exe) automates the routine troubleshooting steps that Microsoft Support technicians use when they diagnose Windows configuration issues. You can use this tool to change the system configuration and troubleshoot the problem by using a process-of-elimination method.

You must be logged on as Administrator or as a member of the administrative groups to use System Configuration Utility. If your computer is connected to a network, network policy settings may prevent you from using the utility. As a security best practice, consider using the **Run as** command to perform these procedures.

> [!NOTE]
> We recommend that you don't use System Configuration Utility to modify the Boot.ini file on your computer without the help of a Microsoft Support professional because it may make your computer unusable.  

## Create a clean environment for troubleshooting

To create a clean environment for troubleshooting, follow these steps.  

1. Select **Start** > **Run**, type `msconfig` in the Open box, and then select OK. (To use the **Run as** command, type `runas /user: administrator Path \msconfig.exe` in the Open box, and then select OK.)
2. Select the General tab, select **Diagnostic startup - load basic devices and services only**, select OK, and then select **Restart** to restart your computer.
3. After Windows starts, determine whether the problem still occurs.  

## Isolate problems by using system startup options

To isolate problems by using System Startup options, follow these steps.  

1. Select Start > Run, type `msconfig` in the Open box, and then select OK.
2. Select the General tab, and then select Selective Startup.
3. Clear the following check boxes:  
   - Process SYSTEM.INI File  
   - Process WIN.INI File  
   - Load System Services

    You'll be unable to clear the Use Original BOOT.INI check box.

4. To test the software loading process, make sure that the Load Startup Items check box is selected, and then select OK.
5. Restart the computer when you're prompted.  

## Isolate problems by using Selective Startup options

To isolate problems by using the Selective Startup options, follow these steps.

1. Select Start > Run, type `msconfig` in the Open box, and then select OK.
2. Select the General tab, and then select Selective Startup.
3. Clear all the check boxes under Selective Startup. You'll be unable to clear the Use Original BOOT.INI check box.
4. Select the Process SYSTEM.INI File check box, select OK, and then restart the computer when you're prompted.

    Repeat this process and select each check box one at a time. Restart your computer every time. Repeat the process until the problem occurs.
5. When the problem occurs, select the tab that corresponds to the selected file. For example, if the problem occurs after you select the Win.ini file, select the WIN.INI tab in System Configuration Utility.  

## Isolate problems by using the Startup tab

The Startup tab lists items that load at startup from the Startup group, Win.ini load= and run=, and the registry. To isolate problems by using the Startup tab, follow these steps.

1. Select Start > Run, type `msconfig` in the Open box, and then select OK.
2. Select the Startup tab.
3. Clear all check boxes.
4. To start troubleshooting, select the first check box, select OK, and then restart the computer when you're prompted.

    Repeat this process and select each check box one at a time. Restart your computer every time. Repeat the process until the problem occurs.  

## Troubleshoot System Services

To troubleshoot System Services, follow these steps.

1. Select Start > Run, type `msconfig` in the Open box, and then select OK.
2. Select the Services tab.
3. Note any services that aren't selected.

    > [!IMPORTANT]
    > Don't skip this step. You'll need this information later.

4. Select Disable All, select OK, and then restart your computer.
5. Select Start > Run, type `msconfig` in the Open box, and then select OK.
6. Select the Services tab.
7. Select the check box of a service to turn it on, and then select OK.
8. Restart your computer, and see whether the problem occurs.
9. Repeat steps 5 through 8 for each service until the problem occurs. When the problem occurs, you'll know that the last service that you turned on is causing the problem. Note this service, and then go to step 10.
10. Select Enable All, the check box next to the faulty service, clear the check boxes of any other services that you noted in step 3, select OK, and then restart your computer.

    As a workaround, you can leave the faulty service turned off (not selected). Contact the manufacturer of the faulty service for more assistance.

    > [!NOTE]
    > You may be able to determine more quickly which service is causing the problem by testing the services in groups. Divide the services into two groups by selecting the check boxes of the first group, and then clearing the check boxes of the second group. Restart your computer, and then test for the problem. If the problem occurs, the faulty service is in the first group. If the problem doesn't occur, the faulty service is in the second group. Repeat this process on the faulty group until you have isolated the faulty service.  

## Troubleshoot the System.ini file

To troubleshoot the System.ini file, follow these steps.  

1. Select Start > Run, type `msconfig` in the Open box, and then select OK.
2. Select the SYSTEM.INI tab.
3. Note any items that aren't selected. You might have to expand some items (such as [drivers]) to determine whether any subitems aren't selected.

    > [!IMPORTANT]
    > Don't skip this step. You'll need this information later.

4. Select Disable All, select OK, and then restart your computer.
5. Select Start > Run, type `msconfig` in the Open box, and then select OK.
6. Select the SYSTEM.INI tab.
7. Expand all items in the list, select the check box of an item to turn it on, and then select OK.
8. Restart your computer, and see whether the problem occurs.
9. Repeat steps 5 through 8 for each item until the problem occurs.

    When the problem occurs, you'll know that the last item that you turned on is causing the problem. Note this item, and then go to step 10.
10. Select Enable All, clear the check box next to the faulty item, clear the check boxes of any other items that you noted in step 3, select OK, and then restart your computer.

    As a workaround, you can leave the faulty item turned off (not selected). If it's possible, contact the manufacturer of the faulty item for more assistance.

    > [!NOTE]
    > You may be able to determine more quickly which System.ini item is causing the problem by testing the items in groups. Divide the items into two groups by selecting the check boxes of the first group, and then clearing the check boxes of the second group. Restart your computer, and then test for the problem. If the problem occurs, the faulty service is in the first group. If the problem doesn't occur, the faulty service is in the second group. Repeat this process on the faulty group until you have isolated the faulty System.ini item.  

## Troubleshoot the Win.ini file

To troubleshoot the Win.ini file, follow these steps.  

1. Select Start > Run, type `msconfig` in the Open box, and then select OK.
2. Select the WIN.INI tab.
3. Note any items that aren't selected. You might have to expand some items (such as [OLFax Ports) to determine whether any subitems aren't selected.

    > [!IMPORTANT]
    > Don't skip this step. You'll need this information later.

4. Select Disable All, select OK, and then restart your computer.
5. Select Start > Run, type `msconfig` in the Open box, and then select OK.
6. Select the WIN.INI tab.
7. Expand all items in the list, select the check box of an item to turn it on, and then select OK.
8. Restart your computer, and see whether the problem occurs.
9. Repeat steps 5 through 8 for each item until the problem occurs.

    When the problem occurs, you'll know that the last item that you turned on is causing the problem. Note this item, and then go to step 10.
10. Select Enable All, clear the check box of the faulty item, clear the check boxes of any other items that you noted in step 3, select OK, and then restart your computer.

    As a workaround, you can leave the faulty item turned off (not selected). If it's possible, contact the manufacturer of the faulty item for more assistance.

    > [!NOTE]
    > You may be able to determine more quickly which Win.ini item is causing the problem by testing the items in groups. Divide the items into two groups by selecting the check boxes of the first group, and then clearing the check boxes of the second group. Restart your computer, and then test for the problem. If the problem occurs, the faulty service is in the first group. If the problem doesn't occur, the faulty service is in the second group. Repeat this process on the faulty group until you have isolated the faulty Win.ini item.  

## Troubleshoot the Boot.ini file

Only system administrators and advanced users should try to change the Boot.ini file. Steps for troubleshooting Boot.ini are beyond the scope of this article.

For more information, search the Microsoft Knowledge Base on the Microsoft Support website.  

## Reset System Configuration Utility to normal startup

To reset System Configuration Utility to normal startup, follow these steps.  

1. Select Start > Run, type `msconfig` in the Open box, and then select OK.
2. On the General tab, select **Normal Startup - load all device drivers and services**, and then select OK.
3. Restart your computer.  

## Use the Windows Recovery Console

The Recovery Console is a command-line tool that you can use to repair Windows if the computer doesn't start correctly. You can start the Recovery Console from the Windows Server 2003 CD or at startup if the Recovery Console was previously installed on your computer. Use the Recovery Console if the Last Known Good Configuration startup option was not successful, and you can't start the computer in safe mode. We recommend that you use the Recovery Console method only if you're an advanced user who can use basic commands to identify and locate problem drivers and files.

To use Recovery Console, follow these steps.

1. Insert the Windows Server 2003 installation CD in your CD drive or DVD drive, and then restart the computer.
2. When you're prompted during text-mode setup, press R to start the Recovery Console. You can use the Recovery Console to perform the following actions:

    - Access the drives on your computer.
    - Enable or disable device drivers or services.
    - Copy files from the Windows Server 2003 installation CD or copy files from other removable media. For example, you can copy a file that you need that was deleted.
    - Create a new boot sector and a new master boot record (MBR). You might have to do so if there are problems starting from the existing boot sector.  

## Confirm that your hard disk or file system is not damaged

To confirm that your hard disk or file system isn't damaged, start your computer from the Windows Server 2003 CD, start the Recovery Console, and then use the Chkdsk command prompt utility. It may resolve your problem.

> [!IMPORTANT]
> We recommend that only advanced users or administrators use the Recovery Console. You have to know the password for the Administrator account to use the Recovery Console.

For more information about how to test and repair a damaged hard disk by using Chkdsk, see the "How to use the Recovery Console" and "How to use the Recovery Console Command Prompt" sections in the following article: [307654](https://support.microsoft.com/help/307654) How to install and use the Recovery Console in Windows XP  

> [!NOTE]
> If Chkdsk reports that it can't access your hard disk, you may have a hardware failure. Examine all cable connections and any jumper settings on your drive. Contact a computer repair professional or the manufacturer of your computer for more assistance.

If Chkdsk reports that it can't fix all hard disk problems, your file system or MBR may be damaged or no longer accessible. Try to use the appropriate Recovery Console commands, such as `Fixmbr` and `Fixboot`, contact a data recovery service, or repartition and then reformat your hard disk.

> [!WARNING]
> If you repartition and reformat your hard disk, you lose all information on the disk.

> [!IMPORTANT]
> For more help, contact your computer manufacturer or a Microsoft Support professional. Only qualified personnel should try to repair your computer. If the computer repair is performed by unqualified personnel, this may nullify your computer's warranty. For more information about how to Use Recovery Console, see [How to use the Recovery Console on a Windows Server 2003-based computer that doesn't start](https://support.microsoft.com/help/326215).  

## How to use Automated System Recovery (ASR)

To recover from a system failure by using Automated System Recovery, follow these steps.

1. Make sure that you have the following available before you start the recovery procedure:
   - The ASR disk that you created before.
   - The backup media that you created before.
   - The original operating system installation CD.
   - If you have a mass storage controller and you know that the manufacturer has supplied a separate driver file for it (different from the driver files that are available on the Setup CD), obtain the file (on a disk) before you start this procedure.
2. Insert the original operating system installation CD into your CD drive or DVD drive.
3. Restart your computer. If you're prompted to press a key to start the computer from CD, press the appropriate key.
4. If you have a separate driver file as described in step 1, press the F6 key to use the driver as part of Setup when you're prompted.

5. Press the F2 key when you're prompted at the start of the text-only mode section of Setup.

    You're prompted to insert the ASR disk that you created.
6. Follow the instructions.
7. If you have a separate driver file as described in step 1, press F6 (again) when you're prompted after the system restarts.
8. Follow the instructions.  

    > [!NOTE]
    >
    > - ASR doesn't restore your data files. For more information about how to back up and restore your data files, see Windows Help.
    > - If you're restoring a server cluster in which all nodes failed and the quorum disk can't be restored from backup, use ASR on each node in the original cluster to restore the disk signatures and the partition layout of the cluster disks (quorum and nonquorum). For more information about how to back up and restore server clusters, see Windows Help.  

## Create an ASR disk set by using Backup

To use ASR, you must have an ASR disk set. To create an ASR disk set, follow these steps.

1. Select Start, point to All Programs, point to Accessories, point to System Tools, and then select Backup.

    The Backup or Restore Wizard starts by default, unless it's disabled. You can use the Backup or Restore Wizard to create an ASR disk set by answering **All information on this computer** in the **What do you want to backup** section. Otherwise, you can go to the next step to create an ASR disk set in Advanced Mode.
2. Select the Advanced Mode link in the Backup or Restore Wizard.
3. On the Tools menu, select ASR Wizard.
4. Follow the instructions that appear on your screen.

    > [!NOTE]
    >
    > - You must have a blank 1.44 megabyte (MB) disk to save your system settings and media to contain the backup files. If your computer doesn't have a disk drive, perform an ASR backup on the computer without the disk drive. Copy the Asr.sif and Asrpnp.sif files that are located in the %SystemRoot%\Repair folder to another computer that has a disk drive, and then copy those files to a disk.
    > - To perform this procedure, you must be a member of the Administrators or Backup Operators group on the local computer, or you must have been delegated the appropriate authority. If the computer is joined to a domain, members of the Domain Admins group might be able to perform this procedure. As a security "best practice," consider using the **Run as** command to perform this procedure.
    > - This procedure backs up only those system files that you must have to start your system. You must back up your data files separately.
    > - After you create the ASR set, label this disk and the backup media carefully and keep them together. To use the backup media, you must have the disk that you created by using that set of media. You can't use a disk that you created at a different time or with a different set of media. You must also have your Setup CD available at the time that you perform ASR.
   > - Keep the ASR set in a secure location. The ASR set contains information about your systems configuration that might be used to damage your system.
   > - If you're backing up a server cluster, run the Automated System Recovery Wizard on all nodes of the cluster, and make sure that the Cluster service is running when you start each ASR backup. Make sure that one of the nodes on which you run the Automated System Recovery Preparation Wizard is listed as the owner of the quorum resource while the wizard is running.  

## How to repair your installation of Windows

You may be able to repair a damaged Windows Server 2003 installation by running Windows Setup from the Windows CD.

To repair your installation of Windows, follow these steps.  

1. Insert the Windows Server 2003 CD in the CD drive or DVD drive.
2. If the Windows CD displays the **What would you like to do** menu, select Exit.
3. Turn off your computer, wait 10 seconds, and then turn your computer back on.
4. If you're prompted to start your computer from the CD, do so.

    > [!NOTE]
    > You must be able to start your computer from the Windows Server 2003 CD-ROM to run Windows Setup. Your CD drive or DVD drive must be configured to do so. For information about how to configure your computer to start from the CD drive or DVD drive, see the documentation that is included with your computer, or contact your computer manufacturer.

5. After Setup starts, press Enter to continue the setup process.
6. Press ENTER to select the following option:

   **To set up Windows now, press ENTER**

   Don't select the Recovery Console option.
7. Press F8 to accept the licensing agreement.

    Setup searches for previous installations of Windows.  

    - If Setup doesn't find a previous installation of Windows Server 2003, you might have a hardware failure.

        Hardware failures are beyond the scope of this article. See a computer hardware specialist for more help or try the Hardware troubleshooter. For more information about the Hardware Troubleshooter, see the Windows Server 2003 Help topic "Using Troubleshooters."  

    - If Setup does find a previous installation of Windows Server 2003, you may receive the following message: If one of the following Windows Server 2003 installations is damaged, setup can try to repair it. Use the up and down arrows to select an installation. To repair the selected installation, press R. To continue without repairing, press ESC.
       Select the appropriate Windows Server 2003 operating system installation, and then press R to try to repair it.  

    - Follow the instructions to repair the installation.

    > [!NOTE]
    >
    > - You might have to change the boot drive sequence in the BIOS settings to successfully start your computer from the Windows Server 2003 CD. For more information, contact the manufacturer of your computer, or see your manufacturer's documentation.
    > - If you can't start your computer from the Windows Server 2003 CD, you might have a CD drive or DVD drive failure or other hardware failure.  
    > Hardware failures are beyond the scope of this article. See a computer hardware specialist for more help or try the Hardware troubleshooter. For more information about the Hardware Troubleshooter, see the Windows Server 2003 Help topic "Using Troubleshooters."
    > - After you repair your Windows Server 2003, you may be prompted to reactivate your copy of Windows Server 2003.

## How to use the Microsoft Support website to find a solution

If you can't resolve the problem by following the steps in this article, you can use the Microsoft Support website to find a solution to your problem. The following list describes some of the services that the Microsoft Support website provides:

- [Searchable Knowledge Base](https://support.microsoft.com/) - Search technical support information and self-help tools for Microsoft products.
- [Software and Updates](https://www.microsoft.com/download/search.aspx) - Find software and updates on the Download Center.
- [Other Support Options](https://support.microsoft.com/contactus/) - Ask a support question by using the web or telephone Microsoft Support.
