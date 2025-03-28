---
title: Resolve Teams Client Crash Issues
description: Lists all possible causes for Teams client crash issues and provides resolutions for them.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Admin\TAC (Teams Admin Center)
  - CI 3647
  - CSSTroubleshoot
ms.reviewer: shals
search.appverid: 
  - MET150
ms.date: 03/27/2025
---
# Resolve Teams client crash issues

> [!IMPORTANT]
> This article describes a Microsoft Teams feature that hasn't yet been released. It's been announced, and it's coming soon. If you're an admin, you can find out when this feature will be released in the Message Center (in the [Microsoft 365 admin center](https://portal.office.com/adminportal/home)). For more information, see [Teams client health](https://www.microsoft.com/microsoft-365/roadmap?filters=&searchterms=478610) and [Monitor Teams client updates](https://www.microsoft.com/microsoft-365/roadmap?filters=&searchterms=478609).

When a user in your organization uses the Teams app on their device, the app exits unexpectedly. This issue is categorized as a **Client crash** in the [Teams client health dashboard](/microsoftteams/teams-client-health).

As an administrator, you can check the **Insight** column on the **Issues** tab to find potential reasons why the Teams app crashes. This article lists all the insights for Teams client crash issues and provides resolutions for them. If the issue persists after you perform the resolution, contact [Microsoft Support](https://support.microsoft.com/contactus) for more assistance.

If your organization uses non-Microsoft antivirus or data loss prevention (DLP) applications, make sure that you include or approve the Teams desktop client, the executable that automatically starts the Teams app, and Microsoft Edge WebView2. For more information, see [Prevent antivirus and DLP tools from blocking or crashing Microsoft Teams](include-exclude-teams-from-antivirus-dlp.md)

## Media stack technology failure

To fix the issue, make sure that [antivirus and DLP tools](include-exclude-teams-from-antivirus-dlp.md) don't block Teams and WebView2 processes from accessing Teams services.

Additionally, [enable Windows Error Reporting (WER)](/troubleshoot/windows-client/system-management-components/windows-error-reporting-diagnostics-enablement-guidance) to collect more information and update drivers.

## WebView2 failure

To fix issues that are caused by WebView2 process failures, check the WebView2 error codes for more information. These error codes indicate various problems such as:

- External termination
- Invalid parameters
- Resource limits
- Sandbox or GPU issues
- System faults
