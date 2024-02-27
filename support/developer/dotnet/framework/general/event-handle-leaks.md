---
title: .NET Framework 4 app leaks event handle
description: Resolves a problem in which a .NET Framework 4 based application may leak event handles. This problem occurs even when the application is idle.
ms.date: 05/08/2020
ms.reviewer: jitheshn, raviuppa
---
# Event handle leaks in a .NET Framework 4 based application

This article helps you resolve event handle leaks in a .NET Framework 4 based application.

_Original product version:_ &nbsp; Microsoft .NET Framework 4  
_Original KB number:_ &nbsp; 2973904

## Summary

This issue may occur even when the application is idle. Additionally, if you examine the process of this application by using a debugging tool, the stack resembles the following in which the event handles are allocated:

> ntdll!ZwCreateEvent  
> kernelbase!CreateEventExW+0x6e  
> kernelbase!CreateEventW+0x27  
> clr!CLREvent::CreateManualEvent+0x3b  
> clr!Thread::AllocHandles+0xa3  
> clr!Thread::CreateNewOSThread+0x85  
> clr!Thread::CreateNewThread+0xa9  
> clr!ThreadpoolMgr::CreateUnimpersonatedThread+0xbb  
> clr!ThreadpoolMgr::CreateWorkerThread+0x19  
> clr!ThreadpoolMgr::EnsureEnoughWorkersWorking+0x116  
> clr!ThreadpoolMgr::AddWorkingWorker+0x12  
> clr!UnManagedPerAppDomainTPCount::DispatchWorkItem+0x266  
> clr!ThreadpoolMgr::NewWorkerThreadStart+0x20b  
> clr!ThreadpoolMgr::WorkerThreadStart+0x3d1  
> clr!Thread::intermediateThreadProc+0x4b  
> kernel32!BaseThreadInitThunk+0xe  
> ntdll!__RtlUserThreadStart+0x70  
> ntdll!_RtlUserThreadStart+0x1b  

## Cause

The issue occurs because the .NET Framework won't immediately reclaim the memory that is associated with these handles. The handles are reclaimed only when a Garbage Collection runs. For some applications, Garbage Collection happens rarely, because the application rarely allocates managed objects.

## Resolution

To resolve this issue, upgrade from the .NET Framework 4 to the latest version of [the .NET Framework 4.5](/dotnet/framework/install/guide-for-developers).

## Workaround

To work around this issue in the .NET Framework 4, call the `GC.Collect()` method when the application needs to reclaim the handles immediately.
