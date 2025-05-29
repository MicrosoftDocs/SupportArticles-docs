---
title: No Add-ins Loaded Due to Group Policy Settings
description: Office 2016 and later versions include Group Policy settings that control how add-ins are managed. This article provides details on configuring the Block all unmanaged add-ins and List of managed add-ins Group Policy settings.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: gregmans
ms.custom:
  - sap:Building and Debugging Add-Ins for Office 365 Web and Desktop Apps
  - CSSTroubleshoot
  - CI 5944
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
  - Office 2019
  - Office 2016
ms.date: 05/22/2025
---

# No Add-ins loaded due to Group Policy settings

## Symptoms

When you select **File** > **Options** > **Add-ins** in an Office or Microsoft 365 application, none of your add-ins are enabled, as shown in the following example for Outlook.

:::image type="content" source="media/office-add-in-not-loaded/no-add-in-outlook.png" alt-text="Screenshot shows no add-ins are enabled in Outlook.":::

If you then open the **COM Add-ins** dialog box by selecting **Go**, you can't enable any of the listed add-ins. When you select any add-in, the **COM Add-ins** dialog box displays the following message:

> The add-in you have selected is disabled by your system administrator.

:::image type="content" source="media/office-add-in-not-loaded/warning-in-outlook.png" alt-text="Screenshot of the warning message in Outlook." border="false":::

## Cause

This problem occurs because your administrator configures a Group Policy setting to disable all COM add-ins.

> [!WARNDING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

The following registry data is used to disable all add-ins:

**Key:** `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\<application>\Resiliency`

**DWORD:** RestrictToList

**Value:** 1

In addition, under the `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\<application>\Resiliency\AddinList`key, nothing is listed except for the Default REG_SZ value with no data.

**Note**: In the above registry keys, \<application\> is the name of the application in which you experience this problem.

## More Information

Administrator can manage the add-ins that are loaded in Office applications by using the following Group Policy settings.

- List of Managed Add-ins

  This policy setting allows you to specify which add-ins are always enabled, always disabled (blocked), or configurable by the user. To block add-ins that aren't managed by this policy setting, you must also configure the **Block all unmanaged add-ins** policy setting.

  To enable the **List of Managed Add-ins** policy setting, you must provide the programmatic identifier (ProgID) for each COM add-in that you want to manage. To obtain the ProgID for an add-in, use Registry Editor on the client computer where the add-in is installed. Locate the registry key names under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\<application>\Addins` or `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\<application>\Addins`.

  To use this policy, you must also specify how each add-in is managed. To specify how each add-in is managed, configure one of the following three options:

  - **0**: The add-in is always disabled (blocked).
  - **1**: The add-in is always enabled.
  - **2**: The add-in can be manually enabled or disabled by the user.

  When you enable the **List of Managed Add-ins** policy setting, the following registry data is configured on the Office client:

  **Key:** `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\<application>\Resiliency\AddinList`
  
  **REG_SZ:** \<ProgID for the add-in\>

  **Values:** Specify one of the following values:

  - **0**: The add-in is always disabled (blocked).
  - **1**: The add-in is always enabled.
  - **2**: The add-in can be manually enabled or disabled by the user.

- Block all unmanaged add-ins

  This policy setting blocks all add-ins that aren't managed by the **List of Managed Add-ins** policy setting.

  If you enable the **Block all unmanaged add-ins** and **List of Managed Add-ins** policy settings, all add-ins are blocked except those that are configured in the list of managed add-ins as 1 (always enabled) or 2 (configurable by the user).

  When you enable the **Block all unmanaged add-ins** policy setting, the following registry data is configured on the Office client:

  **Key:** `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\<application>\Resiliency`

  **DWORD:** RestrictToList

  **Value:** 1

  When `RestrictToList` is set to 1 and you don't enable any add-ins by using the **List of Managed Add-ins** policy setting, all COM add-ins are disabled.
