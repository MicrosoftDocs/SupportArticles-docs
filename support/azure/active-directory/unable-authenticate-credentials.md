---
title: Unable to authenticate your credentials error when you connect to Microsoft Entra ID
description: Describes an issue that triggers an Unable to authenticate your credentials. Make sure that your user name is in the format <username>@<domain> error. Occurs when you use the Azure Active Directory module for Windows PowerShell to connect to Microsoft Entra ID.
ms.date: 05/11/2020
ms.reviewer: willfid
ms.service: entra-id
ms.subservice: users
ms.custom: has-azure-ad-ps-ref
---
# "Unable to authenticate your credentials" error when you try to connect to Microsoft Entra ID

_Original product version:_ &nbsp; Microsoft Entra ID, Cloud Services (Web roles/Worker roles), Microsoft Intune, Azure Backup, Office 365 User and Domain Management, Office 365 Identity Management  
_Original KB number:_ &nbsp; 2929554

## Symptoms

When you try to connect to Microsoft Entra ID by using the Azure Active Directory module for Windows PowerShell, you receive the following error message:

```console
Connect-MsolService : Unable to authenticate your credentials. Make sure that
your user name is in the format: <username>@<domain>. If this issue persists,
contact Support.

At line:1 char:1
+ Connect-MsolService
+ ~~~~~~~~~~~~~~~~~~~
+ CategoryInfo : OperationStopped: (:) [Connect-MsolService], Mic
rosoftOnlineException
+ FullyQualifiedErrorId : 0x80048862,Microsoft.Online.Administration.Autom
ation.ConnectMsolService
```

## Cause

This issue occurs if one of the following conditions is true:

- You used an incorrect format when you entered your user name.
- Your user account is enabled for Microsoft Entra multifactor authentication.

## Resolution

Do one of the following, as appropriate for your situation.

### Scenario 1: You used an incorrect format when you entered your user name

Use the following format when you enter your user name:

`<user_name >@<domain>`

For example, `john@contoso.com` is in the correct format. Entering `john` or `contoso\john` doesn't work.

<a name='scenario-2-your-user-account-is-enabled-for-azure-ad-multi-factor-authentication'></a>

### Scenario 2: Your user account is enabled for Microsoft Entra multifactor authentication

If your user account is enabled for Microsoft Entra multifactor authentication, Microsoft doesn't currently support using the Azure Active Directory module for Windows PowerShell to connect to Microsoft Entra ID.

To perform administrative tasks by using the Azure Active Directory module for Windows PowerShell, use either of the following methods:

- Disable Microsoft Entra multifactor authentication for the user account.
- Use a different admin account that isn't enabled for Microsoft Entra multifactor authentication.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
