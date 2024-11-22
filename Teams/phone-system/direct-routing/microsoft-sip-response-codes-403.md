---
title: SIP 403 and Microsoft response codes
description: Lists combinations of Microsoft response codes and the SIP 403 error, and provides actions to resolve the errors.
ms.date: 11/22/2024
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)\Direct Routing
  - CI173631
  - CI2381
  - CSSTroubleshoot
ms.reviewer: teddygyabaah
---

# SIP response code 403

This article provides troubleshooting information for various combinations of the SIP 403 error and Microsoft response codes.

## 10199 403 Call rejected as private calling is disabled for the callee

- Microsoft response code: **10199**
- SIP response code: **403**
- Suggested actions:  
  - In the calling policy that's assigned to the affected user, turn on the [Make private calls](/MicrosoftTeams/teams-calling-policy#make-private-calls) setting.

## 10500 403 Current call site state prevents fork to this entity

- Microsoft response code: **10500**
- SIP response code: **403**
- Suggested actions:  
  - Verify that [Location-Based Routing](/microsoftteams/location-based-routing-plan) is set up correctly, and fix any misconfigurations.  

## 10553 403 Participant call leg has been canceled because an invite to a required recorder failed

- Microsoft response code: **10553**
- SIP response code: **403**
- Suggested actions:  
  - Verify that [compliance recording](/microsoftteams/teams-recording-policy) is set up correctly, including provisioning of the recorder bot.
  - Work with the compliance recording partner who provides the recorder service to check why the bot can't be invited.
  
## 510532 403 Get Inbound Direct Routing - RuntimeApi trunk config not found for customer

- Microsoft response code: **510532**
- SIP response code: **403**
- Suggested actions:  
  - Verify the trunk (gateway) configuration for the specific tenant, and make sure that it's set up correctly. For more information about call routing configuration, see [Configure call routing for Direct Routing](/microsoftteams/direct-routing-voice-routing).

## 510532 403 No trunk config was found

- Microsoft response code: **510532**
- SIP response code: **403**
- Suggested actions:  
  - Verify that the calls are sent from the correct Session Border Controller (SBC) Fully Qualified Domain Name (FQDN) that's associated with your tenant. Also, verify that the FQDN in the Contact header of the SIP INVITE message is registered under your tenant.

## 510534 403 Get Inbound Direct Routing - blocked calling number for customer

- Microsoft response code: **510534**
- SIP response code: **403**
- Suggested actions:  
  - Check the [inbound call blocking settings](/microsoftteams/block-inbound-calls) for blocked caller numbers.

## 510546 403 Get Outbound Direct Routing - no trunk config found by LBR selection criteria

- Microsoft response code: **510546**
- SIP response code: **403**
- Suggested actions:  
  - If you use [Location-Based Routing](/microsoftteams/location-based-routing-plan) for Direct Routing, check the settings to determine whether toll bypass is restricted for the affected user's location. If it is, this error is expected and no action is required. Otherwise, fix any misconfiguration.
  - If you don't use Direct Routing, check whether the [PreventTollBypass](/powershell/module/teams/set-csteamscallingpolicy?view=teams-ps#-preventtollbypass&preserve-view=true) setting in your Teams calling policy is set to **True**. To check the setting, run the following PowerShell command and look for the **PreventTollBypass** setting in the result:

    ```powershell
    Get-CsTeamsCallingPolicy -Identity <PolicyName>
    ```

    If its value is **True**, run the [Set-CsTeamsCallingPolicy](/powershell/module/teams/set-csteamscallingpolicy?view=teams-ps&preserve-view=true) PowerShell command to set it to **False**:

    ```powershell
    Set-CsTeamsCallingPolicy -Identity <PolicyName> -PreventTollBypass $false
    ```

## 510560 403 User is not Enterprise Voice enabled

- Microsoft response code: **510560**
- SIP response code: **403**
- Suggested actions:  
  - Verify that the affected user is assigned a Phone System license, and [enable Enterprise Voice for the user](/microsoftteams/direct-routing-enable-users).

## 510560 403 User is not Enterprise Voice enabled. User is not allowed to make user based dial out

- Microsoft response code: **510560**
- SIP response code: **403**
- Suggested actions:  
  - Verify that the affected user is assigned a Phone System license, and [enable Enterprise Voice for the user](/microsoftteams/direct-routing-enable-users).

## 510562 403 User is not allowed to make outbound PSTN Calls

- Microsoft response code: **510562**
- SIP response code: **403**
- Suggested actions:  
  - Verify that the affected user is assigned a Phone System license and is correctly [enabled for Direct Routing](/microsoftteams/direct-routing-enable-users). For more information about issues with outbound calls, see [Issues that affect outbound Direct Routing calls](/microsoftteams/troubleshoot/phone-system/direct-routing/issues-with-outbound-calls).

## 510563 403 User is only allowed to make domestic calls. This is an international call

- Microsoft response code: **510563**
- SIP response code: **403**
- Suggested actions:  
  - Check whether the user is limited to making only domestic calls.

## 560403 403 Forbidden; Call rejected

- Microsoft response code: **560403**
- SIP response code: **403**
- Suggested actions:  
  - Check the logs on the SBC to investigate why the call was rejected.

## 510559 403 Get Outbound routing - No viable path (Forbidden)

- Microsoft response code: **510559**
- SIP response code: **403**
- Suggested actions:  
  - Make sure that the dialed number in Teams matches a corresponding number pattern in a voice route for the given user. In some cases, this error occurs because an incorrect number is dialed, or the customer's own internal policy prevents calls to specific country/region, or number patterns.
