---
title: troubleshoot "NTLDR Is Missing" error
description: Describes how to troubleshoot the "NTLDR Is Missing" error message.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, larryga
ms.custom: sap:System Performance\Startup or Pre-logon Reliability (crash, errors, bug check or Blue Screen), csstroubleshoot
---
# How to troubleshoot the "NTLDR is missing" error message

This article describes how to troubleshoot the "NTLDR is missing" error message.

_Applies to:_ &nbsp; Windows 2000  
_Original KB number:_ &nbsp; 318728

>[!NOTE]
This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).  

## Summary

This step-by-step article describes methods that you can use to troubleshoot the "NTLDR Is Missing" error message that you may receive when you try to start Microsoft Windows 2000.

### How to troubleshoot the "NTLDR is missing" error message

When you start your Windows 2000-based computer, you may receive the following error message:  
>NTLDR is missing  
Press any key to restart  

This problem may occur if the basic input/output system (BIOS) on your computer is outdated, or if one or more of the following Windows boot files are missing or damaged:  
Ntldr  
`Ntdetect.com`  
Boot.ini  
To resolve this issue, verify that the BIOS on your computer is current, and then use one or more of the following methods, as appropriate to your situation, to repair the Windows 2000 startup environment.

> [!IMPORTANT]
> Microsoft recommends that you fully back up your data on a regular basis. This is the best defense against data loss, and it must be a part of any disaster recovery plan.

#### Verify that the BIOS on the computer is current

Make sure that the latest revision for BIOS is installed on the computer. Contact the computer manufacturer to inquire about how to obtain, and then install the latest BIOS update that is available for the computer.

For information about how to configure and how to verify the correct BIOS settings for the computer, see the computer documentation or contact the manufacturer of the computer.  

To repair the Windows startup environment, use one or more of the following methods, as appropriate to your situation.

#### Method 1: Use a boot disk to start the computer

1. Create a Windows 2000 boot disk that contains the following files:  
Ntldr  
Ntdetect.com  
Boot.ini  
Ntbootdd.sys  

