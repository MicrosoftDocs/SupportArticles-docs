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
ms.date: 3/31/2022
---

# Dial pad is missing in Teams

## Symptoms

Microsoft Teams user can't make outbound calls because the dial pad in the **Calls** screen in Teams is missing.

## Cause

In the Teams client, the dial pad enables users to access Public Switched Telephone Network (PSTN) functionality. The dial pad is available for users with a Phone System license, provided they're configured properly. The following criteria are all required for the dial pad to show:

- User has Teams license assigned
- User has Teams Phone System ("MCOEV") license assigned
- User has Microsoft Calling Plan, Operator Connect, or is enabled for Direct Routing
- User has Enterprise Voice enabled
- User is homed online and not in Skype for Business on premises
- User has Teams Calling Policy enabled with AllowPrivateCalling = True

## Resolution

Please see [Teams dial pad configuration](https://docs.microsoft.com/en-us/microsoftteams/dial-pad-configuration) for how to configure users correctly for Teams PSTN Calling capability.

Please run one of the available diagnostic tools

### Microsoft Remote Connectivity Analyzer tool
Microsoft 365 admin users can run Microsoft Remote Connectity Analyzer tool [Teams PSTN Calling Dial Pad](https://testconnectivity.microsoft.com/tests/TeamsDialpadMissing/input) in the context of the user experiencing the symptom. 

### Microsoft 365 support self-diagnostics tool

Microsoft 365 admin users have access to diagnostic tools that they can run within the tenant to verify possible issues that affect the dial pad.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select the **Run Tests** link. This will populate the diagnostic in the Microsoft 365 admin center.

> [!div class="nextstepaction"]
> [Run Tests: Teams Dial Pad Missing](https://aka.ms/TeamsDialPadMissingDiag)

### Enterprise Voice Shows Disabled
If a diagnostic result from one of the tools shows that the user is not enterprise voice enabled but the user account shows enabled in Teams PowerShell, then a Tenant administrator should toggle the setting off and back on to force an update to the backend as shown in the following example:

    ```powershell
    Set-CsPhoneNumberAssignment -Identity "Ken Myer" -EnterpriseVoiceEnabled $False
    ```

    ```powershell
    Set-CsPhoneNumberAssignment -Identity "Ken Myer" -EnterpriseVoiceEnabled $True
    ```

### Direct Routing User Missing Dial Pad
If a diagnositic result from one of the tools noted below shows that the user is not configured correctly with a routing policy, then a Tenant administrator should remove the user's **OnlineVoiceRoutingPolicy** value and set the correct value for the policy as shown in the following example:

    ```powershell
    Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName $Null
    ```

    ```powershell
    Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName "RedmondOnlineVoiceRoutingPolicy"
    ```

    These actions force an update of the policy in the back-end environment of Teams. After this change is made, the user should see the dial pad appear under **Calls** within an hour.



## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
