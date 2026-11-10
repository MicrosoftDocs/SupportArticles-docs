---
title: "AGDiag: Analyze Availability Group Health Events"
description: Use AGDiag to diagnose Always On availability group health events, collect logs from the replica that was primary at the event, and interpret reports.
ms.date: 11/09/2026
ms.custom: sap:Always On Availability Groups (AG)
ms.reviewer: v-shaywood, jopilov
ai-usage: ai-assisted
---
# Use AGDiag to diagnose availability group health events

## Summary

Use AGDiag to diagnose Windows Cluster and Always On availability group health events. AGDiag automates manual cluster log analysis, correlates events with SQL Server error logs and Windows event logs, and generates a summary report with detailed analysis for each detected health event. To automate much of the analysis, provide the appropriate logs from the replica that was primary at the time of the health event.

> [!NOTE]
> To diagnose Always On availability group health issues that trigger availability group failover, see [Troubleshoot failover of Always On Availability Groups](troubleshooting-availability-group-failover.md).

## Collect logs for AGDiag analysis

You can use various methods to generate the logs that AGDiag takes as inputs. AGDiag relies on the following base logs to do analysis:

- Windows Cluster Diagnostic logs
- SQL Server Error logs
- Windows System Event logs
- System Health Extended Events (XEL) files
- AlwaysOn Health Session XEL files

As an alternative method to manually collecting these logs, you can use the following log collection tool to capture them:

- SQL LogScout

### Use SQL LogScout to capture logs for AGDiag analysis

To diagnose an availability group health event, use SQL LogScout to collect logs on the SQL Server instance that was in the primary role at the time of the event:

1. Download the latest [SQL LogScout](https://aka.ms/get-sqllogscout) as a .zip file.
2. Save and extract the .zip file on the computer where SQL Server hosts the primary replica. This system is where the failover started or the availability group was resolving.
3. Open an elevated PowerShell window, and change the directory to the SQL LogScout folder where you extracted the .zip file.
4. Run the following command to capture the `Basic` scenario, and follow the prompts.

   ```powershell
   .\SQL_LogScout.ps1 -Scenario "Basic" -ServerName "<SqlInstanceName>"
   ```

   Replace `<SqlInstanceName>` with the name of your SQL Server instance.

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/launch-sql-log-scout-powershell.png" alt-text="Screenshot of SQL LogScout collecting Basic scenario logs in an elevated PowerShell window.":::
5. When the log capture process finishes, you can point AGDiag to the `\output` folder that was created inside the SQL LogScout folder. This folder contains the logs that SQL LogScout collected.

## Download the AGDiag tool

To download AGDiag, follow these steps:

1. Open [AGDiag Windows Release October 2024 (signed)](https://github.com/microsoft/agdiag/releases/tag/Win2.0.0.23).
2. Select the **agdiag.zip** link to download the tool.

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-zip-download.png" alt-text="Screenshot of the AGDiag release page with agdiag.zip highlighted in Assets and the browser Downloads pane." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-zip-download.png":::

## Start AGDiag and select the log folder

After you download the tool, follow these steps to launch AGDiag and give it the unzipped logs:

1. Extract the ZIP file, and open **agdiag.exe** to start AGDiag.

   A dialog box that resembles the following box appears.

   :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-select-log-folder.png" alt-text="Screenshot of AGDiag with the Select Log Folder control and Browse For Folder dialog.":::
2. Select **Select Log Folder**, go into the folder that stores the collected SQL LogScout files, and then select **OK**.

## Interpret the AGDiag report

The default system browser opens the AGDiag report. The following illustrations help you interpret the report:

- The following AGDiag splash screen describes AGDiag capabilities and version information.

  :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-splash-screen.png" alt-text="Screenshot of the AGDiag splash screen describing supported health event analysis and required logs." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-splash-screen.png":::
- AGDiag reports on the logs that it analyzes in the initialize section. To see more detailed information, select the triangles (highlighted in red boxes in the following image).

  :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-report.png" alt-text="Screenshot of AGDiag log initialization with expandable file lists and SQL Server error log events." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-report.png":::
- The summary report lists the availability group health events from the cluster log. To jump to a specific health event's detailed report, select the numerical link (highlighted in red box in the following image).

  :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/availability-group-health-event-summary-report.png" alt-text="Screenshot of the AGDiag health event summary with event links, local server times, and event types." lightbox="media/use-agdiag-diagnose-availability-group-health-events/availability-group-health-event-summary-report.png":::
- A detailed report exists for each health event that's detected. This report includes log findings that correlate to the health event, diagnosis, and recommendations. To see more detailed information, select the triangles (highlighted in red boxes in the following image).

  :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/alwayson-health-event.png" alt-text="Screenshot of an AGDiag SQL Server Health Check Timeout report with correlated logs and recommendations." lightbox="media/use-agdiag-diagnose-availability-group-health-events/alwayson-health-event.png":::

## Known issues in AGDiag

For the latest information about documented issues and possible solutions, see [Known Issues with AGDiag](https://github.com/microsoft/agdiag/wiki/Known-Issues-with-AGDiag).
