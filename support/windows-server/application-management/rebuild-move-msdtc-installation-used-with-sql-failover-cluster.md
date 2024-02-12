---
title: How to rebuild or move a MSDTC installation for use with a SQL failover cluster
description: Describes how to rebuild a broken Microsoft Distributed Transaction Coordinator (MSDTC) installation for use with a failover clustered SQL Server installation, and how to move the MSDTC clustered resource to a new group.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dtc-startup-configuration-connectivity-and-cluster, csstroubleshoot
---
# How to rebuild or move a MSDTC installation for use with a SQL failover cluster

This article describes how to rebuild a broken Microsoft Distributed Transaction Coordinator (MSDTC) installation for use with a failover clustered SQL Server installation.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 294209

## Summary

The following blog has detailed information around the changes in MSDTC behavior since the release of Windows Server 2008.

[MSDTC Recommendations on SQL Failover Cluster](/archive/blogs/alwaysonpro/msdtc-recommendations-on-sql-failover-cluster)

The purpose of the following Frequently Asked Questions (FAQs) is to address common questions with MSDTC when used with SQL Server Failover Clustered instances to include current recommendations and best practices.

The MSDTC is a transaction manager that permits client applications to include several different data sources in one transaction and which then coordinates committing the distributed transaction across all the servers that are enlisted in the transaction. This helps ensure that the transaction is committed, if every part of the transaction succeeds, or is rolled back, if any part of the transaction process fails.  

Many people ask why we need to install MSDTC before installing SQL Server. You no longer need to do this operation. It was a requirement that SQL Server 2005 had required. That version of SQL Server has ended its lifecycle and so ended the requirement to install SQL Server.  

When deploying SQL Server in a highly available environment like Windows Failover Clustering, there are certain best practices that can make the MSDTC services behavior more predictable.

- When the topic of cross-database and/or DTC transaction support, under an Availability Group, comes up the quick response is **NOT SUPPORTED!**.

- This is a true statement and the conversation tends to then focus on but why? In fact, some DBAs have tested various forms of these transaction types and not encountered errors.

- The issue is the testing is not complete and the two-phase commit activity required can result in data loss or a database that does not recover as expected in certain configurations. In fact, the SQL Server testers inject failures at strategic locations to create the scenarios that are difficult (but not impossible) to create on a production server. For more information, see [Not-Supported: AGs with TC/Cross-Database Transaction](/archive/blogs/alwaysonpro/not-supported-ags-with-dtccross-database-transactions).  

With Windows 2008 Failover cluster and later, you don't need to cluster MSDTC to use the functionality of the MSDTC service because MSDTC was re-designed in Windows 2008. Unlike Windows 2003, if you install Windows Failover Cluster, you had to cluster MSDTC. This is no longer the case when using Windows 2008, since by default MSDTC service is running locally, even with Failover Clustering installed.  

If your SQL Server Failover Clustered Instance does require MSDTC and does require the MSDTC resources to fail over with the SQL Server Instance, we recommend creating a MSDTC resource within the FailoverCluster role that contains the SQL Server instance and that it use:  

- The SQL Server network name\\client access point
- A disk within the SQL Server role
- Name the MSDTC resource with the SQL virtual server name.

## Setup and test a new MSDTC cluster resource by using PowerShell

1. Create a new MSDTC resource replacing the content between and including the <> sections below then execute.

    ```powershell
    $SqlRole = <Actual name of the role containing the SQL Server instance>
    $SqlNetName = <Actual SQL Servernetwork resourcename>
    $VSqlSrv = <Actual SQL Server virtual server name>
    $CluDsk = <Actual disk resource name>
    ```

    If the MSDTC resource didn't accept the name provided, you can alter the name using the following PowerShell replacing the New Distributed Transaction Coordinator with RealSqlVsName:

    ```powershell
    Get-ClusterResource "New Distributed Transaction Coordinator" | %{$_.Name = RealSqlVsName }
    ```

    You can substitute `$VSqlSrv` for RealSqlVsName if still active.

2. Verify firewall rules by using the following script:

    ```powershell
    Set-NetFirewallRule -Name 'RPC Endpoint Mapper' -Enabled True
    Set-NetFirewallRule -Name 'DTC incoming connections' -Enabled True
    Set-NetFirewallRule -Name 'DTC outgoing connections' -Enabled True
    ```

3. Set the MSDTC network authentication by using the following script:

    ```powershell
    Set-DtcNetworkSetting -AuthenticationLevel Mutual `
    -DtcName "Local" -InboundTransactionsEnabled $True `
    -LUTransactionsEnabled $True `
    -OutboundTransactionsEnabled $True `
    -RemoteAdministrationAccessEnabled $False `
    -RemoteClientAccessEnabled $False `
    -XATransactionsEnabled $True -verbose
    ```

4. Verify the new MSDTC resource is now listed by using the following command:

    ```powershell
    Get-Dtc -Verbose |Sort-Object DtcName
    ```

5. Test the new MSDTC resource.

    ```powershell
    Test-Dtc -LocalComputerName RealSqlVsName -Verbose
    ```

    You can substitute `$VSqlSrv` for RealSqlVsName if still active. Use `$Env:COMPUTERNAME` to test the local installation. You'll need to execute the firewall rules and MSDTC authentication PowerShell commands on all the other existing cluster nodes.  

6. Test MSDTC.

    In this example, we'll use the AdventureWorks2012 database, you have to substitute an actual database name that you want to test against. From a SQL Server query window, run the following SQL statement:  

    ```sql
    USE AdventureWorks2012;
    
    GO
    
    BEGIN DISTRIBUTED TRANSACTION; 
    
    -- Enter fake transaction to the database
    
    INSERT SQL_Statement
    
    DELETE SQL_Statement
    
    COMMIT TRANSACTION
    
    GO
    ```

    You should now see that one row affected and that the inserted record doesn't exist.

## References

[Recommended MSDTC settings for using Distributed Transactions in SQL Server](https://support.microsoft.com/help/2027550/recommended-msdtc-settings-for-using-distributed-transactions-in-sql-s)
