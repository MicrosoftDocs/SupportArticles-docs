---
title: Linker warning when building managed extension
description: Describes that you receive error messages at compile time or at link time. Provides a solution to resolve this problem.
ms.date: 04/20/2020
ms.custom: sap:Language or Compilers\C++
---
# You receive linker warnings when you build managed extensions for C++ DLL projects

This article provides information about resolving linker warnings when you build managed extensions for C++ DLL projects.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 814472

## Symptoms

You receive one of the following error messages at compile time or at link time:

> Linker Tools Error LNK2001  
> 'unresolved external symbol "symbol" '  
> Linker Tools Warning LNK4210  
> '.CRT section exists; there may be unhandled static initializes or teminators'You receive Linker Warnings when you build Managed Extensions for C++ DLL projects  
> Linker Tools Warning LNK4243  
> 'DLL containing objects compiled with /clr is not linked with /NOENTRY; image may not run correctly'.

These warnings may occur during the following circumstances:

- When you compile linking objects with the **/clr** switch.
- When you are building one of the following projects:
  - ASP.NET Web Service Template
  - Class Library Template
  - Windows Control Library Template
- When you have added code that uses global variables or native classes (that is, not `__gc`or `__value`) with static data members. For example, the ActiveX Template Library (ATL), Microsoft Foundation Classes (MFC), and the C Run-Time (CRT) classes.

> [!NOTE]
> You may receive the LNK2001 and LNK4210 errors with projects that are not affected by the issue described in this article. However, the project definitely is affected by the issue described in this article if resolving a LNK2001 or LNK4210 warning leads to a LNK4243 warning, or if linking the project generates a LNK4243 warning.

## Cause

The following projects are created by default as a dynamic link library (DLL) without any linkage to native libraries (such as the CRT, ATL, or MFC), and without any global variables or native classes with static data members:

- ASP.NET Web Service Template
- Class Library Template
- Windows Control Library Template

