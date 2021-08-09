---
title: Internet Explorer Mode in Windows 10
description: This article describes how Internet Explorer Enterprise Mode works in Windows 10.
ms.date: 01/21/2021
ms.prod-support-area-path: Administration
ms.reviewer: 
ms.topic: article
---
# How Enterprise Mode works in Windows 10

[!INCLUDE [](../includes/browsers-important.md)]

This article describes how Internet Explorer Enterprise Mode works in Windows 10.

_Applies to:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 4019877

## Summary

On a Windows 10-based computer, sites that are specified on the Enterprise Mode site list open automatically in Internet Explorer 11 and in Microsoft Edge.

## More information

This action occurs without any user input. For example, Contoso Travel requires Internet Explorer legacy proprietary technologies. The website was on the Enterprise Mode site list or in the Intranet Zone. When a user visits the following page in Microsoft Edge, the site is automatically opened in Internet Explorer 11.
![Open in Internet Explorer 11](./media/internet-explorer-mode-windows-10/contoso-travel-image.png)

> [!NOTE]
> On a Windows 10-based computer that has the [Anniversary Update](https://support.microsoft.com/help/12387) installed, when a site is opened in Edge and is redirected to Internet Explorer 11, the **Open With Internet Explorer** option is disabled and that message does not appear. Instead, the webpage is automatically redirected and loaded in Internet Explorer 11.

To re-enable the message, you can configure the following policy:

- **Show message when opening sites in Internet Explorer**

  ![policy](./media/internet-explorer-mode-windows-10/show-message-image.png)

In the Windows 10 Anniversary Update, the following new group policy makes sure that sites that aren't on the Enterprise Mode site list should default to Microsoft Edge:

- **Send all sites not included in the Enterprise Mode Site List to Microsoft Edge**

  ![Policy](./media/internet-explorer-mode-windows-10/send-all-sites-image.png)
