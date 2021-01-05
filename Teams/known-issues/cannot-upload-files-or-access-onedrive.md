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
- CSSTroubleshoot
ms.reviewer: prbalusu
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# File is locked error when uploading a file or item might not exist error when accessing OneDrive in Teams

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

The document library name on your OneDrive site isn't **Documents**.

**Note:** By default, the document library name is **Documents** on the OneDrive site.

## Resolution

You must have administrator permissions or contact your administrator to make these changes.

1. In [SharePoint Designer](https://www.microsoft.com/download/details.aspx?id=35491), open your OneDrive site.
2. Go to **All Files**.
3. Right-click the document library, select **Rename**, and rename it to **Documents**.

**Note:** We don't recommend using SharePoint Designer to perform any customization on OneDrive sites.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
