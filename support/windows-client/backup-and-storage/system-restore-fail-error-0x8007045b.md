---
title: System Restore fails with error 0x8007045b
description: Describes an issue that occurs when you try to restore a system back to a restore point after you accept enforced security.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\System Restore, csstroubleshoot
---
# System Restore may fail with error code 0x8007045b if there is encrypted content in the restore point

This article provides a workaround for an issue where System Restore may fail with error code 0x8007045b.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3074925

## Symptoms

Consider the following scenario:

- You are using the Mail application in Windows 8.1 or Windows 8.
- You want to use the Mail application to connect to a Microsoft Exchange or Microsoft Office 365 mail server. (To do this, you have to accept the **Make my PC more secure** security policies that are applied from the mail server.)
- You take one of the following actions:
  - You use the System Restore program in Windows to create some restore points.
  - You try to use restore points that were created by the system automatically.
- You try to restore the system back to one of the restore points after you accept enforced security.

In this scenario, System Restore may fail, and you receive an error message that resembles the following after the system is restarted.

> System Restore did not complete successfully. Your computer's system files and settings were not changed.
>
> Details:
>
> System Restore failed to extract the file
>
> C:\Users\< **User Name** >\AppData\Local\Packages\microsoft.windowscommunicationsapps_8wekyb3d8bbwe\....
>
> From the restore point.
>
> An unexpected error occurred during System Restore. (0x8007045b)

## Cause

This problem occurs because of a known issue in the System Restore program.

After you configure the Mail application to connect to an Exchange or Office 365 server and accept the **Make my PC more secure** security policies, some files in the user profile will be encrypted by using the Encrypting File System (EFS). And those files will be included in the restore point if you use System Restore to create a restore point. When you start the System Restore program to restore the system, System Restore creates a shutdown task to do the real restoration work. When this task is being executed, most system services are already stopped. This includes EFS.

However, if any file is being encrypted by EFS in the restore point, the System Restore program will have to call in to the EFS service to extract files of this kind from the restore point. But because the EFS service is already stopped and cannot be restarted because the system is being shutting down, the restoration process fails with error code 0x8007045b. This code means ERROR_SHUTDOWN_IN_PROGRESS.

## Workaround

To work around this issue, follow these steps to restart into Windows RE, and then run the System Restore program.

1. Open a command prompt as Administrator, and then run the following command:

    ```console
    reagentc /boottore
    ```

    > [!NOTE]
    > If this command returns a **Windows RE is disabled** error, run the following command to install it, and then run `reagentc /enable` again.

2. Restart the computer. The computer will restart into the Windows RE environment.

3. In Windows RE, click **Troubleshoot**, click **Advanced Options**, click **System Restore**, and then follow the prompt to start the System Restore program. Because EFS is always running in Windows RE, and because System Restore doesn't have to create a shutdown task to perform the restoration work in Windows RE, this specific issue will not occur in Windows RE. For more information about the REAgentC command, see [REAgentC Command-Line Options](/previous-versions/windows/it-pro/windows-8.1-and-8/hh825204(v=win.10)).
