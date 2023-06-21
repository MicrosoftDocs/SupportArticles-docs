---
title: Troubleshooting on Always On issues
description: This article provides resolutions for the common problem about Always On configuration on SQL Server.
ms.date: 08/03/2020
ms.custom: sap:Availability Groups
---

# Troubleshoot SQL Server Always On issues

This article helps you resolve the common problem about Always On configuration on SQL Server.

> [!NOTE]
> For a guided walk through experience of this article, see [Troubleshooting SQL Server Always On Issues](https://support.microsoft.com/sbs/topic/troubleshooting-sql-server-alwayson-issues-a1585e3d-3bb7-5440-bbee-677f7d14f334).

_Original product version:_ &nbsp; SQL Server 2012 Enterprise, SQL Server 2014 Enterprise, SQL Server 2016 Enterprise  
_Original KB number:_ &nbsp; 10179

## Important notes

- Microsoft CSS data indicates that a significant percentage of customer issues is often previously addressed in a released CU, but not applied proactively and hence recommends ongoing, proactive installation of CUs as they become available. For more information, see [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism).

    To check the latest CUs that may be available for your version, see [How to determine the version, edition and update level of SQL Server and its components](https://support.microsoft.com/kb/321185).

- You can see [Useful Tools for Troubleshooting](/previous-versions/sql/sql-server-guides/dn135328(v=sql.110)#useful-tools-for-troubleshooting) and [Monitoring Always On Availability Groups](/previous-versions/sql/sql-server-guides/dn135328(v=sql.110)#monitoring-alwayson-availability-groups) in [Always On Availability Groups Troubleshooting and Monitoring Guide](/previous-versions/sql/sql-server-guides/dn135328(v=sql.110)) to learn more about the tools that you can use for diagnosing different types of issues and for monitoring availability groups. The guide also has additional scenarios that may not be covered in this guided walk through.

- The parent node for Always On Availability Groups documentation and provides a one stop reference for various questions, see [Always On Availability Groups (SQL Server)](/sql/database-engine/availability-groups/windows/always-on-availability-groups-sql-server).

## I need pointers on setting up and configuring Always On Availability groups

If you are looking for documentation on setting up Always On configuration, please see the following documents:

[Getting Started with Always On Availability Groups (SQL Server)](/sql/database-engine/availability-groups/windows/getting-started-with-always-on-availability-groups-sql-server) - The document provides answers to many questions you may have about Availability groups and setup. Following all the steps in this article and reviewing [Prerequisites, Restrictions, and Recommendations for Always On Availability Groups (SQL Server)](/sql/database-engine/availability-groups/windows/prereqs-restrictions-recommendations-always-on-availability) will help prevent many issues that you may run into with setting up and maintaining availability groups in your environment.

### Additional resources

- [Step-By-Step: Creating a SQL Server 2012 Always On Availability Group](/archive/blogs/canitpro/step-by-step-creating-a-sql-server-2012-alwayson-availability-group)
- [Always On Architecture Guides](/archive/blogs/sqlalwayson/alwayson-architecture-guides)
- External link: [SQL Server Always On Availability Groups](http://www.brentozar.com/sql/sql-server-alwayson-availability-groups/)

If this information isn't helpful, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## I am having problems configuring Always On Availability groups

Typical configuration problems include Always On Availability Groups are disabled, accounts are incorrectly configured, the database mirroring endpoint doesn't exist, the endpoint is inaccessible (SQL Server Error 1418), network access doesn't exist, and a join database command fails (SQL Server Error 35250). Review the following document for help on troubleshooting these issues:

[Troubleshoot Always On Availability Groups Configuration (SQL Server)](/sql/database-engine/availability-groups/windows/troubleshoot-always-on-availability-groups-configuration-sql-server)

Additional link: [Fix: Error 41009 when you try to create multiple availability groups](https://support.microsoft.com/kb/2711145)

If the issue still exists, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## I am having issues with Listener configuration (19471, 19476, and other errors)

One of the most common configuration issues customers encounter is availability group listener creation. The errors are similar to the following:

- > Msg 19471, Level 16, State 0, Line 2The WSFC cluster could not bring the Network Name resource with DNS name '' online. The DNS name may have been taken or have a conflict with existing name services, or the WSFC cluster service may not be running or may be inaccessible. Use a different DNS name to resolve name conflicts, or check the WSFC cluster log for more information.

- > Msg 19476, Level 16, State 4, Line 2The attempt to create the network name and IP address for the listener failed. The WSFC service may not be running or may be inaccessible in its current state, or the values provided for the network name and IP address may be incorrect. Check the state of the WSFC cluster and validate the network name and IP address with the network administrator.

The majority of time, listener creation failure resulting in the previous messages are due to a lack of permissions for the Cluster Name Object (CNO) in Active Directory to create and read the listener computer object. For troubleshooting this problem, please review the following articles:

- [Create Listener Fails with Message 'The WSFC cluster could not bring the Network Name resource online'](/archive/blogs/alwaysonpro/create-listener-fails-with-message-the-wsfc-cluster-could-not-bring-the-network-name-resource-online)
- [Troubleshooting Always On availability group listener creation in SQL Server 2012](https://support.microsoft.com/kb/2829783)

- [Configure a listener for an Always On availability group](/sql/database-engine/availability-groups/windows/create-or-configure-an-availability-group-listener-sql-server)

If the issue still exists, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## Automatic Failover isn't working as expected

If you notice that the automatic failover isn't working as expected either during testing or in production, see: [Troubleshooting automatic failover problems in SQL Server 2012 Always On environments](https://support.microsoft.com/kb/2833707).

Improper configuration of **Maximum failures in the specified period** is one of the leading causes for primary not automatically failing over to the secondary. The default value for this setting is **N-1**, where N is the number of replicas. For more information, see [Failover cluster (group) maximum failures limit](https://deep.data.blog/2012/03/09/failover-cluster-group-maximum-failures-limit/).

If the issue still exists, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## I am having issues connecting to Always On Availability groups

After you configure the availability group listener for an Always On Availability Group in SQL Server 2012, you may be unable to ping the listener or connect to it from an application. You may get an error that's similar to the following:

> Sqlcmd: Error: Microsoft SQL Native Client : Login timeout expired.

To troubleshoot this and similar errors, review the following:

- [Time-out error and you cannot connect to a SQL Server 2012 Always On availability group listener in a multi-subnet environment](https://support.microsoft.com/kb/2792139)
- [Connection Timeouts in Multi-subnet Availability Group](/archive/blogs/alwaysonpro/connection-timeouts-in-multi-subnet-availability-group)

More information links:

- [An update introduces support for the Always On features in SQL Server 2012 or a later version to the.NET Framework 3.5 SP1](https://support.microsoft.com/kb/2654347)
- [SQL Server Multi-Subnet Clustering (SQL Server)](/sql/sql-server/failover-clusters/windows/sql-server-multi-subnet-clustering-sql-server)

If the issue still exists, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## I am having issues configuring Always On Availability groups in my Azure VM (IaaS)

1. Lot of issues related to Always On occur due to improper configuration of the listener. If you are having connection issues to the listener,

   1. Make sure you read all the limitations of ILB listener and followed all the steps documented in the following article paying particular attention to dependency configuration, IP address, and various other parameters in the PowerShell script.

   2. If unsure, you may want to delete and recreate the listener as per the above document.

2. If you recently moved your VM to a different service or if the IP addresses changed, you need to update the value of the IP address resource to reflect the new address and you need to recreate the load balanced endpoint for your AG. You can update the IP address using the `Get` or `Set` commands as follows:

    ```console
    Get-ClusterResource "IPResourceName" | Set-ClusterParameter -name Address -value "w.x.y.z"
    ```

Recommended documents:

- [Configure a load balancer for a SQL Server Always On availability group in Azure Virtual Machines](/azure/azure-sql/virtual-machines/windows/availability-group-load-balancer-portal-configure)

- [Recommendations and Best Practices When Deploying SQL Server Always On Availability Groups in Microsoft Azure (IaaS)](https://techcommunity.microsoft.com/t5/sql-server-support/recommendations-and-best-practices-when-deploying-sql-server/ba-p/318391)

If the issue still exists, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## It takes a long time to failover from primary to secondary or vice-versa

After an automatic failover or a planned manual failover without data loss on an availability group, you may find that the failover time exceeds your recovery time objective (RTO). To troubleshoot the causes and potential resolutions, see [Troubleshoot: Availability Group Exceeded RTO](/previous-versions/sql/sql-server-2012/dn135336(v=sql.110)).

If the issue still exists, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## Changes on the Primary Replica are either not reflected on or slow to replicate to the Secondary Replica

You may notice that changes on primary replica are not getting propagated to secondary in a timely manner. To troubleshoot and resolve these problems, try the following:

- For SQL Server 2012 and SQL Server 2014 environments, see [FIX: Slow synchronization when disks have different sector sizes for primary and secondary replica log files in SQL Server AG and Logshipping environments](https://support.microsoft.com/kb/3009974).

- Check if the secondary nodes are in a Paused state in the Cluster administrator.
- See [Troubleshoot: Changes on the Primary Replica are not Reflected on the Secondary Replica](/previous-versions/sql/sql-server-2012/dn135335(v=sql.110)).

If the issue still exists, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## How to manage the size of transaction log for my AG databases

You can reduce the transaction log sizes by configuring regular backups at either primary or secondary servers.

Review the following topics for additional information:

- [Offload supported Backups to secondary replicas of an availability group](/sql/database-engine/availability-groups/windows/active-secondaries-backup-on-secondary-replicas-always-on-availability-groups)
- [Performing Transaction Log Backups using Always On Availability Group Read-Only Secondary Replicas - Part 1](/archive/blogs/alwaysonpro/performing-transaction-log-backups-using-alwayson-availability-group-read-only-secondary-replicas-part-1)

If this information isn't helpful, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## Primary or Secondary Servers struck in Resolving State or you experience unexpected failovers

- Check System and Application event logs for hardware issues and other errors and work with the vendor to fix them.

- If you are using Virtual machines, check their knowledge base to see if there are any recently reported issues that may be contributing to the problem. For example, [Large packet loss at the guest operating system level on the VMXNET3 vNIC in ESXi (2039495)](https://kb.vmware.com/s/article/2039495) has caused issues with AG configuration in some cases.  

- More information:  

  - [Diagnose Unexpected Failover or Availability Group in RESOLVING State](/archive/blogs/alwaysonpro/diagnose-unexpected-failover-or-availability-group-in-resolving-state)
  - External link: [SQL SERVER - Always On Availability Group Stuck in Resolving State For Long time](http://blog.sqlauthority.com/2016/02/27/sql-server-alwayson-availability-group-stuck-in-resolving-state-for-longtime/)  

If the issue still exists, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## Not able to bring resources online

Check if the databases are taking a long time to recover by reviewing the messages in the SQL ErrorLog.

If the issue still exists, see [More information about Always On Availability Groups](#more-information-about-always-on-availability-groups).

## Frequently asked questions

1. **Is it possible to have two Listeners for one availability group?**

    Yes, you can set up multiple listeners for the same availability group. See
 [How to create multiple listeners for same availability group (Goden Yao)](/archive/blogs/sqlalwayson/how-to-create-multiple-listeners-for-same-availability-group-goden-yao).

2. **Is it possible to have a separate NIC card for always on traffic and Client connectivity?**

    Yes, you can have dedicated NIC card for Always On traffic. See [Configure Availability Group to Communicate on a Dedicated Network](/archive/blogs/alwaysonpro/configure-availability-group-to-communicate-on-a-dedicated-network).

3. **What editions support Always On failover cluster instances?**

    This topic in SQL Server Books Online has more information: [Editions and Supported Features for SQL Server 2016](/sql/sql-server/editions-and-components-of-sql-server-2016).

4. **How to recover in case of a failure on all nodes of your cluster?**

    See [WSFC Disaster Recovery through Forced Quorum (SQL Server)](https://support.microsoft.com/kb/2792138).

5. **Where can I find information on support for distributed transactions in AG configurations?**

    See [Transactions - availability groups and database mirroring](/sql/database-engine/availability-groups/windows/transactions-always-on-availability-and-database-mirroring).

6. **How to update Always On configurations?**

    See [Upgrading Always On Availability Group Replica Instances](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances).  

7. **How to add TDE (Transparent Data Encryption) enabled database to AG configuration?**

    To add TDE enabled DB to AG, see [How to configure Always On for a TDE database](/archive/blogs/sqlserverfaq/how-to-configure-always-on-for-a-tde-database).

8. **How to configure alerts for checking if the secondary is lagging behind the primary?**

    You can use the following script:

    ```sql
    SELECT ag.name AS ag_name, ar.replica_server_name AS ag_replica_server,
    dr_state.database_id AS database_id,
    is_ag_replica_local = CASE
        WHEN ar_state.is_local = 1 THEN N'LOCAL'
        ELSE 'REMOTE'
        END,
    ag_replica_role = CASE
        WHEN ar_state.role_desc IS NULL THEN N'DISCONNECTED'
        ELSE ar_state.role_desc
        END,
    dr_state.last_hardened_lsn, dr_state.last_hardened_time,
    datediff(s,last_hardened_time, getdate()) AS 'seconds behind primary'
    FROM (( sys.availability_groups AS ag
    JOIN sys.availability_replicas AS ar
        ON ag.group_id = ar.group_id)
    JOIN sys.dm_hadr_availability_replica_states AS ar_state
        ON ar.replica_id = ar_state.replica_id)
    JOIN sys.dm_hadr_database_replica_states dr_state
        ON ag.group_id = dr_state.group_id AND dr_state.replica_id = ar_state.replica_id
    ```

9. **How to get alerted if the state of the database is other than synchronized?**

    You can use the following script:
  
    ```sql
    SELECT ag.name AS ag_name, ar.replica_server_name AS ag_replica_server,
    dr_state.database_id AS database_id,
    is_ag_replica_local = CASE
        WHEN ar_state.is_local = 1 THEN N'LOCAL'
        ELSE 'REMOTE'
        END,
    ag_replica_role = CASE
        WHEN ar_state.role_desc IS NULL THEN N'DISCONNECTED'
        ELSE ar_state.role_desc
        END,
    ar_state.connected_state_desc, ar.availability_mode_desc, dr_state.synchronization_state_desc
    FROM (( sys.availability_groups AS ag
    JOIN sys.availability_replicas AS ar
        ON ag.group_id = ar.group_id )
    JOIN sys.dm_hadr_availability_replica_states AS ar_state
        ON ar.replica_id = ar_state.replica_id)
    JOIN sys.dm_hadr_database_replica_states dr_state
        ON ag.group_id = dr_state.group_id AND dr_state.replica_id = ar_state.replica_id
    ```

    You can also review the following links for additional methods to monitor Always On groups:

    - [Policy based management for operational issues with Always On availability groups](/sql/database-engine/availability-groups/windows/always-on-policies-for-operational-issues-always-on-availability)

    - External link: [Using Policy Based Management for SQL Server Availability Groups Data Loss Alerts](https://www.mssqltips.com/sqlservertip/3505/using-policy-based-management-for-sql-server-availability-groups-data-loss-alerts/)

    - [Behavior of Dynamic Witness on Windows Server 2012 R2 Failover Clustering](/archive/blogs/askcore/behavior-of-dynamic-witness-on-windows-server-2012-r2-failover-clustering-3)

## More information about Always On Availability Groups

- [Always On Availability Groups Troubleshooting and Monitoring Guide](/previous-versions/sql/sql-server-guides/dn135328(v=sql.110))  
- [Always On availability groups: a high-availability and disaster-recovery solution](/sql/database-engine/availability-groups/windows/always-on-availability-groups-sql-server)
