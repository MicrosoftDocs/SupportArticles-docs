---
title: Use AGDiag to diagnose availability group health events
description: This article describes how to use AGDiag to diagnose availability group health events.
ms.date: 05/15/2023
ms.custom: sap:Always On Availability Groups (AG)
ms.reviewer: cmathews, v-sidong, v-shaywood
---
# Use AGDiag to diagnose availability group health events

> [!NOTE]
> To diagnose Always On availability group health issues that trigger availability group failover, see [Troubleshoot Always On Availability Groups failover](troubleshooting-availability-group-failover.md).

AGDiag is an application that automates the manual analysis described in the article (mentioned in the **Note** section). It analyzes the cluster log and correlates and reports pertinent events from the other logs (SQL Server error logs, Windows event logs, and so on). It generates a summary report of Windows Cluster and Always On health events and then provides more detailed analysis results for each health event detected. It automates much of the work described in the article (mentioned in the **Note** section) when you provide the proper logs from the availability group primary replica at the time of the health event.

## Generate logs for AGDiag to diagnose

You can use multiple methods to generate the logs that AGDiag takes as inputs. AGDiag relies on the following base logs to do analysis:

- Windows Cluster Diagnostic Logs
- SQL Server Error Logs
- Windows System Event Logs
- System Health Extended Events (XEL) files
- AlwaysOn Health Session XEL files

Besides manually collecting these logs, you can use either of the following log collection tools to capture them:

- LogScout
- TSS

### Use SQL LogScout to capture logs for AGDiag analysis

To diagnose an availability group health event, use SQL LogScout to collect logs on the SQL Server instance that was in the primary role at the time of the event:

1. Download the latest [SQL LogScout](https://aka.ms/get-sqllogscout) as zip file.
1. Save and extract the zip file on the machine where SQL Server hosts the primary replica. This system is where the failover started or the availability group was resolving.
1. Open an elevated PowerShell command (Run as Administrator), change the directory to the SQL LogScout folder where you extracted the zip file.
1. Run the following command to capture the `Basic` scenario and follow the prompts.

   ```PowerShell
   .\SQL_LogScout.ps1 -Scenario "Basic" -ServerName "<Your_Sql_Instance_Name>"
   ```

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/launch-sql-logscout-powershell.png" alt-text="Screenshot of starting SQL LogScout from an elevated PowerShell command window":::

1. When the log capture process completes, you can point AGDiag to the `\output` folder created inside the SQL LogScout folder. This folder contains the logs collected by SQL LogScout.

### Use TSS to generate logs for AGDiag to diagnose

Alternatively, you can capture the logs by using TSS on the SQL Server instance that was in the primary role at the time of the event:

1. Download the toolset ([TSSv2.zip](https://aka.ms/getTSS)) as a zip file. For more information, see [Introduction to TroubleShootingScript toolset (TSSv2)](../../../windows-client/windows-troubleshooters/introduction-to-troubleshootingscript-toolset-tssv2.md).

1. Save and extract the zip file to a folder on the SQL Server instance that hosted the availability group primary replica when the failover started or the availability group was resolving.

1. Open an elevated command prompt, change the directory to the TSS folder where you saved and extracted the *TSSv2.zip* file, run `TSS SDP:SQLBase`, and respond to the prompts.

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/command-prompt-tss.png" alt-text="Screenshot of the elevated command prompt changing the directory to the TSS folder." lightbox="media/use-agdiag-diagnose-availability-group-health-events/command-prompt-tss.png":::

1. When TSS creates the SQLBase cab file, extract the cab file into a folder.

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/extract-tss-sqlbase-cab.png" alt-text="Screenshot of extracting the SQLBase cab file to a folder." lightbox="media/use-agdiag-diagnose-availability-group-health-events/extract-tss-sqlbase-cab.png":::

## Download the AGDiag tool

To download AGDiag, follow these steps:

1. Open [Release AGDiag Windows Release October 2021 (signed)](https://github.com/microsoft/agdiag/releases/tag/Win2.0.0.23).
1. Select the *agdiag.zip* link to download the tool.

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-zip-download.png" alt-text="Screenshot of selecting the agdiag.zip link to download the tool." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-zip-download.png":::

## Launch AGDiag and feed it the unzipped TSS logs

After you download the tool, follow these steps to launch AGDiag and feed it the unzipped TSS logs:

1. Extract the zip and double-click *agdiag.exe* to launch AGDiag.

   A dialog appears like the following one:
  
   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-select-log-folder.png" alt-text="Screenshot of running the AGDiag tool." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-select-log-folder.png":::

1. Select **Select Log Folder**, drill into the folder you extracted the TSS SQL Base CAB files into, and then select **OK**.

## Interpret the AGDiag report

The default system browser launches the AGDiag report. The following illustrations help you interpret the report.

- The following AGDiag Splash Screen describes AGDiag capabilities and version information:

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-splash-screen.png" alt-text="Screenshot of the AGDiag Splash Screen." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-splash-screen.png":::

- AGDiag reports on the logs it analyzes in the initialize section. To see more detailed information, select the triangles (highlighted in red boxes in the following image).

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-report.png" alt-text="Screenshot of the AGDiag reports on the logs." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-report.png":::

- The summary report lists the availability group health events from the cluster log. To jump to a specific health event's detailed report, select the numerical link, highlighted in red box in the following image.

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/availability-group-health-event-summary-report.png" alt-text="Screenshot of availability group health events." lightbox="media/use-agdiag-diagnose-availability-group-health-events/availability-group-health-event-summary-report.png":::

- There's a detailed report for each health event detected, which includes log findings that correlate to the health event, diagnosis, and recommendations. To see more detailed information, select the triangles, highlighted in red boxes in the following image.

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/alwayson-health-event.png" alt-text="Screenshot of AlwaysOn health events." lightbox="media/use-agdiag-diagnose-availability-group-health-events/alwayson-health-event.png":::

## Known issues with AGDiag

For the latest information on documented issues and possible solutions, see [Known Issues with AGDiag](https://github.com/microsoft/agdiag/wiki/Known-Issues-with-AGDiag).
