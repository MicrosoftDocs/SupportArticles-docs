---
title: No Add-ins Loaded Because of Group Policy Settings
description: Provides details to configure the Block all unmanaged add-ins and List of managed add-ins Group Policy settings in Office 2016 and later.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
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
ms.date: 06/02/2025
---

# No add-ins loaded because of Group Policy settings

## Symptoms

When you select **File** > **Options** > **Add-ins** in an Office or Microsoft 365 application, none of your add-ins are enabled, as shown in the following example for Microsoft Outlook.

:::image type="content" source="media/office-add-in-not-loaded/no-add-in-outlook.png" alt-text="Screenshot shows no add-ins are enabled in Outlook.":::

If you open the **COM Add-ins** dialog box by selecting **Go**, you can't enable any of the listed add-ins. When you select any add-in, the **COM Add-ins** dialog box displays the following warning message:

> The add-in you have selected is disabled by your system administrator.

:::image type="content" source="media/office-add-in-not-loaded/warning-in-outlook.png" alt-text="Screenshot of the warning message in Outlook." border="false":::

## Cause

This problem occurs because your administrator configures Group Policy settings to disable all COM add-ins.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or another method. These problems might require that you reinstall the operating system. Microsoft can't guarantee that these problems can be solved. Modify the registry at your own risk.

In this situation, the `RestrictToList` value under the `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\<application>\Resiliency` registry subkey is set to **1**. Additionally, under the `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\<application>\Resiliency\AddinList` subkey, nothing is listed except the **(Default)** value.

**Note**: In these registry subkeys, \<application\> is the name of the application in which you experience this problem.

Administrators can manage the add-ins that are loaded in Office applications by using the following Group Policy settings.

- List of Managed Add-ins

  This policy setting enables you to specify which add-ins are always enabled, always disabled (blocked), or configurable by the user. To block add-ins that aren't managed by this policy setting, you must also configure the **Block all unmanaged add-ins** policy setting.

  To enable the **List of Managed Add-ins** policy setting, you must provide the programmatic identifier (ProgID) for each COM add-in that you want to manage. To obtain the ProgID for an add-in, use Registry Editor on the client computer where the add-in is installed. Locate the registry key names under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\<application>\Addins` or `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\<application>\Addins`.

  To use this policy, you must also specify how each add-in is managed. To do this, configure one of the following three options:

  - **0**: The add-in is always disabled (blocked).
  - **1**: The add-in is always enabled.
  - **2**: The add-in can be manually enabled or disabled by the user.

  If you enable the **List of Managed Add-ins** policy setting, the following registry data is configured on the Office client:

  **Subkey:** `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\<application>\Resiliency\AddinList`
  
  **Value name:** \<ProgID for the add-in\>

  **Value data:** Specify one of the following values:

  - **0**: The add-in is always disabled (blocked).
  - **1**: The add-in is always enabled.
  - **2**: The add-in can be manually enabled or disabled by the user.

- Block all unmanaged add-ins

  This policy setting blocks all add-ins that aren't managed by the **List of Managed Add-ins** policy setting.

  If you enable the **Block all unmanaged add-ins** and **List of Managed Add-ins** policy settings, all add-ins are blocked except those add-ins that are configured in the list of managed add-ins as **1** (always enabled) or **2** (configurable by the user).

  If you enable the **Block all unmanaged add-ins** policy setting, the following registry data is configured on the Office client:

  **Subkey:** `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\<application>\Resiliency`

  **Value name:** RestrictToList

  **Value data:** 1

  If `RestrictToList` is set to **1**, and you don't enable any add-ins by using the **List of Managed Add-ins** policy setting, all COM add-ins are disabled.
