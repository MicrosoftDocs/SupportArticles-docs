---
title: An application fails to create a COM+ component
description: This article describes a problem that might occur when a client application tries to create a COM+ component, and the client application receives an error message.
ms.date: 12/19/2023
ms.custom: sap:Component development
ms.reviewer: wmascia
ms.subservice: component-dev
---

# A client application may intermittently receive an error message when it tries to create a COM+ component

This article helps you resolve the problem where the client application might intermittently receive an error message when it creates a COM+ component.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 911359

## Symptoms

When a client application tries to create a Microsoft COM+ component, the client application may intermittently receive an error message.

- Microsoft C++ applications may receive the following error message:

    > E_INVALIDARG: "The parameter is incorrect" (0x80070057/-2147024809)

- Microsoft Visual Basic 6.0 applications may receive the following error message:

    > Run-time error '5': "Invalid procedure call or argument" (0x800a0005/-2146828283)

- Client applications that are built on the Microsoft .NET Framework may receive the following error message:

    > System.ArgumentException: "The parameter is incorrect." at System.Runtime.Type.CreateInstanceImpl(Boolean publicOnly) at System.Activator.CreateInstance(Type type, Boolean nonPublic) (with _HResult = 0x80070057/-2147024809)

The COM+ application will typically function without error for some time immediately after the COM+ application is opened. The problem occurs intermittently, but increases in frequency over time until the application eventually fails on every activation request.

## Cause

This problem occurs because the Component Object Model (COM) initialization count for a thread is incremented and decremented when the `CoInitialize` function and the `CoUninitialize` function are called. When this count reaches zero after you call the `CoUninitialize` function, COM will be uninitialized on the thread. When a COM+ STA ThreadPool thread is uninitialized, the thread's apartment activator is destroyed. The next activation request that is routed to this thread will fail with the **E_INVALIDARG** error message. This problem occurs because the thread apartment activator is no longer available. Only activation requests that are routed to the particular uninitialized thread will fail. As more COM+ `ThreadPool` threads become uninitialized, a larger percentage of requests will fail. When all COM+ `ThreadPool` threads become uninitialized, all requests will fail. If the process is restarted, the problem will recover for some time. However, the cycle will be repeated.

## Resolution

To resolve this problem, remove the `CoInitialize` calls and the `CoUninitialize` calls from the affected COM DLL. A COM DLL that exposes COM components and is loaded through COM calls from a client should not call the `CoInitialize` function or the `CoUninitialize` function on any thread that is used to load or to start the DLL. These threads are owned by the client application, by the COM runtime, or by the COM+ runtime. Only the COM DLL should call these APIs on additional threads that were explicitly created by the COM DLL. However, it is a common bug for COM DLLs to call the `CoInitialize` function and the `CoUninitialize` function in response to attach events and detach events in the `DllMain` function.

> [!NOTE]  
> It is correct for a standard Win32 DLL that isn't loaded through COM to call these APIs if the standard Win32 DLL plans to use COM APIs. However, these functions should not be called from the `DllMain` function.

For more information about the `CoInitialize` function, see [CoInitialize function](/windows/win32/api/objbase/nf-objbase-coinitialize).

For more information about the `DllMain` function, see [DllMain entry point](/windows/win32/dlls/dllmain).

> [!NOTE]  
> One Microsoft component that contains this bug is the *Cdo.dll* component. This component isn't supported in multithreaded environments. Instead, we recommend that you use the *Cdosys.dll* component or the *Cdonts.dll* component.

## More information

To determine which COM component contains the affected code, use the Microsoft Internet Information Services (IIS) Debug Diagnostic Tool (DebugDiag). To do this, follow these steps:

