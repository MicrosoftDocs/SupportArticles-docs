---
title: SharePoint 2010 Workflow platform creates Word files that can't be opened
description: You cannot open Word documents that's created by SharePoint 2010 Workflow platform.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Workflows and Automation\Other
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# SharePoint 2010 Workflow platform creates Word files that can't be opened

## Problem

Consider the following scenario:

- You create a Microsoft SharePoint Online or a SharePoint 2013 on-premises workflow by using the SharePoint 2010 Workflow platform type.
- The workflow uses the **Create List Item** action to create a Microsoft Word document.
- When you try to open the Word document in Microsoft Word for the web, you receive the following error message:

  **Sorry, Word for the web ran into a problem opening this document. To view this document, please open it in Microsoft Word.**

- When you try to open the file in Word, you receive the following error message:

  **We're sorry. We cannot open *file_name* because we found a problem with its contents.**

## Solution/Workaround

To work around this issue, change the document template that's used for the affected content type. To do this, follow these steps:

1. On the affected SharePoint list, create a Word document by clicking the **New Document** button on the SharePoint ribbon.
1. Download a copy of the file that you created in step 1.
1. On the **LIBRARY** tab in the affected list, click **Library Settings**, and then click the name of the content type that's associated with the affected template.
1. Click **Advanced settings**.
1. Click the **Upload a new document template** option, and then click **Browse**.
1. Select the file that you downloaded in step 2, and then click **Open**.
1. On the **Advanced Settings** page, click **OK**.

> [!NOTE]
> This workaround affects the templates are used when you create list items by clicking the **New Document** button on the ribbon.

## More information

This behavior is by design. The **Create List Item** action in the **SharePoint 2010 Workflow** platform can't convert Word content type file templates to the correct .docx format.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
