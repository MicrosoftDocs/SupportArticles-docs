---
title: How to use mailbox audit logs in Office 365
description: Describes how to use mailbox audit logs to determine when a mailbox was updated unexpectedly or whether items are missing in Office 365 dedicated.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: Office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: kerbo
appliesto: 
- Exchange Online
- Microsoft Exchange Online Dedicated
search.appverid: MET150
---

# How to use mailbox audit logs in Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;4021960

## Summary

In Microsoft Office 365, you can run mailbox audit logs to determine when a mailbox was updated unexpectedly or whether items are missing from a mailbox. You may have to do this, for example, if items are moved or if they're deleted unexpectedly or incorrectly.

For the vNext environment, please note that mailbox audit logs are not enabled by default and need to be turned on for a user before beginning a search.

## How to run and check mailbox audit logs

Mailbox audit logging lets users obtain information about actions that are performed by non-owners and administrators. Mailbox audit logging is available to members of the Audit Reporting Mailbox self-service group only by using Windows Remote PowerShell.

> [!NOTE]
>
> - By default, only non-owner mailbox audit logging is enabled, and owner mailbox audit logging is disabled. If you have to perform owner mailbox audit logging to investigate a specific issue, you can temporarily enable the process for a two-week period.
> - Some organizations may not enable you to use mailbox audit logging and, therefore, have turned off the feature.

To investigate this issue, create and use a Windows PowerShell script by using the sample script that's provided in the Step 1 in this section, and then customize a search. By default, you can investigate actions that are performed by non-owners and administrators. This script exports content in a simplified, comma-separated values (.csv) file to help you troubleshoot reports about items that are missing or that were updated unexpectedly.

> [!IMPORTANT]
> Customers are encouraged to use the script that's provided by Microsoft Online Services to help in certain investigations. Microsoft Online Services scripts are generic, and they should be usable in all customer environments. If errors occur when a script is run, the content of the script should be used as an example to create a customized script for a particular customer environment. Microsoft Online Services provides the script as a convenience to Office 365 customers without warranty, expressed or implied.

### Step 1: Run the script

To run the script, follow these steps:

1. Start Notepad, and then copy the following code into the file. The code uses the `search-mailboxAuditLog` command that is part of Microsoft Exchange Server.

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
        $OutFileName = 'AuditLogResults$Date.csv'
        write-host
        write-host -fore green 'Posting results to file: $OutfileName'
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

1. On the **File** menu, click **Save As**.
1. In the **Save as type** box, click **All File**.
1. In the **File name** box, type **Run-MailboxAuditLogSearcher.ps1**, and then click **Save**.
1. Start Windows PowerShell, and then connect to Windows Remote PowerShell.
1. Locate the directory in which you saved the script, and then run the script.

    ```powershell
    .\Run-MailboxAuditLogSearcher.ps1
    ```

    > [!NOTE]
    >
    > - If you run the script without parameters, you will be prompted for the following default parameters:
    >   - Mailbox
    >   - StartDate
    >   - EndDate
    > - To search for entries from the current day, add one day to the end-date value in the prompt window. For example, if the current date is **3/14/2017**, and you want to include the current day in your search, enter **4/15/2017**  as the end date.

### Step 2: Customize a mailbox audit log search

In Office 365, mailbox audit logging entries are retained in the mailbox for 90 days. You are prompted to indicate a start date and end date for the search. You can use several optional parameters to customize the search. For a description of these parameters, see the 'More Information' section.

If items are found after the script runs, you receive a message that resembles the following:

![A screenshot of the message after running script](./media/mailbox-audit-logs/message.png)

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

Review the output of the .csv file. The most useful columns are exported, and some of these columns are merged to make the output easier to review. For more information about the columns that are exported, see the 'More Information' section.

### Owner mailbox audit logging

By default. owner audit logging is not turned on. It should only be used if you have to investigate an action by the owner of the mailbox. It should be used for a limited time period, approximately two weeks. This is because the audit log entries are stored in the mailbox, and this may cause the mailbox dumpster to exceed the size limit.

To enable owner audit logging, follow these steps:

1. Determine whether mailbox audit logging is enabled. To do this, run the following cmdlet:

    ```powershell
    Get-Mailbox <useridentity> | ft AuditEnabled
    ```

