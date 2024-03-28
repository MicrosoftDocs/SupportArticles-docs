---
title: Set up dynamic boot partition mirroring on GPT disks
description: Contains steps and examples of how to set up dynamic boot partition mirroring on GUID partition table (GPT) disks in Windows Server 2008.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\Partition and volume management , csstroubleshoot
---
# How to set up dynamic boot partition mirroring on GUID partition table (GPT) disks in Windows Server 2008

This article contains steps and examples of how to set up dynamic boot partition mirroring on GUID partition table (GPT) disks in Windows Server 2008.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 951985

## Introduction

This step-by-step article describes how to successfully set up dynamic boot partition mirroring on GUID partition table (GPT) disks in Windows Server 2008. Unlike the master boot record (MBR) mirrors on 32-bit versions of Windows, there are more steps to successfully create and to start mirrored boot volumes on GPT disks. This article also describes how to recover after a primary disk failure.

You must have the built-in Diskpart.exe and Bcdedit.exe utilities to create mirrored boot volumes on GPT disks in Windows Server 2008. You can use the Disk Management console do some of these tasks. But for other tasks, you have to use the built-in Diskpart.exe utility.

For consistency and for ease of use, this article uses the Diskpart.exe utility in the procedures in this article. For help with any of the Diskpart.exe commands, start Diskmgmt.msc, and then open the Help topics on the **Help** menu. The steps that are described in the procedures in this article use real examples.

The procedures in this article show the expected results that each command returns. In these procedures, disk 0 is the primary system and the boot drive, and disk 1 is the secondary drive.

