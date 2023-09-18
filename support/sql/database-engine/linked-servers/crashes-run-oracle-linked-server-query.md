---
title: SQL Server service crashes when you run an Oracle linked server query
description: This article provides workarounds to the problem that occurs when you run an Oracle linked server query.
ms.date: 01/07/2022
ms.custom: sap:Administration and Management
ms.reviewer: ramakoni
---
# SQL Server service crashes when you run an Oracle linked server query

This article helps you resolve a problem that can occur when you run an Oracle linked server query.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2295405

## Symptoms

Consider the following scenario:

- You install SQL Server on a computer that is running the Windows Server.
- You create a linked server for an Oracle database.
- You run a linked server query using the OraOLEDB provider (OLEDB Provider for Oracle).

In this scenario, the SQL Server service crashes, and no results are returned for the query. Additionally, you may notice the following issues:

- You receive the following error message in the Windows system event log:

  > The SQL Server (MSSQLSERVER) service terminated unexpectedly. It has done this 1 time(s).

- A minidump file of the SQL Server process is generated with heap corruption and you receive an exception message that resembles the following:

  > In minidump.mdmp the assembly instruction at ntdll!RtlReportCriticalFailure+62 in C:\Windows\System32\ntdll.dll from Microsoft Corporation has caused an unknown exception (0xc0000374) on thread 235  
  OR sometimes alternatively in errorlog can be seen another exception:  
  SqlDumpExceptionHandler: Process 74 generated fatal exception c0000005 EXCEPTION_ACCESS_VIOLATION. SQL Server is terminating this process.

- The stack of the minidump file contains third-party modules inside the *Sqlserver.exe* process. For example, the minidump file contains the following information in the Oracle modules:

    ```console
    OraOLEDButl11
    OraOLEDBrst11
    OraOLEDBrst10

    Full Call Stack:

    ntdll!RtlReportCriticalFailure+62 
    ntdll!RtlpReportHeapFailure+26 
    ntdll!RtlpHeapHandleError+12 
    ntdll!RtlpLogHeapFailure+a4 
    ntdll!RtlFreeHeap+1aa8f 
    ole32!CoTaskMemFree+36 
    OraOLEDButl11+1a5f 
    0x403d6b00 
    0x00000001 
    0x4d200e30 
    0x00000024 
    0x403d7ab8 
    OraOLEDBrst11+12843 
    0x403b8c00 
    0x403c95f0 
    0x403ca610 
    0x403ca610 
    0x403c95f0 
    OraOLEDBrst11+128b1 
    0x403d7ab8 
    0x403c95f0 
    0x4966a260 
    0x05cd21e0 
    ```

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

## Cause

This issue occurs because the special characters `--` exist in the query to the Oracle linked server. These characters are used to denote a comment symbol.

The SQL Server process crashes because the third-party linked server provider is loaded inside SQL Server process and it incorrectly modifies heap memory that does not belong to it. If the [Heap Functions](/windows/win32/memory/heap-functions) inside a process is unstable, for protection from data corruption, the process is automatically shut down by the OS. If the third-party linked server provider is enabled together with the **Allow inprocess** option, the SQL Server process crashes when the third-party linked server experiences the described issue.

## Workaround

In some cases, one of the following methods solves the problem:

- Remove the comments symbol.
- Replace the comments symbol with `/* */`.

## Resolution

Contact the third-party provider for information and latest fixes. For latest OLEDB provider version, see [64-bit Oracle Data Access Components (ODAC) Downloads](https://www.oracle.com/database/technologies/odac-downloads.html).
