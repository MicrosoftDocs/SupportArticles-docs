---
title: Issues with call transfers
description: Troubleshoot issues affecting call transfers that are initiated by Microsoft.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Calling (PSTN)\Direct Routing
  - CI 150733
  - CSSTroubleshoot
ms.reviewer: mikebis
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 08/31/2026
---
# Issues that affect call transfers

[!INCLUDE [Teams Direct Routing note](../../../includes/teams-direct-routing-note.md)]

## Summary

This article describes how to resolve issues that are related to call transfers initiated by Microsoft. It doesn't apply to issues that are related to call transfers initiated from Session Border Controller (SBC) or Public Switched Telephone Network (PSTN) sources. 

The issues discussed in the article include auto attendant not transferring calls to an external PSTN number, SIP REFER method not sent from the SIP proxy to the SBC, and calls dropping before the transfer is complete.

## Call transfer methods

Here's a quick review of call transfer methods. A call transfer can be initiated by using any of the following methods, in order of preference:

1. A Session Initiation Protocol (SIP) REFER method.  
1. A SIP INVITE method that has a Replaces header. This method is mostly used for call queue responses.
1. An internal Microsoft Teams infrastructure. This method isn't visible to SBC. The method is used only if the first two methods are not supported.

All call transfers that use a SIP REFER method must use the following process:

1. The transfers go through the Microsoft Teams infrastructure. The transferee might hear an international ringtone.
1. When the Microsoft SIP proxy sends a SIP REFER request to the SBC, a new SIP INVITE request is returned to the SIP proxy, not to the PSTN or to any other destination. This requirement is necessary even if the call is transferred to an external PSTN number.
1. The SBC sends the SIP INVITE request with the Request-URI (R-URI) set only to the string listed in the Refer-To header. 
1. The SIP INVITE request includes the Referred-By header from the SIP REFER request. 
1. The exact strings from the SIP REFER request and in the Refer-To and Referred-By headers are added to the SIP INVITE request and not changed before being sent. This detail is important because these strings are used to identify calls, targets, and other important parts of a call transfer. The strings in the Referred-By and Refer-To headers can be either x-* strings or custom strings.

## Auto attendant doesn't transfer calls to an external PSTN number

This issue might occur for the following reasons:  

- No licenses, or incorrect licenses, are assigned to the auto attendant. If you can transfer a call to an internal user or a bot, but if you can't transfer a call to an external PSTN number, this might indicate a licensing issue.
- The SIP INVITE request is sent to an incorrect device. For example, the request is sent to a PSTN provider. By design, SIP REFER requests don't contain complete information about the target. For example, a PSTN number is normalized to the international format.

To resolve this issue, assign the correct license to the auto attendant to enable it to make PSTN calls. If the issue persists, make sure that the SIP INVITE request is sent to the SIP proxy that can transfer calls appropriately. The SIP proxy sends the SIP INVITE request to the PSTN network based on the settings for normalization rules, SBC routing, and caller ID.

## The SIP REFER request doesn't contain a phone number or the phone number is incorrectly formatted

This behavior is by design. To work around this behavior, make sure that the SIP proxy sends the SIP REFER request to the SBC. Then, configure the SBC to copy the Referred-By and Refer-To strings to the SIP INVITE request that will be sent back to the SIP proxy.

## No SIP REFER received by the SBC from the SIP proxy

To resolve this issue, follow these steps:

1. Make sure that the SIP REFER method is supported for call transfers by the SBC in the SIP INVITE request or SIP 200 OK response, depending on whether the call is initiated by the SBC or by Microsoft. If the SIP REFER method isn't supported, then call transfers are made by using the SIP INVITE that has a Replaces header, provided this method is supported. If the SIP INVITE method doesn't work, the internal transfer that's hidden from the SBC is used.
1. Make sure that the firewall and SBC settings allow incoming connections from any Microsoft signaling IP address, and not from specific addresses only. The SIP REFER request can come from any of the IP addresses by using a new TLS connection, even if the previous part of the call came from another IP address.

If the SBC receives the SIP REFER request after you follow these steps, make sure that the new SIP INVITE request is delivered to the SIP proxy, even if the call is transferred to an external PSTN number. If the call is transferred to an external PSTN number, the SIP proxy will forward the call and then send a new SIP INVITE to the SBC. In this scenario, make sure that the call doesn't fail on the SBC. If this call fails and generates an error, this error will be sent back to the SBC on the transferred call.

## Calls drop before the transfer is completed

This issue might occur for one of the following reasons:

- The SIP proxy doesn't receive the SIP 202 Accepted response or SIP NOTIFY requests from the SBC as a response to the SIP REFER request, and the process times out.
- The SIP BYE request from the SBC arrives too early, and the call ends before the transfer is completed fully.

To resolve this issue for a consultative transfer, make sure that SBC sends the SIP 202 Accepted response and SIP NOTIFY requests to provide an update about the progress of the transferred call. When the SIP proxy receives a SIP NOTIFY request that includes the SIP 200 OK payload, it will safely end the original call by sending the SIP BYE request because it knows that the call was replaced with a new call.

For blind transfers that are made without consultation, the behavior changed in June 2026. Refer to Message Center post MC1296872 for more information. The call is now terminated by Microsoft immediately after the transfer is accepted by the SBC, without waiting for the final result of the transfer. To resolve issues with blind transfers, review the SBC configuration and make sure it is correctly configured to support this behavior.

## No ringing sound when transferring calls

To resolve this issue, follow these steps:

1. Make sure that the SIP REFER method is supported by the SBC in the initial SIP INVITE request or SIP 200 OK response, depending on whether the call is initiated by the SBC or by Microsoft. The SIP REFER method is required to generate the ringing sound successfully because no simulated ringing sound is generated when you transfer calls internally.
1. If the SBC receives the SIP REFER request, but PSTN users still don't hear a ring tone, make sure that the SBC connects to the newly initiated transfer call and plays a ring tone that's based on the SIP 180 Ringing or SIP 183 Session Progress response which is sent from the SIP proxy.
