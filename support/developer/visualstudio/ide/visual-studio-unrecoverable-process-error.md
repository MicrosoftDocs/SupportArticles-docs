---
title: A process has encountered an unrecoverable error
description: Learn about the processes that might encounter unrecoverable errors during the normal operations of Visual Studio.
ms.date: 10/14/2021
author: aartig13
ms.author: aartigoyle
ms.reviewer: tglee
ms.custom: sap:Integrated Development Environment (IDE)\Other
---
# Visual Studio unrecoverable process error

_Applies to:_&nbsp;Visual Studio

Visual Studio uses several out-of-proc processes to run required background tasks, such as live unit testing, code analyzers, and more. These processes are run out-of-proc to give Visual Studio performance advantages, such as enabling Visual Studio to respond faster when running long, resource-intensive jobs. Especially, for Visual Studio 2019 or previous versions, because it's a 32-bit process, running processes out-of-proc gives memory intensive work a larger memory space in which to operate.

If the *ServiceHub.RoslynCodeAnalysisService.exe* or *ServiceHub.RoslynCodeAnalysisService32.exe* process ends for some reason, a pop-up information bar appears with the following message:

> Unfortunately, a process used by Visual Studio has encountered an unrecoverable error. We recommend saving your work, and then closing and restarting Visual Studio.

If you see the message, save your work, and then close and restart Visual Studio.

## List of processes

Following is a list of out-of-proc processes used by Visual Studio. This list is inclusive of processes that launch in specific workflows or scenarios, and so in most cases they aren't all running at the same time.

- _Microsoft.Alm.Shared.Remoting.RemoteContainer.dll_
- _Microsoft.CodeAnalysis.LiveUnitTesting.EntryPoint_
- _MSBuild.exe_
- _PerfWatson2.exe_
- _ScriptedSandbox64.exe_
- _ServiceHub.Host.CLR.x86.exe_
- _ServiceHub.Host.Node.x86.exe_
- _ServiceHub.IdentityHost.exe_
- _ServiceHub.RoslynCodeAnalysisService.exe_
- _ServiceHub.RoslynCodeAnalysisService32.exe_
- _ServiceHub.SettingsHost.exe_
- _ServiceHub.VSDetouredHost.exe_
- _VBCSCompiler.exe_
- _VsHub.exe_
- _vstest.discoveryengine.x86.exe_
- _WaAppAgent.exe_
- _WindowsAzureGuestAgent.exe_
- _WindowsAzureTelemetryService.exe_

If any of these processes terminates unexpectedly, some functionalities within Visual Studio stop working. For some processes, the loss of functionality may be insignificant. For others, the stability of Visual Studio is affected and an error message is displayed.

> [!NOTE]
> If you experience a problem that's not referenced on this page, please report it to us via the [Report a Problem](/visualstudio/ide/how-to-report-a-problem-with-visual-studio) tool that appears both in the Visual Studio Installer and in the Visual Studio IDE.
