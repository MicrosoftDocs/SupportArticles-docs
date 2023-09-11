---
title: eDiscovery searches are queued indefinitely
description: Describes an issue in which the status of an eDiscovery search in Exchange Online remains in a search has been queued state. Provides a workaround.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 03/31/2022
---
# eDiscovery searches in Exchange Online are queued indefinitely

_Original KB number:_ &nbsp; 2979630

## Symptoms

You perform an eDiscovery search in the Exchange admin center in Exchange Online. However, the status of the search remains in a **search has been queued** state.

## Cause

This problem occurs if the regional setting is **English (Canada)**. When you filter the search by using start and end dates, the **English (Canada)** regional setting configures the `DateFormat` property to use the DD/MM/YY format. This time format is passed to the .NET Framework `DateTime.TryParse` method, and causes the search to fail and throw an exception.

## Workaround

To work around this issue, use one of the following options:

- Don't specify start and end dates. Instead, in the **Keywords** box on the **Search query** page, use date query terms that use the MM/DD/YY format. For example:

  Received>="06/01/2009 7:00:00 AM" AND Received<="06/01/2014 7:00:00 AM"

  Make sure that you use UTC format when you specify the time.

- Use the `Set-MailboxRegionalConfiguration` cmdlet to set the `DateFormat` property of users to the MM/DD/YY format. For more information about this cmdlet, see [Set-MailboxRegionalConfiguration](/powershell/module/exchange/set-mailboxregionalconfiguration?view=exchange-ps&preserve-view=true).

## Status

It's a known issue. We're working to address this issue and will post more information in this article when it becomes available.

## More information

For more info about Keyword Query Language (KQL) syntax, see [Keyword Query Language (KQL) syntax reference](/sharepoint/dev/general-development/keyword-query-language-kql-syntax-reference).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
