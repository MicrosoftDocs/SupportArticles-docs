---
title: Can't create alerts for views in SharePoint
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 6/4/2020
audience: Admin
ms.topic: article
ms.prod: sharepoint
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint
ms.custom: 
- CI 119396
- CSSTroubleshoot 
ms.reviewer: prbalusu
description: Describes a resolution to an issue where a view doesn't appear in the option "Someone changes an item that appears in the following view". 
---

# Unable to create alerts for views in SharePoint

## Symptoms

When creating an alert in SharePoint, the option "Someone changes an item that appears in the following view" is not visible or a view doesn't show up in the drop-down list.

:::image type="content" source="media/unable-to-create-view-alerts/unable-to-create-view-alerts.png" alt-text="Highlight of the view alert option.":::
 
## Cause

This option and view shows up ONLY if you have custom views that are created with filters based on the **Choice** column.

The **Choice** column must be a custom column, not a system-generated column such as **Approval Status**.

## Resolution

In your custom view, create a filter for items based on a custom **Choice** column.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).