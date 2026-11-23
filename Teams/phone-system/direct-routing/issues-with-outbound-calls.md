---
title: Resolve issues with outbound calls
description: Describes outbound call issues in Microsoft Teams Direct Routing, including wrong caller ID and SBC failures. Also provides resolutions to restore calling.
ms.date: 11/23/2026
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: mikebis, v-kccross, v-gsitser
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ai-usage: ai-assisted
ms.custom: 
  - sap:Teams Calling\Direct Routing
  - CI 126689
  - CSSTroubleshoot
  - scenario:Direct-Routing-3
---

# Resolve issues that affect outbound Direct Routing calls

[!INCLUDE [Teams Direct Routing note](../../../includes/teams-direct-routing-note.md)]

## Summary

When you use Microsoft Teams Direct Routing for outbound calls, recipients might see the wrong caller ID, calls might fail to connect to the session border controller (SBC), or some or all users might be unable to call. These issues can result from Session Initiation Protocol (SIP) header mismatches, SBC or network connectivity problems, incorrect user provisioning, voice routing policies, or a disabled gateway. This article explains how to check each cause and apply the corresponding resolution.

## Symptoms

The following sections describe common scenarios and troubleshooting steps for outbound calls from a Microsoft Teams client through Direct Routing to a Session Border Controller (SBC):

- An incorrect caller ID is displayed to the call recipient.
- A connection to the SBC isn't established.
- Some users in a tenant can't make calls.
- No users in a tenant can make calls.

This article discusses potential causes of these issues, and provides resolutions that you can try.

## Incorrect caller ID displayed to the recipient

When you use Direct Routing, the caller ID information that is delivered to the call recipient is listed in the `From` and `P-Asserted-Identity` headers in the SIP INVITE message.

The `From` header contains the number that should be displayed and can be one of the following, depending on the scenario and settings:

- The phone number that's assigned to the Teams user or app that is initiating the call.
  If the caller's phone number has to be hidden from the call recipient, it's replaced with "anonymous". This can result from an assigned caller ID policy, the user's Teams client settings, or the absence of an assigned phone number.
- A resource number that you assign to the caller by using the `New-CsCallingLineIdentity` and `Grant-CsCallingLineIdentity` cmdlets.
- The phone number of the original caller if the call was forwarded.

The `P-Asserted-Identity` header contains the phone number of the user who is billed for the call. If `Privacy:id` is set, this setting indicates that the information in the header has to be hidden from the call recipient.

### Cause

If the information in the `From` and `P-Asserted-Identity` headers doesn't match, and if the public switched telephone network (PSTN) prioritizes the `P-Asserted-Identity` header information over the `From` header information, then incorrect information might be displayed.

### Resolution

To ensure that the correct caller ID is displayed to the call recipient, configure the SBC to either remove the `P-Asserted-Identity` header from the SIP INVITE message or modify its contents.

## Outbound calls fail after reaching the SBC

Sometimes, calls reach the SBC but aren't established. In this situation, when the SBC receives a SIP INVITE message from Teams, it returns a failure message that includes error codes in the range of 400 to 699.

The following causes might prevent call establishment.

### Cause 1

An SBC or another device on your network generates the SIP failure message.

### Resolution 1

Troubleshoot the device that returns the error. If you need assistance, contact the device vendor.

### Cause 2

Your PSTN provider is experiencing an issue and sends the SIP failure message.

### Resolution 2

Inspect the SIP trace. If you see the failure originating from the PSTN network, contact your PSTN provider for assistance.

## Some users can't make outbound calls

If the connection between the Teams SIP proxy and the SBC is working correctly, but some users can't make calls, incorrect settings or incorrect provisioning might cause the problem.

### Cause 1

Users are missing the dial pad on the **Calls** tab in Teams.

### Resolution 1

