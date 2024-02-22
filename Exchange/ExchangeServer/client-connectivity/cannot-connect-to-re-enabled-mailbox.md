---
title: Can't connect to a mailbox after it's re-enabled
description: Describes an issue that prevents users from accessing their mailboxes after they've been disabled and then re-enabled. Affects Exchange Server 2016 and 2013 environments. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Can't connect to a mailbox after it's re-enabled in Exchange Server

_Original KB number:_ &nbsp; 3132711

After a user's mailbox is re-enabled in an Exchange Server 2016 or Exchange Server 2013 environment, the user can't access their mailbox by using one or more client protocols.

When a user account has the Exchange mailbox disabled, the following Exchange attributes aren't removed from the user object:

- `msExchAddressBookFlags`
- `msExchBypassAudit`
- `msExchPreviousRecipientTypeDetails`
- `msExchProvisioningFlags`
- `msExchRecipientSoftDeletedStatus`
- `msExchUMDtmfMap`
- `msExchWhenMailboxCreated`
- `protocolSettings`

Use the `Set-CASMailbox` cmdlet to enable the client protocol that's required for the user to connect to their mailbox. For example, to enable Outlook Anywhere for the user, run the following cmdlet:

```powershell
Set-CASMailbox Jim -MAPIBlockOutlookRpcHttp:$False
```
