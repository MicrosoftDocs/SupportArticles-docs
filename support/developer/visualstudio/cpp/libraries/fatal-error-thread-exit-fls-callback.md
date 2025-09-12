---
title: Error at thread exit if FLS callback isn't freed
description: A process may crash at thread exit with an Access Violation exception if it had dynamically loaded a native C++ DLL that was statically linked with C Runtime, and the DLL generated an unhandled exception during its initialization or shutdown.
ms.date: 04/22/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.reviewer: ScotBren, gaurap
---
# Fatal error at thread exit if FLS callback isn't freed

This article helps you resolve the problem where a C++ DLL statically linked to C Run-time Library (CRT) causes a fatal error at thread exit if the DLL load or unload sequence is interrupted by an unhandled exception.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 2754614

## Symptoms

A C++ DLL statically linked to C Run-time Library (CRT) may cause a fatal error at thread exit if the DLL load or unload sequence is interrupted by an unhandled exception.  

A process may crash at thread exit with an Access Violation exception (0xC0000005, EXCEPTION_ACCESS_VIOLATION) if it had dynamically loaded (such as by calling [LoadLibraryA()](/windows/win32/api/libloaderapi/nf-libloaderapi-loadlibrarya)) a native C++ DLL that was statically linked with C Runtime, and the DLL generated an unhandled exception during its initialization or shutdown.

During the CRT startup or shutdown (such as during `DLL_PROCESS_ATTACH` or `DLL_PROCESS_DETACH` in `DllMain()`, or in the constructor or destructor of a global/static C++ object), if the DLL generates a fatal error that is unhandled, the `LoadLibrary` call just swallows the exception and returns with **NULL**. When the DLL load or unload fails, some error codes you may observe include:

- ERROR_NOACCESS (998) or EXCEPTION_ACCESS_VIOLATION (0xC0000005, 0n3221225477)
- EXCEPTION_INT_DIVIDE_BY_ZERO (0xC0000094, 0n3221225620)
- ERROR_STACK_OVERFLOW (1001) or EXCEPTION_STACK_OVERFLOW (0xC00000FD, 0n3221225725)
- C++ exception (0xE06D7363, 0n3765269347)
- ERROR_DLL_INIT_FAILED (0x8007045A)

This library startup or shutdown failure usually is not observed until the calling thread is about to exit, in the form of a deadly Access Violation exception with a similar call stack as below:

```console
<Unloaded_TestDll.dll>+0x1642 ntdll!RtlProcessFlsData+0x57 ntdll!LdrShutdownProcess+0xbd
ntdll!RtlExitUserProcess+0x74 kernel32!ExitProcessStub+0x12 TestExe!__crtExitProcess+0x17
TestExe!doexit+0x12a TestExe!exit+0x11 TestExe!__tmainCRTStartup+0x11c
kernel32!BaseThreadInitThunk+0xe ntdll!__RtlUserThreadStart+0x70 ntdll!_RtlUserThreadStart+0x1b
```

This behavior can be reproduced with the following snippet of code in Visual Studio:

```cpp
//TestDll.dll: Make sure to use STATIC CRT to compile this DLL (i.e., /MT or /MTd)
#include <Windows.h>
BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
{
    switch (ul_reason_for_call)
    {
        case DLL_PROCESS_ATTACH:
        {
            //About to generate an exception
            int* pInt = NULL;
            *pInt = 5;
            break;
        }
    }
    return TRUE;
}

//TestExe.exe:
#include <Windows.h>
#include <stdio.h>
int main(int argc, TCHAR* argv[])
{
     HMODULE hModule = LoadLibrary(TEXT("TestDll.dll"));
     printf("GetLastError = %d\n", GetLastError());
     if (hModule != NULL)
     FreeLibrary(hModule);
     return 0;
     //Access Violation will occur following the above return statement
}
```

## Cause

A Fiber Local Storage (FLS) callback function is invoked by Windows when the thread exits, and the address of that function is no longer in valid process memory. The most common cause is from the use of static CRT in a DLL that is prematurely unloaded.

When the C Runtime is initialized at DLL load time, it registers an FLS callback function named *_freefls()* via a call to [FlsAlloc()](/windows/win32/api/fibersapi/nf-fibersapi-flsalloc); however, the C Runtime doesn't unregister this FLS callback if an unhandled exception occurs in the DLL while it is being loaded or unloaded.

Because the C Runtime is statically linked in the DLL, its FLS callback is implemented in that DLL itself. If this DLL fails to load or unload due to an unhandled exception, not only will the DLL be automatically unloaded, but the C Runtime's FLS callback will remain registered with the OS even after the DLL is unloaded. When the thread exits (for example, when the EXE's `main()` function returns), the OS tries to invoke the registered FLS callback function (*_freefls* in this case) which now points to unmapped process space and ultimately results in an Access Violation exception.

## Resolution

A change has been made in the VC++ 11.0 CRT (in VS 2012) to better address FLS callback cleanup on unhandled exceptions during DLL startup. So, for DLLs whose source code is accessible and hence could be recompiled, the following options can be tried:

1. Compile the DLL with the latest VC11 CRT (for example, build the DLL with VS2012 RTM).
2. Use the CRT DLL, rather than static linking to C Runtime while compiling your DLL; use **/MD** or **/MDd** instead of **/MT** or **/MTd**.
3. If possible, correct the cause of the unhandled exception, remove the exception-prone piece of code from `DllMain`, and/or handle the exception properly.
4. Implement a custom DLL entry point function, wrapping up CRT's initialization and code to unregister the CRT's FLS callback if an exception occurs during DLL startup. This exception handling around the entry point can cause a problem when **/GS** (buffer security checks) is used in a debug build. If you choose this option, exclude the exception handling (using `#if` or `#ifdef`) from debug builds. For DLLs that can't be rebuilt, there is currently no way to correct this behavior.

## More information

This behavior is caused by a failure to unregister an FLS callback into a module that has been unloaded, so it is caused not only by an unhandled exception during DLL CRT startup or shutdown, but also by setting up an FLS callback as shown below and not unregistering it before the DLL is unloaded:

```cpp
//TestDll.dll: To reproduce the problem, compile with static CRT (/MT or /MTd)
#include <Windows.h>

VOID WINAPI MyFlsCallback(PVOID lpFlsData)
{
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
{
    switch (ul_reason_for_call)
    {
         case DLL_PROCESS_ATTACH:
         {
             //Leaking FLS callback and rather setting an invalid callback.
             DWORD dwFlsIndex = FlsAlloc(MyFlsCallback);
             FlsSetValue(dwFlsIndex, (PVOID)5);
             break;
         }
    }
    return TRUE;
}

//TestExe.exe:
#include <Windows.h>
#include <stdio.h>

int main(int argc, TCHAR* argv[])
{
     HMODULE hModule = LoadLibrary(TEXT("TestDll.dll"));
     printf("GetLastError = %d \n", GetLastError());
     if (hModule != NULL)
     FreeLibrary(hModule);
     return 0;
     //Access Violation will occur following the above return statement
}
```

As the FLS callback function is supposed to be called by OS to perform FLS cleanup, the above invalid function pointer will result in Access Violation exception. Therefore, the ideal resolution to this issue would be to correct the code itself, ensuring that the FLS callback is unregistered before the DLL is unloaded.

> [!NOTE]
> There may be third-party products registered on the runtime machine that will inject DLLs at runtime into most processes. In such cases, an affected DLL outside of your product development may lead to this error during thread exit. If you are not in a position to rebuild such DLLs according to the guidance suggested above, your only option may be to contact the vendor of the product and request such a fix, or to uninstall the third-party product.
