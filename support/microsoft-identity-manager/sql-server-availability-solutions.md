---
title: SQL Server availability solutions
description: Describes SQL Server availability solutions for the Identity Manager service (FIMService) and the Synchronization service (FIMSynchronizationService) databases.
ms.date: 08/18/2020
ms.reviewer: jchornbe, stevekl, mwahl, midi, stlieber
---
# SQL Server availability solutions for Microsoft Identity Manager services databases

This article describes the availability solutions for Microsoft SQL Server for the Microsoft Identity Manager service (`FIMService`) and the Synchronization service (`FIMSynchronizationService`) databases.

_Original product version:_ &nbsp; Microsoft Identity Manager 2016  
_Original KB number:_ &nbsp; 3200896

## High availability

High availability (HA) is supported in the following scenarios for a configuration of SQL Server:

- Failover clustering is supported.
- Mirroring is supported on 4.4.1459.0 or later versions.
- Always On Availability Groups is supported on 4.4.1459.0 or later versions.
- Synchronization server HA isn't supported.

## Disaster recovery

Disaster recovery is supported in the following scenarios for a configuration of SQL Server:

- Log shipping is supported.
- Mirroring is supported (this feature will likely be deprecated in future SQL Server versions).
- Always On Availability Groups is supported - [Synchronous (supported on 4.4.1459.0 or later versions)/Asynchronous-Commit Availability mode]  

## Known issues and findings

> [!NOTE]
> Unless otherwise specified, the following items apply to all databases for the MIM server components.

- The SQLNCLI OLE DB Provider doesn't support the `MultiSubnetFailover` keyword. To use the `MultiSubnetFailover` keyword, use the ODBC driver. For more information, see [SQL Server Native Client Support for High Availability, Disaster Recovery](/sql/relational-databases/native-client/features/sql-server-native-client-support-for-high-availability-disaster-recovery).

- By default, the `RegisterAllProvidersIP` is now disabled.

- The FIMService server service throws an exception. The service tries to send the fault to the client if it's necessary and update the request status to **Denied**.

- The FIMService server service retries to connect to the database. There are 10 retries with a timeout of 6 seconds, after which the service is terminated if the database isn't available. If the database is available, the service tries to continue processing request.

- The FIMService server service throws an exception or retries to connect to the database when the server service tries to update its status to **Denied** if the database isn't available.

- For the Synchronization service, if a request fails during a sync session (FIM MA import/export) because the `FIMService` database isn't available, the sync session will stop with **Stop Server** status (the same error as for `FIMSynchronizationService` database isn't available).

    > [!NOTE]
    > To work around this issue, run (Delta/Full) import, and then continue with the export.

- In some scenarios, slow SQL Server replication is lagging as this may bring down the service request pipeline.
