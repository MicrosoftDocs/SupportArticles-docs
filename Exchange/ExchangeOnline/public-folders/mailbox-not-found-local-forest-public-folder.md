---
title: The mailbox is not found in the local forest error when you access public folders
description: When you try to access public folders by using EAC or Exchange Online PowerShell, you receive an error The mailbox is not found in the local forest.
author: TobyTu
ms.author: batre
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: exchange-online
localization_priority: Normal
ms.custom: 
- CI 111727
- CSSTroubleshoot
ms.reviewer: batre, EXOL_Triage
appliesto:
- Exchange Online
search.appverid: 
- MET150
---

# “The mailbox is not found in the local forest” error when you access public folders

## Symptoms

When you try to access public folders by using Exchange Admin Center or Exchange Online PowerShell, you receive an error message that resembles the following:

```
The mailbox ‘Mailbox GUID’ is not found in the local forest. Please connect using ConnectionUri as https://outlook.office365.com/powershell-liveid?email=<emailaddressofthemailbox> while running New-PSSession
```

## Cause

This issue occurs when the administrator’s mailbox and public folder mailbox aren't in the same forest.

## Workaround

To work around this issue, follow these steps:

1. Get the SMTP address of the public folder mailbox that’s reported in the error message. To do this, run the following PowerShell commands:

    ```powershell
    Get-Mailbox -PublicFolder ‘Mailbox GUID’ | fl *primarysmtp*
    ```

2. Use this SMTP address like 'User@contoso.onmicrosoft.com' in the connection string to open Exchange Online PowerShell:

    ```powershell
    Import-PSSession -Session (New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid?User@contoso.onmicrosoft.com -Credential (Get-Credential) -Authentication Basic -AllowRedirection) -DisableNameChecking
    ```

## Status

Microsoft is researching this problem and will post more information in this article when it becomes available.

## More information

In this situation, it’s possible that the administrator’s mailbox or public folder mailbox was redistributed among different forests. This may be done as part of the [go-local](https://docs.microsoft.com/office365/enterprise/moving-data-to-new-datacenter-geos) initiative or to load balance mailboxes. Currently, there's no option available in EAC to administer public folders that are in different forest.
