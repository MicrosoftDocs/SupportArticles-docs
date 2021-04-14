---
title: (File is locked) or (item might not exist) error
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

In Microsoft Teams, you receive one of these error messages:

### Error 1

When uploading a file in a chat, you receive this error message:

> The file <*FileName*> didn't upload.  
> The file <*FileName*> is locked.

**Note:** This error occurs while Teams is uploading the file to the OneDrive cloud storage.

### Error 2

When accessing the OneDrive cloud storage from the **Files** section, you receive this error message:

> This item might not exist or is no longer available.  
> This item might have been deleted, expired, or you might not have permission to view it. Contact the owner of this item for more information.

## Cause

These error messages occur when the document library on your OneDrive site has been changed from its default name "Documents" to another name.

## Resolution

To resolve this issue, the document library must be renamed to “Documents”, using one of the following methods.

**Note** You must have administrator permissions or contact your administrator to make these changes.

### Method 1: Rename the library using the Microsoft Admin site

1. Go to the [Microsoft Admin site](https://admin.microsoft.com/).
1. In the navigation pane, select **Support**, and then select **New Service Request**.
1. In the **Briefly describe your issue** field, enter *OneDrive Document Library Path Modified*.
1. In the **Run diagnostics** section, enter the **User Principal Name (UPN)** for the user in question, and then select **Run Tests**.

    :::image type="content" source="./media/cannot-upload-files-or-access-onedrive/run-diagnostics.png" alt-text="Image shows the Run Diagnostics section.":::

5. If the test finds that the default Documents library name has been changed, put a check in the checkbox, and then select **Update Settings**.

    :::image type="content" source="./media/cannot-upload-files-or-access-onedrive/update-settings.png" alt-text="Image shows the Update Settings button.":::

### Method 2: Rename the library using SharePoint Designer

1. In [SharePoint Designer](https://www.microsoft.com/download/details.aspx?id=35491), open your OneDrive site.
2. Go to **All Files**.
3. Right-click the document library, select **Rename**, and rename it to **Documents**.

**Note:** We don't recommend using SharePoint Designer to perform any customization on OneDrive sites.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
