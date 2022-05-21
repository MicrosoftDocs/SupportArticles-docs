---
title: Send raw data to printers by using Win32 API
description: This article introduces how to send Raw Data to a Printer by using the Win32 API.
ms.date: 02/28/2020
ms.reviewer: jhornick
ms.topic: how-to
ms.custom: sap:Developer Tools
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# Send raw data to a printer by using the Win32 API

This article introduces how to send raw data to a printer by using the Win32 API.

_Original product version:_ &nbsp; Windows API  
_Original KB number:_ &nbsp; 138594

## Summary

It's sometimes necessary to send printer-specific data directly to a printer, bypassing the driver. The Win32 API provides a do it that works on local and networked printers. This method can be used to replace the `PASSTHROUGH` escape and `SpoolFile()` methods that are used in previous versions of the Windows API.

## Code sample

You can use the following code to send raw data directly to a printer in Windows NT or Windows 95.

```cpp
// RawDataToPrinter - sends binary data directly to a printer
// Params:
//   szPrinterName - NULL terminated string specifying printer name
//   lpData        - Pointer to raw data bytes
//   dwCount       - Length of lpData in bytes
// Returns: TRUE for success, FALSE for failure.
BOOL RawDataToPrinter(LPSTR szPrinterName, LPBYTE lpData, DWORD dwCount)
{
    HANDLE     hPrinter;
    DOC_INFO_1 DocInfo;
    DWORD      dwJob;
    DWORD      dwBytesWritten;

    // Need a handle to the printer.
    if(!OpenPrinter( szPrinterName, &hPrinter, NULL))
    return FALSE;

    // Fill in the structure with info about this "document."
    DocInfo.pDocName = "My Document";
    DocInfo.pOutputFile = NULL;
    DocInfo.pDatatype = "RAW";
    // Inform the spooler the document is beginning.
    if((dwJob = StartDocPrinter(hPrinter, 1, (LPSTR)&DocInfo)) == 0)
    {
      ClosePrinter(hPrinter);
      return FALSE;
    }
    // Start a page.
    if(!StartPagePrinter(hPrinter))
    {
      EndDocPrinter(hPrinter);
      ClosePrinter(hPrinter);
      return FALSE;
    }
    // Send the data to the printer.
    if(!WritePrinter(hPrinter, lpData, dwCount, &dwBytesWritten))
    {
      EndPagePrinter(hPrinter);
      EndDocPrinter(hPrinter);
      ClosePrinter(hPrinter);
      return FALSE;
    }
    // End the page.
    if(!EndPagePrinter(hPrinter))
    {
      EndDocPrinter(hPrinter);
      ClosePrinter(hPrinter);
      return FALSE;
    }
    // Inform the spooler that the document is ending.
    if(!EndDocPrinter(hPrinter))
    {
      ClosePrinter(hPrinter);
      return FALSE;
    }
    // Tidy up the printer handle.
    ClosePrinter(hPrinter);
    // Check to see if correct number of bytes were written.
    if(dwBytesWritten != dwCount)
      return FALSE;
      return TRUE;
}
```

The following file is available for download from the Microsoft Download Center:

[RAWPRN.EXE](https://download.microsoft.com/download/platformsdk/utility/95/win98/en-us/rawprn.exe)

For more information about how to download Microsoft Support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help to prevent any unauthorized changes to the file.
