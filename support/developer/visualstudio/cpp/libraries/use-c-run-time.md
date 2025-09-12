---
title: Use the C Run-time
description: This article describes how to use the C Run-time.
ms.date: 10/27/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.topic: how-to
---
# Use the C Run-Time

This article describes how to use the C Run-time.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 94248

## Section 1: Three Forms of C Run-Time (CRT) Libraries Are Available

There are three forms of the C Run-time library provided with the Win32 SDK:

- LIBC.LIB is a statically linked library for single-threaded programs.

- LIBCMT.LIB is a statically linked library that supports multithreaded programs.

- CRTDLL.LIB is an import library for CRTDLL.DLL that also supports multithreaded programs. CRTDLL.DLL itself is part of Windows NT.

Microsoft Visual C++ 32-bit edition contains these three forms as well, however, the CRT in a DLL is named MSVCRT.LIB. The DLL is redistributable. Its name depends on the version of VC++ (that is, MSVCRT10.DLL or MSVCRT20.DLL). Note however, that MSVCRT10.DLL is not supported on Win32s, while CRTDLL.LIB is supported on Win32s. MSVCRT20.DLL comes in two versions: one for Windows NT and the other for Win32s.

## Section 2: Using the CRT libraries when building a DLL

When building a DLL that uses any of the C Run-time libraries, in order to ensure that the CRT is properly initialized, either

1. The initialization function must be named `DllMain()` and the entry point must be specified with the linker option `-entry:_DllMainCRTStartup@12`

   or

2. The DLL's entry point must explicitly call `CRT_INIT()` on process attach and process detach.

This permits the C Run-time libraries to properly allocate and initialize C Run-time data when a process or thread is attaching to the DLL, to properly clean up C Run-time data when a process is detaching from the DLL, and for global C++ objects in the DLL to be properly constructed and destructed.

The Win32 SDK samples all use the first method. Use them as an example. Also refer to the Win32 Programmer's Reference for `DllEntryPoint()` and the Visual C++ documentation for `DllMain()`. Note that `DllMainCRTStartup()` calls `CRT_INIT()` and `CRT_INIT()` will call your application's DllMain(), if it exists.

If you wish to use the second method and call the CRT initialization code yourself, instead of using `DllMainCRTStartup()` and `DllMain()`, there are two techniques:

1. If there is no entry function that performs initialization code, specify `CRT_INIT()` as the entry point of the DLL. Assuming that you've included NTWIN32.MAK, which defines `DLLENTRY` as **@12**, add the option to the DLL's link line:`-entry:_CRT_INIT$(DLLENTRY)`.

   or

2. If you do have your own DLL entry point, do the following in the entry point:

    1. Use this prototype for `CRT_INIT()`: `BOOL WINAPI _CRT_INIT(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpReserved);`

       For information on `CRT_INIT()` return values, see the documentation DllEntryPoint; the same values are returned.

    2. On `DLL_PROCESS_ATTACH` and `DLL_THREAD_ATTACH` (see DllEntryPoint in the Win32 API reference for more information on these flags), call `CRT_INIT()`, first, before any C Run-time functions are called or any floating-point operations are performed.

    3. Call your own process/thread initialization/termination code.

    4. On `DLL_PROCESS_DETACH` and `DLL_THREAD_DETACH`, call `CRT_INIT()` last, after all C Run-time functions have been called and all floating- point operations are completed.

Be sure to pass on to `CRT_INIT()` all of the parameters of the entry point; `CRT_INIT()` expects those parameters, so things may not work reliably if they are omitted (in particular, fdwReason is required to determine whether process initialization or termination is needed).

Below is a skeleton sample entry point function that shows when and how to make these calls to `CRT_INIT()` in the DLL entry point:

