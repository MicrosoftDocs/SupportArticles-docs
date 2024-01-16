---
title: Public folder auto-replies are sent from an incorrect email address
description: Provides a resolution for an issue in which automatic replies from a mail-enabled public folder are sent from an incorrect email address.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 185745
ms.reviewer: haembab, batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/12/2024
---

# Public folder auto-replies are sent from an incorrect email address

## Symptoms

Auto-replies from a mail-enabled public folder have an email address in the **From** field that isn't an email address of the public folder.

## Cause

The email address in the auto-reply **From** field is incorrect because the Microsoft Entra ID object for the mail-enabled public folder is corrupted. The incorrect email address belongs to the public folder mailbox that hosts the content of the mail-enabled public folder.

## Resolution

To fix the issue, re-create the Microsoft Entra ID object for the mail-enabled public folder. Follow these steps:

1. Get the email addresses of the mail-enabled public folder from the corrupted Microsoft Entra ID object. Run the following [Get-MailPublicFolder](/powershell/module/exchange/get-mailpublicfolder) PowerShell cmdlet:

   ```PowerShell
   Get-MailPublicFolder <public folder ID> | Select-Object -ExpandProperty EmailAddresses
   ```

2. Remove the corrupted Microsoft Entra ID object by [disabling email for the public folder](/exchange/collaboration/public-folders/mail-enable-or-disable#use-the-exchange-management-shell-to-mail-disable-a-public-folder). Run the following [Disable-MailPublicFolder](/powershell/module/exchange/disable-mailpublicfolder) PowerShell cmdlet:

   ```PowerShell
   Disable-MailPublicFolder -Identity <public folder ID>
   ```

   Wait five minutes for the command to fully take effect before you go to the next step.

3. Re-create the Microsoft Entra ID object by [enabling email for the public folder](/exchange/collaboration/public-folders/mail-enable-or-disable#use-the-exchange-management-shell-to-mail-enable-a-public-folder). Run the following [Enable-MailPublicFolder](/powershell/module/exchange/enable-mailpublicfolder) PowerShell cmdlet:

   ```PowerShell
   Enable-MailPublicFolder -Identity <public folder ID>
   ```

4. Find the email addresses of the new Microsoft Entra ID object. Run the following [Get-MailPublicFolder](/powershell/module/exchange/get-mailpublicfolder) PowerShell cmdlet:

   ```PowerShell
   Get-MailPublicFolder <public folder ID> | Select-Object -ExpandProperty EmailAddresses
   ```

5. Verify that the new Microsoft Entra ID object has the same email addresses that you found in step 1. If the new Microsoft Entra ID object is missing an email address, add the address by running the following [Set-MailPublicFolder](/powershell/module/exchange/set-mailpublicfolder) PowerShell cmdlet:

   ```PowerShell
   Set-MailPublicFolder -Identity <public folder ID> -EmailAddresses @{add="smtp:<missing email address>"}
   ```

   > [!NOTE]
   > In this command, "smtp" is case-sensitive. Uppercase "SMTP" is used for only the primary SMTP address.
