---
title: Issues with call transfers
description: Troubleshoot issues related to call transfers initiated from Microsoft side.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 150733
- CSSTroubleshoot
ms.reviewer: mikebis
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# Issues with call transfers

This article focuses on troubleshooting issues related to call transfers initiated from Microsoft side. This article is not applicable for issues related to call transfers initiated from Session Border Controller (SBC) or Public Switched Telephone Network (PSTN) side.  

Call transfers initiated from Microsoft side occur in different scenarios, such as user-initiated call transfers, transfers from an auto attendant, transfers from a call queue and so on. Before you troubleshoot the issues, take a look at the following background information.

## Background

Basically, a call transfer can happen by using one of the following methods, ordered by preference:

1. Using a Session Initiation Protocol (SIP) Refer message.  
1. Using a SIP Invite message with a Replaces header. This way is mostly used for call queue answers.
1. Using internal Microsoft Teams infrastructure. This way isn't visible to SBC, and it's only used if the previous two methods are not supported.

All transfers that use a SIP Refer message must go through Microsoft Teams infrastructure. When Microsoft SIP Proxy sends a SIP Refer message to SBC, a SIP Invite message should go back to the SIP Proxy, not to PSTN or to any other destination, even if the call is transferred to an external PSTN number. SBC doesn't have to parse the SIP Refer message to look for the transfer target. SBC should only send the SIP Invite message with the Request-URI (RURI) setting to contents of the Refer-To header and include the Referred-by header from the SIP Refer message. Make sure the strings of the SIP Invite message are not manipulated and are sent exactly as the strings provided in the SIP Refer message (especially in the Referred-by header), because these strings are used to identify calls, targets, and other important parts of a call transfer.

**Note:** The strings could be either x-* strings or custom strings in the Referred-by and Refer-to headers.

## Auto attendant fails to transfer calls to an external PSTN number

This issue might occur for these reasons:

- No licenses or incorrect licenses are assigned to the auto attendant. If you can transfer a call to an internal user or a bot, but if you can't transfer a call to an external PSTN number, this issue might occur due to licenses.  
- The SIP Invite message is sent to a wrong device, for example to a PSTN provider. By design, SIP Refer message doesn't contain complete information about the target (for example, a PSTN number is normalized to the international format).

To resolve this issue, assign the correct license to the auto attendant to make PSTN calls. If the issue isn't resolved, make sure the SIP Invite message is sent to the SIP Proxy that can transfer calls appropriately. The SIP Proxy will send the SIP Invite message to the PSTN network according to settings (normalization, correct SBC routing, caller ID, and so on).

## SIP Refer message doesn't contain a phone number or the phone number is in an incorrect format

This behavior is by design. To fix this issue, make sure that the SIP Proxy sends the SIP Refer message to SBC and then SBC must copy the Referred-By and Refer-To strings to the SIP Invite message that will be sent back to the SIP Proxy.

## No SIP Refer is coming from SIP Proxy to SBC

To resolve this issue, follow these steps:

1. Make sure the SIP Refer method is supported for call transfers by SBC in the SIP Invite or SIP 200OK (depending on if the call is initiated from SBC or Microsoft side). If the SIP Refer method isn't supported, SIP Invite with a Replaces header (if this method is supported) is used for call transfers. If the SIP Invite method doesn't work, the internal transfer that's not visible to SBC will be used.
1. Make sure that the firewall and SBC settings allow incoming connections from any Microsoft signaling IP address, not only specific ones. SIP Refer can come from any of the IP addresses by using new TLS connection, even if the previous part of the call came from another IP address.

After doing the above steps, if SBC receives SIP Refer, make sure the new SIP Invite is coming to the SIP Proxy, even if the call is transferred to an external PSTN number. If the call is transferred to an external PSTN number, the SIP Proxy will forward the call and send a new SIP Invite to SBC. In this case, make sure the call doesn't fail on SBC. If this call fails with an error, this error will be forwarded back to SBC on the transferred call.

## Calls drop before the transfer is completed

This issue might occur for these reasons:

- The SIP Proxy doesn't receive 202 Accepted or SIP Notify messages from SBC as an answer to SIP Refer and it's timeout.
- The SIP Bye message comes from SBC too early and ends the call before it's fully transferred.

To resolve this issue, make sure that SBC sends SIP 202 Accepted and SIP Notify messages to update on the progress of the transferred call. When the SIP Proxy receives SIP Notify with "200 OK", it will safely end the original call with SIP Bye, knowing the call was replaced with a new call.

## No ringing sound when transferring calls

To resolve this issue, follow these steps:

1. Make sure the SIP Refer method is supported by SBC in the initial SIP Invite or SIP 200OK (depending on if the call is initiated from SBC or Microsoft side). SIP Refer is required for ringing sound to work, as currently there is no fake ringing sound generated when transferring calls internally.
2. If SBC receives SIP Refer, but there is still no ringing sound for PSTN users, make sure that SBC connects to the newly initiated transfer call and plays the ringing sound based on the SIP 180 Ringing or SIP 183 Session progress message that's sent from the SIP Proxy.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
