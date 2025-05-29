---
title: Collect endpoint DLP diagnostic logs
description: Discusses how to use the MDE Client Analyzer tool to collect endpoint DLP diagnostic logs.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:EndPoint DLP
  - Microsoft Purview
  - CSSTroubleshoot
  - CI 929
ms.reviewer: managrawal, sathyana, meerak, v-shorestris
appliesto:
  - Microsoft Purview
search.appverid: MET150
ms.date: 05/05/2025
---

# Collect endpoint DLP diagnostic logs

If you open a Microsoft Support case for an [endpoint data loss prevention](/purview/endpoint-dlp-learn-about) (DLP) issue, you might be asked to provide diagnostic logs. You can use the Microsoft Defender for Endpoint (MDE) Client Analyzer tool to simplify, standardize, and streamline data collection.

This article offers step-by-step instructions for using the MDE Client Analyzer tool to collect diagnostic logs for your endpoint DLP setup on a Microsoft Windows device.

To analyze the diagnostic results so that you can independently troubleshoot endpoint DLP issues, see [Analyze endpoint DLP diagnostic logs](analyze-endpoint-dlp-diagnostic-logs.md).

> [!TIP]
> For additional resources to troubleshoot endpoint DLP issues, see [Troubleshoot and manage DLP for endpoint devices](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/troubleshoot-and-manage-microsoft-purview-data-loss-prevention/ba-p/4077992).

## Collect diagnostic logs

Follow these steps on a Windows 10 or Windows 11 device:

1. [Download the MDE Client Analyzer tool](/defender-endpoint/download-client-analyzer).

2. Extract the content of the downloaded **MDEClientAnalyzer.zip** file to any folder.

3. In an elevated command prompt window, navigate to the root folder that contains the extracted content.

4. At the command prompt, run the following command to start the MDE Client Analyzer tool:

   ```Cmd
   MDEClientAnalyzer.cmd -t
   ```

   The `-t` switch enables client-side DLP logging (tracing).

   > [!NOTE]
   > Don't run the PowerShell script file that's named **MDEClientAnalyzer.ps1**.

5. Wait for the tool to generate the following output in the terminal:

   > Starting Microsoft Defender for Endpoint analyzer process  
   > …  
   > DLP quick diagnosis complete  
   > Do you want to allow MDEClientAnalyzer to collect screen-captures while traces are running?  
   > If yes, make sure you close any windows not related to the issue you are recording such as Outlook or Teams  
   > Type 'Y' and press ENTER to allow Problem Steps Recorder to capture screenshots. Use any other key or ENTER to disable PSR.:

6. If you want the tool to capture screenshots, type '**Y**', and then press **Enter**. Otherwise, just press **Enter**.

7. Wait for the tool to generate the following output in the terminal:

   > Capturing screenshots <enabled/disabled> by user request  
   > Stopping any running WPR trace profiles  
   > Enter the number of minutes to collect traces:

8. Enter the maximum number of minutes for diagnostic data collection, and then press **Enter**.

   > [!NOTE]
   > Regardless of the minutes value that you enter, you can manually stop data collection at any time.

9. Wait for the tool to display a blue banner as shown in the following screenshot. The banner displays the message, "Collecting traces, run your scenario now and press 'q' to stop data collection at any time."

   :::image type="content" source="media/collect-endpoint-dlp-diagnostic-logs/collecting-traces-banner.png" border="true" alt-text="Screenshot of the blue banner that appears in the console to indicate that data collection started." lightbox="media/collect-endpoint-dlp-diagnostic-logs/collecting-traces-banner-lrg.png":::

10. Reproduce the endpoint DLP issue that you want to diagnose. For example, if the issue is that users can copy a protected document to a USB removable device, reproduce the issue by copying a protected document to a USB removable device. Make sure that you perform all necessary actions to reproduce the issue.

11. Press '**q**' to stop data collection, and then wait for the tool to generate the following output in the terminal:

    > WARNING: The trace collection action was ended by user exit command  
    > Stopping and merging Defender Antivirus traces if running  
    > Please enter the full path to the document that was used during log collection…

12. Enter the full path of the protected document surrounded by quotation marks, then press **Enter**.

    > [!NOTE]
    > To get the full path surrounded by quotation marks, right-click the file in File Explorer, and then select **Copy as path**.

13. Wait for the tool to generate the following output in the terminal:

    > Succeeded to CollectLog at: \<root path\>\MDEClientAnalyzer\MDEClientAnalyzerResult\MDM\MDMLogs.zip  
    > Generating HealthCheck report…  
    > Compressing results directory…  
    > Result is available at: MDEClientAnalyzerResult_\<ID\>.zip  
    > Client analysis results opened in browser

    The tool opens a webpage in your default browser that's titled **MDE Client Analyzer Results**.

14. Find the **MDEClientAnalyzerResult_\<ID\>.zip** file in the **MDEClientAnalyzer** folder, and then extract the file to view the diagnostic logs.
