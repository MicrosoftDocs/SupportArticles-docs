---
title: Resolve Microsoft Teams Client Launch Failures
description: Lists all possible causes for Teams client startup failures and provides resolutions for them. 
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Admin\TAC (Teams Admin Center)
  - CI 3646
  - CSSTroubleshoot
ms.reviewer: shals
search.appverid: 
  - MET150
ms.date: 03/26/2025
---
# Resolve Teams client launch failures

## Summary

When Microsoft Teams opens a blank window and then closes, the Teams client health dashboard reports a **Launch failure**. The dashboard’s Insight column can identify blocked or timed-out connections to Teams endpoints, a script error, or an unsupported Windows or macOS version. This article provides the corresponding steps to restore network access, sign back in to Teams, or update the operating system.

## Symptoms

When a user in your organization tries to start the Teams app on their device, a blank window opens and then disappears immediately. This issue is categorized as a **Launch failure** in the [Teams client health dashboard](/microsoftteams/teams-client-health). 

## Cause

As an administrator, you can check the **Insight** column on the **Issues** tab to find a potential cause of the launch failure. This article lists all the insights for Teams client launch failures and provides resolutions for them. If the issue persists after you perform the resolution, contact [Microsoft Support](https://support.microsoft.com/contactus) for more assistance.

## Resolution

### Unable to navigate to Teams endpoint

To fix the issue, review and update your network configuration. Make sure that a firewall or proxy settings don't block the Teams client access to [Teams endpoints](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#microsoft-teams&preserve-view=true).

### Timed out waiting for Teams endpoint

To fix the issue, review and update your network configuration. Make sure that a firewall or proxy settings don't block the Teams client access to [Teams endpoints](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#microsoft-teams&preserve-view=true). Also, make sure that all Teams-related network requests are allowed in your environment.

### Teams application contains a script error

To fix the issue, ask the affected user to sign out of the Teams app and then sign back in.

### Unsupported OS version

To fix the issue, update the operating system on the affected device to a supported version of [Windows](/microsoftteams/teams-client-system-requirements#new-teams-for-windows-pc-desktop) or [macOS](/microsoftteams/teams-client-system-requirements#new-teams-for-macos-desktop).
