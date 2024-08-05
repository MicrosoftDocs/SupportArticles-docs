---
title: Use _crtBreakAlloc to debug a memory allocation
description: This article describes how to use _crtBreakAlloc to debug a memory allocation.
ms.date: 10/27/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.topic: how-to
---
# Use _crtBreakAlloc to debug a memory allocation

This article describes how to use `_crtBreakAlloc` to debug a memory allocation.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 151585

## Summary

When tracking down memory leaks using the debug C-Runtime (CRT), it is often useful to set a breakpoint immediately before allocating the memory that causes the leak. By setting `_crtBreakAlloc` at either compile time or run-time, you can cause a user-defined breakpoint at a specific point of memory allocation.

## More information

When tracking memory leaks with Debug-CRT functions, such as `_CrtDumpMemoryLeaks`, an allocation number enclosed in braces ({}) often appears. For example, the following is a memory leak at allocation number 18:

> Detected memory leaks!  
Dumping objects ->  
{18} normal block at 0x00660BE4, 10 bytes long  
Data: < > CD CD CD CD CD CD CD CD CD CD  
Object dump complete.  

It is useful to set a breakpoint right before this memory gets allocated so you can step through the callstack and see what functions are causing this memory to get allocated. The Debug-CRT function `_CrtSetBreakAlloc` that allows you to specify an allocation number at which to break. This method requires that you recompile your program every time you want to set an allocation breakpoint. An alternative method is to use the Watch window and set the allocation breakpoint dynamically. This method has the advantage of not requiring any source code changes or recompiling.

If you are statically linking to the C Run-time, the variable you want to change is called `_crtBreakAlloc`. If you are dynamically linking to the C Run-time, the variable you want to change in the Watch window is `{,,msvcr40d.dll}__p__crtBreakAlloc()` if you are using Visual C++ 4.0 or 4.1. The variable you want to change in the Watch window should be `{,,msvcrtd.dll}__p__crtBreakAlloc()` if you are using Visual C++ 4.2 or later.

To determine which version of the CRT you are compiling with:

1. From the **Build** menu, choose **Settings**.

2. In the **Settings** for: pane, select the configuration you are building for. Choose the **C/C++** tab, and then select the **Code Generation** category.

The Use run-time library dialog should appear to display the version of the CRT you are using. (If this setting is blank, make sure you have only selected one configuration on the Settings for: pane.)

To set an allocation breakpoint dynamically, perform the following steps:

1. Start your debugging session. From the Build menu, choose Debug -> Step-Into. If you are using the "Debug Single-Threaded" or "Debug Multi- Threaded CRT", follow step 1a. Otherwise, follow step 1b.

    1. Type *_crtBreakAlloc* in the Watch window. This shows the current allocation number at which your program will stop. This allocation number should be -1 when your program first starts.

    2. Type *{,,msvcr40d.dll}__p__crtBreakAlloc()* in the Watch window if you are using Visual C++ 4.0 or 4.1. Type *{,,msvcrtd.dll}__p__crtBreakAlloc()* if you are using Visual C++ 4.2 or later. This shows the current allocation number at which your program will stop. This allocation number should be -1 when your program first starts.

2. Double-click on the **-1** value, and enter the new allocation number that causes a user-defined breakpoint.

3. From the **Debug** menu, choose **Debug** -> **Go**.

For more information about `_crtBreakAlloc`, please see **Tracking Heap Allocation Requests** in the Online Help.
