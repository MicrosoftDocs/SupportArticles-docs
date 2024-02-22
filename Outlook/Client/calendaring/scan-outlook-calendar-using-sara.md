---
title: Run CalCheck from Microsoft Support and Recovery Assistant to scan Outlook calendar
description: Use the Outlook Calendar diagnostic to scan the Outlook calendar for issues.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 158167
ms.reviewer: meerak, zebamehdi, v-chazhang
appliesto: 
  - Outlook 2016
  - Outlook 2019
search.appverid: MET150
ms.date: 10/30/2023
---

# Scan Outlook calendar by using Microsoft Support and Recovery Assistant

You can use [Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f) to run the Outlook Calendar diagnostic to troubleshoot and fix such issues as missing meeting entries and shared calendars that can't be accessed by other users. This advanced diagnostic closely mimics the scan logic that was introduced in the [Calendar Checking Tool for Outlook](https://support.microsoft.com/topic/information-about-the-calendar-checking-tool-for-outlook-calcheck-0d2ccac8-f8dd-9289-82cc-943650e36a76) (CalCheck) to identify and report issues that involve general settings such as permissions, free/busy publishing, delegate configuration, and automatic booking. The tool also alerts you to known issues that affect the Outlook calendar folder and calendar items.

To scan an Outlook calendar that's experiencing issues, you can either download the diagnostic to the computer or select it from the list of diagnostics within Microsoft Support and Recovery Assistant. Select the option that works best for you.

## Download the Outlook Calendar diagnostic

1. On the computer that's running the Outlook version that's experiencing the calendar issues, open a web browser tab, and navigate to [Advanced Diagnostics - Outlook Calendar](https://aka.ms/sara-calcheck) to access the download file.

1. Run the downloaded file, *SetupProd_CalCheck.exe*.

1. If you don't have Microsoft Support and Recovery Assistant already installed on the computer, select **Install** in the window that appears, and then select **I agree** to agree to the terms of the [Microsoft Services Agreement and Privacy Statement](https://www.microsoft.com/servicesagreement).

    **Note** After Microsoft Support and Recovery Assistant is installed, the calendar scan begins automatically. The scan is finished when you see **We're done collecting your Outlook configuration details**.

## Run the Outlook Calendar diagnostic from Microsoft Support and Recovery Assistant

1. On the computer that's running the Outlook version that's experiencing the calendar issues, start Microsoft Support and Recovery Assistant.

1. Select **Advanced diagnostics** > **Next**.

1. Select **Outlook** > **Next**.

1. Select **Create a detailed scan of my Outlook Calendar to identify and resolve issues** > **Next**.

1. When you're prompted to confirm that you're using the affected computer, select **Yes** > **Next**.

   **Note** The scan is finished when you see **We're done collecting your Outlook configuration details**.

## Review Outlook calendar scan report

The Outlook calendar scan report includes the following tabs:

- **Issues found**: Lists the configuration issues that were detected during the scan.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/issues-found-tab.png" alt-text="Screenshot of the tab for issues found." border="false":::
- **Detailed View** - Lists the issues that were found, categorized by the issue type.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/detailed-view-tab.png" alt-text="Screenshot of the tab for detailed view." border="false":::
- **Configuration Summary** - Lists the configuration settings that were analyzed during the scan to identify issues.

    :::image type="content" source="media/scan-outlook-calendar-using-sara/configuration-summary-tab.png" alt-text="Screenshot of the tab for configuration summary." border="false":::

## Access Outlook calendar scan report

Microsoft Support and Recovery Assistant saves the following files that are related to a calendar scan in the *\user\appdata\local\saralogs\uploadlogs* folder on the computer on which the scan was run.

:::image type="content" source="media/scan-outlook-calendar-using-sara/access-calendar-scan-report.png" alt-text="Screenshot of calendar scan report.":::
