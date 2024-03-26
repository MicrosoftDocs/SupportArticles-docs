---
title: No Add-ins loaded due to group policy settings
description: Microsoft Outlook 2013 and Outlook 2016 include group policy settings that control how add-ins are managed. An administrator may use these settings to enable or disable specific add-ins. Additionally, these can be configured to allow a user to control the use of a specific add-in. This article provides details on configuring the Block all unmanaged add-ins and List of managed add-ins group policy settings.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: gregmans
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2016
  - Outlook 2016
  - PowerPoint 2016
  - Word 2016
  - Word 2013
  - Outlook 2013
  - Excel 2013
  - PowerPoint 2013
ms.date: 03/31/2022
---

# No Add-ins loaded due to group policy settings for Office 2013 and Office 2016 programs

## Symptoms

When you look at **Add-Ins** section of the **Options** dialog box in a Microsoft 2016 or Microsoft Office 2013 program, none of your add-ins are enabled, as shown in the following figure for Outlook.

:::image type="content" source="media/office-add-in-not-loaded/no-add-in-outlook.png" alt-text="Screenshot shows no add-ins are enabled in Outlook.":::

If you then open the **COM Add-ins** dialog box by clicking **Go**, you cannot enable any of the listed add-ins. When you select any add-in, the **COM Add-ins** dialog box displays the following text.

> The add-in you have selected is disabled by your system administrator.

The warning is shown in the following figure for Outlook.

:::image type="content" source="media/office-add-in-not-loaded/warning-in-outlook.png" alt-text="Screenshot of the warning message in Outlook." border="false":::

## Cause

Warning Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

This problem occurs because your administrator has configured a group policy setting to disable all COM add-ins.

The following registry data is used to disable all add-ins:

**Key:** HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\\\<application>\Resiliency

**DWORD:** RestrictToList

**Value:** 1

**Key:**   HKEY_CURRENT_USER\Software\Microsoft\Office\x.0\\\<application>\Resiliency\AddinList

> [!NOTE]
>
> - When this problem occurs, there is nothing listed under this key except for the Default REG_SZ value with no data.
> - In the above registry data, \<application> is the name of the Office program in which you are experiencing this problem.
> - In the above registry key path, x.0 corresponds to version of Office (16.0 = Office 2016, 15.0 = Office 2013).

## More Information

Through group policy, an administrator can manage the add-ins that are loaded in Office 2016 or Office 2013 programs. The following group policy settings are used to manage this functionality.

- List of managed add-ins

  This policy setting allows you to specify which add-ins are always enabled, always disabled (blocked), or configurable by the user. To block add-ins that are not managed by this policy setting, you must also configure the Block all unmanaged add-ins policy setting.

  To enable the List of managed add-ins policy setting, you must provide the programmatic identifier (ProgID) for each COM add-in that you want to manage. To obtain the ProgID for an add-in, use the Windows Registry Editor on the client computer where the add-in is installed. Locate the registry key names under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\\\<application>\Addins or HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\\\<application>\Addins.

  To use this policy, you must also specify how each add-in should be managed. To specify how each add-in is managed, configure one of the following three options:

  **0**: The add-in is always disabled (blocked)

  **1**: The add-in is always enabled

  **2**: The add-in can be manually enabled or disabled by the user

  When you enable the List of managed add-ins policy, the following registry data is configured on the Office 2016 or Office 2013 client:

  **Key:** HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\\\<application>\Resiliency\AddinList
  
  **REG_SZ:** \<ProgID for the add-in>

  **Values:** \<one of the following values>

  **0** = The add-in is always disabled (blocked)

  **1** = The add-ins is always enabled

  **2**= The add-in can be manually enabled or disabled by the user

  > [!NOTE]
  > In the above registry key path, x.0 corresponds to version of Office (16.0 = Office 2016, 15.0 = Office 2013)
- Block all unmanaged add-ins

  This policy setting blocks all add-ins that are not managed by the "List of managed add-ins" policy setting.

  If you enable the Block all unmanaged add-ins and List of managed add-ins policy settings, all add-ins are blocked except those that are configured in the List of managed add-ins as 1 (always enabled) or 2 (configurable by the user).

  When you enable the Block all unmanaged add-ins policy, the following registry data is configured on the Outlook client:

  **Key:** HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\\\<application>\Resiliency

  **DWORD:** RestrictToList

  **Value:** 1

 > [!NOTE]
>
 > - If RestrictToList is set to 1, but you do not enable any add-ins using the List of managed add-ins policy, all COM add-ins are disabled.
 > - In the above registry key path, x.0 corresponds to version of Office (16.0 = Office 2016, 15.0 = Office 2013).
