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
# Error when searching mailbox by using Search-Mailbox cmdlet

## Symptoms

To search messages from a mailbox and copy the search results to a target mailbox, you run the [Search-Mailbox](/powershell/module/exchange/search-mailbox) cmdlet with the `LogLevel` parameter set to **Full**. For example:

```powershell
Get-Mailbox -Identity mailbox1@contoso.com | Search-Mailbox -SearchQuery 'Subject:"Quarterly Results"' -TargetMailbox admin1@contoso.com -LogOnly -LogLevel Full
```

In this case, the search is failed with the following warning message:

> WARNING: The Search-Mailbox cmdlet returns up to 10000 results per mailbox if a search query is specified. To return more than 10000 results, use the New-MailboxSearch cmdlet or the In-Place eDiscovery & Hold console in the Exchange Administration Center.  
> Cannot save changes made to an item to store.  
                + CategoryInfo                  : InvalidArgument: (:) [], ObjectNotFoundException  
                + FullyQualifiedErrorId   : [Server=<server_name>,RequestId=<request_id>,TimeStamp=<date_and_time>] [FailureCategory =Cmdlet-ObjectNotFoundException] 1227BC9F  
                + PSComputerName       : server_name.contoso.com

However, if you run the cmdlet with the `LogLevel` parameter set to **Basic**, the search is successful.

## Cause

This issue occurs because the target mailbox has a retention policy enabled. When you run the cmdlet with the `LogLevel` parameter set to **Full**, an email message is created in the target mailbox. However, the retention policy modifies the message so that the log that contains the search results isn't attached to the message and the error occurs.

## Workaround

To work around this issue, use either of the following methods:

### Method 1: Run the New-MailboxSearch cmdlet to perform the search

```powershell
New-MailboxSearch -Name mailbox1@contoso.com -SourceMailboxes mailbox1@contoso.com -TargetMailbox admin1@contoso.com -SearchQuery 'Subject:"Quarterly Results"' -LogLevel Full
```

**Note:** The [New-MailboxSearch](/powershell/module/exchange/new-mailboxsearch) cmdlet will not remove the search results from the source mailbox.

### Method 2: Run the New-ComplianceSearch and New-ComplianceSearchAction cmdlets together to perform the search

1. Create a compliance search by running the following [New-ComplianceSearch](/powershell/module/exchange/new-compliancesearch) cmdlet:

    ```powershell
    New-ComplianceSearch -Name mailbox1@contoso.com -ExchangeLocation mailbox1@contoso.com -ContentMatchQuery 'Subject:"Quarterly Results"' -LogLevel Full
    ```

2. Create an action for the search by running either of the following [New-ComplianceSearchAction](/powershell/module/exchange/new-compliancesearchaction) cmdlets:

    ```powershell
    New-ComplianceSearchAction -SearchName mailbox1@contoso.com -Preview
    ```

    ```powershell
    New-ComplianceSearchAction -SearchName mailbox1@contoso.com -Purge -PurgeType SoftDelete
    ```

    ```powershell
    New-ComplianceSearchAction -SearchName mailbox1@contoso.com -Purge -PurgeType HardDelete
    ```

    **Note:** Using the `Purge` parameter will remove the search results from the source mailbox.

### Method 3: Remove the retention policy from the target mailbox

1. Remove the retention policy by running the following cmdlet:

    ```powershell
    Set-Mailbox admin1@contoso.com -RemoveManagedFolderAndPolicy
    ```

2. Start the messaging records management (MRM) processing of the target mailbox.

    ```powershell
    Start-ManagedFolderAssistant admin1@contoso.com
    ```

3. Run the `Search-Mailbox` cmdlet again.

**Note:** This method may result in unexpected data loss of the mailbox.
