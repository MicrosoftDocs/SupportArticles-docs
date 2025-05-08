---
title: How to use mailbox audit logs in Microsoft 365
description: Describes how to use mailbox audit logs to determine when a mailbox was updated unexpectedly or whether items are missing in Microsoft 365 dedicated.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Auditing
  - CSSTroubleshoot
  - 'Associated content asset: 4555332'
ms.reviewer: kerbo
appliesto: 
  - Exchange Online
  - Microsoft Exchange Online Dedicated
search.appverid: MET150
ms.date: 05/05/2025
---

# How to use mailbox audit logs in Microsoft 365

In Microsoft 365, you can run mailbox audit logs to determine when a mailbox was updated unexpectedly or whether items are missing from a mailbox. For example, you may have to do this if items are moved or if they're deleted unexpectedly or incorrectly.

**Note**: For the vNext environment, by default, mailbox audit logs aren't enabled. The feature must be turned on in order for a user to begin a search.

## How to run and check mailbox audit logs

Mailbox audit logging lets users obtain information about actions that are performed by non-owners and administrators. Mailbox audit logging is available to members of the Audit Reporting Mailbox self-service group only by using Windows Remote PowerShell.

> [!NOTE]
>
> - By default, only non-owner mailbox audit logging is enabled, and owner mailbox audit logging is disabled. If you have to perform owner mailbox audit logging to investigate a specific issue, you can temporarily enable the process for two weeks.
> - Some organizations might not allow you to use mailbox audit logging. In this case, the feature will be turned off for you.

To investigate this issue, create and use a Windows PowerShell script by using the sample script that's provided in Step 1 in this section, and then customize a search. By default, you can investigate actions that are performed by non-owners and administrators. This script exports content in a simplified, comma-separated values (.csv) file to help you troubleshoot reports about items that are missing or that were updated unexpectedly.

> [!IMPORTANT]
> Customers are encouraged to use this sample script. The script is provided by Microsoft Online Services to help in certain investigations. Microsoft Online Services scripts are generic, and they should be usable in all customer environments. If errors occur when a script is run, the content of the script should be used as an example to create a customized script for a particular customer environment. Microsoft Online Services provides the script as a convenience to Microsoft 365 customers without warranty, expressed or implied.

### Step 1: Run the script

To run the script, follow these steps:

1. Open a text editor, such as Notepad, and then copy the following code into the file. The code uses the `search-mailboxAuditLog` command that is part of Microsoft Exchange Server.

    ```powershell
     param ([PARAMETER(Mandatory=$TRUE,ValueFromPipeline=$FALSE)]
    [string]$Mailbox,
    [PARAMETER(Mandatory=$TRUE,ValueFromPipeline=$FALSE)]
    [string]$StartDate,
    [PARAMETER(Mandatory=$TRUE,ValueFromPipeline=$FALSE)]
    [string]$EndDate,
    [PARAMETER(Mandatory=$FALSE,ValueFromPipeline=$FALSE)]
    [string]$Subject,
    [PARAMETER(Mandatory=$False,ValueFromPipeline=$FALSE)]
    [switch]$IncludeFolderBind,
    [PARAMETER(Mandatory=$False,ValueFromPipeline=$FALSE)]
    [switch]$ReturnObject)
    BEGIN {
      [string[]]$LogParameters = @('Operation', 'LogonUserDisplayName', 'LastAccessed', 'DestFolderPathName', 'FolderPathName', 'ClientInfoString', 'ClientIPAddress', 'ClientMachineName', 'ClientProcessName', 'ClientVersion', 'LogonType', 'MailboxResolvedOwnerName', 'OperationResult')
      }
      END {
        if ($ReturnObject)
        {return $SearchResults}
        elseif ($SearchResults.count -gt 0)
        {
        $Date = get-date -Format yyMMdd_HHmmss
        $OutFileName = "AuditLogResults$Date.csv"
        write-host
        write-host -fore green "Posting results to file: $OutfileName"
        $SearchResults | export-csv $OutFileName -notypeinformation -encoding UTF8
        }
        }
        PROCESS
        {
        write-host -fore green 'Searching Mailbox Audit Logs...'
        $SearchResults = @(search-mailboxAuditLog $Mailbox -StartDate $StartDate -EndDate $EndDate -LogonTypes Owner, Admin, Delegate -ShowDetails -resultsize 50000)
        write-host -fore green '$($SearchREsults.Count) Total entries Found'
        if (-not $IncludeFolderBind)
        {
        write-host -fore green 'Removing FolderBind operations.'
        $SearchResults = @($SearchResults | ? {$_.Operation -notlike 'FolderBind'})
        write-host -fore green 'Filtered to $($SearchREsults.Count) Entries'
        }
        $SearchResults = @($SearchResults | select ($LogParameters + @{Name='Subject';e={if (($_.SourceItems.Count -eq 0) -or ($_.SourceItems.Count -eq $null)){$_.ItemSubject} else {($_.SourceItems[0].SourceItemSubject).TrimStart(' ')}}},
        @{Name='CrossMailboxOp';e={if (@('SendAs','Create','Update') -contains $_.Operation) {'N/A'} else {$_.CrossMailboxOperation}}}))
        $LogParameters = @('Subject') + $LogParameters + @('CrossMailboxOp')
        If ($Subject -ne '' -and $Subject -ne $null)
        {
        write-host -fore green 'Searching for Subject: $Subject'
        $SearchResults = @($SearchResults | ? {$_.Subject -match $Subject -or $_.Subject -eq $Subject})
        write-host -fore green 'Filtered to $($SearchREsults.Count) Entries'
        }
        $SearchResults = @($SearchResults | select $LogParameters)
        }
    ```

