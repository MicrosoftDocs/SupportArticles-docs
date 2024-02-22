---
title: Automapping experiences unwanted results
description: This article describes how unwanted Automapping results may occur when you add or remove mailbox permissions in EAC. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: ninob, dpaul, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
---
# Unwanted Automapping results occur when you add or remove mailbox permissions in Exchange Admin Center

_Original KB number:_ &nbsp; 4487381

## Symptoms

Consider the following scenario:

- You're working in a Microsoft Exchange Server 2016 or Exchange Server 2013 organization.
- You have a cross-Active Directory forest environment that contains [linked mailboxes](/exchange/recipients/linked-mailboxes).
- In the Exchange Admin Center (EAC), you remove the Full Access permission from a linked account to a mailbox.

In this scenario, Automapping may experience unwanted results. For example, the linked mailbox may still be displayed in Outlook.

Additionally, if the user had previously selected **Download Shared Folders** in Outlook, the user who no longer has permission to the linked mailbox still sees mail items for the mailbox that were previously synced while the user still had permission. However, the user can no longer do any work out of the linked mailbox.

## Cause

The issue may occur because the server that is running Exchange Server doesn't correctly update the `msExchDelegateListLink` attribute. This attribute is used for Automapping from the Active Directory account when you add or remove the mailbox permission in EAC. The server that is running Exchange Server references the AD object of the account forest instead of the resource forest in which the server is deployed.

## Workaround

To work around this issue, add or remove the mailbox permissions within the Exchange Management Shell, and use the correct AD object.

In the following example, you grant the Full Access permission to mailbox *MailboxTest1* for the *LinkTest2* account forests. The resource forest (Exchange forest) domain is `contoso.com`, and the account forest domain is `example.com`.  

```powershell
Add-MailboxPermission -Identity 'Contoso\MailboxTest1' -User 'Contoso\LinkTest2' -AccessRights 'FullAccess'
```
