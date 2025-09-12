---
title: ZipEngine role is stuck between Restarting and Busy state
description: Provides information about troubleshooting issues in which ZipEngine role is looping between Restarting and Busy state and throwing an exception
ms.date: 09/26/2022
ms.reviewer: 
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-cloud-services-classic
ms.custom: sap:Development
---
# ZipEngine role is stuck between Restarting and Busy state

This article provides information about troubleshooting issues in which ZipEngine role is stuck between **Restarting** and **Busy** state and throwing an exception stating: Could not load file or assembly 'WorkerAssembly - An attempt was made to load a program with an incorrect format.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464909

> [!NOTE]
> Refer the article on [Azure Cloud Service Troubleshooting Series](https://support.microsoft.com/help/4466645), this is the first scenario of the lab. Make sure you have followed the lab setup instructions for **Compressor** application as per [this](https://github.com/prchanda/compressor), to recreate the problem.

## Symptoms

**ZipEngine** role instance of Compressor application is constantly looping between **Restarting** and **Busy** state throwing the below unhandled exception in the Azure portal blade:

```output
Unhandled Exception: Could not load file or assembly 'WorkerAssembly, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null' or one of its dependencies. An attempt was made to load a program with an incorrect format. at ZipEngine.WorkerRole.OnStart() at Microsoft.WindowsAzure.ServiceRuntime.RoleEnvironment.InitializeRoleInternal(RoleType roleTypeEnum) at Microsoft.WindowsAzure.ServiceRuntime.Implementation.Loader.RoleRuntimeBridge. <InitializeRole> b__0() at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx) at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx) at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state) at System.Threading.ThreadHelper.ThreadStart()'[2018-08-12T11:28:39Z] Last exit time: [2018/08/12, 11:28:39.434].
```

## Troubleshoot steps

If your role does not start, or is recycling between the initializing, busy, and stopping states, your code may be throwing an unhandled exception within one of the lifecycle events each time the role restarts. So if you look into the above call stack carefully you would notice that an unhandled exception is being through from **OnStart()** method of your worker role. The best place to begin troubleshooting for this kind of scenarios is to check **Microsoft Azure Event Logs** that contains key diagnostic output from the Microsoft Azure Runtime, including information such as Role starts/stops, startup tasks, OnStart start and stop, OnRun start, crashes, recycles, and so on.

System.BadImageFormatException

```output
Process ID: 5132
Process Name: WaWorkerHost
Thread ID: 4
AppDomain Unhandled Exception for role ZipEngine_IN_0
Exception: Could not load file or assembly 'WorkerAssembly, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null' or one of its dependencies. An attempt was made to load a program with an incorrect format.
at ZipEngine.WorkerRole.OnStart()
at Microsoft.WindowsAzure.ServiceRuntime.RoleEnvironment.InitializeRoleInternal(RoleType roleTypeEnum)
at Microsoft.WindowsAzure.ServiceRuntime.Implementation.Loader.RoleRuntimeBridge.
<InitializeRole>
b__0()
at System.Threading.ExecutionContext.RunInternal(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state, Boolean preserveSyncCtx)
at System.Threading.ExecutionContext.Run(ExecutionContext executionContext, ContextCallback callback, Object state)
at System.Threading.ThreadHelper.ThreadStart()
```

Now you get a bit more detail about the exception from **Microsoft Azure Event Logs** saying that process hosting worker role is not able to load the assembly 'WorkerAssembly' due to **System.BadImageFormatException**. In general when a process is not able to load an assembly, it's always a good practice to capture Fusion logs. Make the following registry key changes under the path `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Fusion` to enable fusion logging. Give **Everyone - Full Control** permission to the fusion log path folder `C:\FusionLogs`.

:::image type="content" source="media/scenario-1-zipengine-role-stuck-busy-restart/registry-key-fusion.png" alt-text="Screenshot shows the registry keys under Fusion.":::

Upon checking the fusion log for 'WorkerAssembly', you might get more information for further troubleshooting.

```output
*** Assembly Binder Log Entry  (8/12/2018 @ 12:51:00 PM) ***
The operation failed.
Bind result: hr = 0x8007000b. An attempt was made to load a program with an incorrect format.
Assembly manager loaded from:  D:\Windows\Microsoft.NET\Framework64\v4.0.30319\clr.dll
Running under executable  E:\base\x64\WaWorkerHost.exe
--- A detailed error log follows. 
=== Pre-bind state information ===
LOG: DisplayName = WorkerAssembly, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
(Fully-specified)
LOG: Appbase = file:///E:/approot
LOG: Initial PrivatePath = E:\approot
LOG: Dynamic Base = NULL
LOG: Cache Base = NULL
LOG: AppName = RoleManager
Calling assembly : ZipEngine, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null.
===
LOG: This bind starts in default load context.
LOG: Using application configuration file: E:\approot\ZipEngine.dll.config
LOG: Using host configuration file: 
LOG: Using machine configuration file from D:\Windows\Microsoft.NET\Framework64\v4.0.30319\config\machine.config.
LOG: Policy not being applied to reference at this time (private, custom, partial, or location-based assembly bind).
LOG: Attempting download of new URL file:///E:/approot/WorkerAssembly.DLL.
LOG: Assembly download was successful. Attempting setup of file: E:\approot\WorkerAssembly.dll
LOG: Entering run-from-source setup phase.
LOG: Assembly Name is: WorkerAssembly, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
ERR: Invalid assembly platform or ContentType in file (hr = 0x8007000b).
ERR: Run-from-source setup phase failed with hr = 0x8007000b.
ERR: Failed to complete setup of assembly (hr = 0x8007000b). Probing terminated.
```

The above highlighted error message in fusion logs states that something is wrong in the bitness of the assembly. If you look into this [BadImageFormatException](/dotnet/api/system.badimageformatexception?redirectedfrom=MSDN&view=netcore-3.1&preserve-view=true) article, then the most probable cause of this error correlates to this:

"A DLL or executable is loaded as a 64-bit assembly, but it contains 32-bit features or resources. For example, it relies on COM interop or calls methods in a 32-bit dynamic link library. To address this exception, set the project's **Platform target**  property to x86 (instead of x64 or AnyCPU) and recompile."

In order to find out the bitness of the assembly, you can run any .NET decompiler of your choice. You might find the following assembly after decompiling 'WorkerAssembly' using [ILSpy](https://github.com/icsharpcode/ILSpy).

This is 32-bit assembly (x86).

```output
// C:\WorkerAssembly.dll
// WorkerAssembly, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// Global type:
<Module>
// Architecture: x86
// Runtime: .NET 4.0
```

Azure is a 64-bit environment. Therefore, .NET assemblies compiled for a 32-bit target won't work on Azure. To address this exception, set 'WorkerAssembly' project's **Platform target** property to x64 (instead of x86 or AnyCPU) and recompile.

If you review the code of WorkerRole.cs for ZipEngine role, you would notice below two lines of code that was actually loading the assembly 'WorkerAssembly' and performing some function. Since it was a 32-bit assembly the **WaWorkerHost.exe** was not able to load that assembly.

```output
WorkerAssembly.WorkerAssembly workerAssembly = new WorkerAssembly.WorkerAssembly();
workerAssembly.DoWork();
```

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
