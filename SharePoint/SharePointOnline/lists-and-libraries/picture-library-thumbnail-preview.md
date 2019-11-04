---
title: Picture Library doesn't display thumbnail previews
description: This article describes an issue where SharePoint Online Picture Library doesn't display thumbnail previews, and provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# SharePoint Online Picture Library doesn't display thumbnail previews

## Problem

You have a picture library that's using the classic experience for lists and libraries in SharePoint Online. You add a large image to the Picture Library. However, when you use the **Thumbnails** view for the library, the thumbnail image isn’t displayed. Additionally, when you click the image, the Preview field displays a broken image-link icon and the text "Picture."

## Solution/Workaround

To work around this issue, reduce the image to less than 50 megapixels, or use the new SharePoint Online Document Library view.

> [!NOTE]
> Although the thumbnail preview for the image is affected by this issue, you can open the file as expected by clicking the file name.

## More information

This issue occurs when the size of an image exceeds 50 megapixels in a picture library that uses the classic view.

For more information about the new look and navigation experience for document libraries, go to [Switch the default for document libraries from new or classic](https://support.office.com/article/switch-the-default-for-document-libraries-from-new-or-classic-66dac24b-4177-4775-bf50-3d267318caa9).

For more information about how to work with photos in a picture library, go to [Work with photos in a picture library](https://support.office.com/article/work-with-photos-in-a-picture-library-84e938f3-b578-41a3-ba31-4d3847ec21aa).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
