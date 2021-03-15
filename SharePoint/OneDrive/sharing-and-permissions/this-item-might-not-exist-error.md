---
title: (This item might not exist or is no longer available) error when using OneDrive 
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/16/2020
audience: Admin
ms.topic: article
ms.prod: onedrive
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- OneDrive
ms.custom: 
- CI 125780
- CSSTroubleshoot 
ms.reviewer: prbalusu
description: Describes a solution to the error "This item might not exist or is no longer available" when accessing OneDrive.
---

# "This item might not exist" error when accessing OneDrive 

## Symptoms

When you try to access a Microsoft OneDrive webpage, you see the following error message:

> This item might not exist or is no longer available. 
> 
> This item might have been deleted, expired, or you might not have permission to view it. Contact the owner of this item for more information.

:::image type="content" source="this-item-might-not-exist-error/this-item-might-not-exist-error-1.png" alt-text="This item might not exist error.":::
 
## Cause

The default document library name on the OneDrive site was changed from ”Documents” to some other name.  

## Resolution

To resolve this issue, follow these steps:

1.	In SharePoint Designer, open the OneDrive site.
2.	Navigate to **All Files**.
3.	Right-click the library, select **Rename**, and then rename the library to **Documents**.

    :::image type="content" source="this-item-might-not-exist-error/this-item-might-not-exist-error-2.gif" alt-text="Moving GIF showing how to rename Documents library.":::

> [!note]
> We do not recommended that you use SharePoint designer to perform customizations on OneDrive sites. 

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).