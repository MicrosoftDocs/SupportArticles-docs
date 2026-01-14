---
title: Troubleshoot Edge Update, Installation, and Rollback Failures
description: Learn how to troubleshoot and resolve installation, update, or roll back failures for Microsoft Edge and Edge WebView2.
ms.custom: 'sap:Manageability and Deployment\Installation, Update, Removal, Rollback'
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.date: 01/07/2026
---
# Install, update, or roll back failures for Edge and Edge WebView2

When you install, update, or roll back Microsoft Edge or Microsoft Edge WebView2, you encounter a problem that prevents the operation from finishing. This article helps you collect the diagnostic information that the [Microsoft Support Team](TODO) needs to analyze and help resolve the problem.

The following components are involved in Edge installation and update scenarios.

| Component             | Description                     |
| --------------------- | ------------------------------- |
| Microsoft Edge        | Chromium-based browser          |
| Edge WebView2 Runtime | Embedded web rendering runtime  |
| Microsoft Edge Update | Update service (`msedgeupdate`) |
| Edge Installer        | MSI or EXE installer            |

## Symptoms

You experience one or more of the following symptoms:

- Edge or Edge WebView2 installation stops responding or rolls back.
- The installation finishes, but the version doesn't change.
- Edge WebView2 Runtime is missing or unexpectedly removed.
- Edge Update service retries repeatedly.
- Silent installation fails and returns no UI or error prompt.
- Edge automatically rolls back to an older version.
- The application doesn't start after an Edge WebView2 downgrade.
- MSI errors occur during rollback.
- Edge doesn't start after a rollback.

You might also see one of the following error codes.

### Installer or MSI errors

| Error code   | Meaning                              |
| ------------ | ------------------------------------ |
| `0x80070643` | MSI installation failure             |
| `0x80070005` | Access denied                        |
| `0x80070002` | File not found                       |
| `0x80070652` | Another installation is in progress  |
| `1603`       | Fatal error during installation      |
| `1618`       | Windows Installer is already running |

### Edge Update errors

| Error code   | Meaning                                         |
| ------------ | ----------------------------------------------- |
| `0x80072EE7` | DNS resolution failure                          |
| `0x80072EFE` | Network connection dropped                      |
| `0x80072F8F` | TLS or certificate validation failure           |
| `0x80004005` | Unspecified error (usually environment related) |

## Cause

Most Edge and WebView2 installation, update, and rollback failures occur because of one of the following problems:

- Permission restrictions
- Network or TLS issues
- Security software interference
- System component corruption
- Residual installation artifacts

> [!NOTE]
> In enterprise environments, [Group Policy Object (GPO)](/windows-server/identity/ad-ds/manage/group-policy/group-policy-overview), [Mobile Device Management (MDM)](/windows/client-management/mdm-overview), and security policies often cause installation, update, or rollback failures.

## Solution

### Common troubleshooting checks

Before you contact Microsoft Support, complete the following common troubleshooting checks. These steps resolve most Microsoft Edge and Edge WebView2 installation, update, and rollback problems.

#### Restart the device

A system restart clears temporary system states that might block Edge or Edge WebView2 updates.

Restarting the device helps to:

- Complete any pending system restart that's required by previous updates
- Release locked files that are used by Edge or Edge WebView2 processes
- Reset Windows Installer and related update services

After a restart, make sure that no Edge or Edge WebView2-based applications are running before you try the installation, update, or rollback operation again.

#### Verify available disk space

Insufficient disk space might cause Edge or Edge WebView2 installaion, update, or rollback failures. During installation, setup packages need temporary space to extract files and complete the process.

_Recommended_: At least 1-2 GB of free disk space on the system drive (usually `drive C`).

1. Open **File Explorer**.
1. Check the available space on the system drive.
1. Free up disk space if it's necessary (for example, remove temporary files or unused applications).

#### Run installation as an administrator

Edge and Edge WebView2 installation, update, and rollback operations require administrative privileges to:

- Write to system directories (for example, `Program Files`)
- Register system components
- Modify services and scheduled tasks

To run the installation, update, or rollback process as an administrator:

1. Right-click the installer file (`.exe` or `.msi`).
1. Select **Run as administrator**.
1. Approve the [User Account Control (UAC)](/windows/security/application-security/application-control/user-account-control/) prompt.

> [!NOTE]
> On managed or enterprise devices, make sure that the account you use has local administrator permissions.

