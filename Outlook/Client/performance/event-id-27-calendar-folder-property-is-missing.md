---
title: Event ID 27 and Calendar Folder property is missing error
description: Describes an issue in which some users will see lots of instances of Event ID 27 in the Application log.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: abarglo, gbratton, aruiz
appliesto: 
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Event ID 27 and Calendar Folder property is missing error occurs after you apply Office 2010 SP2

_Original KB number:_ &nbsp; 2883156

## Summary

After you apply Microsoft Office 2010 Service Pack 2 (SP2) or hotfixes released after SP2, users may see many Event ID 27 warnings from Outlook in the Application log. This issue occurs for users who have a PST attached to their profile. This includes PSTs that were created by connecting to a Microsoft SharePoint site.

The following is an example event in the Application log:

> Log Name: Application  
Source: Outlook  
Date: DateTime  
EventID: 27  
Task Category: None  
Level: Warning  
Keywords: Classic  
User: N/A  
Computer: ComputerName  
Description:  
Calendar Folder Property is missing

## Workaround

To work around this problem, PSTs can be removed from the profile. To remove PSTs from your Outlook profile, follow these steps:

1. Open Microsoft Outlook 2010.
2. Select **File**, and then select **Account Settings**.
3. Select the **Data Files** tab.
4. Select the data file that you want to remove, and then select **Remove**.

Removing PSTs from your profile will not remove the PSTs from your system. Removing some PSTs may result in loss of functionality in Outlook. For example, removing the SharePoint Lists PST will remove connections to SharePoint sites.
