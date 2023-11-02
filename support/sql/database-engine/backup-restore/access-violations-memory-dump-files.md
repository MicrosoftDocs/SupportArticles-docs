---
title: Access violations and memory dump files
description: This article provides a workaround for the problem that occurs when you use an XEvent session that has a sqlos.wait_info event in SQL Server.
ms.date: 09/25/2020
ms.custom: sap:Administration and Management
---
# Access violations and memory dump files when you use XEvent session with sqlos.wait_info event in SQL Server

This article helps you resolve the problem that occurs when you use an XEvent session that has a `sqlos.wait_info` event in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4033835

## Symptoms

Consider the following scenario:

- You create an **XEvent** session that has a `sqlos.wait_info` event in Microsoft SQL Server.
- In this session, you define a filter (predicate) in the following pattern:

    ```sql
    [sqlserver].[like_i_sql_unicode_string]([sqlserver].[sql_text],N'%< **Query Text** >')
    ```

In this scenario, you may experience any of the following problems:

- SQL Server generates access violations or a stack overflow memory dump file.
- SQL Server generates a non-yielding scheduler memory dump file.
- Queries don't return results, or you can't cancel or kill a query.
- When SQL Server produces an `EXCEPTION_ACCESS_VIOLATION` exception and stack overflow memory dump file in the [SQL Server Error Log](/sql/tools/configuration-manager/viewing-the-sql-server-error-log), error messages that resemble either of the following messages are generated:

    > \<Time Stamp> spid52      *  
    \<Time Stamp> spid52      \* BEGIN STACK DUMP:  
    \<Time Stamp> spid52      \*\<Time Stamp> spid 52  
    \<Time Stamp> spid52      \*  
    \<Time Stamp> spid52      \*  
    \<Time Stamp> spid52      \*   Exception Address = 00007FFA414ED763 Module(sqlmin+000000000000D763)  
    \<Time Stamp> spid52      \*   Exception Code    = c0000005 EXCEPTION_ACCESS_VIOLATION  
    \<Time Stamp> spid52      \*   Access Violation occurred writing address 0000000000000008  
    \<Time Stamp> spid55      Unable to create stack dump file due to stack shortage (Location:     scheduler.cpp:2090  
    Expression: !pWorker->WorkerQueueElem::IsInList ()  
    SPID:       55  
    Process ID: 8548)  
    \<Time Stamp> spid55      Stack Signature for the dump is 0x0000000000000000  
    \<Time Stamp> spid55      \<Time Stamp> Stack Overflow Dump not possible - Exception c00000fd  EXCEPTION_STACK_OVERFLOW at 0x00007FFA4EF85F35  
    \<Time Stamp> spid55      SqlDumpExceptionHandler: Address=0x00007FFA4EF85F35 Exception Code = c00000fd    
    \<Time Stamp> spid55      Rax=000000000000044c Rbx=0000000002612320 Rcx=0000000002612050 Rdx=00000000662baf59  
    \<Time Stamp> spid55      Rsi=000000004b04f848 Rdi=000000004b000270 Rip=000000004ef85f35 Rsp=0000000002611fd0  
    \<Time Stamp> spid55      Rbp=0000000000000000 EFlags=0000000000010202  
    \<Time Stamp> spid55      cs=0000000000000033 ss=000000000000002b ds=000000000000002b  
    es=000000000000002b fs=0000000000000053 gs=000000000000002b  
    \<Time Stamp> spid55      1: Frame 0000000000000000 Return Address 00007FFA4EF85F35

## Workaround

To work around this problem, avoid using complex filter conditions together with the `wait_info` event. This is because the `wait_info` event is resource-intensive and can slow down a query significantly.

If you want to track `<Query Text>` in this situation, change the Filter Predicate pattern to the following:

```sql
([sqlserver].[equal_i_sql_unicode_string]([sqlserver].[sql_text],N'<Query Text>')
```
