---
title: Cannot connect to the mailbox error when searching mailbox
description: Works around an issue in which running the Search-Mailbox cmdlet fails for a mailbox that's in a different region from the one for the administrator's account.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - CSSTroubleshoot
appliesto:
- Exchange Online
- Exchange
- Outlook
search.appverid: MET150
ms.reviewer: kellybos, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# "Can't connect to the mailbox" error when you run cmdlets for a mailbox hosted in a different Exchange Online region

## Symptoms

Assume that you are an account administrator. When you try to run the `Search-Mailbox` cmdlet for a mailbox that's hosted in a different region from your account region, you receive the following error message:

> Can't connect to the mailbox of user Mailbox database guid \<GUID> because the ExchangePrincipal object contains outdated information. The mailbox may have been moved recently.

However, in this scenario, you can do the following actions:

- You can successfully run this cmdlet for a mailbox that's hosted in the same region as your account region.
- You can successfully run other cmdlets, such as `Set-CalendarProcessing` or `Get-Mailbox`, for mailboxes that are hosted in a different region.

## Cause

This issue occurs because the cmdlet doesn't work for a mailbox that's in a different region from the administrator's region.

## Workaround 1

Use the search and delete functionality in the Security & Compliance Center.

## Workaround 2

Force a connection to another region by changing the value of the `ConnectionUri` parameter when you use the `New-PSSession` cmdlet. For example, you can run the following cmdlet:

```ps
New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid?email=alias@contoso.com-Credential $UserCredential -Authentication  Basic -AllowRedirection
```

The appended email address in the `ConnectionUri` parameter should be for a mailbox in the region for which you want to run the `Search-Mailbox` cmdlet.

For example, if your mailbox is in the **European Union** region, and you want to run the cmdlet against a mailbox in the **United States** region, you have to locate a mailbox in the **United States** region (it can be any mailbox in that region), and then append the email address of that mailbox to the `ConnectionUri` parameter. To be able to do this, you don't have to have special permissions to the **United States** mailbox. Appending the email address forces the connection to be made in the **United States** region. This enables the cmdlets to be run successfully for a **United States** mailbox.
