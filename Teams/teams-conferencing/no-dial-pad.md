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

Here are the four possible causes of this issue:

- The user hasn't assigned a Teams license.
- The user hasn't assigned a Calling Plan.
- The user hasn't enabled Enterprise Voice.
- The user is in **Islands** mode.
- The **OnlineVoiceRoutingPolicy** value isn't set correctly for the user.

## Resolution

- Make sure that the user has been assigned a [Teams license](/microsoftteams/teams-add-on-licensing/assign-teams-add-on-licenses).
- Make sure that the user has been assigned a [Calling Plan](/microsoftteams/calling-plan-landing-page).
- Enable the user for [Enterprise Voice](/skypeforbusiness/skype-for-business-hybrid-solutions/plan-your-phone-system-cloud-pbx-solution/enable-users-for-enterprise-voice-online-and-phone-system-voicemail).
- For more information about Islands mode, see [Understand Microsoft Teams and Skype for Business coexistence and interoperability](/microsoftteams/teams-and-skypeforbusiness-coexistence-and-interoperability).
- Teams administrators should remove the user's **OnlineVoiceRoutingPolicy** value and set the correct value for the policy as shown in the following example:

    ```powershell
    Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName $Null
    ```

    ```powershell
    Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName "RedmondOnlineVoiceRoutingPolicy"
    ```

    These actions force an update of the policy in the back-end environment of Teams. After this change is made, the user should see the dial pad appear under **Calls** within four hours.

### Run a self-diagnostics tool

Microsoft 365 admin users have access to diagnostic tools that they can run within the tenant to verify possible issues that affect the dial pad.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select the **Run Tests** link. This will populate the diagnostic in the Microsoft 365 admin center.

> [!div class="nextstepaction"]
> [Run Tests: Teams Dial Pad Missing](https://aka.ms/TeamsDialPadMissingDiag)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
