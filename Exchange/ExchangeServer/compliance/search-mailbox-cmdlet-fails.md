---
title: Can't search using Search-Mailbox cmdlet
description: A retention policy that's applied on a target mailbox affects how the Search-Mailbox cmdlet searches messages from a source mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Messaging Policy and Compliance\Issues with eDiscovery, import/export of mailbox
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
ms.date: 01/24/2024
---
# Error when using the Search-Mailbox cmdlet

## Symptoms

When you run the [Search-Mailbox](/powershell/module/exchange/search-mailbox) cmdlet by having the `LogLevel` parameter set to **Full**, the cmdlet fails and returns the following warning message:

> WARNING: The Search-Mailbox cmdlet returns up to 10000 results per mailbox if a search query is specified. To return more than 10000 results, use the New-MailboxSearch cmdlet or the In-Place eDiscovery & Hold console in the Exchange Administration Center.  
> Cannot save changes made to an item to store.  
                + CategoryInfo                  : InvalidArgument: (:) [], ObjectNotFoundException  
                + FullyQualifiedErrorId   : [Server=<server_name>,RequestId=<request_id>,TimeStamp=<date_and_time>] [FailureCategory =Cmdlet-ObjectNotFoundException] 1227BC9F  
                + PSComputerName       : server_name.contoso.com

However, if you run the cmdlet by having the `LogLevel` parameter set to **Basic**, the search is successful.

## Cause

This issue occurs if a retention policy is set on the target mailbox that you specify in the `Search-Mailbox` cmdlet. The cmdlet creates an email message in the target mailbox when it runs by having the `LogLevel` parameter specified, and it attaches to the message a log file that includes the search results. However, the retention policy modifies this email message right after it is created. Therefore, the cmdlet can't attach the log file, and this triggers the warning.

## Workaround

To work around this issue, use one of the following methods to do the search.

### Method 1: Run the New-MailboxSearch cmdlet

```powershell
New-MailboxSearch -Name <search_name> -SourceMailboxes mailbox1@contoso.com -TargetMailbox admin1@contoso.com -SearchQuery 'Subject:"Quarterly Results"' -LogLevel Full
```

**Note:** The [New-MailboxSearch](/powershell/module/exchange/new-mailboxsearch) cmdlet doesn't remove the search results from the source mailbox.

### Method 2: Run both the New-ComplianceSearch and New-ComplianceSearchAction cmdlets

1. To create a compliance search, run the [New-ComplianceSearch](/powershell/module/exchange/new-compliancesearch) cmdlet:

    ```powershell
    New-ComplianceSearch -Name <search_name> -ExchangeLocation mailbox1@contoso.com -ContentMatchQuery 'Subject:"Quarterly Results"' -LogLevel Full
    ```

2. To create an action for the compliance search, run one of the following [New-ComplianceSearchAction](/powershell/module/exchange/new-compliancesearchaction) cmdlets:

    ```powershell
    New-ComplianceSearchAction -SearchName <search_name> -Preview
    ```

    ```powershell
    New-ComplianceSearchAction -SearchName <search_name> -Purge -PurgeType SoftDelete
    ```

    ```powershell
    New-ComplianceSearchAction -SearchName <search_name> -Purge -PurgeType HardDelete
    ```

    **Note:** Use the `Purge` parameter to remove the search results from the source mailbox.

### Method 3: Remove the retention policy from the target mailbox

> [!NOTE]
> This method might cause unexpected data loss for the mailbox.

1. To remove the retention policy, run the following cmdlet:

    ```powershell
    Set-Mailbox admin1@contoso.com -RemoveManagedFolderAndPolicy
    ```

2. To process the target mailbox immediately, run the following cmdlet to force the Managed Folder Assistant:

    ```powershell
    Start-ManagedFolderAssistant admin1@contoso.com
    ```

3. Run the `Search-Mailbox` cmdlet again.
