---
title: Configure security for SQL Server log shipping
description: This article describes how to configure security for SQL Server log shipping and provides information about the problem that may occur when you are configuring security for SQL Server log shipping.
ms.date: 11/03/2020
ms.custom: sap:Log Shipping
ms.reviewer: PANKAJA
ms.topic: how-to
---
# Configure security for SQL Server log shipping

This article describes how to configure security for SQL Server log shipping and provides information about the problem that may occur when you are configuring security for SQL Server log shipping.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 321247

## Summary

This article provides information about how to configure security for log shipping. There are several issues to consider when you are configuring security for SQL Server log shipping that range from the startup account for SQL Server to share permissions for the network share where the transaction log backups reside. These issues are described in this article.

## Domain account

If you have placed SQL Server in a domain, Microsoft recommends that you use a domain account to start SQL Server services. You should use a domain account if you are going to configure SQL Server to run as a Virtual server under Windows Clustering. A domain account provides the benefit of minimal maintenance in case of password changes. However, you may not be able to start SQL under a domain account if SQL Server resides on a server that is in a workgroup.

## Local network account

You can use SQL Server to start under a locally created network account. In the situation where there is network access required by a SQL Server process, which is the case if you have configured SQL Server to use log shipping, you can use network pass-through security. With pass-through security, all machines that will be accessed by SQL Server must have the same network account with the same password and appropriate permissions, configured locally. Additionally, when the SQL Server process requests resources from the second computer, traditional network security is bypassed if the same account (under which the requesting SQL Server service is started) exists with the same password. As long as the account on the second computer is configured with enough permission to carry out the task that is requested by calling SQL Server, the task will be successful.

## Local system account

You can also configure SQL Server to start under the Local System account. Modifying the password for the LocalSystem account may result in the failure of some services that are critical for system stability. This account is local to the computer where it resides, which means that the security context that SQL Server services uses is local. As stated in the Local Network Account section, you cannot use network pass-through security when you start SQL Server under the LocalSystem account because the passwords for the LocalSystem account on different computers are different. The starting of SQL Server under this account when network resource access is required will most likely result in the unsuccessful completion of tasks.

For information about the minimal required rights for a network account to successfully start and run SQL Server and SQL Server Agent services, see [Setting up Windows Service Accounts](https://www.microsoft.com/download/details.aspx?id=51958).

## Understanding the SQL Server security model

To completely understand the security implications, it is important to understand the security model that Microsoft implemented in SQL Server 2000. When you create a login, it is added to the `syslogins` table in the MASTER database. For each database that this newly added login is provided access to, it is added to the `sysusers` table in that database. The mapping between `syslogins` table and `sysusers` table is on the SID field.

If a user database is moved to a different server, the SID values are carried over from the previous server. Either database security breaks when logins on the second server are not created with the same SID values or if the security is improperly configured because of mismatching SID values.

For more information, see [How to resolve permission issues when you move a database between servers that are running SQL Server](https://support.microsoft.com/help/240872).

## Security requirements

- Backup Share

    Configure the network share that is configured to hold the transaction log backups to have read/change permissions for the account under which SQL Server services (on the secondary server that is configured for log shipping) are starting.

    The network share that is configured to hold the transaction log backups, should be configured to have read/change permissions for the account under which SQL Server services, on the secondary server configured for log-shipping, are starting. This share is accessed by the Copy job on the secondary server to copy the transaction log backups to the local folder on the respective secondary server. The Load job then loads these backups from the local folder.

- Cross Domain Log Shipping

    If computers that are running SQL Server are placed in a multi-domain environment, Microsoft recommends that you set up two-way trusts between all domains that are involved in log shipping. However, if you cannot establish trusts between domains, you can use network pass-through security for log shipping. Refer to the section of this article that discusses the LocalSystem network account startup option for SQL Server-related services.

- Selecting Authentication Mode to Connect to Monitor Server

    You can select either Windows authentication or SQL authentication (by primary and secondary servers) to connect to monitor server and to update the monitor tables. You can select this either while setting up log shipping or after you have set up log shipping and it is functional. By default, SQL Server uses Windows authentication; however, if you select SQL authentication, a new SQL login log_shipping_monitor_probe is created on the primary, secondary, and monitor servers if one does not exist. If you select SQL authentication for this purpose, configure SQL Server to use the SQL and Windows authentication option.

## Security configuration on secondary server for standby Databases

If you configure the secondary database in standby mode, you can access this database in read-only state. By restoring the secondary database in this mode, this can provide a means by which to run offline reports, thereby offloading some of the work from the production system. However, for the standby database to support read-only functionality, you may have to apply the same security settings on secondary server. Because the database is in standby state, you cannot even make any modifications for the purposes of configuring security. In this case, you have to create all SQL Server logins with the same SID values on the secondary server. Windows logins automatically retain the same SIDs because the Windows GUID is globally unique, even when using multiple domains.

For more information about how to create SQL logins with the same SID on different servers, see [How to grant access to SQL logins on a standby database when the guest is disabled in SQL Server](https://support.microsoft.com/help/303722).

## Security configuration when performing role change

The role-change procedure for log shipping involves promoting a secondary server to take over as the primary. You can do this with or without the primary server being online. As part of the role change, there are up to four stored procedures that are executed. One of these stored procedures, `sp_resolve_logins` , helps to correct the SID values for logins that reside in the standby database just before it is made available for use as the primary database.

As part of this stored procedure, a `.bcp` file of the `syslogins` table from the former primary server is loaded into a temporary table. Each login that is present in this temporary table is then compared to the `syslogins` table in the MASTER database of the secondary server and the `sysusers` table of the secondary database. For each login in the temporary table that has a login with the same name in the `syslogins` table and same SID as the one in the `sysusers` table of the secondary database, the SID is corrected (in the secondary database) by using `sp_change_users_login` to match the one that is in the `syslogins` table.

Security configuration using this stored procedure requires the following:

- SQL logins must already be created on the secondary server. To do so, use the Transfer Logins DTS task that is explained in SQL Server Books Online topic: **How to set up and perform log shipping role change**.

- You should provide a `.bcp` file of the `syslogins` table from the primary server. This file must be current because an out-of-date file might result in `sp_resolve_logins` failing to fix the logins.

You should meet the following three conditions before `sp_resolve_logins` can actually fix the logins in the secondary database:

1. The name of login from the `.bcp` file of the `syslogins` table must match the name in the `syslogins` table from the primary server.

2. The SID value must match between the login the `.bcp` file and the `sysusers` table in the secondary database.

3. The SID value from the secondary database must be different than the SID value in the `syslogins` table in the MASTER database on the secondary server.

If you create SQL Server logins as described in Q303722, it does not have to run this stored procedure because all logins are already been presented with the same SID value in the `syslogins` table (in MASTER database on the secondary server) and the `sysusers` table (in the secondary database).

## Frequently asked questions

- **Question: Does log shipping propagate security-related changes to a secondary server automatically?**

    Answer: Yes. Because all changes to the system tables are logged operations, these are propagated through to the secondary server (or servers) automatically.

- **Question: Can you have two logins on the secondary server with the same SID? I need this because I am using the same SQL Server computer to maintain multiple standby databases from multiple servers.**

    Answer: No. SQL Server security model does not permit having two logins with the same SID. If there is a conflict on SID while using log shipping with multiple servers, the only way to correct this is to drop the conflicting login on the primary server, and then to create it with an SID that does not exist on the secondary server.
