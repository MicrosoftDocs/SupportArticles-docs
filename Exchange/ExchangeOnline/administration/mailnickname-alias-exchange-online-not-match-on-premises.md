---
title: MailNickname or Alias attribute in Exchange Online doesn't match Exchange on-premises settings
description: Fixes an issue in which the Alias or Mailnickname attribute in Exchange Online doesn't match what's set in the on-premises environment for a synced user account.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Exchange Online
- Microsoft Exchange Online Dedicated
search.appverid: MET150
ms.reviewer: rrajan, v-maqiu, ninob, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# MailNickName or Alias attribute in Exchange Online doesn't match what is set in Exchange on-premises

## Symptoms

The `Alias` or `Mailnickname` attribute in Microsoft Exchange Online doesn't match what is set in the Exchange on-premises environment for a synced user account.

## Cause

This issue occurs if changes are made to the user principal name (UPN) for the user and the `Mailnickname` attribute value is changed to the prefix of the UPN.

## Resolution

To resolve this issue, update the `Alias` or `Mailnickname` attribute. To do this, use one of the following methods.

### Method 1: Use Exchange Management Shell

1. Change the existing `Alias` attribute value so that the change is found by Microsoft Entra Connect. This should sync the change to Microsoft 365. To do this, use either the `Set-Mailbox` or `Set-RemoteMailbox` cmdlet, based on the recipient type in Exchange on-premises.

      - `Set-RemoteMailbox`

          ```powershell
          $alias=Get-remotemailbox <user@domain.com>
          Set-RemoteMailbox <user@domain.com> -alias "$($alias.alias)1"
          ```

      - `Set-Mailbox`

          ```powershell
          $alias=Get-mailbox <user@domain.com>
          Set-Mailbox <user@domain.com> -alias "$($alias.alias)1"**
          ```
  
2. Start a Delta sync from Microsoft Entra Connect, or wait for Microsoft Entra Connect to run the delta. Ideally, this should sync the changes that are made in step 1 to Microsoft 365.
3. Change the value of the `Alias` attribute to its original value. To do this, run either of the following cmdlets:

      ```powershell
      Set-RemoteMailbox <user@domain.com> -alias "$($alias.alias)"
      ```

      ```powershell
      Set-Mailbox <user@domain> -alias "$($alias.alias)"
      ```  

4. Start a Delta sync from Microsoft Entra Connect, or wait for Microsoft Entra Connect to run the delta> Ideally, this should sync the changes to Microsoft 365.

### Method 2: Use Active Directory PowerShell module

1. Change the `Mailnickname` attribute value so that the change is discovered by Microsoft Entra Connect. This should sync the change to Microsoft 365. To do this, run the following set of cmdlets:

      ```powershell
      $mailnickname=Get-ADUser -Properties * -Filter {name -like '<username>*'}
      Get-ADUser -Properties * -Filter {name -like '<username>*'} | set-aduser -replace @{mailnickname="$($mailnickname.mailnickname)1"
      ```  

2. Start a Delta sync from Microsoft Entra Connect, or wait for Microsoft Entra Connect to run the delta. Ideally, this should sync the changes that are made in step 1 to Microsoft 365.
3. Change the value of the `Mailnickname` attribute to its original value. To do this, run the following cmdlet:

     ```powershell
     Get-ADUser -Properties * -Filter {name -like '<username>*'} | set-aduser -replace @{mailnickname="$($mailnickname.mailnickname)"
     ```  

4. Start a Delta sync from Microsoft Entra Connect, or wait for Microsoft Entra Connect to run the delta. Ideally, this should sync the changes that are made in step 1 to Microsoft 365.
