---
title: Scan Outlook by using Microsoft Support and Recovery Assistant
description: Detect and resolve known Outlook issues and create a detailed Outlook configuration report by using Microsoft Support and Recovery Assistant (SaRA).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae; gregmans
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Scan Outlook by using Microsoft Support and Recovery Assistant

_Original KB number:_ &nbsp; 4098558

## Overview

Microsoft Support and Recovery Assistant use advanced diagnostics to report known problems and details about your Microsoft Outlook configuration. Reported problems are linked to public-facing documentation (usually a Microsoft Knowledge Base article) for possible fixes. If you're a Support professional, you can review customer reports that are generated in HTML format.

The scenario in the Assistant that is described in this article replaces the Outlook scanning functionality that was originally provided by the Office Configuration Analyzer Tool (OffCAT).

For more information about the Assistant, see [About the Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f).

## System requirements

The following operating systems are supported:

- Windows 10
- Windows 8 and Windows 8.1
- Windows 7

The Outlook program in any of the following Office versions can be scanned:

- Microsoft 365
- Microsoft Office 2016 (32-bit or 64-bit; Click-to-Run or MSI installations)
- Microsoft Office 2013 (32-bit or 64-bit; Click-to-Run or MSI installations)
- Microsoft Office 2010 (32-bit or 64-bit)

If you're running Windows 7 (any edition), you must also have .NET Framework 4.5 installed. Windows 8 and later versions of Windows already include at least .NET Framework 4.5.

## Install Microsoft Support and Recovery Assistant

To install the Assistant and automatically start the scenario for scanning Outlook, select the following link:

[Advanced diagnostics-Outlook](https://aka.ms/SaRA-OutlookAdvDiagnostics)

> [!NOTE]
> By downloading this app, you agree to the terms of the [Microsoft Services Agreement and Privacy Statement](https://www.microsoft.com/servicesagreement).

## Scan an Outlook configuration for known issues

The Assistant can resolve issues in many programs. To scan Outlook for known issues and create a detailed report of your Outlook configuration, follow these steps:

1. Select **Advanced diagnostics**, and then select **Next**.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/advanced-diagnostics.png" alt-text="Select the Advanced diagnostics option." border="false":::

2. Select **Outlook**, and then select **Next**.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/select-to-run-outlook.png" alt-text="Select Outlook item." border="false":::

3. When you are prompted to confirm that you are using the affected machine, select **Yes**, and then select **Next**.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/confirm-affected-machine.png" alt-text="Confirm that you are using the affected machine." border="false":::

4. After your account is validated in Microsoft 365, the scan automatically begins.

   > [!NOTE]
   > The scan may take several minutes to run.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/scan-begins.png" alt-text="Scan automatically begins." border="false":::

    You see the following error message if your account is in Microsoft 365 and the Assistant can't validate your credentials.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/error-message.png" alt-text="Error message details." border="false":::

   If you select **Back** to reenter your credentials, and you see this same error, select **Back** again, and then use the following sample credentials to mimic a non-Microsoft 365 account:

   - **Email address**: `juliet@contoso.com`
   - **Password**: \<any password that you want to use>

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/sign-in-using-non-office-account.png" alt-text="Sign in account example." border="false":::

   No non-Microsoft 365 account will be authenticated through the Microsoft 365 service. In this case, the Assistant provides the **Next** button to continue.

   The scan is complete when you see **We're done collecting your Outlook configuration details**.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/scan-complete.png" alt-text="The scan is complete." border="false":::

## Review your Outlook scan

Your scan report includes these separate tabs:

- Issues found
- Detailed View
- Configuration Summary

### Issues found

On the **Issues found** tab, you'll see a list of configuration issues that are detected during the scan.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/issues-found-tab.png" alt-text="List of configuration issues." border="false":::

Select an issue to expand it for a more detailed description. There's also a link to an article that contains steps to resolve the issue.

### Detailed view

The information on the **Detailed View** tab is intended for advanced users, Support personnel, and IT administrators. This tab contains configuration information for diagnosing an Outlook issue in the client. The information includes the following items:

- User name
- Computer hardware
- Windows version
- Office installation
- Outlook profile
- Registry and policies information
- Event logs

The information is provided in a tree view. Select any node to expand or collapse it.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/detailed-view-tab.png" alt-text="Information under the Detailed view tab." border="false":::

When running this scenario, the Assistant also collects important configuration information for Microsoft Excel, Microsoft PowerPoint, and Microsoft Word. To see this information, expand the **Miscellaneous** section in the tree view.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/microsoft-excel-details-node.png" alt-text="Tree view of Excel details" border="false":::

### Configuration Summary

The information in the **Configuration Summary** tab is a snapshot of the configuration settings that are most frequently collected and analyzed.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/configuration-summary-tab.png" alt-text="Information under the Configuration Summary tab." border="false":::

### Viewing scan results in a browser

To increase the viewing area for the scan results, select **View results in my browser**. This view displays the whole scan report, including all three tabs, in your default browser.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/whole-scan-report.png" alt-text="Whole scan report and the three tabs." border="false":::

**Note**: The **Detailed View** in your browser contains a search feature that isn't found when you view this information in the Assistant.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/search-feature-in-detailed-view.png" alt-text="Search feature in Detailed View tab." border="false":::

### Sharing your scan results

After you review your scan results, select **Next**. On this screen, select **See all logs** to see the log files that were saved to your computer or **View log** to view the log again.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/sara-outlook-diag-logs-screen.png" alt-text="Screenshot of the Outlook diagnostic logs" border="false":::

**Note**:  The scan file is ConfigurationDetails_{CorrelationId}.html. It's located in the ***%localappdata%\saralogs\UploadLogs*** folder, for example, *C:\users\\\<username>\AppData\Local\saralogs\UploadLogs*.

If you need to share your log files with a Support professional, select **See all logs** to open the folder that contains all the logs that are created by the Assistant. Then copy the files and share them.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/example-of-selecting-see-all-logs.png" alt-text="Example of See all logs." border="false":::
