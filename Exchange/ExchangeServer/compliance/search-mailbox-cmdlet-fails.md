---
title: Can't search using Search-Mailbox cmdlet
description: A retention policy that's applied on a target mailbox affects how the Search-Mailbox cmdlet searches messages from a source mailbox.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 163129
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jeffrem, johage, lindabr
appliesto:
  - Exchange Server 2013
  - Exchange Server 2013 Enterprise
  - Exchange Server 2016
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2019
search.appverid: MET150
ms.date: 6/20/2022
---
# Error when using the Search-Mailbox cmdlet

## Symptoms

When you run the [Search-Mailbox](/powershell/module/exchange/search-mailbox) cmdlet with the `LogLevel` parameter set to **Full**, the cmdlet fails with the following warning message:

> WARNING: The Search-Mailbox cmdlet returns up to 10000 results per mailbox if a search query is specified. To return more than 10000 results, use the New-MailboxSearch cmdlet or the In-Place eDiscovery & Hold console in the Exchange Administration Center.  
> Cannot save changes made to an item to store.  
                + CategoryInfo                  : InvalidArgument: (:) [], ObjectNotFoundException  
                + FullyQualifiedErrorId   : [Server=<server_name>,RequestId=<request_id>,TimeStamp=<date_and_time>] [FailureCategory =Cmdlet-ObjectNotFoundException] 1227BC9F  
                + PSComputerName       : server_name.contoso.com

However, if you run the cmdlet with the `LogLevel` parameter set to **Basic**, the search is successful.

## Cause

This issue occurs when a retention policy is set on the target mailbox that you specify in the `Search-Mailbox` cmdlet. The cmdlet creates an email message in the target mailbox when it runs with the `LogLevel` parameter specified and attaches a log file with the search results to the message. However, the retention policy modifies this email message right after it is created. So the cmdlet is unable to attach the log file and triggers the warning.

## Workaround

To work around this issue, use one of the following methods to perform the search:

### Method 1: Run the New-MailboxSearch cmdlet

```powershell
New-MailboxSearch -Name mailbox1@contoso.com -SourceMailboxes mailbox1@contoso.com -TargetMailbox admin1@contoso.com -SearchQuery 'Subject:"Quarterly Results"' -LogLevel Full
```

**Note:** The [New-MailboxSearch](/powershell/module/exchange/new-mailboxsearch) cmdlet doesn't remove the search results from the source mailbox.

### Method 2: Run both the New-ComplianceSearch and New-ComplianceSearchAction cmdlets

1. Run the [New-ComplianceSearch](/powershell/module/exchange/new-compliancesearch) cmdlet to create a compliance search:

    ```powershell
    New-ComplianceSearch -Name mailbox1@contoso.com -ExchangeLocation mailbox1@contoso.com -ContentMatchQuery 'Subject:"Quarterly Results"' -LogLevel Full
    ```

2. Run one of the following [New-ComplianceSearchAction](/powershell/module/exchange/new-compliancesearchaction) cmdlets to create an action for the compliance search:

    ```powershell
    New-ComplianceSearchAction -SearchName mailbox1@contoso.com -Preview
    ```

    ```powershell
    New-ComplianceSearchAction -SearchName mailbox1@contoso.com -Purge -PurgeType SoftDelete
    ```

    ```powershell
    New-ComplianceSearchAction -SearchName mailbox1@contoso.com -Purge -PurgeType HardDelete
    ```

    **Note:** Use the `Purge` parameter to remove the search results from the source mailbox.

### Method 3: Remove the retention policy from the target mailbox

> [!NOTE]
> This method may result in unexpected data loss of the mailbox.

1. Run the following cmdlet to remove the retention policy:

    ```powershell
    Set-Mailbox admin1@contoso.com -RemoveManagedFolderAndPolicy
    ```

2. Run the following cmdlet to force the Managed Folder Assistant to process the target mailbox immediately:

    ```powershell
    Start-ManagedFolderAssistant admin1@contoso.com
    ```

3. Run the `Search-Mailbox` cmdlet again.
