---
title: How to rebuild or move a MSDTC installation to be used with a SQL failover cluster
description: Describes how to rebuild a broken Microsoft Distributed Transaction Coordinator (MSDTC) installation for use with a failover clustered SQL Server installation, and how to move the MSDTC clustered resource to a new group.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# How to rebuild or move a MSDTC installation to be used with a SQL failover cluster

_Original product version:_ &nbsp; Windows Server 2019, all editions, SQL Server 2008 R2 Workgroup, SQL Server 2008 R2 Developer, SQL Server 2008 R2 Datacenter, SQL Server 2008 Enterprise, SQL Server 2008 Developer, SQL Server 2008 Standard, SQL Server 2012 Business Intelligence, SQL Server 2012 Developer, SQL Server 2012 Enterprise, SQL Server 2012 Standard, SQL Server 2012 Enterprise Core, SQL Server 2014 Business Intelligence, SQL Server 2014 Enterprise, SQL Server 2014 Enterprise Core, SQL Server 2014 Standard, SQL Server 2016 Business Intelligence, SQL Server 2016 Enterprise, SQL Server 2016 Developer, SQL Server 2016 Standard, SQL Server 2016 Enterprise Core, Windows Server 2008 Enterprise without Hyper-V, Windows Server 2008 Datacenter, Windows Server 2012 Foundation, Windows Server 2012 Datacenter, Windows Server 2012 Standard, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, Windows Server 2016, Windows Server 2016 Datacenter, SQL Server 2017 on Windows (all editions), Windows Server version 1709, Windows Server version 1803  
_Original KB number:_ &nbsp; 294209

## Summary

This article describes how to rebuild a broken Microsoft Distributed Transaction Coordinator (MSDTC) installation for use with a failover clustered SQL Server installation. The following blog has detailed information around the changes in MSDTC behavior since the release of Windows 2008.


- ﻿ [MSDTC Recommendations on SQL Failover Cluster](https://docs.microsoft.com/archive/blogs/alwaysonpro/msdtc-recommendations-on-sql-failover-cluster) 

The purpose of the following FAQ (Frequently Asked Questions) is to address common questions with MSDTC (Microsoft Distributed Transaction Coordinator) when used with SQL Server Failover Clustered instances to include current recommendations and best practices.

## Introduction

The Microsoft Distributed Transaction Coordinator (MSDTC) is a transaction manager that permits client applications to include several different data sources in one transaction and which then coordinates committing the distributed transaction across all the servers that are enlisted in the transaction. This helps ensure that the transaction is committed, if every part of the transaction succeeds, or is rolled back, if any part of the transaction process fails.  

A lot of people ask why we need to install MSDTC prior to installing SQL Server, you no longer need to do this that was a requirement that SQL Server 2005 had required. That version of SQL Server has ended its lifecycle and so ended the requirement to perform SQL Server installation.  

When deploying SQL Server in a highly available environment like Windows Failover Clustering, there are certain best practices that can make the MSDTC services behavior more predictable.  


- When the topic of cross-database and/or DTC transaction support, under an Availability Group, comes up the quick response is **NOT SUPPORTED!**  

- This is a true statement and the conversation tends to then focus on but why? In fact, some DBAs have tested various forms of these transaction types and not encountered errors.

- The issue is the testing is not complete and the two-phase commit activity required can result in data loss or a database that does not recover as expected in certain configurations. In fact, the SQL Server testers inject failures at strategic locations to create the scenarios that are difficult (but not impossible) to create on a production server. For more information, see [Not-Supported: AGs with TC/Cross-Database Transaction](https://docs.microsoft.com/archive/blogs/alwaysonpro/not-supported-ags-with-dtccross-database-transactions).  

With Windows 2008 Failover cluster and later you do not need to cluster MSDTC to utilize the functionality of the MSDTC service. This is because MSDTC was re-designed in Windows 2008 and unlike Windows 2003 if Windows Failover Cluster was installed you had to cluster MSDTC. This is no longer the case when using Windows 2008, since by default MSDTC service is running locally, even with Failover Clustering installed.  

If your SQL Server Failover Clustered Instance does require MSDTC and does require the MSDTC resoruces to failover with the SQL Server Instance, we recommend creating a MSDTC resource within the FailoverCluster role containing the SQL Server instance and that it use:  

- The SQL Server network name \client access point

- A disk within the SQL Server role

- The MSDTC resource should be named with the SQL virtual server name.


## More Information

### How to setup and test a new MSDTC cluster resource by using PowerShell

# Create a new MSDTC resource replacing the content between and including the <> sections below then execute.

$SqlRole = <Actual name of the role containing the SQL Server instance>

$SqlNetName = <Actual SQL Servernetwork resourcename>

$VSqlSrv = <Actual SQL Server virtual server name>

$CluDsk = <Actual disk resource name># NOTE: If the MSDTC resource did not accept the name provided you can alter the name using the following Powershell replacing the New Distributed Transaction Coordinator with RealSqlVsName:

Get-ClusterResource "New Distributed Transaction Coordinator" | %{$_.Name = RealSqlVsName }

# $VSqlSrv can be substituted for RealSqlVsName if still active

# Script to verify firewall rules

Set-NetFirewallRule -Name 'RPC Endpoint Mapper' -Enabled True

Set-NetFirewallRule -Name 'DTC incoming connections' -Enabled True

Set-NetFirewallRule -Name 'DTC outgoing connections' -Enabled True

# Setting the MSDTC network authentication

Set-DtcNetworkSetting -AuthenticationLevel Mutual;

-DtcName "Local" -InboundTransactionsEnabled $True;

-LUTransactionsEnabled $True;

-OutboundTransactionsEnabled $True;

-RemoteAdministrationAccessEnabled $False;

-RemoteClientAccessEnabled $False;

-XATransactionsEnabled $True -verbose

# Verify the new MSDTC resoruce is now listed

Get-Dtc -Verbose |Sort-Object DtcName

# Test the new MSDTC resource

Test-Dtc -LocalComputerName RealSqlVsName -Verbose

# $VSqlSrv can be substituted for RealSqlVsName if still active, Use $Env:COMPUTERNAME to test the local installation. The firewall rules and MSDTC authentication PowerShell commands will need to be executed on all the other existing cluster nodes.  

#### Testing MSDTC  

In this example, we will use the AdventureWorks2012 database, you have to substitute an actual database name that you want to test against.  
 From a SQL Server query window run the following SQL statement:  

```
USE AdventureWorks2012;

GO

BEGIN DISTRIBUTED TRANSACTION; 

-- Enter fake trans action to the database

INSERT SQL_Statement

DELETE SQL_Statement

COMMIT TRANSACTION

GO
```

You should now see that one row affected and that the inserted record does not exist. 

## Reference

KB 2027550 ﻿ [Recommended MSDTC settings for using Distributed Transactions in SQL Server](https://support.microsoft.com/help/2027550/recommended-msdtc-settings-for-using-distributed-transactions-in-sql-server) ﻿
