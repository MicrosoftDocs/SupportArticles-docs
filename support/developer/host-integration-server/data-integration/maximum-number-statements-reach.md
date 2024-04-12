---
title: Maximum number of statements has reached
description: This article provides resolutions for the problem where the maximum number of statements has been reached for the current connection.
ms.date: 03/18/2020
ms.custom: sap:Data Integration (DB2, Host Files)
---
# The maximum number of statements has been reached for the current connection

This article helps you resolve the problem where insert operation fails when BizTalk Server 2010 writes e-commerce order information to DB2/AS400 and the BizTalk orchestration uses the DB2 adapter to write the information to the DB2 tables.

_Original product version:_ &nbsp; Host Integration Server 2010, 2009  
_Original KB number:_ &nbsp; 2679772

## Symptoms

Consider the following scenario:

- BizTalk Server 2010 writes e-commerce order information to DB2/AS400.
- The BizTalk orchestration uses the DB2 adapter to write the information to the DB2 tables.

When an order has more than 128 line items, insert operation fails with the following error:

> The maximum number of statements has been reached for the current connection. SQLSTATE: HY000, SQLCODE:-1500

## Cause

The client relies on pre-defined SQL statements in sections within DB2 static SQL packages to support execution of concurrent SQL `SELECT` statements. By default, the client defines 128 package sections, allowing the client to execute 128 concurrent SQL `SELECT` statements per client connection. When the maximum number of outstanding concurrent SQL `SELECT` statements exceeds the number of pre-defined sections, then the client cannot execute a new SQL `SELECT` statement.

## Resolution

- Add the following registry key:  
  - Key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Host Integration Server\Data Integration`
  - Value: **NumberOfPackages**
  - Type: REG_DWORD
  - Value data: **512**
- Recreate packages.
- Stop/restart BizTalk.
