---
title: Edge and Edge WebView2 update, installation, or rollback failure
description: Troubleshoot issues when Microsoft Edge or Edge WebView2 fails to update, install, or roll back.
author: [your GitHub alias]
ms.author: [your Microsoft alias or a team alias]
ms.service: microsoft-edge
ms.topic: troubleshooting-problem-resolution
ms.date: [mm/dd/yyyy]

#customer intent: As an IT admin, I want to collect diagnostic logs so that I can troubleshoot Edge installation and update failures.

---
# Install, update, or rollback failures for Edge and Edge WebView2

This article helps you collect the necessary diagnostic information when Microsoft Edge or Microsoft Edge WebView2 fails to update, install, or roll back. This information is required for the Microsoft Support Team to analyze and resolve the issue.

## Symptoms

You experience one or more of the following issues:

- Microsoft Edge fails to install
- Microsoft Edge fails to update
- Microsoft Edge WebView2 fails to install or update
- Microsoft Edge fails to roll back to a previous version

## Solution

To resolve this issue, collect and package the following diagnostic logs, then submit them to the Microsoft Support Team for analysis:

1. Edge installation and update logs
2. Edge policy JSON export
3. Process Monitor (PML) log

### Step 1: Collect Edge installation and update logs

Check the following log locations based on your installation type:

#### Update logs

- **If Edge is installed for Local System:**

  >%ALLUSERSPROFILE%\Microsoft\EdgeUpdate\Log\MicrosoftEdgeUpdate.log

- **If Edge is installed per user:**

  >%LOCALAPPDATA%\Temp\MicrosoftEdgeUpdate.log

#### Installation logs

- **If Edge is installed for Local System:**

  >%WINDIR%\Temp\msedge_installer.log

- **If Edge is installed per user:**

  >%LOCALAPPDATA%\Temp\msedge_installer.log

### Step 2: Export Edge policy settings

Follow these steps to export Edge policy information:

1. Open Microsoft Edge and navigate to:

   >edge://policy

2. Select **Export to JSON**.
3. Save the exported JSON file.

### Step 3: Collect a Process Monitor log

Process Monitor is a Windows monitoring tool that captures real-time file system, registry, and process/thread activity.

Follow these steps to collect a Process Monitor log:

1. Download Process Monitor and unzip it.
2. Run `Procmon.exe`.
3. When Process Monitor starts, data capture begins automatically. Select the **Capture** icon in the toolbar to stop capturing.

   ![Screenshot showing the Capture icon in Process Monitor](../assets/images/Procmon_1.png)

4. Go to **Edit** > **Clear Display** to clear existing data.

   ![Screenshot showing the Clear Display option](../assets/images/Procmon_2.png)

5. Make sure the following options are enabled to capture all activity types:
   - File System
   - Registry
   - Process/Thread
   - Network

   ![Screenshot showing capture options](../assets/images/Procmon_3.png)

6. Select the **Capture** icon again to start monitoring.
7. Reproduce the issue.
8. Once the issue occurs, select the **Capture** icon again to stop monitoring.
9. Save the log file:
   1. Go to **File** > **Save**.
   2. In the dialog, select:
      - **Events to save:** `All events`
      - **Format:** `Native Process Monitor Format (PML)`
      - **Path:** Choose the desired folder to save the log file

### Step 4: Submit the diagnostic package

After packaging the collected logs together, submit the files to the Microsoft Support Team. The support team will analyze the logs and help you resolve the issue.