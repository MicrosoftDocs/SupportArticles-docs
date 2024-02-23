---
title: Credential prompt when accessing on-premises public folders
description: Fixes an issue in which Exchange Online users are prompted for credentials when they try to access on-premises public folders, and a Can't act as owner of a MailUser object error is logged in the Exchange Server log.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 160577
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Credential prompt when accessing on-premises public folders

## Symptoms

Consider the following scenario:

- You have a hybrid environment of Microsoft Exchange Server on-premises and Microsoft Exchange Online.
- You create public folders in Exchange Server on-premises.

In this scenario, users in Exchange Online are repeatedly prompted for credentials when they try to access on-premises public folders.

Additionally, the Exchange Server log (ExchangeInstallDirectory\Logging\MAPI Client Access) contains the following error entry:

> Can't act as owner of a MailUser object.
 
Here's an example of the error message details:

> "RpcDispatch: [LoginPermException] 'User SID: \<SID number>' **can't act as owner of a MailUser object** '/o=ExchangeLabs/ou=Exchange Administrative Group (\<Group name>)/cn=Recipients/cn=\<User identity>-OnPrem' with : \<SID number> and MasterAccountSid  (StoreError=LoginPerm)   at M.E.R.Server.UserManager.User.CorrelateIdentityWithLegacyDN(ClientSecurityContext clientSecurityContext)     at M.E.R.Server.RpcDispatch.<>c__DisplayClassc.\<Connect>b__8()     at M.E.R.Server.RpcDispatch.ExecuteWrapper(Func\`1 getExecuteParameters, Func\`1 executeDelegate, Action\`1"

## Cause

In a hybrid environment, Exchange Online user mailboxes are associated with the owners' on-premises mail user accounts. This issue occurs if the passwords of the on-premises mail user accounts are expired.

## Resolution

To resolve this issue, reset the passwords of the on-premises user accounts that are associated with the Exchange Online mailboxes.