1. If the result is **True**, skip this step. If the result is **False**, run the following cmdlet in Windows PowerShell:

    ```powershell
    Set-Mailbox <useridentity> -AuditEnabled $true
    ```

1. Enable the owner audit logging. To do this, run the following cmdlet:

    ```powershell
    Set-Mailbox <useridentity> -AuditOwner "Create,HardDelete,Move,MoveToDeletedItems,SoftDelete,Update"
    ```

1. Rerun the **Run-MailboxAuditLogSearcher.ps1**, and review the data.
1. After the troubleshooting is complete, disable owner audit logging. To do this, run the following cmdlet:

    ```powershell
    Set-Mailbox <useridentity> -AuditOwner $none
    ```

## More Information

### Optional script parameters

The following list describes optional parameters that generate different results when they are used together with the `Run-MailboxAuditLogSearcher` script:

- **IncludeFolderBind**: When you use this switch, the FolderBind operation is not filtered from the output. You can use FolderBind information to investigate mailbox access issue.

  For example, the following cmdlet searches the "Test User 1" mailbox and includes all operations:

    ```powershell
    .\Run-MailboxAuditLogSearcher.ps1 -IncludeFolderBind -Mailbox "<Test User 1gt;" -StartDate "<04/10/17gt;" -EndDate "<04/27/17gt;&quot
    ```

- **Subject**: When you use this switch, you can specify the subject of an item in order to limit the search for operations that are performed on that item.

  For example, the following cmdlet filters out all output except items that have the subject set as 'Good News':

    ```powershell
    .\Run-MailboxAuditLogSearcher.ps1 -Subject "<Good News>" -Mailbox "<test1@contoso.comgt;" -StartDate "<04/10/17gt;" -EndDate "<04/27/17gt;&quot
    ```

- **ReturnObject**: When you use this switch, the result is displayed on the screen, but it is not exported to a .csv file.

  For example, the following cmdlet displays the output on the screen:

    ```powershell
    .\Run-MailboxAuditLogSearcher.ps1 -ReturnObject -Mailbox "<Test User 1gt;" -StartDate "<04/10/17gt;" -EndDate "<04/27/17gt;&quot
    ```

### Exported columns from the .csv file

The most useful columns of the .csv file are exported. Some of these columns are merged to make the output easier to review. The following table lists the columns that are exported.

|Column|Description|
|---|---|
|Subject|Subject of item |
|Operation|Actions that are performed on item |
|LogonUserDisplayName|Display name of user who is logged o |
|LastAccessed|Time at which the operation was performed |
|DestFolderPathName|Destination folder for the move operation |
|FolderPathName|Path of folder |
|ClientInfoString|Details about the client that performs the operation |
|LastAccessed|IP address for the client computer |
|ClientMachineName|Name of the client computer |
|ClientProcessName|Name of the client application process|
|ClientVersion|Version of the client application |
|LogonType|Logon type of the user who performs the operation</br>**Note** Logon types includes the following: </br>- Delegate for non-owner </br>- Administrator </br>- Mailbox owner (not logged by default) |
|MailboxResolvedOwnerName|Resolved name of mailbox user</br>**Note** Resolved name is in the following format:</br>Domain\SamAccountName |
|OperationResult|Status of the operation</br>**Note** Operation results include the following: </br>- Failed </br>- PartiallySucceeded </br>- Succeeded |
|CrossMailboxOperation|Information about whether the operation logged is a cross-mailbox operation (for example, copying or moving messages among mailboxes) |
|||

### More information about mailbox audit logging

- The **Search-MailboxAuditLog**  cmdlet is used in the sample script in Step 1 to search a single mailbox synchronously. You can also do this by running the cmdlet in Windows Remote PowerShell.

  For more information about the cmdlet, go to the following TechNet article:

  [Search-MailboxAuditLog](https://technet.microsoft.com/library/ff522360.aspx)
- You can search one or more mailboxes asynchronously. To do this, run the following cmdlet in Windows Remote PowerShell:

    ```powershell
    New-MailboxAuditLogSearch
    ```  

    For more information about this cmdlet, go to the following TechNet article:

    [New-MailboxAuditLogSearch](https://technet.microsoft.com/library/ff522362.aspx)

    For more information about the default mailbox audit logging entries, go to the 'Mailbox audit log entries' section of the following TechNet article:

    [Mailbox Audit Logging in Exchange 2016](https://technet.microsoft.com/library/ff459237.aspx#mailbox)
