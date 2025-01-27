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

You might experience various issues with inbound Direct Routing calls. This article describes some common issues and provides resolutions that you can try.

## No ringback tone when calling a Teams user by using PSTN

This issue is caused by inconsistent behavior of Public Switched Telephone Network (PSTN) carriers or devices when handling early media.

When Teams clients receive a call, they first send a SIP 180 Ringing message. Some Teams clients then engage in media negotiation and send a media (SDP) offer. In this scenario, the SIP proxy converts the SIP 180 message with SDP offer to a SIP 183 Session Progress message with SDP offer.

According to RFC 3261 and RFC 3960 standards, a SIP 180 Ringing message prompts the user agent (the device that initiates the call) to generate the ringing tone locally. And a SIP 183 Session Progress message with SDP offer indicates that early media (the ringing tone) might originate from the destination, which is the Teams client in this scenario.

When the user agent receives a SIP 183 message, some PSTN carriers or devices might expect to start receiving media from the destination and stop generating local ringing tones. This behavior causes the ringback tone to not play.

### Resolution

To fix this issue, update the SIP manipulation rules on your Session Border Controller (SBC) to change how SIP 183 messages are handled.

Here are some examples of how to solve the issue for the most common SBCs.

#### Audiocodes SBC

On AudioCodes SBCs, you can disable support for multiple SIP 18x messages by changing the following setting to **Not Supported**:

**SBC Early Media** > **Remote Multiple 18x**

