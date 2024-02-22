---
title: Default column name shown in list settings after name change
description: If you change the name of a default column in a SharePoint Online list, the original default name is still shown in the list settings.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: pejohn
ms.custom: 
  - CSSTroubleshoot
  - CI 150405
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Default column name shown in list settings after name change

If you change the name of a default column in a SharePoint Online list, the original default name is still shown in the list settings. Changing the name in the SharePoint Online user interface (UI) creates a different property that the UI shows as the column name. However, the list settings page shows the default name, not the new property.

To have the new name shown on the list settings page, create a new custom column with the name you want, and hide the default column.

For instructions to take those actions, see:

- [Create a column in a list or library](https://support.microsoft.com/office/create-a-column-in-a-list-or-library-2b0361ae-1bd3-41a3-8329-269e5f81cfa2)

- [Show or hide columns in a list or library](https://support.microsoft.com/office/show-or-hide-columns-in-a-list-or-library-b820db0d-9e3e-4ff9-8b8b-0b2dbefa87e2)