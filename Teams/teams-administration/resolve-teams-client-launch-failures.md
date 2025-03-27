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

> [!IMPORTANT]
> This article describes a Microsoft Teams feature that hasn't yet been released. It's been announced, and it's coming soon. If you're an admin, you can find out when this feature will be released in the Message Center (in the [Microsoft 365 admin center](https://portal.office.com/adminportal/home)). For more information, see [Teams client health](https://www.microsoft.com/microsoft-365/roadmap?filters=&searchterms=478610) and [Monitor Teams client updates](https://www.microsoft.com/microsoft-365/roadmap?filters=&searchterms=478609).

When a user in your organization tries to start the Teams app on their device, a blank window opens and then disappears immediately. This issue is categorized as a **Launch failure** in the [Teams client health dashboard](/microsoftteams/teams-client-health). 

As an administrator, you can check the **Insight** column on the **Issues** tab to find a potential cause of the launch failure. This article lists all the insights for Teams client launch failures and provides resolutions for them. If the issue persists after you perform the resolution, contact [Microsoft Support](https://support.microsoft.com/contactus) for more assistance.

## Unable to navigate to Teams endpoint

To fix the issue, review and update your network configuration. Make sure that a firewall or proxy settings don't block the Teams client access to [Teams endpoints](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#microsoft-teams&preserve-view=true).

## Timed out waiting for Teams endpoint

To fix the issue, review and update your network configuration. Make sure that a firewall or proxy settings don't block the Teams client access to [Teams endpoints](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide#microsoft-teams&preserve-view=true). Also, make sure that all Teams-related network requests are allowed in your environment.

## Teams application contains a script error

To fix the issue, ask the affected user to sign out of the Teams app and then sign back in.

## Unsupported OS version

To fix the issue, update the operating system on the affected device to a supported version of [Windows](/microsoftteams/teams-client-system-requirements#new-teams-for-windows-pc-desktop) or [macOS](/microsoftteams/teams-client-system-requirements#new-teams-for-macos-desktop).
