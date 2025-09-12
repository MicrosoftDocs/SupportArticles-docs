---
title: Root Cause Undetermined for Teams Client Update Failure
description: Provides instructions for collecting diagnostic logs and contacting Microsoft Support when a Teams client update fails with "Root cause undetermined".
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Admin\TAC (Teams Admin Center)
  - CI 3645
  - CSSTroubleshoot
ms.reviewer: binga
search.appverid: 
  - MET150
ms.date: 03/13/2025
---
# "Root cause undetermined" for Teams client update failure

> [!IMPORTANT]
> This article describes a Microsoft Teams feature that hasn't yet been released. It's been announced, and it's coming soon. If you're an admin, you can find out when this feature will be released in the Message Center (in the [Microsoft 365 admin center](https://portal.office.com/adminportal/home)). For more information, see [Teams client health](https://www.microsoft.com/microsoft-365/roadmap?filters=&searchterms=478610) and [Monitor Teams client updates](https://www.microsoft.com/microsoft-365/roadmap?filters=&searchterms=478609).

## Symptoms

On the **Health** tab of the [Teams client health dashboard](/microsoftteams/teams-client-health), the **Version status** column displays **Outdated** for one or more versions of the Teams client app that’s running on Windows devices. You select an affected entry in the **Client version** column. On the details screen, you notice that the **Insight** column displays the following message:

> Root cause undetermined.

## Resolution

To resolve the problem, follow these steps to collect diagnostic logs and contact Microsoft Support for assistance:

1. On the device that's running an outdated version of the Teams client app, open Windows PowerShell, and then run the following command to close the Teams app and force an update to the latest version:

   ```powershell
   Add-AppxPackage https://go.microsoft.com/fwlink/?linkid=2196060 -ForceUpdateFromAnyVersion -ForceTargetApplicationShutdown
   ```

1. If the Teams app doesn't update to the latest version successfully, the cause of the problem might be the version of Windows that's running on the device. Collect [Windows diagnostic logs](https://aka.ms/TCSMWinLogs), and then [contact Microsoft Support](https://support.microsoft.com/contactus).
1. If the Teams app updates to the latest version successfully, the cause of the problem might be the automatic update process. Collect [Teams diagnostic logs](/microsoftteams/log-files) and [Windows diagnostic logs](https://aka.ms/TCSMWinLogs), and then contact Microsoft Support by using the **Contact Support** menu option in the **Help** pane of the Microsoft Teams admin center.
