---
title: Troubleshoot Edge Update, Installation, and Rollback Failures
description: Learn how to troubleshoot and resolve installation, update, or rollback failures for Microsoft Edge and Edge WebView2 with step-by-step guidance.
ms.custom: sap:Manageability and Deployment\Installation, Update, Removal, Rollback
ms.reviewer: dili, Johnny.Xu, v-shaywood
ms.date: 01/07/2026
---
# Install, update, or rollback failures for Edge and Edge WebView2

When you install, update, or rollback Microsoft Edge or Microsoft Edge WebView2, you might encounter an issue that prevents the operation from completing. This article helps you collect the diagnostic information the [Microsoft Support Team](TODO) needs to analyze and help resolve the problem.

The following components are involved in Edge installation and update scenarios:

| Component             | Description                     |
| --------------------- | ------------------------------- |
| Microsoft Edge        | Chromium-based browser          |
| Edge WebView2 Runtime | Embedded web rendering runtime  |
| Microsoft Edge Update | Update service (`msedgeupdate`) |
| Edge Installer        | MSI or EXE installer            |

## Symptoms

You might experience one or more of the following symptoms:

- Edge or Edge WebView2 installation hangs or rolls back.
- Installation completes but the version doesn't change.
- Edge WebView2 Runtime is missing or unexpectedly removed.
- Edge Update service retries repeatedly.
- Silent installation fails with no UI or error prompt.
- Edge automatically rolls back to an older version.
- Application fails to start after Edge WebView2 downgrade.
- MSI errors occur during rollback.
- Edge fails to launch after rollback.

You might also see one of the following error codes:

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
| `0x80004005` | Unspecified error (usually environment-related) |

## Cause

Most Edge and WebView2 installation, update, and rollback failures are caused by one of the following issues:

- Permission restrictions
- Network or TLS issues
- Security software interference
- System component corruption
- Residual installation artifacts

> [!NOTE]
> In enterprise environments, [Group Policy Object (GPO)](/windows-server/identity/ad-ds/manage/group-policy/group-policy-overview), [Mobile Device Management (MDM)](/windows/client-management/mdm-overview), and security policies are often causes of install, update, or rollback failures.

## Solution

### Common troubleshooting checks

Before contacting Microsoft support, you should complete the following common troubleshooting checks. These steps resolve the majority of Microsoft Edge and Edge WebView2 update, installation, or rollback issues.

#### Restart the device

A system restart clears temporary system states that may block Edge or Edge WebView2 updates.

Restarting the device helps to:

- Complete any pending system reboot required by previous updates
- Release locked files used by Edge or Edge WebView2 processes
- Reset Windows Installer and related update services

After restarting, ensure no Edge or Edge WebView2-based applications are running before retrying the install, update, or rollback operation.

#### Verify available disk space

Insufficient disk space may cause Edge or Edge WebView2 install, update, or rollback failures. During installation, setup packages need temporary space to extract files and complete the process.

_Recommended_: At least 1-2 GB of free disk space on the system drive (usually `C:`).

1. Open **File Explorer**.
1. Check the available space on the system drive.
1. Free up disk space if needed (for example, remove temporary files or unused applications).

#### 3. Run installation as an administrator

Edge and Edge WebView2 install, update, and rollback operations require administrative privileges to:

- Write to system directories (for example, `Program Files`)
- Register system components
- Modify services and scheduled tasks

To run the install, update, or rollback as an administrator:

1. Right-click the installer file (`.exe` or `.msi`).
1. Select **Run as administrator**.
1. Approve the [User Account Control (UAC)](/windows/security/application-security/application-control/user-account-control/) prompt.

> [!NOTE]
> On managed or enterprise devices, ensure the account used has local administrator permissions.

#### Close Edge and Edge WebView2-based applications

Running Edge or Edge WebView2-based applications may lock files required during install, update, or rollback operations.

Common WebView2-based applications include (but are not limited to):

- Microsoft Edge
- [Microsoft Teams](/microsoftteams/teams-overview)
- [Outlook (new client)](/microsoft-365-apps/outlook/overview-new-outlook-windows)
- [Windows Widgets](/windows/apps/design/widgets/)
- Custom line-of-business applications

Follow these steps:

1. Close all open applications.
1. Open **Task Manager**.
1. Confirm there are no running processes such as:
   - `msedge.exe`
   - `msedgewebview2.exe`
1. End any remaining processes if necessary.
1. Retry the install, update, or rollback operation.

#### Temporarily disable third-party security software (if applicable)

> [!IMPORTANT]
> Follow your organization's security policies. If disabling security software is not allowed, contact your IT administrator for assistance.

Some third-party antivirus, endpoint protection, or application control solutions may block:

- Installer execution (for example, `msedgeupdate.exe`, `msiexec.exe`)
- File replacement during update or rollback
- Service registration or scheduled task creation

Follow these steps:

1. Temporarily disable third-party security software, if permitted by organizational policy.
1. Retry the installation or update.
1. Re-enable security software immediately after completion.

### Contact support

If the steps in [Common troubleshooting checks](#common-troubleshooting-checks) do not resolve your problem, collect and package the following diagnostic logs. Then, submit them to the Microsoft Support Team for analysis:

- Edge installation and update logs
- Edge policy JSON export
- Process Monitor (PML) log

#### Collect Edge installation and update logs

Collect logs from the following locations based on your installation type:

##### Update logs

- If Edge is installed for all users:

  `%ALLUSERSPROFILE%\Microsoft\EdgeUpdate\Log\MicrosoftEdgeUpdate.log`

- If Edge is installed for just you:

  `%LOCALAPPDATA%\Temp\MicrosoftEdgeUpdate.log`

##### Installation logs

- If Edge is installed for all users:

  `%WINDIR%\Temp\msedge_installer.log`

- If Edge is installed for just you:

  `%LOCALAPPDATA%\Temp\msedge_installer.log`

#### Export Edge policy settings

Follow these steps to export the Edge policy information:

1. Open Microsoft Edge and go to `edge://policy`.
1. Select **Export to JSON**.
1. Save the exported JSON file.

#### Collect a Process Monitor log

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

#### Submit the diagnostic package

After packaging the collected logs, submit the files to the [Microsoft Support Team](TODO). The support team will analyze the logs and help you resolve the problem.

## Related content

- [Sysinternals](/sysinternals)
- [Troubleshooting with the Windows Sysinternals Tools](/sysinternals/resources/troubleshooting-book)