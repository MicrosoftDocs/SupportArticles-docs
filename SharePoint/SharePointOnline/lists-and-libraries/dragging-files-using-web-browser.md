---
title: Info about dragging files into SharePoint libraries by using a web browser
description: SharePoint that use the SharePoint 2013 experience version has a new feature that lets you drag files into document libraries by using a web browser.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# Information about dragging files into document libraries in SharePoint Server 2013 or SharePoint Online by using a web browser

## Introduction

SharePoint Server 2013 and SharePoint Online sites that use the SharePoint 2013 experience version have a new feature that lets you drag files into document libraries by using a web browser. This feature works when any of following conditions are true:

- You use the latest version of Mozilla Firefox.
- You use the latest version of Google Chrome.
- You use the desktop version of Internet Explorer 10 or Internet Explorer 11.
- You use Internet Explorer 8 or Internet Explorer 9, and you have Microsoft Office 2013 or newer installed on your computer.

## More information

You may experience one of the following issues, depending on your configuration:

> [!NOTE]
> This scenario affects only folders, and not files.

- When you use Internet Explorer 10 or Internet Explorer 11, you receive the following message:

  ```asciidoc
  Sorry, that didn't work
  Folders and invalid files can't be dragged to upload.
  ```
- When you use the latest version of Google Chrome, you receive the one of the following messages:

  ```asciidoc
  Folders and unsupported file types can't be uploaded.
  We can't upload folders or empty files.
  ```
- When you use the latest version of Mozilla Firefox, you receive one of the following messages:

  ```asciidoc
  Folders and unsupported file types can't be uploaded.
  We can't upload folders or empty files.
  ```

This behavior is by design. You can't drag folders into document libraries by using a web browser. This feature is limited to files. If you try to drag a folder into a document library, you'll receive an error message. The exact text of the error message depends on your browser type and version.

To work around this behavior, use either the Microsoft OneDrive for Business (formerly Microsoft SkyDrive Pro) sync client or the **Open with Explorer** feature.

For more information, visit the following Microsoft websites:

- [Sync files with the OneDrive sync client in Windows](https://support.office.com/article/sync-files-with-the-onedrive-sync-client-in-windows-615391c4-2bd3-4aae-a42a-858262e42a49)
- [How to use the "Open with Explorer" command to troubleshoot issues in SharePoint Online](https://support.office.com/article/how-to-use-the-open-with-explorer-command-to-troubleshoot-issues-in-sharepoint-online-87155331-0c92-4224-a4c1-da5c21c4ade4)
- [Microsoft Support Lifecycle for Internet Explorer](https://support.microsoft.com/lifecycle/search?sort=pn&alpha=internet%20explorer)
- [System requirements for Office](https://products.office.com/office-system-requirements/#office365forbeg)

> [!IMPORTANT]
> The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
