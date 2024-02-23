---
title: Outlook repeatedly disconnects and reconnects
description: Discusses that Outlook 2013, Outlook 2010, and Outlook 2007 clients repeatedly disconnect from and reconnect to Exchange Server 2013. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Service Pack 1
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 10/30/2023
---
# Outlook clients repeatedly disconnect from and reconnect to Exchange Server 2013

_Original KB number:_ &nbsp; 2962915

## Symptoms

You experience one or more of the following symptoms in Exchange Server 2013.

### Symptom 1

The Outlook 2013 client, Outlook 2010 client, or Outlook 2007 client disconnects from the server that is running Exchange Server 2013. Shortly after the disconnection, the client reconnects to the Exchange server. This behavior continues repeatedly.

### Symptom 2

The `MSExchangeRpcProxyAppPool` is continually recycled. In Event Viewer under Application and Services Logs\Microsoft\Exchange\ActiveMonitoring in the ProbeResult log, you see probe result errors for the Outlook service for different 2013 databases that indicate the **StoreError=UnknownUser** value.

In the **Details** view in the log entry, you see this line:

> Microsoft.Exchange.Data.Storage.DatabaseNotFoundException: The database with ID \<GUID> couldn't be found

The relevant parts of the error event are the following:

> Log Name: Microsoft-Exchange-ActiveMonitoring/ProbeResult  
Source: Microsoft-Exchange-ActiveMonitoring  
Date: *DateTime*  
Event ID: 2  
Task Category: Probe result  
Level: Error  
Keywords:  
User: SYSTEM  
Computer: *CAS.contoso.com*  
Description:  
Event Xml:  
\<ServiceName>Outlook\</ServiceName>  
\<IsNotified>0\</IsNotified>  
\<ResultName>OutlookMailboxCtpProbe/2013 Mailbox Database 1\</ResultName>  
\<WorkItemId>121\</WorkItemId>  
\<DeploymentId>0\</DeploymentId>  
\<MachineName>CAS1\</MachineName>  
\<Error>Error returned in ConnectCallResult. Error code = UnknownUser (0x000003EB)\</Error>  
\<Error>Error returned in ConnectCallResult. Error code = UnknownUser (0x000003EB)\</Error>  
\<Exception>Microsoft.Exchange.RpcClientAccess.RopExecutionException: Error returned in ConnectCallResult. Error code = UnknownUser (0x000003EB) ---&gt; System.Exception: Microsoft.Exchange.RpcClientAccess.Server.UnknownUserException: Unable to map userDn '/o=First Organization/ou=Monitoring Mailboxes/cn=Recipients/cn=HealthMailboxcaea01e2cff446d1b0645f01d11fb55f' to exchangePrincipal (StoreError=UnknownUser) --- Microsoft.Exchange.Data.Storage.DatabaseNotFoundException: The database with ID \<Unknown DB Guid> couldn't be found.

### Symptom 3

The `MSExchangeRpcProxyAppPool` application pool is continually recycled much like it is on the CAS. In the system log, you might also see events 7031 and 7032 logged, as follows:

> Time: *DateTime*  
ID: 7031  
Level: Error  
Source: Service Control Manager  
Machine: <*2013 MBX Server name*>  
Message: The Microsoft Exchange RPC Client Access service terminated unexpectedly. It has done this 1 time(s). The following corrective action will be taken in 5000 milliseconds: Restart the service.  
Time: *DateTime*  
ID: 7032  
Level: Error  
Source: Service Control Manager  
Machine: *MachineName*  
Message: The Service Control Manager tried to take a corrective action (Restart the service) after the unexpected termination of the Microsoft Exchange RPC Client Access service, but this action failed with the following error:  
%%1056

> [!NOTE]
> This log entry indicates that the RPC Client Access service is unexpectedly terminated.

### Symptom 4

On the Exchange 2013 MBX server, in Event Viewer under Application and Services Logs\Microsoft\Exchange\ActiveMonitoring in the ProbeResult log, you see probe result error events for the Outlook.Protocol service for different 2013 databases that indicate the **StoreError=UnknownUser** value.