```cpp
BOOL WINAPI DllEntryPoint(HINSTANCE hinstDLL, DWORD fdwReason,
LPVOID lpReserved)
{
    if (fdwReason == DLL_PROCESS_ATTACH || fdwReason == DLL_THREAD_ATTACH)
    if (!_CRT_INIT(hinstDLL, fdwReason, lpReserved))
    return(FALSE);

    if (fdwReason == DLL_PROCESS_DETACH || fdwReason == DLL_THREAD_DETACH)
    if (!_CRT_INIT(hinstDLL, fdwReason, lpReserved))
    return(FALSE);
    return(TRUE);
}
```

> [!NOTE]
> This is not necessary if you are using `DllMain()` and `-entry:_DllMainCRTStartup@12`.

## Section 3: Using NTWIN32.MAK to Simplify the Build Process

There are macros defined in NTWIN32.MAK that can be used to simplify your makefiles and to ensure that they are properly built to avoid conflicts. For this reason, Microsoft highly recommends using NTWIN32.MAK and the macros therein.

For compilation, use: `$(cvarsdll) for apps/DLLs using CRT in a DLL`.

For linking, use one of the following:

- `$(conlibsdll) for console apps/DLLs using CRT in a DLL`
- `$(guilibsdll) for GUI apps using CRT in a DLL`

## Section 4: Problems Encountered When Using Multiple CRT Libraries

If an application that makes C Run-time calls links to a DLL that also makes C Run-time calls, be aware that if they are both linked with one of the statically linked C Run-time libraries (LIBC.LIB or LIBCMT.LIB), the .EXE and DLL will have separate copies of all C Run-time functions and global variables. This means that C Run-time data cannot be shared between the .EXE and the DLL. Some of the problems that can occur as a result are:

- Passing buffered stream handles from the .EXE/DLL to the other module

- Allocating memory with a C Run-time call in the .EXE/DLL and reallocating or freeing it in the other module

- Checking or setting the value of the global errno variable in the .EXE/DLL and expecting it to be the same in the other module. A related problem is calling `perror()` in the opposite module from where the C Run- time error occurred, since `perror()` uses errno.

To avoid these problems, link both the .EXE and DLL with CRTDLL.LIB or MSVCRT.LIB, which allows both the .EXE and DLL to use the common set of functions and data contained within CRT in a DLL, and C Run-time data such as stream handles can then be shared by both the .EXE and DLL.

## Section 5: Mixing Library Types

You can link your DLL with CRTDLL.LIB/MSVCRT.LIB regardless of what your .EXE is linked with if you avoid mixing CRT data structures and passing CRT file handles or CRT FILE* pointers to other modules.

When mixing library types adhere to the following:

- CRT file handles may only be operated on by the CRT module that created them.

- CRT FILE* pointers may only be operated on by the CRT module that created them.

- Memory allocated with the CRT function `malloc()` may only be freed or reallocated by the CRT module that allocated it.

To illustrate this, consider the following example:

- .EXE is linked with MSVCRT.LIB
- DLL A is linked with LIBCMT.LIB
- DLL B is linked with CRTDLL.LIB

If the .EXE creates a CRT file handle using `_create()` or `_open()`, this file handle may only be passed to `_lseek()`, `_read()`, `_write()`, `_close()`, etc. in the .EXE file. Do not pass this CRT file handle to either DLL. Do not pass a CRT file handle obtained from either DLL to the other DLL or to the .EXE.

If DLL A allocates a block of memory with `malloc()`, only DLL A may call `free()`, `_expand()`, or `realloc()` to operate on that block. You cannot call `malloc()` from DLL A and try to free that block from the .EXE or from DLL B.

> [!NOTE]
> If all three modules were linked with CRTDLL.LIB or all three were linked with MSVCRT.LIb, these restrictions would not apply.

When linking DLLs with LIBC.LIB, be aware that if there is a possibility that such a DLL will be called by a multithreaded program, the DLL will not support multiple threads running in the DLL at the same time, which can cause major problems. If there is a possibility that the DLL will be called by multithreaded programs, be sure to link it with one of the libraries that support multithreaded programs (LIBCMT.LIB, CRTDLL.LIB, or MSVCRT.LIB).
