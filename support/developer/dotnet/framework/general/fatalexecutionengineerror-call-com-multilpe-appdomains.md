---
title: FatalExecutionEngineError when you call COM
description: This article describes a problem in which an ASP.NET application crashes and the FatalExecutionEngineError error occurs when you do COM calls together with multiple AppDomains.
ms.date: 05/11/2020
ms.reviewer: leecow
---
# FatalExecutionEngineError occurs when you do COM calls together with multiple AppDomains

This article helps you resolve the problem where a **FatalExecutionEngineError** error might be thrown when you do Component Object Model (COM) calls together with multiple AppDomains.

_Original product version:_ &nbsp; .NET Framework 4.5  
_Original KB number:_ &nbsp; 2997900

## Symptoms

In an ASP.NET application, when you create multiple AppDomains and start a method with an optional parameter by using `IDispatch::Invoke` without specifying a value for the optional parameter, the application may crash and you receive the following error message:

> Managed Debugging Assistant FatalExecutionEngineError has detected a problem in xxx.exe. Additional information: The runtime has encountered a fatal error. The address of the error was at 0x0e888517, on thread 0x20a8. The error code is 0xc0000005.

## Cause

.NET creates an internal GC handle in the first `AppDomain` where the method call is made and will reuse the same internal GC handle throughout the lifetime of the application regardless of which `AppDomain` is used. It may cause an application crash if this `AppDomain` is unloaded.

## Workaround

To work around this issue, implement the changes shared as the code example:

```csharp
[ComVisible(true)]
[InterfaceType(ComInterfaceType.InterfaceIsDual)]
public interface ITestInterface
{
    .
    .
}
```

To do it, follow these steps:

1. Apply assembly-level `IDispatchImplAttribute(IDispatchImplType.CompatibleImpl)` to use an operating system provided `ITypeInfo` implementation instead of .NET's implementation:

    ```csharp
    [assembly:IDispatchImplAttribute(IDispatchImplType.CompatibleImpl)]
    ```

    Or, you can apply such attribute on any types that have to be accessed through `IDispatch`.

2. Change the interface type to be `InterfaceIsDual`, as the operating system provided `ITypeInfo` implementation doesn't support pure dispatch interfaces.
3. Make the interface public and visible to COM so that the interface actually shows in the type lib, and the corresponding `typeinfo` can be found in the type lib.
