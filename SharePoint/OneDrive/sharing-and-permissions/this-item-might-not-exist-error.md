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
- CI 147421
- CSSTroubleshoot 
ms.reviewer: prbalusu
description: Describes a solution to the error "This item might not exist or is no longer available" when accessing OneDrive.
---

# "This item might not exist" error when accessing OneDrive

## Symptoms

When you try to access a Microsoft OneDrive webpage, you receive the following error message:

> This item might not exist or is no longer available.
> 
> This item might have been deleted, expired, or you might not have permission to view it. Contact the owner of this item for more information.

:::image type="content" source="this-item-might-not-exist-error/this-item-might-not-exist-error-1.png" alt-text="This item might not exist error.":::
 
## Cause

The default document library name on the OneDrive site was changed from ”Documents” to some other name.  

## Resolution

To resolve this issue, you must rename the document library to “Documents” by using one of the following methods.

> [!NOTE]
> You must have administrative permissions to make these changes, or contact your administrator to make these changes.

### Method 1: Use the Microsoft Admin site

> [!NOTE]
> This feature is not available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

1. Go to the [Microsoft Admin site](https://admin.microsoft.com/).
1. In the left pane, select **Support**, and then select **New Service Request**.
1. In the **Briefly describe your issue** field, enter *OneDrive Document Library Path Modified*.
1. In the **Run diagnostics** section, enter a value for **User Principal Name (UPN)** for the user in question, and then select **Run Tests**.

    :::image type="content" source="this-item-might-not-exist-error/run-diagnostics.png" alt-text="Image shows the Run Diagnostics section.":::

1. If the test results indicate that the default document library name was changed, select the checkbox, and then select **Update Settings**.

    :::image type="content" source="this-item-might-not-exist-error/update-settings.png" alt-text="Image shows the Update Settings button.":::

### Method 2: Use SharePoint Designer

1.	In [SharePoint Designer](https://www.microsoft.com/download/details.aspx?id=35491), open the OneDrive site.
2.	Navigate to **All Files**.
3.	Right-click the library, select **Rename**, and then rename the library to **Documents**.

    :::image type="content" source="this-item-might-not-exist-error/this-item-might-not-exist-error-2.gif" alt-text="Moving GIF showing how to rename Documents library.":::

> [!NOTE]
> We recommend that you do not use SharePoint Designer to make customizations on OneDrive sites. 

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
