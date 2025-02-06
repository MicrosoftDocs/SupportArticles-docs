---
title: Issues that affect inbound Direct Routing calls
description: Describe issues that affect inbound calls when you use Direct Routing and provide resolutions.
ms.date: 01/27/2025
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
  - CI 3294
  - CSSTroubleshoot
ms.reviewer: mikebis
---

# Issues that affect inbound Direct Routing calls

You might experience issues when you receive Public Switched Telephone Network (PSTN) calls through Direct Routing. This article describes some of these issues and provides resolutions that you can try.

## No ringback tone when Teams receives a call from a PSTN endpoint

This issue occurs in the following scenario:  

When a Microsoft Teams client receives a call, it first sends a SIP 180 Ringing message and follows that with a SIP 183 Session Progress message with media offer (SDP).  

According to RFC 3261 and RFC 3960 standards, when the endpoint used by the caller receives a SIP 180 Ringing message, it must generate the ring tone locally. If the caller's device receives a SIP 183 Session Progress message with SDP, it allows the destination (the Teams client in this scenario) to play audio or a ring tone, also known as early media.  

However, some caller devices and carriers stop generating the ring tone locally when they receive a SIP 183 Session Progress message, even though they should continue to do so until the actual media packets are received.

### Resolution

To fix the issue, you need to update the SBC configuration to handle multiple SIP 18x messages.  

Most SBCs offer one of the following mitigation options:

- Forward only the first SIP 18x message and ignore subsequent messages until the call is answered or ended. This option is offered by AudioCodes SBCs for example.
- Remove the SDP information from the SIP 183 Session Progress message and change it to an SIP 180 Ringing message. This option is offered by Metaswitch SBCs for example.

For instructions to update the SIP manipulation rules in your SBC, refer to the documentation that's specific to your SBC model and contact your SBC vendor for other recommended options.

## Multiple notifications about missed calls

When Teams receives a call and rejects it because the user is busy or doesn't want to accept the call at that time, the PSTN carrier or SBC might retry the call multiple times. Teams interprets each of the re-tried calls as separate calls and displays multiple missed call notifications.

This issue occurs because different communication standards such as RFC 4497 standard and NICC standard ND1017:2006/07 map the same SIP response code to different Q.850 cause codes.

For example, RFC 4497 maps SIP response code 486 to Q.850 cause code 34 while ND1017:2006/07, which Direct Routing uses, maps it to Q.850 cause code 17. Because of this difference, the PSTN providers which use the RFC 4497 standard interpret the reason for Teams rejecting the call incorrectly and retry the call multiple times.

### Resolution

To fix the issue, update the SIP manipulation rules in your SBC to either remove the Q.850 cause code that’s mapped to SIP response code 486, or change the cause code from 34 to 17. Refer to the documentation that's specific to your SBC model for instructions to update the SIP manipulation rules.  

If updating the rules doesn't fix the issue, then it's likely that either the SBC, a network device in the communication path, or your PSTN provider is retrying the call after receiving a SIP 4xx response code. This behavior isn't recommended. In this situation, update the configuration of the SBC, the network devices, or contact the PSTN provider to update their configuration to ensure that they don't retry a call after they receive a SIP 4xx response to end the call.

## Incorrect caller ID (CLI) is displayed for inbound calls

When Teams receives a call, it displays the caller's number that is specified in the `From` header in the SIP INVITE message. However, some PSTN providers might use the `P-Asserted-Identity` header to store the caller's number instead of the `From` header. In this situation, the information displayed to the Teams user is incorrect.

### Resolution

To fix this issue, check whether your PSTN provider uses the `P-Asserted-Identity` header. If so, configure your SBC to rewrite the content of the `From` header with the information from the `P-Asserted-Identity` header.

Refer to the documentation that's specific to your SBC model for instructions to rewrite the From header.

> [!NOTE]
> If the `From` header contains "Anonymous" as its information, Teams sometimes converts it to a number and displays *266696687* instead.

## Incoming calls are marked incorrectly as "Spam Likely"

When [spam filtering for calls](/microsoftteams/configure-call-spam-filtering) is enabled, the caller IDs of all incoming calls are checked and assigned a spam score. If the score for a caller ID is higher than a specific threshold, Teams displays a notification that the call might be spam.

### Resolution

To increase the reliability of a caller's phone number not being marked as spam, make sure that it's provided in the E.164 format.

## Incoming calls aren't blocked as expected

You've configured Teams to block calls from caller IDs that satisfy pre-defined specific criteria. However, you continue to receive calls from such phone numbers.  

