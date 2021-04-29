---
title: File is locked or item might not exist error
description: Fixes an issue in which you get the "file is locked" error when uploading a file or get the "item might not exist or is no longer available" error when accessing OneDrive in Teams.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 125872
- CI 147731
- CSSTroubleshoot
ms.reviewer: prbalusu
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# Error when uploading a file or accessing OneDrive cloud storage in Teams

## Symptoms

In Microsoft Teams, you experience one of the following errors.

### Error 1

When you upload a file in a chat, you receive the following error message:

> The file <*FileName*> didn't upload.  
> The file <*FileName*> is locked.

**Note:** This error occurs while Teams is uploading the file to the OneDrive cloud storage.

### Error 2

When you access the OneDrive cloud storage from the **Files** section, you receive the following error message:

> This item might not exist or is no longer available.  
> This item might have been deleted, expired, or you might not have permission to view it. Contact the owner of this item for more information.

## Cause

You receive these error messages if the default document library name on the OneDrive site was changed from "Documents" to some other name.

## Resolution

To resolve this issue, you must rename the document library to "Documents" by using one of the following methods.

> [!NOTE]
> You must have administrative permissions to make these changes, or contact your administrator to make these changes.

### Method 1: Use the Microsoft Admin site

1. Go to the [Microsoft Admin site](https://admin.microsoft.com/).
1. In the left pane, select **Support**, and then select **New Service Request**.
1. In the **Briefly describe your issue** field, enter *OneDrive Document Library Path Modified*.
1. In the **Run diagnostics** section, enter a value for **User Principal Name (UPN)** for the user in question, and then select **Run Tests**.

    :::image type="content" source="media/cannot-upload-files-or-access-onedrive/run-diagnostics.png" alt-text="Image shows the Run Diagnostics section.":::

1. If the test results indicate that the default document library name was changed, select the checkbox, and then select **Update Settings**.

    :::image type="content" source="media/cannot-upload-files-or-access-onedrive/update-settings.png" alt-text="Image shows the Update Settings button.":::

### Method 2: Use SharePoint Designer

1. In [SharePoint Designer](https://www.microsoft.com/download/details.aspx?id=35491), open the OneDrive site.
2. Navigate to **All Files**.
3. Right-click the library, select **Rename**, and then rename the library to **Documents**.

> [!NOTE]
> We recommend that you do not use SharePoint Designer to make customizations on OneDrive sites.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
