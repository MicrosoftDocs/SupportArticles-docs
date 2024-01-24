---
title: Default maximum stack size of a thread
description: This article describes the default maximum stack size of a thread that is created by a native IIS process.
ms.date: 12/29/2020
ms.custom: sap:Site Behavior and Performance
ms.reviewer: mlaing
ms.subservice: site-behavior-performance
---
# The default maximum stack size of threads created in a native IIS process is 256 KB

This article introduces the default maximum stack size of a thread that is created by a native Microsoft Internet Information Services (IIS) process.

_Original product version:_ &nbsp; Internet Information Services 8.0  
_Original KB number:_ &nbsp; 932909

## Summary

By default, the maximum stack size of a thread that is created by a native IIS process is 256 KB prior to Windows Server 2008. For example, when Inetinfo.exe, DLLHost.exe, or W3wp.exe creates a thread in IIS 5.0 or IIS 6.0, the maximum stack size of the thread is 256 KB by default. You can also explicitly call the CreateThread  function to specify the stack size of the thread. In Microsoft Windows 2000, if the Microsoft ASP.NET Worker Process (ASPNet_wp.exe) creates a thread, the maximum stack size of the thread is 1 MB. In Windows Server 2008 and higher, the maximum stack size of a thread running on 32-bit version of IIS is 256 KB, and on an x64 server is 512 KB.

> [!NOTE]
> Internet Information Services is a multi-threaded web application platform that allows application code running inside of each worker process to utilize hundreds or more threads at once as necessary. Each thread is bound by the same stack size limit in order to keep the virtual memory usage of the process within manageable limits.

## More information

The maximum stack size of a thread is not determined by an individual ISAPI, DLL, or ASP component that is running inside the process. The maximum stack size of a thread is configured by the executable file of the process. If you must have a large stack size, you can programmatically create a thread and then set the appropriate stack size. Alternatively, if the thread runs out of the maximum stack size, you must change the code in the application to use the stack correctly.

The arguments and the local variables of a function are stored in the stack of the thread. If you declare a local variable that has a large value, the stack is quickly exhausted. For example, the function in the following code example requires 400,000 bytes in the stack to store the array.

```aspx-csharp
void func(void)
{
    int i[100000];
    // Use 100,000 integers multiplied by 4 bytes per integer to store the array.
    return;
}
```

> [!NOTE]
> You cannot call this function in IIS 4.0, in IIS 5.0, in IIS 5.1, or in IIS 6.0.

To avoid using the stack, dynamically allocate the memory. For example, the function in the following code example dynamically allocates the memory.

```aspx-csharp
void func(void)
{
    int *i
    
    i = new int[100000];
    // More code goes here.
    return;
}
```

> [!NOTE]
> In this code example, the memory is stored in the heap instead of the stack. Therefore, the function does not require 400,000 bytes in the stack to store the array.

If a function is called recursively, the stack may be quickly exhausted. For example, a function requires 400,000 bytes in the stack if the following conditions are true:

- The function requires 40 bytes for a local variable.
- The function is recursively called 10,000 times.

In a Common Gateway Interface (CGI) application, a thread does not have a maximum stack size of 256 KB. When you start the CGI application, a new process is created, and the CGI executable files configure the stack size. You can also explicitly call the CreateThread function to specify the stack size of the thread.

For more information, see [Thread Stack Size](/windows/win32/procthread/thread-stack-size).
