---
title: Troubleshoot Remove an alias from a distribution list
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Recipients management
  - Exchange Online
  - CSSTroubleshoot
f1_keywords: 
  - 'O365P_AdminDistList_TSAlias'
  - 'O365M_AdminDistList_TSAlias'
  - 'O365E_AdminDistList_TSAlias'
  - 'AdminDistList_TSAlias'
ms.collection: 
  - M365-subscription-management
  - Adm_O365
search.appverid: 
  - BCS160
  - MET150
  - MOE150
ms.assetid: b8c5f0f6-eefd-4d9d-b508-7ef2d84b626b
description: Learn how to remove an email alias from a distribution list using Exchange Online PowerShell.
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Troubleshoot: Remove an alias from a distribution list

Did you get this error when you were creating a new user? "This email address is already being used as an alias for the distribution list \<list name>." This article will show you how to remove the email alias from the distribution list.
  
> [!CAUTION]
> It is unusual for a distribution list to have an alias because it has to be added using Exchange Online PowerShell. You'll have to remove it using Exchange Online PowerShell.
>
> If you're new to PowerShell, you can do this! The Exchange Online PowerShell commands used in this article will only remove an alias from a distribution list.
  
## Remove the email alias from the distribution list using Exchange Online PowerShell

Before you can do this procedure, you need the following:
  
- [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell)
- The name of the distribution list
- The email address that you want to remove

1. In Exchange Online PowerShell, replace the distribution list name and the email address with your values, and run the following command:

   ```powershell
   Set-DistributionGroup -Identity "List name" -Alias @{remove="alias@contoso.com"}
   ```

2. It may take a few minutes, but when the command has completed, the command prompt will return. You'll only get a message if there was an error.

3. Close the connection to Exchange Online PowerShell by running the following command:

   ```powershell
   Remove-PSSession $Session
   ```
