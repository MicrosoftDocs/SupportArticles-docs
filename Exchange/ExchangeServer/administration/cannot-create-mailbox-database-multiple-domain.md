---
title: Failed to mount a Mailbox database in Exchange Server 2010
description: Describes an issue in which you can't create a new Exchange Server 2010 Mailbox database in a multiple domain environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: raghunp, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't create a new Exchange Server 2010 Mailbox database in a multiple domain environment

_Original KB number:_ &nbsp;977960

## Symptoms

When you create a Mailbox database in a multiple domain environment and then mount the Mailbox database on a Microsoft Exchange Server 2010 server, the Mailbox database mounting fails. Additionally, you receive the following error message in Exchange Management Console:

```console
Failed to mount database ' <test3> '.

 <test3>
Failed Error: Couldn't mount the database that you specified. Specified database:
   <test3> ; Error code: An Active Manager operation failed. Error: The database action failed. Error: Operation failed with message: MapiExceptionNotFound: Unable to mount database. (hr=0x8004010f, ec=-2147221233) [Database:  <test3> , Server:
   <Servername> ]. An Active Manager operation failed. Error: The database action failed. Error: Operation failed with message: MapiExceptionNotFound: Unable to mount database. (hr=0x8004010f, ec=-2147221233) [Database:  <test3> , Server:
   <Servername>

An Active Manager operation failed. Error: Operation failed with message: MapiExceptionNotFound: Unable to mount database. (hr=0x8004010f, ec=-2147221233) [Server: e14mbxndb2.Enterprise.emory.net] MapiExceptionNotFound: Unable to mount database. (hr=0x8004010f, ec=-2147221233)
```

If you mount the Mailbox database by using a command in Exchange Management Shell, you receive the following error message:

```console
[PS] C:\Windows\system32>New-MailboxDatabase -EdbFilePath <FilePath> -LogFolderPath <FolderPath> -Server <ServerName> -Name <DatabaseName>  Active Directory operation failed on <Mailbox>. This error is not retriable. Additional information: The name reference is invalid.  This may be caused by replication latency between Active Directory domain controllers. Active directory response: 000020B5: AtrErr: DSID-03152392,  #1: 0: 000020B5: DSID-03152392, problem 1005 (CONSTRAINT_ATT_TYPE), data 0, Att 200f4 (homeMDB) + CategoryInfo : NotSpecified: (0:Int32) [New-MailboxDatabase],  ADOperationException + FullyQualifiedErrorId : 8022381D,Microsoft.Exchange.Management.SystemConfigurationTasks.NewMailboxDatabase
```

Additionally, you see the following event logged in the Application log:

```console
Log Name:      Application Source:        MSExchange Configuration Cmdlet - Remote Management Event ID:      4 Task Category: General Level:         Error Keywords:      Classic Description: (PID 8136, Thread 2652) Task New-MailboxDatabase writing error when processing record of index 0. Error: Microsoft.Exchange.Data.Directory.ADOperationException: Active Directory operation failed on <Mailbox>. This error is not retriable. Additional information: The name reference is invalid. This may be caused by replication latency between Active Directory domain controllers. Active directory response: 000020B5: AtrErr: DSID-03152392, #1: 0: 000020B5: DSID-03152392, problem 1005 (CONSTRAINT_ATT_TYPE), data 0, Att 200f4 (homeMDB) ---> System.DirectoryServices.Protocols.DirectoryOperationException: A value in the request is invalid. at System.DirectoryServices.Protocols.LdapConnection.ConstructResponse(Int32 messageId, LdapOperation operation, ResultAll resultType, TimeSpan requestTimeOut, Boolean exceptionOnTimeOut) at System.DirectoryServices.Protocols.LdapConnection.SendRequest(DirectoryRequest request, TimeSpan requestTimeout) at Microsoft.Exchange.Data.Directory.PooledLdapConnection.SendRequest(DirectoryRequest request, LdapOperation ldapOperation, IAccountingObject budget) at Microsoft.Exchange.Data.Directory.ADSession.ExecuteModificationRequest(ADObject entry, DirectoryRequest request, ADObjectId originalId, Boolean emptyObjectSessionOnException) --- End of inner exception stack trace --- at Microsoft.Exchange.Data.Directory.ADSession.AnalyzeDirectoryError(PooledLdapConnection connection, DirectoryRequest request, DirectoryException de, Int32 totalRetries, Int32 retriesOnServer) at Microsoft.Exchange.Data.Directory.ADSession.ExecuteModificationRequest(ADObject entry, DirectoryRequest request, ADObjectId originalId, Boolean emptyObjectSessionOnException) at Microsoft.Exchange.Data.Directory.ADSession.Save(ADObject instanceToSave, IEnumerable`1 properties) at Microsoft.Exchange.Management.SystemConfigurationTasks.NewMailboxDatabase.SaveSystemMailbox(MailboxDatabase mdb, Server owningServer, ADObjectId rootOrgContainerId, ADSystemConfigurationSession configSession, ADRecipientSession recipientSession, ADObjectId[] forcedReplicationSites, TaskWarningLoggingDelegate writeWarning, TaskVerboseLoggingDelegate writeVerbose) at Microsoft.Exchange.Management.SystemConfigurationTasks.NewMailboxDatabase.WriteResult() at Microsoft.Exchange.Configuration.Tasks.NewTaskBase`1.InternalProcessRecord() at Microsoft.Exchange.Configuration.Tasks.NewADTaskBase`1.InternalProcessRecord() at Microsoft.Exchange.Management.SystemConfigurationTasks.NewDatabaseTask`1.InternalProcessRecord() at Microsoft.Exchange.Management.SystemConfigurationTasks.NewMailboxDatabase.InternalProcessRecord() at Microsoft.Exchange.Configuration.Tasks.Task.ProcessRecord()
```

## Cause

This issue occurs when the value of the **ConfigurationDomainController** parameter and the value of the **PreferredGlobalCatalog** parameter are different. In this scenario, the Mailbox database operation fails, because of the replication latency that occurs between the configured domain controllers and the preferred global catalog.

## Resolution

To resolve this issue, set the preferred Active Directory server in Exchange Management Shell to the following cmdlet:

```powershell
Set-ADServerSettings -PreferredServer <DC FQDN>
```

For more information about the Set-AdServerSettings cmdlet, see [Set-AdServerSettings](/powershell/module/exchange/set-adserversettings).

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.