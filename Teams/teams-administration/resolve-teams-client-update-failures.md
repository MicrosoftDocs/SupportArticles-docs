---
title: Resolve Teams Client Update Failures
description: Lists all possible causes for Teams client update failures and provides resolutions for them.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Admin\TAC (Teams Admin Center)
  - CI 4439
  - CSSTroubleshoot
ms.reviewer: shals
search.appverid: 
  - MET150
ms.date: 03/27/2025
---
# Resolve Teams client update failures

## Summary

When Microsoft Teams fails to update, the Teams client health dashboard reports an Update failure and provides an insight into the possible cause. This article explains how to resolve failures caused by Group Policy, network connectivity, or Delivery Optimization settings. If the cause remains unclear, it explains how to force an update, collect diagnostic logs, and contact Microsoft Support.

## Symptoms

When a user in your organization uses the Teams app on their device, the app fails to update to the latest version. This issue is categorized as a **Update failure** in the [Teams client health dashboard](/microsoftteams/teams-client-health).

## Cause

As an administrator, you can check the **Insight** column on the **Issues** tab to find a potential cause of the update failure. This article lists all the insights for Teams client update failure and provides resolutions for them. If the issue persists after you perform the resolution, contact [Microsoft Support](https://support.microsoft.com/contactus) for more assistance.

## Resolution

### MSIX GPO block

This insight indicates that the update failure is caused by specific Group Policy settings. To fix the issue, [bulk deploy the Teams client](/microsoftteams/new-teams-bulk-install-client) to the devices.

### Network failure data corruption – External

To fix the issue, see [Windows Update error 0X8007000D](/troubleshoot/windows-client/installing-updates-features-roles/common-windows-update-errors#0x8007000d).

### Network failure - Connection time out

To fix the issue, see [Windows Update error 0x80072EE2](/troubleshoot/windows-client/installing-updates-features-roles/common-windows-update-errors#0x80072ee2).

### Network/Connectivity failure, external

To fix the issue, see [Troubleshoot Windows Update error 0x80072EFE](/troubleshoot/windows-client/installing-updates-features-roles/troubleshoot-windows-update-error-0x80072efe-with-cipher-suite-configuration).

### DO service disabled by admin

To fix the issue, make sure that [Delivery Optimization](/microsoft-365-apps/updates/delivery-optimization) is enabled and configured correctly.

### Network failure or server not supporting range request

To fix the issue, make sure that the device meets the [system requirements for new Teams client](/microsoftteams/teams-client-system-requirements).

### Network failure – External DNS

To fix the issue, check for network connection issues and fix them. If the Teams app still can't update, follow these steps to collect diagnostic logs and contact Microsoft Support for assistance:

1. On the device that's running an outdated version of the Teams client app, open Windows PowerShell, and then run the following command to close the Teams app and force an update to the latest version:

   ```powershell
   Add-AppxPackage https://go.microsoft.com/fwlink/?linkid=2196060 -ForceUpdateFromAnyVersion -ForceTargetApplicationShutdown
   ```

1. If the Teams app doesn't update to the latest version successfully, the cause of the problem might be the version of Windows that's running on the device. Collect [Windows diagnostic logs](https://aka.ms/TCSMWinLogs), and then [contact Microsoft Support](https://support.microsoft.com/contactus).
1. If the Teams app updates to the latest version successfully, the cause of the problem might be the automatic update process. Collect [Teams diagnostic logs](/microsoftteams/log-files) and [Windows diagnostic logs](https://aka.ms/TCSMWinLogs), and then contact Microsoft Support by using the **Contact Support** menu option in the **Help** pane of the Microsoft Teams admin center.
