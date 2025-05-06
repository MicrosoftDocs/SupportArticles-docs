---
title: Unable to update the password for Windows in Exchange
description: Describes an error when users reset their Windows password on a computer that's not domain-joined in an Exchange Server environment. A resolution is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Need help with Active Directory/DNS/Network Exchange pre-requisites
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when users reset Windows password in an Exchange environment: Unable to update the password
  
_Original KB number:_ &nbsp;3090164

## Symptoms

Users in a Microsoft Exchange Server environment receive the following error message when they try to set a new password for Windows:

> Unable to update the password. The value provided for the new password does not meet the length, complexity, or history requirements of the domain.

> [!NOTE]
> The Exchange ActiveSync mailbox policy setting is configured to use the following password requirements:
>
> ```console
> AlphanumericPasswordRequired : False
> PasswordEnabled              : True
> PasswordRecoveryEnabled      : False
> AllowSimplePassword          : True
> MinPasswordLength            : 4
> MaxPasswordFailedAttempts    : 10
> PasswordExpiration           : Unlimited
> PasswordHistory              : 0
> MinPasswordComplexCharacters : 1
> ```

## Cause

Local accounts must meet the following requirements when any password policy is set:

```console
MinPasswordLength            : 6
MinPasswordComplexCharacters : 3
```

## Resolution

This behavior is by design. The user must create a password that meets these complexity requirements.

## More information

For more information, see the [Exchange ActiveSync policy engine overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn282287(v=ws.11)).