Ensure that the user has the [required licenses](/microsoftteams/direct-routing-plan#licensing-requirements) and all required settings. To check the settings, run the [Get-CsOnlineUser](/powershell/module/skype/get-csonlineuser) cmdlet in Teams PowerShell, as follows:

```powershell
Get-CsOnlineUser -Identity <UserId> | fl Identity,EnterpriseVoiceEnabled,HostedVoiceMail,OnPremLineURI
```

The required values are described in [Enable users for Direct Routing, voice, and voicemail](/microsoftteams/direct-routing-enable-users).

### Cause 2

None of the patterns in the voice routes available through the user's Online Voice Routing Policy (OVRP) match the number that was dialed by the user.

### Resolution 2

Ensure that the following conditions are true:

- The user's effective OVRP, whether explicitly assigned or inherited from the global policy, contains a valid PSTN Usage record.
- There is a pattern in the voice route that matches the dialed number.
- The PSTN Usage in the voice route matches the one that's set up for the specific user through their OVRP.
- The gateway that's specified for the [SBC exists, is enabled, and is reachable](/microsoftteams/direct-routing-connect-the-sbc).

### Cause 3

The voice routing configuration contains invalid characters.

### Resolution 3

Invalid or invisible characters can be introduced into voice routing configuration when you paste information from rich-text editors. Invisible characters aren't displayed but can still affect route matching.

To fix the issue, identify the invalid or invisible character by using a tool that reveals hidden characters and character codes, remove the affected configuration, and then re-create it by either entering the configuration manually or copying it from a plain-text editor, such as Notepad.

## No users can make outbound calls

If users can't make calls, the calls might not reach the SBC. Check the following possible causes.

### Cause 1

The gateway for outbound calls is disabled.

### Resolution 1

Use the Microsoft Teams admin center to ensure that the gateway Teams uses is available and enabled.

You can also use PowerShell cmdlets to check and update the gateway, as necessary.

To check the status of the gateway, run the [Get-CsOnlinePSTNGateway](/powershell/module/skype/get-csonlinepstngateway) cmdlet. The output must show that the value of the `Enabled` property is set to `True`. In the following example, the `Enabled` property is set to `True` for the `sbc1.contoso.com` gateway but not for the `sbc2.contoso.com` gateway.

```powershell
Get-CsOnlinePSTNGateway | fl Identity,Fqdn,SipSignalingPort,MaxConcurrentSessions,Enabled
```

:::image type="content" source="media/issues-with-outbound-calls/gateway-status-1.png" alt-text="Screenshot of the PowerShell output that shows the sbc2.contoso.com gateway Enabled property set to False.":::

To enable the `sbc2.contoso.com` gateway in Teams, run the [Set-CsOnlinePSTNGateway](/powershell/module/skype/set-csonlinepstngateway) cmdlet to set the `Enabled` parameter to `True`.

```powershell
Set-CsOnlinePSTNGateway -Identity "sbc2.contoso.com" -Enabled $true
```

To verify that the `sbc2.contoso.com` gateway is now enabled, run the `Get-CsOnlinePSTNGateway` cmdlet again:

```powershell
Get-CsOnlinePSTNGateway -Identity "sbc2.contoso.com" | fl Identity,Fqdn,SipSignalingPort,MaxConcurrentSessions,Enabled
```
:::image type="content" source="media/issues-with-outbound-calls/gateway-status-2.png" alt-text="Screenshot of the PowerShell output that shows the sbc2.contoso.com gateway Enabled property set to True.":::

For more information, see [Connect your SBC to Direct Routing](/microsoftteams/direct-routing-connect-the-sbc).

### Cause 2

The gateway doesn't respond to SIP requests because a device on the network, such as a firewall, blocks the messages.

### Resolution 2

Ensure that you [allow SIP signaling IP addresses and FQDNs](/microsoftteams/direct-routing-plan#sip-signaling-fqdns) on all network devices that connect the SBC to the internet. You can find the IP addresses that you need to allow in [SIP Signaling: FQDNs](/microsoftteams/direct-routing-plan#sip-signaling-fqdns).
