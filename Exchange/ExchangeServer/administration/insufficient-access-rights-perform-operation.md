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
ms.reviewer: v-six
appliesto: 
  - Exchange Server
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you try to perform Exchange Server management tasks: Insufficient access rights to perform the operation  

_Original KB number:_ &nbsp;3096158

## Symptoms

When you try to perform Microsoft Exchange Server management tasks such as Set-Mailbox and Move-Mailbox in a multidomain environment, you receive the following error message:

> Active Directory operation failed on dc1.contoso.com. This error is not retriable. Additional information: Insufficient access rights to perform the operation.  
> Active directory response: 00002098: SecErr: DSID-03150889, problem 4003 (INSUF_ACCESS_RIGHTS), data 0

This issue occurs only when you are running cmdlets against mailboxes in a domain where the Exchange universal security groups reside, for example, in Exchange Trusted Subsystem.

## Cause

This issue occurs if SID filtering quarantining is enabled between domains in the same forest. When this feature is turned on, the domain where the Exchange universal security groups reside will discard the SIDs of those universal security groups from any tokens for users in other domains. This means that users who are members of Exchange Trusted Subsystem, such as the Exchange servers themselves, will be unable to act as members of Exchange Trusted Subsystem when those members are located in other domains. Because the Exchange management cmdlets use the security context of the computer account to update recipients, any attempts to update the recipients in that domain will fail.

## Resolution

To fix this issue, don't enable SID filter quarantining between domains in the same forest. For information about how to disable SID filter quarantining, see [Disable SID filter quarantining](/previous-versions/windows/it-pro/windows-server-2003/cc772816(v=ws.10)).

## More information

For more information about SID filter quarantining, see [Configuring SID Filtering Settings](/previous-versions/windows/it-pro/windows-server-2003/cc772633(v=ws.10)).
