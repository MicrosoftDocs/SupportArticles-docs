---
title: SharePoint Online content manual migration
description: This document describes the steps to save a SharePoint document library or list content from a SharePoint Online environment to file shares or to a local computer.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Information about manual migration of SharePoint Online content

## Introduction

Offboarding is the ability to move data from Microsoft 365 to file shares or to a local computer. This is a manual process. This document describes the steps to save a SharePoint document library or list content from a SharePoint Online environment to file shares or to a local computer.

This document covers the following SharePoint Online archive scenarios:

- Administrator or site owner archives the contents of a SharePoint Online document library. This is a manual process when you use SharePoint Online.
- Administrator or list owner archives the contents of a SharePoint list. This is a manual process when you use SharePoint Online.
- Administrator or list owner archives the following information from a SharePoint list to Outlook: Calendar items, Contact items, Document libraries, Discussion lists and Tasks.

This document doesn't cover the following scenarios:

- Migration of SharePoint content from SharePoint Online to a local SharePoint installation: Transferring content between SharePoint Online and local SharePoint installations isn't supported in this version of SharePoint Online.
- Preservation of list content properties, functionality, and relationships: SharePoint list content can be archived in spreadsheet or database table format. These spreadsheets or tables contain the content from the SharePoint list. However, the properties, permissions, functionality, and relationships between the various tables and table contents aren't preserved.

## Procedure

### Archive SharePoint Online document library content

If you want to migrate lots of SharePoint Online files, we recommend syncing the libraries or folders. Then you can use **File Explorer** on your computer (or **Finder** on a Mac) to move the files to the new location. For more information about syncing SharePoint files, see [Sync SharePoint files with the new OneDrive sync client](https://support.office.com/article/sync-sharepoint-files-with-the-new-onedrive-sync-client-6de9ede8-5b6e-4503-80b2-6190f3354a88).

If you want to migrate only a few files to another SharePoint Online document library, you can do this in your browser. For more information, see [Move or copy files in SharePoint](https://support.office.com/article/move-or-copy-files-in-sharepoint-00e2f483-4df3-46be-a861-1f5f0c1a87bc).

You can also use **Open with Explorer** to migrate files to a new location. For more information, see [Copy or move library files by using Open with Explorer](https://support.office.com/article/copy-or-move-library-files-by-using-open-with-explorer-aaee7bfb-e2a1-42ee-8fc0-bcc0754f04d2
).

SharePoint document libraries can contain many kinds of files, and SharePoint maintains information about each file that SharePoint stores. Most of this other information isn't preserved when the files are downloaded. For example, the following information isn't included when a file is downloaded:

- Document properties
- File access permissions
- Relative links between files
- Workflow information
- Versioning information
- Templates

### Archive SharePoint list

To archive SharePoint Online document library content, you must be able to connect to your organization's SharePoint Online sites. The person archiving SharePoint list content must have either Excel 2010 or Excel 2013 installed.

The following kinds of SharePoint lists can be linked to Outlook:

- Calendar
- Contacts
- Tasks
- Document Libraries
- Discussion
- Lists

To archive SharePoint list data to Excel, follow these steps:

1. Browse to the SharePoint list.
1. On the **LIST** or **LIBRARY** tab, click **Export to Excel**.
1. Select **Open**.
1. Under **Import Data**, select where you want to put the data (if this is applicable). The list is exported to Excel.
1. You can save the file to your local directory.
1. Repeat this process for every SharePoint list.

   > [!NOTE]
   > This process will save entries in a list. The actual content such as files and attachments won't be saved when you use this method.

To archive a SharePoint Calendar list to Outlook, follow these steps:

1. Browse to the SharePoint Calendar to be archived.
1. Click the **CALENDAR** tab, and then click **Connect to Outlook**.
1. On the **Actions** menu, click **Connect to Outlook**, and in the Outlook dialog box, click **Yes**. The Calendar is saved to Outlook.

To archive a SharePoint Contacts list to Outlook, follow these steps:

1. Browse to the SharePoint Contact list.
1. Click **LIST**, and then click **Connect to Outlook**.
1. In the Outlook dialog box, click **Yes**. The Contact list is saved to Outlook.

To archive a SharePoint Tasks list Outlook, follow these steps:

1. Browse to the SharePoint Tasks list.
1. Click **LIST**, and then click **Connect to Outlook**.
1. In the Outlook dialog box, click **Yes**. The Tasks list is saved to Outlook.

To archive SharePoint Document Libraries to Outlook, follow these steps:

1. Browse to the SharePoint Document Library.
1. On the ribbon, click **LIBRARY**, and then click **Connect to Outlook**.
1. In the Outlook dialog box, click Yes. The Library is saved to Outlook.

To archive a SharePoint Discussion Board list to Outlook, follow these steps:

1. Browse to the SharePoint Discussion list.
1. On the **LIBRARY** tab, click **Connect to Outlook**.
1. In the Outlook dialog box, click **Yes**. The Library is saved to Outlook.

The OneDrive for Business sync client is an additional option that provides the functionality to take SharePoint items offline and save them to your local computer. For more information about how to use the OneDrive for Business sync client, go to the following Microsoft website:

[Sync files with the OneDrive sync client in Windows](https://support.office.com/article/sync-files-with-the-onedrive-sync-client-in-windows-615391c4-2bd3-4aae-a42a-858262e42a49)

## Known limitations

SharePoint list content must be exported to Excel or to an Access database. Simple lists can be exported to Excel. However, if the content of a single cell exceeds Excel's maximum cell size limit of 32,767 characters, the information that exceeds that maximum is lost. If your lists contain large cells, you should export to Access.

SharePoint lists are used to host complex data like wikis and blogs. These complex data forms consist of several tables. For example, blog tables are as follows: Categories, Posts, Comments, Links, and Other Blogs. For the best results, export wikis and blogs to Access. When wikis and blogs are exported to Access, each of these tables is exported correctly. However, all properties, permissions, and relationships between tables and contents are lost.

When you export list data to Access or Excel, list data will be saved. However, attachments and documents within the list won't be archived. To archive attachments and documents, follow the instructions in the "Archive SharePoint Online document library content" section.

## Additional resources

For more information about how to use and troubleshoot "Open with Explorer" issues, see [How to use the "Open with Explorer" command to troubleshoot issues in SharePoint Online](https://support.office.com/article/how-to-use-the-open-with-explorer-command-to-troubleshoot-issues-in-sharepoint-online-87155331-0c92-4224-a4c1-da5c21c4ade4).

For more information about how to synchronize a SharePoint 2010 list by using Access 2010, see [Synchronize a SharePoint 2010 list with Access 2010](https://support.office.com/article/synchronize-a-sharepoint-2010-list-with-access-2010-975bfb97-c799-4fce-b7cc-3db3b397f116).

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
