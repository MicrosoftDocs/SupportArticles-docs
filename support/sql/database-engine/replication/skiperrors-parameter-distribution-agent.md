---
title: SkipErrors parameter in Distribution Agent
description: This article describes the usage of -SkipErrors parameter in Distribution Agent.
ms.date: 09/22/2020
ms.custom: sap:Replication
ms.topic: article
---
# Use the -SkipErrors parameter in Distribution Agent

This article introduces the usage of `-SkipErrors` parameter in Distribution Agent.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 327817

## Summary

Microsoft SQL Server includes the new parameter `-SkipErrors` in the Distribution Agent that permits the Distribution Agent to skip the indicated error in transactional replication and to continue the distribution process.

The following excerpt is from the **Handling Agent Errors** topic in SQL Server Books Online:

Under typical replication processing, you should not experience any errors that need to be skipped. The ability to skip errors during transactional replication is available for the unique circumstances where you expect errors and do not want them to affect replication (for example, when failing over to a secondary Publisher during log shipping).

Microsoft recommends that you use this parameter cautiously and only when you have a good understanding of the following:

- What the error indicates.
- Why the error occurs.
- Why it is better to skip the error instead of solving it.

If you do not know the answers to these items, inappropriate use of the `-SkipErrors` parameter may cause data inconsistency between the Publisher and Subscriber. This article describes some problems that can occur when you incorrectly use the `-SkipErrors` parameter.

## More information

In transactional replication, data changes at the Publisher are propagated to the Subscriber in the unit of transaction.

In one transaction, there may be multiple commands. By default, if one command fails, the whole replication transaction rolls back at the Subscriber. If you add the `-SkipErrors` parameter to permit the Distribution Agent to skip certain errors, the individual command that causes this error is not applied to the Subscriber, but all other commands in the same transactions are applied. In this situation, the replication transaction is only partially applied to the Subscriber, which can therefore cause the data inconsistency between the Publisher and the Subscriber.

For example:

You have a transaction waiting to be replicated to the Subscriber table named T1. This transaction includes 100 insert statements. When it applies to the Subscriber, the first 90 inserts process correctly; however, the ninety-first insert statement fails and the primary key violation error 2627 occurs.

When you do not use the `-SkipErrors` parameter (default behavior):

By default, the whole transaction rolls back, and none of the 100 new records are inserted into the subscribing table. In this situation, you must fix the replication error so that the transaction can be reapplied to the Subscriber.

When you use the `-SkipErrors` parameter:

The Distribution Agent logs the error in the Distribution Agent history, it skips this error, and then it continues the distribution process. Therefore, except for the ninety-first new record that caused the error, the other 99 new records are inserted into the subscribing table. This transaction is not reapplied by the Distribution Agent, even after you manually fix the error at the Subscriber. Therefore, in this situation, the Subscriber is missing the ninety-first new record and a data inconsistency problem occurs.

You also must be aware that, in SQL Server 2000 typically the Distribution Agent is shared by multiple publications (by default, there is one Distribution Agent per publication database and subscription database pair), so if you add the `-SkipErrors` parameter to the Distribution Agent job, it affects all the publications that this agent is servicing. In SQL 2005 and SQL 2008 versions, transactional replication uses independent agents by default for publications created in the New Publication Wizard. For publications created using `sp_addpublication` stored procedure, the default behavior is to use a shared agent.

To use the `-SkipErrors` parameter for a specific publication, use an independent agent, which just services one subscription. To use an independent agent, follow the steps for your version:

## SQL Server 2000

1. In SQL Server Enterprise Manager, right-click the publication, click `Properties`, and then on the **Subscription Options** tab, click the **use a Distribution Agent that is independent of other publication from this database** option.

    > [!NOTE]
    > You cannot turn this option on after you add any subscriptions to this publication.

2. Add the `-SkipErrors` parameter to the Distribution Agent of a specific subscription.

## SQL Server 2005 and SQL Server 2008

1. In SQL Server management studio, navigate to **Replication** and then in the **Local Publications** section right-click the publication, click **Properties**, and then on the **Subscription Options** page, change the value of **Independent Distribution Agent** from **False** to **True**.

    > [!NOTE]
    > You cannot turn this option on after you add any subscriptions to this publication.

2. Add the `-SkipErrors` parameter to the **Distribution Agent** of a specific subscription.

For more information, see the following:

- [Replication Agent Administration](/sql/relational-databases/replication/agents/replication-agent-administration)

- [Skipping Errors in Transactional Replication](/previous-versions/sql/sql-server-2008-r2/ms151331(v=sql.105))

- [sp_addpublication (Transact-SQL)](/sql/relational-databases/system-stored-procedures/sp-addpublication-transact-sql)
