---
title: Event IDs 12290 and 16387 are logged when system state backup fails
description: Discusses a system state backup failure on a Windows Server 2008-based computer where event IDs 12290 and 16387 are logged. Provides a resolution.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, cpuckett
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# Event IDs 12290 and 16387 are logged when system state backup fails on a Windows Server 2008-based computer

This article provides a solution to an issue where event IDs 12290 and 16387 are logged when system state backup fails.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 968128

## Symptoms

When you try to perform a system state Automated System Recovery (ASR) backup on a Windows Server 2008-based computer, the backup fails, and error messages that resemble the following are logged in the Application log.

## Cause

This problem occurs if the active EISA partition on the computer is a hidden partition. The ASR writer in Windows Server 2008 doesn't support hidden active partitions. A hidden EISA partition may be marked as active when a new operating system installation is complete on a new computer without first completing the manufacturer's initial Out Of Box Experience (OOBE) program or without first using a disk utility to clear the disk.

This problem doesn't occur on a new computer if the computer manufacturer's OOBE program has been run before installing Windows. In this scenario, after the OOBE program is finished, the hidden partition is marked inactive. You can then install Windows and the backup is completed successfully.

## Resolution

To resolve this problem, follow these steps.

1. Click **Start**, point to **Administrative Tools**, click **Computer Management**, and then click **Disk Management**.
2. Click the volume that contains the existing Windows Server 2008 installation. Typically, this is drive C.
3. Right-click the volume, and then click **Mark Partition as Active**.
4. Click **Yes** to confirm the action.

    > [!NOTE]
    > In this scenario, the existing installation of Windows cannot start until the remaining steps are completed.

5. Close Computer Management.
6. Insert the Windows Server 2008 installation DVD into the DVD drive, and then restart the computer.
7. Select the following options, and then click **Next**:
    - Installation language
    - Time and currency format
    - Keyboard layout
8. Click **Repair your computer**.
9. In the **System Recovery Options** dialog box, click the operating system that you want to repair, and then click **Next**.
10. Under **Choose a recovery tool**, click **Command Prompt**.
11. At the command prompt, type the following command, and then press ENTER:

    ```console
    copy c:\windows\boot\PCAT\bootmgr c:\bootmgr
    ```

12. Type the following command, and then press ENTER:  

    ```console
    Attrib +h +s c:\bootmgr
    ```

13. Type the following command, and then press ENTER:  

    ```console
    Bootrec /fixboot
    ```

14. Type the following command, and then press ENTER:  

    ```console
    Bootrec /rebuildbcd
    ```

15. Press Y when you are prompted to add the installation to the boot list.

16. Restart the computer.

17. Try the full system state ASR backup again. Confirm that the backup is successful.

## More information

If the operating system is installed on a partition that is not located on the same disk as the hidden active EISA partition, you have to mark a partition as active that is located on the same drive as the EISA partition. If no other partition exists on the same drive as the EISA partition, you have to create a partition and mark it as active.
