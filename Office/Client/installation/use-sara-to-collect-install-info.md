---
title: Use Support and Recovery Assistant to collect data about Microsoft 365 Apps installations
description: Explains how the Microsoft Support and Recovery Assistant uses Robust Office Inventory Scan (ROIScan) to collect information about Microsoft 365 apps installations.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 144048
  - CI 147050
ms.author: luche
appliesto: 
  - Microsoft 365
  - Office 2016
  - Office 2013
  - Office 2010
ms.date: 06/28/2023
---

# Use Support and Recovery Assistant to collect data about Microsoft 365 Apps installations

## Summary

Microsoft Support and Recovery Assistant uses Robust Office Inventory Scan (ROIScan) to collect information about Microsoft 365 apps installations. Support and Recovery Assistant can help you collect information about the computer properties, installed product, product properties, install sources, licensing (OSPP), patch detection, and feature states.

For more information, see [About the Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f).

## System requirements

Support and Recovery Assistant can be run on the following operating systems:

- Windows 10
- Windows 8.1 and Windows 8
- Windows 7

The following Office versions can be scanned:

- Microsoft 365
- Microsoft Office 2016 (32-bit or 64-bit; Click-to-Run or MSI installations)
- Microsoft Office 2013 (32-bit or 64-bit; Click-to-Run or MSI installations)
- Microsoft Office 2010 (32-bit or 64-bit)

If you are running Windows 7 (any edition), you must have .NET Framework 4.5 installed. Windows 8 and later versions of Windows include at least .NET Framework 4.5.

> [!NOTE]
> By downloading this app, you agree to the terms of the [Microsoft Services Agreement and Privacy Statement](https://www.microsoft.com/servicesagreement).

## Installing Support and Recovery Assistant to automatically start ROIScan

To install Support and Recovery Assistant and automatically start collecting ROIScan data, select one of the following links:

[Advanced diagnostics – Normal ROIScan](https://aka.ms/sara-roiscannormal)
[Advanced diagnostics – Full ROIScan](https://aka.ms/sara-roiscanfull)

> [!NOTE]
> In addition to Normal ROIScan, Full ROIScan creates verbose .xml files for [MSI-based installations of Office products](/deployoffice/install-different-office-visio-and-project-versions-on-the-same-computer#installation-technologies-used-by-office). These are helpful in scenarios that require in-depth analysis of file versions and file states.

## Collect the Robust Office Inventory Scan

After Support and Recovery Assistant is successfully installed, collect the ROIScan data:

1. Select **Advanced diagnostics** > **Next**.

   :::image type="content" source="media/use-sara-to-collect-install-info/open-screen.png" alt-text="Screenshot of the Support and Recovery Assistant window with Advanced diagnostics selected.":::

1. Select **Office** > **Next**.

   :::image type="content" source="media/use-sara-to-collect-install-info/advanced-diagnostics.png" alt-text="Screenshot of the Support and Recovery Assistant window with Office selected.":::

1. Select **Normal Robust Office Inventory Scan** or **Full Robust Office Inventory Scan**.

   :::image type="content" source="media/use-sara-to-collect-install-info/select-diagnostic.png" alt-text="Screenshot to select whether to run the normal scan or the full scan.":::

1. When you are prompted to confirm that you are using the affected computer, select **Yes** > **Next**.

   :::image type="content" source="media/use-sara-to-collect-install-info/affected-machine.png" alt-text="Screenshot to confirm you're using the affected computer.":::

   After you select **Next**, you might be prompted for a Support and Recovery Assistant restart in order to validate the user or admin permissions.

   > [!NOTE]
   >
   > - The scan may take several minutes to run.
   > - You are notified when the scan is finished. You can view the output by selecting **Next**.
   > - The last page gives you the option to view the log, and send it directly to Microsoft if you have an active support request.

## Tips to analyze a ROIScan log

If you aren't currently working with Microsoft on a support request, and you want to review the ROIScan log yourself, review the following details:

Aside from the title line, the ROIScan log is grouped into three sections: Computer, Review Items, and Products Inventory.

### Computer

This section contains current user and operating system-specific data:

- Windows Installer Version
- Computer Name
- OS Details: OS Name, Service pack, Version, Codepage, Country/Region Code, Language as LCID, 64-bit or 32-bit
- Current User: Username, IsAdmin, SID.
- Logfile Name 
- ROI Script Build

**Note:** Data in this section is collected only. No additional analysis is done.

### Review items

This section includes three categories of review items to notify you about anything in the “Products Inventory” section that requires attention:

- Note
- Warning
- Error

### Products Inventory

This section contains data about each Office product that is installed on the computer where the ROIScan script is executed. For Click-To-Run installations, Products Inventory also lists shared properties, such as Shared Computer Licensing and SCLCacheOverride.
