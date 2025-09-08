---
title: Cannot restore individual database via Backup
description: Discusses the options that are available when you back up the Exchange databases by using Windows Server Backup.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Need Help with Backup
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: sidd, v-six
appliesto: 
  - Exchange Server 2010
  - Exchange Server 2007
search.appverid: MET150
---
# You cannot restore an individual database by using Windows Server Backup in Exchange Server

_Original KB number:_ &nbsp; 2735099

## Symptoms

Consider the following scenario:

- You must restore a mailbox in Exchange Server 2010 or Exchange Server 2007.
- The computer that is running Exchange Server 2010 or Exchange Server 2007 hosts multiple mailbox databases.
- You try to use Windows Server Backup to restore the individual mailbox. This mailbox is located in a specific database.

In this scenario, you cannot restore the individual mailbox or the individual database. When you try to use Windows Server Backup to restore the mailbox, the only option available is to restore all the databases if one of the following conditions is true:

- The backup that is being restored is a Full Volume backup, and multiple databases are hosted on the same volume.
- The backup that is being restored is a Full Server backup, and the server hosts multiple databases.

(The screenshots for this issue are listed below).

:::image type="content" source="media/cannot-restore-individual-database-via-backup/windows-server-backup.png" alt-text="Screenshot of using Windows Server Backup to restore the mailbox.":::

:::image type="content" source="media/cannot-restore-individual-database-via-backup/select-application-in-recovery-wizard.png" alt-text="Screenshot of the window for Details - Exchange.":::

## Cause

This issue occurs because Windows Server Backup only lets you restore all databases.

> [!NOTE]
> This is by design.

## Workaround

To work around this issue, use the Recovery Wizard in Windows Server Backup to restore files and folders from a backup. To do this, follow these steps:

1. Select **Start** > **Administrative Tools** > **Windows Server Backup**.

2. In the **Actions** pane of the snap-in default page, under **Windows Server Backup**, select **Recover**.

    > [!NOTE]
    > This opens the Recovery Wizard.

3. On the **Getting Started** page, select the option that you want, and then select **Next**.
4. On the **Select Backup Date** page, select the date from the calendar and the time from the drop-down list of the backup that you want to restore from. Then, select **Next**.

5. On the **Select Recovery Type** page, select **Files and folders**, and then select **Next** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-restore-individual-database-via-backup/select-recovery-type-in-recovery-wizard.png" alt-text="Screenshot of the window for Select Recovery Type.":::

6. On the **Select Items to Recover** page, under **Available items**, expand the list until the folder that you want is visible. select a folder to display the contents in the adjacent pane, select each item that you want to restore, and then select **Next** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-restore-individual-database-via-backup/select-items-to-recover-in-recovery-wizard.png" alt-text="Screenshot of the window for Select Items to Recover.":::

7. On the **Specify Recovery Options** page, select **Original Location**, and then select **Next** (The screenshot for this step is listed below).

   :::image type="content" source="media/cannot-restore-individual-database-via-backup/specify-recovery-options-in-recovery-wizard.png" alt-text="Screenshot of the window for Specify Recovery Options.":::

8. Under **When this wizard find items in the backup that are already in the recovery destination**, select the option that you want, and then select **Next.**

9. Under **Security settings**, select the **Restore access control list (ACL) permissions to the file or folder being recovered** check box, if this is needed, and then select **Next**.
10. On the **Confirmation** page, review the details, and then select **Recover** to restore the specified items.
11. On the **Recovery progress** page, verify the status of the recovery operation.

12. After the restore operation is complete, check the health of the database, and verify that the log files exist (The screenshot for this step is listed below):

    :::image type="content" source="media/cannot-restore-individual-database-via-backup/log-files.png" alt-text="Screenshot of verifying that the log files exist.":::

13. Perform a Soft Recovery operation. To do this, run the Eseutil.exe utility (The screenshot for this step is listed below):

    :::image type="content" source="media/cannot-restore-individual-database-via-backup/perform-soft-recovery-operation.png" alt-text="Screenshot of performing a Soft Recovery operation by using Command Prompt.":::

14. Verify the status of the database. To do this, run the Eseutil.exe utility (The screenshot for this step is listed below):

    :::image type="content" source="media/cannot-restore-individual-database-via-backup/database-status.png" alt-text="Screenshot of verifying the status of the database by using Command Prompt.":::

## More information

> [!NOTE]
> The following information refers to the information in step 7 on the following website. This information will be updated:  
> [Use Windows Server Backup to restore a backup of Exchange](/Exchange/high-availability/disaster-recovery/restore-with-windows-server-backup).
>
> 1. Select **Recover to original location** to recover backed-up data to its original location. If you use this option, you cannot set a single database or multiple databases. All backed-up databases are restored to their original locations.
>
> 2. Select **Recover to another location** to restore multiple databases to a custom location. To do this, select **Browse** to specify the other location. If you use this option, you can restore a single database or multiple databases into a custom location. After the databases are restored, the data files can then be moved into a recovery database and manually moved back to their original locations. When you restore databases to another location, the restored database is in a Dirty Shutdown state.
