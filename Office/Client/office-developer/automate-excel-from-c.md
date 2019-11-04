---
title: How to automate Excel from C++ without using MFC or #import
description: Explains how to automate Excel from C++ without using MFC or #import
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Excel
---

# How to automate Excel from C++ without using MFC or #import

## Summary

There are several advantages to writing your Automation code in straight C++. First and foremost, you can do exactly what you want. Next, your code will be smaller, faster, and easier to debug. And finally, you won't be dependent on any libraries. Even if you are dedicated to using MFC's wrapper classes or Visual C++'s native COM support (#import), you may still have to delve into the guts of IDispatch and COM Automation in order to work around common bugs and limitations with these frameworks.

## More Information

Follow the steps below to build a simple Visual C++ 6.0 console application that automates Microsoft Office Excel using just C++:

1. Start Visual C++ 6.0, and create a new Win32 Console Application named XlCpp. Choose a "Hello, World!" application base, and click **Finish**.
1. Open the generated XlCpp.cpp, and add the following code before the main() function.
    ```c
    #include <ole2.h> // OLE2 Definitions
    
    // AutoWrap() - Automation helper function...
    HRESULT AutoWrap(int autoType, VARIANT *pvResult, IDispatch *pDisp, LPOLESTR ptName, int cArgs...) {
        // Begin variable-argument list...
        va_list marker;
        va_start(marker, cArgs);
    
        if(!pDisp) {
            MessageBox(NULL, "NULL IDispatch passed to AutoWrap()", "Error", 0x10010);
            _exit(0);
        }
    
        // Variables used...
        DISPPARAMS dp = { NULL, NULL, 0, 0 };
        DISPID dispidNamed = DISPID_PROPERTYPUT;
        DISPID dispID;
        HRESULT hr;
        char buf[200];
        char szName[200];
    
        
        // Convert down to ANSI
        WideCharToMultiByte(CP_ACP, 0, ptName, -1, szName, 256, NULL, NULL);
        
        // Get DISPID for name passed...
        hr = pDisp->GetIDsOfNames(IID_NULL, &ptName, 1, LOCALE_USER_DEFAULT, &dispID);
        if(FAILED(hr)) {
            sprintf(buf, "IDispatch::GetIDsOfNames(\"%s\") failed w/err 0x%08lx", szName, hr);
            MessageBox(NULL, buf, "AutoWrap()", 0x10010);
            _exit(0);
            return hr;
        }
        
        // Allocate memory for arguments...
        VARIANT *pArgs = new VARIANT[cArgs+1];
        // Extract arguments...
        for(int i=0; i<cArgs; i++) {
            pArgs[i] = va_arg(marker, VARIANT);
        }
        
        // Build DISPPARAMS
        dp.cArgs = cArgs;
        dp.rgvarg = pArgs;
        
        // Handle special-case for property-puts!
        if(autoType & DISPATCH_PROPERTYPUT) {
            dp.cNamedArgs = 1;
            dp.rgdispidNamedArgs = &dispidNamed;
        }
        
        // Make the call!
        hr = pDisp->Invoke(dispID, IID_NULL, LOCALE_SYSTEM_DEFAULT, autoType, &dp, pvResult, NULL, NULL);
        if(FAILED(hr)) {
            sprintf(buf, "IDispatch::Invoke(\"%s\"=%08lx) failed w/err 0x%08lx", szName, dispID, hr);
            MessageBox(NULL, buf, "AutoWrap()", 0x10010);
            _exit(0);
            return hr;
        }
        // End variable-argument section...
        va_end(marker);
        
        delete [] pArgs;
        
        return hr;
    }
    ```
