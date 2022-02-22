---
title: Credential prompt when accessing on-premises public folders
description: Fixes an issue in which Exchange Online users are prompted for credentials when they try to access on-premises public folders. Also the "Can't act as owner of a MailUser object" error shows in the Exchange Server log.
author: MaryQiu1987
ms.author: v-maqiu
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
---

# Credential prompt when accessing on-premises public folders

## Symptoms

Consider the following scenario:

- You have a hybrid environment of Microsoft Exchange Server on-premises and Microsoft Exchange Online.
- You have created public folders in Exchange Server on-premises.

In this scenario, uses in Exchange Online are repeatedly prompted for credentials when they try to access on-premises public folders.

Additionally, if you check the Exchange Server log (ExchangeInstallDirectory\Logging\MAPI Client Access), you see the following error message in the log:

> Can't act as owner of a MailUser object.

Here's an example of the detailed error message:

> "RpcDispatch: [LoginPermException] 'User SID: \<SID number>' can't act as owner of a MailUser object '/o=ExchangeLabs/ou=Exchange Administrative Group (\<Group name>)/cn=Recipients/cn=\<User identity>-OnPrem' with : \<SID number> and MasterAccountSid  (StoreError=LoginPerm)   at M.E.R.Server.UserManager.User.CorrelateIdentityWithLegacyDN(ClientSecurityContext clientSecurityContext)     at M.E.R.Server.RpcDispatch.<>c__DisplayClassc.\<Connect>b__8()     at M.E.R.Server.RpcDispatch.ExecuteWrapper(Func\`1 getExecuteParameters, Func\`1 executeDelegate, Action\`1"

## Cause

In a hybrid environment, Exchange Online users' mailboxes are associated with their on-premises mail user accounts. This issue occurs if the passwords of the on-premises mail user accounts are expired.

## Resolution

To resolve this issue, reset the passwords of the on-premises user accounts that are associated with the Exchange Online mailboxes.
