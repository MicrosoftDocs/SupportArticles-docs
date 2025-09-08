---
title: Unable to move a mailbox from Microsoft 365 back to on-premises in hybrid
description: Describes an issue in which the move operation fails after it reaches 95 percent when you try to move a mailbox from Microsoft 365 back to the on-premises environment in a hybrid deployment of Exchange Online in Microsoft 365 and of Exchange Server. Provides a resolution.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Migration
  - Exchange Hybrid
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Move operation fails when moving a mailbox from Microsoft 365 back to the on-premises environment

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://blogs.technet.com/b/exchange/archive/2016/02/17/office-365-hybrid-configuration-wizard-for-exchange-2010.aspx).

## Problem

Consider the following scenario:

- You have a hybrid deployment of Microsoft Exchange Online in Microsoft 365 and of your on-premises Microsoft Exchange Server environment.
- You previously moved a mailbox from the on-premises environment to Microsoft 365.
- You try to offboard or to move the same mailbox from Microsoft 365 back to the on-premises environment.

In this scenario, the operation reaches 95 percent and then fails.

When this occurs, an "HTTP 400" error is generated in the following log files in the on-premises environment when you access the `/EWS/mrsproxy.svc` link:

- The Internet Information Services (IIS) log files
- The HTTP error log (HTTPERR) files

When you connect to Microsoft 365 by using Windows PowerShell and then run the `Get-MoveRequestStatisticsMailboxID -IncludeReport | Export-CliXml FileName.xml` command, the stack trace section of the XML report shows the following:

```asciidoc
<S N="StackTrace"> at
Microsoft.Exchange.MailboxReplicationService.CommonUtils.CallService
(Action serviceCall, String epAddress, VersionInformation
serverVersion)_x000A_ at
Microsoft.Exchange.MailboxReplicationService.MailboxReplicationProxyClient.CallServiceWithTimeout
(TimeSpan timeout, Action serviceCall)_x000A_ at Microsoft.Exchange.MailboxReplicationService.RemoteDestinationFolder.Microsoft.Exchange.MailboxReplicationService.IDestinationFolder.SetRules(RuleData[] rules)_x000A_ at Microsoft.Exchange.MailboxReplicationService.DestinationFolderWrapper.<;>;c__DisplayClass31.<;Microsoft.Exchange.MailboxReplicationService.IDestinationFolder.SetRules>;b__30()_x000A
at Microsoft.Exchange.MailboxReplicationService.ExecutionContext.Execute
(Action operation)_x000A_ at Microsoft.Exchange.MailboxReplicationService.DestinationFolderWrapper.Microsoft.Exchange.MailboxReplicationService.IDestinationFolder.SetRules(RuleData[] rules)_x000A_ at
Microsoft.Exchange.MailboxReplicationService.FolderRecWrapper.WriteRules
(IDestinationFolder targetFolder, Action`1 reportBadItemsDelegate)
_x000A_ at
Microsoft.Exchange.MailboxReplicationService.MailboxCopierBase.CopyFolderProperties
(FolderRecWrapper folderRec, ISourceFolder sourceFolder,
IDestinationFolder destFolder, FolderRecDataFlags dataToCopy)
_x000A_ at Microsoft.Exchange.MailboxReplicationService.MailboxMover.<;>;c__DisplayClass2.<;>;c__DisplayClass4.<;FinalSyncCopyAllFolders>;b__1()_x000A_ at
Microsoft.Exchange.MailboxReplicationService.ExecutionContext.Execute
(Action operation)_x000A_ at Microsoft.Exchange.MailboxReplicationService.MailboxMover.<;>;c__DisplayClass2.<;FinalSyncCopyAllFolders>;b__0
(FolderRecWrapper folderRec, EnumFolderContext ctx)_x000A_ at
Microsoft.Exchange.MailboxReplicationService.FolderMap.EnumSingleFolder
(FolderRecWrapper folderRec, EnumFolderContext ctx, EnumFolderCallback callback, EnumHierarchyFlags flags)_x000A_ at Microsoft.Exchange.MailboxReplicationService.FolderMap.EnumSingleFolder(FolderRecWrapper folderRec, EnumFolderContext ctx, EnumFolderCallback callback, EnumHierarchyFlags flags)_x000A_ at Microsoft.Exchange.MailboxReplicationService.FolderMap.EnumSingleFolder(FolderRecWrapper folderRec, EnumFolderContext ctx, EnumFolderCallback callback, EnumHierarchyFlags flags)_x000A_ at Microsoft.Exchange.MailboxReplicationService.MailboxMover.FinalSyncCopyAllFolders()
_x000A_ at
Microsoft.Exchange.MailboxReplicationService.MoveBaseJob.<;FinalSync>;b__4d
(MailboxMover mbxCtx)_x000A_ at
Microsoft.Exchange.MailboxReplicationService.MoveBaseJob.ForeachMailboxContext
(Action`1 del)_x000A_ at
Microsoft.Exchange.MailboxReplicationService.MoveBaseJob.FinalSync(Object[] wiParams)_x000A_ at Microsoft.Exchange.MailboxReplicationService.CommonUtils.CatchKnownExceptions
(Action actionDelegate, Action`1 failureDelegate)</S>
```

## Cause

This issue occurs if the SetRules call to the Mailbox Replication Proxy (MRSProxy) service fails. This issue may also occur if the mailbox that's being moved contains a large amount of junk-mail rules and user rules.

## Solution

To resolve this issue, change the values of the `MRSProxyHttpsBinding` settings and of the `MRSProxyWSSecurityBinding` settings in the Web.config file on every Client Access server in the on-premises environment that's in the path through which the mailbox passes when it is moved. To do this, follow these steps:

1. On the Client Access server, locate and then open the Web.config file.

   > [!NOTE]
   > In Exchange Server 2010, the Web.config file is located in the following folder: \Program Files\Microsoft\Exchange Server\V14\ClientAccess\exchweb\ews

2. Change certain values of the `MRSProxyHttpsBinding` settings and of the `MRSProxyWSSecurityBinding` settings from **1048576** to **8388608**. Then, save the file.

   The following example shows what this section of the Web.config will look like after it's changed:

   ```xml
   <binding name="MRSProxyHttpsBinding"> <reliableSession />
   <textMessageEncoding>
   <readerQuotas maxDepth="32"
   maxStringContentLength="8388608"
   maxArrayLength="8388608"
   maxBytesPerRead="4096"
   maxNameTableCharCount="16384" />
   </textMessageEncoding>
   <httpsTransport authenticationScheme="Negotiate"
   maxReceivedMessageSize="8388608" />
   </binding>
   <binding name="MRSProxyWSSecurityBinding">
   <reliableSession />
   <textMessageEncoding>
   <readerQuotas maxDepth="32"
   maxStringContentLength="8388608"
   maxArrayLength="8388608"
   maxBytesPerRead="4096"
   maxNameTableCharCount="16384" />
   </textMessageEncoding>
   <httpsTransport authenticationScheme="Anonymous"
   maxReceivedMessageSize="8388608" />
   </binding>  
   ```

3. Restart IIS by using the `iisreset` command.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
