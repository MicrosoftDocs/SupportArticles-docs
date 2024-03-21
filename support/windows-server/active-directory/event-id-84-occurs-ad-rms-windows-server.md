---
title: Event ID 84 occurs in AD RMS in Windows Server
description: Fixes an issue in which event ID 84 is logged in Active Directory Rights Management Services (AD RMS) in Windows Server 2008 and later.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, kakojima, kmasudo, kewaka, slight
ms.custom: sap:Active Directory\AD Rights Management Service (Azure Information Protection only), csstroubleshoot
---
# Event ID 84 occurs in Active Directory Rights Management Services (AD RMS) in Windows Server

This article provides help to fix an issue in which event ID 84 is logged in Active Directory Rights Management Services (AD RMS) in Windows Server.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4038927

## Symptoms

On a Windows Server-based computer that has Active Directory Rights Management Services (AD RMS) installed, you receive the following event:
> Log Name:      Application  
Source:        Active Directory Rights Management Services  
Date:         Date/Time  
Event ID:      84  
Task Category: Certification  
Level:         Error  
Keywords:      Classic  
User:          N/A  
Computer:      `ipc01.treyresearch.net`  
Description:  
This Active Directory Rights Management Services (AD RMS) cluster cannot perform an operation on one of the AD RMS databases. Ensure that all AD RMS databases are operating correctly on the network and that the AD RMS service account has read and write permissions to the databases.  
>
> Parameter Reference  
Context: Pipeline[ComponentBase.LogResults]  
RequestId:RequestID  
HelpLink.ProdName: Microsoft SQL Server  
HelpLink.ProdVer: 10.50.4000  
HelpLink.EvtSrc: MSSQLServer  
HelpLink.EvtID: 8115  
HelpLink.BaseHelpUrl: `https://go.microsoft.com/fwlink`  
HelpLink.LinkId: 20476  
SqlError-1.Class: 0  
SqlError-0.State: 1  
SqlError-1.Server: `sql01.treyresearch.net`,1441  
SqlError-0.Message: **Arithmetic overflow error converting IDENTITY to data type smallint.**  
SqlError-1.Number: 3606  
SqlError-0.Number: 8115  
SqlError-1.Message: Arithmetic overflow occurred.  
SqlError-1.State: 0  
SqlError-0.Server: `sql01.treyresearch.net`,1441  
SqlError-0.Class: 16  
>
> Microsoft.RightsManagementServices.LowSeveritySqlException  
        Message: The Database Engine threw this exception in response to an error that can be corrected by the user, such as a missing database object or entity, possible data inconsistency, transaction deadlock, security setting problems, or SQL command syntax error.  Please examine the SqlError details for more information.  
        HelpLink.ProdName: Microsoft SQL Server  
        HelpLink.ProdVer: 10.50.4000  
        HelpLink.EvtSrc: MSSQLServer  
        HelpLink.EvtID: 8115  
        HelpLink.BaseHelpUrl: `https://go.microsoft.com/fwlink`  
        HelpLink.LinkId: 20476  
        Context: ComponentBase.LogResults  
        SqlError-1.Class: 0  
        SqlError-0.State: 1  
        SqlError-1.Server: `sql01.treyresearch.net`,1441  
        SqlError-0.Message: Arithmetic overflow error converting IDENTITY to data type smallint.  
        SqlError-1.Number: 3606  
        SqlError-0.Number: 8115  
        SqlError-1.Message: Arithmetic overflow occurred.  
        SqlError-1.State: 0  
        SqlError-0.Server: `sql01.treyresearch.net`,1441  
        SqlError-0.Class: 16  
  \+ System.Data.SqlClient.SqlException  
  \+         Message: Arithmetic overflow error converting IDENTITY to data type smallint.
Arithmetic overflow occurred.  
  \+         HelpLink.ProdName: Microsoft SQL Server  
  \+         HelpLink.ProdVer: 10.50.4000  
  \+         HelpLink.EvtSrc: MSSQLServer  
  \+         HelpLink.EvtID: 8115  
  \+         HelpLink.BaseHelpUrl: `https://go.microsoft.com/fwlink`  
  \+         HelpLink.LinkId: 20476  
  \+         Context: ComponentBase.LogResults  

