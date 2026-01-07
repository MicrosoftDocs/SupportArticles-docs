---
title: Edge and Edge WebView2 update, installation, or rollback failure
description: Troubleshoot issues when Microsoft Edge or Edge WebView2 fails to update, install, or roll back.
ms.custom: sap:Manageability and Deployment\Installation, Update, Removal, Rollback
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.date: 01/07/2026
---
# Install, update, or rollback failures for Edge and Edge WebView2

When you install, update, or rollback Microsoft Edge or Microsoft Edge WebView2, you might encounter an issue that prevents the operation from completing. This article helps you collect the diagnostic information the [Microsoft Support Team](TODO) needs to analyze and help resolve the problem.

## Symptoms

You might experience one or more of the following problems with Edge or Edge WebView2:

- Failure to install
- Failure to update
- Failure to rollback to a previous version

<!-- TODO: Ask SME for more info about symptoms. Error messages, effect of the error, what the user is doing when the error occurs -->

## Cause

<!-- TODO: Ask SME for info about the cause (unless there are many possible causes and the exact cause can't be known in advance) -->

## Solution

To resolve this problem, collect and package the following diagnostic logs. Then, submit them to the Microsoft Support Team for analysis:

- Edge installation and update logs
- Edge policy JSON export
- Process Monitor (PML) log

### Collect Edge installation and update logs

Collect logs from the following locations based on your installation type:

#### Update logs

- If Edge is installed for all users:

  `%ALLUSERSPROFILE%\Microsoft\EdgeUpdate\Log\MicrosoftEdgeUpdate.log`

- If Edge is installed for just you:

  `%LOCALAPPDATA%\Temp\MicrosoftEdgeUpdate.log`

#### Installation logs

- If Edge is installed for all users:

  `%WINDIR%\Temp\msedge_installer.log`

- If Edge is installed for just you:

  `%LOCALAPPDATA%\Temp\msedge_installer.log`

### Export Edge policy settings

Follow these steps to export the Edge policy information:

1. Open Microsoft Edge and go to `edge://policy`.
1. Select **Export to JSON**.
1. Save the exported JSON file.

### Collect a Process Monitor log

[Process Monitor](/sysinternals/downloads/procmon) is a Windows monitoring tool that captures real-time file system, registry, and process/thread activity.

Follow these steps to collect a Process Monitor log:

1. Download [Process Monitor](/sysinternals/downloads/procmon) and unzip it.
1. Run `Procmon.exe`.
1. When Process Monitor starts, data capture begins automatically. Select the **Capture** icon in the toolbar to stop the initial capture.

   :::image type="content" source="./media/update-install-rollback-failures/procmon-capture-icon.png" alt-text="Screenshot of Process Monitor with the Capture button highlighted.":::

1. Go to **Edit** > **Clear Display** to clear existing data.

   :::image type="content" source="./media/update-install-rollback-failures/procmon-clear-display.png" alt-text="Screenshot of Process Monitor with the Clear Display option highlighted.":::

1. Make sure the following options are enabled to capture all activity types:
   - File System
   - Registry
   - Process/Thread
   - Network

   :::image type="content" source="./media/update-install-rollback-failures/procmon-activity-types.png" alt-text="Screenshot of Process Monitor with the File System, Registry, Process/Thread, and Network activity types selected.":::

1. Select the **Capture** icon again to start monitoring.
1. Retry the install, update, or rollback process to reproduce the issue.
1. Once the issue occurs, select the **Capture** icon again to stop monitoring.
1. Save the log file:
   1. Go to **File** > **Save**.
   1. In the dialog, select:

      - **Events to save**: _All events_
      - **Format**: _Native Process Monitor Format (PML)_
      - **Path**: Choose the desired folder to save the log file

### Submit the diagnostic package

After packaging the collected logs, submit the files to the [Microsoft Support Team](TODO). The support team will analyze the logs and help you resolve the problem.

## Related content

- [Sysinternals](/sysinternals)
- [Troubleshooting with the Windows Sysinternals Tools](/sysinternals/resources/troubleshooting-book)