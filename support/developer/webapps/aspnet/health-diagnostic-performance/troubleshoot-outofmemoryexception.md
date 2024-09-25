---
title: Troubleshoot Out of Memory issues
description: This article describes the Out of Memory issues that occur in ASP.NET.
ms.date: 03/26/2020
ms.reviewer: bretb, kaorif
ms.custom: sap:Performance
---
# Troubleshoot Out of Memory issues (System.OutOfMemoryException) in ASP.NET

This article helps you troubleshoot **Out of Memory** errors in ASP.NET.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 2020006

## Symptoms

One of the most common issues that we see in Microsoft Customer Support Services is `OutOfMemoryException` scenarios. So we've put together a collection of resources to help troubleshooting and identifying the cause of memory issues.

Before we cover the details of troubleshooting an `OutOfMemoryException`, it's important to understand what causes this problem. Contrary to what many developers believe, the amount of RAM that's installed doesn't impact the possibility of an `OutOfMemoryException`. A 32-bit operating system can address 4 GB of virtual address space, whatever the amount of physical memory that is installed in the box. Out of that, 2 GB is reserved for the operating system (Kernel-mode memory) and 2 GB is allocated to user-mode processes. The 2 GB allocated for Kernel-mode memory is shared among all processes, but each process gets its own 2 GB of user-mode address space. It all assumes that you aren't running with the `/3gb` switch enabled.

When an application needs to use memory, it reserves a chunk of the virtual address space and then commits memory from that chunk. It is exactly what the .NET Framework's garbage collector (GC) does when it needs memory to grow the managed heaps. When the GC needs a new segment for the small object heap (where objects smaller than 85 KB reside), it makes an allocation of 64 MB. When it needs a new segment for the large object heap, it makes an allocation of 16 MB. These large allocations must be satisfied from contiguous blocks of the 2 GB of address space that the process has to work with. If the operating system is unable to satisfy the GC's request for a contiguous block of memory, a `System.OutOfMemoryException` (OOM) occurs.

> [!NOTE]
> A 32-bit process running on a 64-bit operation system can address 4GB of user-mode memory, and a 64-bit process running on a 64-bit operation system can address 8TB of user-mode memory, so an OOM on a 64-bit operation system isn't likely. It is possible to experience an OOM in a 32-bit process running on a 64-bit operation system, but it usually doesn't occur until the process is using close to 3 GB of private bytes.

There are two reasons why you might see an OOM condition.

1. Your process is using much memory (typically over 800 MB in a 32-bit environment.)
2. The virtual address space is fragmented, reducing the likelihood that a large, contiguous allocation will succeed.

It's also possible to see an OOM condition because of a combination of 1 and 2. For more information, see [Troubleshooting System.OutOfMemoryExceptions in ASP.NET](/archive/blogs/webtopics/troubleshooting-system-outofmemoryexceptions-in-asp-net).

When an OOM occurs, you may notice one or more of the following symptoms:

- Your application crashes. For more information, see [Who is this OutOfMemory guy and why does he make my process crash when I have plenty of memory left?](/archive/blogs/tess/who-is-this-outofmemory-guy-and-why-does-he-make-my-process-crash-when-i-have-plenty-of-memory-left).
- Your application may experience high memory as indicated by Task Manager or Performance Monitor.
- Requests may take a long time to process.
  
  On Internet Information Services (IIS) 7, you can use [Troubleshooting Failed Requests Using Tracing in IIS 7](/iis/troubleshoot/using-failed-request-tracing/troubleshooting-failed-requests-using-tracing-in-iis) to troubleshoot long-running requests.
- Users may report an error message in the application because of the OOM.

When it comes to determining the cause for an OOM condition, you're actually working to determine the cause for either a high memory situation or a fragmented address space. While we can't document all of the possible causes of these situations, there are some common causes that we see regularly.

The following information outlines common causes of OOM conditions and the resolutions on resolving each of these causes.

## String concatenation

