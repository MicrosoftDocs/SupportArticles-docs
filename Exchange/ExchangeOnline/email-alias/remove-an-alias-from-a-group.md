---
title: Troubleshoot Remove an alias from a group
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
f1_keywords: 
  - 'O365P_AdminGroups_TSAlias'
  - 'O365M_AdminGroups_TSAlias'
  - 'O365E_AdminGroups_TSAlias'
  - 'AdminGroups_TSAlias'
localization_priority: None
ms.collection: 
  - M365-subscription-management
  - Adm_O365
search.appverid: 
  - BCS160
  - MET150
  - MOE150
ms.assetid: d96989c4-6efc-4523-9c89-44ce06e601bf
description: Learn how to remove the email alias from the group using Exchange Online PowerShell.
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Troubleshoot: Remove an alias from a group

Did you get this error when you were creating a new user? "This email address is already being used as an alias for the group \<group name>." This article will show you how to remove the email alias from the group.
  
> [!CAUTION]
> It is unusual for a group to have an alias because it has to be added using Exchange Online PowerShell. You'll have to remove it using Exchange Online PowerShell.
>
> If you're new to PowerShell, you can do this! The Exchange Online PowerShell commands used in this article will only remove an alias from a Microsoft 365 group.
  
## Remove the email alias from the group using Exchange Online PowerShell

Before you can do this procedure, you need the following:
  
- [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell)
- The name of the group
- The email address that you want to remove

1. In Exchange Online PowerShell, replace the group name and email address with your values, and run the following command:

   ```powershell
   Set-UnifiedGroup -Identity "Group name" -EmailAddresses @{remove="alias@contoso.com"}
   ```

2. It may take a few minutes, but when the command has completed, the command prompt will return. You'll only get a message if there was an error.

3. Close the connection to Exchange Online PowerShell by running the following command:

   ```powershell
   Remove-PSSession $Session
   ```