2. Modify the Boot.ini file to point to the correct hard disk controller and to the correct volume for your Windows installation. For more information about how to create a boot disk, click the following article number to view the article in the Microsoft Knowledge Base:  
[311578](https://support.microsoft.com/help/311578) How to edit the Boot.ini file in Windows 2000  

3. Insert the boot disk into the computer's floppy disk drive, and then restart the computer.
4. Copy the Ntldr file, the `Ntdetect.com` file, and the Boot.ini file from the boot disk to the system partition of the local hard disk.

#### Method 2: Use the Recovery Console

1. Use the Windows 2000 Setup disks to restart the computer, or use the Windows 2000 CD-ROM to restart the computer.
2. At the **Welcome to Setup** screen, press R to repair the Windows 2000 installation.
3. Press C to repair the Windows 2000 installation by using the Recovery Console.
4. Type the number that corresponds to the Windows installation that you want to repair, and then press ENTER. For example, type
 1, and then press ENTER.  
5. Type the Administrator password, and then press ENTER.
6. Type map, and then press ENTER. Note the drive letter that is assigned to the CD-ROM drive that contains the Windows 2000 CD-ROM.
7. Type the following commands, pressing ENTER after you type each one, where **drive** is the drive letter that you typed in step 4 of "Method 2: Use the Recovery Console," of this article:  

    ```console
    copy drive:\i386\ntldr c:\  

    copy drive:\i386\ntdetect.com c:\  
    ```  

    If you are prompted to overwrite the file, type
     y, and then press ENTER.

    > [!NOTE]
    > In these commands, there is a space between the ntldr and c:\\, and between ntdetect.com and c:\\.
8. Type the following command, and then press ENTER: type c:\Boot.ini  
    A list similar to the following list appears:  

    ```ini
    [boot loader]
    timeout=30
    default=multi(0)disk(0)rdisk(0)partition(1)\WINNT

    [operating systems]
    multi(0)disk(0)rdisk(0)partition(1)\WINNT="Microsoft Windows 2000 Professional" /fastdetect
    ```

    If you receive the following message, the Boot.ini file may be missing or damaged:  
    The system cannot find the file or directory specified.  

9. If the Boot.ini file is missing or damaged, create a new one. To do so, follow these steps:

    1. Use a text editor, such as Notepad or `Edit.com`, to create a boot loader file similar to the following boot loader file:  

        ```ini
        [boot loader]
        timeout=30
        default=multi(0)disk(0)rdisk(0)partition(1)\WINNT  

        [operating systems]
        multi(0)disk(0)rdisk(0)partition(1)\WINNT="Microsoft Windows 2000 Professional" /fastdetect  
        ```  

    2. Save the file to a floppy disk as  
    Boot.ini.

       > [!NOTE]
       > If you used Notepad to create the file, make sure that the .txt extension is not appended to the Boot.ini file name.  

    3. Type the following command at the Recovery Console command prompt to copy the Boot.ini file from the floppy disk to the computer:  
    copy a:\Boot.ini c:\  

10. Type exit, and then press ENTER. The computer restarts.

#### Method 3: Use the Windows 2000 CD-ROM

1. Insert the Windows 2000 CD-ROM into the computer's CD-ROM drive or DVD-ROM drive, and start Windows 2000 Setup.
2. On the **Welcome to Setup** page, press R.
3. On the **Windows 2000 Repair Options** page, press R.
4. When you are prompted to select one of the repair options, press M.
5. Press the UP ARROW, press the UP ARROW again, to select  
 **Verify Windows 2000 system files**, and then press ENTER to clear the selection.
6. Press the DOWN ARROW to select **Continue (perform selected tasks)**, and then press ENTER. The following message appears:  
You need an Emergency Repair disk for the Windows 2000  
installation you want to repair.

7. Do one of the following, as appropriate to your situation:

    - If you have an Emergency Repair Disk, follow these steps:

        1. Press ENTER.
        2. Insert the Emergency Repair Disk into the computer's floppy disk drive, and then press ENTER.
        3. Follow the instructions to repair the installation, and then restart the computer.  
        -or-
    - If you do not have an Emergency Repair Disk, follow these steps:

        1. Press L. You receive a message similar to the following one:  
        Setup has found Windows 2000 in the following folder:
         **drive**: \WINNT "Microsoft Windows 2000"

        2. Press ENTER.

        Setup examines the disks, and then completes the repair process.  

#### If setup cannot locate Windows 2000

If you do not have a Windows 2000 Emergency Repair Disk, and if Setup cannot locate the Windows 2000 installation, follow these steps:

1. Start Windows 2000 Setup.
2. On the **Setup will install Windows 2000 on partition** page, select **Leave the current file system intact (no changes)**, and then press ENTER.
3. Press ESC to install Windows 2000 to a new folder.
4. In the **Select the folder in which the files should be copied** box, type \tempwin, and then press ENTER.

    Setup installs a new copy of Windows 2000.
5. Log on to the new copy of Windows 2000.
6. Click Start, and then click Run.
7. In the Open box, type cmd, and then click OK.
8. At the command prompt, type  
 **drive**: , where  
**drive** is the boot drive of the computer, and then press ENTER. For example, type c: , and then press ENTER.
9. Type `attrib -h -r -s Boot.ini`, and then press ENTER.
10. Type edit Boot.ini, and then press ENTER.

    `Edit.com` opens a Boot.ini file that is similar to the following file:  

    ```ini

    [boot loader]
    timeout=30
    default=multi(0)disk(0)rdisk(0)partition(1)\TEMPWIN
    [operating systems]
    multi(0)disk(0)rdisk(0)partition(1)\TEMPWIN="Microsoft Windows 2000 Professional" /fastdetect

    ```

11. Replace all instances of TEMPWIN with WINNT. The Boot.ini file that appears is similar to the following file:  

    ```ini
    [boot loader]
    timeout=30
    default=multi(0)disk(0)rdisk(0)partition(1)\WINNT
    [operating systems]
    multi(0)disk(0)rdisk(0)partition(1)\WINNT="Microsoft Windows 2000 Professional" /fastdetect
    ```

12. Press ALT+F, and then press S.
13. Press ALT+F, and then press X.
14. Type `attrib +h +r +s Boot.ini`, and then press ENTER.
15. Type exit to quit the command prompt.
16. Restart the computer.
17. At the **Please select the operating system to start** screen, use the ARROW keys to select Microsoft Windows 2000, and then press ENTER.
18. Start Windows Explorer, locate the following folders, and then delete them:  
    `Tempwin`  
    `All Users.Tempwin`
