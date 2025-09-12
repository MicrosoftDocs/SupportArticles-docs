---
title: HTTPS linked images in HTML emails display the red X
description: Provides a resolution for the error (The linked image cannot be displayed) that occurs when you try to download an image in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Data Protection and Security\Images or links blocked in email messages
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: robevans
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# HTTPS linked images in HTML emails display the red X

_Original KB number:_ &nbsp; 3033864

## Symptoms

When you are using Microsoft Outlook, images will display a red X instead of the actual image. And, when you try to download the image you receive the following error:

> The linked image cannot be displayed. The file may have been moved, renamed, or deleted. Verify that the link points to the correct file...

This error is shown in the following figure.

:::image type="content" source="media/https-linked-images-in-html-emails-show-red-x/error.png" alt-text="Screenshot of the image display error details." border="false":::

## Cause

This problem occurs when the Internet Explorer Security setting **Do not save encrypted pages to disk** option is enabled.

## Resolution

To resolve this problem, disable the Internet Explorer Security setting **Do not save encrypted pages to disk**.

1. Exit Outlook
2. Open Internet Options, and then select the **Advanced** tab.
3. Under the Security heading, disable the **Do not save encrypted pages to disk** option.
4. Select **OK**.
5. Start Outlook.

In the event you are unable to disable the **Do not save encrypted pages to disk** option, it is being managed by Group Policy. Contact your system administrator to determine the appropriate configuration for this setting.

:::image type="content" source="media/https-linked-images-in-html-emails-show-red-x/group-policy.png" alt-text="Screenshot of the checkboxes for enabling the group policy options. Do not save encrypted pages to disk option is enabled and in grey.":::

## More information

The **Do not save encrypted pages to disk** setting is managed by the following registry data:

- Without Group Policy:

  Key: `HKEY_CURRENT_USER\software\microsoft\windows\CurrentVersion\Internet Settings`  
  DWORD: DisableCachingOfSSLPages  
  Value: 1
- With Group Policy:

  Key: `HKEY_CURRENT_USER\software\Policies\microsoft\windows\CurrentVersion\Internet Settings`  
  DWORD: DisableCachingOfSSLPages  
  Value: 1

- All users on a machine:

  Key:

  - 32-bit Office on 32-bit Windows, or 64-bit Office on 64-bit Windows

    `HKEY_LOCAL_MACHINE\software\microsoft\windows\CurrentVersion\Internet Settings`

  - 32-bit Office on 64-bit Windows

    `HKEY_LOCAL_MACHINE\software\Wow6432Node\microsoft\windows\CurrentVersion\Internet Settings`

    DWORD: DisableCachingOfSSLPages  
    Value: 1