> [!NOTE]
> For Windows Server 2012 documentation, see the following TechNet blog post:  
>[Tip of the Day: Configuring Disk Mirroring for Windows Server 2012](https://blogs.technet.com/b/tip_of_the_day/archive/2014/10/10/tip-of-the-day-configuring-disk-mirroring-for-windows-server-2012.aspx)  

## More information

### Prepare the secondary drive for mirroring

Before you set up boot volume mirroring, we recommend that you have another GPT disk in the computer that contains an Extensible Firmware Interface (EFI) partition. The EFI partition contains the system files that are used to start the operating system. The disk must have an EFI partition to start. If the primary system drive (disk 0) fails, you can use the EFI partition on the secondary drive (disk 1) to start the operating system. This section describes how to create and to prepare new EFI and Microsoft Reserved (MSR) partitions on the secondary drive. You can use only the Diskpart.exe utility to create the EFI and MSR partitions that are required. You can't use the Disk Management console to create or to mirror EFI or MSR partitions.

Before you start the following procedure, make sure that you have another basic disk that has unallocated free space that is greater than or equal to the capacity of the system and boot partitions of the primary disk. If you already converted the spare drive to a dynamic disk, revert it back to a basic drive before you follow these steps.  

1. At a command prompt, run the `Diskpart.exe` utility.

    > [!NOTE]
    > This starts the diskpart console. After the console is initialized, **DISKPART>** is displayed. The diskpart console is now ready for input commands.
2. Select the disk that you want to be the secondary drive, and then convert the drive to GPT. In this example, disk 1 is used for the mirror (secondary) drive.

    > [!NOTE]
    > The disk that you select must not contain any data partitions. Additionally, the disk must be a raw basic disk that has unallocated space that is greater than or equal to the capacity of the primary system disk.
    >

   The following are the commands that you type at the command prompt. The commands are formatted in bold, and the comments about the command or about the contents of the screen display are formatted in plain text.  

   ```console
   DISKPART> Select disk 1
   Disk 1 is now the selected disk.

   DISKPART> Convert GPT  
   Diskpart successfully converted the selected disk to GPT format.

   DISKPART> List partition  

   Partition ###   Type             Size      Offset  
   --------------- ---------------- --------- -------  
   Partition 1     Reserved         128 MB    17 KB
   ```

   > [!NOTE]
   > If you notice that more than one partition is displayed, you have selected the wrong drive, or you did not start with a raw drive. Correct this before you continue, or data loss may occur.

3. Select partition 1 on disk 1, and then delete it. You must use the override command to delete the Microsoft Reserved (MSR) partition. You'll re-create a new MSR partition after you create the required EFI partition.

   ```console
   DISKPART> Select partition 1  
   Partition 1 is now the selected partition.  

   DISKPART> Delete partition override  
   Diskpart successfully deleted the selected partition.  
   ```

4. Select disk 0, and then list the partitions that are on disk 0. With the output of the list command, create new EFI and MSR partitions on disk 1 that are the same sizes as the EFI and MSR partitions on disk 0.

   ```console
   DISKPART> Select disk 0  
   Disk 0 is now the selected disk.  

   DISKPART> List partition  

   Partition ###       Type             Size     Offset  
   ----------------- ---------------- --------- -------  
   Partition 1  System                 200 MB   1024 KB <- EFI PARTITION  
   Partition 2  Reserved               128 MB   201 MB <- MSR PARTITION  
   Partition 3  Primary                50 GB    329 MB

   DISKPART> select disk 1  
   Disk 1 is now the selected disk.  

   DISKPART> create partition efi size=200  
   Diskpart succeeded in creating the specified partition.  

   DISKPART> create partition msr size=128  
   Diskpart succeeded in creating the specified partition  

   DISKPART> list partition  

   Partition ### Type              Size   Offset
   ------------- ---------------- ------- -------
   Partition 1   System           200 MB  1024 KB
   *Partition 2  Reserved         128 MB  201 MB
   ```

### Convert the primary and secondary drives to dynamic disks

Before you can create a mirror, both the primary (source) drive (disk 0) and the secondary (destination) drive (disk 1) must be converted to dynamic disks. After you convert both disks to dynamic disks, you can create the mirror. You can use the Disk Management console or the Diskpart.exe utility to convert both the primary drive and the secondary drive to dynamic disks.

When you use the Diskpart.exe utility, select the drive that you want to convert to a dynamic disk, and then convert the drive to a dynamic disk. You must follow this step on both the secondary and primary GPT drives. To convert both the primary and secondary drives to dynamic disks, follow these steps:

```console
DISKPART> Select disk 1  
Disk 1 is now the selected disk  

DISKPART> Convert dynamic  
Diskpart successfully converted the selected disk to Dynamic format.  

DISKPART> Select disk 0  
Disk 0 is now the selected disk  

DISKPART> Convert dynamic  
DiskPart successfully converted the selected disk to dynamic format.  

DISKPART> Exit  
Leaving Diskpart...  
```

### Establish a mirror from the boot volume to the secondary drive

After you convert both the primary drive (disk 0) and secondary drive (disk 1) to dynamic disks, you can establish a mirror from the boot volume to the secondary drive. To do this, you can use either the Disk management console or the Diskpart.exe utility. To do this by using the Diskpart.exe utility, follow these steps.  

1. At the DISKPART> prompt, select the boot volume (C:), and then mirror the volume to the secondary drive (disk 1).

   ```console
   DISKPART> Select volum
   Volume 1 is the selected volume.  

   DISKPART> add disk=1  
   Diskpart succeeded in adding a mirror to the volume.  
   ```

2. Wait for the volume synchronization to complete, and then exit Diskpart.exe. You can check the progress of the synchronization in the Diskmgmt.msc console.

### Format the EFI partition

You must now copy the BCD store and the contents of the EFI partition from the primary drive (disk 0) to the secondary drive (disk 1).

> [!NOTE]
> You must follow these steps when the BCD store is modified on either drive.

Use the Diskpart.exe utility to select the EFI partition on the secondary drive, and then assign a letter to the EFI partition so that it can be formatted. In the following example, the drive letter "S" is assigned to the EFI partition on the secondary drive. You can use any available drive letter for this step.  

```console
DISKPART> Select disk 1  
Disk 1 is now the selected disk.  

DISKPART> Select partition 1  
Partition 1 is now the selected partition.  

DISKPART> Assign letter=S  
DiskPart successfully assigned the drive letter or mount point.  
```

Use Diskpart to format the "S" partition to use the FAT32 file system. The system can't start from an EFI partition unless it's formatted to use the FAT32 file system. To do this, type the following command, and then press ENTER:  

```console
DISKPART> format fs=FAT32 quick  
```

Select the EFI partition on the primary drive (disk 0), and then assign a drive letter to that EFI partition. In this example, the drive letter "P" is assigned to the primary EFI partition on disk 0. You can use any available drive letter for this step.

```console
DISKPART> Select disk 0  
Disk 0 is now the selected disk.  
  
DISKPART> Select partition 1  
Partition 1 is now the selected partition.  

DISKPART> Assign letter=P  
DiskPart successfully assigned the drive letter or mount point.  
```

Exit Diskpart.

### Use Bcdedit.exe to configure boot entries for the mirrored disk

Use the `BCDedit` command to view the current Windows boot entries. During the "add disk" operation to create the mirror, the Volume Disk Service (VDS) created a secondary entry in the Windows Server 2008 boot configuration, also known as the BCD store, for the Windows Boot Loader on disk 1. To view the current Windows boot entries, follow these steps:

1. Open a command prompt.
2. At the command prompt, type `P:`, and then press ENTER to change to drive P.
3. At the command prompt, type `cd EFI\Microsoft\Boot`, and then press ENTER to change to the Boot folder.
4. At the command prompt, type `bcdedit /enum`, and then press ENTER. Then, you see output that resembles the following:  

   > Windows Boot Manager  
    \--------------------  
    identifier {bootmgr}  
    device partition=P:  
    path \EFI\Microsoft\Boot\bootmgfw.efi  
    description Windows Boot Manager  
    locale en-US  
    inherit {globalsettings}  
    default {current}  
    displayorder {current}  
     {1ba28ce6-d91e-11dc-bc7e-e72bb3afd58e}  
    toolsdisplayorder {memdiag}  
    timeout 30  
    >
   > Windows Boot Loader  
    \-------------------  
    identifier {current}  
    device partition=C:  
    path \Windows\system32\winload.efi  
    description Microsoft Windows Server 2008  
    locale en-US  
    inherit {bootloadersettings}  
    osdevice partition=C:  
    systemroot \Windows  
    resumeobject {b158d5f9-d91f-11dc-bc7e-e72bb3afd58e}  
    nx OptOut  
    >
   > Windows Boot Loader  
    \-------------------  
    identifier {1ba28ce6-d91e-11dc-bc7e-e72bb3afd58e}  
    device partition=C:  
    path \Windows\system32\winload.efi  
    description Microsoft Windows Server 2008 - secondary plex  
    locale en-US  
    inherit {bootloadersettings}  
    osdevice partition=C:  
    systemroot \Windows  
    resumeobject {b158d5f9-d91f-11dc-bc7e-e72bb3afd58e}  
    nx OptOut  

    The Windows Boot Loader with the description, "Microsoft Windows Server 2008 - secondary plex," was created by VDS during the "add disk" operation. The Windows Boot Loader entry "Partition=C:" represents the volume C that is mirrored, and this entry references the copy of Winload.efi file on disk 1 that will start Windows Server 2008 from disk 1.Next, create a copy of the current Windows Boot Manager so that it can be used from the EFI firmware startup menu to make Windows Server 2008 start from either disk 0 or disk 1. The bcdedit /copy command copies the current Windows Boot Manager entry to a new Windows Boot Manager entry that has the description, "Windows Boot Manager Cloned." The bcdedit /set command uses the GUID of the new Windows Boot Manager, and the command sets the device partition to reference the copy of the Bootmgr.efi file that is located on the "S" partition on disk 1. The following is an example of a GUID:

    FD221F0A-5B5D-484A-99FE-DEB4B3F90C32

The following example shows how to use the bcdedit commands.  

1. At the command prompt, type `bcdedit /copy {bootmgr} /d "Windows Boot Manager Cloned"`, and then press ENTER. An output that resembles the following is displayed:

    > The entry was successfully copied to { GUID }.

2. At the command prompt, type `bcdedit /set { GUID } device partition=s:`  
, and then press ENTER. In this command, replace **GUID** with the GUID in the output from the previous command. An output that resembles the following is displayed:

    > The operation completed successfully.

3. At the command prompt, type `bcdedit /enum all`, and then press ENTER to verify the changes that were made. Then, you see output that resembles the following:

   > Firmware Boot Manager  
    \---------------------  
    identifier {fwbootmgr}  
    displayorder {bootmgr}  
     {1ba28ce0-d91e-11dc-bc7e-e72bb3afd58e}  
     {1ba28ce1-d91e-11dc-bc7e-e72bb3afd58e}  
     {1ba28cdf-d91e-11dc-bc7e-e72bb3afd58e}  
     {1ba28cde-d91e-11dc-bc7e-e72bb3afd58e}  
     {1ba28ce2-d91e-11dc-bc7e-e72bb3afd58e}  
     {1ba28ce3-d91e-11dc-bc7e-e72bb3afd58e}  
     {1ba28ce5-d91e-11dc-bc7e-e72bb3afd58e}  
     {1ba28ce4-d91e-11dc-bc7e-e72bb3afd58e}  
     {1ba28ce8-d91e-11dc-bc7e-e72bb3afd58e}  
    timeout 2  
    >
    > Windows Boot Manager  
    \--------------------  
    identifier {1ba28ce8-d91e-11dc-bc7e-e72bb3afd58e}  
    device partition=S:  
    path \EFI\Microsoft\Boot\bootmgfw.efi  
    description Windows Boot Manager Cloned  
    locale en-US  
    inherit {globalsettings}  
    default {current}  
    displayorder {current}  
     {1ba28ce6-d91e-11dc-bc7e-e72bb3afd58e}  
    toolsdisplayorder {memdiag}  
    timeout 30  
    >
    > Windows Boot Manager  
    \--------------------  
    identifier {bootmgr}  
    device partition=P:  
    path \EFI\Microsoft\Boot\bootmgfw.efi  
    description Windows Boot Manager  
    locale en-US  
    inherit {globalsettings}  
    default {current}  
    displayorder {current}  
     {1ba28ce6-d91e-11dc-bc7e-e72bb3afd58e}  
    toolsdisplayorder {memdiag}  
    timeout 30  

4. Close the Command Prompt window.  

   > [!NOTE]
   > That the last GUID in the Firmware Boot Manager display order is the same GUID as the secondary Windows Boot Manager on the "S" partition. This means that the new Windows Boot Manager that has the description "Windows Boot Manager Cloned" is synchronized in the NVRAM that is used by the firmware when the EFI firmware displays the firmware startup menu. There are now two NVRAM entries for Windows Boot Manager, one on the "P" partition and the other on the "S" partition. The EFI firmware lists these entries in the EFI startup menu.

### Copy the EFI partition and the BCD store to the second drive

To export the EFI partition and the BCD store to the second drive, follow these steps:

1. Export the BCD store to the EFI partition on disk 0. This lets you copy the BCD store from disk 0 to disk 1. To do this, follow these steps:
      1. Open a command prompt.
      2. At the command prompt, type `bcdedit /export P:\EFI\Microsoft\Boot\BCD2`, and then press ENTER to export the BCD store to a file that is named "BCD2." An output that resembles the following is displayed:

         The operation completed successfully.

2. Use the `Robocopy` command to copy the system files from "P" (the EFI partition on the primary drive) to "S" (the EFI partition on the secondary drive). You must do this to make sure that the secondary drive can start the system if disk 0 fails. Make sure that you use the correct drive letters if you used different letters for your EFI partitions. To do this, type `robocopy p:\ s:\ /e /r:0` at the command prompt, and then press ENTER.
3. Rename the BCD store on disk 1 so that it matches the name of the store on disk 0. To do this, type rename S:\EFI\Microsoft\Boot\BCD2 BCD at the command prompt, and then press ENTER.
4. Delete the duplicate BCD store on disk 0. To do this, type del P:\EFI\Microsoft\Boot\BCD2 at the command prompt, and then press ENTER.
5. Remove the drive letters that are assigned to both EFI partitions. This step is optional because the drive letters aren't re-assigned after a system restart. To remove the drive letters that are assigned to both EFI partitions, follow these steps:
    1. At the command prompt, type `diskpart.exe`, and then press ENTER.
    2. At the `DISKPART>` prompt, type `Select volume P`.  
  
         Volume 1 is the selected volume.  

    3. At the `DISKPART>` prompt, type `Remove`.  

       Diskpart successfully removed the drive letter or mount point.
  
    4. Repeat steps 5b and 5c for the "S" partition.

### Test the secondary drive by using the new Windows Server 2008 boot entries

After you've updated the BCD configuration, test the entries to make sure that the system can start by using the secondary drive if disk 0 fails. To do this, follow these steps:  

1. Shut down and then restart the computer.  

2. On the startup menu, select the startup entry in EFI that is named "Windows Boot Manager Cloned." This option lets you restart to the Windows Boot Manager on the EFI partition of the secondary drive. Then, select "Microsoft Windows Server 2008 - secondary plex" to start Windows Server 2008 from the secondary drive.
    > [!NOTE]
    > In an MUI environment, the secondary plex entry in the Windows Boot Manager may be displayed as "Microsoft Windows Server 2008 - ????? ?????". You can use the bcdedit /set { **GUID** } description "**Description**" command to give the secondary plex entry a more meaningful name. For example, you can use the following command: bcdedit /set {7e4632e7-0b4d-11dd-813b-bcbfbfe8b578} description "Microsoft Windows Server 2008 - Secondary Plex"  

    After you complete this step to give the secondary plex entry a more meaningful name, make sure that you copy the BCD store to the secondary drive by using the steps that are described in the "Copy the EFI partition and the BCD store to the second drive" section.

### Reestablish the primary boot drive mirror

If there's a failure of the primary drive (disk 0), you must start the computer in the secondary drive (disk 1), and then re-create the mirror to return the boot volume to a fault-tolerant state. To do this, follow these steps.  

1. Replace the failed dynamic disk 0 by using the directions that are provided by your hardware vendor. Make sure that the disk has no partition information. The diskpart clean command can be used to destroy any existing partition information on the disk.

    > [!NOTE]
    >
    > - Be careful when you run the diskpart clean command because it will destroy the partition table on the selected disk, and it will make the contents of the disk inaccessible.
    > - Throughout this section, the former primary disk will continue to be known as disk 0, and the former secondary disk will continue to be known as disk 1. However, after you follow these steps, disk 1 will be the new primary disk, and disk 0 will be the new secondary disk.  

2. Select **Windows Boot Manager Cloned** to start the computer by using the EFI partition on the secondary drive. When the Boot Manager appears, select **Microsoft Windows Server 2008 - secondary plex**.

3. Import the BCD store located on the EFI partition on disk 1. This sets the BCD store on disk 1 as the active system store, and lets it be modified. To do this, follow these steps:
    1. Start DiskPart.
    2. Run the following commands to select the EFI partition on disk 1, and to assign to it drive letter "S."  

       ```console
       DISKPART> select disk 1  
       DISKPART> select partition 1  
       DISKPART> assign letter=s  
       ```

    3. Exit DiskPart.
    4. Run the command `bcdedit /import S:\EFI\Microsoft\Boot\BCD /clean` to import the store from the EFI partition on disk 1.  

4. You have to break the broken mirror. However, you must first determine which is the correct disk on which to run the diskpart break command. After you do this, select the mirror volume (Volume #), and then view the details to determine from which missing disk (m#) you have to break the mirror. To do this, follow these steps:
      1. Start DiskPart.
      2. Select the mirror volume, typically volume C (the boot volume):

         ```console
         DISKPART> select volume c  
         ```

      3. Use the detail volume or list disk command to determine the identifier for the missing disk, typically m0:

         ```console
         DISKPART> detail volume  
         ```  

      4. Break the mirror by specifying the identifier for the missing disk that you obtained in step 5c (for example, m0):

         ```console
         DISKPART> break disk=m0 nokeep  
         ```

      5. List the volumes to make sure that the mirror is gone and that the volume is now listed as a simple volume:

         ```console
         DISKPART> list volume  
         ```

      6. Delete the missing disk (m0):

         ```console
         DISKPART> select disk m0  
         DISKPART> delete disk  
         ```  

      7. Exit DiskPart.
5. Remove all stale entries from the BCD store to return the system to a known clean state. Also, rename the entries to accurately reflect the current state of the system. To do this, follow these steps:
      1. Run the command `bcdedit /enum all /v` to determine the GUID of the entry in NVRAM that has the description "Windows Boot Manager" and that has a device parameter of *unknown* or a missing device parameter. After you determined the GUID for this entry, use the command `bcdedit /set {GUID}` device partition=s: to point the entry to disk 1.
      2. Use the output from the `bcdedit /enum all /v` command to determine the GUID of the "Windows Boot Manager Cloned" entry in NVRAM. After you determine the GUID for this entry, use the command `bcdedit /delete {GUID}` to delete the old entry for disk 1 from NVRAM.
      3. In the output for the `bcdedit /enum all /v` command, look for an entry named "Windows Resume Application" that has a device parameter of *unknown* or a missing device parameter. Delete this entry using the `bcdedit /delete {GUID}` command.
      4. In the `bcdedit /enum all /v` output, look for an entry that has the description, "Windows Resume Application - Secondary Plex." Use the command `bcdedit /set {GUID} description "Windows Resume Application"` command to rename the entry to reflect that this is now the Windows Resume Application entry for the primary mirror plex.
      5. In the output for the `bcdedit /enum all /v` command, look for an entry that has the description, "Windows Server 2008" and that has a device parameter of *unknown* or a missing device parameter. Delete this entry using the bcdedit /delete {GUID} command.
      6. In the `bcdedit /enum all /v` output, look for an entry that has the description "Windows Server 2008 - Secondary Plex." Use the command `bcdedit /set {GUID} description "Windows Server 2008"` to rename the entry to reflect that this is now the boot manager entry for the primary mirror plex.
      7. Look for the BCD entry that has the description, "Windows Memory Diagnostic." Use the command bcdedit /set {GUID} device partition=s: to point the entry to the memory tester that is located on disk 1.
      8. Run the command `bcdedit /enum all /v` to verify the NVRAM and BCD entries.
      9. Restart the computer. Select "Windows Boot Manager" and "Windows Server 2008" to start in disk 1.
6. Convert the newly added disk to GPT format, and then create the partition structure. To do this, follow these steps:
      1. Start DiskPart.
      2. Convert disk 0 to GPT format:  

         ```console
         DISKPART> select disk 0  
         DISKPART> convert GPT  
         ```  

      3. Delete the partition on disk 0 that is created automatically:  

         ```console
         DISKPART> list partition  
         DISKPART> select partition 1  
         DISKPART> delete partition override
         ```  

      4. Record the partition layout for disk 1 to duplicate the layout on disk 0:  

         ```console
         DISKPART> select disk 1  
         DISKPART> list partition  
         ```  

      5. Duplicate the layout of disk 1 on disk 0. To calculate the size of the MSR partition for this step, add together the size of the MSR "Reserved" partition and the "Dynamic Reserved" partition that is listed in DiskPart for disk 1. For example, if the MSR partition is 127 MB on disk 1, and if the "Dynamic Reserved" partition is 1 MB on disk 1, then create a 128-MB MSR partition on disk 0. Generally, the EFI partition should be 200 MB, and the MSR partition should be 128 MB. To duplicate the layout of disk 1, run these commands:  

         ```console
         DISKPART> select disk 0  
         DISKPART> create partition efi size=200  
         DISKPART> create partition msr size=128  
         ```  

      6. List the partitions that are on the system to verify that disk 0 contains both an EFI and an MSR partition:  

         ```console
         DISKPART> list partition  
         ```

7. Convert both disks to dynamic disks if they aren't already dynamic disks:

     ```console
     DISKPART> select disk 0  
     DISKPART> convert dynamic  
     DISKPART> select disk 1  
     DISKPART> convert dynamic  
     ```  

8. Add the new disk 0 to a mirror of the boot volume:

     ```console  
     DISKPART> select volume c  
     DISKPART> add disk=0  
     ```

9. While the mirror resynchronization is occurring, prepare the EFI partition on disk 0:  

    ```console
    DISKPART> select disk 0  
    DISKPART> select partition 1  
    DISKPART> format fs=fat32 quick  
    ```  

    Exit DiskPart  

10. Wait for the mirror resynchronization to finish. You can use Disk Management to check on the resynchronization process.
11. If the EFI partition on disk 0 isn't already assigned the drive letter "P," and if the EFI partition on disk 1 isn't already assigned the drive letter of "S," assign the appropriate drive letters to the EFI partitions on disk 0 and disk 1:
      Start Diskpart.  

      ```console
       DISKPART> select disk 0  
       DISKPART> select partition 1  
       DISKPART> assign letter=p  
       DISKPART> select disk 1  
       DISKPART> select partition 1  
       DISKPART> assign letter=s  
       ```

      Exit DiskPart.
12. Clone the boot manager entry in NVRAM for disk 1:
      1. Clone the boot manager entry using the `bcdedit /copy {bootmgr} /d "Windows Boot Manager Cloned"` command. Record the GUID for the new entry that is given in the output for this command.
      2. Set the device parameter in the cloned entry to point to the EFI partition on disk 0 by using the `bcdedit /set {GUID} device partition=p:` command. Use the GUID from the output of the `bcdedit /copy` command.
      3. Run the command `bcdedit /enum all /v` to verify the changes.
13. Copy the contents of the EFI partition on disk 1 to the EFI partition on disk 0 so that you can boot from disk 0:
      1. Export the active BCD store by using the command `bcdedit /export S:\EFI\Microsoft\Boot\BCD2`  
      2. Copy the EFI partition from disk 1 to disk 0 by using the command `robocopy s:\ p:\ /e /r:0`  
      3. Rename the copied BCD store on disk 0 to BCD by using the command `rename P:\EFI\Microsoft\Boot\BCD2 BCD`.
      4. Delete the duplicate exported BCD store on disk 1 by using the command `del S:\EFI\Microsoft\Boot\BCD2`  
14. Follow these steps:
      1. Remove the drive letters that you assigned in DiskPart:  

         ```console
         DISKPART> select volume p  
         DISKPART> remove  
         DISKPART> select volume s  
         DISKPART> remove  
         ```

      2. Restart the computer to verify that you can boot from either disk 0 or disk 1.

> [!NOTE]
> By default, the boot entries will point to disk 1. If you boot from disk 0, and If you have to modify the BCD store when you start in disk 0, you first have to import the store:
>
> 1. Start DiskPart.
> 2. Select the EFI partition on disk 0, and assign to it the drive letter "P":
>
>    ```console
>    DISKPART> select disk 0
>    DISKPART> select partition 1
>    DISKPART> assign letter=p
>    ```
>
> 3. Exit DiskPart.
> 4. Run the command `bcdedit /import P:\EFI\Microsoft\Boot\BCD /clean` to import the store from the EFI partition on disk 0.

  > [!NOTE]
  > You should always boot from the BCD entry that corresponds to the NVRAM entry that you selected when you started the computer. For example, if you selected the "Windows Boot Manager" (primary disk) NVRAM entry, you may have to select the "Windows Server 2008" (primary disk) BCD entry for the system to start correctly. If you selected the "Windows Boot Manager Cloned" (secondary disk) NVRAM entry, you should select the "Microsoft Windows Server 2008 - secondary plex" (secondary disk) BCD entry.