If you add code that uses global variables or native classes with static data members (for example, the ATL, MFC, and CRT libraries use global variables), you will receive linker error messages at compile time. When this occurs, you must add code to manually initialize the static variables. For more information about how to do this, see the [Resolution](#resolution) section of this article.

For convenience, this article refers to global variables and static data members of native classes as *statics* or *static variables* from this point forward.

This problem is caused by the mixed DLL loading problem. Mixed DLLs (that is, DLLs that contain both managed and native code) can encounter deadlock scenarios under some circumstances when they are loaded into the process address space, especially when the system is under stress. The linker error messages mentioned earlier were enabled in the linker to make sure that customers are aware of the potential for deadlock and the workarounds that are described in this document.

## Resolution

Managed extensions for C++ projects that are created as DLLs by default do not link to native C/C++ libraries such as the C run-time (CRT) library, ATL, or MFC and do not use any static variables. Additionally, the project settings specify that the DLLs should be linked with the **/NOENTRY** option enabled.

This is done because linking with an entry point causes managed code to run during `DllMain`, which is not safe (see `DllMain` for the limited set of things you can do during its scope).

A DLL without an entry point has no way to initialize static variables except for simple types such as integers. You don't typically have static variables in a **/NOENTRY** DLL.

The ATL, MFC, and CRT libraries all rely on static variables, so you also cannot use these libraries from within these DLLs without first making modifications.

If your mixed-mode DLL needs to use statics or libraries that depend on statics (such as ATL, MFC, or CRT), then you must modify your DLL so that the statics is manually initialized.

The first step to manual initialization is to make sure that you disable the automatic initialization code, which is unsafe with mixed DLLs and can cause deadlock. To disable the initialization code, follow the steps.

## Remove the entry point of the managed DLL

1. Link with **/NOENTRY**. In Solution Explorer, right-click the project node, click **Properties**. In the **Property Pages** dialog box, click **Linker**, click **Command Line**, and then add this switch to the **Additional Options** field.
2. Link *msvcrt.lib*. In the **Property Pages** dialog box, click **Linker**, click **Input**, and then add *msvcrt.lib* to the **Additional Dependencies** property.
3. Remove *nochkclr.obj*. On the **Input** page (same page as in the previous step), remove *nochkclr.obj* from the **Additional Dependencies** property.
4. Link in the CRT. On the **Input** page (same page as in the previous step), add *__DllMainCRTStartup@12* to the **Force Symbol References** property.

    If you are using the command prompt, specify the above project settings with the following:

    ```console
    LINK /NOENTRY msvcrt.lib /NODEFAULTLIB:nochkclr.obj /INCLUDE:__DllMainCRTStartup@12
    ```

## Modify components that consume the DLL for manual initialization

After you remove the explicit entry point, you must modify components that consume the DLL for manual initialization, depending on the way that your DLL is implemented:

- Your DLL is entered using DLL exports (`__declspec(dllexport)`), and your consumers cannot use managed code if they are linked statically or dynamically to your DLL.
- Your DLL is a COM-based DLL.
- Consumers of your DLL can use managed code, and your DLL contains either DLL exports or managed entry points.

## Modify DLLs that you enter by using DLL exports and consumers that can't use managed code

To modify DLLs that you enter by using dll exports (`__declspec(dllexport)`) and consumers that cannot use managed code, follow these steps:

1. Add two new exports to your DLL, as shown in the following code:

    ```cpp
    // init.cpp
    #include <windows.h>
    #include <_vcclrit.h>
    // Call this function before you call anything in this DLL.
    // It is safe to call from multiple threads; it is not reference
    // counted; and is reentrancy safe.
    __declspec(dllexport) void __cdecl DllEnsureInit(void)
    {
        // Do nothing else here. If you need extra initialization steps,
        // create static objects with constructors that perform initialization.
        __crt_dll_initialize();
        // Do nothing else here.
    }
    // Call this function after this whole process is totally done
    // calling anything in this DLL. It is safe to call from multiple
    // threads; is not reference counted; and is reentrancy safe.
    // First call will terminate.
    __declspec(dllexport) void __cdecl DllForceTerm(void)
    {
        // Do nothing else here. If you need extra terminate steps, 
        // use atexit.
        __crt_dll_terminate();
        // Do nothing else here.
    }
    ```

    To add the common language runtime support compiler option, follow these steps:

    1. Click **Project**, and then click **ProjectName Properties**.

        > [!NOTE]
        > *ProjectName* is a placeholder for the name of the project.

    2. Expand **Configuration Properties**, and then click **General**.
    3. In the right pane, click to select **Common Language Runtime Support, Old Syntax (/clr:oldSyntax)** in the **Common Language Runtime support** project settings.
    4. Click **Apply**, and then click **OK**.

    For more information about common language runtime support compiler options, see [/clr (Common Language Runtime Compilation)](/cpp/build/reference/clr-common-language-runtime-compilation?view=vs-2019&preserve-view=true).

    These steps apply to the whole article.

2. Your DLL can have several consumers. If it does have multiple consumers, add the following code to the DLL .def file in the exports section:

    ```cpp
    DllEnsureInitPRIVATE
    DllForceTermPRIVATE
    ```

    If you don't add these lines, and if you have two DLLs that export functions, the application that links to the DLL will have link errors. Typically, the exported functions have the same names. In a multiconsumer case, each consumer can be linked statically or dynamically to your DLL.

3. If the consumer is statically linked to the DLL, before you use the DLL the first time, or before you use anything that depends on it in your application, add the following call:

    ```cpp
    // Snippet 1
    typedef void (__stdcall *pfnEnsureInit)(void);
    typedef void (__stdcall *pfnForceTerm)(void);
    {
        // ... initialization code
        HANDLE hDll=::GetModuleHandle("mydll.dll");
        If(!hDll)
        {
            // Exit, return; there is nothing else to do.
        }
        pfnEnsureInit pfnDll=::( pfnEnsureInit) GetProcAddress(hDll,
         "DllEnsureInit");
        if(!pfnDll)
        {
            // Exit, return; there is nothing else to do.
        }
        pfnDll();
        // ... more initialization code
    }
    ```

4. After the last use of the DLL in your application, add the following code:

    ```cpp
    // Snippet 2
    {
        // ... termination code
        HANDLE hDll=::GetModuleHandle("mydll.dll");
        If(!hDll)
        {
            // exit, return; there is nothing else to do
        }
        pfnForceTerm pfnDll=::( pfnForceTerm) GetProcAddress(hDll,
         "DllForceTerm");
        if(!pfnDll)
        {
            // exit, return; there is nothing else to do
        }
        pfnDll();
        // ... more termination code
    }
    ```

5. If the consumer is dynamically linked to the DLL, insert code as follows:

    - Insert snippet 1 (see step 3) immediately after the first LoadLibrary for the DLL.
    - Insert snippet 2 (see step 4) immediately before the last FreeLibrary for the DLL.

## Modify COM-based DLLs

Modify the DLL export functions `DllCanUnloadNow`, `DllGetClassObject`, `DllRegisterServer`, and `DllUnregisterServer` as demonstrated in the following code:

```cpp
// Implementation of DLL Exports.
#include <_vcclrit.h>
STDAPI DllCanUnloadNow(void)
{
    if ( _Module.GetLockCount() == 0 )
    {
        __crt_dll_terminate();
        return S_OK;
    }
    else
    {
        return S_FALSE;
    }
}

STDAPI DllGetClassObject(REFCLSID rclsid, REFIID riid, LPVOID* ppv)
{
    if ( !( __crt_dll_initialize()) )
    {
        return E_FAIL;
    }
    else
    {
        return _Module.GetClassObject(rclsid, riid, ppv);
    }
}

STDAPI DllRegisterServer(void)
{
    if ( !( __crt_dll_initialize()) )
    {
        return E_FAIL;
    }
    // Call your registration code here
    HRESULT hr = _Module.RegisterServer(TRUE)
    return hr;
}

STDAPI DllUnregisterServer(void)
{
    HRESULT hr = S_OK;
    __crt_dll_terminate();
    // Call your unregistration code here
    hr = _Module.UnregisterServer(TRUE);
    return hr;
}
```

## Modify DLL that contains consumers that use managed code and DLL exports or managed entry points

To modify DLL that contains consumers that use managed code and dll exports or managed entry points, follow these steps:

1. Implement a managed class with static member functions for initialization and termination. Add a .cpp file to your project, implementing a managed class with static members for initialization and termination:

    ```cpp
    // ManagedWrapper.cpp
    // This code verifies that DllMain is not automatically called
    // by the Loader when linked with /noentry. It also checks some
    // functions that the CRT initializes.

    #include <windows.h>
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include <math.h>
    #include "_vcclrit.h"

    #using <mscorlib.dll>
    using namespace System;
    public __gc class ManagedWrapper
    {
        public:
        static BOOL minitialize()
        {
            BOOL retval = TRUE;
            try
            {
                retval = __crt_dll_initialize();
            } catch(System::Exception* e)
            {
                Console::WriteLine(e->Message);
                retval = FALSE;
            }
            return retval;
        }
        static BOOL mterminate()
        {
            BOOL retval = TRUE;
            try
            {
                retval = __crt_dll_terminate();
            } catch(System::Exception* e)
            {
                Console::WriteLine(e->Message);
                retval = FALSE;
            }
            return retval;
        }
    };

    BOOL WINAPI DllMain(HINSTANCE hModule, DWORD dwReason, LPVOID
    lpvReserved)
    {
        Console::WriteLine(S"DllMain is called...");
        return TRUE;
    } /* DllMain */
    ```

2. Call these functions before you refer to the DLL and after you have finished using it. Call the initialization and termination member functions in `main`:

    ```cpp
    // Main.cpp

    #using <mscorlib.dll>
    using namespace System;
    using namespace System::Reflection;
    #using "ijwdll.dll";

    int main()
    {
        int retval = ManagedWrapper::minitialize();
        ManagedWrapper::mterminate();
    }
    ```
