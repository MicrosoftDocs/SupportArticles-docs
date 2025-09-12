---
title: Update Is Replicated as DELETE or INSERT Pairs
description: This article describes that Update statements may be replicated as DELETE/INSERT pairs.
ms.date: 03/20/2025
ms.custom: sap:Replication, Change Tracking, Change Data Capture, Synapse Link
ms.reviewer: RAJUGIRD, ansavio
ms.topic: reference-architecture
---
# UPDATE statements may be replicated as DELETE/INSERT pairs

This article describes that Update statements may be replicated as DELETE/INSERT pairs.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 238254

## Summary

If any column that is part of a unique constraint is updated, SQL Server implements the update as a "deferred update", which means as a pair of `DELETE`/`INSERT` operations. This "deferred update" causes replication to send a pair of `DELETE`/`INSERT` statements to the subscribers. There are also other situations that might cause a deferred update. Therefore, any business logic that you implement in your `UPDATE` triggers or custom stored procedures at the Subscriber should also be included in the `DELETE`/`INSERT` triggers or custom stored procedures.

## More information

The default behavior in transactional replication is to use the `INSERT`, `UPDATE`, and `DELETE` custom stored procedures to apply changes at the subscribers.

`INSERT` statements made at the Publisher are applied to subscribers through an `INSERT` stored procedure call. Similarly, a `DELETE` statement is applied through a `DELETE` stored procedure call.

However, when an `UPDATE` statement is executed as a "deferred update", the log reader agent places a pair of `DELETE`/`INSERT` stored procedure calls in the distribution database to be applied to the Subscribers rather than an update stored procedure call. For example, suppose you have a publishing table, named `TABLE1`, with these three columns:

- col1 int
- col2 int
- col3 varchar(30)

The only unique constraint on `TABLE1` is defined on `col1` through a primary key constraint. Assume that you have one record (1,1,'Dallas').

When you execute this code:

```sql
UPDATE TABLE1 set col1 = 3 where col3 = 'Dallas'
```

The `UPDATE` statement is implemented by SQL Server as a pair of `DELETE`/`INSERT` statements since you're updating `col1`, which has a unique index defined. Thus, the log reader places a pair of `DELETE`/`INSERT` calls in the distribution database. This can impact any business logic that is present in the triggers or custom stored procedures at the Subscriber. You should incorporate the additional business logic in `DELETE` and `INSERT` triggers or stored procedures to handle this situation.

If you prefer to replicate single-row updates as `UPDATE` statements instead of `DELETE` or `INSERT` pairs, you can enable [Trace Flag 8207](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf8207).

Additionally, if you use a horizontal filter in your publication and if the updated row doesn't meet a filter condition, only a `DELETE` procedure call is sent to the subscribers. If the updated row previously didn't meet the filter condition but meets the condition after the update, only the `INSERT` procedure call is sent through the replication process.

In the preceding example, assume that you also have a horizontal filter defined on `TABLE1`: `where col3 = 'Dallas'`. If you execute this code:

```sql
UPDATE table1 set col3 = 'New York' where col1 = 3
```

The log reader agent only places a `DELETE` stored procedure call to be applied to the subscribers since the updated row doesn't meet the horizontal filter criteria.

Now, if you execute this code:

```sql
UPDATE table1 set col3 = 'Dallas' where col1 = 3
```

The log reader generates only the `INSERT` stored procedure call, since the row didn't previously meet the filter condition.

Although an `UPDATE` operation was performed at the Publisher, only the appropriate commands are applied at the Subscriber.
