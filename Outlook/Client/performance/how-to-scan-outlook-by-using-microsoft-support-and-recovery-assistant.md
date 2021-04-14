---
title: Scan by using Microsoft Support and Recovery Assistant
description: Detect and resolve known Outlook issues and create a detailed Outlook configuration report by using the Microsoft Support and Recovery Assistant (SaRA).
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: tasitae
appliesto:
- Outlook 2016
- Outlook 2013
- Outlook 2010
- Outlook for Office 365
search.appverid: MET150
---
# How to scan Outlook by using the Microsoft Support and Recovery Assistant

_Original KB number:_ &nbsp; 4098558

## Overview

The Microsoft Support and Recovery Assistant (SaRA) uses advanced diagnostics to report known problems and details about your Microsoft Outlook configuration. Reported problems are linked to public-facing documentation (usually a Microsoft Knowledge Base article) for possible fixes. If you're a Helpdesk professional, you can review customer reports that are generated in HTML format.

The SaRA scenario that is described in this article replaces the Outlook scanning functionality that was originally provided by the Office Configuration Analyzer Tool (OffCAT).

For more information about SaRA, see [About the Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f).

## System requirements

The following operating systems are supported:

- Windows 10
- Windows 8 and Windows 8.1
- Windows 7

The Outlook program in any of the following Office versions can be scanned:

- Microsoft Office 365 (2016 or 2013, 32-bit or 64-bit)
- Microsoft Office 2016 (32-bit or 64-bit; Click-to-Run or MSI installations)
- Microsoft Office 2013 (32-bit or 64-bit; Click-to-Run or MSI installations)
- Microsoft Office 2010 (32-bit or 64-bit)

If you are running Windows 7 (any edition), you must also have .NET Framework 4.5 installed. Windows 8 and later versions of Windows include at least .NET Framework 4.5.

## Installing SaRA

To install SaRA and automatically start the scenario for scanning Outlook, select the following link:

[Advanced diagnostics-Outlook](https://aka.ms/SaRA-OutlookAdvDiagnostics)

> [!NOTE]
> By downloading this app, you agree to the terms of the [Microsoft Services Agreement and Privacy Statement](https://www.microsoft.com/servicesagreement).

## How to scan an Outlook configuration for known issues

The Microsoft Support and Recovery Assistant can resolve issues in many programs. To scan Outlook for known issues and create a detailed report of your Outlook configuration, follow these steps:

1. Select **Advanced diagnostics**, and then select **Next**.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/advanced-diagnostics.png" alt-text="select the Advanced diagnostics" border="false":::

2. Select **Outlook**, and then select **Next**.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/select-to-run-outlook.png" alt-text="select Outlook" border="false":::

3. When you are prompted to confirm that you are using the affected machine, select **Yes**, and then select **Next**.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/confirm-affected-machine.png" alt-text="confirm that you are using the affected machine" border="false":::

4. After your account is validated in Office 365, the scan automatically begins.

   > [!NOTE]
   > The scan may take several minutes to run.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/scan-begins.png" alt-text="scan automatically begins" border="false":::

    You see the following error message if your account is in Office 365 and SaRA cannot validate your credentials.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/error-message.png" alt-text="error-message details" border="false":::

   If you select **Back** to reenter your credentials, and you see this same error, select **Back** again, and then use the following sample credentials to mimic a non-Office 365 account:

   - **Email address**: `juliet@contoso.com`
   - **Password**: \<any password that you want to use>

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/sign-in-using-non-office-account.png" alt-text="sign in account example" border="false":::

   Any non-Office 365 account will not be authenticated through the Office 365 service. In this case, SaRA gives you an option to continue. Select the **Next** button to continue.

   The scan is complete when you see **We're done collecting your Outlook configuration details**.

   :::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/scan-complete.png" alt-text="The scan is complete" border="false":::

## Review your Outlook scan

Your scan report includes these separate tabs:

- Issues found
- Detailed View
- Configuration Summary

### Issues found

On the **Issues found** tab, you are provided a list of configuration issues that are detected during the scan.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/issues-found-tab.png" alt-text="a list of configuration issues" border="false":::

Select an issue to expand it for a more detailed description. There is also a link to an article that contains steps for resolving the issue.

### Detailed view

The information on the **Detailed View** tab is intended for advanced users, Helpdesk personnel, and IT administrators. This tab contains configuration information for diagnosing an Outlook issue from the client-side. This includes the following items:

- User name
- Computer hardware
- Windows version
- Office installation
- Outlook profile
- Registry and policies information
- Event logs

The information is provided in a tree view. Select any node to expand or collapse it.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/detailed-view-tab.png" alt-text="Detailed view" border="false":::

This scenario also collects important configuration information for Microsoft Excel, Microsoft PowerPoint, and Microsoft Word. To see this information, expand the **Miscellaneous** section in the tree view.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/microsoft-excel-details-node.png" alt-text="tree view of Excel details" border="false":::

### Configuration Summary

The information on the **Configuration Summary** tab is a snapshot of the configuration settings that are most frequently collected and analyzed.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/configuration-summary-tab.png" alt-text="Configuration Summary tab" border="false":::

### Viewing scan results in a browser

To increase the viewing area for the scan results, select **View results in my browser**. This view displays the whole scan report, including all three tabs, in your default browser.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/whole-scan-report.png" alt-text="whole scan report" border="false":::

> [!NOTE]
> The **Detailed View** in your browser contains a search feature that is not found when you view this information in the SaRA window.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/search-feature-in-detailed-view.png" alt-text="a search feature in Detailed View" border="false":::

### Sharing your scan results

After you review your scan results, select **Next**. The next screen provides an opportunity to see the log files that were saved on your computer (**See all logs**) or to view the log again (**View log**).

#### Users who have an Office 365 account

If you sign in to SaRA by using an account in Office 365, you also see an option to send your files to Microsoft. This option is helpful if you are working with a Microsoft support engineer. Select **Send** to have your log files securely uploaded.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/upload-files.png" alt-text="Select Send to have your log files securely uploaded" border="false":::

Select **Don't send** if you don't want to upload your log files. If you have to share your log files with someone, select **See all logs** to open the folder that contains all the logs that are created by SaRA.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/see-all-logs.png" alt-text="Select to see all logs" border="false":::

> [!NOTE]
> If you select **Send**, only the .json file is uploaded to Microsoft.

#### Users who do not have an Office 365 account

If you sign in to SaRA by using an account that is not in Office 365, there is no option to send your files to Microsoft.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/no-option-to-send.png" alt-text="there is no option to send your files to Microsoft" border="false":::

For example, if you have to share your log files with your Helpdesk, select **See all logs** to open the folder that contains all the logs that are created by SaRA.

:::image type="content" source="media/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant/eample-of-selecting-see-all-logs.png" alt-text="example of See all logs" border="false":::

You can copy the file from this folder to share with the person who is helping you to fix your Outlook issue.
