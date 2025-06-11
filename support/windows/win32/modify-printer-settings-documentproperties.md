---
title: Modify printer settings with the DocumentProperties
description: This article describes how to modify printer settings with the DocumentProperties function.
ms.date: 06/11/2025
ms.custom: sap:Graphics and Multimedia development\Printing and the Print Spooler API
---

# Modify printer settings with the DocumentProperties() Function

This article shows how to modify printer settings with the `DocumentProperties()` function.

_Original product version:_ &nbsp; Printer  
_Original KB number:_ &nbsp; 167345

## Summary

Using a DEVMODE structure to modify printer settings is more difficult than just changing the fields of the structure. Specifically, a valid DEVMODE structure for a device contains private data that can only be modified by the `DocumentProperties()` function.

This article explains how to modify the contents of a DEVMODE structure with the `DocumentProperties()` function.

## More information

A DEVMODE structure, as documented by the Win32 SDK, contains public or 'device independent data' and private or 'device dependent data'. The private part of a DEVMODE exists immediately following the public part, which is defined by the DEVMODE structure, in a contiguous buffer of memory.

A program cannot predict the size of this buffer because it is different from printer to printer and from version to version of printer driver. Additionally, a DEVMODE structure that is declared by a program does not contain enough space for private device data. If a DEVMODE buffer that lacks private data is passed to functions such as `CreateDC()`, `ResetDC()`, and `DocumentProperties()`, the function may fail.

To reliably use a DEVMODE with a device driver, create and modify it by following these steps:

1. Determine the required size of the buffer from the device, and then allocate enough memory for it.

    `DocumentProperties()` returns the number of bytes that are required for a DEVMODE buffer when the last parameter is set to 0. The sample code in this article uses this technique to determine the correct size of the buffer. The sample code then uses the C run-time memory allocation function of `malloc()` to allocate a buffer that is large enough. Because `DocumentProperties()` and functions like `ResetDC()` and `CreateDC()` take pointers to a DEVMODE as a parameter, most applications can allocate memory that is addressed by a pointer.

    However, functions such as the common `PrintDlg()` take parameters that are needed to be handles to global memory. If a program uses the final DEVMODE buffer as a parameter to one of these functions, it should allocate memory using `GlobalAlloc()` and obtain a pointer to the buffer using `GlobalLock()`.
2. Ask the device driver to initialize the DEVMODE buffer with the default settings.

    The sample code calls `DocumentProperties()` a second time to initialize the allocated buffer with the current default settings. `DocumentProperties()` fills the buffer referred to as the *pDevModeOutput* parameter with the printer's current settings when the `DM_OUT_BUFFER` command is passed in the fMode parameter.

3. Make changes to the public portion of the DEVMODE and ask the device driver to merge the changes into the private portion of the DEVMODE by calling `DocumentProperties()`.

    After initializing the buffer with current settings in step 2, the sample code makes changes to the public part of the DEVMODE. See the Win32 SDK documentation for descriptions of the DEVMODE members. This sample code determines whether the printer can use orientation and duplex (double-sided) settings and changes them appropriately.

    > [!NOTE]
    > A flag in a DEVMODE's dmFields member is only an indication that a printer uses the associated structure member. Printers have a variety of different physical characteristics and, therefore, may only support a subset of a DEVMODE's documented capabilities. To determine the supported settings of a DEVMODE's field, applications should use `DeviceCapabilities()`.

    The sample code then makes a third call to `DocumentProperties()` and passes the DEVMODE buffer in both the pDevModeInput and pDevModeOutput parameters. It also passes the combined commands of DM_IN_BUFFER and DM_OUT_BUFFER in the fMode parameter by using the OR("|") operator. These commands tell the function to take whatever settings are contained in the input buffer and to merge them with the current settings for the device. Then it writes the result to the buffer specified in the out parameter.

> [!NOTE]
> `DocumentProperties()` refers to a specific printer by a handle to a printer: hPrinter. This handle is obtained from `OpenPrinter()`, which the sample code also illustrates. `OpenPrinter()` requires the name of a printer, which is typically the friendly name of the printer as it appears in the Operating System's shell. This name can be obtained from `EnumPrinters()`, from the DEVNAMES structure returned by `PrintDlg()`, or from the Default Printer.

In this article, the first two steps of allocating the correct size of buffer and initializing that buffer is performed with `DocumentProperties()`. You can also follow these steps by using `GetPrinter()`.

For more information and an example of this, see [Modify printer settings by using the SetPrinter function](modify-printer-settings-setprinter-api.md).

### Sample Code

The sample code follows these three steps for obtaining and changing the DEVMODE buffer. The function takes a named printer and configures a DEVMODE to print double-sided and in the landscape orientation if it supports these features. The resulting DEVMODE that is returned to the caller is suitable for other API calls that use DEVMODE buffers, such as `CreateDC()`, `SetPrinter()`, `PrintDlg()`, or `ResetDC()`. When the caller has completed using the DEVMODE buffer, the caller is responsible for freeing the memory.

```cpp
 LPDEVMODE GetLandscapeDevMode(HWND hWnd, char *pDevice)
 {
    HANDLE hPrinter;
    LPDEVMODE pDevMode;
    DWORD dwNeeded, dwRet;
    
    /* Start by opening the printer */ 
    if (!OpenPrinter(pDevice, &hPrinter, NULL))
        return NULL;
    
    /*
    * Step 1:
    * Allocate a buffer of the correct size.
    */ 
    dwNeeded = DocumentProperties(hWnd,
    hPrinter, /* Handle to our printer. */ 
    pDevice, /* Name of the printer. */ 
    NULL, /* Asking for size, so */ 
    NULL, /* these are not used. */ 
    0); /* Zero returns buffer size. */ 
    pDevMode = (LPDEVMODE)malloc(dwNeeded);
    
    /*
    * Step 2:
    * Get the default DevMode for the printer and
    * modify it for your needs.
    */ 
    dwRet = DocumentProperties(hWnd,
    hPrinter,
    pDevice,
    pDevMode, /* The address of the buffer to fill. */ 
    NULL, /* Not using the input buffer. */ 
    DM_OUT_BUFFER); /* Have the output buffer filled. */ 
    if (dwRet != IDOK)
    {
        /* If failure, cleanup and return failure. */ 
        free(pDevMode);
        ClosePrinter(hPrinter);
        return NULL;
    }
    
    /*
    * Make changes to the DevMode which are supported.
    */ 
    if (pDevMode->dmFields & DM_ORIENTATION)
    {
        /* If the printer supports paper orientation, set it.*/ 
        pDevMode->dmOrientation = DMORIENT_LANDSCAPE;
    }
    
    if (pDevMode->dmFields & DM_DUPLEX)
    {
        /* If it supports duplex printing, use it. */ 
        pDevMode->dmDuplex = DMDUP_HORIZONTAL;
    }
    
    /*
    * Step 3:
    * Merge the new settings with the old.
    * This gives the driver an opportunity to update any private
    * portions of the DevMode structure.
    */ 
    dwRet = DocumentProperties(hWnd,
    hPrinter,
    pDevice,
    pDevMode, /* Reuse our buffer for output. */ 
    pDevMode, /* Pass the driver our changes. */ 
    DM_IN_BUFFER | /* Commands to Merge our changes and */ 
    DM_OUT_BUFFER); /* write the result. */ 
    
    /* Finished with the printer */ 
    ClosePrinter(hPrinter);
    
    if (dwRet != IDOK)
    {
        /* If failure, cleanup and return failure. */ 
        free(pDevMode);
        return NULL;
    }
    
    /* Return the modified DevMode structure. */ 
    return pDevMode;
}
```