#### Close Edge and Edge WebView2-based applications

Running Edge or Edge WebView2-based applications might lock files that are required during installation, update, or rollback operations.

Common WebView2-based applications include (but aren't limited to):

- Microsoft Edge
- [Microsoft Teams](/microsoftteams/teams-overview)
- [Outlook (new client)](/microsoft-365-apps/outlook/overview-new-outlook-windows)
- [Windows Widgets](/windows/apps/design/widgets/)
- Custom line-of-business applications

Follow these steps:

1. Close all open applications.
1. Open **Task Manager**.
1. Verify that there are no running processes such as:
   - `msedge.exe`
   - `msedgewebview2.exe`
1. End any remaining processes, if it's necessary.
1. Retry the installation, update, or rollback operation.

#### Temporarily disable third-party security software (if applicable)

> [!IMPORTANT]
> Follow your organization's security policies. If the policies don't allow you to disable security software, contact your IT administrator for assistance.

Some third-party antivirus, endpoint protection, or application control solutions block the following actions:

- Installer execution (for example, `msedgeupdate.exe`, `msiexec.exe`)
- File replacement during an update or rollback operation
- Service registration or scheduled task creation

Follow these steps:

1. Temporarily disable third-party security software, if your organizational policy permits.
1. Retry the installation or update.
1. Re-enable security software immediately after completion.

### Contact support

If the steps in [Common troubleshooting checks](#common-troubleshooting-checks) don't resolve your problem, collect and package the following diagnostic logs, and then, submit them to Microsoft Support for analysis:

- Edge installation and update logs
- Edge policy JSON export
- Process Monitor (PML) log

#### Collect Edge installation and update logs

Collect logs from the following locations, based on your installation type:

##### Update logs

- If Edge is installed for all users:

  `%ALLUSERSPROFILE%\Microsoft\EdgeUpdate\Log\MicrosoftEdgeUpdate.log`

- If Edge is installed for only you:

  `%LOCALAPPDATA%\Temp\MicrosoftEdgeUpdate.log`

##### Installation logs

- If Edge is installed for all users:

  `%WINDIR%\Temp\msedge_installer.log`

- If Edge is installed for only you:

  `%LOCALAPPDATA%\Temp\msedge_installer.log`

#### Export Edge policy settings

To export the Edge policy information, follow these steps:

1. Open Microsoft Edge, and browse to `edge://policy`.
1. Select **Export to JSON**.
1. Save the exported JSON file.

#### Collect a Process Monitor log

[Process Monitor](/sysinternals/downloads/procmon) is a Windows monitoring tool that captures real-time file system, registry, and process and thread activity.

To collect a Process Monitor log, follow these steps:

1. Download [Process Monitor](/sysinternals/downloads/procmon), and expand it.
1. Run `Procmon.exe`.
1. When Process Monitor starts, data capture begins automatically. To stop the initial capture, select the **Capture** icon on the toolbar.

   :::image type="content" source="./media/update-install-rollback-failures/procmon-capture-icon.png" alt-text="Process Monitor showing the Capture button highlighted.":::

1. Go to **Edit** > **Clear Display** to clear existing data.

   :::image type="content" source="./media/update-install-rollback-failures/procmon-clear-display.png" alt-text="Screenshot of Process Monitor with the Clear Display option highlighted.":::

1. To capture all activity types, make sure that the following options are enabled:

   - File System
   - Registry
   - Process/Thread
   - Network

   :::image type="content" source="./media/update-install-rollback-failures/procmon-activity-types.png" alt-text="Process Monitor showing the File System, Registry, Process/Thread, and Network activity types selected.":::

1. To start monitoring, select the **Capture** icon again.
1. Reproduce the problem by retrying the installation, update, or rollback process.
1. When the problem occurs, select the **Capture** icon again to stop monitoring.
1. Save the log file:
   1. Go to **File** > **Save**.
   1. In the dialog box, select:

      - **Events to save**: _All events_
      - **Format**: _Native Process Monitor Format (PML)_
      - **Path**: Choose the folder where you want to save the log file

#### Submit the diagnostic package

After you package the collected logs, submit the files to the [Microsoft Support Team](TODO). The support team analyzes the logs and helps you resolve the problem.

## Related content

- [Sysinternals](/sysinternals)
- [Troubleshooting with the Windows Sysinternals Tools](/sysinternals/resources/troubleshooting-book)