1. [Download and install DebugDiag](https://www.microsoft.com/download/details.aspx?id=58210).
2. Create a crash rule in DebugDiag. To do this, follow these steps:

   1. Click **Start**, point to **Programs**, point to **IIS Diagnostics (32bit)**, point to **Debug Diagnostics Tool**, and then click **Debug Diagnostics Tool 1.0**.
   2. If the **Select Rule Type** dialog box opens, click **Cancel**.
   3. On the **Tools** menu, click **Options And Settings**.
   4. Click the **Folders and Search Paths** tab, and then enter `srv*C:\symsrv\*http://msdl.microsoft.com/download/symbols` in the **Symbol Search Path For Analysis** field.
   5. In the **Symbol Search Path For Debugging** field, enter `srv*C:\symsrv\*http://msdl.microsoft.com/download/symbols`, and then click **OK**.
   6. Click **Add Rule**.
   7. Click **Crash**, and then click **Next**.
   8. Click **A specific MTS/COM+ application (included high and medium isolation websites)**, and then click **Next**.
   9. Click the appropriate COM+ application, and then click **Next**.
   10. In the **Advanced Configuration (Optional)** dialog box, click **Breakpoints**.
   11. In the **Configure Breakpoints** dialog box, click **Add Breakpoint**.
   12. In the **Configure Breakpoint** dialog box, enter *ole32!CoInitializeEx* in the **Breakpoint Expression** field, enter *1000* in the **Action Type** field, keep **Log Stack Trace** in the **Action Type** field, and then click **OK**.
   13. In the **Configure Breakpoints** dialog box, click **Add Breakpoint**.
   14. In the **Configure Breakpoint** dialog box, enter *ole32!CoUninitialize* in the **Breakpoint Expression** field, enter *1000* in the **Action Limit** field, and then click **OK**.
   15. In the **Configure Breakpoints** dialog box, click **Save & Close**.
   16. In the **Advanced Configuration (Optional)** dialog box, click **Next**.
   17. In the **Select Dump Location And Rule Name (Optional)** dialog box, click **Next**.
   18. In the **Rule Completed** dialog box, click **Activate the rule now**, and then click **Finish**.

DebugDiag monitors the selected COM+ application when the application runs. Every time that DebugDiag experiences one of the selected breakpoints, DebugDiag adds data to a log file. By default, the log file will be named:  
`C:\Program Files\IIS Resources\DebugDiag\Logs\dllhost__PID__\<pid>\__Date__\<date> __Time\_\<time> Log.txt`

When an error occurs in the application, review the appropriate log file to find the affected DLL. In the following example, the affected COM component is *Mybaddll.dll*. The following call stacks are examples of expected API calls that are directly from the COM+ runtime:

```console
[10/27/2005 10:03:42 AM] Breakpoint at ole32!CoInitializeEx caused by 3500
[10/27/2005 10:03:42 AM] Stack Trace
ChildEBP RetAddr Args to Child
0097ff38 7668c062 00000000 00000002 7c910732 ole32!CoInitializeEx
0097ff80 77c3a3b0 000de370 7c910732 00000005 COMSVCS!CSTAThread::WorkerLoop+0x6c
0097ffb4 7c80b50b 0003e018 7c910732 00000005 msvcrt!_endthreadex+0xa9
0097ffec 00000000 77c3a341 0003e018 00000000 kernel32!BaseThreadStart+0x37

[10/27/2005 10:13:29 AM] Breakpoint at ole32!CoUninitialize caused by 1300
[10/27/2005 10:13:29 AM] Stack Trace
ChildEBP RetAddr Args to Child 
006dff08 766f965b 00000000 000b9838 00037138 ole32!CoUninitialize
006dff70 766f9742 000b9838 00037258 006dffb4 COMSVCS!WORK_QUEUE::WorkerLoop+0x248
006dff80 77c3a3b0 000b9838 00000000 7c9105c8 COMSVCS!WORK_QUEUE::ThreadLoop+0x19
006dffb4 7c80b50b 00037138 00000000 7c9105c8 msvcrt!_endthreadex+0xa9
006dffec 00000000 77c3a341 00037138 00000000 kernel32!BaseThreadStart+0x37

[10/27/2005 10:13:29 AM] Breakpoint at ole32!CoUninitialize caused by 2188
[10/27/2005 10:13:29 AM] Stack Trace
ChildEBP RetAddr Args to Child
0007fd98 0100128e 00092388 00000000 0007fdbc ole32!CoUninitialize
0007ff1c 010015b0 01000000 00000000 00092388 dllhost!WinMain+0xd0
0007ffc0 7c816d4f 00098610 005df0fc 7ffdb000 dllhost!WinMainCRTStartup+0x174
0007fff0 00000000 0100143c 00000000 78746341 kernel32!BaseProcessStart+0x23
```

The following call stacks are examples of unexpected API calls from a custom DLL:

```console
[10/27/2005 10:03:49 AM] Breakpoint at ole32!CoInitializeEx caused by 3500
[10/27/2005 10:03:42 AM] Stack Trace
ChildEBP RetAddr Args to Child
0097e684 1001349c 00000000 00000001 0097e7cc ole32!CoInitialize
0097e76c 100293ca 10000000 00000001 00000000 MyBadDLL!DllMain+0x4c
0097e7b8 7c9011a7 10000000 00000001 00000000 MyBadDLL!_DllMainCRTStartup+0xca
0097e7d8 7c91cbab 10011712 10000000 00000001 ntdll!LdrpCallInitRoutine+0x14
0097e8e0 7c916178 00000000 c0150008 00000000 ntdll!LdrpRunInitializeRoutines+0x344
0097eb8c 7c9162da 00000000 000c6a30 0097ee80 ntdll!LdrpLoadDll+0x3e5
0097ee34 7c801bb9 000c6a30 0097ee80 0097ee60 ntdll!LdrLoadDll+0x230
0097ee9c 7752e1b1 0097ef18 00000000 00000008 kernel32!LoadLibraryExW+0x18e
0097eec0 7752e0cd 0097ef18 0097eee4 0097eee8 ole32!CClassCache::CDllPathEntry::LoadDll+0x6c
0097eef0 7752d550 0097ef18 0097f1f4 0097ef10 ole32!CClassCache::CDllPathEntry::Create_rl+0x37
0097f13c 7752d473 00000001 0097f1f4 0097f16c ole32!CClassCache::CClassEntry::CreateDllClassEntry_rl+0xd6
0097f184 7752d3d1 00000001 000ba820 0097f1ac ole32!CClassCache::GetClassObjectActivator+0x195
0097f1b0 7752cf3b 0097f1f4 00000000 000d82c4 ole32!CClassCache::GetClassObject+0x23
0097f22c 7752cddf 77607150 00000000 000d82c4 ole32!CServerContextActivator::CreateInstance+0x106
0097f26c 76672d76 000d82c4 00000000 0097f33c ole32!ActivationPropertiesIn::DelegateCreateInstance+0xf7
0097f2e0 7752cddf 000cba80 00000000 000d82c4 COMSVCS!CObjectActivator::CreateInstance+0x21c
0097f320 7759699a 000d82c4 00000000 0097f33c ole32!ActivationPropertiesIn::DelegateCreateInstance+0xf7
0097f340 775877e1 000cf170 000b492c 00000000 ole32!DoServerContextCCI+0x1d
0097f38c 775880cf 00000000 000b492c 7759697d ole32!EnterForCallback+0xc2
0097f4ec 77563258 0097f3c4 7759697d 000cf170 ole32!SwitchForCallback+0x1a3
0097f518 7751929f 000b492c 7759697d 000cf170 ole32!PerformCallback+0x54
0097f5b0 7758a738 00099940 7759697d 000cf170 ole32!CObjectContext::InternalContextCallback+0x155
0097f5d0 77596ba1 00099940 7759697d 000cf170 ole32!CObjectContext::DoCallback+0x1c
0097f5fc 77567439 77607154 000d82c4 000d0ba0 ole32!CApartmentActivator::ContextCallHelper+0x4e
0097f658 77e79dc9 77607154 00000000 000d82c4 ole32!CApartmentActivator::CreateInstance+0x110
0097f67c 77ef321a 7752cfbc 0097f690 00000004 RPCRT4!Invoke+0x30
0097fa88 77ef3bf3 000d8ea0 000cfc04 000cecb4 RPCRT4!NdrStubCall2+0x297
0097fae0 77600c31 000d8ea0 000cecb4 000cfc04 RPCRT4!CStdStubBuffer_Invoke+0xc6
0097fb20 77600bdb 000cecb4 000b689c 00000000 ole32!SyncStubInvoke+0x33
0097fb68 7750f237 000cecb4 000d5de8 000d8ea0 ole32!StubInvoke+0xa7
0097fc40 7750f15c 000cfc04 00000000 000d8ea0 ole32!CCtxComChnl::ContextInvoke+0xe3
0097fc5c 7750fc79 000cecb4 00000001 000d8ea0 ole32!MTAInvoke+0x1a
0097fc88 77600e3b 000cecb4 00000001 000d8ea0 ole32!STAInvoke+0x4a
0097fcbc 776009bc 000cec60 000cfc04 000d8ea0 ole32!AppInvoke+0x7e
0097fd90 77600df2 000cec60 000b1b10 00000000 ole32!ComInvokeWithLockAndIPID+0x2e0
0097fdbc 7750fcb3 000cec60 00000400 000d1d88 ole32!ComInvoke+0x60
0097fdd0 7750fae9 000cec60 0097fe50 7750fa56 ole32!ThreadDispatch+0x23
0097fde8 77d48734 002f07c8 000c7d08 0000babe ole32!ThreadWndProc+0xfe
0097fe14 77d48816 7750fa56 002f07c8 00000400 USER32!InternalCallWinProc+0x28
0097fe7c 77d489cd 00000000 7750fa56 002f07c8 USER32!UserCallWinProcCheckWow+0x150
0097fedc 77d48a10 000de3fc 00000000 0097ff08 USER32!DispatchMessageWorker+0x306
0097feec 7668b57c 000de3fc 000de3f8 000de370 USER32!DispatchMessageW+0xf
0097ff08 7668b42d 000de390 000de370 000de3ec COMSVCS!CSTAQueueLessMessageWork::DoWork+0x4e
0097ff20 7668bea5 000de3f8 7668c2d0 000de370 COMSVCS!CSTAThread::DoWork+0x18
0097ff40 7668c197 7c910732 0003c9a8 0003e018 COMSVCS!CSTAThread::ProcessQueueWork+0x47
0097ff80 77c3a3b0 000de370 7c910732 00000005 COMSVCS!CSTAThread::WorkerLoop+0x1a1
0097ffb4 7c80b50b 0003e018 7c910732 00000005 msvcrt!_endthreadex+0xa9
0097ffec 00000000 77c3a341 0003e018 00000000 kernel32!BaseThreadStart+0x37

[10/27/2005 10:08:42 AM] Breakpoint at ole32!CoUninitialize caused by 628
[10/27/2005 10:08:42 AM] Stack Trace
ChildEBP RetAddr Args to Child
0097f9f4 100134e5 0097fb7c 0097fb38 10011712 ole32!CoUninitialize
0097fad8 100293ca 10000000 00000000 00000000 MyBadDLL!DllMain+0x95
0097fb24 7c9011a7 10000000 00000000 00000000 MyBadDLL!_DllMainCRTStartup+0xca
0097fb44 7c91e6f4 10011712 10000000 00000000 ntdll!LdrpCallInitRoutine+0x14
0097fc3c 7c80aa7f 10000000 0097fc90 0097fdb0 ntdll!LdrUnloadDll+0x41c
0097fc50 77513442 10000000 0097fdd0 77513456 kernel32!FreeLibrary+0x3f
0097fc5c 77513456 0097fc9c 776067e0 00000000 ole32!CClassCache::CDllPathEntry::CFinishObject::Finish+0x2f
0097fc70 775135fe 774e1ab0 00000000 00000000 ole32!CClassCache::CFinishComposite::Finish+0x1d
0097fdd0 77513578 ffffffff 000c7d08 0097fe1c ole32!CClassCache::FreeUnused+0x19d
0097fde0 775133a2 ffffffff 00000000 7668b359 ole32!CoFreeUnusedLibrariesEx+0x36
0097fdec 7668b359 77d48734 00000000 00000113 ole32!CoFreeUnusedLibraries+0x9
0097fdf0 77d48734 00000000 00000113 0000705b COMSVCS!STAFreeLibTimerProc+0x6
0097fe1c 77d49857 7668b353 00000000 00000113 USER32!InternalCallWinProc+0x28
0097fe84 77d49791 00000000 7668b353 00000000 USER32!UserCallWinProc+0xf3
0097fedc 77d48a10 000de3fc 00000000 0097ff08 USER32!DispatchMessageWorker+0x10e
0097feec 7668b57c 000de3fc 000de3f8 000de370 USER32!DispatchMessageW+0xf
0097ff08 7668b42d 000de390 000de370 000de3ec COMSVCS!CSTAQueueLessMessageWork::DoWork+0x4e
0097ff20 7668bea5 000de3f8 7668c2d0 000de370 COMSVCS!CSTAThread::DoWork+0x18
0097ff40 7668c197 7c910732 0003c9a8 0003e018 COMSVCS!CSTAThread::ProcessQueueWork+0x47
0097ff80 77c3a3b0 000de370 7c910732 00000005 COMSVCS!CSTAThread::WorkerLoop+0x1a1
0097ffb4 7c80b50b 0003e018 7c910732 00000005 msvcrt!_endthreadex+0xa9
0097ffec 00000000 77c3a341 0003e018 00000000 kernel32!BaseThreadStart+0x37
```
