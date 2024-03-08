---
title: Email non-delivery report (NDR) and SMTP errors in Exchange Online
ms.date: 03/08/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six
audience: Admin
ms.topic: troubleshooting
ms.localizationpriority: high
f1.keywords:
- CSH
ms.custom: 
- Exchange Online
- CSSTroubleshoot
- CI 167832
- CI 179631
search.appverid:
- MET150
- MOP150
ms.assetid: 51daa6b9-2e35-49c4-a0c9-df85bf8533c3
description: Admins can learn about SMTP errors and non-delivery reports (also known as NDRs or Bounce Messages) that are generated in Exchange Online.
---

# Email non-delivery reports and SMTP errors in Exchange Online

When there's a problem delivering an email message that you sent, Microsoft 365 or Office 365 will generate an error code and often will send an email to let you know. The email you receive is a delivery status notification, also known as a DSN or Bounce Message. The most common type is called a non-delivery report (NDR) and they tell you that a message wasn't delivered. Non-delivery can be caused by something as simple as a typo in an email address. NDRs include an error code that indicates why your email wasn't delivered, solutions to help you get your email delivered, a link to more help on the web, and technical details for administrators. Find out [What's included in an NDR?](#whats-included-in-an-ndr).

## Find my error code and get help delivering my email

The following table contains the error codes (also known as enhanced status codes) for the most common Bounce Messages and errors that you might encounter in Exchange Online.

|Error code|Description|Possible cause|Additional information|
|---|---|---|---|
|432&nbsp;4.3.2|`STOREDRV.Deliver; recipient thread limit exceeded`|The recipient mailbox's ability to accept messages is being throttled because it's receiving too many messages too quickly. This is done so a single recipient's mail processing doesn't unfairly impact other recipients sharing the same mailbox database.|For more information about this by-design throttling, see [Store Driver Fault Isolation Improvements in Exchange 2010 SP1](https://techcommunity.microsoft.com/t5/exchange-team-blog/store-driver-fault-isolation-improvements-in-exchange-2010-sp1/ba-p/586093).|
|4.4.316|`Connection refused [Message=Socket error code 10061]`|Microsoft 365 or Office 365 is trying to send a message to an email server outside of Microsoft 365 or Office 365, but attempts to connect to it are failing due to a network connection issue at the external server's location.|This error almost always indicates an issue with the receiving server or network outside of Microsoft 365 or Office 365. The error should also include the IP address of the server or service that's generating the error, which you can use to identify the party responsible for fixing this.|
|4.4.7|`Message expired`|The message in the queue has expired. The sending server tried to relay or deliver the message, but the action wasn't completed before the message expiration time occurred. This message can also indicate that a message header limit has been reached on a remote server, or some other protocol time-out occurred while communicating with the remote server.|This message usually indicates an issue on the receiving server. Check the validity of the recipient address, and determine if the receiving server is configured correctly to receive messages. <br/><br/> You might have to reduce the number of recipients in the message header for the host about which you're receiving this error. If you send the message again, it's placed in the queue again. If the receiving server is available, the message is delivered. <br/><br/> For more information, see [Fix email delivery issues for error code 4.4.7 in Exchange Online](fix-error-code-550-4-4-7-in-exchange-online.md).|
|4.4.8|`MX hosts of <domain> failed MTA-STS validation`|The destination MX host was not the host expected per the domain's STS policy.|This error usually indicates an issue with the destination domain's MTA-STS policy not containing the MX host. For more information, see [Enhancing mail flow with MTA-STS](/purview/enhancing-mail-flow-with-mta-sts).|
|4.5.3|`Too many recipients`|The message has more than 200 SMTP envelope recipients from the same domain.|An envelope recipient is the original, unexpanded recipient that's used in the **RCPT TO** command to transmit the message between SMTP servers. When this error is returned by Microsoft 365 or Office 365, the sending server must break up the number of envelope recipients into smaller chunks (chunking) and resend the message.|
|4.7.5|`Remote certificate failed MTA-STS validation. Reason: <validityStatus>`|The destination mail server's certificate must chain to a trusted root Certificate Authority and the Common Name or Subject Alternative Name must contain an entry for the host name in the STS policy.|This error usually indicates an issue with the destination mail server's certificate. For more information, see [Enhancing mail flow with MTA-STS](/purview/enhancing-mail-flow-with-mta-sts).|
|4.7.26|`Access denied, a message sent over IPv6 [2a01:111:f200:2004::240] must pass either SPF or DKIM validation, this message is not signed`|The sending message sent over IPv6 must pass either SPF or DKIM.|For more information, see [Support for anonymous inbound email messages over IPv6](/microsoft-365/security/office-365-security/support-for-anonymous-inbound-email-messages-over-ipv6).|
|4.7.321|`starttls-not-supported: Destination mail server must support TLS to receive mail.`|<ul><li>DNSSEC checks have passed, yet upon connection, destination mail server doesn't respond to the `STARTTLS` command. </li><li>The destination server responds to the `STARTTLS` command, but the TLS handshake fails.</li></ul>|This message usually indicates an issue on the destination email server. Check the validity of the recipient address. Determine if the destination server is configured correctly to receive the messages.|
|4.7.322|`certificate-expired: Destination mail server's certificate is expired.`|DNSSEC checks have passed, yet upon establishing the connection, the destination mail server provides a certificate that's expired.|A valid X.509 certificate that isn't expired must be presented. X.509 certificates must be renewed after their expiration, most commonly on an annual basis.|
|4.7.323|`tlsa-invalid: The domain failed DANE validation.`|Records are DNSSEC authentic, but one or multiple of these scenarios occurred: <ul><li>The destination mail server's certificate doesn't match with what's expected per the authentic TLSA record.</li><li>Authentic TLSA record is misconfigured.</li><li>Destination domain is being attacked.</li><li>Any other DANE failure.</li></ul>|This message usually indicates an issue on the destination email server. Check the validity of the recipient address and determine if the destination server is configured correctly to receive messages. For more information, see [DANE protocol: updates and operational guidance](https://datatracker.ietf.org/doc/html/rfc7671).|
|4.7.324|`dnssec-invalid: Destination domain returned invalid DNSSEC records`|The destination domain indicated it was DNSSEC-authentic, but Exchange Online wasn't able to verify it as DNSSEC-authentic.|For more information, see [Overview of DNSSEC.](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj200221(v=ws.11))|
|4.7.325|`certificate-host-mismatch: Remote certificate MUST have a common name or subject alternative name matching the hostname (DANE)`|This happens when the presented certificate identities (CN and SAN) of a destination SMTP target host don't match any of the domains or MX host.|This message usually indicates an issue on the destination email server. Check the validity of the recipient address and determine if the destination server is configured correctly to receive messages. For more information, see [How SMTP DNS-based Authentication of Named Entities (DANE) works to secure email communications](/microsoft-365/compliance/how-smtp-dane-works).|
|4.7.500-699|`Access denied, please try again later`|Suspicious activity has been detected and sending has been temporarily restricted for further evaluation.|If this activity is valid, this restriction will be lifted shortly.|
|4.7.850-899|`Access denied, please try again later`|Suspicious activity has been detected on the IP in question, and it has been temporarily restricted while it's being further evaluated.|If this activity is valid, this restriction will be lifted shortly.|
|5.0.350|Generic error, `x-dg-ref header is too long`, or `Requested action not taken: policy violation detected (AS345)`|5.0.350 is a generic catch-all error code for a wide variety of nonspecific errors from the recipient's email organization. The specific `x-dg-ref header is too long` message is related to Rich Text formatted messages. The specific `Requested action not taken: policy violation detected (AS345)` message is related to nested attachments.|For more information, see [Fix email delivery issues for error code 550 5.0.350 in Exchange Online](fix-error-code-550-5-0-350-in-exchange-online.md).|
|5.1.0|`Sender denied`|A common cause of this NDR is when you use Microsoft Outlook to save an email message as a file, and then someone opened the message offline and replied to it. The message property only preserves the **legacyExchangeDN** attribute when Outlook delivers the message, and therefore the lookup could fail.|Either the recipient address is incorrectly formatted, or the recipient couldn't be correctly resolved. The first step in resolving this error is to check the recipient address, and send the message again. <br/><br/> For more information, see [Fix email delivery issues for error code 5.1.0 in Exchange Online](fix-error-code-550-5-1-0-in-exchange-online.md).|
|5.1.1|`Bad destination mailbox address`|This failure might be caused by the following conditions: <ul><li>The recipient's email address was entered incorrectly by the sender.</li><li>The recipient's email address doesn't exist in the destination email system.</li><li>The recipient's mailbox has been moved and the Outlook recipient cache on the sender's computer hasn't updated.</li><li>An invalid legacy domain name (DN) exists for the recipient's mailbox Active Directory Domain Service.</li></ul>|This error typically occurs when the sender of the message enters an incorrect email address of the recipient. The sender should check the recipient's email address and send again. This error can also occur if the recipient email address was correct in the past but has changed or has been removed from the destination email system. <br/><br/> If the sender of the message is in the same organization as the recipient, and the recipient's mailbox still exists, determine whether the recipient's mailbox has been relocated to a new email server. If so, Outlook might not have updated the recipient cache correctly. Instruct the sender to remove the recipient's address from sender's Outlook recipient cache and then create a new message. Resending the original message will result in the same failure. <br/><br/> For more information, see [Fix email delivery issues for error code 5.1.1 through 5.1.20 in Exchange Online](fix-error-code-550-5-1-1-through-5-1-20-in-exchange-online.md).|
|5.1.8|`Access denied, bad outbound sender`|The account has been blocked for sending too much spam. Typically, this problem occurs because the account has been compromised (hacked) by phishing or malware.|For more information, see [Fix email delivery issues for error code 5.1.8 in Exchange Online](fix-error-code-5-1-8-in-exchange-online.md).|
|5.1.10|`Recipient not found`|The recipient's `<SMTP Address>` wasn't found by SMTP address lookup. | For more information, see [Fix email delivery issues for error code 550 5.1.10 in Exchange Online](fix-error-code-550-5-1-10-in-exchange-online.md).|
|5.1.90|`Your message can't be sent because you've reached your daily limit for message recipients`|The sender has exceeded the recipient rate limit as described in [Sending limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#sending-limits).|This could indicate the account has been compromised and is being used to send spam. For more information, see [How to determine whether your account has been compromised](/office365/troubleshoot/security/determine-account-is-compromised).|
|5.2.2|`Submission quota exceeded`|The sender has exceeded the recipient rate limit or the message rate limit as described in [Sending limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#sending-limits).|This could indicate the account has been compromised and is being used to send spam. For more information, see [How to determine whether your account has been compromised](/office365/troubleshoot/security/determine-account-is-compromised).|
|5.2.121|`Recipient's per hour message receive limit from specific sender exceeded`|The sender has exceeded the maximum number of messages they're allowed to send per hour to a specific recipient in Exchange Online.|The automated mailer or sender should try again later, and reduce the number of messages they send per hour to a specific recipient. <br/><br/> This limit helps protect Microsoft 365 or Office 365 users from rapidly filling their inboxes with a large number of messages from errant automated notification systems or other single-sender mail storms.|
|5.2.122|`Recipient's per hour message receive limit exceeded`|The Microsoft 365 or Office 365 recipient has exceeded the number of messages they can receive per hour from all senders.|The automated mailer or sender should try again later, and reduce the number of messages they send per hour to a specific recipient. <br/><br/> This limit helps protect Microsoft 365 and Office 365 users from rapidly filling their inboxes with a large number of messages from errant automated notification systems or other mail storms.|
|5.3.190|`Journaling on-premises messages to Microsoft 365 or Office 365 not supported when Journaling Archive is disabled`|Journaling on-premises messages to Microsoft 365 or Office 365 isn't supported for this organization because they haven't turned on Journaling Archive in their settings.|A journaling rule is configured in the organization's on-premises environment to journal on-premises messages to Microsoft 365 or Office 365, but Journaling Archive is disabled. For this scenario to work, the organization's Office 365 administrator should either enable Journaling Archive or change the journaling rule to journal messages to a different location.|
|5.4.1|`Relay Access Denied`|The mail server that's generating the error doesn't accept mail for the recipient's domain. This error is caused by mail server or DNS misconfiguration.|For more information, see [Fix email delivery issues for error code 5.4.1 in Exchange Online](fix-error-code-550-5-4-1-in-exchange-online.md).|
|5.4.1|`Recipient address rejected: Access denied`|The recipient's address doesn't exist.|For more information, see [Use Directory Based Edge Blocking to reject messages sent to invalid recipients](/exchange/mail-flow-best-practices/use-directory-based-edge-blocking).|
|5.4.6 or 5.4.14|`Routing loop detected`|A configuration error has caused an email loop. 5.4.6 is generated by on-premises Exchange server (you'll see this code in hybrid environments). 5.4.14 is generated by Exchange Online. <br/><br/> By default, after 20 iterations of an email loop, Exchange interrupts the loop and generates an NDR to the sender of the message.|This error occurs when the delivery of a message generates another message in response. That message then generates a third message, and the process is repeated, creating a loop. To help protect against exhausting system resources, Exchange interrupts the mail loop after 20 iterations. Mail loops are typically created because of a configuration error on the sending mail server, the receiving mail server, or on both. Check the sender's and the recipient's mailbox rules configuration to determine whether automatic message forwarding is enabled. <br/><br/> For more information, see [Fix email delivery issues for error code 5.4.6 or 5.4.14 in Exchange Online](fix-error-code-5-4-6-through-5-4-20-in-exchange-online.md).|
|5.4.8|`MX hosts of <domain> failed MTA-STS validation`|The destination MX host was not the host expected per the domain's STS policy.|This error usually indicates an issue with the destination domain's MTA-STS policy not containing the MX host. For more information, see [Enhancing mail flow with MTA-STS](/purview/enhancing-mail-flow-with-mta-sts).|
|5.4.300|`Message expired`|The email took too long to be successfully delivered, either because the destination server never responded or the sent message generated an NDR error and that NDR couldn't be delivered to the original sender.|
|5.5.0|`550 5.5.0 Requested action not taken: mailbox unavailable`|The recipient's `<SMTP Address>` domain is @hotmail.com or @outlook.com and it wasn't found by SMTP address lookup.|Similar to 550 5.1.10. For more information, see [Fix email delivery issues for error code 550 5.1.10 in Exchange Online](fix-error-code-550-5-1-10-in-exchange-online.md).|
|5.6.11|`Invalid characters`|Your email program added invalid characters (bare line feed characters) into a message you sent.|For more information, see [Fix email delivery issues for error code 5.6.11 in Exchange Online](fix-error-code-550-5-6-11-in-exchange-online.md).|
|5.7.1|`Delivery not authorized`|The sender of the message isn't allowed to send messages to the recipient.|This error occurs when the sender tries to send a message to a recipient but the sender isn't authorized to do this. This error frequently occurs when a sender tries to send messages to a distribution group that has been configured to accept messages only from members of that distribution group or other authorized senders. The sender must request permission to send messages to the recipient. <br/><br/> This error can also occur if an Exchange transport rule rejects a message because the message matched conditions that are configured on the transport rule. <br/><br/> For more information, see [Fix email delivery issues for error code 5.7.1 in Exchange Online](fix-error-code-550-5-7-1-in-exchange-online.md).|
|5.7.1|`Unable to relay`|The sending email system isn't allowed to send a message to an email system that isn't the final destination of the message.|This error occurs when the sending email system tries to send an anonymous message to a receiving email system, and the receiving email system doesn't accept messages for the domain or domains specified in one or more of the recipients. The following reasons are the most common ones for this error: <ul><li>A third party tries to use a receiving email system to send spam, and the receiving email system rejects the attempt. By the nature of spam, the sender's email address might have been forged, and the resulting NDR could have been sent to the unsuspecting sender's email address. It's difficult to avoid this situation.</li><li>An MX record for a domain points to a receiving email system where that domain isn't accepted. The administrator responsible for the specific domain name must correct the MX record or configure the receiving email system to accept messages sent to that domain, or do both.</li><li>A sending email system or client that should use the receiving email system to relay messages doesn't have the correct permissions to do this.</li></ul> For more information, see [Fix email delivery issues for error code 5.7.1 in Exchange Online](fix-error-code-550-5-7-1-in-exchange-online.md).|
|5.7.1|`Client was not authenticated`|The sending email system didn't authenticate with the receiving email system. The receiving email system requires authentication before message submission.|This error occurs when the receiving server must be authenticated before message submission, and the sending email system hasn't authenticated with the receiving email system. The sending email system administrator must configure the sending email system to authenticate with the receiving email system for delivery to be successful. <br/><br/> For more information, see [Fix email delivery issues for error code 5.7.1 in Exchange Online](fix-error-code-550-5-7-1-in-exchange-online.md).|
|5.7.5|`Remote certificate failed MTA-STS validation. Reason: <validityStatus>`|The destination mail server's certificate must chain to a trusted root Certificate Authority and the Common Name or Subject Alternative Name must contain an entry for the host name in the STS policy.|This error usually indicates an issue with the destination mail server's certificate. For more information, see [Enhancing mail flow with MTA-STS](/purview/enhancing-mail-flow-with-mta-sts).|
|5.7.12|`Sender was not authenticated by organization`|The sender's message is rejected because the recipient address is set up to reject messages sent from outside its organization. Only an email administrator for the recipient's organization can change this.|For more information, see [Fix email delivery issues for error code 5.7.12 in Exchange Online](fix-error-code-5-7-12-in-exchange-online.md).|
|5.7.23|`The message was rejected because of Sender Policy Framework violation`|The destination email system uses SPF to validate inbound mail, and there's a problem with your SPF configuration.|For more information, see [Fix email delivery issues for error code 5.7.23 in Exchange Online](fix-error-code-5-7-23-in-exchange-online.md).|
|5.7.57|`Client was not authenticated to send anonymous mail during MAIL FROM`|You configured an application or device to send (relay) email messages in Microsoft 365 or Office 365 using the smtp.office365.com endpoint, and there's a problem with the configuration of the application or device.|For more information, see [Fix email delivery issues for error code 5.7.57 in Exchange Online](fix-error-code-5-7-57-in-exchange-online.md).|
|5.7.64|`TenantAttribution; Relay Access Denied`|You use an inbound connector to receive messages from your on-premises email environment, and something has changed in your on-premises environment that makes the inbound connector's configuration incorrect.|For more information, see [Fix email delivery issues for error code 5.7.64 in Exchange Online](fix-error-code-5-7-64-in-exchange-online.md).|
|5.7.124|`Sender not in allowed-senders list`|The sender doesn't have permission to send to the distribution group because the sender isn't in the group's allowed-senders list. Depending how the group is set up, even the group's owner might need to be added to the allowed sender list in order to send messages to the group.|For more information, see [Fix email delivery issues for error code 5.7.124 in Exchange Online](fix-error-code-5-7-124-in-exchange-online.md).|
|5.7.133|`Sender not authenticated for group`|The recipient address is a group distribution list that is set up to reject messages sent from outside its organization. Only an email administrator for the recipient's organization or the group owner can change this.|For more information, see [Fix email delivery issues for error code 5.7.133 in Exchange Online](fix-error-code-5-7-133-in-exchange-online.md).|
|5.7.134|`Sender was not authenticated for mailbox`|The recipient address is a mailbox that is set up to reject messages sent from outside its organization. Only an email administrator for the recipient's organization can change this.|For more information, see [Fix email delivery issues for error code 5.7.134 in Exchange Online](fix-error-code-5-7-134-in-exchange-online.md).|
|5.7.13 or 135|`Sender was not authenticated for public folder`|The recipient address is a public folder that is set up to reject messages sent from outside its organization. Only an email administrator for the recipient's organization can change this.|For more information, see [Fix email delivery issues for error code 5.7.13 or 5.7.135 in Exchange Online](fix-error-code-5-7-13-or-5-7-135-in-exchange-online.md).|
|5.7.136|`Sender was not authenticated`|The recipient address is a mail user that is set up to reject messages sent from outside its organization. Only an email administrator for the recipient's organization can change this.|For more information, see [Fix email delivery issues for error code 5.7.136 in Exchange Online](fix-error-code-5-7-136-in-exchange-online.md).|
|5.7.25|`Access denied, the sending IPv6 address [2a01:111:f200:2004::240] must have a reverse DNS record`|The sending IPv6 address must have a reverse DNS record to send email over IPv6.|For more information, see [Support for anonymous inbound email messages over IPv6](/microsoft-365/security/office-365-security/support-for-anonymous-inbound-email-messages-over-ipv6).|
|5.7.321|`starttls-not-supported: Destination mail server must support TLS to receive mail.`|<ul><li>DNSSEC checks have passed, yet, upon connection, the destination mail server doesn't respond to the `STARTTLS` command. </li><li>The destination server responds to the `STARTTLS` command, but the TLS handshake fails. </li></ul>| This message usually indicates an issue on the destination mail server. Check the validity of the recipient address and determine if the destination server is configured correctly to receive messages.|
|5.7.322|`certificate-expired: Destination mail server's certificate is expired.`| DNSSEC checks have passed, yet, upon establishing the connection, the destination mail server provides a certificate that is expired. | A valid X.509 certificate that isn't expired must be presented. X.509 certificates must be renewed after their expiration, most commonly on an annual basis.|
|5.7.323|`tlsa-invalid: The domain failed DANE validation.`| Records are DNSSEC authentic but one or multiple of these things occurred: <ul><li> The destination mail server's certificate doesn't match with what is expected per the authentic TLSA record.</li><li> Authentic TLSA record is misconfigured. </li><li> Destination domain is being attacked.</li><li> The certificate start date is in the future. </li><li> Any other DANE failure.</li></ul>| This message usually indicates an issue on the destination mail server. Check the validity of the recipient address and determine if the destination server is configured correctly to receive messages. <br/><br/> For more information about DANE, see [https://datatracker.ietf.org/doc/html/rfc7671](https://datatracker.ietf.org/doc/html/rfc7671).|
|5.7.324|`dnssec-invalid: Destination domain returned invalid DNSSEC records`| The destination domain indicated it was DNSSEC authentic but Exchange Online wasn't able to verify it as DNSSEC authentic. | For more information about DNSSEC, see [Overview of DNSSEC](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj200221(v=ws.11)).|
|5.7.325|`certificate-host-mismatch: Remote certificate MUST have a common name or subject alternative name matching the hostname (DANE)`|This error occurs when the presented certificate identities (CN and SAN) of a destination SMTP target host don't match any of the domains or MX host.|This message usually indicates an issue on the destination email server. Check the validity of recipient address and determine if the destination server is configured correctly to receive messages. For more information, see [How SMTP DNS-based Authentication of Named Entities (DANE) works to secure email communications](/microsoft-365/compliance/how-smtp-dane-works).|
|5.7.501|`Access denied, spam abuse detected`|The sending account has been banned due to detected spam activity.|For more information, see [Fix email delivery issues for error code 451 5.7.500-699 (ASxxx) in Exchange Online](fix-error-code-451-4-7-500-699-asxxx-in-exchange-online.md). <br/><br/> Verify that account issues have been resolved, and reset its credentials. To restore this account's ability to send mail, contact support through your regular channel.|
|5.7.502|`Access denied, banned sender`|The sending account has been banned due to detected spam activity.|Verify that account issues have been resolved, and reset its credentials. To restore this account's ability to send mail, please contact support through your regular channel.|
|5.7.503|`Access denied, banned sender`|The sending account has been banned due to detected spam activity.|Verify that account issues have been resolved, and reset its credentials. To restore this account's ability to send mail, please contact support through your regular channel.|
|5.7.504|`[email@contoso.com]: Recipient address rejected: Access denied`|The recipient address that you're attempting to contact isn't valid.|Verify the recipient's email address, and try again.|
|5.7.505|`Access denied, banned recipient`|The recipient that you're attempting to contact isn't valid.|If you feel this is an error, contact support.|
|5.7.506|`Access Denied, Bad HELO`|Your server is attempting to introduce itself (HELO according to RFC 821) as the server it's trying to connect to, rather than its own fully qualified domain name.|This isn't allowed, and it's characteristic of typical spambot behavior.|
|5.7.507|`Access denied, rejected by recipient`|The IP that you're attempting to send from has been blocked by the recipient's organization.|Contact the recipient to resolve this issue.|
|5.7.508|`Access denied, [$SenderIPAddress] has exceeded permitted limits within $range range`|The sender's IPv6 range has attempted to send too many messages in too short a time period.|Not applicable|
|5.7.509|`Access denied, sending domain [$SenderDomain] does not pass DMARC verification and has a DMARC policy of reject.` |The sender's domain in the **5322.From** address doesn't pass DMARC.|For information on why this error occurred, see [Why does DMARC fail?](#why-does-dmarc-fail).<br/><br/> A user too receives this Bounce Message because it failed DMARC and the DMARC policy is set to reject all failures. The user then should contact their email administrator for additional help.|
|5.7.510|`Access denied, [contoso.com] does not accept email over IPv6`|The sender is attempting to transmit a message to the recipient over IPv6, but the recipient doesn't accept email messages over IPv6.|Not applicable|
|5.7.511|`Access denied, banned sender`|The IP that you're attempting to send from has been banned.|To delist the address, email delist@microsoft.com and provide the full NDR code and IP address. <br/><br/> For more information, see [Use the delist portal to remove yourself from the blocked senders list](/microsoft-365/security/office-365-security/use-the-delist-portal-to-remove-yourself-from-the-office-365-blocked-senders-lis).|
|5.7.512|`Access denied, message must be RFC 5322 section 3.6.2 compliant`|Message was sent without a valid "From" email address.|Office 365 only. Each message must contain a valid email address in the "From" header field. Proper formatting of this address includes angle brackets around the email address, for example, \<security@contoso.com\>. Without an address with this format, Microsoft 365 or Office 365 will reject the message.|
|5.7.513|`Service unavailable, Client host [$ConnectingIP] blocked by $recipientDomain using Customer Block list (AS16012607)`|The recipient domain has added your sending IP address to its custom blocklist.|The domain that received the email has blocked your sender's IP address. If you think your IP address has been added to the recipient domain's custom blocklist by error, you need to contact them directly and ask them to remove it from the blocklist.|
|5.7.606-649|`Access denied, banned sending IP [IP1.IP2.IP3.IP4]`|The IP that you're attempting to send from has been banned.|Verify that you're following the [best practices for email deliverability](/dynamics365/marketing/get-ready-email-marketing), and ensure your IPs' reputations haven't been degraded as a result of compromise or malicious traffic. If you believe you're receiving this message by error, you can use the self-service portal to request your IP address to be removed from this list. <br/><br/> For more information, see [Use the delist portal to remove yourself from the blocked senders list](/microsoft-365/security/office-365-security/use-the-delist-portal-to-remove-yourself-from-the-office-365-blocked-senders-lis).|
|5.7.703|`Your message can't be delivered because messages to XXX, YYY are blocked by your organization using Tenant Allow Block List.`|Someone in your organization sent mail to an email address or domain that's blocked in the [Tenant Allow/Block List](/microsoft-365/security/office-365-security/tenant-allow-block-list-about#block-entries-in-the-tenant-allowblock-list). The entire message is blocked for all internal and external recipients of the message, even if only one recipient email address or domain is defined in a block entry.|
|5.7.705 <br/><br/> 5.7.708|`5.7.705 Access denied, tenant has exceeded threshold`, `5.7.708 Access denied, traffic not accepted from this IP`|Most of the traffic from this tenant has been detected as suspicious and this detection has resulted in a ban on the sending ability for the tenant.|Ensure that any compromises or open relays have been resolved, and then contact support through your regular channel. <br/><br/> For more information, see [Fix email delivery issues for error codes 5.7.700 through 5.7.750 in Exchange Online](fix-error-code-5-7-700-through-5-7-750.md).|
|5.7.750|`Service unavailable. Client blocked from sending from unregistered domains`|A suspicious number of messages from unprovisioned domains is coming from this tenant.|Add and validate any or all domains that you use to send email from Microsoft 365 or Office 365. <br/><br/> For more information, see [Fix email delivery issues for error codes 5.7.700 through 5.7.750 in Exchange Online](fix-error-code-5-7-700-through-5-7-750.md).|
|5.7.800|`Access denied, banned sender`|The EHLO, P1, or P2 sender domain of this message has been banned due to detected spam activity.|To restore this domain's ability to send mail, contact Microsoft support.|
|n/a|`The message can't be submitted because the sender's submission quota was exceeded`|The user account has exceeded the recipient rate limit (10,000 recipients per day).|The account has likely been compromised. For more information, see [Fix email delivery issues for error 'the sender's submission quota was exceeded' in Exchange Online](fix-error-for-submission-quota-exceeded-in-exchange-online.md).|

## Run non-delivery report diagnostics

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

To learn more about the description of the non-delivery report (NDR), possible cause, and solution (by running the following NDR diagnostic), you can run an automated diagnostic. Ensure you get the NDR code or status code from the undeliverable/non-delivery report.

To run the diagnostic check, select the following button:

> [!div class="nextstepaction"]
> [Run Tests: NDR diagnostics](https://aka.ms/PillarEmailNDR)

A flyout page opens in the Microsoft 365 admin center. Paste the NDR code or error message, and then select **Run Tests**.

## What's included in an NDR?

Exchange NDRs are designed to be easy to be read and understood by email users and administrators. There are a couple of different formats for NDRs. The newest style NDR contains a problem description in everyday language, along with steps to fix it. The following figure shows the format for this type of NDR:

:::image type="content" source="media/non-delivery-reports-in-exchange-online/delivery-status-notification.png" alt-text="Screenshot of the newest format for delivery status notification in Exchange Online." border="false":::

Information provided in the newest style NDRs is designed to help the typical email users solve their problem immediately. When that isn't possible, the NDR provides details for administrators and also a link to more help on the web. The fields that appear in the newest Office 365 NDRs are described in the following table:

|Field|Description|
|---|---|
|**Office 365 logo**|This section indicates that Microsoft 365 or Office 365 generated the NDR. The logo doesn't mean that Microsoft 365 or Office 365 was responsible for the error. This tells which messaging endpoints or services are involved in the email transaction, which isn't always clear in older style NDRs.|
|**Cause**|This section provides the reason that the message wasn't delivered.|
|**Fix-it owner indicator**|This section provides an at-a-glance view of the issue and who needs to fix it. The image shows the three basic parties in a Microsoft 365 or Office 365 email transaction: the sender, Microsoft 365 or Office 365, and the recipient. The area marked in red is where the problem usually must be fixed.|
|**How to fix it**|This section is designed for the end user or the email sender who receives the NDR. It explains how to fix the issue.|
|**More info for email admins**|This section provides a detailed explanation of the problem and solution along with technical details and a link to a web-based article that has detailed reference information.|
|**Message hops**|This section contains times and system references for the message, which allows an administrator to follow the message's hops or server-to-server path. With this information, an administrator might quickly spot problems between message hops.|

For NDRs that don't have the latest format, the information might be separated into two sections: User information and Diagnostic information for administrators. The following figure shows the format for one type of Exchange Online NDR:

:::image type="content" source="media/non-delivery-reports-in-exchange-online/ndr-message.png" alt-text="Screenshot of an NDR message that shows User and Administrator diagnostic info." border="false":::

### User information

The **User information** section appears first in some NDRs, and the main purpose is to provide a summary about what went wrong. The text is designed to help the message sender determine why the message was rejected and, if possible, how to resend the message successfully. The email address of each recipient is listed, and the reason for the failure is included in the space below the recipient's email address. The name of the mail server that rejected the message might also be included in this section.

### Diagnostic information for administrators

The **Diagnostic information for administrators** section provides deeper technical information to help administrators troubleshoot the message delivery problem. It contains detailed information about the specific error that occurred during delivery of the message, the server that generated the NDR, and the server that rejected the message. This section uses the following format:

```output
Diagnostic information for administrators
Generating server:
<server name>
          <rejected recipient>
          <remote server>

          <enhanced status code>

<SMTP response>
Original message headers
<message header fields>
```

**Note:** The \<SMTP response\> and message header fields will be in English and aren't customizable.

|Field|Description|
|---|---|
|**Generating server**|This field indicates the name of the SMTP mail server that created the NDR. If no remote server is listed below the sender's email address, the generating server is also the server that rejected the original email message. When the remote mail server acknowledges and accepts the message, but later rejects the message, for example, because of content restrictions, the remote server generates the NDR. If the remote mail server never acknowledges and never accepts the message, the sending server in Exchange Online generates the NDR.|
|**\<Rejected recipient\>**|This value is the email address of the recipient. If delivery failed to more than one recipient, the email address of each recipient is listed. The following information is also included for each failed recipient:<ul><li> **Field**</li><li> **Description**</li></ul>|
|**\<Remote server\>**|This value is the name of the mail server that rejected the message. If the original message is successfully acknowledged by the receiving server, but is later rejected, the remote server value isn't populated.|
|**\<Enhanced status code\>**|This value is assigned by the mail server that rejected the original message and indicates why the message was rejected. These codes are defined in RFC 3463, and use the format _abc x.y.z_, where the placeholder values are integers. For example, a 5._x.x_ code indicates a permanent error, and a 4._x.x_ code indicates a temporary error. Although the enhanced status code is often generated by an external mail server, Exchange Online uses the enhanced status code value to determine the text to display in the **User information** section.|
|**\<SMTP response\>**|This value is returned by the mail server that rejected the original message. This text provides an explanation for the enhanced status code value. The text is always presented in US-ASCII format.|
|**Original message headers**|This section contains the message header fields of the rejected message. These header fields can provide useful diagnostic information, such as the path that the message took before it was rejected, or whether the `To` field value matches the rejected recipient value.|

## How to interpret an Exchange NDR

Here's an example. Suppose you receive an Exchange NDR that contains the following information:

```output
Delivery has failed to these recipients or groups:
ronald@contoso.com
Your message wasn't delivered due to a permission or security issue. It might have been rejected by a moderator, the address might only accept email from certain senders, or another restriction might be preventing delivery. The following organization rejected your message: mail.contoso.com.
Diagnostic information for administrators:
Generating server: alpineskihouse.com
ronald@contoso.com
mail.contoso.com #<exchange.contoso.com #5.7.1 smtp;530 5.7.1 Client was not authenticated> #SMTP#
Original message headers:
...
```

From the **User information** section, you can determine that the recipient is Ronald Slattery, and that the message was rejected by the mail server mail.contoso.com, which isn't an Exchange Online or Exchange Online Protection mail server.

From the **Diagnostic information for administrators** section, you can see that alpineskihouse.com attempted to connect to the server mail.contoso.com to deliver the message to the recipient ronald@contoso.com. However, mail.contoso.com responded with the error `530 5.7.1 Client was not authenticated`. Even though bigfish.com generated the NDR, mail.contoso.com actually rejected the message, so the administrators at contoso.com are responsible for understanding and fixing the problem. This particular error indicates that the server mail.contoso.com is configured not to accept anonymous email from the Internet.

Although the **Original message headers** are omitted from this example due to their length and complexity, you can typically extract useful information from the following header fields:

- **To**: This field might be helpful if the email address was mistyped.

- **Received**: These fields can tell you what the path was for the message, and the last hop that generated the delivery status notification if it isn't easy to tell from the `Generating server` value in the NDR.

- **Received-SPF**: If this value is anything other than `pass`, check the Sender Policy Framework (SPF) DNS record for your domain. For more information, see [Add or edit custom DNS records](/microsoft-365/admin/setup/add-domain).

## Still need help with SMTP errors, NDRs or other status notifications?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## Additional email help

- [Get help when email messages won't send](https://support.office.com/article/97748418-bbd5-4743-a05b-581f22a466dd.aspx)

- [Find and fix email delivery issues as a Microsoft 365 for business admin](/Exchange/fix-outlook-connection-problems-in-office-365/fix-outlook-connection-problems-in-office-365/find-and-fix-email-delivery-issues-as-an-office-365-for-business-admin)

- [Anti-spam protection in EOP](/office365/securitycompliance/anti-spam-protection)

- [Recover deleted items in a user mailbox - Admin Help](/office365/enterprise/recover-deleted-items-in-a-mailbox)

- [My messages won't send](https://support.office.com/article/97748418-bbd5-4743-a05b-581f22a466dd.aspx)

- [Message trace in the Security & Compliance Center](/office365/securitycompliance/message-trace-scc)

- [Troubleshoot Microsoft 365 mail flow](/exchange/mail-flow-best-practices/troubleshoot-mail-flow)

## Why does DMARC fail?

1. **Missing or incorrect DMARC/DNS records:** Alignment issues, missing SPF, and policy issues.
1. **Missing DKIM or DKIM records:** Missing DKIM DNS record (public key) or the Message isn't DKIM signed at the time of sending (private key).
1. **Forwarding emails:** Forwarding can break SPF/DKIM, which fails DMARC.

### How do I fix this error?

1. If you're using/paying a DMARC service to read your reports, ask them what is happening.
1. Read the NDR message to trace information that provides the reasons for the DMARC failure.
1. Add/correct/align based on the ascertained reasons for the DMARC failure.

#### How can I see the message headers?

Microsoft includes the headers in the NDR email sent back to the original sender of the message that failed DMARC.

##### Header information

- SPF/DKIM Failures:

  
```azurepowershell-interactive
Transport; Wed, 22 Mar 2023 21:14:22 +0000
Authentication-Results: spf=none (sender IP is 40.95.88.73)
 smtp.mailfrom=o365e083.onmicrosoft.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject
 header.from=o365e.onmicrosoft.com;compauth=fail reason=000
Received-SPF: None (protection.outlook.com: o365e.onmicrosoft.com does
 not designate permitted sender hosts)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none; dmarc=none action=none
 header.from=o365e.onmicrosoft.com;
X-Test-Message-Executed-by: daiq_debug
Message-ID: <991e8244-85@A.MB3331.outlook.com>
From: admin@o365e.onmicrosoft.com
Subject: Consumer dmarc reject test
MIME-Version: 1.0
Content-Type: text/plain
Sender: "admin@o365e.onmicrosoft.com"
    <admin@o365e.onmicrosoft.com>
```

- Alignment
  P1 and P2 Domains don't align (match)
  
```azurecli-interactive
Message-ID: <1430c613-58@A.MB3outlook.com>
From: admin@o365e083.onmicrosoft.com
Subject: Consumer auto forward test
MIME-Version: 1.0
Content-Type: text/plain
Sender: "admin@o365e039.onmicrosoft.com"
    <admin@o365e039.onmicrosoft.com>
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMB3284:EE_|DU0PRMB172:EE
To: Undisclosed recipients:;
Return-Path: admin@o365e039.onmicrosoft.com
Date: Tue, 11 Apr 2023 16:20:03 +0000
```

## Still need help with DMARC?

- DNS
    - [DMARC](https://dmarc.org/)
    - [SPF](http://www.open-spf.org/)
    - [DKIM](https://dkim.org/)

- Microsoft DNS articles
    - [DMARC](/microsoft-365/security/office-365-security/email-authentication-dmarc-configure)
    - [SPF](/microsoft-365/security/office-365-security/email-authentication-spf-configure)
    - [DKIM](/microsoft-365/security/office-365-security/email-authentication-dkim-configure)

- Header Readers
    - [MSFT Header Reader](https://mha.azurewebsites.net/)
    - [Google Admin Toolbox Messageheader](https://toolbox.googleapps.com/apps/messageheader/)
