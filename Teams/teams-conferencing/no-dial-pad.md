---
title: Dial pad in missing in Teams
description: Microsoft Teams users cannot make outbound calls to external phone numbers because of no dial pad in Teams.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 112082, 120059
  - CSSTroubleshoot
ms.reviewer: kellybos
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# Dial pad is missing in Teams

Microsoft Teams user can't make outbound calls because the dial pad in the **Calls** screen in Teams is missing.

## Cause

In the Teams client, the dial pad enables users to access Public Switched Telephone Network (PSTN) functionality. The dial pad is available for users with a Phone System license, provided they're configured properly. All of the following conditions must be met for the dial pad to appear:

- The user has a Teams license assigned.
- The user has a Teams Phone System (MCOEV) license assigned.
- The user has Microsoft Calling Plan, Operator Connect, or is enabled for Direct Routing.
- The user has Enterprise Voice enabled.
- The user is homed online and not in Skype for Business on-premises.
- The user has Teams Calling Policy enabled with AllowPrivateCalling = True.

## Resolution

See [Dial pad Configuration](/microsoftteams/dial-pad-configuration) to learn how to configure users correctly for Teams PSTN calling.

Use one of the following diagnostic tools:

- Microsoft Remote Connectivity Analyzer tool

  Microsoft 365 admin users can run the [Teams PSTN Calling Dial Pad](https://testconnectivity.microsoft.com/tests/TeamsDialpadMissing/input) test in the context of the user experiencing the symptom. 
- Microsoft 365 support self-diagnostics tool

  Microsoft 365 admin users have access to diagnostic tools that they can run within the tenant to verify possible issues that affect the dial pad.

  > [!NOTE]
  > This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

  Select the **Run Tests** link. It will populate the diagnostic in the Microsoft 365 admin center.

  > [!div class="nextstepaction"]
  > [Run Tests: Teams Dial Pad Missing](https://aka.ms/TeamsDialPadMissingDiag)

### Enterprise Voice shows Disabled

If the diagnostic result from one of the tools shows that the user isn't enabled for Enterprise Voice, but the user account shows that it's enabled in Teams PowerShell, the tenant administrator must toggle the setting off and back on to force an update to the backend as shown in the following example:

```powershell
Set-CsPhoneNumberAssignment -Identity "Ken Myer" -EnterpriseVoiceEnabled $False
```

```powershell
Set-CsPhoneNumberAssignment -Identity "Ken Myer" -EnterpriseVoiceEnabled $True
```

### Direct Routing-enabled users missing dial pad

If the diagnositic result from one of the tools shows that the user isn't configured correctly with a routing policy, the tenant administrator must remove the user's **OnlineVoiceRoutingPolicy** value, and then set the correct value for the policy as shown in the following example:

```powershell
Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName $Null
```

```powershell
Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName "RedmondOnlineVoiceRoutingPolicy"
```

These actions force an update of the policy in the backend environment of Teams. After this change is made, the user should see the dial pad appears under **Calls** within an hour.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
