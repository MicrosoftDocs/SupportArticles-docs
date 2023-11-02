---
title: Explorer work item form doesn't display images
description: This article provides a workaround for the problem that prevents inline images from being rendered in Visual Studio Team Explorer.
ms.date: 08/14/2020
ms.custom: sap:Boards
ms.service: azure-devops
ms.subservice: ts-boards
---
# Visual Studio Team Explorer work item form doesn't display inline images

This article helps you work around the problem that prevents inline images from being rendered in Visual Studio Team Explorer.

_Original product version:_ &nbsp; Team Foundation Server 2013, Team Foundation Server 2015, Azure DevOps Services Premium  
_Original KB number:_ &nbsp; 4011768

## Symptoms

When you open a work item that has inline images in Microsoft Visual Studio Team Explorer, the images are not displayed as expected.  

:::image type="content" source="media/explorer-work-item-form-doesnt-display-image/images-not-display.png" alt-text="Screenshot shows the images aren't displayed as expected.":::

> [!NOTE]
> The images are displayed without a problem when you open the same work item in the web browser.

## Cause

This issue occurs if your Visual Studio browser credentials to access Visual Studio Team Services or Microsoft Team Foundation Server have expired.  

## Workaround

To work around this issue, follow these steps:

1. In Visual Studio, click **View**, click **Other Windows**, and then click **Web Browser**. You can also use the Ctrl+Alt+R shortcut to do this.
2. Locate your Visual Studio Team Services or Team Foundation Server account in the web browser.
3. Log on with your account.
4. Refresh your work item in Team Explorer.  

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