## Cause

This issue occurs because the AD RMS logging process does not log an event to the logging database.

There are two tables in the logging database that refer to a UserAgentId value. Both the dbo.UserAgent and the dbo.ServiceRequest tables have a UserAgentId column. These columns are both of data type smallint. As soon as the UserAgentId value exceeds the maximum value (~32,767), the logging database cannot update. When a transaction does not log, RMS will roll back the request and throw an error.

## More information

When requesting a license from AD RMS, clients are passing agent strings with the basic information about the requesting application. The dbo.UserAgent table only stores unique agent strings.

Originally, the MSIPC clients just passed in versions of OS, application, MSIPC, and architecture. The table in which the strings are stored only keeps unique entries. There should not be lots of unique strings across the user base.

```sql
MSIPC;version=1.0.2191.0;AppName=EXCEL.EXE;AppVersion=16.0.7369.2127;AppArch=x86;OSName=Windows;OSVersion=10.0.10586;OSArch=amd64
```

At some point, the MSIPC client started including the process ID (PID) to that user agent string. This makes every string unique.

```sql
MSIPC;version=1.0.2456.0;AppName=EXCEL.EXE;AppVersion=15.0.4919.1000;AppArch=x86;PID=13660;OSName=Windows;OSVersion=6.1.7601;OSA
```

Therefore, the table that should not have terribly many unique strings to store now has many thousands.

## Workaround

To work around this issue, disable logging on the AD RMS cluster:

:::image type="content" source="media/event-id-84-occurs-ad-rms-windows-server/disable-logging-on-the-ad-rms-cluster.png" alt-text="Unselect the Enable logging option on the A D R M S cluster.":::

## Resolution

To resolve this issue, change the data type of the columns from smallint to int (integer). To do this, follow these steps:

> [!Note]
> A large logging database (DB) may take a long time to alter and may cause SQL performance issues. Therefore, we recommend that you back up the SQL DB from the production SQL instance and restore it on a nonproduction SQL location. After that, you can perform the database alteration on the nonproduction SQL location, and then replace the production DB.

1. Back up the AD RMS logging database.
2. Collect the SQL information.
    - The AD RMS logging database name
    - The Dbo.UserAgent key name

    :::image type="content" source="media/event-id-84-occurs-ad-rms-windows-server/sql-information.png" alt-text="Collect the SQL information about the A D R M S logging database name and Dbo.UserAgent key name.":::

3. Generate the script (see the following sample).

### Sample script

> [!Note]
> Edit the database name and the UserAgent table key value to reflect the target environment.

```sql
/******************************************************************************* 
THIS TOOL AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
*******************************************************************************/
use [DRMS_Logging_ipc_treyresearch_net_443]
go

ALTER TABLE [dbo].[ServiceRequest] drop CONSTRAINT [FK_CLIENTINFOID_ServiceRequest_UserAgent]
GO

Alter table [dbo].[ServiceRequest] alter COLUMN [UserAgentId] int
GO

ALTER TABLE [dbo].[UserAgent] DROP CONSTRAINT [PK__UserAgen__UserAgentId]
GO

Alter table [dbo].[UserAgent] alter COLUMN [UserAgentId] int
GO

Alter table [dbo].[UserAgent] ADD PRIMARY KEY (UserAgentId)
GO

ALTER TABLE [dbo].[ServiceRequest] WITH CHECK ADD CONSTRAINT [FK_CLIENTINFOID_ServiceRequest_UserAgent] FOREIGN KEY([UserAgentId]) REFERENCES [dbo].[UserAgent] ([UserAgentId])
GO

ALTER TABLE [dbo].[ServiceRequest] CHECK CONSTRAINT [FK_CLIENTINFOID_ServiceRequest_UserAgent]
GO
```
