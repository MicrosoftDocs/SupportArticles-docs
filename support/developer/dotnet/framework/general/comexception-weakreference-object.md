---
title: COMException when you use WeakReference<T>
description: Works around an issue in which a COMException exception occurs when you create a WeakReference<T> object in a .NET Framework-based application.
ms.date: 07/08/2025
ms.reviewer: rachanr, leecow
ms.custom: sap:Class Library Namespaces
ms.topic: troubleshooting-problem-resolution

#customer intent: As a developer, I want to resolve COMExceptions that occur when I create a WeakReference object so that my application functions as intended.
---
# COMException occurs when you create a WeakReference object in a .NET Framework-based application

This article helps you work around the `COMException` exception that occurs when you create a WeakReference object in an Microsoft .NET Framework-based application.

_Original product version:_ Microsoft .NET Framework 4.5
_Original KB number:_ 2978463

## Symptoms

Assume that you develop a .NET Framework-based application. In this application, you use the reflection API to enumerate methods in a `WeakReference<T>` type. Then you call the `GetFunctionPointer` method on the `RuntimeMethodHandle` handle for the `WeakReference<T>.Create` function. When the pointer to the `WeakReference<T>.Create` method is retrieved by using code that resembles the following code sample:

```csharp
var assembly = System.Reflection.Assembly.GetAssembly(typeof(WeakReference<object>));
foreach (Type t in assembly.GetTypes())
{
    if (t.Name.StartsWith("WeakReference") && t.IsGenericType)
    {
        MethodInfo[] methods = t.GetMethods(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.CreateInstance);
        foreach (MethodInfo method in methods)
        {
            if (method.Name != "Create")
            continue;
            var ptr = method.MethodHandle.GetFunctionPointer();
        }
    }
}
```

In this situation, a `COMException` is raised if you create a `WeakReference<T>` object that resembles the following code sample:

```csharp
WeakReference<object> wr = new WeakReference<object>(new object());
```

If a debugger is attached to this application's process, you receive an exception and call stack that resembles the following code sample:

```console
Exception object: 0000000102b7bde8  
Exception type: System.Runtime.InteropServices.COMException  
Message: Unspecified error (Exception from HRESULT: 0x80004005 (E_FAIL))  
InnerException: \<none>  
StackTrace (generated):  
\<none>  
StackTraceString: \<none>  
HResult: 80004005  

00 0081eb80 742d5ddf KERNELBASE!RaiseException+0x48  
01 0081ec20 743eff3f clr!RaiseTheExceptionInternalOnly+0x27f  
02 0081ec50 7445a27f clr!UnwindAndContinueRethrowHelperAfterCatch+0x90  
03 0081ecb4 74132b0c clr!PreStubWorker+0x162  
04 0081ece4 73a0fd37 clr!ThePreStub+0x16  
05 0081ed08 0483039f mscorlib_ni!System.WeakReference1[[System.__Canon, mscorlib]]..ctor(System.__Canon)+0x7  
```

## Solution

To work around this issue, don't retrieve a pointer to the `WeakReference<T>.Create` method. This method is private to the `WeakReference<T>` class. So, invoking this method may cause undefined behavior even if you get a pointer to the function.
