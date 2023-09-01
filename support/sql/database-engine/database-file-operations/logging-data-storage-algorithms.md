---
title: Logging and data storage algorithms
description: This article discusses how SQL Server logging and data storage algorithms extend data reliability.
ms.date: 10/10/2022
ms.custom: sap:Administration and Management
ms.reviewer: rdorr, bobward
---
# Description of logging and data storage algorithms that extend data reliability in SQL Server

_Original product version:_ &nbsp; SQL Server 2014, SQL Server 2012, SQL Server 2008, SQL Server 2005  
_Original KB number:_ &nbsp; 230785

## Summary

This article discusses how Microsoft SQL Server logging and data algorithms extend data reliability and integrity.

To learn more about the underlying concepts of the engines and about Algorithm for Recovery and Isolation Exploiting Semantics (ARIES), see the following ACM Transactions on Database Systems document (under Volume 17, Number 1, March 1992):

External link: [ARIES: A Transaction Recovery method Supporting Fine-Granularity Locking and Partial Rollbacks Using Write-Ahead Logging](https://dl.acm.org/doi/10.1145/128765.128770)

The document addresses the SQL Server techniques to extend data reliability and integrity as related to failures.

We recommend that you read the following articles in the Microsoft Knowledge Base for more information about caching and alternative failure mode discussions:

- [Description of caching disk controllers in SQL Server](https://support.microsoft.com/help/86903)

- [Information about using disk drive caches with SQL Server that every database administrator should know](https://support.microsoft.com/help/234656)  

## Terms used in this article

Before we begin the in-depth discussion, some of the terms that are used throughout this article are defined in the following table.

|Term|Definition|
|---|---|
|Battery-backed|Separate and localized battery Backup facility directly available and controlled by the caching mechanism to prevent data loss.<br/> This isn't an uninterruptible power supply (UPS). A UPS doesn't guarantee any write activities and can be disconnected from the caching device.|
|Cache|Intermediary storage mechanism used to optimize physical I/O operations and improve performance.|
|Dirty Page|Page containing data modifications that are yet to be flushed to stable storage. For more information about dirty page buffers, see [Writing Pages](/previous-versions/sql/sql-server-2008-r2/aa337560(v=sql.105)) at SQL Server Books Online.<br/>The content also applies to Microsoft SQL Server 2012 and later versions.|
|Failure|Anything that might cause an unexpected outage of the SQL Server process. Examples include: power outage, computer reset, memory errors, other hardware issues, bad sectors, drive outages, system failures, and so on.|
|Flush|Forcing of a cache buffer to stable storage.|
|Latch|Synchronization object used to protect physical consistency of a resource.|
|Nonvolatile storage|Any medium that remains available across system failures.|
|Pinned page|Page that remains in data cache and can't be flushed to stable storage until all associated log records are secured in a stable storage location.|
|Stable storage|Same as nonvolatile storage.|
|Volatile storage|Any medium that will not remain intact across failures.<br/>|
  
## Write-Ahead Logging (WAL) protocol

The term protocol is an excellent way to describe WAL. It's a specific and defined set of implementation steps necessary to make sure that data is stored and exchanged correctly and can be recovered to a known state if there is a failure. Just as a network contains a defined protocol to exchange data in a consistent and protected manner, so too does the WAL describe the protocol to protect data.

The ARIES document defines the WAL as follows:

The WAL protocol asserts that the log records representing changes to some data must already be in stable storage before the changed data is allowed to replace the previous version of the data in nonvolatile storage. That is, the system isn't allowed to write an updated page to the nonvolatile storage version of the page until at least the undo portions of the log records, which describe the updates to the page have been written to stable storage.

For more information about write-ahead logging, see the [Write-Ahead Transaction Log](/previous-versions/sql/sql-server-2008-r2/ms186259(v=sql.105)) topic at SQL Server Books Online.

## SQL Server and the WAL

SQL Server uses the WAL protocol. To make sure that a transaction is correctly committed, all log records that are associated with the transaction must be secured in stable storage.

To clarify this situation, consider the following specific example.

> [!NOTE]
> For this example, assume that there's no index and that the affected page is page 150.

```sql
BEGIN TRANSACTION
 INSERT INTO tblTest VALUES (1)
COMMIT TRANSACTION
```

Next, break down the activity into simplistic logging steps, as described in the following table.

|Statement|Actions performed|
|---|---|
|BEGIN TRANSACTION|Written to the log cache area. However, it's not necessary to flush to stable storage because the SQL Server hasn't made any physical changes.|
|INSERT INTO tblTest|<br/>1. Data page 150 is retrieved into SQL Server data cache, if not already available.<br/>2. The page is _latched_, _pinned_, and _marked dirty_, and appropriate locks are obtained.<br/>3. An Insert Log record is built and added to the log cache.<br/>4. A new row is added to the data page.<br/>5. The latch is released.<br/>6. The log records associated with the transaction or page doesn't have to be flushed at this point because all changes remain in volatile storage.|
|COMMIT TRANSACTION|<br/>1. A Commit Log record is formed and the log records associated with the transaction must be written to stable storage. The transaction isn't considered committed until the log records are correctly assigned to stable storage.<br/>2. Data page 150 remains in SQL Server data cache and isn't immediately flushed to stable storage. When the log records are correctly secured, recovery can redo the operation, if it's necessary.<br/>3. Transactional locks are released.|
  
Don't be confused by the terms "locking" and "logging." Although important, locking, and logging are separate issues when you deal with the WAL. In the previous example, SQL Server generally holds the latch on page 150 for the time necessary to perform the physical insert changes on the page, not the entire time of the transaction. The appropriate lock type is established to protect the row, range, page, or table as necessary. Refer to the SQL Server Books Online locking sections for more details about lock types.

Looking at the example in more detail, you might ask what happens when the LazyWriter or CheckPoint processes run. SQL Server issues all appropriate flushes to stable storage for transactional log records that are associated with the dirty and pinned page. This makes sure that the WAL protocol data page can never be written to stable storage until the associated transactional log records have been flushed.

## SQL Server and stable storage

SQL Server enhances log and data page operations by including the knowledge of disk sector sizes (commonly 4,096 bytes or 512 bytes).

To maintain the ACID properties of a transaction, the SQL Server must account for failure points. During a failure, many disk drive specifications only guarantee a limited number of sector write operations. Most specifications guarantee completion of a single sector write when a failure occurs.

SQL Server uses 8-KB data pages and the log (if flushed) on multiples of the sector size. (Most disk drives use 512 bytes as the default sector size.) If there is a failure, SQL Server can account for write operations larger than a sector by employing log parity and torn write techniques.

## Torn page detection

This option allows SQL Server to detect incomplete I/O operations caused by power failures or other system outages. When true, it causes a bit to be flipped for each 512-byte sector in an 8 kilobyte (KB) database page whenever the page is written to disk. If a bit is in the wrong state when the page is later read by SQL Server, then the page was written incorrectly; a torn page is detected. Torn pages are detected during recovery because any page that was written incorrectly is likely to be read by recovery.

Although SQL Server database pages are 8 KB, disks perform I/O operations by using a 512-byte sector. Therefore, 16 sectors are written per database page. A torn page can occur if the system fails (for example, because of a power failure) between the time that the operating system writes the first 512-byte sector to disk and the completion of the 8-KB I/O operation. If the first sector of a database page is successfully written before the failure, the database page on disk will appear as updated, although it may not have succeeded.

By using battery-backed disk controller caches, you can make sure that data is successfully written to disk or not written at all. In this situation, don't set torn page detection to "true" because this isn't necessary.

> [!NOTE]
> Torn page detection isn't enabled by default in SQL Server. For more information, see [ALTER DATABASE SET Options (Transact-SQL)](/sql/t-sql/statements/alter-database-transact-sql-set-options).

## Log parity

Log parity checking is similar to torn page detection. Each 512-byte sector contains parity bits. These parity bits are always written with the log record and evaluated when the log record is retrieved. By forcing log writes on a 512-byte boundary, SQL Server can make sure that committal operations are written to the physical disk sectors.

## Performance impacts

All versions of SQL Server open the log and data files by using the Win32 CreateFile function. The dwFlagsAndAttributes member includes the `FILE_FLAG_WRITE_THROUGH` option when they're opened by SQL Server.

`FILE_FLAG_WRITE_THROUGH` instructs the system to write through any intermediate cache and go directly to disk. The system can still cache write operations, but can't lazily flush them.

The `FILE_FLAG_WRITE_THROUGH` option makes sure that when a write operation returns a successful completion, the data is correctly stored in stable storage. This aligns with the WAL protocol that ensures the data.

Many disk drives (SCSI and IDE) contain onboard caches of 512 KB, 1 MB, or larger. However, the drive caches usually rely on a capacitor and not a battery-backed solution. These caching mechanisms can't guarantee writes across a power cycle or similar failure point. They only guarantee the completion of the sector write operations. This is specifically why the torn write and log parity detection were built into SQL Server 7.0 and later versions. As the drives continue to grow in size, the caches become larger, and they can expose larger amounts of data during a failure.

Many hardware vendors provide battery-backed disk controller solutions. These controller caches can maintain the data in the cache for several days and even allow the caching hardware to be placed in a second computer. When power is correctly restored, the unwritten data is flushed before the further data access is allowed. Many of them allow a percentage of read versus write cache to be established for optimal performance. Some contain large memory storage areas. In fact, for a specific segment of the market, some hardware vendors provide high-end battery-backed disk caching controller systems with 6 GB of cache. These can significantly improve database performance.

Advanced caching implementations will handle the `FILE_FLAG_WRITE_THROUGH` request by not disabling the controller cache because they can provide true rewrite capabilities in the event of a system reset, power failure, or other failure point.

I/O transfers without the use of a cache can be longer because of the mechanical time that's required to move the drive heads, spin rates, and other limiting factors.

## Sector ordering

A common technique used to increase I/O performance is sector ordering. To avoid mechanical head movement the read/write requests are sorted, allowing a more consistent motion of the head to retrieve or store data.

The cache can hold multiple log and data write requests at the same time. The WAL protocol and the SQL Server implementation of the WAL protocol require flushing of the log writes to stable storage before the page write can be issued. However, use of the cache might return success from a log write request without the data being written to the actual drive (that is, written to stable storage). This may lead to SQL Server issuing the data page write request.

With the write cache involvement, the data is still considered to be in volatile storage. However, from the Win32 API WriteFile call, exactly how SQL Server sees the activity, a successful return code was obtained. SQL Server or any process that uses the WriteFile API call can determine only that the data has correctly obtained stable storage.

For discussion purposes, assume that all sectors of the data page are sorted to write before the sectors of the matching log records. This immediately violates the WAL protocol. The cache is writing a data page before the log records. Unless the cache is fully battery-backed, a failure can cause catastrophic results.

When you evaluate the optimal performance factors for a database server, there are many factors to consider. The most important of these is, "Does my system allow valid `FILE_FLAG_WRITE_THROUGH` capabilities?"

> [!NOTE]
> Any cache that you're using must fully support a battery-backed solution. All other caching mechanisms are prone to data corruption and data loss. SQL Server makes every effort to ensure the WAL by enabling `FILE_FLAG_WRITE_THROUGH`.

Testing has shown that many disk drive configurations may contain write caching without the appropriate battery Backup. SCSI, IDE, and EIDE drives take full advantage of write caches. For more information about how SSDs work together with SQL Server, see the following CSS SQL Server Engineers Blog article:

[SQL Server and SSDs - RDORR's Learning Notes - Part 1](https://techcommunity.microsoft.com/t5/sql-server-support/sql-server-and-ssds-8211-rdorr-8217-s-learning-notes-part-1/ba-p/318506)

In many configurations, the only way to correctly disable the write caching of an IDE or EIDE drive is by using a specific manufacturer utility or by using jumpers located on the drive itself. To make sure that the write cache is disabled for the drive itself, contact the drive manufacturer.

SCSI drives also have write caches. However, these caches can commonly be disabled by the operating system. If there is any question, contact the drive manufacturer for appropriate utilities.

## Write Cache Stacking

Write Cache Stacking is similar to Sector Ordering. The following definition was taken directly from a leading IDE drive manufacturer's website:

Normally, this mode is active. Write cache mode accepts the host write data into the buffer until the buffer is full or the host transfer is complete.

A disk write task begins to store the host data to disk. Host write commands continue to be accepted and data transferred to the buffer until either the write command stack is full or the data buffer is full. The drive may reorder write commands to optimize drive throughput.

## Automatic Write Reallocation (AWR)

Another common technique that's used to protect data is to detect bad sectors during data manipulation. The following explanation comes from a leading IDE drive manufacturer's website:

This feature is part of the write cache and reduces the risk of data loss during deferred write operations. If a disk error occurs during the disk write process, the disk task stops and the suspect sector is reallocated to a pool of alternate sectors that are located at the end of the drive. Following the reallocation, the disk write task continues until it is complete.

This can be a powerful feature if battery Backup is provided for the cache. This provides appropriate modification upon restart. It is preferable to detect the disk errors, but the data security of the WAL protocol would again require this to be done real time and not in a deferred manner. Within the WAL parameters, the AWR technique can't account for a situation in which a log write fails because of a sector error but the drive is full. The database engine must immediately know about the failure so the transaction can be correctly aborted, the administrator can be alerted, and correct steps taken to secure the data and correct the media failure situation.

## Data safety

There are several precautions that a database administrator should take to ensure the safety of the data.

- It is always a good idea to make sure that your Backup strategy is sufficient to recover from a catastrophic failure. Offsite storage and other precautions are appropriate.
- Test the database restore operation in a secondary or test database on a frequent basis.
- Make sure that any caching devices can handle all failure situations (power outage, bad sectors, bad drives, system outage, lockups, power spike, and so on).
- Make sure that your caching device:
  - Has integrated battery Backup
  - Can reissue writes on power-up
  - Can be fully disabled if it's necessary
  - Handles bad sector remapping in real time
- Enable torn page detection. (This has little effect on performance.)
- Configure RAID drives allowing for a hot swap of a bad disk drive, if it's possible.
- Use newer caching controllers that let you add more disk space without restarting the OS. This can be an ideal solution.

## Testing drives

To fully secure your data, you should make sure that all data caching is correctly handled. In many situations, you must disable the write caching of the disk drive.

> [!NOTE]
> Make sure that an alternative caching mechanism can correctly handle multiple types of failure.

Microsoft has performed testing on several SCSI and IDE drives by using the `SQLIOSim` utility. This utility simulates heavy asynchronous read/write activity to a simulated data device and log device. Test performance statistics show the average write operations per second between 50 and 70 for a drive with disabled write caching and an RPM range between 5,200 and 7,200.

For more information about the `SQLIOSim` utility, see the following article in the Microsoft Knowledge Base:

[How to use the SQLIOSim utility to simulate SQL Server activity on a disk subsystem](https://support.microsoft.com/help/231619)

Many computer manufacturers order the drives by having the write cache disabled. However, testing shows that this may not always be the case. Therefore, always test completely.

## Data devices

In all but non-logged situations, SQL Server will require only the log records to be flushed. When doing non-logged operations, the data pages must also be flushed to stable storage; there are no individual log records to regenerate the actions in the case of a failure.

The data pages can remain in cache until the LazyWriter or CheckPoint process flushes them to stable storage. Using the WAL protocol to make sure that the log records are correctly stored makes sure that recovery can recover a data page to a known state.

This doesn't mean that it is advisable to place data files on a cached drive. When the SQL Server flushes the data pages to stable storage, the log records can be truncated from the transaction log. If the data pages are stored on volatile cache, it's possible to truncate log records that would be used to recover a page in the event of a failure. Make sure that both your data and log devices accommodate stable storage correctly.

## Increasing performance

The first question that might occur to you is: "I have an IDE drive that was caching. But when I disabled it, my performance became less than expected. Why?"

Many of the IDE drives that are tested by Microsoft run at 5,200 RPM, and the SCSI drives at 7,200 RPM. When you disable the write caching of the IDE drive, the mechanical performance can become a factor.

To address the performance difference, the method to follow is clear: "Address the transaction rate."

Many online transaction processing (OLTP) systems require a high transaction rate. For these systems, consider using a caching controller that can appropriate support a write cache and provide the desired performance boost while still ensuring data integrity.

To observe significant performance changes that occur in SQL Server on a caching drive, the transaction rate was increased by using small transactions.

Testing shows that high writes activity of buffers that's less than 512 KB or greater than 2 MB can cause slow performance.

Consider the following example:

```sql
CREATE TABLE tblTest ( iID int IDENTITY(1,1), strData char(10))
GO

SET NOCOUNT ON
GO

INSERT INTO tblTest VALUES ('Test')
WHILE @@IDENTITY < 10000
INSERT INTO tblTest VALUES ('Test')
```

The following are sample test results for SQL Server:

```console
SCSI(7200 RPM) 84 seconds
SCSI(7200 RPM) 15 seconds (Caching controller)

IDE(5200 RPM) 14 seconds (Drive cache enabled)
IDE(5200 RPM) 160 seconds
```

The process of wrapping the entire series of `INSERT` operations into a single transaction runs in approximately four seconds in all configurations. This is because of the number of log flushes that are required. If you don't create a single transaction, every `INSERT` is processed as a separate transaction. Therefore, all the log records for the transaction must be flushed. Each flush is 512 bytes in size. This requires significant mechanical drive intervention.

When a single transaction is used, the log records for the transaction can be bundled, and a single, larger write can be used to flush the gathered log records. This significantly reduces the mechanical intervention.

> [!WARNING]
> We recommend that you don't increase your transaction scope. Long-running transactions can cause excessive and unwanted blocking and increased overhead. Use the SQL Server:Databases SQL Server performance counters to view the transaction log-based counters. Specifically, Log Bytes Flushed/sec can indicate many small transactions that can cause high mechanical disk activity.

Examine the statements that are associated with the log flush to determine whether the Log Bytes Flushed/sec value can be reduced. In the previous example, a single transaction was used. However, in many scenarios, this can cause undesired locking behavior. Examine the design of the transaction. You can use code similar to the following code to run batches to reduce the frequent and small log flush activity:

```sql
BEGIN TRAN
GO

INSERT INTO tblTest VALUES ('Test')
WHILE @@IDENTITY < 50
    BEGIN
        INSERT INTO tblTest VALUES ('Test')
  
        if(0 = cast(@@IDENTITY as int) % 10)
        BEGIN
            PRINT 'Commit tran batch'
            COMMIT TRAN
            BEGIN TRAN
        END
    END
GO

COMMIT TRAN
GO
```

SQL Server requires that systems support **guaranteed delivery to stable media**, as described in the [SQL Server I/O Reliability Program Review Requirements](https://download.microsoft.com/download/f/1/e/f1ecc20c-85ee-4d73-baba-f87200e8dbc2/sql_server_io_reliability_program_review_requirements.pdf) download document. For more information about the input and output requirements for the SQL Server database engine, see
[Microsoft SQL Server Database Engine Input/Output Requirements](https://support.microsoft.com/help/967576).
