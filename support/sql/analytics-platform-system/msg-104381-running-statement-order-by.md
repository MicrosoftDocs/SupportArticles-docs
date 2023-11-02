---
title: Msg 104381 when you run a statement with ORDER BY clause
description: This article provides a resolution for the problem that occurs when you run an INSERT ... SELECT statement in Microsoft Analytics Platform System 2016 or a later version of APS and that statement includes an ORDER BY clause.
ms.date: 01/14/2021
ms.custom: sap:Parallel Data Warehouse (APS)
ms.topic: troubleshooting 
---
# Msg 104381 when running INSERT...SELECT statement in Analytics Platform System 2016 or later versions

This article helps you resolve the problem that occurs when you run an `INSERT ... SELECT` statement in Microsoft Analytics Platform System (APS) 2016 or a later version of APS and that statement includes an `ORDER BY` clause.

_Applies to:_ &nbsp; Microsoft Analytics Platform System  
_Original KB number:_ &nbsp; 4038456

## Symptoms

When you run an `INSERT ... SELECT` statement in APS 2016 or a later version of APS and that statement includes an `ORDER BY` clause, you receive an error message that resembles the following:

> Msg 104381, Level 16, State 1, Line 26  
The ORDER BY clause is invalid in views, CREATE TABLE AS SELECT, INSERT SELECT,  
inline functions, derived tables, subqueries, and common table expressions,  
unless TOP or FOR XML is also specified.

## Cause

This issue occurs because sort operations aren't valid with the `INSERT ... SELECT` statement. This is by design.

## Resolution

To fix this problem, remove the `ORDER BY` clause from the statement.

## More information

In earlier versions of APS, no error may have been returned. However, the `ORDER BY` clause was not honored.
