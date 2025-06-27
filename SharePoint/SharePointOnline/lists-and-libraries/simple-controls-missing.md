---
title: The simple controls are missing for a SharePoint Online document library
description: This article explains an issue where the simple controls are missing for a SharePoint document library, and provides a solution.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Lists and Libraries\List Designs
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# The simple controls are missing for a SharePoint Online document library 

## Problem

When you browse to a SharePoint Online document library in classic Experience, the following simple controls are missing and aren't available for the list:

- New
- Upload
- Sync
- Edit
- Manage
- Share

## Solution

To work around this problem, use the **Default** style within the view for the affected library. Or, switch to Modern Experience.

## More information

This problem occurs when you use a view for the document library if the view style is configured to any setting other than **Default**.

For more information about how to create, change, or delete a view of a list or library, go to [Create, change, or delete a view of a list or library](https://support.office.com/article/create-change-or-delete-a-view-of-a-list-or-library-27ae65b8-bc5b-4949-b29b-4ee87144a9c9?ocmsassetID=HA102774516&CorrelationId=b5cd93cb-5967-44a0-ab95-6259affd46d1).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
