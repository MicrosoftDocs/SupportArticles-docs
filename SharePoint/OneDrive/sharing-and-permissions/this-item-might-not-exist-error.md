---
title: (This item might not exist or is no longer available) error when using OneDrive
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
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
description: Describes a solution to the error This item might not exist or is no longer available when accessing OneDrive.
---

# "This item might not exist" error when accessing OneDrive

## Symptoms

When you try to access a Microsoft OneDrive webpage, you receive the following error message:

> This item might not exist or is no longer available.
> 
> This item might have been deleted, expired, or you might not have permission to view it. Contact the owner of this item for more information.

:::image type="content" source="this-item-might-not-exist-error/this-item-might-not-exist-error.png" alt-text="Screenshot of This item might not exist error.":::
 
## Cause

The default document library name on the OneDrive site was changed from ”Documents” to some other name.  

## Resolution

To resolve this issue, you must rename the document library to “Documents” by using one of the following methods.

> [!NOTE]
> You must have administrative permissions to make these changes, or contact your administrator to make these changes.

### Method 1: Use the Microsoft Admin site

> [!NOTE]
> This diagnostic isn't available for the GCC High or DoD environments, or for Microsoft 365 operated by 21Vianet.

1. Select **Run Tests** below, which will populate the diagnostic in the Microsoft 365 Admin Center. 

    > [!div class="nextstepaction"]
    > [Run Tests: OneDrive Document Library Path Modified](https://aka.ms/PillarOneDriveLibraryPathModified)
    
1. In the **Run diagnostics** section, enter a value for **User Principal Name (UPN)** for the user in question, and then select **Run Tests**.

    :::image type="content" source="this-item-might-not-exist-error/run-diagnostics.png" alt-text="Screenshot shows the Run Diagnostics section.":::

1. If the test results indicate that the default document library name was changed, select the checkbox, and then select **Update Settings**.

    :::image type="content" source="this-item-might-not-exist-error/update-settings.png" alt-text="Screenshot shows the Update Settings button.":::

### Method 2: Use SharePoint Designer

1.	In [SharePoint Designer](https://www.microsoft.com/download/details.aspx?id=35491), open the OneDrive site.
2.	Navigate to **All Files**.
3.	Right-click the library, select **Rename**, and then rename the library to **Documents**.

    :::image type="content" source="this-item-might-not-exist-error/sharepoint-designer-rename-documents-library.gif" alt-text="Animated GIF showing how to rename Documents library.":::

> [!NOTE]
> We recommend that you do not use SharePoint Designer to make customizations on OneDrive sites. 

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
