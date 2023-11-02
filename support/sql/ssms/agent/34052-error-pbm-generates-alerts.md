---
title: Policy-Based Management generates alerts
description: This article helps you resolve the problem where a SQL Agent job generates false alerts when using Policy-Based Management (PBM).
ms.date: 09/14/2020
ms.custom: sap:Administration and Management
ms.reviewer: ramakoni
---
# 34052 error message and PBM generates alerts on policies that have an evaluation mode in SQL Server

This article helps you resolve the problem where a SQL Agent job generates false alerts when using Policy-Based Management (PBM).

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2923956

## Symptoms

Consider the following scenario:

- You create a policy by using PBM in SQL Server.
- The evaluation mode for the policy is On Schedule.
- One of the Conditions for the policy contains the `ExecuteSql()` function.

In this scenario, when the SQL Server Agent job is executed, the agent generates false alerts, and the following error message is logged in the SQL Server error log file:

> Error: 34052, Severity: 16, State: 1.  
Policy '\<Policy name>' has been violated.

> [!NOTE]
> This issue does not occur when you run this job manually.

## Cause

This issue occurs because a created PBM policy is being violated. PBM puts policy violation messages into the error log as one mechanism for tracking. This indicates that you should examine the server configuration to determine why the policy is being violated.

The issue is caused by the usage of the `ExecuteSql()` function within the policy. This function allows the policy author to create a condition expressed in Transact-SQL and can also execute any Transact-SQL code within PBM. Therefore, by default, the security context that the code runs under is a low-privileged account *MS_PolicyTsqlExecutionLogin*. The account *MS_PolicyTsqlExecutionLogin* is not given any permissions for any database in addition to the `msdb` database. However, when a scheduled job runs, one of the first statements that is automatically added is the use [\<DBName>] statement. This statement causes the policy check to fail.

When you run this job manually, SQL Server uses your current security context. As long as you have permission to run the queries in the policy, this job will evaluate correctly.

## Workaround

To resolve this issue, grant the *MS_PolicyTsqlExecutionLogin* account the correct rights in order to execute the necessary statements.

For example, the public role is good enough for certain queries to execute. This role can be changed as necessary based on business needs and company policies. However, it is unlikely to change, as this behavior is intended for security reasons.
