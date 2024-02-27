---
title: How To Use the Recovery Console
description: Describes how to use the Recovery Console on a computer that does not start.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# How To Use the Recovery Console on a Computer That Does Not Start

This article describes how to use the Recovery Console on a computer that does not start.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 326215

## Summary

This step-by-step article describes how to use Recovery Console to recover a Windows Server 2003-based computer that does not start.

The Recovery Console is a command-line tool that you can use to repair Windows if the computer does not start correctly. You can start the Recovery Console from the Windows Server 2003 CD, or at startup, if you previously installed the Recovery Console on the computer.

### Use the Recovery Console on a Computer that Does Not Start

> [!NOTE]
> You must be logged on as Administrator or as a member of the Administrators group to perform this procedure. Also, if your computer is connected to a network, network policy settings may prevent you from completing this procedure.

To run the Recovery Console, follow these steps:

1. Configure the computer to start from the CD or the DVD drive. For more information, see the computer documentation or contact the computer manufacturer.
2. Insert the Windows Server 2003 CD in the computer's CD or DVD drive.
3. Restart the computer.
4. When you receive the message that prompts you to press any key to start from the CD, press a key to start the computer from the Windows Server 2003 CD.
5. When the **Welcome to Setup** screen appears, press the R key to start the Recovery Console.
6. Select the Windows installation that you must access from the Recovery Console.
7. Follow the instructions that appear on the screen, type the Administrator password, and then press ENTER.
8. At the command prompt, type the appropriate Recovery Console commands to repair your Windows Server 2003 installation.

    For a list of commands that are available in the Recovery Console, type  
    help at the command prompt, and then press ENTER.

   > [!NOTE]
    > Alternatively, you can install the Recovery Console as a startup option on the computer so that it is always available. For information about how to do so, see the [Precautionary Measures](#precautionary-measures) section in this article.
9. To quit the Recovery Console and restart the computer, type  
 exit at the command prompt, and then press ENTER.

### Recovery Console Commands

The following list describes the available commands for the Recovery Console:

- `Attrib` changes attributes on one file or folder.
- Batch executes commands that you specify in the text file, *InputFile*. *OutputFile* holds the output of the commands. If you omit the *OutputFile* argument, output is displayed on the screen.

- Bootcfg is used for boot configuration and recovery. You can use the bootcfg command to make changes to the Boot.ini file.
- CD (chdir) operates only in the system directories of the current Windows installation, in removable media, in the root directory of any hard disk partition, or in the local installation sources.
- Chkdsk: The /p switch runs Chkdsk even if the drive is not flagged as dirty. The
 /r switch locates bad sectors and recovers readable information. This switch implies /p. Chkdsk requires Autochk. Chkdsk automatically looks for Autochk.exe in the startup folder or in the boot folder. If Chkdsk cannot find the file in the startup folder, it looks for the Windows Server 2003 installation CD. If Chkdsk cannot find the installation CD, it prompts the user for the location of Autochk.exe.
- `Cls` clears the screen.
- Copy copies one file to a target location. By default, the target cannot be removable media, and you cannot use wildcard characters. Copying a compressed file from the Windows Server 2003 installation CD automatically decompresses the file.
- Del (delete) deletes one file. Del operates in the system directories of the current Windows installation, in removable media, in the root directory of any hard disk partition, or in the local installation sources. By default, you cannot use wildcard characters.
- Dir displays a list of all files, including hidden and system files.

- Disable disables a Windows system service or a Windows driver. The *servicename* argument is the name of the service or the driver that you want to disable. When you use this command to disable a service, it displays the service's original startup type before changing the type to SERVICE_DISABLED. It is a good idea to note the original startup type so that you can use the enable command to restart the service.
- Diskpart manages partitions on hard disk volumes.

  - The /add option creates a new partition.
  - The /delete option deletes an existing partition.
  - The *device-name* argument is the device name for a new partition. One example of a device name for a new partition is \device\harddisk0.
  - The *drive-name* argument is the drive letter for a partition that you are deleting, such as `D:`.
  - *Partition-name* is the partition-based name for a partition that you are deleting, and can be used instead of the *drive-name* argument. One example of a partition-based name is \device\harddisk0\partition1.
  - The *size* argument is the size in megabytes of a new partition.

- Enable enables a Windows system service or a Windows driver. The *servicename* argument is the name of the service or the driver that you want to enable, and *start_type* is the startup type for an enabled service. The startup type uses one of the following formats:  

    ```console
     SERVICE_BOOT_START
     SERVICE_SYSTEM_START
     SERVICE_AUTO_START
     SERVICE_DEMAND_START
    ```

- Exit quits the Recovery Console and then restarts the computer.

- Expand expands a compressed file. The *source* argument is the file that you want to expand. By default, you cannot use wildcard characters. The *destination* argument is the directory for the new file. By default, the destination cannot be removable media and cannot be read-only. You can use the `attrib` command to remove the read-only attribute from the destination directory. The option `/f:filespec` is required if the source contains more than one file. This option permits wildcard characters. The /y switch disables the overwrite confirmation prompt. The /d switch specifies that the files should not be expanded and displays a directory of the files in the source.
- `Fixboot` writes a new boot sector on the system partition. The `fixboot` command is only supported on x86-based computers.
- Fixmbr repairs the boot partition's master boot record (MBR). The *device-name* argument is an optional name that specifies the device that requires a new MBR. Omit this variable when the target is the boot device. The fixmbr command is only supported on x86-based computers.
- Format formats a disk. The /q switch performs a quick format. The /fs: *file-system* switch specifies the file system.
- Help lists all the commands that the Recovery Console supports. For more information about a specific command, type help  
 **command-name** or  
 **command-name** /? .
- Listsvc displays all available services and drivers on the computer.

- Logon displays detected installations of Windows and requests the local Administrator password for those installations. Use this command to move to another installation or subdirectory.
- Map displays currently active device mappings. Include the arc option to specify the use of Advanced RISC Computing (ARC) paths instead of Windows device paths. (ARC is the format that is used for the Boot.ini file.)
- Md (Mkdir) creates a directory. The command operates only in the system directories of the current Windows installation, in removable media, in the root directory of any hard disk partition, or in the local installation sources.
- More/Type displays the specified text file to the screen.
- Rd (rmdir) removes a directory. The command operates only in the system directories of the current Windows installation, in removable media, in the root directory of any hard disk partition, or in the local installation sources.
- Ren (rename) renames a single file. The command operates only in the system directories of the current Windows installation, in removable media, in the root directory of any hard disk partition, or in the local installation sources. You cannot specify a new drive or path as the target.
- Set displays and sets the Recovery Console environment variables.

- `Systemroot` sets the current directory to %systemroot%.

### Precautionary Measures

#### How to Install the Recovery Console as a Startup Option

You can install the Recovery Console on a working computer so that it is available to use if you cannot start Windows. This precautionary measure can save you time if you must use the Recovery Console.

> [!NOTE]
> You must be logged on as Administrator or as a member of the Administrators group to complete this procedure. Also, if your computer is connected to a network, network policy settings may prevent you from completing this procedure.

To install the Recovery Console as a startup option:

1. While Windows is running, insert the Windows Server 2003 CD in the computer's CD or DVD drive.
2. Click Start, and then click Run.
3. In the Open box, type the following line, where  
 **drive** is the drive letter of the computer's CD drive or DVD drive that contains the Windows Server 2003 CD, and then click OK:  
**drive: \i386\winnt32.exe /cmdcons  

    To install Recovery console as a startup option for Windows Server 2003 x64 edition, type the following line:  
 **drive: \amd64\winnt32.exe /cmdcons  

4. Click Yes when the message appears, to install the Recovery Console.

5. When you receive the message that states that the Recovery Console is successfully installed, click OK.
6. To use the Recovery Console, restart the computer, and then use the ARROW keys to select **Microsoft Windows Recovery Console** in the **Please select the operating system to start** list.

### How to Remove the Recovery Console

As a precaution, do not remove the Recovery Console. However, if you want to remove the Recovery Console, you must do so manually.

To remove the Recovery Console, follow these steps:

1. Restart the computer.
2. Click Start, and then click My Computer.
3. Turn on the **Show hidden files and folders** option (if it is not already turned on). To do so, follow these steps:

    1. On the Tools menu, click Folder Options.
    2. Click the View tab.
    3. Click **Show hidden files and folders**, click to clear the **Hide protected operating system files (Recommended)** check box (if it is selected), and then click OK.
4. Double-click the drive letter that represents the hard disk on which you installed the Recovery Console.
5. Delete the Cmdcons folder from the root folder, and then delete the Cmldr file. To do so, follow these steps:

    1. Right-click Cmdcons, and then click Delete. Follow the instructions that appear on the screen, and then click Yes to confirm the deletion.
    2. Right-click Cmldr, and then click Delete. Follow the instructions that appear on the screen, and then click Yes to confirm the deletion.
6. Remove the Recovery Console entry from the Boot.ini file. To do so, follow these steps.

    > [!WARNING]
    > Incorrectly modifying the Boot.ini file may prevent your computer from restarting. Make sure that you delete only the entry for the Recovery Console.

    1. At the root folder, right-click the Boot.ini file, and then click Properties. Click to clear the **Read-only** check box, and then click OK.
    2. Open the Boot.ini file in Notepad.
    3. Locate the Recovery Console entry, and then delete it. The Recovery Console entry looks similar to the following line:  
    C:\cmdcons\bootsect.dat="Microsoft Windows Recovery Console" /cmdcons  

    4. On the File menu, click Save, and then click Exit to quit Notepad.
7. Change the attribute for the Boot.ini file back to Read-only. To do so, right-click Boot.ini, and then click Properties. Click to select the **Read-only** check box, and then click OK.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
