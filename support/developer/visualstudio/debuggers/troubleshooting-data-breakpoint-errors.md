---
title: Troubleshooting .NET data breakpoints
description: Provides explanation, solutions, and workarounds for "Unable to set data breakpoint" errors that occur when using "Break when Value Changes" (C# only).
ms.date: 09/12/2023
author: Mikejo5000 
ms.author: wardengnaw
ms.reviewer: khgupta, raviuppa, waan, v-sidong
ms.custom: sap:Debuggers and analyzers
f1_keywords:
  - "vs.debug.error.unable_to_set_data_breakpoint"
---

# Troubleshooting data breakpoint errors (.NET)

This article helps you resolve common errors that occur when you use "Break when Value Changes."

## Diagnose "Unable to set data breakpoint" errors

> [!IMPORTANT]
> Managed data breakpoints are supported in .NET Core 3.0, .NET 5.0.3 and later versions. You can download the latest [here](https://dotnet.microsoft.com/download).

The following errors may occur when you use managed data breakpoints. This article provides more explanation on why these errors happen and possible solutions or workarounds to resolve them.

- **The version of .NET used by the target process does not support data breakpoints. Data breakpoints require .NET Core 3.x or .NET 5.0.3+, running on x86 or x64.**

  The support for managed data breakpoints began in .NET Core 3.0. It's currently not supported in .NET Framework, versions of .NET Core under 3.0, or versions of .NET under 5.0.3.

  **Solution**: The solution to this error is upgrading your project to .NET Core 3.x or .NET 5+.

- **The value cannot be found on the managed heap and cannot be tracked.**

  - Variable declared on the stack.

    We don't support setting data breakpoints for variables created on the stack since this variable will be invalid once the function exits.

    **Workaround**: Set breakpoints on lines where the variable is used.

  - "Break when Value changes" on a variable that's not expanded from a dropdown.

    The debugger internally needs to know the object containing the field you want to track. The Garbage Collector may move your object around in the heap, so the debugger needs to know the object that's holding the variable you wish to track.

    **Workaround**: If you're in a method within the object you want to set a data breakpoint on, follow these steps:

    a. Navigate to the frame that contains the method of the object you're interested in.  
    b. Open the **Locals**, **Autos**, or **Watch** window.  
    c. Find the object and expand it to reveal its fields.  
    d. Right-click on the field you want to set a data breakpoint on and select **Break when value changes** from the context menu.

- **Data breakpoints are not supported for static fields or static properties.**

  Static fields and properties aren't supported at the moment. If you're interested in this feature, provide [feedback](#provide-feedback).

- **Fields and properties of structs cannot be tracked.**

  Fields and properties of structs aren't supported at the moment. If you're interested in this feature, provide [feedback](#provide-feedback).

- **The property value has changed and can no longer be tracked.**

  A property may change how it's calculated during runtime, and if this happens, the number of variables that the property depends on increases and may exceed the hardware limitation. For more information, see the following error **The property is dependent on more memory than can be tracked by the hardware**.

- **The property is dependent on more memory than can be tracked by the hardware.**

  Each architecture has a set number of bytes and hardware data breakpoints that it can support and the property that you wish to set a data breakpoint on has exceeded that limit. Refer to the [Data Breakpoint Hardware Limitations](#data-breakpoint-hardware-limitations) table to find out how many hardware supported data breakpoints and bytes are available for the architecture you're using.

  **Workaround**: Set a data breakpoint on a value that may change within the property.

- **Data Breakpoints are not supported when using the legacy C# expression evaluator.**

  Data breakpoints are only supported on the non-legacy C# expression evaluator.

  **Solution**: To disable the legacy C# expression evaluator, follow these steps:

  1. Go to the **Debug** menu in Visual Studio.
  1. Select **Options**.
  1. Navigate to **Debugging** > **General**.
  1. Uncheck the option **Use the legacy C# and VB expression evaluators**.

- **Class X has a custom debugger view that blocks using data breakpoints on data specific only to it.**
  
  Data breakpoints are only supported on memory that's created by the target process (the application that's being debugged). The memory that the data breakpoint is being set on has been flagged as possibly being owned by an object created by a [DebuggerTypeProxy attribute](/visualstudio/debugger/using-debuggertypeproxy-attribute) or something else that isn't part of the target process.

  **Workaround**: Expand the **Raw View** of the object(s) instead of expanding the **DebuggerTypeProxy** view of the object(s), and then set the data breakpoint. This will guarantee that the data breakpoint isn't on memory owned by an object created by a `DebuggerTypeProxy` attribute.

## Data breakpoint hardware limitations

The architecture (platform configuration) that your program runs on has a limited number of hardware data breakpoints available. The following table indicates how many registers are available to use per architecture.

| Architecture | Number of hardware supported data breakpoints | Max byte size|
| :-------------: |:-------------:| :-------------:|
| x86 | 4 | 4 |
| x64 | 4 | 8 |
| ARM | 1 | 4 |
| ARM64 | 2 | 8 |

## Provide feedback

For any issues or suggestions about this feature, let us know via **Help** > **Send Feedback** > [Report a Problem](/visualstudio/ide/how-to-report-a-problem-with-visual-studio) in the IDE or in the [Developer Community](https://aka.ms/feedback/suggest?space=8).

## See also

- [Using "Break when Value changes" in .NET](/visualstudio/debugger/using-breakpoints#BKMK_set_a_data_breakpoint_managed).
- [DevBlog: Break When Value Changes: Data Breakpoints for .NET Core in Visual Studio 2019](https://devblogs.microsoft.com/visualstudio/break-when-value-changes-data-breakpoints-for-net-core-in-visual-studio-2019/)
