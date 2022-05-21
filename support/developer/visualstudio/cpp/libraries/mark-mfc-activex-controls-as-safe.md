---
title: Mark MFC ActiveX controls as safe
description: This article describes how to mark MFC ActiveX controls as safe for Scripting and Initialization.
ms.date: 10/27/2020
ms.custom: sap:C and C++ Libraries
ms.topic: how-to
---
# Mark MFC ActiveX controls as Safe for Scripting and Initialization

This article describes how to mark MFC ActiveX controls as Safe for Scripting and Initialization.

_Original product version:_ &nbsp; MFC ActiveX controls  
_Original KB number:_ &nbsp; 161873

## Summary

By default, MFC ActiveX controls are not marked as Safe for Scripting and Safe for Initialization. This becomes apparent when the control is run in the Internet Explorer with the security level set to medium or high. In either of these modes, warnings may be displayed that the control's data is not safe or that the control may not be safe for scripts to use.

There are two methods that a control can use to eliminate these errors. The first involves the control implementing the `IObjectSafety` interface and is useful for controls that would like to change their behavior and become safe if run in the context of an Internet Browser. The second involves modifying the control's `DllRegisterServer` function to mark the control safe in the registry. This article covers the second of these methods. The first method, implementing the `IObjectSafety` interface, is covered in the Internet Client SDK.

Keep in mind that a control should only be marked as safe if it is, in fact, safe. Refer to the Internet Client SDK documentation for a description of this. See **Safe Initialization and Scripting for ActiveX Controls** under the Component Development Section.

> [!NOTE]
> This article does not cover how to mark a control safe for downloading. For more information on code download and code signing, please refer to the Internet Client SDK.

## More information

Follow these steps to mark your MFC ActiveX Control as Safe for Scripting and Safe for Initializing:

1. Implement the `CreateComponentCategory` and `RegisterCLSIDInCategory` helper functions by adding the following cathelp.h and cathelp.cpp files to your project.

    - Cathelp.h

        ```cpp
        #include "comcat.h"

        // Helper function to create a component category and associated
        // description
        HRESULT CreateComponentCategory(CATID catid, WCHAR* catDescription);

        // Helper function to register a CLSID as belonging to a component
        // category
        HRESULT RegisterCLSIDInCategory(REFCLSID clsid, CATID catid);
        ```

    - Cathelp.cpp

        ```cpp
        #include "comcat.h"

        // Helper function to create a component category and associated
        // description
        HRESULT CreateComponentCategory(CATID catid, WCHAR* catDescription)
        {
            ICatRegister* pcr = NULL ;
            HRESULT hr = S_OK ;

            hr = CoCreateInstance(CLSID_StdComponentCategoriesMgr,
            NULL,
            CLSCTX_INPROC_SERVER,
            IID_ICatRegister,
            (void**)&pcr);
            if (FAILED(hr))
            return hr;

            // Make sure the HKCR\Component Categories\{..catid...}
            // key is registered
            CATEGORYINFO catinfo;
            catinfo.catid = catid;
            catinfo.lcid = 0x0409 ; // english

            // Make sure the provided description is not too long.
            // Only copy the first 127 characters if it is
            int len = wcslen(catDescription);
            if (len>127)
            len = 127;
            wcsncpy(catinfo.szDescription, catDescription, len);
            // Make sure the description is null terminated
            catinfo.szDescription[len] = '\0';

            hr = pcr->RegisterCategories(1, &catinfo);
            pcr->Release();

            return hr;
        }

        // Helper function to register a CLSID as belonging to a component
        // category
        HRESULT RegisterCLSIDInCategory(REFCLSID clsid, CATID catid)
        {
            // Register your component categories information.
            ICatRegister* pcr = NULL ;
            HRESULT hr = S_OK ;
            hr = CoCreateInstance(CLSID_StdComponentCategoriesMgr,
            NULL,
            CLSCTX_INPROC_SERVER,
            IID_ICatRegister,
            (void**)&pcr);
            if (SUCCEEDED(hr))
            {
                // Register this category as being "implemented" by
                // the class.
                CATID rgcatid[1] ;
                rgcatid[0] = catid;
                hr = pcr->RegisterClassImplCategories(clsid, 1, rgcatid);
            }

            if (pcr != NULL)
            pcr->Release();

            return hr;
        }
        ```

