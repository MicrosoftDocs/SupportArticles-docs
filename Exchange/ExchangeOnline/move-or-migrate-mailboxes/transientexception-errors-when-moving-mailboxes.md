---
title: TransientException when moving mailboxes
description: Describes that you experience RestartMoveCorruptSyncStateTransientException and CommunicationErrorTransientException errors in the move request report when you try to offboard mailboxes from Exchange Online to Exchange Server 2010 in the on-premises Exchange environment. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010
search.appverid: MET150
ms.date: 01/24/2024
---
# TransientException when moving mailboxes from Exchange Online to Exchange Server 2010 in on-premises

_Original KB number:_ &nbsp; 3063045

## Symptoms

When you try to offboard or move mailboxes from Microsoft Exchange Online to Microsoft Exchange Server 2010 in the on-premises environment, the move operation doesn't progress past a certain percentage. For example, the operation appears to stop at 10 percent, and eventually fails.

When you run the [Get-MoveRequestStatistics](/powershell/module/exchange/get-moverequeststatistics?view=exchange-ps&preserve-view=true) cmdlet together with the **-IncludeReport** parameter to obtain the move report, you may see the following TransientException errors:

> Timestamp: \<Date>\<Time>  
FailureType: RestartMoveCorruptSyncStateTransientException  
FailureCode: -2146233088  
MapiLowLevelError: 0  
FailureSide:  
FailureSideInt: 0  
ExceptionTypes: {Exchange, Transient, MRS, MRSTransient}  
ExceptionTypesInt: {1, 2, 10, 11}  
Message: Restarting the move because checkpoint data doesn't exist or is invalid in '\<DomainName>.onmicrosoft.com\xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx (Primary)'.

> Timestamp: \<Date>\<Time>  
FailureType: CommunicationErrorTransientException  
FailureCode: -2146233088  
MapiLowLevelError: 0  
FailureSide: Target  
FailureSideInt: 2  
ExceptionTypes: {Exchange, Transient}  
ExceptionTypesInt: {1, 2}  
Message: The call to '`https://hybrid.<DomainName>.com/EWS/mrsproxy.svc \<ServerName>.\<DomainName>.com` (14.3.224.1 caps:05FFFF)' failed. Error details: The server was unable to process the request due to an internal error.

Additionally, you may see the following error in the move report:

> Flags: Recursive, FailOnForeignEID--------Search folder: '/Finder/Search Folder1', entryId [len=46,  data=000000003C6CB08C6F36E04A9861917047605CC001006A88A52868A7A64E94CDB47ADBE5296E00006564271D0000], parentId [len=46,  data=000000003C6CB08C6F36E04A9861917047605CC00100D439EA6B5AE3BB4FA439F2C8AED5465600000034F8F40000]

## Cause

This issue can occur if the virtual folders in the Search Folders mailbox are corrupted.

## Resolution

Reset Search Folders, and then restore the default views for the user's profile in Outlook. To do this, follow these steps:

1. Reset Search Folders in Outlook. To do this, select **Start**, select **Run**, type *outlook.exe /cleanfinders*, and then press Enter.

    > [!NOTE]
    > This action deletes the Search Folders mailbox from the information store.
2. After the folders are updated, exit Outlook.
3. Restore the default views in Outlook. To do this, select **Start**, select **Run**, type *outlook.exe /cleanviews*, and then press Enter.

    > [!NOTE]
    > This action restores folder views to the default settings.
4. After the folders are updated, exit Outlook.

## More information

To obtain the move request report and confirm this issue, you can run the following command while connected to [Exchange Online PowerShell](/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/connect-to-exchange-online-powershell?preserve-view=true&view=exchange-ps):

```console
$stats = Get-MoveRequestStatistics -identity [user@contoso.com](mailto:user@contoso.com) -IncludeReport
$stats.Report.Failures | select -last 2
```

In the report, you will usually find keywords with the term *Search* in the DataContext section of the error, such as **IDestinationFolder.SetSearchCriteria**, **Search Folder** etc. that will indicate that your issue is related to Search Folders / Finders.

To provide Microsoft Support with the move report for analysis, export it by using the following command:

```powershell
Get-MoveRequestStatistics -identity [user@contoso.com](mailto:user@contoso.com) -IncludeReport -DiagnosticInfo showtimeslots | Export-CliXml <XML File Name and Path>
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).