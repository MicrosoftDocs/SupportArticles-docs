---
title: Exchange error-Insufficient access rights to perform the operation
description: Exchange Server management tasks fail with insufficient rights.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Need help with Active Directory/DNS/Network Exchange pre-requisites
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 10004
ms.reviewer: v-six, v-kccross
appliesto: 
  - Exchange Server
search.appverid: MET150
ms.date: 07/15/2026
---

# Error when you try to perform Exchange Server management tasks: Insufficient access rights to perform the operation  

_Original KB number:_ &nbsp;3096158

## Summary

This article describes an issue that occurs when users try to perform Exchange Server management tasks. The issue occurs when security identifier (SID) filter quarantining is enabled between domains in the same forest. The article explains how users can resolve the issue.

## Symptoms

When you try to perform Microsoft Exchange Server management tasks such as [Set-Mailbox](/powershell/module/exchangepowershell/set-mailbox) and [New-MoveRequest](/powershell/module/exchangepowershell/new-moverequest) in a multidomain environment, you receive a message similar to the following error message:

> Active Directory operation failed on dc1.contoso.com. This error is not retriable. Additional information: Insufficient access rights to perform the operation.  
> Active directory response: 00002098: SecErr: DSID-03150889, problem 4003 (INSUF_ACCESS_RIGHTS), data 0

This issue occurs only when you're running cmdlets against mailboxes in a domain where the Exchange universal security groups are located, for example, in an Exchange Trusted Subsystem.

## Cause

This issue occurs if SID filter quarantining is enabled between domains in the same forest. When you turn on this feature, the domain where the Exchange universal security groups reside discards the SIDs of the universal security groups from the tokens for users in other domains. Users who are members of an Exchange Trusted Subsystem group, such as the Exchange servers themselves, can't act as members of an Exchange Trusted Subsystem group when those members are in other domains. Because the Exchange management cmdlets use the security context of the computer account to update recipients, any attempts to update the recipients in that domain fail.

The SID quarantine isn't enabled by default. To verify if the quarantine is currently enabled, run the following command on the domain controller:

```input
netdom trust "Contoso.com" /domain:"child.contoso.com" /Quarantine
```

If quarantine is enabled, the output contains a message similar to the one in the following example:

```input
Netdom trust "Contoso.com" /domain:"child.contoso.com" /Quarantine

SID filtering is enabled for this trust. Only SIDs from the trusted domain
will be accepted for authorization data returned during authentication. SIDs
from other domains will be removed.

The command completed successfully.
```

## Resolution

To fix this issue, disable SID filter quarantining between domains in the same forest.

To disable the SID quarantine, run the following command on the domain controller:

```input
netdom trust "Contoso.com" /domain:"child.contoso.com" /Quarantine:No
```
