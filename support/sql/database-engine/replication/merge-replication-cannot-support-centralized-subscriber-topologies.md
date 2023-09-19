---
title: Merge replication doesn't support topologies
description: This article discusses alternatives to centralized subscriber topologies in SQL Server.
ms.date: 07/22/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: hnunes, jmneto, jeanyd, lakshmij, holgerl, syele, gemason
---

# Merge replication doesn't support centralized subscriber topologies

This article helps you work around the problem where merge replication doesn't support centralized subscriber topologies.

_Original product version:_ &nbsp; SQL Server 2012, SQL Server 2008, SQL Server 2005  
_Original KB number:_ &nbsp; 2750005

## Summary

Merge replication doesn't support centralized subscriber topologies. A single merge subscriber database can subscribe to only a single merge publication. Therefore, any kind of centralized subscriber topology isn't supported in merge replication.

> [!NOTE]
> This limitation applies to all the currently supported versions of SQL server but doesn't apply to Microsoft SQL Server Compact subscribers.

## Workaround

To work around this issue, consider the following alternatives to using a central subscriber topology and merge replication:

- Implement a single central merge publication that has parameterized row filters in which the data partitions provide the data for the individual subscriber databases.
- Use transactional replication instead of merge replication to implement the central subscriber topology

> [!NOTE]
> For more information about how to implement central subscriber topologies and integrate data from multiple sites, see the [References](#references) section.

## More information

In a central subscriber model, the subscriber database synchronizes with two or more publishing sources. In this scenario, the publishing sources consist of one of the following combinations:

- Two or more publications inside the same publisher database at the same publishing server instance.
- Two or more publications in two or more publisher databases at the same publishing server instance.
- Two or more publications in two or more publisher databases at different publishing server instances.

Merge replication doesn't support the central subscriber model. The merge agents were not designed or tested to work in this scenario. The only supported topology is the topology in which each subscriber database synchronizes with a single merge publication. Consider the following:

> [!NOTE]
> This applies to all versions of Microsoft SQL Server.

- Merge replication metadata of a subscriber database is stored in a single set of metadata tables. If several subscriptions are created in the same database, the metadata of all subscriptions will be stored in the same set of system tables.
- Replication metadata is shared by multiple merge agents.
- Merge agents synchronize publication and subscription information between their configured synchronization partners. Therefore, each synchronization also uploads unrelated metadata from the subscriber database to the publisher database. Additional synchronizations then distribute this metadata to other unrelated nodes in the topology.
- When merge agents synchronize their subscriptions at the same time in parallel. the interaction between the merge agents might affect how the changes are handled. For example, the grouping of generations in batches during the individual upload phase of each synchronization may be affected.

You may have problems if you implement a central merge subscriber model. Examples of the problems that you might experience when you implement a central merge subscriber model include the following:

- The consistency of the merge replication metadata is compromised after a publication is dropped and then re-created on the same publisher server and database that has the same name. In this scenario, merge agents may not synchronize later. For example, you may receive one or more of the following error messages:

  - > Cannot insert duplicate key row in object `dbo.sysmergepartitioninfo` with unique index `uc1sysmergepartitioninfo`.

  - > This publication differs from the publication to which the subscription was initially created. The original publication may have been deleted and replaced with a new publication with the same name. At the subscriber, delete the subscription and recreate it for the new publication.

  - > The merge process detected a mismatch while evaluating the subscriber partition validation expression. The problem can be resolved by reinitializing the subscription.

  - > Unable to retrieve subscription information for the 'Subscriber' from the 'Publisher'. The subscription to publication 'publication' is invalid or has not been setup correctly.

- The consistency of the merge replication metadata may be compromised after a subscription is dropped and then re-created in the central subscriber database.
- The consistency of the merge replication metadata may be compromised if the subscriptions into the central subscriber database are configured to use different values for their parameterized row filters. This includes using different values for the *host_name* parameter in different subscriptions. Additionally, we suspect that mixing filters based on *host_name* and *suser_sname* contributes to this issue.
- Unexpected conflicts during conflict resolution may result in potential data loss. This issue may occur when the merge agents run in parallel at the central subscriber.
- Extensive blocking occurs if merge agents run in parallel. This issue may occur during the start of either the upload or the download phase of the synchronization. This issue can also occur when change data is being read or written. This performance issue might cascade into the topology, depending on the objects that are involved in the blocking.

> [!NOTE]
> These issues may not occur immediately after the topology is configured or changed. These issues may occur unexpectedly and intermittently later. The extent of the issues may depend on the timing of events. For example, when individual merge agents synchronize in relation to one other, the severity of the issue may be affected by the event causing the issue and by how much data is uploaded or downloaded.

## References

- For more information on how to integrate data from multiple sites in Microsoft SQL Server 2008 R2, see [Integrating Data from Multiple Sites (Client)](/previous-versions/sql/sql-server-2008-r2/ms151790(v=sql.105)).

- For more information on how to integrate data from multiple sites in Microsoft SQL Server 2008, see [Integrating Data from Multiple Sites (Client)](/previous-versions/sql/sql-server-2008/ms151790(v=sql.100)).

- For more information on how to integrate data from multiple sites in Microsoft SQL Server 2005, see [Integrating Data from Multiple Sites (Client)](/previous-versions/sql/sql-server-2005/ms151790(v=sql.90)).

- For more information on publishing data and database objects in SQL Server 2012, see the **Publishing Tables in More Than One Publication** topic in [Publish Data and Database Objects](/sql/relational-databases/replication/publish/publish-data-and-database-objects#publishing-tables-in-more-than-one-publication).

- For more information on publishing data and database objects in SQL Server 2008 R2, see the **Publishing Tables in More Than One Publication** topic in [Publishing Data and Database Objects](/previous-versions/sql/sql-server-2008-r2/ms152559(v=sql.105)#publishing-tables-in-more-than-one-publication).

- For more information on publishing data and database objects in SQL Server 2008, see the **Publishing Tables in More Than One Publication** topic in [Publishing Data and Database Objects](/previous-versions/sql/sql-server-2008/ms152559(v=sql.100)#publishing-tables-in-more-than-one-publication).

- For more information on publishing data and database objects in SQL Server 2005, see the **Publishing Tables in More Than One Publication** topic in [Publishing Data and Database Objects](/previous-versions/sql/sql-server-2005/ms152559(v=sql.90)#publishing-tables-in-more-than-one-publication).
