---
title: Use SaRA to collect data about Microsoft 365 Apps installations
description: Explains how to use the Microsoft Support and Recovery Assistant (SaRA) uses Robust Office Inventory Scan (ROIScan) to collect information about Microsoft 365 Apps installations. 
author: mibrelea
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-matham
appliesto:
- Office 365
- Office 2016
- Office 2013
- Office 2010
---

# Use SaRA to collect data about Microsoft 365 Apps installations

## Overview

The Microsoft Support and Recovery Assistant (SaRA) uses Robust Office Inventory Scan (ROIScan) to collect information about Microsoft 365 Apps installations. SaRA can help you collect information about the computer properties, installed product, product properties, install sources, licensing (OSPP), patch detection, or feature states.

For more information about SaRA, see [About the Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f).

## System requirements

SaRA can be run on the following operating systems:
- Microsoft Windows 10
- Microsoft Windows 8 and Windows 8.1
- Microsoft Windows 7

The following Office versions can be scanned:
- Microsoft Office 365 (2016 or 2013, 32-bit or 64-bit)
- Microsoft Office 2016 (32-bit or 64-bit; Click-to-Run or MSI installations)
- Microsoft Office 2013 (32-bit or 64-bit; Click-to-Run or MSI installations)
- Microsoft Office 2010 (32-bit or 64-bit)

If you are running Windows 7 (any edition), you must have .NET Framework 4.5 installed. Windows 8 and later versions of Windows include at least .NET Framework 4.5.

> [!Note]
> By downloading this app, you agree to the terms of the [Microsoft Services Agreement and Privacy Statement](https://www.microsoft.com/servicesagreement).

## Installing SaRA to automatically start ROIScan

To install SaRA and automatically start collecting ROIScan data, select one of the following links:

[Advanced diagnostics – Normal ROIScan](http://aka.ms/sara-roiscannormal)
[Advanced diagnostics – Full ROIScan](http://aka.ms/sara-roiscanfull)

> [!Note]
> In addition to Normal ROIScan, Full ROIScan creates verbose .xml files for [MSI based installations of Office products[(https://docs.microsoft.com/deployoffice/install-different-office-visio-and-project-versions-on-the-same-computer#installation-technologies-used-by-office), which are helpful in scenarios that require in-depth analysis of file versions and file states.

## Collect the Robust Office Inventory Scan from SaRA

When you have SaRA installed, collect the ROIScan data:

1. Select **Advanced diagnostics**, and then **Next**.
 
1. Select **Office**, and then **Next**.
 
1. Select **Normal Robust Office Inventory Scan** or **Full Robust Office Inventory Scan**: 
 
1. When you're prompted to confirm that you are using the affected machine, select **Yes**, and then **Next**.
 
   After selecting **Next**, you might be prompted for a SaRA restart in order to validate the user/admin permissions.

   > [!Note]
   >The scan may take several minutes to run.

1.	You will be notified when the scan is complete and can view the output by selecting **Next**.
 
1.	The last page gives you the option to view the log, and send it directly to Microsoft if you have an active support request.


## Tips to analyze a ROIScan log

If you are not currently working with Microsoft on a support request and would like to review the ROIScan log yourself, review the following details:

Besides the title line, the ROIScan log is grouped into three sections: **Computer**, **Review Items**, and **Products Inventory**.

### Computer
- This section contains current user and operating system-specific data:
   - Windows Installer Version
   - Computer Name
   - OS Details: OS Name, Service pack, Version, Codepage, Country Code, Language as LCID, 64-bit or 32-bit
   - Current User: Username, IsAdmin, SID.
   - Logfile Name 
   - ROI Script Build
- Data in this section is collected only, with no additional analyses done.

### Review items
- This section includes three categories of review items to make you aware if something in the “Products Inventory” requires attention:
   - Note
   - Warning
   - Error

### Products Inventory
- This section contains data about each Office product installed on the machine where the ROIScan script is executed.
- For Click-To-Run installations “Products Inventory” also lists shared properties such as Shared Computer Licensing and SCLCacheOverride.