---
title: Image in HTML-formatted email not shown
description: Resolves an issue in which an image in an HTML-formatted email message is not displayed in Outlook 2013. This issue occurs when you use a proxy server that is configured to use basic authentication.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: sercast
appliesto: 
  - Outlook 2013
search.appverid: MET150
ms.date: 10/30/2023
---
# An image in an HTML-formatted email message is not displayed in Outlook 2013 when you use a proxy server that is configured to use basic authentication

_Original KB number:_ &nbsp; 2846350

## Symptoms

Consider the following scenario:

- You have a computer that is running Microsoft Outlook 2013.
- You access the Internet by using a proxy server that is configured to use basic authentication.
- You use Outlook 2013 to open an HTML-formatted email message.
- The HTML-formatted email message contains an HTTP reference to an image that requires proxy authentication.

In this scenario, you are not prompted for authentication, and the image is not displayed.

## Resolution

To resolve this issue, follow these steps:

1. Select **Start**, select **Run**, type regedit in the **Open** box, and then select **OK**.
2. Locate and then select the following registry subkey:  
   `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common`

3. On the **Edit** menu, point to **New**, and then select **DWORD (32-bit) Value**.
4. Type *AllowImageProxyAuth*, and then press Enter.
5. In the **Details** pane, right-click **AllowImageProxyAuth**, and then select **Modify**.
6. In the **Value data** box, type *1* or *2*, and then select **OK**.
7. Exit Registry Editor.

> [!NOTE]
>
> - If you set the value to **1** in step 6, you are prompted for authentication one time per Outlook session in the scenario that is described in the Symptoms section. If you cancel the authentication request, you are not prompted again during that Outlook session. This option introduces a small volume of network overhead per Outlook session.
> - If you set the value to **2** in step 6, you are prompted for authentication when it is required. Typically you are prompted for authentication one time per Outlook session. However, in some scenarios, you may be prompted multiple times. For example, if you cancel the authentication request for one image, you are prompted again for the next image that requires proxy authentication. This option introduces additional network overhead for each downloaded image. If an email message contains multiple images, the additional network overhead may cause slow performance in Outlook.
> - If the value in step 6 is nonexistent, or if you set the value to **0**, you are not prompted for authentication, and the image might not be displayed.
