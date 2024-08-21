---
title: Error (The workbook is currently open by 256 users) when opening an Excel workbook from SharePoint or OneDrive
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 06/06/2024
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Open\Sharing
  - sap:office-experts
  - CSSTroubleshoot
  - CI 106765
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - SharePoint Online
ms.reviewer: denniwil
description: Describes how to resolve a shared workbook error when opening a Microsoft 365 Excel file.
---

# "The workbook is currently open by 256 users" error when opening an Excel workbook from SharePoint or OneDrive

## Symptoms
You receive the following error when opening an Excel workbook that is stored on SharePoint or OneDrive:

   > "The workbook is currently open by 256 users. A maximum of 256 users can have a shared workbook open at the same time.<br/>
The workbook will be opened read-only. You can try again later when one or more users have closed the workbook."

## Cause
"Shared Workbooks" is a legacy sharing option that allows you to collaborate on a workbook with multiple authors. This feature has been replaced in Microsoft 365 by the co-authoring feature. 

## Resolution
To resolve this issue, select the **Review** tab of the ribbon, and within the **Protect** group select **Unshare Workbook**. 

For other versions of Excel, see the article [About the shared workbook feature](https://support.office.com/en-us/article/About-the-shared-workbook-feature-49b833c0-873b-48d8-8bf2-c1c59a628534) and follow the steps provided under **Additional Information** > **Turning off the Shared Workbook feature**. 

## More information
For more information about co-authoring, see [What you need to co-author](https://support.office.com/en-us/article/Collaborate-on-Excel-workbooks-at-the-same-time-with-co-authoring-7152aa8b-b791-414c-a3bb-3024e46fb104).