1. On the **File** menu, select **Save As**.
1. In the **Save as type** box, select **All File**.
1. In the **File name** box, enter **Run-MailboxAuditLogSearcher.ps1**, and then select **Save**.
1. Open Windows PowerShell, and then connect to [Windows Remote PowerShell](/powershell/scripting/learn/remoting/running-remote-commands?preserve-view=true&view=powershell-7).
1. Locate the folder in which you saved the script, and then run the script:

    ```powershell
    .\Run-MailboxAuditLogSearcher.ps1
    ```

    > [!NOTE]
    >
    > - If you run the script without parameters, you are prompted for the following default parameters:
    >   - Mailbox
    >   - StartDate
    >   - EndDate
    > - To search for entries from the current day, add one day to the end-date value in the prompt window. For example, if the current date is **3/14/2017**, and you want to include the current day in your search, enter **3/15/2017** as the end date.

### Step 2: Customize a mailbox audit log search

In Microsoft 365, mailbox audit logging entries are retained in the mailbox for 90 days. You are prompted to indicate a start date and end date for the search. You can use several optional parameters to customize the search. For a description of these parameters, see the "More information" section.

If items are found after the script runs, you receive a message that resembles the following message:

> Searching Mailbox Audit Logs...<br/>
> 11 Total entries Found<br/>
> Removing FolderBind operations.<br/>
> Filtered to 1 Entries<br/>
>
> Posting results to file: AuditLogResults121024_142419.csv

:::image type="content" source="media/mailbox-audit-logs/script-message.png" alt-text="Screenshot of the message after running the script." border="false":::

This example message indicates that the search process has found 11 entries. By default, the **FolderBind** entries are filtered out, and the following operation types remain:

- Copy
- Create
- HardDelete
- MessageBind
- Move
- MoveToDeletedItems
- SendAs
- SendOnBehalf
- SoftDelete
- Update

> [!NOTE]
> The **FolderBind** operation indicates the times at which the mailbox is accessed by a non-owner. This is the most common operation. You do not have to view the FolderBind operations when you investigate an item that is updated or deleted.

Review the output of the .csv file. The most useful columns are exported, and some of these columns are merged to make the output easier to review. For more information about the columns that are exported, see the 'More information' section.

### Owner mailbox audit logging

Mailbox audit logging is turned on by default for all organizations. One of the main benefits of enabling mailbox auditing by default is that you don't have to manage audited mailbox actions. Microsoft manages these actions for you, and we automatically add new mailbox actions to be audited by default as we release them.

