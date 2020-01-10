---
title: Offboarding mailbox fails with error "Error MigrationPermanentException Target user ‎'User‎' already has a primary mailbox."
description: Describes an error message that you receive when you Offboard mailboxes from your on-premises environment to Office 365 in a hybrid deployment. Provides a resolution.
author: TobyTu
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: rrajan
manager: dcscontentpm
ms.custom: CSSTroubleshoot
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# Offboarding mailbox fails with error "Error: MigrationPermanentException: Target user ‎'User‎' already has a primary mailbox."

## Symptoms

Assume that you are in a Microsoft Exchange hybrid environment. When you try to offboard Exchange Online mailboxes to the on-premises organization by using the migration batch in Office 365 Exchange Admin Center (EAC), the attempt fails, and you receive an error message that resembles the following:

```
‘Error: MigrationPermanentException: Target user ‎'User‎' already has a primary mailbox.’.
```

## Cause

This issue occurs because the HomeMDB and HomeMTA attributes are present on the user object in on-premises Active Directory, and they contain values.

## Resolution

To fix this issue, follow these steps:

Step 1: Install Active Directory PowerShell Module, and then run either of the following PowerShell commands to review the values of the homeMDB and homeMTA attributes on the user object.

Command option 1

```powershell
Get-ADUser -Filter {userprincipalname -eq 'user@contoso.com'} -properties homemdb,homemta
```

Command option 2

```powershell
Get-ADUser -Identity 'SAMAccountName of the user' -properties homemdb,homemta
```

Step 2: Clear the values of the homemdb and homemta attributes. To do this, run either of the following PowerShell commands:

Command option 1

```powershell
Get-ADUser -Filter {userprincipalname -eq 'user@contoso.com'} -properties homemdb,homemta | Set-ADObject -clear homemdb,homemta
```

Command option 2

```powershell
Get-ADUser -Identity 'SAMAccountName of the user' -properties homemdb,homemta | Set-ADobject -clear homemdb,homemta
```

Step 3: Select the affected users in the migration batch, and then start the batch to move the users again. In this step, you could also use the following PowerShell command:

```powershell
Start-MigrationUser -Identity user@contoso.com
```
