---
title: Description of the AutoArchive feature
description: Discusses the AutoArchive feature in Outlook. Explains the difference between archiving and exporting items. You're also given the steps to turn on the AutoArchive feature and how to set the AutoArchive properties for a folder.
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
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
  - Outlook for Microsoft 365
  - Outlook 2010 with Business Contact Manager
search.appverid: MET150
ms.date: 10/30/2023
---
# Description of the AutoArchive feature in Outlook

_Original KB number:_ &nbsp; 830119

## More information

Your Outlook mailbox grows as items are created in the same way that papers pile up on your desk. In the paper-based world, you can occasionally shuffle through your documents and store those that are important but that are rarely used. You can discard documents that are less important, such as newspapers and magazines, based on their age.

You can quickly complete the same process in Outlook 2003 and later versions. You can manually transfer old items to a storage file by selecting **Archive** on the **File** menu. Or you can have old items automatically transferred by using the AutoArchive feature. Items are considered old when they reach the age that you specify. With the AutoArchive feature, you can either delete or move old items. Outlook can archive all kinds of items, but it can only locate files that are stored in an e-mail folder, such as a Microsoft Excel spreadsheet or a Microsoft Word document, that is attached to an e-mail message. A file that isn't stored in an e-mail folder can't be archived.

The AutoArchive feature has a two-step process. First, you turn on the AutoArchive feature. Second, you set the properties for the AutoArchive feature for each folder that you want archived.

> [!NOTE]
> If you have multiple Exchange accounts in the same Outlook profile, the default AutoArchive setting will apply to all of the accounts. To avoid this, apply the AutoArchive setting on the folder level.

At the folder level, you can determine the items that are to be archived and how frequently they're archived. You can automatically archive individual folders, or you can configure a default AutoArchive setting for all folders. And then configure AutoArchive settings for individual folders that you don't want to use the default AutoArchive settings. The AutoArchive feature runs automatically whenever you start Outlook. Outlook checks the AutoArchive properties of each folder by date and moves old items to your archive file. Items that are moved to the Deleted Items folder are deleted.

### Outlook 2003 and Outlook 2007

By default, several Outlook folders are set up with the AutoArchive feature turned on. The following list is the folders that have the AutoArchive feature turned on and of each folder's default aging period:

- The Calendar folder (six months)  
- The Tasks folder (six months)  
- The Journal folder (six months)  
- The Sent Items folder (two months)  
- The Deleted Items folder (two months)

The Inbox, Notes, Contacts, and Drafts folders don't have the AutoArchive feature turned on automatically. You can't use the AutoArchive feature with the Contacts folder, as the Contacts folder doesn't have an archive property.

### Outlook 2010 and later versions

By default, the AutoArchive feature is turned off in Outlook 2010 and later versions. The AutoArchive feature is enabled in Outlook 2003 and Outlook 2007 by default. If you don't disable the AutoArchive feature in Outlook 2003 or Outlook 2007 and upgrade to Outlook 2010 or later versions, the AutoArchive feature remains enabled.

### The Difference Between Archiving and Exporting Items

When you archive items, you can only archive the items to a personal folders (.pst) file. When you export items, you can export the items to many different file types, including .pst files and delimited text files. Your existing folder structure is maintained in your new archive file. If there is a parent folder above the folder that you archived, the parent folder is created in the archive file. But the items that are in the parent folder are not archived. In this way, the same folder structure exists between the archive file and your mailbox. Folders are left in place after being archived, even if they're empty. You can only archive one file type, a .pst file.

When you export items, the original items are copied to the export file, but they aren't removed from the current folder.

### How to Turn On the AutoArchive Feature

For Outlook 2010 and later versions:

1. Select the **File** tab, and then select the **Options** tab on the **File** menu.
2. Select the **Advanced** tab.
3. Select **AutoArchive Settings**.
4. Select the **AutoArchive Every** check box. Type a number in the **Days** box to specify how frequently the AutoArchive process runs.
5. If you want to be notified before the items are archived, select to select the **Prompt Before AutoArchive** check box.
6. In the **Default archive file** box, type a file name for the archived items to be transferred to, or select **Browse** to select from a list.
7. Select **OK** two times.

For Outlook 2007 and Outlook 2003:

1. On the **Tools** menu, select **Options**, and then select the **Other** tab.
1. Select **AutoArchive**.
1. Select to select the **AutoArchive Every** check box, and then specify how frequently the AutoArchive process will run by typing a number in the **days** box.
1. If you want to be notified before the items are archived, select to select the **Prompt Before AutoArchive** check box.
1. In the **Default archive file** box, type a file name for the archived items to be transferred to, or select **Browse** to select from a list.
1. Select **OK** two times.

Now that you've turned on the AutoArchive feature, you must set the AutoArchive properties for each folder.

> [!IMPORTANT]
> The Outlook Data (.pst) file that you choose as the default archive file must be located on the local computer. The use of networked .pst files is only supported with Outlook 2010 and under very specific conditions. For more information about the limits to using .pst files over the network, see [Limits to using personal folders (.pst) files over LAN and WAN links](limits-using-pst-files-over-lan-wan.md).

### How to Set the AutoArchive Properties for a Folder

For Outlook 2010 and later versions:

Method 1:

1. Select the folder that you want to AutoArchive.
2. Select the **Folder** tab, and then select **AutoArchive Settings**.

Method 2:

1. Right-click the folder that you want to AutoArchive, and then select **Properties**.
2. Select the **AutoArchive** tab.
3. To set the **AutoArchive** properties for this folder, select the **Clean out items older than** check box.
4. To specify when the items must be automatically transferred to your archive file, type a number in the **Months** box.
5. To specify a file for the archived items to be transferred to, select **Move old items to**.
6. In the **Move old items to** box, type a file name for the archived items. Or select **Browse** to select from a list, and then select **OK**.

For Outlook 2007 and Outlook 2003:

1. In the **Folder List**, right-click the folder that you want to AutoArchive, and then select **Properties**.
2. Select the **AutoArchive** tab.
3. To set the AutoArchive properties for this folder, select to select **Clean out items older than**.
4. To specify when the items must be automatically transferred to your archive file, type a number in the **Months** box.
5. To specify a file for the archived items to be transferred to, select **Move old items to**.
6. In the **Move old items to** box, type a file name for the archived items. Or select **Browse** to select from a list, and then select **OK**.
