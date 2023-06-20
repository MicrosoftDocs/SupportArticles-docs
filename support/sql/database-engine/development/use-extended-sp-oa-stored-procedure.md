---
title: Use extended or SP_OA stored procedure to load CLR
description: Loading CLR by using extended stored procedures or `sp_OA` stored procedures is not supported.
ms.date: 09/25/2020
ms.custom: sap:Database Design and Development
---

# Using extended stored procedures or SP_OA stored procedures to load CLR in SQL Server is not supported

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 322884

## Summary

SQL Server 2005 and later versions host Common Language Runtime (CLR) and support procedures, functions, triggers, types, and aggregates that are written in CLR languages. In these versions, you can't load CLR by using extended stored procedures or `sp_OA` stored procedures.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 322884

## More information

The .NET Framework assembly `System.Runtime.InteropServices` provides a robust environment for invoking assemblies from unmanaged code. However, there are several technical discordances between the internal implementations of CLR and SQL Server.

## Threading

To increase performance, the CLR implements Thread Local Storage.

Additionally, CLR uses only thread-based scheduling and doesn't support Fiber-mode scheduling. However, SQL Server can use Fiber-mode scheduling. To configure this property, run the `sp_configure` stored procedure by using the lightweight pooling option. For more information about this topic, see [lightweight pooling Server Configuration Option](/sql/database-engine/configure-windows/lightweight-pooling-server-configuration-option).

## Memory

The use of extended stored procedures and OLE Automation both run in the virtual memory address space of the memory of SQL Server. The default SQL Server memory is only a fraction of the memory that SQL Server can potentially use and CLR competes with any existing implementations for these memory resources.

## COM interoperability

This section specifically addresses the use of OLE Automation in SQL Server and it applies to both in-process and out-of-process COM objects. Assembly metadata for function interfaces implements a typed mechanism for any invocations.

As part of this design, the COM Callable wrapper for an assembly must use an external mechanism of mapping a ClassID to a member of a managed class. Because of this explicit mapping, there is no ability from an unmanaged perspective to establish a root list of available interfaces.

The extended stored procedure `sp_oaCreate` uses the `IUnknown::QueryInterface` interface to determine the object's support for a particular interface. The interoperability between CLR and unmanaged code relies on the IDispatch interface for implementing interfaces. Because there is no equivalent to a `QueryInterface` method in a CLR-based assembly, you can't create an instance of the object.
