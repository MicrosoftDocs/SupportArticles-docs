---
title: How to repair personal folder file (.pst)
description: Describes how to find the Inbox Repair tool (Scanpst.exe) that is designed to repair the personal folder (.pst) files.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: sercast
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 10/30/2023
---
# How to repair your Outlook personal folder file (.pst)

_Original KB number:_ &nbsp; 272227

Follow these steps to repair your Outlook personal folder file (.pst) by using Inbox Repair tool.

## Step 1 - Exit Outlook and start the Inbox Repair tool

### Automatically start the Inbox Repair tool

Start the Inbox Repair tool (Scanpst.exe). Then select **Open** or **Run** in the **File Download** dialog box, and follow the steps in the easy fix wizard.

Once the Inbox Repair tool is started, continue with [Step 2](#step-2---repair-the-pst-file). (Can't start the Inbox Repair tool?)

### Manually start the Inbox Repair tool

To start the Inbox Repair tool manually, locate one of the folders by using Microsoft Windows Explorer, and then double-click the Scanpst.exe file.

> [!NOTE]
> The file or folders may be hidden. For instructions about how to unhide files and folders, see your operating system documentation.

| Typical location| Remark |
|---|---|
| \<disk drive>\Program Files(x86)\Microsoft Office\root\Office16| For Outlook 2016 Click-to-Run installation on a 32-bit version of Windows |
| \<disk drive>\Program Files\Microsoft Office\root\Office16| For Outlook 2016 Click-to-Run installation on a 64-bit version of Windows |
| \<disk drive>\Program Files(x86)\Microsoft Office\Office16| For Outlook 2016 MSI-based installation on a 32-bit version of Windows |
| \<disk drive>\Program Files\Microsoft Office\Office16| For Outlook 2016 MSI-based installation on a 64-bit version of Windows |
| \<disk drive>\Program Files\Microsoft Office 15\root\office15| For Outlook 2013 Click-to-Run installation on a 64-bit version of Windows |
| \<disk drive>\Program Files(x86)\Microsoft Office 15\root\office15| For Outlook 2013 Click-to-Run installation on a 32-bit version of Windows |
| \<disk drive>\Program Files\Microsoft Office\Office15| For Outlook 2013 MSI-based installation on a 64-bit version of Windows |
| \<disk drive>\Program Files(x86)\Microsoft Office\Office15| For Outlook 2013 MSI-based installation on a 32-bit version of Windows |
| \<disk drive>:\Program Files\Microsoft Office\Office14| For Outlook 2010 on a 64-bit version of Windows |
| \<disk drive>:\Program Files\Microsoft Office(x86)\Office14| For Outlook 2010 on a 32-bit version of Windows |
| \<disk drive>:\Program Files\Microsoft Office\Office12| For Outlook 2007 on a 64-bit version of Windows |
| \<disk drive>:\Program Files(x86)\Microsoft Office\Office12| For Outlook 2007 on a 32-bit version of Windows |
| \<disk drive>:\Program Files\Common Files\System\Mapi\1033\| Other typical location |
| \<disk drive>:\Program Files\Common Files\System\MSMAPI\1033| Other typical location |
| \<disk drive>:\Program Files\Common Files\System\Mapi\1033\NT| Other typical location (for Windows NT and Windows 2000) |
| \<disk drive>:\Program Files\Common Files\System\Mapi\1033\95| Other typical location (for Windows 95 and Windows 98) |

(Can't find the Inbox Repair tool?)

## Step 2 - Repair the .pst file

In the Inbox Repair tool, type the path and the file name of your personal folders (.pst) file or select **Browse** to locate the file by using the Windows file system, and then select **Start**.

> [!NOTE]
> If you do not know where the .pst file is located, follow the steps in [How to locate, move, or back up your .pst file](https://support.microsoft.com/help/287070).

:::image type="content" source="media/how-to-repair-personal-folder-file/inbox-repair-tool.png" alt-text="Screenshot shows steps to repair the .pst file in the Inbox Repair tool." border="false":::

> [!NOTE]
>
> - The Inbox Repair Tool may need to be run several times in order to fully repair your personal folder (.pst) file.
> - The Inbox Repair Tool cannot repair every problem that is detected. In some cases, items may not be recovered if they were permanently deleted or corrupted beyond repair.

## Step 3 - Recover repaired items to a new .pst file

After you run the Inbox Repair tool, you can start Outlook and recover repaired items. Optionally, you can try to [recover additional repaired items from the backup personal folder](#recover-repaired-items-from-the-backup-file-optional).

To start, create a new Personal Folders (.pst) file entry in your profile. Then, you can move the recovered items to your new Personal Folders (.pst) file.

1. Start Outlook. If you use multiple profiles in Outlook, make sure that you select the profile that contains the Personal Folders (.pst) file that you tried to repair.
2. Press Ctrl+6 to turn on Folder List view.
3. In your Folder List, you should see the following recovered folders:

    ```console
    Recovered Personal Folders

    Calendar
    Contacts
    Deleted Items
    Inbox
    Journal
    Notes
    Outbox
    Sent Items
    Tasks
    ```

    > [!NOTE]
    > These recovered folders are usually empty because this is a rebuilt .pst file. You should also see a folder named Lost and Found. This folder contains folders and items that the Inbox Repair Tool recovered. Unfortunately, items that are missing from the Lost and Found folder may be beyond repair.

4. Create a new Personal Folder (.pst) file in your profile. The steps may be different, depending on which version of Outlook you are running.

    Outlook 2010 and later

    1. Select the **File** tab on the ribbon, and then select the **Info** tab on the menu.
    2. Select the **Account Settings** button, and then select **Account Settings** again.
    3. Select the **Data Files** tab.
    4. Select **Add** to open the **Create or Open Outlook Data File** dialog box.
    5. Enter a file name for your new Outlook Data (.pst) file, and then select **OK**.
    6. You should have a new Outlook Data (.pst) file in your profile.

    Outlook 2007

    1. On the **File** menu, select **Data File Management**.
    2. Select **Add** to open the **New Outlook Data File** dialog box.
    3. In the **Types of storage** dialog box, select **Office Outlook Personal Folders File (.pst)**, and then select **OK**.
    4. In the **Create or Open Outlook Data File** dialog box, select the location and a file name for your new Personal Folders (.pst) file, and then select **OK**.
    5. Select **OK**.
    6. You should have a new Personal Folders (.pst) file in your profile.

    Outlook 2003

    1. On the **File** menu, point to **New**, and then select **Outlook Data File**.
    2. Select **OK** to open the **Create or Open Outlook Data File** dialog box.
    3. Enter a file name for your new Personal Folders (.pst) file, and then select **OK** to open the **Create Microsoft Personal Folders** dialog box.
    4. Enter a file name for your new Personal Folders (.pst) file, and then select **OK**.
    5. You should have a new Personal Folders (.pst) file in your profile.

    Outlook 2002

    1. On the **File** menu, point to **New**, and then select **Personal Folders File (.pst)**.
    2. Select **Create** to open the **Create Microsoft Personal Folders** dialog box.
    3. Enter a file name for your new Personal Folders (.pst) file, and then select **OK**.
    4. You should have a new Personal Folders (.pst) file in your profile.

5. Drag the recovered items from the Lost and Found folder to your new Personal Folders (.pst) file.
6. When you have finished moving all items, you can remove the Recovered Personal Folders (.pst) file from your profile. This includes the Lost and Found folder.
7. If you are satisfied with the information that you recovered, you are finished. However, if you want to try to recover additional information, go to the [Recover repaired items from the backup file (Optional)](#recover-repaired-items-from-the-backup-file-optional) section.

## What is the Inbox Repair tool

The Inbox Repair tool (Scanpst.exe) is designed to help repair problems that are associated with personal folder (.pst) files.

The Inbox Repair tool is automatically installed with all English-language Microsoft Outlook installation options depending on your operating system.

## Can't find or start the Inbox Repair tool

If you can't start the Inbox Repair tool automatically or manually, you may try to [repair your Office application](https://support.microsoft.com/office/repair-an-office-application-7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).

## Recover repaired items from the backup file (Optional)

> [!NOTE]
> If you could not open your original Personal Folders (.pst) file before you ran Inbox Repair Tool, the following procedures may not work. If it does not work, then unfortunately, you will be unable to recover any additional information. If you could open the file, the following procedure may help you recover additional items from your damaged Personal Folders (.pst) file.

When you run Inbox Repair Tool, the option to create a backup of the original Personal Folders (.pst) file is automatically selected. This option creates a file on your hard disk that is named **File name**.bak. This file is a copy of the original **File name**.pst file with a different extension. If you think that you are still missing items after following the steps in the previous section, you can try to recover additional information from this backup file by following these steps:

Locate the .bak file. It is located in the folder of your original Personal Folders (.pst) file.

1. Locate the .bak file. It is located in the folder of your original Personal Folders (.pst) file.

1. Make a copy of the .bak file and give the file a new name with a .pst extension. For example, name the file **New name**.pst.
1. Import the **New name**.pst file that you created in the previous step by using the Import and Export Wizard in Outlook. To do this, follow these steps:
   1. On the **File** menu, select **Import and Export**.
        > [!NOTE]
        > On Outlook 2010 and later, select the **File** tab on the Ribbon, select **Open**, and then select **Import**.
   2. Select **Import from another program or file**, and then select **Next**.
   3. Select **Personal Folder File (.pst)**, and then select **Next**.
   4. Under **File to import**, select **Browse**, and then double-click your Newname.pst file.
   5. Under **Options**, select **Do not import duplicates**, and then select **Next**.
   6. Under **Select the folder to import from**, select the Personal Folders (.pst) file, and then select **Include subfolders**.
   7. Select **Import folders into the same folder in**, and then select your new Personal Folders (.pst).
   8. Select **Finish**.

> [!NOTE]
> Remember that the backup file was the original corrupted file, and you may find that you cannot recover anything other than what was recovered in the Lost and Found folder. If you cannot import the Newname.pst file into Outlook, unfortunately you have lost all the information that is not in the Lost and Found folder.

## How the Inbox Repair tool validates and corrects errors

ScanPST mostly validates and corrects errors in the internal data structures of a .pst file. The .pst file is a database file. Therefore, structures such as BTrees and reference counts, are checked and repaired as necessary. These low-level objects have no knowledge of the upper-level structures, such as messages, calendar items, and so on, that are built upon them.

If ScanPST determines that a specific block of the structure or table is unreadable or corrupted, ScanPST removes it. If that block was part of a specific item in Outlook, the item will be removed when it is validated.

You may not expect this behavior, but the removal of the item is appropriate given the circumstances. Also, this specific kind of situation is rare, and it will always be entered in the ScanPST log file.

At a higher level, the more visible changes that you see involve folders and messages.

### Folders

ScanPST examines every folder in the .pst and performs the following operations:

1. ScanPST makes sure that there are the correct tables associated with the folder.
2. ScanPST checks every row in each table and makes sure that the message or the subfolder exists in the system.
3. If ScanPST cannot find the message or the subfolder, ScanPST removes the row from the table.
4. If ScanPST does find the message or the subfolder, ScanPST validates the message or the folder.
5. If that validation fails, the message or folder is considered corrupted, and it is removed from the table and deleted from the database.
6. If the validation succeeds, ScanPST does another analysis to make sure that the now-recovered message values are consistent with the values in the table. Corrupted folders are recreated from scratch, if it is necessary. These folders contain no user data.

### Messages

Most users will be concerned by message operations, because a corrupted item is likely to cause something to be deleted from the .pst file. ScanPST performs the following operations on messages:

1. ScanPST does some basic validation of attachment tables and recipient tables. This operation resembles how a folder works with the messages in it.
2. As soon as the recipient table is validated to guarantee recipients that are formatted correctly, ScanPST makes any changes that are required to synchronize these valid recipient table contents to the recipient properties on the message. ScanPST also guarantees that the message's parent folder refers to a valid folder. The following message properties are checked to make sure that they follow valid data formats:

   - PR_MESSAGE_CLASS

     ScanPST checks that this property exists. If the property does not exist, it is set to **IPM.Note**.

   - PR_MESSAGE_FLAGS

     Each flag is validated separately.

   - PR_SUBMIT_FLAGS

     This validation resembles the operation for message flags.

   - PR_CLIENT_SUBMIT_TIME

     If the submit flags indicate that the message is marked as submitted, this property must exist. If the submit flags do not indicate that the message is marked as submitted, the time is set to **Now**.

   - PR_SEARCH_KEY

     This property must exist. If the property is not present, a random GUID is generated for it.

   - PR_CREATION_TIME

     This property must exist. If the property is not present, the time is set to **Now**.

   - PR_LAST_MODIFICATION_TIME

     This property must exist. If the property is not present, the time is set to **Now**.

   - PR_MESSAGE_SIZE

     Sizes are recalculated and compared to stored values. If sizes differ by some delta, the calculated value is written.

No validation is explicitly done on body-related properties or on subject-related properties, except the implicit low-level validation that this article discusses earlier. The recipient display properties are changed to be consistent with the recovered recipient table. As soon as this operation is complete, other algorithms are run to collect all the orphaned messages and to put them in an Orphans folder.

For more information about binary trees (btrees), see [An Extensive Examination of Data Structures](https://www.microsoft.com/download/details.aspx?id=55979).
