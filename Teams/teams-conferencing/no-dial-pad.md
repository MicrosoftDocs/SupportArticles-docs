---
title: Dial pad in missing in Teams
description: Microsoft Teams users cannot make outbound calls to external phone numbers because of no dial pad in Teams.
author: helenclu
ms.author: kellybos
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: o365-proplus-itpro
localization_priority: Normal
ms.custom: 
- CI 112082, 120059
- CSSTroubleshoot
ms.reviewer: kellybos
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# Dial pad is missing in Teams

## Symptoms

Microsoft Teams user can't make outbound calls because the dial pad in the **Calls** screen in Teams is missing.

## Cause

Here are the four possible causes of this issue:

- The user hasn't assigned a Teams license.
- The user hasn't assigned a Calling Plan.
- The user hasn't enabled Enterprise Voice.
- The **OnlineVoiceRoutingPolicy** value isn't set correctly for the user.

## Resolution

- Make sure the user has been assigned a [Teams license](https://docs.microsoft.com/microsoftteams/teams-add-on-licensing/assign-teams-add-on-licenses).
- Make sure the user has been assigned a [Calling Plan](https://docs.microsoft.com/microsoftteams/calling-plan-landing-page).
- Enable the user for [Enterprise Voice](https://docs.microsoft.com/skypeforbusiness/skype-for-business-hybrid-solutions/plan-your-phone-system-cloud-pbx-solution/enable-users-for-enterprise-voice-online-and-phone-system-voicemail).
- Teams administrators should remove the user's **OnlineVoiceRoutingPolicy** value and set the correct value for the policy as shown in this example:

    ```powershell
    Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName $Null
    ```

    ```powershell
    Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName "RedmondOnlineVoiceRoutingPolicy"
    ```

    These actions force an update of the policy in the back-end environment of Teams. After this change is made, the user should see the dial pad appear under **Calls** within four hours.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
