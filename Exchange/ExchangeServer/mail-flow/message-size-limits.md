---
title: "Message size limits in Exchange Server"
ms.author: chrisda
author: chrisda
manager: serdars
ms.date: 7/6/2018
ms.audience: ITPro
ms.topic: overview
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.assetid: b6a3840d-b821-4e53-877b-59c16be77206
description: "Summary: Learn how administrators can apply limits to messages in an Exchange Server 2016 or Exchange Server 2019 organization."
---

# Message size limits in Exchange Server

You can apply limits to messages that move through your organization. You can set the maximum size of an entire message as a whole, or the size of individual parts of a message, or both. For example, you could restrict the maximum size of the message header or attachments, or set a maximum number of recipients that can be added to the message. You can apply these limits to your entire Exchange organization, to specific mail transport connectors, specific servers, and to individual mailboxes.

This topic only talks about message and recipient size limits. If you want to know more about how to control how many messages are sent over time, how many connections are allowed over time, and how long Exchange will wait before closing a connection, see [Message rate limits and throttling](message-rate-limits.md).

As you plan the message size limits for your Exchange organization, consider the following questions:

- What size limits should I impose on all incoming messages?

- What size limits should I impose on all outgoing messages?

- What is the mailbox quota for my organization, and how do the message size limits that I have chosen relate to the mailbox quota size?

- Are there users in my organization who need to send or receive messages that are larger than the maximum allowed size?

- Does my organization include other messaging systems or separate business units that require different message size limits?

This topic provides guidance to help you answer these questions and to apply the appropriate message size limits in the appropriate locations.

## Types of message size limits
<a name="Types"> </a>

The following list describes the basic types of message size limits, and the message components that they apply to.

- **Whole message size limits**: Specifies the maximum size of a message, which includes the message header, the message body, and any attachments. Exchange uses the custom **X-MS-Exchange-Organization-OriginalSize:** message header to record the original size of the message as it enters the Exchange organization. Whenever the message size is checked, the lower value of the current message size or the original message size header is used. The size of the message can change because of content conversion, encoding, and transport agent processing.

    For any message size limit, you need to set a value that's larger than the actual size you want enforced. This accounts for the Base64 encoding of attachments and other binary data. Base64 encoding increases the size of the message by approximately 33%, so the value you specify should be approximately 33% larger than the actual message size you want enforced. For example, if you specify a maximum message size value of 64 MB, you can expect a realistic maximum message size of approximately 48 MB.

- **Attachment size limits**: Specifies the maximum size of a single attachment in a message. The message might contain many smaller attachments that greatly increase its overall size. However, the attachment size limit applies only to the size of an individual attachment. While you can't limit the number of attachments on a message, you can use the maximum message size limit to control the maximum total of attachments on the message.

- **Recipient limits**: Specifies the total number of recipients that are allowed in a message. This includes the total number of recipients in the **To:**, **Cc:**, and **Bcc:** fields. A distribution group counts as a single recipient.

- **Message header size limits**: Specifies the maximum size of all message header fields in a message. The size of the message body or attachments isn't considered. Because the header fields are plain text, the size of the header is determined by the number of characters in each header field and by the total number of header fields. Each text character consumes 1 byte.

## Scope of limits
<a name="Scope"> </a>

