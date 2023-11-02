---
title: Install service packs and hotfixes
description: This article describes how to install service packs and hotfixes on an instance of SQL Server that is part of transactional replication and database mirroring topology.
ms.date: 09/25/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: benjones
ms.topic: how-to
---
# Apply a hotfix for SQL Server in a transactional replication and database mirroring topology

## Introduction

This article contains steps that you can follow to install service packs and hotfixes on an instance of Microsoft SQL Server with the following characteristics:

- The instance of SQL Server has one or more databases that participate in both a database mirroring, and transactional replication topology.
- The database participates as a publisher, as a distributor, or as a subscriber.

> [!NOTE]
> The distribution database cannot be mirrored. However, it can co-exist with the principal/publisher database, or with the database mirroring witness.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 977051

## More information

The steps to apply hotfixes to a SQL Server that participates in either a database mirroring or transactional replication is documented in the following topics in SQL Server docs:

- [Upgrade or patch replicated databases](/sql/database-engine/install-windows/upgrade-replicated-databases)

- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)

In an environment where a SQL Server is configured to participate in both database mirroring and transactional replication topology, if the witness and the distributor are on the same server instance, the installation steps are as follows:

1. The mirror
2. The witness/distributor
3. The principal/publisher
4. The subscriber(s)

If the witness and the distributor are not on the same server, the installation steps are as follows:

1. The mirror
2. The witness
3. The distributor
4. The principal/publisher
5. The subscriber(s)

## Procedure

1. If a witness server is in the database mirroring session, you must disable the automatic failover feature during the update process. To do this, remove the witness server from the database mirroring session. If the server is not a partner server of some other database mirroring sessions, follow these steps to disable automatic failover on the witness server:

   - Use the `ALTER ENDPOINT` Transact-SQL statement to disable the database mirroring endpoint.

     For more information, see [Remove the Witness from a Database Mirroring Session (SQL Server)](/sql/database-engine/database-mirroring/remove-the-witness-from-a-database-mirroring-session-sql-server).

   - Perform a full database backup on the principal/publisher database, and then run the `DBCC CHECKDB` command on the principal database.

        > [!NOTE]
        > This step is optional, however, it is recommended. This step will impede production activity. Therefore, you should schedule a maintenance window for this step.

2. Install the service pack or the hotfix on the mirror server. Remember that you may have to update multiple servers at this point.

3. Install the service pack or the hotfix on the witness server.

4. Install the service pack or hotfix on the distributor. If the distributor is located on the same server instance as the witness, these server roles will be updated at the same time.

    > [!NOTE]
    > Replication will be temporarily suspended while the update is being applied. Transactions will remain in the publisher transaction log during the update and will then be replicated as soon as the SQL Service is restarted on the distributor.

5. Resume the database mirroring sessions.

   For more information about how to resume a database mirroring session, see [Pause or Resume a Database Mirroring Session (SQL Server)](/sql/database-engine/database-mirroring/pause-or-resume-a-database-mirroring-session-sql-server).

6. Perform a manual failover to the mirror server so that the mirror server resumes the principal and publisher role.

    For more information about how to manually perform failover to the mirror server, see the **Manually Failing Over to a Secondary Database** topic in SQL Server 2005 or SQL Server 2008 Books Online.

7. Run the `DBCC CHECKDB` command on the principal server.

    > [!NOTE]
    > This step is optional, but recommended.

8. Pause the database mirroring sessions.
9. Install the service pack or the hotfix on the new mirror server.

    > [!NOTE]
    > The new mirror server is the same as the original principal/publisher server. Remember that you may have to update multiple servers at this point.

10. Resume the database mirroring sessions.

    If the database mirroring session has a witness server, undo the changes that you made in step 1.

    For more information about how to do this, see [Add or Replace a Database Mirroring Witness (SQL Server Management Studio)](/sql/database-engine/database-mirroring/add-or-replace-a-database-mirroring-witness-sql-server-management-studio).

      > [!NOTE]
      > When you undo the changes that you made in step 1, the witness server is added back into the database mirroring session.

11. Install the service pack or hotfix on the subscriber(s). During this process, replication from the distributor to the subscriber(s) will be temporarily suspended, and transactions will be queued in the distribution database. If the subscriber is mirrored and a different witness server is used, follow steps 1 to 3 to update the mirror server first, followed by the witness.

