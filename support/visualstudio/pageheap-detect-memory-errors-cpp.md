---
title: Use PageHeap to detect memory errors
description: Describes how to use the PageHeap utility to automatically monitor memory errors in a Microsoft Visual C++ project.
ms.date: 04/24/2020
ms.prod-support-area-path: 
ms.reviewer: JULIAJ
---
# How to use the PageHeap utility to detect memory errors in a Microsoft Visual C++ project

This article describes how to use the PageHeap utility to detect memory errors in Visual C++ projects. The information in this article applies only to unmanaged Visual C++ code.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 264471

## Summary

The PageHeap utility can be enabled for applications so that all `malloc`, `new`, and `heapAlloc` allocations are monitored automatically for memory errors.

PageHeap1 is a Microsoft Visual C++ project with several types of memory errors. To enable PageHeap on this sample application, type in the following content from the command line:

```console
pageheap /enable pgh.exe 0x01
```

Then, type in the following content:

```console
pageheap
```

> [!NOTE]
> The application name that PageHeap monitors.

For many applications, `0x01` is the only flag you need. You can get more information on its usage by running PageHeap with the question mark flag (`/?`) from the command line.

## How PageHeap works

PageHeap returns a pointer to allocated memory on 8-byte boundaries. The end of the returned pointer is followed by 0 to 7 guard bytes (depending on the size requested, 0 bytes to 7 bytes are added to round up the request size to be on an 8-byte boundary), followed by a memory page marked `PAGE_NOACCESS` (for more information, see VirtualAlloc documentation). For example:

```cpp
char * p;
p = new char[5];
```

PageHeap returns a pointer to the 5 bytes plus three guard bytes to make up a total of 8 bytes, such as.....XXX. If the memory allocation size is a multiple of eight, there are no guard bytes added to the returned pointer.

If the end of the allocation is overwritten, the cause an Access Violation (AV) when the memory is freed. If the application reads or writes past the allocation (including the guard bytes), it incurs an instant AV.

## How to use PageHeap1 sample

1. Build the pgh project and run the pgh.exe.

    > [!NOTE]
    > You must do a release build for PageHeap to work with `new`/`malloc`.

    Launch the PageHeap1.exe. There is a dialog box pop-up.

2. On the dialog box, you can see a TextBox, a Bad Alloc/Free check box, and three pair of buttons, new & delete, PageAlloc & Heap Free and COM new & COM Delete. The TextBox takes in the size of memory you want to have allocated. If the Bad Alloc/Free check box is selected, each allocation type (new, PageAlloc, and COM new) allocates memory and then writes past the allocation. If bad Alloc isn't checked, no memory overwrite occurs.

    Button new tests the `new` operator, button PageAlloc tests `HeapAlloc`. The Component Object Model (COM) new doesn't use `CoTaskMemAlloc` but rather calls into a COM Dynamic-link library (DLL) that simply calls `new`. To test COM new, you must either register *r1LeakMemMod.dll* or build the r1LeakMemMod project.

    You can use a run-time DLL library for PageHeap to work. (From the Visual C++ Integrated Development Environment (IDE), **Projects** > **settings** > **C++** > **Category: Code Generation** > **Use run-time library**).

3. After checking the box of Bad Alloc/Free, if the memory allocation size is 5 bytes, click on the new button, 5-bytes memory will be allocated and 0 is written into the sixth byte. Writing to the sixth byte is an illegal memory overwrite, however it occurs on a guard byte so PageHeap doesn't detect this error until the memory is deleted. When you click the delete button, PageHeap detects the overwrite and you'll see an error message box similar to following example:

    > The exception Breakpoint A breakpoint has been reached. (0x80000003) occurred in the application at location 0x77f9f9df.

    If you have Visual C++ specified as Just-In-Time (JIT) debugger, you can click the **Cancel** button and debug into the code.

    If you change the allocation size to 8 (or any multiple of 8), selecting new, pageAlloc, or COM New buttons results in an instant AV because you've written to an address with no access. (that is you don't have to delete the memory to detect the error).

> [!NOTE]
>
> 1. Limitations: PageHeap can only find memory errors from the `malloc` family (hence C++ operator `new`) and `heapAlloc`. Many applications use custom allocators and PageHeap is unable to intercept these allocations.
> 2. When you have finished testing an application run `pageheap /disable <appName>` from the command line to turn off PageHeap for that application.
> 3. PageHeap enabled applications can consume much more memory than the same application without PageHeap enabled. You may have to increase your swap file to satisfy the increased memory demand.

The following files are available for download from the Microsoft Download Center:  

- [Download Pageheap1vcnet.exe now](http://download.microsoft.com/download/visualstudionet/sample/1.13/win98mexp/en-us/pageheap1vcnet.exe)

For more information about how to download Microsoft support files, click [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.
