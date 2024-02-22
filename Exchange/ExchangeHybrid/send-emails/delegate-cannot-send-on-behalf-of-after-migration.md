---
title: Delegate can't send on behalf of after migration
description: Describes an issue in which a newly added delegate can't send on behalf of a user when the user is moved to Microsoft 365 hybrid environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Delegate can't send on behalf of after migration to Microsoft 365 hybrid environment

_Original KB number:_ &nbsp; 4039613

## Symptoms

If your mailbox is migrated to Exchange Online and add a delegate who has the mailbox in the on-premises environment, the delegate can't send emails on behalf of you with the mailbox in Exchange Online. The folder access and meeting invite-forwarding rule work as expected.

## Cause

This issue occurs because the `publicDelegates` attribute (`GrantSendOnBehalfTo`) is not currently written back to the on-premises Active Directory Domain Services. This is by default.

## Resolution

To automatically write back the send on behalf (`publicDelegates`) attribute, the user must enable the Microsoft Entra Connect Exchange hybrid deployment settings and must be running version 1.1.553 or a later version. For more information, see the following articles:

- [Exchange hybrid writeback](/azure/active-directory/hybrid/reference-connect-sync-attributes-synchronized#exchange-hybrid-writeback)
- [Microsoft Entra Connect Version 1.1.553.0](/azure/active-directory/hybrid/reference-connect-version-history#115530)

As a workaround, an administrator can manually add the **send on behalf** permission by using Remote PowerShell. To do this, run the following cmdlet:

```powershell
Set-MailUser UserSMTPAddress -GrantSendOnBehalfTo DelegateSMTPAddress
```

After this permission is manually added, the delegate will be able to send on behalf of the user.

**For Microsoft 365 dedicated/ITAR users only:**

If you migrate from a legacy dedicated environment to Microsoft 365, you have to add the **send on behalf** permission manually. The values are not automatically written back to the dedicated users who moved their mailboxes to vNext.

You can use the following options:

Option 1

Administrators who are a member of the SSA-SE-RemoteMailbox role group can run the following cmdlet:

```powershell
Set-RemoteMailbox <mailbox> -GrantSendonBehalfTo <delegate>
```

Option 2

You can submit a request to Microsoft Support to add the `GrantSendOnBehalfTo` permission to the remote mailbox.
