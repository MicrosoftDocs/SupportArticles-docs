---
title: How to scan Outlook calendar by using Microsoft Support and Recovery Assistant
description: Describes how to use Microsoft Support and Recovery Assistant to scan Outlook calendar for known issues and create a detailed report. 
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
- CI 158167
ms.reviewer: meerak; zebamehdi
appliesto:
- Outlook 2016
- Outlook 2019
search.appverid: MET150
---

# How to scan Outlook calendar using Microsoft Support and Recovery Assistant

## Overview

The [Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f) (SaRA) includes an advanced diagnostic that uses the [Calendar Checking Tool for Outlook](https://support.microsoft.com/topic/information-about-the-calendar-checking-tool-for-outlook-calcheck-0d2ccac8-f8dd-9289-82cc-943650e36a76) (CalCheck) to identify, and report known issues and details about items in your Microsoft Outlook calendar.

## Use CalCheck to scan a calendar for known issues

SaRA can resolve issues in many programs. To scan Outlook calendar for known issues and create a detailed report of your Outlook configuration, use one of the following methods to run a calendar scan automatically or manually:

### Automatically start a calendar scan in SaRA

To start a calendar scan automatically, follow these steps:

1. In Microsoft Edge, download the [Microsoft Support and Recovery Assistant](https://aka.ms/sara-calcheck).

    **Note**: By downloading this app, you agree to the terms of the [Microsoft Services Agreement and Privacy Statement](https://www.microsoft.com/servicesagreement).

1. Select the **Open file** link under the file name.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/open-file.png" alt-text="Screenshot of the download file., select the open file link.":::
1. If you don't have SaRA installed, select **Install** in the pop-up window that displays the security warning. Then, select **I agree** to agree to the terms of the Microsoft Services Agreement and Privacy Statement.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/security-warning.png" alt-text="Screenshot of the application install-security warning.":::
1. Once the download is completed, a calendar scan will start.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/calendar-scan.png" alt-text="Screenshot of starting the calendar scan.":::
1. The scan is completed when you see **We're done collecting your Outlook configuration details**.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/scan-completed.png" alt-text="Screenshot of the completed scan.":::

### Manually start a calendar scan in SaRA

If you have installed SaRA, follow these steps to start a calendar scan manually:

1. Select the **Start** button, type *Microsoft Support and Recovery Assistant*, and then press Enter.

1. Select **Advanced diagnostics** > **Next**.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/advanced-diagnostics.png" alt-text="Screenshot of the Microsoft Support and Recovery Assistant, select Advanced diagnostics.":::
1. Select **Outlook** > **Next**.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/outlook-advanced-diagnostics.png" alt-text="Screenshot of selecting outlook advanced diagnostics.":::
1. Select the Outlook calendar diagnostic: **Create a detailed scan of my Outlook Calendar to identify and resolve issues**, and then select **Next** to start the scan.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/select-diagnostic-you-like-to-run.png" alt-text="Screenshot of creating a scan of calendar.":::
1. When you are prompted to confirm that you are using the affected machine, select **Yes** > **Next**.

:::image type="content" source="media/scan-outlook-calendar-using-sara/affected-machine.png" alt-text="Screenshot of confirming the affected machine.":::
1. Scan will run automatically when you select **Next** on the previous screen.

1. The scan is completed when you see **We're done collecting your Outlook configuration details**.

## Review Outlook calendar scan report

You can review your Outlook calendar scan report from the following tabs:

- **Issues found** - This tab provides you a list of configuration issues that are detected during the scan.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/issues-found-tab.png" alt-text="Screenshot of issues found tab.":::
- **Detailed View** - This tab provides you with all the issues that were found categorized by the issue type.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/detailed-view-tab.png" alt-text="Screenshot of detailed view tab.":::
- **Configuration Summary** - This tab provides you a snapshot of the configuration settings that are most frequently collected and analyzed.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/configuration-summary-tab.png" alt-text="Screenshot of configuration summary tab.":::
