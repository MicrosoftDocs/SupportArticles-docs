---
title: Changes to msExchangeHiddenFromAddressList not updated
description: Provides a fix for an issue in which changes made to the msExchangeHiddenFromAddressList attribute are not updated against the recipient object in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: gabesl, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 12/15/2023
---
# Changes to msExchangeHiddenFromAddressList attribute not updated against recipient object in Exchange Online

_Original KB number:_ &nbsp; 4042820

## Symptoms

Consider the following scenario:

- You change the `msExchangeHiddenFromAddressList` attribute in on-premises.
- The attribute is synced by using Microsoft Entra Connect.

In this scenario, the changes are not updated against the recipient object in Microsoft Exchange Online.

## Cause

This issue occurs due to one of the following reasons:

- The Alias (`MailNickname`) attribute on the source object that's located in on-premises doesn't have the required value.
- A sync rule in Microsoft Entra Connect has a scoping filter that states that the **Operator** of the `MailNickName` attribute is **ISNOTNULL**. The rule sets **Link Type** to **Join** for syncing Exchange attributes together and uses the name **In From AD - User Exchange**.

## Resolution

To resolve this issue, follow these steps:

1. Start PowerShell as an administrator on any domain controller or any server that has Remote Server Administrator pack installed. To determine whether any Active Directory module is present on the server, run the following cmdlet:

    ```powershell
    Get-Module -ListAvailable activedirectory
    ```  

2. Import the Active Directory module for PowerShell versions earlier than 3.0. To do this, run the following cmdlet:

    ```powershell
    Import-Module activedirectory
    ```  

    For PowerShell module 3.0 and later versions, the module will load automatically based on the commands that are issued.

3. Validate that the `mailnickname` attribute is not set to any value. To do this, run the following cmdlet:

    ```powershell
    Get-ADObject -Filter {Name -eq ObjectName} -Properties * | Out-String -Stream | Select-String mailnickname
    ```

4. Set the value of the `mailnickname` attribute to a value that corresponds to the information in the [ms-Exch-Mail-Nickname Attribute](/previous-versions/office/developer/exchange-server-2003/ms981776(v=exchg.65)).

    ```powershell
    Get-ADObject -Filter {Name -eq ObjectName } -Properties * | Set-ADObject -add @{mailnickname=AttributeValue}
    ```  

## More information

If the issue still persists, check for and resolve data validation errors in your tenant.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
