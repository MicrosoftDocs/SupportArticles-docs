---
title: Shared or resource mailbox UPN and SamAccountName contain a GUID
description: Resolves an issue in which the UPN and SamAccountName of a shared or resource mailbox contain a GUID.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 178045
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: matbyrd, lusassl, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/24/2024
---

# Shared or resource mailbox UPN and SamAccountName contain a GUID

## Symptoms

You create a [shared mailbox](/microsoft-365/admin/email/about-shared-mailboxes) or a [resource mailbox](/exchange/recipients-in-exchange-online/manage-resource-mailboxes#create-a-resource-mailbox-room-or-equipment-mailbox) in the Exchange admin center (EAC) or by using the [New-Mailbox](/powershell/module/exchange/new-mailbox) PowerShell cmdlet. When you create the mailbox, you don't specify the [UserPrincipalName](/powershell/module/exchange/new-mailbox#-userprincipalname) (UPN) and [SamAccountName](/powershell/module/exchange/new-mailbox#-samaccountname) property values. When you check the default `UserPrincipalName` and `SamAccountName` values that Microsoft Exchange Server assigns to the new mailbox, you see that they each contain a GUID.

For example, you run the following PowerShell commands:

```powershell
New-Mailbox -Shared -Name <mailbox name> -Alias <mailbox alias>
Get-Mailbox <mailbox alias> | FL UserPrincipalName,SamAccountName
```

You expect to see the following output:

```output
UserPrincipalName : <mailbox alias>@<your domain>
SamAccountName : <mailbox alias>
```

However, you see the following output instead:

```output
UserPrincipalName : <GUID>@<your domain>
SamAccountName : <GUID>
```

## Cause

The issue occurs if the mailbox alias meets any of the following criteria:

- Contains characters that aren't letters, numerals, periods, hyphens, or underscores

- Starts with a character that isn't a letter

- Ends in a period

- Contains consecutive periods

- Is longer than 63 characters

## Status

This behavior is by design to make sure that the `UserPrincipalName` and `SamAccountName` property values for a mailbox are unique.

## Resolution

If you don't want the `UserPrincipalName` and `SamAccountName` property values to contain a GUID, you can manually assign the values when you create a shared or resource mailbox. Use the [New-Mailbox](/powershell/module/exchange/new-mailbox) PowerShell cmdlet together with the `UserPrincipalName` and `SamAccountName` parameters. For example, run the following command:

```powershell
New-Mailbox -Room -Name Conference -Alias "12" -UserPrincipalName "12@contoso.com" -SamAccountName "12"
```

For an existing shared or resource mailbox that contains a GUID in the `UserPrincipalName` and `SamAccountName` property values, you can update the values by using the [Set-Mailbox](/powershell/module/exchange/set-mailbox) PowerShell cmdlet together with the `UserPrincipalName` and `SamAccountName` parameters. For example, run the following command:

```powershell
Get-Mailbox "12" | Set-Mailbox -UserPrincipalName "12@contoso.com" -SamAccountName "12"
```
