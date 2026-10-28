---
title: Check Conditional Access policies for unsupported Teams device settings
description: Describes how to identify Conditional Access policy settings that aren't supported for Microsoft Teams Rooms and Teams Android devices. Use PowerShell to identify Conditional Access policy settings that aren't supported for Microsoft Teams Rooms and Teams Android devices.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug
author: Cloud-Writer
ms.author: meerak
ms.date: 10/27/2026
---

# Check Conditional Access policies for unsupported Teams device settings

## Summary

You might need to verify whether your Microsoft Entra Conditional Access policies include settings that aren't supported for Microsoft Teams Rooms on Windows, Teams Rooms on Android, Teams phones, Teams panels, or Teams displays. This verification is needed to diagnose the issue when any of these devices have sign-in or sign-out issues. For example, unsupported conditions, grant controls, or session controls can affect sign-in behavior. Also you might want to confirm that your Conditional Access configuration is supported before you troubleshoot further.

## Use PowerShell to review Conditional Access policies

You can use the UcLobbyTeams PowerShell module to review Conditional Access policies in your tenant.

> [!NOTE]
> You must be at least a Conditional Access Administrator to use the UcLobbyTeams PowerShell module.

### Commercial tenants

1. Run the following commands in PowerShell:
   ```powershell
   Install-Module UcLobbyTeams
   Install-Module EntraAuth
   Connect-MgGraph -Scopes "Policy.Read.All","Directory.Read.All"
   Test-UcTeamsDevicesConditionalAccessPolicy -detailed -ExportCSV -All
   ```

### GCC High tenants

1. Run the following commands in PowerShell:
   ```powershell
   Install-Module UcLobbyTeams
   Install-Module EntraAuth
   Connect-MgGraph -Scopes "Policy.Read.All","Directory.Read.All" -Environment USGov
   Test-UcTeamsDevicesConditionalAccessPolicy -detailed -ExportCSV -All
   ```

### Review the results

1. Open the exported CSV file, and review the results for unsupported settings.
1. If you see unsupported settings in the **TeamsDevicesStatus** results, check whether the affected Conditional Access policies use **Filter for devices**.
1. Configure device filters where appropriate to exclude Teams devices from unsupported policy settings.
1. When you create device filters for Teams phones, use the **In**, **StartsWith**, or **Contains** operators for model and manufacturer values.

> [!NOTE]
> Using the **Equals** operator in these device filters can cause intermittent issues.

## More information

For information on the supported Conditional Access and compliance settings for Teams Rooms and Teams Android devices in the following article, see [Supported Conditional Access and Intune device compliance policies for Microsoft Teams Rooms and Teams Android devices](/microsoftteams/rooms/supported-ca-and-compliance-policies?tabs=mtr-a).

The following Conditional Access settings are documented as unsupported for some Teams device types:

- **Client apps**
- **Authentication flows** for some Android-based Teams devices, because device code flow is required for sign-in
- **Require authentication strength**
- **Require Microsoft Entra hybrid joined device**
- **Require approved client app**
- **Require app protection policy**
- **Require password change**
- **Use app enforced restrictions**
- **Use Conditional Access App Control**
- **Persistent browser session**
- **Continuous access evaluation**
- **Disable resiliency defaults**
- **Require token protection for sign-in sessions (Preview)**

> [!NOTE]
> Sign-in frequency policies can periodically sign out devices. Sign-in frequency settings on individual Microsoft 365 services can also interrupt or stop the Teams device sign-in flow, and Microsoft doesn't support that configuration.
> Authentication strength, including FIDO2 security keys, isn't supported in Conditional Access policies that affect Teams devices.

For additional troubleshooting guidance for Android-based Teams devices, see [Conditional Access-related issues on Teams Android devices](teams-android-devices-conditional-access-issues.md).
To diagnose Teams Rooms sign-in issues, use the [Microsoft Teams Rooms Sign in](https://testconnectivity.microsoft.com/tests/TeamsMTRDeviceSignIn/input) test in the Microsoft Remote Connectivity Analyzer.