2. Modify the `DllRegisterServer` to mark the control as safe. Locate the implementation of `DllRegisterServer` in a .cpp file in your project. You will need to add several things to this .cpp file. Include the file that implements `CreateComponentCategory` and `RegisterCLSIDInCategory`:

    ```cpp
    #include "CatHelp.h"
    ```

    Define the GUID associated with the safety component categories:

    ```cpp
    const CATID CATID_SafeForScripting =
    {0x7dd95801,0x9882,0x11cf,{0x9f,0xa9,0x00,0xaa,0x00,0x6c,0x42,0xc4 }} ;
    const CATID CATID_SafeForInitializing =
    {0x7dd95802,0x9882,0x11cf,{0x9f,0xa9,0x00,0xaa,0x00,0x6c,0x42,0xc4 }} ;
    ```

    Define the GUID associated with your control. For simplicity, you can borrow the GUID from the `IMPLEMENT_OLECREATE_EX` macro in the main .cpp file for the control. Adjust the format slightly so that it looks like the following:

    ```cpp
    const GUID CDECL BASED_CODE _ctlid =
    { 0x43bd9e45, 0x328f, 0x11d0,
    { 0xa6, 0xb9, 0x0, 0xaa, 0x0, 0xa7, 0xf, 0xc2 } };
    ```

    To mark your control as both Safe for Scripting and Initialization, modify the `DllRegisterServer` function as follows:

    ```cpp
    STDAPI DllRegisterServer(void)
    {
        AFX_MANAGE_STATE(_afxModuleAddrThis);

        if (!AfxOleRegisterTypeLib(AfxGetInstanceHandle(), _tlid))
        return ResultFromScode(SELFREG_E_TYPELIB);

        if (!COleObjectFactoryEx::UpdateRegistryAll(TRUE))
        return ResultFromScode(SELFREG_E_CLASS);

        if (FAILED( CreateComponentCategory(
        CATID_SafeForScripting,
        L"Controls that are safely scriptable")))
        return ResultFromScode(SELFREG_E_CLASS);

        if (FAILED( CreateComponentCategory(
        CATID_SafeForInitializing,
        L"Controls safely initializable from persistent data")))
        return ResultFromScode(SELFREG_E_CLASS);

        if (FAILED( RegisterCLSIDInCategory(
        _ctlid, CATID_SafeForScripting)))
        return ResultFromScode(SELFREG_E_CLASS);

        if (FAILED( RegisterCLSIDInCategory(
        _ctlid, CATID_SafeForInitializing)))
        return ResultFromScode(SELFREG_E_CLASS);

        return NOERROR;
    }
    ```

    You would not normally modify the `DllUnregisterServer` function for these two reasons:

    - You would not want to remove a component category because other controls may be using it.

    - Although there is an `UnRegisterCLSIDInCategory` function defined, by default `DllUnregisterServer` removes the control's entry from the registry entirely. Therefore, removing the category from the control's registration is of little use.

    After compiling and registering your control, you should find the following entries in the registry:

    - `HKEY_CLASSES_ROOT\Component Categories\{7DD95801-9882-11CF-9FA9-00AA006C42C4}`

    - `HKEY_CLASSES_ROOT\Component Categories\{7DD95802-9882-11CF-9FA9-00AA006C42C4}`

    - `HKEY_CLASSES_ROOT\CLSID\{"your controls GUID"}\Implemented Categories\{7DD95801-9882-11CF-9FA9-00AA006C42C4}`

    - `HKEY_CLASSES_ROOT\CLSID\{"your controls GUID"}\Implemented Categories\{7DD95802-9882-11CF-9FA9-00AA006C42C4}`

## References

Internet Client SDK - Component Development - Safe Initialization and Scripting for ActiveX Controls
