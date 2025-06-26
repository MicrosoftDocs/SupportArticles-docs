---
title: Cannot send emails to an external recipient
description: Describes an issue in which you're told that the host name does not match the IP address.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Online Protection
search.appverid: MET150
ms.date: 01/24/2024
---
# Recipient rejects mail from Exchange Online or Exchange Online Protection and host name does not match IP address error

_Original KB number:_ &nbsp; 3019655

## Symptoms

When users try to send mail from Microsoft Exchange Online or Microsoft Exchange Online Protection to an external recipient, the destination message transfer agent (MTA) rejects the message. The error message that users receive may vary. Typically, it states that the source server's host name does not match its IP address.

## Cause

The recipient server requires that the server name that's contained in the message HELO string have a corresponding pointer (PTR) resource record (reverse IP lookup). Exchange Online and Exchange Online Protection use multiple IP addresses to send mail. Because of DNS limitations, all these IP addresses can't be mapped through the PTR record to the server name that's in the message HELO string.

## Resolution

The method in which Exchange Online and Exchange Online Protection send email by using multiple IP addresses is typical for most large mail systems and is by design. Contact the recipient system administrator for help.

## More information

In Exchange Online and Exchange Online Protection, outgoing email settings use specific patterns. It's important to be aware of these patterns if your recipient servers use PTR record lookups for validation. This is because they explain why messages that are sent from the service might be rejected. The patterns are as follows:

1. The sending IP addresses that are used by Exchange Online and Exchange Online Protection have forward-confirmed reverse DNS records. This means that each sending IP address has both a forward (name-to-IP address) and a reverse (address-to-name) DNS record that contains matching information. For example:

    ```console
    Outbound IP address: 157.56.110.65
    PTR record: 157.56.110.65 = mail-bn1on0065.outbound.protection.outlook.com
    A-record : mail-bn1on0065.outbound.protection.outlook.com = 157.56.110.65
    ```

2. The HELO/EHLO strings that are used to identify the mail servers that are used by the service also contain `outbound.protection.outlook.com`. For example:  
   `na01-bn1-obe.outbound.protection.outlook.com`

    All these HELO/EHLO strings have A records that contain some outgoing IP addresses that correspond to the sending mail servers. (However, the A records do not contain all these outgoing IP addresses.) For example:  
    `HELO na01-bn1-obe.outbound.protection.outlook.com`

    A record: `na01-bn1-obe.outbound.protection.outlook.com`:

    207.46.163.150  
    207.46.163.151  
    207.46.163.152  
    207.46.163.153  
    207.46.163.154  
    207.46.163.155  
    207.46.163.156  
    207.46.163.157  
    207.46.163.158  
    207.46.163.149

3. The PTR records of the IP addresses in the A record of the EHLO/HELO string will not match the HELO/EHLO string of the sending mail server. For example:  
   PTR record: 207.46.163.150: `mail-bn1lp0150.outbound.protection.outlook.com`

   Notice that `mail-bn1lp0150.outbound.protection.outlook.com` does not match `na01-bn1-obe.outbound.protection.outlook.com`.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
