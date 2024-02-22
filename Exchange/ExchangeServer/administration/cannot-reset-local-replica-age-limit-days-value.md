---
title: Cannot reset Local replica age limit (days)
description: Provides workarounds for a problem in which you cannot reset the value of the Local replica age limit (days) setting.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: wlong, sidd, v-six
appliesto: 
  - Exchange Server 2010
search.appverid: MET150
---
# Cannot reset the value of the Local replica age limit (days) setting to 0 or to NULL

_Original KB number:_ &nbsp; 2734536

## Symptoms

Assume that you configure the value of the Local replica age limit (days) setting for a public folder in Exchange Server 2010. However, after you configure the value of the Local replica age limit (days) setting, you cannot reset the value to **0** or to **NULL**.

For example, if you try to reset the value of the Local replica age limit (days) setting to **0** by using Public Folder Management Console, you receive the following error message:

> Some controls aren't valid.  
-The property (00:00:00), is out of range. The valid range is from 1:00:00:00 to 24855:00:00:00.

Additionally, you try to run the following command to remove the value of the Local replica age limit (days) setting in Exchange Management Shell:

```powershell
set-publicfolder -Identity "\folder name" -LocalAgeReplicaLimit:$null -server "FQDN of server"
```

However, you receive the following error message:

> Cannot process argument transformation on parameter 'LocalReplicaAgeLimit'. Cannot convert null to type "Microsoft .Exchange.Data.EnhancedTimeSpan"

## Workaround 1 - Set the value of the Local replica age limit (days) setting to 24855

The valid range for the Local replica age limit (days) setting is one to 24855. Therefore, you can set the value of Local replica age limit (days) setting to **24855** as a workaround.

## Workaround 2 - Rebuild the affected public folder

Before you rebuild the affected public folder, you must export the items in the public folder to a .pst file, and then import this .pst file to the new public folder. To do this, follow these steps.

> [!NOTE]
> After you rebuild the affected public folder, the new public folder has the default Client permissions. You must reconfigure the public folder replicas for the new public folder.

1. Export the items in the affected public folder to a .pst file. To do this, follow these steps:
   1. Open Microsoft Outlook to connect to the public folder database.
   2. On the **File** menu, select **Import and Export**.
   3. Select **Export to a File**, and then select **Next**.
   4. In the **Create a file of Type** list, select **Personal Folder File (.pst)**, and then select **Next**.
   5. In the **Select folder to export from** list, select **Public Folder**, select **All Public Folders**, select to select the affected public folder, and then select **Next**.
   6. In the **Save exported file as** box, type a name for the file (for example, type Backup.pst), and then select **Browse** to select a folder to save the file in.
   7. Select **Ok** to save the exported file, select **Next**, and then select **Finish**.

2. Rebuild the affected public folder. To do this, follow these steps:

   1. In the Exchange Management console tree, select **Toolbox**.
   2. In the **Result** pane, double-click **Public Folder Management Console**.
   3. In the **Public Folder Management Console** console tree, select **Default Public Folders**.
   4. In the **Result** pane, right-click the affected folder, and then select **Remove**.
   5. In the **Public Folder Management Console** console tree, right-click **Default Public Folders**, and then select **New Public Folder**.
   6. In the **Name** box, type a name for the new public folder, and then select **New**.

3. Import the .pst file to the new public folder. To do this, follow these steps.

    > [!NOTE]
    > You must have Owner permissions to import the items to this public folder. You can use Public Folder Management Console to manage the permissions for this public folder.

   1. In the Folder List view of Outlook, select **Public Folders**, select **All Public Folders**, and then select to select the new public folder that you created in step 2.
   2. On the **File** menu, select **Import and Export**.
   3. In the **Choose an action to perform** list, select **Import from another program or file**, and then select **Next**.
   4. In the **Select file type to import from** list, select **Personal Folder File (.pst)**.
   5. In the **File to import** box, type the location and file name of the .pst file that you want to import, or select **Browse** to locate the .pst file.
   6. Select **Replace duplicates with items imported**, and then select **Next**.
   7. In the **Select the folder to import from** list, select **IPM_SUBTREE**, select the public folder that you exported in step 1, select **Import items into the current folder**, and then select **Finish**.

## More information

The Local replica age limit (days) setting specifies the age limit for items in a public folder. Items that have reached the specified age limit are deleted.
