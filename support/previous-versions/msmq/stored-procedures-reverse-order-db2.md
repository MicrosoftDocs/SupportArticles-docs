---
title: Stored Procedures are executed in reverse order
description: This article discusses a by-design behavior where multiple Inserts or Stored Procedures in a single transaction are returned in reverse order in OLE DB Provider for DB2.
ms.date: 07/23/2020
ms.prod-support-area-path:
ms.reviewer: jeremyr, valerieg
---
# Multiple Inserts or Stored Procedures in single transaction returned reverse order in OLE DB Provider for DB2

This article discusses a by-design behavior where multiple Inserts or Stored Procedures in a single transaction are returned in reverse order in OLE DB Provider for DB2.

_Original product version:_ &nbsp; Host Integration Server 2009, OLE DB Provider for DB2, BizTalk Adapters for Host Systems 2.0  
_Original KB number:_ &nbsp; 2982778

## Summary

The default behavior of the Microsoft OLE DB Provider for DB2 is that, when you issue a transaction that contains multiple Inserts or Stored Procedure calls, the Stored Procedures are executed in reverse order.

## More information

This behavior is because of the design of the OLE DB Provider for DB2, and it has functioned in this manner since the initial release of the software. Changes to the default behavior to allow for multiple Inserts or Stored Procedures to execute in the order in which they are called in the transaction are being considered for future releases of the OLE DB Provider for DB2.

## Applies to

- Host Integration Server 2009
- Host Integration Server 2010
- Host Integration Server 2013
- OLE DB Provider for DB2 1.0
- OLE DB Provider for DB2 4.0
- BizTalk Adapters for Host Systems 2.0
- BizTalk Adapters for Host Systems 2.0 Developer Edition