1. Inside the main() function, replace the printf() line with the following code.
    ```c
    // Initialize COM for this thread...
       CoInitialize(NULL);
    
       // Get CLSID for our server...
       CLSID clsid;
       HRESULT hr = CLSIDFromProgID(L"Excel.Application", &clsid);
    
       if(FAILED(hr)) {
    
          ::MessageBox(NULL, "CLSIDFromProgID() failed", "Error", 0x10010);
          return -1;
       }
    
       // Start server and get IDispatch...
       IDispatch *pXlApp;
       hr = CoCreateInstance(clsid, NULL, CLSCTX_LOCAL_SERVER, IID_IDispatch, (void **)&pXlApp);
       if(FAILED(hr)) {
          ::MessageBox(NULL, "Excel not registered properly", "Error", 0x10010);
          return -2;
       }
    
       // Make it visible (i.e. app.visible = 1)
       {
    
          VARIANT x;
          x.vt = VT_I4;
          x.lVal = 1;
          AutoWrap(DISPATCH_PROPERTYPUT, NULL, pXlApp, L"Visible", 1, x);
       }
    
       // Get Workbooks collection
       IDispatch *pXlBooks;
       {
          VARIANT result;
          VariantInit(&result);
          AutoWrap(DISPATCH_PROPERTYGET, &result, pXlApp, L"Workbooks", 0);
          pXlBooks = result.pdispVal;
       }
    
       // Call Workbooks.Add() to get a new workbook...
       IDispatch *pXlBook;
       {
          VARIANT result;
          VariantInit(&result);
          AutoWrap(DISPATCH_PROPERTYGET, &result, pXlBooks, L"Add", 0);
          pXlBook = result.pdispVal;
       }
    
       // Create a 15x15 safearray of variants...
       VARIANT arr;
       arr.vt = VT_ARRAY | VT_VARIANT;
       {
          SAFEARRAYBOUND sab[2];
          sab[0].lLbound = 1; sab[0].cElements = 15;
          sab[1].lLbound = 1; sab[1].cElements = 15;
          arr.parray = SafeArrayCreate(VT_VARIANT, 2, sab);
       }
    
       // Fill safearray with some values...
       for(int i=1; i<=15; i++) {
          for(int j=1; j<=15; j++) {
             // Create entry value for (i,j)
             VARIANT tmp;
             tmp.vt = VT_I4;
             tmp.lVal = i*j;
             // Add to safearray...
             long indices[] = {i,j};
             SafeArrayPutElement(arr.parray, indices, (void *)&tmp);
          }
       }
    
       // Get ActiveSheet object
       IDispatch *pXlSheet;
       {
          VARIANT result;
          VariantInit(&result);
          AutoWrap(DISPATCH_PROPERTYGET, &result, pXlApp, L"ActiveSheet", 0);
          pXlSheet = result.pdispVal;
       }
    
       // Get Range object for the Range A1:O15...
       IDispatch *pXlRange;
       {
          VARIANT parm;
          parm.vt = VT_BSTR;
          parm.bstrVal = ::SysAllocString(L"A1:O15");
    
          VARIANT result;
          VariantInit(&result);
          AutoWrap(DISPATCH_PROPERTYGET, &result, pXlSheet, L"Range", 1, parm);
          VariantClear(&parm);
    
          pXlRange = result.pdispVal;
       }
    
       // Set range with our safearray...
       AutoWrap(DISPATCH_PROPERTYPUT, NULL, pXlRange, L"Value", 1, arr);
    
       // Wait for user...
       ::MessageBox(NULL, "All done.", "Notice", 0x10000);
    
       // Set .Saved property of workbook to TRUE so we aren't prompted
       // to save when we tell Excel to quit...
       {
          VARIANT x;
          x.vt = VT_I4;
          x.lVal = 1;
          AutoWrap(DISPATCH_PROPERTYPUT, NULL, pXlBook, L"Saved", 1, x);
       }
    
       // Tell Excel to quit (i.e. App.Quit)
       AutoWrap(DISPATCH_METHOD, NULL, pXlApp, L"Quit", 0);
    
       // Release references...
       pXlRange->Release();
       pXlSheet->Release();
       pXlBook->Release();
       pXlBooks->Release();
       pXlApp->Release();
       VariantClear(&arr);
    
       // Uninitialize COM for this thread...
       CoUninitialize();
    ```
1. Compile and run.

The AutoWrap() function simplifies most of the low-level details involved with using IDispatch directly. Feel free to use it in your own implementations. One caveat is that if you pass multiple parameters, they need to be passed in reverse-order. For example:

```c
    VARIANT parm[3];
    parm[0].vt = VT_I4; parm[0].lVal = 1;
    parm[1].vt = VT_I4; parm[1].lVal = 2;
    parm[2].vt = VT_I4; parm[2].lVal = 3;
    AutoWrap(DISPATCH_METHOD, NULL, pDisp, L"call", 3, parm[2], parm[1], parm[0]);
```

## References

For more information about automating Office by using Visual C++, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[196776](https://support.microsoft.com/help/196776) Office Automation using Visual C++

(c) Microsoft Corporation 1999, All Rights Reserved. Contributions by Joe Crump, Microsoft Corporation.