---
title: NDR (AggregateGroupMailbox full) received when sending emails to Microsoft 365 Groups
description: Provides a workaround to an issue in which an NDR is received when sending emails to Microsoft 365 Groups.
author: TobyTu
ms.author: batre
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: exchange-online
localization_priority: Normal
ms.custom: 
- CI 125861
- CSSTroubleshoot
- Exchange Online
ms.reviewer: batre
appliesto:
- Exchange Online
search.appverid: 
- MET150
---

# NDR (AggregateGroupMailbox full) received when sending emails to Microsoft 365 Groups

The aggregate group mailbox has a retention policy associated. The policy purges all email messages from the mailbox periodically. However, a heavy mail flow to a Microsoft 365 group may fill up the mailbox before the policy takes effect and purge the content.  

## Status

The non-delivery report (NDR) doesn't affect the actual email delivery to Microsoft 365 Groups.  

## Workaround

Create an Exchange transport rule to delete the email messages sent to the aggregate group mailbox from Exchange Online by using PowerShell cmdlets.  

For example:

```powershell
New-TransportRule -SentTo @("AggregateGroupMailbox@contoso.onmicrosoft.com") -DeleteMessage:$true -Name 'rule name' -StopRuleProcessing:$false -Mode 'Enforce' -Comments '' -RuleErrorAction 'Ignore' -SenderAddressLocation 'Header' 
```

- The `AggregateGroupMailbox@contoso.onmicrosoft.com` represents the SMTP address of aggregate group mailbox stated in the NDR.  
- This transport rule deletes email messages before they arrive at the aggregate group mailbox. It doesn't affect email delivery to Microsoft 365 Groups.

## More information

The aggregate group mailbox is an arbitration mailbox. It was used to temporarily store emails sent to Microsoft 365 Groups to support a search-related feature. The feature is now deprecated and the aggregate group mailbox is no longer used. This arbitration mailbox will be removed from all Microsoft 365 tenants in the future.