Strings in a managed application (an application written by using the .NET Framework) are immutable. When a new value is assigned to a string, a copy is made of the existing string. And the new value is assigned to the new string. It doesn't typically cause any problems. But when a large number of strings are concatenated, it ends up causing many more string allocations than a developer might realize. And it can lead to memory growth and OOM conditions.

To avoid OOM because of string concatenation, make sure that you're using the `StringBuilder` class. For more information, see [How to improve string concatenation performance in Visual C#](https://support.microsoft.com/help/306822).

## Fragmentation in the managed heap

The garbage collector (GC) in a managed application compacts the heaps to reduce the amount of fragmentation. However, it's possible to pin objects in a managed application. Pinned objects can't be moved during heap compaction. Doing so would change the address at which the object is located. If an application pins a large number of objects, and/or it pins objects for a long time, it can cause fragmentation in the managed heap. It can lead to the GC growing the managed heap more often and causing an OOM condition.

We've worked on minimizing OOM conditions because of pinning since the .NET Framework 1.0. Incremental improvements have been made in each version. However, there are still design patterns you can implement that will be beneficial if you have a need to pin objects.

## Fragmentation in the Virtual Address (VA) space

Each process has a certain amount of memory allocated to it, and that memory represents the VA space for the process. If the VA space becomes fragmented, it increases the likelihood that the GC can't obtain a large block of contiguous memory to grow the managed heaps. And it can lead to an OOM condition.

Fragmentation in the VA space is often caused by one or more of the following scenarios:

- Loading the same assemblies into multiple application domains.

    If you need to use an assembly in more than one application running in the same application pool, strong-name the assembly and install it into the GAC. By doing that, you ensure that the assembly is only loaded into the process one time.
- Running an application in production with the debug attribute of the `<compilation>` element set to `true`.

  - The debug attribute of the `<compilation>` element should be `false` when in production.
  - You can use the `<deploy retail="true" />` configuration to ensure that debug is always disabled in product. For more information, see [deployment Element (ASP.NET Settings Schema)](/previous-versions/dotnet/netframework-2.0/ms228298(v=vs.80)).
- Use of scripting within eXtensible Style sheet Language (XSL) transforms or creating `XmlSerializers`.

  In this case, dynamic assemblies caused by Extensible Style sheet Language Transformations (XSLT) scripting or `XmlSerializers`.

## Return large sets of data

When using data from a database or other data source, it's important to limit the amount of data returned. For example, caching a query result that returns an entire database table to avoid the cost of retrieving parts of data from the database when needed isn't a good approach. Doing so can easily cause high memory and lead to an OOM condition. Allowing a user to start a similar query is another common way to create a high memory situation. For example, return all employees in a company or all customers in the state of Texas with a last name starting with the letter S.

Always limit the amount of data that can be returned from a database. Don't allow queries such as `SELECT * FROM. . .` because you then have no control over how much data is displayed in your page.

It's equally important to ensure that you aren't displaying a large data result in UI elements, such as the GridView control. Besides the memory required for the returned data, you'll also consume large amounts of data in strings and in UI elements that are required to render the results. By implementing paging and validating input so that large sets of data aren't returned, you can avoid this problem.

## Run in a production environment with tracing enabled

ASP.NET tracing is a powerful feature for troubleshooting applications. But it should never be left on in a production environment. ASP.NET tracing uses data structures such as `DataTables` to store trace information, and over time, they can cause a high memory condition that can lead to OOM.

Tracing should be disabled in a production environment. You can do so by setting the `enabled` attribute of the `<trace>` element to false in your *web.config* file. Enabling retail deployment by using `<deploy retail="true" />` also disables tracing in your applications.

## Leak native resources

Many managed resources will also make use of native resources. Because the GC doesn't clean up native resources, a developer is responsible for implementing and calling the Dispose method to clean up native resources. If you're using a type that implements the `IDisposable` interface, and you don't call the `Dispose` method, you risk leaking native resources and causing an OOM condition.

These objects should implement the `iDisposable` interface and you should call the `Dispose` method on these objects when you no longer need them.
