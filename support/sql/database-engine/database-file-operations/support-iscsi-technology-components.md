---
title: Support for SQL Server on iSCSI technology components
description: This article describes the support for SQL Server on iSCSI technology components.
ms.date: 09/02/2020
ms.custom: sap:Administration and Management
ms.reviewer: ramakoni, rdorr, sureshka
---
# Support for SQL Server on iSCSI technology components

This article introduces the support for SQL Server on iSCSI technology components.

_Original product version:_ &nbsp; SQL Server 2014, SQL Server 2012, SQL Server 2008, SQL Server 2005  
_Original KB number:_ &nbsp; 833770

## Summary

Microsoft supports Microsoft SQL Server when it is deployed on Internet small computer system interface (iSCSI) technology components that have received the **Designed for Windows** Logo Program qualification. SQL Server installations that use iSCSI will require these iSCSI hardware devices in addition to the network adapters that are required for typical network communications.

## More information

iSCSI is a SCSI transport protocol for mapping block-oriented storage data over TCP/IP networks. When you deploy SQL Server in an iSCSI environment, Microsoft recommends that you use appropriate caution. The involvement of a network may introduce components that are not typically viewed as high-speed I/O paths.

Microsoft operating systems present the iSCSI devices as ordinary drives. To users and applications, including SQL Server, the remote destination is encapsulated. To maximize throughput, use caution to make sure that the computer that is running SQL Server is configured to maximize caching activities, and make sure that the latency that is involved with the iSCSI traffic is minimized.

SQL Server requires systems to support 'guaranteed delivery to stable media' as outlined under the [SQL Server I/O Reliability Program Requirements](https://download.microsoft.com/download/f/1/e/f1ecc20c-85ee-4d73-baba-f87200e8dbc2/sql_server_io_reliability_program_review_requirements.pdf). For more information about the input and output requirements for the SQL Server database engine, see [Microsoft SQL Server Database Engine Input/Output requirements](https://support.microsoft.com/help/967576).
