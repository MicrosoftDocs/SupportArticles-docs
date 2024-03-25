---
title: List or view is read-only in SharePoint Datasheet View
description: Fixes an issue in which a list or view is read-only when you try to edit the list in SharePoint Datasheet View.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Administration\Lists and libraries
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - SharePoint Server 2010
  - SharePoint Server 2013
  - SharePoint Server 2016
  - SharePoint Server 2019
search.appverid: MET150
ms.date: 12/17/2023
---
# Unable to edit a list in SharePoint Datasheet View with Content Approval turned on

_Original KB number:_ &nbsp; 2274841

## Symptoms

When choosing to edit a list in Microsoft SharePoint Datasheet View, the list or view is read-only. You can observe this by seeing the message "This view is read-only" at the bottom of the datasheet.

## Cause

The Microsoft SharePoint **Content Approval** setting has been turned on for the list. The Datasheet View control doesn't support making edits to lists that have **Content Approval** turned on.

## Resolution

Make your edits in Microsoft SharePoint Standard View or turn off **Content Approval**.

To turn off **Content Approval** in Microsoft SharePoint, do the following:

1. In the list, select **Settings**.
2. Select **List Settings**.
3. Select **Versioning Settings**.
4. In the **Content Approval** section, select **No** for **Require content approval for submitted items**.
