---
title: Support for network database files
description: This article describes support for network database files in SQL Server and how to configure SQL Server to store a database on a networked server or on an NAS storage server.
ms.date: 09/04/2023
ms.custom: sap:Administration and Management
ms.reviewer: SANJAYAN
---
# Description of support for network database files in SQL Server

This article describes support for network database files in SQL Server and how to configure SQL Server to store a database on a networked server or on an NAS storage server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 304261

## Summary

Microsoft generally recommends that you use a Storage Area Network (SAN) or locally attached disk for the storage of your Microsoft SQL Server database files because this configuration optimizes SQL Server performance and reliability. By default, the use of network database files that are stored on a networked server or a Network Attached Storage (NAS) server is not enabled for SQL Server.

However, you can configure SQL Server to store a database on a networked server or NAS server. Servers that are used for this purpose must meet SQL Server requirements for data write ordering and write-through guarantees. These are detailed in the [More Information](#more-information) section.

The following conditions describe the use of network database files that are stored on a networked server or NAS server:

- This use is enabled by default in Microsoft SQL Server 2008 R2 and later versions.

- This use requires the **-T1807** startup trace flag to work in Microsoft SQL Server 2008 and earlier versions. Starting with SQL Server 2012, the trace flag is no longer required. For more information about how to enable startup trace flags, see [Database Engine Service Startup Options](/sql/database-engine/configure-windows/database-engine-service-startup-options).

## Windows Hardware Quality Lab (WHQL)-qualified devices

Microsoft Windows servers and networked servers or NAS storage servers that are Windows Hardware Quality Lab (WHQL)-qualified automatically meet the data write ordering and write-through guarantees required to support a SQL Server storage device. Microsoft supports both application and storage-related issues in these configurations.

> [!NOTE]
> To be supported by SQL Server, the NAS storage solution should also meet all the requirements that are listed in the download document: [SQL Server IO Reliability Program Requirements](https://download.microsoft.com/download/f/1/e/f1ecc20c-85ee-4d73-baba-f87200e8dbc2/sql_server_io_reliability_program_review_requirements.pdf).

## Other devices

If you use a non-WHQL-qualified storage device with SQL Server that supports the I/O guarantees for transactional database use described in this article, Microsoft will provide full support for SQL Server and SQL Server-based applications. However, issues with, or caused by, the device or its storage subsystem will be referred to the device manufacturer. If you use a non-WHQL-qualified storage device that does not support the I/O guarantees for transactional database use described in this article, Microsoft cannot provide support for SQL Server or SQL Server-based applications. To determine whether your non-WHQL-qualified storage device supports the I/O guarantees for transactional database use that are described in this article or are designed for database use, check with your device vendor. Also, contact your device vendor to verify that you have correctly deployed and configured the device for transactional database use.

## More information

By default, in SQL Server 2008 and earlier versions, you cannot create a SQL Server database on a network file share. Any attempt to create a database file on a mapped or UNC network location generates either of the following error messages:

- Error Message 1

  > 5105 "Device Activation Error"

- Error Message 2

  > 5110 "File 'file_name' is on a network device not supported for database files."

This behavior is expected. Trace flag 1807 bypasses the check and allows you to configure SQL Server with network-based database files. SQL Server, and most other enterprise database systems, use a transaction log and associated recovery logic to maintain transactional database consistency in the event of a system failure or an unmanaged shutdown. These recovery protocols rely on the ability to write directly to the disk media so that when an operating system input/output (I/O) write request returns to the database manager, the recovery system can be sure that the write is complete or that the completion of the write can be guaranteed. Any failure by any software or hardware component to honor this protocol can cause a partial or total data loss or corruption in the event of a system failure. For more information about these aspects of logging and recovery protocols in SQL Server,see [Description of logging and data storage algorithms that extend data reliability in SQL Server](https://support.microsoft.com/help/230785).

Microsoft does not support SQL Server networked database files on NAS or networked storage servers that do not meet these write-through and write-order requirements.

Because of the risks of network errors compromising database integrity, together with possible performance implications that may result from the use of network file shares to store databases, Microsoft recommends that you store database files either on local disk subsystems or on Storage Area Networks (SANs).

A network attached storage (NAS) system is a file-based storage system that clients attach to through the network redirector by using a network protocol (such as TCP/IP). By default, if access to a disk resource requires that a share be mapped, or if the disk resource appears as a remote server through a UNC path (for example, \\Servername\Sharename) on the network, the disk storage system is not supported as a location for SQL Server databases.

## Performance issues

SQL Server, like other enterprise database systems, can place a large load on an I/O subsystem. In most large database applications, physical I/O configuration and tuning play a significant role in overall system performance. There are three major I/O performance factors to consider:

- I/O bandwidth: The aggregate bandwidth, typically measured in megabytes per second that can be sustained to a database device.
- I/O latency: The latency, typically measured in milliseconds, between a request for I/O by the database system and the point where the I/O request is completed.
- CPU cost: The host CPU cost, typically measured in CPU microseconds, for the database system to complete a single I/O.

Any of these I/O factors can become a bottleneck and you must consider all these factors when you design an I/O system for a database application.

In its simplest form, an NAS solution uses a standard network redirector software stack, standard network interface card (NIC), and standard Ethernet components. The drawback of this configuration is that all file I/O is processed through the network stack and is subject to the bandwidth limitations of the network itself. This can create performance and data reliability problems, especially in programs that require high levels of file I/O, such as SQL Server. In some NAS configurations tested by Microsoft, the I/O throughput was one-third (1/3) that of a direct attached storage solution on the same server. In this same configuration, the CPU cost to complete an I/O through the NAS device was twice that of a local I/O. As NAS devices and network infrastructure evolve, these ratios may also improve relative to direct attached storage or SANs. Furthermore, if your application data is mostly cached in the database buffer pool, and you do not encounter any of the I/O bottlenecks outlined, performance on an NAS-based system is probably adequate for your application.

## Backup and restore considerations

SQL Server provides the Virtual Device Interface (VDI) for backup. The VDI provides backup software vendors with a high-performance, scalable, and reliable means for performing hot backups and for restoring SQL Server databases.

Backup software operates on database files stored on NAS devices through VDI with no special support specific to the NAS. However, this results in lots of additional network traffic during backup and restore. During backup through VDI, SQL Server reads the files remotely and passes the data to the third-party backup software that is running on the SQL Server computer. The restore operation is analogous.

To avoid the extra network overhead, the backup vendor must provide NAS-specific support by the backup vendor and the NAS vendor. SQL Server VDI allows the backup software to take advantage of hardware (split-mirror) or software (copy-on-write) technologies supported by the NAS devices to make fast copies of the database files local to the NAS. These technologies not only avoid the overhead of copying the files over the network for backup, they may also reduce restore times by orders of magnitude.

Backups that are stored on NAS are vulnerable to the same failures that affect database files that are stored on the NAS. You should consider protecting these backups by copying them to alternative media.

> [!CAUTION]
> You may experience database corruption in the backup if you use NAS backup technologies without SQL Server VDI support. Such corruption includes torn pages or inconsistencies between the log and data files if they are stored on separate devices. SQL Server may not detect the torn pages or inconsistencies until you restore the database and access the corrupted data. Microsoft does not support the use of NAS backup technologies that are not coordinated with SQL Server.

Backup support and NAS vendor support for SQL Server VDI varies. Check with your NAS and backup software suppliers for details regarding VDI support.

Microsoft urges customers who are considering a deployment of an NAS solution for SQL Server databases to consult their NAS vendor to make sure that the end-to-end solution design is for database use. Many NAS vendors have best practice guides and certified configurations for this use. Microsoft also recommends that customers benchmark their I/O performance to ensure that none of the I/O factors mentioned previously causes a bottleneck in their application.

The following list describes support for network-based files on SQL Failover clusters:

- SQL Server 2008 R2 and earlier versions: Not supported

- SQL Server 2012 and later versions: Supported

  For more information, see the following SQL Server Books Online topic:

  [Install SQL Server with SMB fileshare storage](/sql/database-engine/install-windows/install-sql-server-with-smb-fileshare-as-a-storage-option)

## Additional notes

Incorrect use of database software with a NAS product, or database use with an improperly configured NAS product, may result in data loss including total database loss. If the NAS device or network software does not completely honor data guarantees, such as write ordering or write-through, then hardware, software, or even power failures could seriously compromise data integrity.

## References

- [Information about using disk drive caches with SQL Server that every database administrator should know](https://support.microsoft.com/help/234656)

- [DBCC TRACEON - Trace Flags (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql)

- [SQL Server I/O Reliability Program Requirements.](https://download.microsoft.com/download/f/1/e/f1ecc20c-85ee-4d73-baba-f87200e8dbc2/sql_server_io_reliability_program_review_requirements.pdf)

- [SQL Server Database Engine Input/Output requirements](/troubleshoot/sql/admin/database-engine-input-output-requirements)


