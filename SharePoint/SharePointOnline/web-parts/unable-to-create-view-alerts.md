---
title: "Title goes here"
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: xx/xx/xxxx
audience: Admin|ITPro|Developer
ms.topic: article
ms.service OR ms.prod: see https://docsmetadatatool.azurewebsites.net/allowlists
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- ADD PRODUCT
ms.custom: 
- CI ID
- CSSTroubleshoot 
ms.reviewer: MS aliases for tech reviewers and CI requestor, without "@microsoft.com".  
description: "How to resolve the error "Virus Found" in SharePoint Server 2013 when the antivirus scanner is unavailable ."
---

# Unable to create alerts for views in SharePoint

## Symptoms

When creating an alert in SharePoint, the option "Someone changes an item that appears in the following view" is not visible or a view doesn't show up in the drop-down list.

:::image type="content" source="media/unable-to-create-view-alerts/unable-to-create-view-alerts.png" alt-text="Highlight of the view alert option.":::
 
## Cause

This option and view shows up ONLY if you have custom views that are created with filters based on the Choice column.

The choice column should be a custom column, not a system-generated column such as “approval status”.

## Resolution

In your custom view, create a filter for items based on a custom choice column.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).