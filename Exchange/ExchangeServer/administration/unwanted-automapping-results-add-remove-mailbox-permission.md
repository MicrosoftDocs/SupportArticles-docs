---
title: Automapping experiences unwanted results
description: This article describes how to work around an issue in which unwanted Automapping results occur if you add or remove mailbox permissions in Exchange Admin Center.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: ninob, dpaul, v-six, v-kccross
ms.custom: 
  - sap:Permissions\Need help with Mailbox permissions (Send As, Send on Behalf, Full Access)
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11875
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 05/12/2026
---

# Unwanted Automapping results occur when you add or remove mailbox permissions in Exchange Admin Center

_Original KB number:_ &nbsp; 4487381

## Summary

## Symptoms

Consider the following scenario:

- You have a cross-Active Directory forest environment that contains [linked mailboxes](/exchange/recipients/linked-mailboxes).
- In the Exchange Admin Center (EAC), you remove the Full Access permission that allows a linked account to access and manage a particular mailbox.

In this scenario, Automapping might experience unwanted results. For example, the linked mailbox might still appear in Outlook.

If the user previously enabled **Download Shared Folders** in Outlook, they might still see mailbox items that were synced earlier. However, because the user no longer has permission, they can’t access or work with the linked mailbox.

## Cause

The issue might occur because the server that is running Microsoft Exchange Server doesn't correctly update the `msExchDelegateListLink` attribute. This attribute is used for Automapping from the Active Directory account when you add or remove the mailbox permission in EAC. The server that is running Exchange Server references the AD object of the account forest instead of the resource forest in which the server is deployed.

## Workaround

To work around this issue, add or remove the mailbox permissions within the Exchange Management Shell, and use the correct AD object.

In the following example, you grant the Full Access permission to mailbox *MailboxTest1* for the *LinkTest2* account forests. The resource forest (Exchange forest) domain is `contoso.com`, and the account forest domain is `example.com`.  

```powershell
Add-MailboxPermission -Identity 'Contoso\MailboxTest1' -User 'Contoso\LinkTest2' -AccessRights 'FullAccess'
```