This issue is usually caused by a mismatch between the caller ID format that's expected by the expression that's used to screen incoming calls and the format of the caller ID in the `From` header of the SIP message.

For example, the caller ID might be specified in an international format, including a leading plus (+) sign and an international prefix, while the expression only checks for numbers that are specified in the national format. The situation might also be reversed.  

### Resolution

To fix this issue, update the expression that's used to check incoming calls by adding the plus (+) sign as an optional character. This updated expression covers multiple caller ID formats and is especially useful if you use both Direct Routing and Calling Plans in which numbers are presented in different formats.

## Delay when answering PSTN calls in Teams

When Teams receives a call from a PSTN endpoint, there's either a delay in answering the call or there’s no audio for a few seconds after Teams answers the call.  

These issues are usually caused by multiple SIP re-invites that are sent between the SBC and the SIP Proxy before the call is connected successfully. This is particularly common in scenarios that involve media bypass or Local Media Optimization, which require several re-invites by design. In addition to these re-invites, if there's a situation such as when the SBC doesn't offer the appropriate media IP in the original invite, then it needs to send a re-invite with the correct information. If the re-invite from the SBC is received by the SIP Proxy in the wrong order or at the wrong time (which will cause a race condition), it can take longer to be negotiated and that can cause audio delays.

### Resolution

To fix these issues, update your SBC configuration and make sure that it offers the most likely media IP by default to minimize the number of reinvites. For example, if most calls are expected from internal users, configure the SBC to offer an internal IP first. For detailed instructions on SBC configuration, refer to the documentation that's specific to your SBC model.

## Calls drop after a specific duration

In Teams, calls that are in progress as well as incoming calls that are still trying to connect can drop for various reasons.

Based on the length of time after which a call drops, try the resolutions that work for your scenario.

### Calls drop after about four seconds

This issue is usually caused by poor connectivity or a communication issue between the SBC and the SIP proxy. For example:

- TThe SBC might not receive the SIP 100 Trying message because the message is blocked by a firewall or not sent because of network issues.
- The SBC receives the SIP message but doesn't acknowledge it by sending a SIP ACK message.

#### Resolution

To fix this issue, update your SBC and network configuration to allow traffic to and from all IP address ranges that the Direct Routing feature uses for [SIP signaling](/microsoftteams/direct-routing-plan#sip-signaling-fqdns). In addition, make sure that the SBC sends messages according to the standard process that's used to communicate SIP signals.

For detailed instructions on SBC configuration, refer to the documentation that's specific to your SBC model.

### Calls drop after approximately 10 to 20 seconds

If an incoming call drops between 10 and 20 seconds of trying to connect, and there's no audio, the reason might be that either no media information was received in that timeframe, or the Interactive Connectivity Establishment (ICE) connectivity checks failed, and Teams dropped the call.

#### Resolution

To fix this issue, make sure that the correct ICE candidates are included in the SDP message from the SBC. Also update the network and firewall configurations as appropriate to make sure that they can handle the requests and responses from ICE candidates.

### Calls drop after several minutes

An ongoing Teams call might drop without an error code after connecting and proceeding between 10 and 60 minutes. This scenario might occur if there's an issue with the session timer or session refresh mechanism that's specified in the `SESSION-EXPIRES` header of the SIP INVITE message. The call is scheduled to end after the time that's specified in the SESSION-EXPIRES header unless a re-invite is sent to refresh the session before the time ends.

In the following example, the `SESSION-EXPIRES` header specifies that the call will end after 1,800 seconds (30 minutes):

`SESSION-EXPIRES : 1800;refresher=uac`

> [!NOTE]
>
> - Reinvites are usually sent at the halfway point of the time that's specified by the session timer.
> - If the value of the `refresher` parameter in the header is `uac`, the party that sends the SIP INVITE message is responsible for sending the reinvite to refresh the session.
> - If the value of the `refresher` parameter in the header is `uas`, the party that receives the SIP INVITE message is responsible for sending the reinvite to refresh the session.

#### Resolution

To fix this issue, update your SBC configuration to make sure that the correct party sends a reinvite message at the appropriate time before the session timer expires.

Session timer issues might also occur in other parts of the call, such as a PSTN carrier in the communication path. If the call fails at a PSTN carrier, it sends a SIP BYE message to the SBC. This message is then sent to the SIP proxy which ends the call. To fix this issue, determine the source of the SIP BYE message and resolve the issue at the source.
