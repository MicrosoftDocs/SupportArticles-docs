---
title: Modify printer settings by SetPrinter API
description: This article introduces that you should do some preparations to properly call SetPrinter API.
ms.date: 03/09/2020
ms.custom: sap:Graphics and multimedia development
ms.reviewer: kayda
ms.topic: how-to
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# Modify printer settings by using the SetPrinter function

The `SetPrinter` function allows applications to change various printer attributes. However, as the code in this article demonstrates, a certain amount of preparation is necessary to correctly call `SetPrinter`.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 140285

## hPrinter parameter for SetPrinter

The first parameter is a handle to the printer whose settings are to be changed. This parameter should be retrieved from `OpenPrinter()`.

## dwLevel parameter for SetPrinter

The second parameter specifies the structure of the data being passed to `SetPrinter()`. The parameter value can be **0**, **2**, **3**, **4**,**5**, **6**, **7**, **8**, or **9**.

## lpbPrinter parameter for SetPrinter

The third parameter is a `PRINTER_INFO_n` structure where `n` corresponds to the number in the second parameter. This structure can cause confusion because it isn't simply a buffer of the size of the structure. These structures contain device-independent information but are immediately followed in memory by some variable amount of device-dependent information, which is given by the device driver. Therefore, a little work is involved to determine how significant this buffer should be. This is achieved by calling `GetPrinter()`, which will set `pcbNeeded` to the total size needed.

Also, the buffer typically has a large amount of device-independent and device-dependent information in it. Your application is not going to know or care about the values in most of these structure members. So, when you make the changes in which you are interested, you must plug in the correct values for all of these other pieces of data. These other pieces of data are set when you call `GetPrinter()` a second time.

## DwCommand parameter for SetPrinter

The fourth parameter is used to pause printing, resume printing, or clear all print jobs. This parameter is typically not used at the same time as `lpbPrinter` is used. This article is not concerned with setting the printer state, so the sample code sets this parameter to zero.

## About DEVMODE

Often, an element of the `DEVMODE` structure pointed to by `pDevMode` will be modified (instead of an element of `PRINTER_INFO_n`). When this is the case, the `pDevMode->dmFields` flags will tell the application which fields can be changed. Because this is given to you by `GetPrinter()`, you can check the `dmFields` flag before attempting the change.

Also, because modifying fields in the device-independent part of `DEVMODE` may also effect changes in the device-dependent part, you need to call `DocumentProperties()` before calling `SetPrinter()` in order to make a consistent `DEVMODE` structure for `SetPrinter()`.

## Sample Code

