---
title: Error code 0x81000031 occurs
description: Describes a problem that occurs when you use the Backup and Restore Wizard in Windows 7 to back up files to an external hard disk drive. A workaround is provided.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: adityah, kaushika
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
---
# Error code 0x81000031 occurs when you try to back up files by using the Backup and Restore Wizard on a Windows 7-based computer

This article describes a problem that occurs when you use the Backup and Restore Wizard in Windows 7 to back up files to an external hard disk drive.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 975692

## Symptoms

Consider the following scenarios.

### Scenario 1: Custom libraries are unavailable

- You have a computer that is running Windows 7.
- You add a custom library that is located on a removable drive or on a network drive.
- You try to perform a backup when one or more of your custom libraries isn't available.

In this scenario, when you try to back up your files by using the Windows Backup and Restore Wizard, you receive an error message that resembles the following message:

> Error code: 0x81000031

### Scenario 2: BitLocker Drive Encryption is enabled

- You have a computer that is running Windows 7.
- You connect an external hard disk drive to the computer.
- You enable Windows BitLocker Drive Encryption on the system drive.

In this scenario, when you try to back up your files to the external drive by using the Windows Backup and Restore Wizard, you receive an error message that resembles the following message:

> BitLocker Drive Encryption cannot be used because critical BitLocker system files are missing or corrupted.
>
> Error code: 0x81000031

## Cause

### Scenario 1: Custom libraries are unavailable

This problem can occur if you have added custom libraries that aren't accessible when you perform a backup by using Windows Backup Wizard. Custom libraries can become unavailable if those libraries are located on a network drive that is unavailable, or if those libraries are located on removable media.

### Scenario 2: BitLocker Drive Encryption is enabled

This problem occurs because the BitLocker Wizard moves Windows Recovery Environment (Windows RE) from the system drive to the external hard disk drive. This prevents creating a backup on the external hard disk.

## Workaround

To work around this problem, follow the appropriate steps for your scenario.

### Scenario 1: Custom libraries are unavailable

To reset your libraries to the default libraries (Documents, Music, Pictures, and Videos), follow these steps:  

1. Click Start, and then click **Computer**.
2. Right-click **Libraries** from the navigation pane on the left side of the Explorer window, and then click **Restore Default Libraries**.
    > [!NOTE]
    > This operation removes any custom libraries that are in your libraries location. You can restore these libraries when the library locations become available again.

3. Start the Backup and Restore Wizard to back up your files and data.

### Scenario 2: BitLocker Drive Encryption is enabled

To disable and re-enable BitLocker Drive Encryption, follow these steps:

1. Connect the external hard disk drive to the computer. Make sure that the external hard disk drive is powered on.
2. Create a Windows 7 system repair disc. To do this, follow these steps:
      1. Click **Start**, and then type create a system repair disc in the **Start Search** box.
      2. In the **Programs** list, click **Create a System Repair Disc**.
      3. Follow the instructions on the screen to create the disc.
    > [!NOTE]
    > You must have a CD or DVD burner to create a system repair disc.
3. Start an elevated command prompt. To do this, follow these steps:
      1. Click **Start**, and then type command prompt in the **Start Search** box.
      2. In the **Programs** list, right-click **Command Prompt**, and then click **Run as administrator**.
4. At the elevated command prompt, type the following command, and then press ENTER:

    ```console
    C:\Windows\System32\REAgentC.exe /disable
    ```  

5. Disconnect the external hard disk drive.
6. At the elevated command prompt, type the following command, and then press ENTER:

    ```console
    C:\Windows\System32\REAgentC.exe /enable
    ```

    > [!NOTE]
    > This operation might fail. In this case, use the Windows 7 system repair disc that you created in step 2 if you have to have access to recovery tools.

7. Reconnect the external hard disk drive to the computer.
8. Start the Backup and Restore Wizard to back up your files and data to the external hard disk drive.

## More information

For more information about how to create and use a system repair disc, visit the following Microsoft Web site:

[Create a system repair disc](https://windows.microsoft.com/windows7/create-a-system-repair-disc)  

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