This way, only the first SIP 18x message is forwarded, and any subsequent messages are ignored until the call is answered or ended. Forwarding only the first SIP 180 Ringing message helps avoid issues with SIP 183 Session Progress. For more information, see the [manual](https://techdocs.audiocodes.com/session-border-controller-sbc/mediant-software-sbc/user-manual/version-740/content/um/Interworking%20SIP%20Early%20Media.htm#:~:text=%E2%96%A0-,Multiple%2018x,-%3A%20The%20device) or contact Audiocodes support.

#### Metaswitch SBC

On Metaswitch SBCs, it's recommended to remove the SDP from the SIP 183 Session Progress message and change it to SIP 180 Ringing. For more details, see the [documentation](https://manuals.metaswitch.com/Perimeta/V5.5/MicrosoftTeamsIntegrationGuide/Source/Perimeta/References/MicrosoftTeamsIntegrationSignalingConfigurationForTeams.html#:~:text=profile%20DR_Teams%0A%20%20%20%20%20%20%20%20activate-,Configuration%20for%20pre%2DIMS%20deployments%20with%20a%20Class%205%20softswitch,-This%20configuration%20sets) or contact Metaswitch support.

#### Other SBCs

For most other SBCs, similar solutions can be implemented. Either disable forwarding SIP 183 Session Progress messages, or transform SIP 183 messages to SIP 180 and remove the SDP.

For detailed instructions on SIP manipulation rules configuration, refer to the documentation specific to your SBC model or contact your SBC vendor.

## Rejected calls keep ringing or multiple missed call notifications for a single call

This issue is caused by differences in the mapping of SIP response codes to Q.850 cause codes. Direct Routing uses the NICC standard ND1017:2006/07 to map SIP codes to Q.850 cause codes, instead of another commonly used standard RFC 4497.

For example, NICC maps SIP response code 486 to Q.850 cause code 34, while RFC 4497 maps SIP 486 to Q.850 cause code 17.  In this case, some PSTN providers interpret the end reason differently and retry calls. As a result, Microsoft treats these calls as multiple calls and shows multiple missed call notifications.

### Resolution

To fix this issue, follow these steps:

1. Update SIP manipulation rules on your SBC. Either remove the Q.850 cause code corresponding to SIP 486, or change the Q.850 cause code to 17. For detailed instructions on SIP manipulation rules configuration, refer to the documentation specific to your SBC model or contact your SBC vendor.
2. If the issue persists, it may be caused by the SBC, some network devices in the communication path, or your PSTN provider retrying the call on a SIP 4xx response code. Such behavior isn't recommended.

   To fix this behavior, use one of the following options:

   - Review your SBC configuration and make sure that it doesn't retry calls on SIP 4xx response codes.
   - Review your network device configuration and make sure that it doesn't retry calls on SIP 4xx response codes.
   - Contact your PSTN provider to check and update their configuration to avoid retrying calls on SIP 4xx response codes.

## Incorrect caller ID displayed for inbound calls

Typically, the caller ID is taken from the `From` header in the SIP INVITE message. However, some PSTN providers use the `P-Asserted-Identity` header instead. In this case, if the information in the `From` and `P-Asserted-Identity` headers doesn't match and the SBC doesn't rewrite the `From` header with the information from the `P-Asserted-Identity` header, then incorrect caller ID is displayed.

> [!NOTE]
> If the displayed caller ID is 266696687, it's because the `From` header contains "Anonymous", which is converted to a number.

## Resolution

To fix this issue, check whether your PSTN provider uses the `P-Asserted-Identity` header. If so, configure your SBC to rewrite the `From` header with the information from the `P-Asserted-Identity` header. For detailed instructions on SBC configuration, refer to the documentation specific to your SBC model or contact your SBC vendor.

## Incoming calls are marked as "Spam Likely"

This behavior is expected when [spam filtering for calls](/microsoftteams/configure-call-spam-filtering) is enabled.

To avoid a phone number being marked as spam, make sure that the number is in E.164 format.

## Incoming calls aren't blocked as expected

The issue is usually caused by a mismatch between the regular expression that's used for call blocking and the format of the caller's number that's displayed in Teams or the `From` header in the SIP message. For example:

- The number appears in international format, including an international prefix, while the regular expression expects a national format.
- Presence or absence of a leading plus (+) sign that doesn't match between the expression and the number format.

### Resolution

To fix this issue, update and test the regular expression to cover various number formats, especially if you use both Direct Routing and Calling Plans where numbers are presented differently.

For example, include the plus (+) sign as an optional character by using the following pattern:

\\+?  

## Delay when answering PSTN calls in Teams or no audio for the first few seconds

These issues are usually caused by multiple SIP reinvites between the SBC and the Microsoft SIP Proxy before the call is successfully established. This is particularly common in scenarios involving media bypass or Local Media Optimization, which require several reinvites by design. If these reinvites occur in the wrong order or take longer to process, it can cause audio delays. A common reason for these reinvites is the SBC doesn't offer the appropriate media IP in the original invite. For example, in a Local Media Optimization setup, the SBC sends an SDP message with an internal IP while the user is external, a reinvite is required to provide the correct external media IP.

### Resolution

To fix these issues, update your SBC configuration and make sure that the SBC offers the most likely media IP by default to minimize the number of reinvites. For example, if most calls are expected from internal users, configure the SBC to offer an internal IP initially. For detailed instructions on SBC configuration, refer to the documentation specific to your SBC model.

## Call drops after a certain amount of time

This issue can occur for various reasons, depending on how long the call stays connected before it drops.

### Call drops after approximately four seconds

This issue is usually caused by connectivity or communication issues between the SBC and the SIP proxy. For example:

- The SBC doesn't receive the SIP message because of firewall or other network issues.
- The SBC receives the SIP message but doesn't respond with a SIP ACK message.

#### Resolution

To fix this issue, update your SBC and network configuration to allow traffic to and from specific IP address ranges that are used by Microsoft for [SIP signaling](/microsoftteams/direct-routing-plan#sip-signaling-fqdns). In addition, make sure that the SBC sends messages according to standard SIP flows. For detailed instructions on SBC configuration, refer to the documentation specific to your SBC model.

### Call drops after approximately 10 to 20 seconds

If a call drops after about 10 to 20 seconds and there's no audio, it's usually caused by a media-related issue. For example, the ICE connectivity check fails, or no media is received during this time.

#### Resolution

To fix this issue, check whether correct ICE candidates are included in the SDP message from the SBC. If necessary, update the network configuration to correctly handle ICE candidates requests and responses, and media traffic. For detailed instructions on SBC configuration, refer to the documentation specific to your SBC model.

### Call works correctly and drops after several minutes without error

This issue is usually caused by the session timer or session refresh mechanism that's specified in the `SESSION-EXPIRES` header of the SIP INVITE message. For example, the following `SESSION-EXPIRES` header specifies that the call will end after 1,800 seconds (30 minutes) unless the user agent client, which is the party that sends the SIP INVITE message, sends a reinvite to refresh the session before the timer expires.

`SESSION-EXPIRES : 1800;refresher=uac`

> [!NOTE]
>
> - Reinvites are usually sent at half the time specified by the session timer.
> - If the refresher value is `uas` in the header, the party that receives the SIP INVITE message is responsible for sending the reinvite to refresh the session.

#### Resolution

To fix this issue, check and update your Direct Routing configuration to make sure that the responsible party correctly sends a reinvite message before the session timer expires.

> [!NOTE]
> Session timer issues might also occur in other parts of the call, such as the PSTN. In this case, the SBC receives a SIP BYE message from the PSTN, and the message is then sent to the SIP proxy, causing the call to end.
>
> To fix this issue in such cases, determine the source of the SIP BYE message and resolve the issue at the source.
