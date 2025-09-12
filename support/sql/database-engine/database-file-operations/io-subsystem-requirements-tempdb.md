---
title: I/O subsystem requirements for the tempdb
description: This article describes the I/O subsystem requirements for the tempdb database in SQL Server.
ms.date: 06/12/2025
ms.custom: sap:File, Filegroup, Database Operations or Corruption
ms.reviewer: rdorr, jopilov
ms.topic: concept-article
---
# Microsoft SQL Server I/O subsystem requirements for the tempdb database

This article introduces the I/O subsystem requirements for the tempdb database in SQL Server.

_Original product version:_ &nbsp; Microsoft SQL Server  
_Original KB number:_ &nbsp; 917047

## Summary

Microsoft SQL Server requires that the I/O subsystem used to store system and user databases fully honor Write-Ahead Logging (WAL) requirements through specific I/O principals. These requirements are necessary in order to honor the ACID properties of transactions: Atomic, Consistent, Isolated, and Durable. Details about I/O subsystem compliance requirements are provided in [SQL Server I/O basics](/previous-versions//cc966500(v=technet.10)).

The following list is a quick summary of the requirements:

- Write ordering must be maintained.
- Dependent write consistency must be maintained.
- Writes must always be secured in/on stable media.
- Torn I/O prevention must occur.

Durability maintenance remains critical for all other databases but may be relaxed for the tempdb database. The following table summarizes several of the critical I/O requirements for SQL Server databases.

| I/O requirement| Brief description| System or user| tempdb |
|---|---|---|---|
| Write ordering<br/><br/>Dependent write consistency|The ability of the subsystem to maintain the correct order of write operations. This can be especially important for mirroring solutions, group consistency requirements, and SQL Server WAL protocol use.|Required|Recommended|
| Read after write|The ability of the subsystem to service read requests with the latest data image when the read is issued after any write is successfully completed.|Required|Required|
| Survival across outage|The ability for data to remain fully intact (Durable) across an outage, such as a system restart.|Required|Not applicable|
| Torn I/O prevention|The ability of the system to avoid splitting individual I/O requests.|Required|Recommended|
| Sector rewrite|The sector can only be written in its entirety and cannot be rewritten because of a write request on a nearby sector.|\* Discouraged, only permitted if transactional|\* Discouraged, only permitted if transactional|
| Hardened data|The expectation that when a write request or a FlushFileBuffers operation is successfully completed, data has been saved to stable media.|Required|Not applicable|
| Physical sector alignment and size|SQL Server interrogates the data and log file storage locations. All devices are required to support sector attributes permitting SQL Server to perform writes on physical sector-aligned boundaries and in multiples of the sector size.|Required|Required|
  
  Transactional sector rewrites involve fully logged operations by the subsystem permitting a sector to be fully moved, replaced, or rolled back to the original image. These rewrites are typically discouraged because of the additional overhead required to perform such actions. An example of this would be a `defragmentation` utility that is moving the file data. The original sector in the file cannot be replaced with the new sector location until the new sector and data are secured. The remapping of the sector must occur in a transactional manner so that any failure, including a power failure, causes the re-establishment of the original data. Make sure that you have locking mechanisms available during this kind of process to prevent invalid data access, thereby upholding the other tenants of SQL Server I/O.

### Survival across outage

The tempdb database is a scratch area for SQL Server and is rebuilt on every SQL Server startup. The initialization supersedes any need for data to survive a restart.

### Transactional sector rewrite operations

To guarantee the success of the recovery processes, such as rollback and crash recovery, the log records must be correctly stored on stable media before the data page is stored and cannot be rewritten without honoring transactional properties. This requires the subsystem and SQL Server to maintain specific attributes, such as write ordering, sector aligned and sized writes, and other such I/O safety attributes outlined in the previously mentioned documents. For the tempdb database, the crash recovery is unnecessary because the database is always initialized during SQL Server startup. However, the tempdb database still requires rollback capabilities. Therefore, some attributes of the WAL protocol can be relaxed.

The storage location for the tempdb database must act in strict accordance with established disk drive protocols. In all ways, the device on which the tempdb database is stored must appear and act as a physical disk providing read after write capabilities. Transaction sector rewrite operations may be an additional requirement of specific implementations. For example, SQL Server does not support database modifications by using NTFS file system compression because NTFS compression can rewrite sectors of the log that have already been written and considered hardened. A failure during this type of rewrite can cause the database to be unusable, damaging data that SQL Server already considered secure.

> [!NOTE]
> SQL Server extended support or compression to read only databases and file groups. See the SQL Server Books Online for complete details.

Transactional sector rewrite operations are pertinent to all SQL Server databases that include the tempdb database. A growing variety of extended storage technologies use devices and utilities that can rewrite data that SQL Server considers secure. For example, some of the emerging technologies perform in-memory caching or data compression. In order to avoid severe database damage, any sector rewrite must have full transactional support in such a way that if a failure occurs, the data is rolled back to the previous sector images. This guarantees that SQL Server is never exposed to an unexpected interruption or data damage condition.

You may be able to put the tempdb database on specialty subsystems, such as RAM disks, solid state, or other high-speed implementations that cannot be used for other databases. However, the key factors presented in the [More Information](#more-information) section must be considered when you evaluate these options.

> [!NOTE]
> The local disks in Failover Clustered environments are only supported with solid state or high speed implementations. This is because the RAM disk can only be created over an iSCSI target. Additionally, the iSCSI target and Failover Cluster features can't be used on the same host.

## More information

Several factors should be carefully studied when you evaluate the storage location of the tempdb database. For example, the tempdb database usage involves, but isn't limited to, memory footprint, query plan, and I/O decisions. The appropriate tuning and implementation of the tempdb database can improve the scalability and responsiveness of a system. This section discusses the key factors in determining the storage needs for the tempdb database.

### High-speed subsystems

There are various high-speed subsystem implementations available on the market that provides SQL Server I/O subsystem protocol requirements but that don't provide durability of the media.

> [!IMPORTANT]
> Always confirm with the product vendor to guarantee full compliance with SQL Server I/O needs.

A RAM disk is one common example of such an implementation. RAM disks install the necessary drivers and enable part of the main RAM disk to appear as and function like any disk drive that is attached to the system. All I/O subsystems should provide full compliance with the SQL Server I/O requirements. However, it's obvious that a RAM disk is not durable media. Therefore, an implementation such as a RAM disk may only be used as the location of the tempdb database and can't be used for any other database.

### Keys to consider before implementation and deployment

There are various points to consider before deployment of the tempdb database on this kind of subsystem. This section uses a RAM disk as the basis for discussion, but similar outcomes occur in other high-speed implementations.

#### I/O safety

Compliance of read after write and transactional sector writes is a must. Never deploy SQL Server on any system that doesn't fully support the SQL Server I/O requirements, or you risk damage and loss of your data.

#### Pages already cached (Double RAM cache)

Temporary tables are like all other tables in a database. They are cached by the buffer pool and handled by lazy write operations. Storing temporary table pages on a RAM disk causes double RAM caching, one in the buffer pool and one on the RAM disk. This directly takes away from the buffer pool's total possible size and generally decreases the performance of SQL Server.

#### Giving up RAM

The RAM disk designates a part of main RAM as the name implies. There are several implementations of RAM disks and RAM-based files caches available. Some also enable physical I/O backing operations. The key element of the RAM-based file cache is that it directly takes away from the physical memory that can be used by SQL Server. Always have strong evidence that adding a RAM-based file cache improves the application performance and does not decrease other query or application performance.

#### Tune first

An application should tune to remove unnecessary and unwanted sorts and hashes that could cause the use of the tempdb database. Many times the addition of an index can remove the need for the sort or hash in the plan completely, leading to optimal performance without requiring the use of the tempdb database.

#### Possible benefit points

The benefits of putting the tempdb database on a high-speed system can only be determined through rigorous testing and measurements of the application workloads. The workload has to be studied carefully for the characteristics that the tempdb database may benefit from, and the I/O safety must be confirmed before deployment.

The sort and hash operations work together with the SQL Server memory managers to determine the size of the in-memory scratch area for each sort or hash operation. As soon as the sort or hash data exceeds the allocated in-memory scratch area, data may be written to the tempdb database. This algorithm has been expanded in SQL Server, reducing the tempdb database usage requirements over earlier versions of SQL Server.

> [!CAUTION]
> SQL Server is designed to account for memory levels and current query activities when making query plan decisions that involve the use of tempdb database operations. Therefore, the performance gains vary significantly based on workloads and application design. We strongly recommend that you complete testing with the preferred solution to determine possible gains and evaluate I/O safety requirements before such a deployment.

SQL Server uses the tempdb database to handle various activities involving sorts, hashes, the row version store, and temp tables:

- Temporary tables are maintained by the common buffer pool routines for data pages and generally do not exhibit performance benefits from specialty subsystem implementations.
- The tempdb database is used as a scratch area for hashes and sorts. Reducing I/O latency for such operations may be beneficial. However, know that adding an index to avoid a hash or a sort may provide a similar benefit.

Run baselines with and without the tempdb database stored on the high-speed subsystem to compare benefits. Part of the testing should include queries against the user database that do not involve sorts, hashes, or temporary tables, and then confirm that these queries are not adversely affected. When you evaluate the system, the following performance indicators can be helpful.

| Indicator| Description/usage |
|---|---|
| Page reads and writes|Improving the performance of the tempdb database I/Os may change the rate of page reads and writes for the user databases because of the reduced latency associated with the tempdb database I/O. For user database pages, the overall number should not vary across the same workload.|
| Physical read and write bytes to the tempdb database|If moving the tempdb database to a device, such as a RAM disk, increases the actual I/O for the tempdb database, it indicates that the memory taken away from the buffer pool is causing increased tempdb database activity to occur. This pattern is an indicator that the page life expectancy of database pages may also be affected in a negative way.|
| Page life expectancy|A decline in page life expectancy can indicate an increase in the physical I/O requirements for a user database. The rate decrease could likely indicate that the memory taken away from the buffer pool is forcing database pages to exit the buffer pool prematurely. Combine with the other indicators and test to fully understand the parameter boundaries.|
| Overall throughput<br/>CPU usage<br/>Scalability<br/>Response time|The primary goal of a tempdb database configuration change is to increase the overall throughput. Your testing should include a mix of repeatable workloads that can be scaled out to determine how throughput is affected.<br/><br/>Something like a compression-based RAM disk implementation may work well with 10 users. However, with increased workload, this may push CPU levels beyond desired levels and have negative effects on response time when the workloads are high. True stress tests and future load prediction tests are encouraged.|
| Work files and work table creation actions|If moving the tempdb database to a device, such as a RAM disk, changes the query plan by increasing the number or size of work files or work tables, it indicates that the memory taken away from the buffer pool is causing increased tempdb database activity to occur. This pattern is an indication that the page life expectancy of database pages may also be affected in a negative way.|
  
#### Transactional sector rewrite example

The following example elaborates the data security that is required by SQL Server databases.

Assume a RAM disk vendor uses an in-memory compression implementation. The implementation must be correctly encapsulated by providing the physical appearance of the file stream as if the sector was aligned and sized so SQL Server is unaware and correctly secured from the underlying implementation. Look at the compression example closer.

- Sector 1 is written to the device and is compressed to save space.
- Sector 2 is written to the device and is compressed with sector 1 to save space.

The device may perform the following actions to help secure sector 1's data when it is combined with sector 2's data.

- Block all writes to sectors 1 and 2.
- Uncompress sector 1 into a scratch area, leaving current sector 1 storage as the active data to be retrieved.
- Compress sectors 1 and 2 into a new storage format.
- Block all reads and writes of sectors 1 and 2.
- Exchange old storage for sectors 1 and 2 with new storage. If the exchange attempt fails (rollback):
  - Restore the original storage for sectors 1 and 2.
  - Remove the sectors 1 and 2 combined data from the scratch area.
  - Fail the sector 2 write operation.
- Unblock reads and writes for sectors 1 and 2.

The ability to provide locking mechanisms around the sector modifications and roll back the changes when the sector exchange attempt fails is considered transitionally compliant. For implementations that use physical storage for extended backing, it would include the appropriate transaction log aspects to help secure and rollback changes that were applied to the on-disk structures to maintain the integrity of the SQL Server database files.

Any device that enables the rewrite of sectors must support the rewrites in a transactional way so that SQL Server isn't exposed to data loss.

> [!NOTE]
> The instance of SQL Server is restarted when online I/O and rollback failures occur in the tempdb database.

#### Be careful when you move the tempdb database

Be careful when you move the tempdb database because if the tempdb database can't be created, SQL Server won't start. If the tempdb database can't be created, start SQL Server by using the (-f) startup parameter and move the tempdb database to a valid location.

To change the physical location of the tempdb database, follow these steps:

1. Use the `ALTER DATABASE` statement and the `MODIFY FILE` clause to change the physical file names of each file in the tempdb database to refer to the new physical location, such as the new disk.

    ```sql
    ALTER DATABASE tempdb MODIFY FILE 
    (name = tempdev, filename = 'C:\MyPath\tempdb.mdf')

    ALTER DATABASE tempdb MODIFY FILE 
    (name = templog, filename = 'C:\MyPath\templog.ldf')
    ```

2. Stop and then restart SQL Server.

#### Partner product certifications are not a guaranty of compatibility or safety

A third-party product or a particular vendor can receive a Microsoft logo certification. However, partner certification or a specific Microsoft logo doesn't certify compatibility or fitness for a particular purpose in SQL Server.

#### Support

If you use a subsystem with SQL Server that supports the I/O guarantees for transactional database use as described in this article, Microsoft will provide support for SQL Server and SQL Server-based applications. However, issues with, or caused by, the subsystem will be referred to the manufacturer.

For tempdb database-related issues, Microsoft Support Services will ask you to relocate the tempdb database. Contact your device vendor to verify that you have correctly deployed and configured the device for transactional database use.

Microsoft doesn't certify or validate that third-party products work correctly with SQL Server. Additionally, Microsoft doesn't provide any warranty, guaranty, or statement of any third-party product's fitness for use with SQL Server.

## References

For more information, see:

- [Error message 823 may indicate hardware problems or system problems in SQL Server](/sql/relational-databases/errors-events/mssqlserver-823-database-engine-error)

- [Using disk drive caching with SQL Server](https://support.microsoft.com/help/234656)  

- [Description of support for network database files in SQL Server](./support-network-database-files.md)

- [Microsoft does not certify that third-party products will work with Microsoft SQL Server](https://support.microsoft.com/help/913945)

- [Performance guidelines for SQL Server on Azure Virtual Machines](/azure/azure-sql/virtual-machines/windows/performance-guidelines-best-practices)

- [Optimizing Your Query Plans with the SQL Server 2014 Cardinality Estimator](/previous-versions/dn673537(v=msdn.10))

- [Query Performance](/previous-versions/sql/sql-server-2008-r2/ms190610(v=sql.105))

- [SQL Server Database Engine Disk Input/Output (I/O) requirements](./database-engine-input-output-requirements.md)
