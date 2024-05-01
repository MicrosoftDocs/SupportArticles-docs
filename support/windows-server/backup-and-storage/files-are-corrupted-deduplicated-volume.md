---
title: Files are corrupted on deduplicated volume that were created as NTFS-compressed
description: Discusses that files cannot be opened and are logged as corrupted on deduplicated volumes that were created by having NTFS compression enabled. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Backup, Recovery, Disk, and Storage\Deduplication , csstroubleshoot
---
# Files are corrupted on deduplicated volumes that were created as NTFS-compressed

This article provides a solution to an issue where files can't be opened and are logged as corrupted on deduplicated volumes.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3066174

## Symptoms

Users can no longer open files on a deduplication-enabled volume that was created by having NTFS compression enabled at the root of the volume. Additionally, the Data Deduplication scrubbing job may log an event in the event log to report corruption on the volume of files that it cannot repair.

## Cause

This problem occurs because deduplication metadata that is stored on the compressed volume root becomes corrupted when a process writes in-place to a file on the deduplicated volume. The deduplication metadata that is stored on the compressed volume root is located under the System Volume Information (SVI) folder.

Duplication is not supported on volumes that have compression enabled on the root when the volume is created. However, deduplication on compressed folders is supported and functions as expected.

## Resolution

To resolve this problem, do not enable data deduplication on an NTFS volume that has volume-level compression enabled.

Unfortunately, we cannot restore data that is already corrupted on existing compressed volumes that have deduplication enabled. Files that have already been corrupted must be restored from backups, if they are available.

To decompress the deduplication metadata folder so that write actions to deduplicated files on this volume are no longer corrupted, follow these steps.

> [!NOTE]
> In the example commands, **\<X>** is a volume that has been created as compressed and that has Data Deduplication enabled.

1. Download the PsExec tool from the following Windows Sysinternals website:
    [PsExec v2.2](/sysinternals/downloads/psexec)
    > [!NOTE]
    > The PsExec tool lets users run processes by having "SYSTEM" user rights. This is necessary to access the protected Data Deduplication metadata folder that is located in the System Volume Information folder.
2. Block data access for your users on the affected volume. To do this, run the following Windows PowerShell [disable-dedupvolume](/powershell/module/deduplication/disable-dedupvolume?view=win10-ps&preserve-view=true) command:

    ```powershell
    disable-dedupvolume X: -dataaccess
    ```  

    > [!NOTE]
    >
    > - This command dismounts and then remounts the volume without the data deduplication filter attached. This blocks users from accessing any deduplicated files.
    > - The dismount action invalidates any open file handles on this volume.

3. Use PsExec to run Cmd.exe as a "SYSTEM" user. To do this, run the following command:

    ```console
    Psexec.exe -i -s cmd
    ```  

    > [!NOTE]
    > The Command Prompt window will now open by having "SYSTEM" user rights assigned.

    > [!CAUTION]
    > The "SYSTEM" account is a user account that has a much higher level of access than an administrator account. Users should be careful to perform only the steps that are mentioned in the article while they are running the "SYSTEM" account. Users should be especially careful not to change ACLs or take ownership of the System Volume Information folder.
4. In the PsExec Command Prompt window, locate the System Volume Information folder of your affected volume.
5. Verify that the volume's deduplication metadata folder is currently compressed.
6. Decompress the volume's deduplication metadata folder.
7. In the PsExec Command Prompt window, run the following command:

    ```console
    X:\System Volume Information>compact /s:Dedup
    ```  

    The output will include the following summary message:

    > Of M files within N directories  
    > \<X> are compressed and \<Y> are not compressed.  

    If **\<X>**  is greater than zero (0), go to step 8. Otherwise, go to step 11 because your deduplication metadata folder is not compressed.
8. In the PsExec Command Prompt window, run the following command:

    ```console
    X:\System Volume Information>compact /u /s:Dedup
    ```  

9. Wait for the deduplication metadata folder to be uncompressed. The process works on one file at a time and can be slow.

    > [!NOTE]
    > The time that is required by this process is proportional to the amount of data that is on the volume. For volumes that contain terabytes of data, this process can take several hours to finish. After it finishes, the command exits and generates the following status message:  
    > N files within M directories were uncompressed.

10. In the PsExec Command Prompt window, run the following "display compression state" command to verify that there are no compressed files in the Data Deduplication metadata folder.

    ```console
    X:\System Volume Information>compact /s:Dedup
    ```  

11. Close the PsExec Command Prompt window.
12. Re-enable data access for your users on the affected volume. To do this, run the following command:

    ```console
    Enable-DedupVolume X: -DataAccess
    ```  

    > [!NOTE]
    >
    > - This command dismounts and then remounts the volume with the data deduplication filter attached. Users will now be able to access the deduplicated files.
    > - The dismount action invalidates any open file handles on this volume.

> [!NOTE]
> To prevent similar corruptions from occurring, perform this procedure on all deduplication-enabled volumes that were created as compressed.
