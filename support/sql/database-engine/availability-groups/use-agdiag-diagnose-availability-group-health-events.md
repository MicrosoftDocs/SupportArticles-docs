---
title: Use AGDiag to diagnose availability group health events
description: This article describes how to use AGDiag to diagnose availability group health events.
ms.date: 04/28/2023
ms.custom: sap:Availability Groups
ms.prod: sql
author: sevend2
ms.author: v-sidong
ms.reviewer: cmathews
---
# Use AGDiag to diagnose availability group health events

To diagnose Always On availability group health issues that trigger availability group failover, see [Troubleshoot Always On Availability Groups failover](troubleshooting-availability-group-failover.md).

AGDiag is an application that automates the manual analysis in the above article. It analyzes the cluster log and correlates and reports pertinent events from the other logs (SQL Server error logs, Windows event logs, and so on). It generates a summary report of Windows Cluster and Always On health events and then provides more detailed analysis results for each health event detected. It automates much of the work described in the article above when the proper logs are provided from the availability group primary replica at the time of the health event.

## Use TSS to generate logs for AGDiag to analyze

To diagnose an availability group health event, use TSS to collect logs on the SQL Server instance that was in the primary role at the time of the event.

To create the TSS logs on the SQL Server instance, download [TSS](https://aka.ms/getTSS) to the availability group primary replica at the time of the health issue:

Select **Save As** to save the zipped binaries to a folder.

From elevated command line, change directory to TSS folder where files were saved/extracted and run 'TSS SDP:SQLBase' and respond to the prompts:

:::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/command-prompt-tss.png" alt-text="Screenshot of elevated command prompt changing directory to tss folder." lightbox="media/use-agdiag-diagnose-availability-group-health-events/command-prompt-tss.png":::

Once the TSS SQLBase cab file has been created, extract the cab into a folder.

:::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/extract-tss-sqlbase-cab.png" alt-text="Screenshot of extracting the SQLBase cab file to a folder." lightbox="media/use-agdiag-diagnose-availability-group-health-events/extract-tss-sqlbase-cab.png":::

## Download AGDiag tool

To download AGDiag, follow these steps:

1. Open [Release AGDiag Windows Release October 2021 (signed) · microsoft/agdiag · GitHub](https://github.com/microsoft/agdiag/releases/tag/Win2.0.0.23)
1. Select the **agdiag.zip** link to download the tool.

  :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-zip-download.png" alt-text="Screenshot of selecting the agdiag.zip link to download the tool." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-zip-download.png":::

## Launch AGDiag and feed it the unzipped TSS logs

Once the tool is downloaded, following these steps to launch AGDiag and feed it the unzipped TSS logs:

1. Extract the zip and double-click the *agdiag.exe* to launch AGDiag.

  A dialog appears like the following one:
  
  :::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-select-log-folder.png" alt-text="Screenshot of running the AGDiag tool." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-select-log-folder.png":::

1. Select **Select Log Folder**, drill into the folder that you extracted the TSS SQL Base CAB files into, and then select **OK**.

## Interpret the AGDiag report

The AGDiag report should be launched in the default system browser. The following illustrations help you interpret the report.

The following AGDiag Splash Screen describes AGDiag capabilities and version information:

:::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-splash-screen.png" alt-text="Screenshot of the AGDiag Splash Screen." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-splash-screen.png":::

AGDiag reports on the logs analyzed in the initialize section:

:::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/agdiag-report.png" alt-text="Screenshot of the AGDiag reports on the logs." lightbox="media/use-agdiag-diagnose-availability-group-health-events/agdiag-report.png":::

Summary report lists the availability group health events from the cluster log:

:::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/availability-group-health-event-summary-report.png" alt-text="Screenshot of availability group health events." lightbox="media/use-agdiag-diagnose-availability-group-health-events/availability-group-health-event-summary-report.png":::

There is a detailed report for each health event detected, which includes log findings that correlate to the health event, diagnosis, and recommendations:

:::image type="content" source="media/use-agdiag-diagnose-availability-group-health-events/alwayson-health-event.png" alt-text="Screenshot of AlwaysOn health events." lightbox="media/use-agdiag-diagnose-availability-group-health-events/alwayson-health-event.png":::

## Known issues with AGDiag

For the latest information on documented issues and possible solutions, see [Known Issues with AGDiag · microsoft/agdiag Wiki · GitHub](https://github.com/microsoft/agdiag/wiki/Known-Issues-with-AGDiag).