In the **Details** view in the log entry, you see the following line:

> Microsoft.Exchange.Data.Storage.DatabaseNotFoundException: The database with ID \<GUID> couldn't be found

The relevant parts of the error event are the following:

> Log Name: Microsoft-Exchange-ActiveMonitoring/ProbeResult  
Source: Microsoft-Exchange-ActiveMonitoring  
Date: *DateTime*  
Event ID: 2  
Task Category: Probe result  
Level: Error  
Keywords:  
User: SYSTEM  
Computer: *mailbox1.contoso.com*  
Description:  
Probe result (Name=OutlookSelfTestProbe)  
Event Xml:  
\<ServiceName>Outlook.Protocol\</ServiceName>  
\<IsNotified>0\</IsNotified>  
\<ResultName>OutlookSelfTestProbe\</ResultName>  
\<WorkItemId>60\</WorkItemId>  
\<DeploymentId>0\</DeploymentId>  
\<MachineName>MAILBOX2\</MachineName>  
\<Error>Error returned in ConnectCallResult. Error code = UnknownUser (0x000003EB)\</Error>\<Exception>Microsoft.Exchange.RpcClientAccess.RopExecutionException: Error returned in ConnectCallResult. Error code = UnknownUser (0x000003EB) ---&gt; System.Exception: Microsoft.Exchange.RpcClientAccess.Server.UnknownUserException: Unable to map userDn '/o=First Organization/ou=Monitoring Mailboxes/cn=Recipients/cn=HealthMailbox147dc27242bb4da4acd5d94cf214934b' to exchangePrincipal (StoreError=UnknownUser) ---&gt; Microsoft.Exchange.Data.Storage.DatabaseNotFoundException: The database with ID \<Unknown DB Guid> couldn't be found.

## Cause

This problem occurs because a public folder database that one or more Exchange 2013 mailbox database point to as the default public folder database setting was deleted in ADSI Edit. The unknown database GUID that is mentioned in the log entry details is that of the deleted public folder database.

You can verify this problem by running the following command:

```powershell
Get-MailboxDatabase | FL name,PublicFolderDatabase
```

The output that is generated by this command resembles the following:

```console
Name : 2013 Mailbox Database
PublicFolderDatabase : Contoso.com/Configuration/Deleted Objects/Public FolderDatabaseDEL:<GUID>
```

> [!NOTE]
> This output indicates that one or more of the Exchange 2013 mailbox databases are pointed to a public folder object that is in the Deleted Object container in Active Directory Domain Services (AD DS).

## Resolution - Method 1

> [!WARNING]
> If you use the ADSI Edit snap-in, the LDP utility, or any other LDAP version 3 client, and you incorrectly modify the attributes of Active Directory objects, you can cause serious problems. These problems may require you to reinstall Microsoft Windows 2000 Server, Microsoft Windows Server 2003, Microsoft Exchange 2000 Server, Microsoft Exchange Server 2003, or both Windows and Exchange. Microsoft cannot guarantee that problems that occur if you incorrectly modify Active Directory object attributes can be solved. Modify these attributes at your own risk.

If you are not using legacy public folder databases, or if you are working in a pure Exchange 2013 environment, remove the default public folder database setting on each Exchange 2013 Mailbox database that points to the deleted public folder database object.

To do this, connect to CN=Configuration in ADSI Edit, and then navigate to this location:

`Domain.com/Configuration/Services/Microsoft Exchange/Org/Administrative Groups/Exchange Administrative Group (FYDIBOHF23SPDLT)/Databases`

Clear the **msExchHomePublicMDB** value so that it reads as **\<not set>**.

## Resolution - Method 2

If you are in an Exchange coexistence environment that includes Exchange 2013, and you are still connecting to legacy public folder databases (that do not use Exchange 2013 public folders), you can set the default public folder database to a valid Exchange 2010 or Exchange 2007 legacy public folder database. To do this, run the following command in Exchange Management Shell:

```powershell
Set-MailboxDatabase <Exchange MDB> -PublicFolderDatabase <Legacy Public Folder DB to use>
```
