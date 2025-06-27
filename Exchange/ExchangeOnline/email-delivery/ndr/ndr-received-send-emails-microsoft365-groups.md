---
title: NDR error AggregateGroupMailbox full when sending emails to Microsoft 365 Groups
description: Provides a workaround to an issue in which an NDR is received when sending emails to Microsoft 365 Groups.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - CI 125861
  - CSSTroubleshoot
  - Exchange Online
  - CI 167832
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# "AggregateGroupMailbox is full" when sending emails to Microsoft 365 Groups

## Symptoms

When you send an email message to a Microsoft 365 group, you receive a non-delivery report (NDR) that resembles the following:

> Delivery has failed to these recipients or groups:
>
> `AggregateGroupMailbox.A.201708181918@contoso.onmicrosoft.com` the recipient's mailbox is full and can't accept messages now. Please try resending your message later, or contact the recipient directly.


## Cause

The aggregate group mailbox is an arbitration mailbox. It was used to temporarily store messages that are sent to Microsoft 365 Groups to support a search-related feature. That feature is now deprecated, and the aggregate group mailbox is no longer used. This arbitration mailbox will be removed from all Microsoft 365 tenants in the future.

The arbitration mailbox has an associated retention policy. The policy periodically purges all email messages from the mailbox. However, a heavy mail flow to a Microsoft 365 group might fill up the mailbox before the policy takes effect and purges the content.

## Status

The NDR doesn't affect the actual email delivery to Microsoft 365 Groups.  

## Workaround

Create an Exchange transport rule by using PowerShell cmdlets to delete the email messages that are sent to the aggregate group mailbox from Exchange Online.

For example:

```powershell
New-TransportRule -SentTo @("AggregateGroupMailbox.A.201708181918@contoso.onmicrosoft.com") -DeleteMessage:$true -Name 'rule name' -StopRuleProcessing:$false -Mode 'Enforce' -Comments '' -RuleErrorAction 'Ignore' -SenderAddressLocation 'Header' 
```
**Notes**:

- In this example, `<AggregateGroupMailbox.A.201708181918@contoso.onmicrosoft.com>` represents the SMTP address of the aggregate group mailbox that's mentioned in the NDR.
- This transport rule deletes email messages before they arrive at the aggregate group mailbox. It doesn't affect email delivery to Microsoft 365 Groups.

