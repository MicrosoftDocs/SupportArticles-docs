---
title: Default Office Add-in icon is displayed in the Outlook Ribbon
description: Describes an issue in which Office Add-in icon isn't displayed the actual icon in the Outlook Ribbon in Outlook 2013 or 2016.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 118852
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook 2016
  - Outlook 2013
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# Default Office Add-in image displayed in the Outlook Ribbon

## Symptoms

In Microsoft Outlook 2013 or Outlook 2016, the default Office Add-in image is displayed in the Outlook Ribbon instead of the actual Office Add-in image.

For example, this screenshot shows the default icon for **Share to Teams** and **Reply with Meeting Poll** Office Add-ins:

:::image type="content" source="./media/default-office-addin-icon-displayed-outlook-ribbon/default-office-addin-icon.png" alt-text="Screenshot of default Office Add-in.":::

This screenshot shows the expected icon for **Share to Teams** and **Reply with Meeting Poll** Office Add-ins:

:::image type="content" source="./media/default-office-addin-icon-displayed-outlook-ribbon/actual-office-addin-icon.png" alt-text="Screenshot of actual Office Add-in.":::

## Cause

The Internet Explorer Security setting **Do not save encrypted pages to disk** option is enabled.

## Resolution

Disable the Internet Explorer Security setting **Do not save encrypted pages to disk**:

1. Exit Outlook
2. In Windows, open **Internet Options** and select **Advanced** tab.
3. Under the **Security** heading, clear the **Do not save encrypted pages to disk** option.
4. Select **OK**.
5. Start Outlook.

If you can't disable the option, it's managed by a Group Policy. Contact your system administrator to determine the appropriate configuration for this setting.

## More information

The **Do not save encrypted pages to disk** setting is managed by the following registry keys:

- Without Group Policy:

    ```
    HKEY_CURRENT_USER\software\microsoft\windows\CurrentVersion\Internet Settings  
    DWORD: DisableCachingOfSSLPages  
    Value: 1
    ```

- Group Policy:

    ```
    HKEY_CURRENT_USER\software\Policies\microsoft\windows\CurrentVersion\Internet
    DWORD: DisableCachingOfSSLPages
    Value: 1
    ```

- All users on a computer:
  - 32-bit Office installed on 32-bit Windows, or 64-bit Office installed on 64-bit Windows:

    ```
    HKEY_LOCAL_MACHINE\software\microsoft\windows\CurrentVersion\Internet Settings
    DWORD:DisableCachingOfSSLPages 
    Value:1
    ```

  - 32-bit Office installed on 64-bit Windows:

    ```
    HKEY_LOCAL_MACHINE \software\Wow6432Node\microsoft\windows\CurrentVersion\Internet Settings
    DWORD:DisableCachingOfSSLPages
    Value:1
    ```
