---
title: Update is replicated as DELETE/INSERT pairs
description: This article describes that Update statements may be replicated as DELETE/INSERT pairs.
ms.date: 09/21/2020
ms.custom: sap:Replication
ms.reviewer: RAJUGIRD
ms.topic: reference-architecture
---
# UPDATE statements may be replicated as DELETE/INSERT pairs

This article describes that Update statements may be replicated as DELETE/INSERT pairs.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 238254

## Summary

If any column that is part of a unique constraint is updated, then SQL Server implements the update as a "deferred update", which means as a pair of `DELETE`/`INSERT` operations. This "deferred update" causes replication to send a pair of `DELETE`/`INSERT` statements to the subscribers. There are also other situations that might cause a deferred update. Therefore, any business logic that you implement in your `UPDATE` triggers or custom stored procedures at the Subscriber should also be included in the `DELETE`/`INSERT` triggers or custom stored procedures.

## More information

The default behavior in transactional replication is to use `INSERT`, `UPDATE` and `DELETE` custom stored procedures to apply changes at the subscribers.

`INSERT` statements made at the Publisher are applied to subscribers through an `INSERT` stored procedure call. Similarly, a `DELETE` statement is applied through a `DELETE` stored procedure call.

However, when an `UPDATE` statement is executed as a "deferred update", the logreader agent places a pair of `DELETE`/`INSERT` stored procedure calls in the distribution database to be applied to the Subscribers rather than an update stored procedure call. For example, suppose you have a publishing table, named `TABLE1`, with these three columns:

- col1 int
- col2 int
- col3 varchar(30)

The only unique constraint on `TABLE1` is defined on `col1` through a primary key constraint. Assume that you have one record (1,1,'Dallas').

When you execute this code:

```sql
UPDATE TABLE1 set col1 = 3 where col3 = 'Dallas'
```

The `UPDATE` statement is implemented by SQL Server as a pair of `DELETE`/`INSERT` statements since you are updating `col1`, which has a unique index defined. Thus, the logreader places a pair of `DELETE`/`INSERT` calls in the distribution database. This can impact any business logic that is present in the triggers or custom stored procedures at the Subscriber. You should incorporate the additional business logic in `DELETE` and `INSERT` triggers or stored procedures to handle this situation.

If you prefer to use single logic and you want all your `UPDATE` commands replicated as `DELETE`/`INSERT` pairs, you can enable a trace flag.

Additionally, if you use a horizontal filter in your publication and if the updated row does not meet a filter condition, only a `DELETE` procedure call is sent to the subscribers. If the updated row previously did not meet the filter condition but meets the condition after the update, only the `INSERT` procedure call is sent through the replication process.

In the preceding example, assume that you also have a horizontal filter defined on `TABLE1`: `where col3 = 'Dallas'`. If you execute this code:

```sql
UPDATE table1 set col3 = 'New York' where col1 = 3
```

the logreader agent only places a `DELETE` stored procedure call to be applied to the subscribers since the updated row does not meet the horizontal filter criteria.

Now, if you execute this code:

```sql
UPDATE table1 set col3 = 'Dallas' where col1 = 3
```

the logreader generates only the `INSERT` stored procedure call, since the row did not previously meet the filter condition.

Although an `UPDATE` operation was performed at the Publisher, only the appropriate commands are applied at the Subscriber.
