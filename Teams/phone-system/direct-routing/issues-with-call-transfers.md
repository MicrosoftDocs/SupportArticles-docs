---
title: Issues with call transfers
description: Troubleshoot issues affecting call transfers that are initiated by Microsoft.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 150733
  - CSSTroubleshoot
ms.reviewer: mikebis
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Issues that affect call transfers

This article focuses on how to troubleshoot issues that are related to call transfers that are initiated by Microsoft. This article does not apply to issues that are related to call transfers that are initiated from Session Border Controller (SBC) or Public Switched Telephone Network (PSTN) sources.

Call transfers that are initiated by Microsoft can occur in multiple scenarios, such as user-initiated call transfers, transfers from an auto attendant, and transfers from a call queue. Before you troubleshoot issues, review the following background information.

## Background

A call transfer can be made by using any of the following methods, in order of preference:

1. Using a Session Initiation Protocol (SIP) Refer message.  
1. Using an SIP Invite message that has a Replaces header. This method is mostly used for call queue responses.
1. Using an internal Microsoft Teams infrastructure. This method isn't visible to SBC. The method is used only if the first two methods are not supported.

All transfers that use an SIP Refer message must go through the Microsoft Teams infrastructure. When the Microsoft SIP proxy sends an SIP Refer message to SBC, an SIP Invite message should be returned to the SIP proxy, not to PSTN or to any other destination. It is true even if the call is transferred to an external PSTN number. SBC doesn't have to parse the SIP Refer message to look for the transfer target. SBC should send the SIP Invite message together with the Request-URI (RURI) setting only to contents of the Refer-To header. It also should include the Referred-By header from the SIP Refer message. Make sure that the strings of the SIP Invite message are not changed, and that they are sent as the exact same strings that are provided in the SIP Refer message (especially in the Referred-By header). This is because these strings are used to identify calls, targets, and other important parts of a call transfer.

**Note:** The strings could be either x-* strings or custom strings in the Referred-By and Refer-To headers.

## Auto attendant does not transfer calls to an external PSTN number

This issue might occur for the following reasons:  

- No licenses, or incorrect licenses, are assigned to the auto attendant. If you can transfer a call to an internal user or a bot, but if you can't transfer a call to an external PSTN number, this might indicate a licensing issue.
- The SIP Invite message is sent to an incorrect device. For example, the message is sent to a PSTN provider. By design, SIP Refer messages don't contain complete information about the target. For example, a PSTN number is normalized to the international format.

To resolve this issue, assign the correct license to the auto attendant to enable it to make PSTN calls. If the issue persists, make sure that the SIP Invite message is sent to the SIP proxy that can transfer calls appropriately. The SIP proxy sends the SIP Invite message to the PSTN network according to settings (such as normalization rules, SBC routing, caller ID).

## SIP Refer message doesn't contain a phone number or the phone number is incorrectly formatted

This behavior is by design. To work around this behavior, make sure that the SIP proxy sends the SIP Refer message to SBC. Then, configure SBC to copy the Referred-By and Refer-To strings to the SIP Invite message that will be sent back to the SIP proxy.

## No SIP Refer is coming from SIP proxy to SBC

To resolve this issue, follow these steps:

1. Make sure that the SIP Refer method is supported for call transfers by SBC in the SIP Invite or "SIP 200 OK" response (depending on whether the call is initiated by SBC or Microsoft). If the SIP Refer method isn't supported, then call transfers are made by using SIP Invite that has a Replaces header (if this method is supported). If the SIP Invite method doesn't work, the internal transfer that's hidden from SBC is used.
1. Make sure that the firewall and SBC settings allow incoming connections from any Microsoft signaling IP address, not only from specific addresses. SIP Refer can come from any of the IP addresses by using new TLS connection, even if the previous part of the call came from another IP address.

If SBC receives SIP Refer messages after you follow these steps, make sure that the new SIP Invite is delivered to the SIP proxy, even if the call is transferred to an external PSTN number. If the call is transferred to an external PSTN number, the SIP proxy will forward the call, and then send a new SIP Invite to SBC. In this case, make sure that the call doesn't fail on SBC. If this call fails and generates an error, this error will be sent back to SBC on the transferred call.

## Calls drop before the transfer is completed

This issue might occur for these reasons:

- The SIP proxy doesn't receive the "202 Accepted" response or "SIP Notify" messages from SBC as a response to the SIP Refer message, and the process times out.
- The "SIP Bye" message arrives from SBC too early, and the call ends before the message is fully transferred.

To resolve this issue, make sure that SBC sends the "SIP 202 Accepted" response and "SIP Notify" messages to provide an update about the progress of the transferred call. When the SIP proxy receives a "SIP Notify" message that includes the "200 OK" response, it will safely end the original call by sending the "SIP Bye" response because it knows that the call was replaced with a new call.

## No ringing sound when transferring calls

To resolve this issue, follow these steps:

1. Make sure that the SIP Refer method is supported by SBC in the initial SIP Invite or "SIP 200 OK" response (depending on whether the call is initiated by SBC or by Microsoft). SIP Refer is required to successfully generate the ringing sound. It is because, currently, no simulated ringing sound is generated when you transfer calls internally.
1. If SBC receives the SIP Refer message, but PSTN users still don't hear a ring tone, make sure that SBC connects to the newly initiated transfer call and plays a ring tone that's based on the "SIP 180 Ringing" or "SIP 183 Session" response that's sent from the SIP proxy.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
