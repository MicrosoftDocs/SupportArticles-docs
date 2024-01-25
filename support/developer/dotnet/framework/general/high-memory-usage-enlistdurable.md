---
title: High memory when you use EnlistDurable
description: Describes high memory usage when using EnlistDurable.
ms.date: 05/11/2020
ms.reviewer: jcarley
---
# You experience high memory usage when using EnlistDurable

This article helps you resolve the problem where the managed heap in your .NET application experiences high memory consumption when you use `System.Transactions.Transaction.EnlistDurable`.

_Original product version:_ &nbsp; Microsoft .NET Framework 4.5  
_Original KB number:_ &nbsp; 2859968

## Symptoms

The managed heap in your .NET application is experiencing high memory consumption and you're using `System.Transactions.Transaction.EnlistDurable`. You'll also see a large number of instances of the `OletxResourceManager` class on the managed heap.

## Cause

You're using a different Guid for the Resource Manager identifier parameter for each call to `System.Transactions.Transaction.EnlistDurable`.

## Resolution

Use the same Guid for all calls to `EnlistDurable`.

## More information

Typically this Resource Manager identifier Guid is associated with the durable storage (the log) maintained by the Resource Manager and only a single Guid is used for all calls to `EnlistDurable` within an AppDomain. In other words, all `EnlistDurable` calls within an `AppDomain` are for the same Resource Manager. If a Resource Manager uses more than one Guid per `AppDomain`, the Resource Manager is required to drive recovery of transactions for all those different Resource Manager identifiers. There's also a performance cost if the transaction gets promoted to become a Microsoft Distributed Transaction Coordinator (MSDTC) transaction because each unique Resource Manager identifier that has enlisted in the transaction must have an associated Resource Manager object registered with MSDTC and that object is kept in anticipation of future `EnlistDurable` calls using the same identifier.