However, your organization might have to audit a different set of mailbox actions for user mailboxes and shared mailboxes. For more information about how to change the mailbox actions that are audited for each sign-in type, and how to revert to the Microsoft-managed default actions, see [Change or restore mailbox actions logged by default](/purview/audit-mailboxes#change-or-restore-mailbox-actions-logged-by-default).

## More information

### Optional script parameters

The following list describes optional parameters that generate different results when they are used together with the `Run-MailboxAuditLogSearcher` script:

- **IncludeFolderBind**: Prevents the FolderBind operation from being filtered from the output. You can use FolderBind information to investigate mailbox access issue.

  For example, the following cmdlet searches the "Test User 1" mailbox and includes all operations:

    ```powershell
    .\Run-MailboxAuditLogSearcher.ps1 -IncludeFolderBind -Mailbox "<Test User 1gt;" -StartDate "<04/10/17gt;" -EndDate "<04/27/17gt;&quot
    ```

- **Subject**: Enables you to specify the subject of an item in order to limit the search for operations that are performed on that item.

  For example, the following cmdlet filters out all output except items that have the subject set as 'Good News':

    ```powershell
    .\Run-MailboxAuditLogSearcher.ps1 -Subject "<Good News>" -Mailbox "<test1@contoso.comgt;" -StartDate "<04/10/17gt;" -EndDate "<04/27/17gt;&quot
    ```

- **ReturnObject**: Causes the results to be displayed on screen (but not be exported to a .csv file).

  For example, the following cmdlet displays the output on screen:

    ```powershell
    .\Run-MailboxAuditLogSearcher.ps1 -ReturnObject -Mailbox "<Test User 1gt;" -StartDate "<04/10/17gt;" -EndDate "<04/27/17gt;&quot
    ```

### Exported columns from the .csv file

The most useful columns of the .csv file are exported. Some of these columns are merged to make the output easier to review. The following table lists the columns that are exported.

|Column|Description|
|---|---|
|Subject|Subject of item |
|Operation|Actions that are performed on item |
|LogonUserDisplayName|Display name of user who is logged on |
|LastAccessed|Time at which the operation was performed |
|DestFolderPathName|Destination folder for the move operation |
|FolderPathName|Path of folder |
|ClientInfoString|Details about the client that performs the operation |
|LastAccessed|IP address for the client computer |
|ClientMachineName|Name of the client computer |
|ClientProcessName|Name of the client application process|
|ClientVersion|Version of the client application |
|LogonType|Logon type of the user who performs the operation</br></br>**Note** Logon types includes the following: </br>- Delegate for non-owner </br>- Administrator </br>- Mailbox owner (not logged by default) |
|MailboxResolvedOwnerName|Resolved name of mailbox user</br></br>**Note** Resolved name is in the following format:</br>Domain\SamAccountName |
|OperationResult|Status of the operation</br></br>**Note** Operation results include the following: </br>- Failed </br>- PartiallySucceeded </br>- Succeeded |
|CrossMailboxOperation|Information about whether the operation that's logged is a cross-mailbox operation (for example, copying or moving messages among mailboxes) |

### More information about mailbox audit logging

- The **Search-MailboxAuditLog**  cmdlet is used in the sample script in Step 1 to search a single mailbox synchronously. You can do this also by running the cmdlet in Windows Remote PowerShell.

  For more information about the cmdlet, go to the following TechNet article:

  [Search-MailboxAuditLog](/powershell/module/exchange/search-mailboxauditlog)
- You can search one or more mailboxes asynchronously. To do this, run the following cmdlet in Windows Remote PowerShell:

    ```powershell
    New-MailboxAuditLogSearch
    ```  

    For more information about this cmdlet, go to the following article:

    [New-MailboxAuditLogSearch](/powershell/module/exchange/new-mailboxauditlogsearch)

    For more information about the default mailbox audit logging entries, go to the "Mailbox audit log entries" section of the following article:

    [Mailbox Audit Logging in Exchange 2016](/Exchange/policy-and-compliance/mailbox-audit-logging/mailbox-audit-logging#mailbox)
