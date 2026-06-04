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

This article describes an issue in which unwanted Automapping behavior occurs after you add or remove mailbox permissions in the Exchange Admin Center (EAC) in a cross-forest environment. The issue occurs because Exchange doesn’t correctly update the attribute that's used for Automapping. This issue can cause a mailbox to continue to appear in Outlook even after permissions are removed. To work around this issue, manage mailbox permissions by using the Exchange Management Shell together with the correct Active Directory object.

## Symptoms

Consider the following scenario:

- You have a cross-Active Directory forest environment that contains [linked mailboxes](/exchange/recipients/linked-mailboxes).
- In the Exchange Admin Center (EAC), you remove the Full Access permission that allows a linked account to access and manage a particular mailbox.

In this scenario, Automapping might experience unwanted results. For example, the linked mailbox might still appear in Outlook.

If the user previously enabled **Download Shared Folders** in Outlook, they might still see mailbox items that were synced earlier. However, because the user no longer has permission, they can’t access or work with the linked mailbox.

## Cause

The issue might occur because the server that's running Microsoft Exchange Server doesn't correctly update the `msExchDelegateListLink` attribute. This attribute is used for Automapping from the Active Directory account when you add or remove the mailbox permission in EAC. The server that's running Exchange Server references the AD object of the account forest instead of the resource forest in which the server is deployed.

## Workaround

To work around this issue, add or remove the mailbox permissions within the Exchange Management Shell, and use the correct AD object.

In the following example, you grant the Full Access permission to the *MailboxTest1* mailbox for the *LinkTest2* account forests. The resource forest (Exchange forest) domain is `contoso.com`, and the account forest domain is `example.com`.  

```powershell
Add-MailboxPermission -Identity 'Contoso\MailboxTest1' -User 'Contoso\LinkTest2' -AccessRights 'FullAccess'
```
