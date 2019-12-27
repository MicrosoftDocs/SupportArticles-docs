---
title: Enterprise Voice users have no dial pad in Teams
description: The Enterprise Voice users cannot make outbound calls to external phone numbers because of no dial pad in Teams. 
author: TobyTu
ms.author: kellybos
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: o365-proplus-itpro
localization_priority: Normal
ms.custom: 
- CI 112082
- CSSTroubleshoot
ms.reviewer: kellybos
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# Enterprise Voice users have no dial pad in Teams

## Symptom

Assume that a user has been moved to Teams Only mode. The user is enabled for Enterprise Voice, and is assigned the correct licenses. However, the user can’t see a dial pad in the **Calls** screen in Microsoft Teams. Therefore, this user cannot make outbound calls to external phone numbers.

## Cause

This issue occurs because the **OnlineVoiceRoutingPolicy** value isn't set correctly for the user.

## Solution

To fix this issue, Teams administrators should remove the value for **OnlineVoiceRoutingPolicy** for the user, and then set the correct value for the policy. For example, set the following value:

```powershell
Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName $Null
```

```powershell
Grant-CsOnlineVoiceRoutingPolicy -Identity "Ken Myer" -PolicyName "RedmondOnlineVoiceRoutingPolicy"
```

These actions force an update of the policy in the back-end environment of Teams. After this change is made, the user should see the dial pad appear under **Calls** within four hours.
