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

# Scan Outlook calendar using Microsoft Support and Recovery Assistant

When you run into issues with Microsoft Outlook calendars such as meetings that are missing, shared calendars that can't be accessed and others, you can use [Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f) (SaRA) to run the Outlook Calendar diagnostic to troubleshoot and fix the issues. This advanced diagnostic closely mimics the scan logic that was introduced in the [Calendar Checking Tool for Outlook](https://support.microsoft.com/topic/information-about-the-calendar-checking-tool-for-outlook-calcheck-0d2ccac8-f8dd-9289-82cc-943650e36a76) (CalCheck) to identify and report issues with general settings such as permissions, free/busy publishing, delegate configuration, and automatic booking. It also alerts you to known issues with the Outlook calendar folder and calendar items.

To scan an Outlook calendar that is having issues, you can either download the diagnostic to the computer or select it from the list of diagnostics within Microsoft Support and Recovery Assistant. Select the option that works best for you.

## Download the Outlook Calendar diagnostic

1. On the machine that's running the Outlook version with calendar issues, open a browser tab and navigate to  [Advanced Diagnostics - Outlook Calendar](https://aka.ms/sara-calcheck).

1. After the download completes, open the downloaded file *SetupProd_CalCheck.exe*.

1. If you don't have Microsoft Support and Recovery Assistant installed on the machine, you'll be presented with the option to install it. Select **Install** in the dialog that displays and then select **I agree** to agree to the terms of the [Microsoft Services Agreement and Privacy Statement](https://www.microsoft.com/servicesagreement).

    After Microsoft Support and Recovery Assistant is installed, the calendar scan will begin automatically. The scan is complete when you see **We're done collecting your Outlook configuration details**.

## Launch the Outlook Calendar diagnostic from SaRA

1. On the machine that's running the Outlook version with calendar issues, launch Microsoft Support and Recovery Assistant.

1. Select **Advanced diagnostics** > **Next**.

1. Select **Outlook** > **Next**.

1. Select **Create a detailed scan of my Outlook Calendar to identify and resolve issues** > **Next**.

1. When prompted to confirm that you're using the affected machine, select  **Yes** > **Next**.

    The scan will begin and is complete when you see **We're done collecting your Outlook configuration details**.

## Review Outlook calendar scan report

The Outlook calendar scan report includes the following tabs:

- **Issues found** - Lists the configuration issues detected during the scan.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/issues-found-tab.png" alt-text="Screenshot of issues found tab." border="false":::
- **Detailed View** - Lists the issues found categorized by the issue type.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/detailed-view-tab.png" alt-text="Screenshot of detailed view tab." border="false":::
- **Configuration Summary** - Lists the configuration settings that were analyzed during the scan to identify issues.

## Access Outlook calendar scan report

Microsoft Support and Recovery Assistant saves the following files related to a calendar scan in the *\user\appdata\local\saralogs\uploadlogs* folder on the machine where the scan was run.

:::image type="content" source="media/scan-outlook-calendar-using-sara/access-calendar-scan-report.png" alt-text="Screenshot of calendar scan report.":::