The following tables show the message limits at the Organization, Connector, Server, and Mailbox levels, including information about how to configure the limits in the Exchange admin center (EAC) or the Exchange Management Shell. To learn how to open the Exchange Management Shell in your on-premises Exchange organization, see [Open the Exchange Management Shell](https://docs.microsoft.com/powershell/exchange/exchange-server/open-the-exchange-management-shell).

### Organizational limits
<a name="Organizational"> </a>

Organizational limits apply to all Exchange 2019 servers, Exchange 2016 servers, Exchange 2013 Mailbox servers, and Exchange 2010 Hub Transport servers that exist in your organization. On Edge Transport servers, any organizational limits that you configure are applied to the local server.

|**Size limit**|**Default value**|**EAC configuration**|**Exchange Management Shell configuration**|
|:-----|:-----|:-----|:-----|
|Maximum size of a message received|10 MB|**Mail flow** \> **Receive connectors** \> **More options** ![More Options icon](../media/ITPro_EAC_MoreOptionsIcon.png) \> **Organization transport settings** \> **Limits** tab \> **Maximum receive message size (MB)**|Cmdlet: **Set-TransportConfig** <br/> Parameter: _MaxReceiveSize_|
|Maximum size of a message sent|10 MB|**Mail flow** \> **Receive connectors** \> **More options** ![More Options icon](../media/ITPro_EAC_MoreOptionsIcon.png) \> **Organization transport settings** \> **Limits** \> **Maximum send message size (MB)**|Cmdlet: **Set-TransportConfig** <br/> Parameter: _MaxSendSize_|
|Maximum number of recipients in a message|5000|**Mail flow** \> **Receive connectors** \> **More options** ![More Options icon](../media/ITPro_EAC_MoreOptionsIcon.png) \> **Organization transport settings** \> **Limits** **Maximum number of recipients**|Cmdlet: **Set-TransportConfig** <br/> Parameter: _MaxRecipientEnvelopeLimit_|
|Maximum attachment size for a message that matches the conditions of the Transport rule|Not configured|**Mail flow** \> **Rules** \> **Add** ![Add icon](../media/ITPro_EAC_AddIcon.png) \> **Create a new rule**, or select an existing rule, and then click **Edit** ![Edit icon](../media/ITPro_EAC_EditIcon.png). <br/> Click **More options**. <br/> Use the condition **Apply this rule if** \> **The message** \> **size is greater than or equal to**, and enter a value in kilobytes (KB).|Cmdlets: **New-TransportRule**, **Set-TransportRule** <br/> Parameter: _AttachmentSizeOver_|
|Maximum message size for a message that matches the conditions of the Transport rule|Not configured|**Mail flow** \> **Rules** \> **Add** ![Add icon](../media/ITPro_EAC_AddIcon.png) \> **Create a new rule**, or select an existing rule, and then click **Edit** ![Edit icon](../media/ITPro_EAC_EditIcon.png). <br/> Click **More options**. <br/> Use the condition **Apply this rule if** \> **The message** \> **size is greater than or equal to**, and enter a value in kilobytes (KB).|Cmdlets: **New-TransportRule**, **Set-TransportRule** <br/> Parameter: _MessageSizeOver_|
 
To see the values of these organizational limits, run the following commands in the Exchange Management Shell:

```
Get-TransportConfig | Format-List MaxReceiveSize,MaxSendSize,MaxRecipientEnvelopeLimit
```

```
Get-TransportRule | where {($_.MessageSizeOver -ne $null) -or ($_.AttachmentSizeOver -ne $null)} | Format-Table Name,MessageSizeOver,AttachmentSizeOver
```

### Connector limits
<a name="Connector"> </a>

Connector limits apply to any messages that use the specified Send connector, Receive connector, Delivery Agent connector, or Foreign connector for message delivery.

 You can assign specific message size limits to the Active Directory site links in your organization. The Transport service on Mailbox servers uses Active Directory sites, and the costs that are assigned to the Active Directory IP site links as one of the factors to determine the least-cost routing path between Exchange servers in the organization.

You can assign specific message size limits to the Delivery Agent connectors and Foreign connectors that are used to send non-SMTP messages in your organization.

|**Size limit**|**Default value**|**EAC configuration**|**Exchange Management Shell configuration**|
|:-----|:-----|:-----|:-----|
|Maximum size of a message sent through the Receive connector|36 MB|**Mail flow** \> **Receive connectors** \> **Edit** ![Edit icon](../media/ITPro_EAC_EditIcon.png) \> **General** \> **Maximum receive message size (MB)**|Cmdlets: **New-ReceiveConnector**, **Set-ReceiveConnector** <br/> Parameter: _MaxMessageSize_|
|Maximum size of all header fields in a message sent through the Receive connector| 256 KB|Not available|Cmdlets: **New-ReceiveConnector**, **Set-ReceiveConnector** <br/> Parameter: _MaxHeaderSize_|
|Maximum number of recipients in a message sent through the Receive connector|**Transport service on Mailbox servers** <br/> Default _\<ServerName\>_: 5000 <br/> Client Proxy _\<ServerName\>_: 200 <br/> **Front End Transport service on Mailbox servers** <br/> Default Frontend _\<ServerName\>_: 200 <br/> Outbound Proxy Frontend _\<ServerName\>_: 200 <br/> Client Frontend _\<ServerName\>_: 200 <br/> If the number of recipients is exceeded in a message from an anonymous sender (for example, an Internet sender), the message is accepted for the first 200 recipients. Most messaging servers will continue to resend the message in groups of 200 recipients until the message is delivered to all recipients.|Not available|Cmdlets: **New-ReceiveConnector**, **Set-ReceiveConnector** <br/> Parameter: _MaxRecipientsPerMessage_|
|Maximum size of a message sent through the Send connector|10 MB|**Mail flow** \> **Send connectors** \> **Edit** ![Edit icon](../media/ITPro_EAC_EditIcon.png) \> **General** tab \> **Maximum send message size (MB)**|Cmdlets: **New-SendConnector**, **Set-SendConnector** <br/> Parameter: _MaxMessageSize_|
|Maximum size of a message sent through the Active Directory site link|Unlimited|Not available|Cmdlet: **Set-AdSiteLink** <br/> Parameter: _MaxMessageSize_|
|Maximum size of a message sent through the Delivery Agent connector|Unlimited|Not available|Cmdlets: **New-DeliveryAgentConnector**, **Set-DeliveryAgentConnector** <br/> Parameter: _MaxMessageSize_|
|Maximum size of a message sent through the Foreign connector|Unlimited|Not available|Cmdlet: **Set-ForeignConnector** <br/> Parameter: _MaxMessageSize_|
 
To see the values of these connector limits, run the following command in the Exchange Management Shell:

```
Get-ReceiveConnector | Format-Table Name,Max*Size,MaxRecipientsPerMessage; Get-SendConnector | Format-Table Name,MaxMessageSize; Get-AdSiteLink | Format-Table Name,MaxMessageSize; Get-DeliveryAgentConnector | Format-Table Name,MaxMessageSize; Get-ForeignConnector | Format-Table Name,MaxMessageSize
```

### Server limits
<a name="Server"> </a>

Server limits apply to specific Mailbox servers or Edge Transport servers. You can set these message size limits independently on each Mailbox server or Edge Transport server.

|**Size limit**|**Default value**|**EAC configuration**|**Exchange Management Shell configuration**|
|:-----|:-----|:-----|:-----|
|Maximum size for a message sent by Outlook on the web clients|35 MB|Not available|You configure this value in web.config XML application configuration files on the Mailbox server. For more information, see [Configure client-specific message size limits](../architecture/client-access/client-message-size-limits.md).|
|Maximum size for a message sent by Exchange ActiveSync clients|10 MB|Not available|You configure this value in web.config XML application configuration files on the Mailbox server. For more information, see [Configure client-specific message size limits](../architecture/client-access/client-message-size-limits.md).|
|Maximum size for a message sent by Exchange Web Services clients|64 MB|Not available|You configure this value in web.config XML application configuration files on the Mailbox server. For more information, see [Configure client-specific message size limits](../architecture/client-access/client-message-size-limits.md).|
 
The pickup directory that's available on Edge Transport servers and Mailbox servers also has messages size limits that you can configure. Typically, the pickup directory isn't used in everyday mail flow. It's is used by administrators for mail flow testing, or by applications that need to create and submit their own messages files. For more information, see [Configure the Pickup Directory and the Replay Directory](https://technet.microsoft.com/library/c9ca7358-9a08-4f57-89d0-910e4438df8a.aspx).

- Maximum size of all header fields in a message file placed in the pickup directory: 64 KB.

- Maximum number of recipients in a message file placed in the pickup directory: 100.

### Recipient limits
<a name="User"> </a>

Recipient limits apply to a specific user object, such as a mailbox, mail contact, mail user, distribution group, or a mail-enabled public folder.

|**Size Limit**|**Default value**|**EAC configuration**|**Exchange Management Shell configuration**|
|:-----|:-----|:-----|:-----|
|Maximum size of a message that can be sent to the specific recipient|Site mailbox provisioning policies: 36 MB <br/> All other recipient types: unlimited|For mailboxes: <br/> **Recipients** \> **Mailboxes** \> **Edit** ![Edit icon](../media/ITPro_EAC_EditIcon.png) \> **Mailbox features** \> **Mail flow** section \> **Message size restrictions** section \> **View details** \> **Received messages** section \> **Maximum message size (KB)** <br/> For mail users: <br/> **Recipients** \> **Contacts** \> **Edit** ![Edit icon](../media/ITPro_EAC_EditIcon.png) \> **Mail flow settings** \> **Message size restrictions** \> **View details** \> **Received messages** section \> **Maximum message size (KB)** <br/> This setting available in the EAC for other types of recipients.|Cmdlets: <br/> **Set-DistributionGroup** <br/> **Set-DynamicDistributionGroup** <br/> **Set-Mailbox** <br/> **Set-MailContact** <br/> **Set-MailUser** <br/> **Set-MailPublicFolder** <br/> **New-SiteMailboxProvisioningPolicy** <br/> **Set-SiteMailboxProvisioningPolicy** <br/> Parameter: _MaxReceiveSize_|
|Maximum size of a message that can be sent by the specific sender|Unlimited|For mailboxes: <br/> **Recipients** \> **Mailboxes** \> **Edit** ![Edit icon](../media/ITPro_EAC_EditIcon.png) \> **Mailbox features** \> **Mail flow** section \> **Message size restrictions** section \> **View details** \> **Sent messages** section \> **Maximum message size (KB)** <br/> For mail users: <br/> **Recipients** \> **Contacts** \> **Edit** ![Edit icon](../media/ITPro_EAC_EditIcon.png) \> **Mail flow settings** \> **Message size restrictions** section \> **View details** \> **Sent messages** section \> **Maximum message size (KB)** <br/> This setting available in the EAC for other types of senders.|Cmdlets: <br/> **Set-DistributionGroup** <br/> **Set-DynamicDistributionGroup** <br/> **Set-Mailbox** <br/> **Set-MailContact** <br/> **Set-MailUser** <br/> **Set-MailPublicFolder** <br/> Parameter: _MaxSendSize_|
|Maximum number of recipients in a message that's sent by the specific sender|Unlimited|For mailboxes: <br/> **Recipients** \> **Mailboxes** \> **Edit** ![Edit icon](../media/ITPro_EAC_EditIcon.png) \> **Mailbox features** \> **Mail flow** section \> **View details** \> **Recipient limit** section \> **Maximum recipients** <br/> This setting isn't available in the EAC for mail users.|Cmdlets: <br/> **Set-Mailbox**, **Set-MailUser** <br/> Parameter: _RecipientLimits_|
 
To see the values of these limits, run the corresponding **Get-** cmdlet for the recipient type in the Exchange Management Shell.

For example, to see the limits that are configured on a specific mailbox, run the following command:

```
Get-Mailbox <MailboxIdentity> | Format-List MaxReceiveSize,MaxSendSize,RecipientLimits
```

To see the limits that are configured on all user mailboxes, run the following command:

```
$mb= Get-Mailbox -ResultSize unlimited; $mb | where {$_.RecipientTypeDetails -eq 'UserMailbox'} | Format-Table Name,MaxReceiveSize,MaxSendSize,RecipientLimits
```

## Order of precedence and placement of message size limits
<a name="Order"> </a>

The order of precedence for message size limits is the most restrictive limit is enforced. The only question is where that limit is enforced. The goal is to reject messages that are too large as early in the transport pipeline as possible. For example, it's a waste of system resources for the Internet Receive connector to accept large messages that are eventually rejected because of a lower organizational limit. Make sure that your organization, server, and connector limits are configured in a way that minimizes any unnecessary processing of messages. You do this by keeping the limits the same in all locations, or by configuring more restrictive limits where messages enter your Exchange organization.

An exception to the order is message size limits on mailboxes and messages size limits in mail flow rules (also known as transport rules). Exchange checks the maximum message size that's allowed on mailboxes before mail flow rules process messages. For example, your organization's message size limit is 50 MB, you configure a 35 MB limit on a mailbox, and you configure a mail flow rule to find and reject messages larger than 40 MB. If an external sender sends a 45 MB message to the mailbox, the message is rejected before the mail flow rule is able to evaluate the message.

Recipient limits between authenticated senders and recipients (typically, internal message senders and recipients) are exempt from the organizational message size restrictions. Therefore, you can configure specific senders and recipients to exceed the default message size limits for your organization. For example, you can allow specific mailboxes to send and receive larger messages than the rest of the organization by configuring custom send and receive limits for those mailboxes.

However, this exemption applies only to messages sent between authenticated senders and recipients (typically, internal senders and recipients). For messages sent between anonymous senders and recipients (typically, Internet senders or Internet recipients), the organizational limits apply. For example, suppose your organizational message size limit is 10 MB, but you configured the users in your marketing department to send and receive messages up to 50 MB. These users will be able to exchange large messages with each other, but not with Internet senders and recipients (unauthenticated senders and recipients).

## Messages exempt from size limits
<a name="Exempt"> </a>

The following list shows the types of messages that are generated by Mailbox servers or Edge Transport servers that are exempted from all message size limits except the organizational limit for the maximum number of recipients that are allowed in a message:

- System messages

- Agent-generated message

- Delivery status notification (DSN) messages (also known as non-delivery reports, NDRs, or bounce messages). However, you can use the _ExternalDsnMaxMessageAttachSize_ and _InternalDsnMaxMessageAttachSize_ parameters on the **Set-TransportConfig** cmdlet to limit the size of original messages that are included in DSN messages (hence, the effective size of the DSN message itself).

- Journal report messages

- Quarantined messages