```cpp
// MySetPrinter
// Demonstrates how to use the SetPrinter API.  This particular function changes the orientation
// for the printer specified in pPrinterName to the orientation specified in dmOrientation.
// Valid values for dmOrientation are:
// DMORIENT_PORTRAIT (1) or DMORIENT_LANDSCAPE (2)
BOOL MySetPrinter(LPTSTR pPrinterName, short dmOrientation)
{
    HANDLE hPrinter = NULL;
    DWORD dwNeeded = 0;
    PRINTER_INFO_2 *pi2 = NULL;
    DEVMODE *pDevMode = NULL;
    PRINTER_DEFAULTS pd;
    BOOL bFlag;
    LONG lFlag;

    // Open printer handle (on Windows NT, you need full-access because you
    // will eventually use SetPrinter)...
    ZeroMemory(&pd, sizeof(pd));
    pd.DesiredAccess = PRINTER_ALL_ACCESS;
    bFlag = OpenPrinter(pPrinterName, &hPrinter, &pd);
    if (!bFlag || (hPrinter == NULL))
        return FALSE;

    // The first GetPrinter tells you how big the buffer should be in
    // order to hold all of PRINTER_INFO_2. Note that this should fail with
    // ERROR_INSUFFICIENT_BUFFER.  If GetPrinter fails for any other reason
    // or dwNeeded isn't set for some reason, then there is a problem...
    SetLastError(0);
    bFlag = GetPrinter(hPrinter, 2, 0, 0, &dwNeeded);
    if ((!bFlag) && (GetLastError() != ERROR_INSUFFICIENT_BUFFER) || (dwNeeded == 0))
    {
        ClosePrinter(hPrinter);
        return FALSE;
    }

    // Allocate enough space for PRINTER_INFO_2...
    pi2 = (PRINTER_INFO_2 *)GlobalAlloc(GPTR, dwNeeded);
    if (pi2 == NULL)
    {
        ClosePrinter(hPrinter);
        return FALSE;
    }

    // The second GetPrinter fills in all the current settings, so all you
    // need to do is modify what you're interested in...
    bFlag = GetPrinter(hPrinter, 2, (LPBYTE)pi2, dwNeeded, &dwNeeded);
    if (!bFlag)
    {
        GlobalFree(pi2);
        ClosePrinter(hPrinter);
        return FALSE;
    }

    // If GetPrinter didn't fill in the DEVMODE, try to get it by calling
    // DocumentProperties...
    if (pi2->pDevMode == NULL)
    {
        dwNeeded = DocumentProperties(NULL, hPrinter,
        pPrinterName,
        NULL, NULL, 0);
        if (dwNeeded <= 0)
        {
            GlobalFree(pi2);
            ClosePrinter(hPrinter);
            return FALSE;
        }

        pDevMode = (DEVMODE *)GlobalAlloc(GPTR, dwNeeded);
        if (pDevMode == NULL)
        {
            GlobalFree(pi2);
            ClosePrinter(hPrinter);
            return FALSE;
        }

        lFlag = DocumentProperties(NULL, hPrinter,
        pPrinterName,
        pDevMode, NULL,
        DM_OUT_BUFFER);
        if (lFlag != IDOK || pDevMode == NULL)
        {
            GlobalFree(pDevMode);
            GlobalFree(pi2);
            ClosePrinter(hPrinter);
            return FALSE;
        }
        pi2->pDevMode = pDevMode;
    }

    // Driver is reporting that it doesn't support this change...
    if (!(pi2->pDevMode->dmFields & DM_ORIENTATION))
    {
        GlobalFree(pi2);
        ClosePrinter(hPrinter);
        if (pDevMode)
        GlobalFree(pDevMode);
        return FALSE;
    }

    // Specify exactly what we are attempting to change...
    pi2->pDevMode->dmFields = DM_ORIENTATION;
    pi2->pDevMode->dmOrientation = dmOrientation;

    // Do not attempt to set security descriptor...
    pi2->pSecurityDescriptor = NULL;

    // Make sure the driver-dependent part of devmode is updated...
    lFlag = DocumentProperties(NULL, hPrinter,
      pPrinterName,
      pi2->pDevMode, pi2->pDevMode,
      DM_IN_BUFFER | DM_OUT_BUFFER);
    if (lFlag != IDOK)
    {
        GlobalFree(pi2);
        ClosePrinter(hPrinter);
        if (pDevMode)
            GlobalFree(pDevMode);
        return FALSE;
    }

    // Update printer information...
    bFlag = SetPrinter(hPrinter, 2, (LPBYTE)pi2, 0);
    if (!bFlag)
    // The driver doesn't support, or it is unable to make the change...
    {
        GlobalFree(pi2);
        ClosePrinter(hPrinter);
        if (pDevMode)
            GlobalFree(pDevMode);
        return FALSE;
    }

    // Tell other apps that there was a change...
    SendMessageTimeout(HWND_BROADCAST, WM_DEVMODECHANGE, 0L,
      (LPARAM)(LPCSTR)pPrinterName,
      SMTO_NORMAL, 1000, NULL);

    // Clean up...
    if (pi2)
        GlobalFree(pi2);
    if (hPrinter)
        ClosePrinter(hPrinter);
    if (pDevMode)
        GlobalFree(pDevMode);
    return TRUE;
}
```
