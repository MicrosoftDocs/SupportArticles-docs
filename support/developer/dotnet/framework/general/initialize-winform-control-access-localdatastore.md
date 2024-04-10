---
title: Initialize WinForm controls before accessing LocalDataStore
description: Windows Forms controls must be initialized before attempting to access Thread LocalDataStore.
ms.date: 05/09/2020
ms.reviewer: bpipal
---
# Windows Forms controls must be initialized before attempting to access Thread LocalDataStore

Microsoft .NET Compact Framework Windows Forms controls must be initialized before attempting to access `Thread` `LocalDataStoreSlot` to prevent potential deadlocks.

_Original product version:_ &nbsp; Microsoft .NET Compact Framework  
_Original KB number:_ &nbsp; 2552355

## Cause

Windows Forms controls use the `ApplicationThreadContext` class that manages thread local storage (TLS) in a Compact Framework application. `ApplicationThreadContext` isn't a static class, although it has some static fields, and a static constructor to initialize them.

`ApplicationThreadContext` explicitly acquires a lock in the static constructor as proper initialization of the static fields is critical to the operation of the system. This is in-line with the ECMA specification (4th Edition, June 2006, Partition II, section 10.5.3.3), which discourages acquiring locks inside static constructors, however, doesn't prohibit them when explicitly invoked.

An attempt by an application to access TLS through the `ApplicationThreadContext` class before the first UI control has been initialized may result in a deadlock. This means that the application must wait until after the first UI control has been initialized before attempting to access TLS via the `ApplicationThreadContext` class. This doesn't mean that the UI control has to be visible; it only means that it must have been initialized.
