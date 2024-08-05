---
title: Instrumenting a signed assembly would throw warning message
description: This article provides two resolutions for the problem where error message XXX.DLL/XXX.EXE has been signed. Instrumenting will break verification occurs.
ms.date: 01/04/2021
ms.custom: sap:Language or Compilers\Other
ms.topic: troubleshooting
---
# Instrumenting a signed assembly would throw warning message: XXX.DLL/XXX.EXE has been signed. Instrumenting will break verification

This article helps you resolve the problem where error message XXX.DLL/XXX.EXE has been signed. Instrumenting will break verification occurs.

_Applies to:_ &nbsp; Microsoft Visual Studio  
_Original KB number:_ &nbsp; 2200180

## Symptoms

In Visual Studio, you would get a warning message similar to the following message:

> XXX.DLL/XXX.EXE has been signed. Instrumenting will break verification. Either turn off verification for this assembly or re-sign it in the post-instrumentation step. Press OK to attempt to profile anyway.

If you press **OK** in the message box, the profiler would run however there will not be any data collected after instrumenting the assembly.

You create any type of .NET based application (Console, `Winforms`, Test project, etc.), and you sign the assembly. Then you use the performance wizard to instrument the signed assembly. Refer the MSDN document: [How to: Use Performance Wizard](/previous-versions/ms182372(v=vs.80)).

You encounter an error similar to the following error:  

> Microsoft Visual Studio  
> \<Assembly Name> has been signed.  Instrumenting will break verification.  Either turn off verification for this assembly or re-sign it in the post-instrumentation step. Press OK to attempt to profile anyway.  
> OK   Cancel  

## Cause

One of the reasons this happens is the that the Visual Studio profiler would break the strong name for the signed assemblies when you try to instrument the assembly. It would lead to an exception when the profiler tries to attach to the signed assembly as the strong name for the signed assembly is broken. This would lead to an internal exception and the profiler would not be able to collect the logs for the instrumentation.

## Resolution

There are two methods to resolve this problem.

- Method 1

    Re-sign the assembly in the post-instrumentation step. To type the re-sign command for the assembly do the following:

    1. Do the following to type the command in the post-instrument command:

       - To specify post-instrument commands for all binaries in a performance session, select the performance session node in **Performance Explorer**, and then right-click and select **Properties**.

       - To specify post-instrument commands for a specific binary right-click the name of the binary in the **Targets** list of the performance session, and then select **Properties**.

    1. In the **Property Pages**, click **Instrumentation**.
    1. Type the command in the **Command-line** text box under **Post-Instrument events**.
    1. Click **OK**.

    The above steps are documented in MSDN. You can refer the MSDN online document about: [How to: Specify Pre- and Post-Instrument Commands](/previous-versions/visualstudio/visual-studio-2015/profiling/how-to-specify-pre-and-post-instrument-commands).

    In the post-instrument command-line type, the command: `"<path>\sn.exe" -Ra <assembly_path> <strong_name_file>`.

    For example: `C:\Program Files\Microsoft SDKs\Windows\v6.0A\bin\sn.exe" -Ra "..Bin\Debug\TestApp.EXE" "..\..\ TestApp.EXE.snk`.

- Method 2

  Register the assembly for verification skipping: `sn -Vr <assembly>`. You can do this in the post-build event of the assembly or outside of IDE, and you need admin privileges to do it.
