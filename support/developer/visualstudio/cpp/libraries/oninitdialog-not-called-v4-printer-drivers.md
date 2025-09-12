---
title: CPrintDialog::OnInitDialog isn't called when using V4 printer drivers
description: Describes a problem where CPrintDialog::OnInitDialog isn't called when using a printer with a V4 printer driver. 
ms.reviewer: ishimada, davean, v-sidong
ms.custom: sap:C and C++ Libraries\Microsoft Foundation Classes (MFC)
ms.date: 07/03/2024
---

# CPrintDialog::OnInitDialog isn't called when using V4 printer drivers

This article helps work around a problem where `CPrintDialog::OnInitDialog` isn't called when using a printer with a [V4 printer driver](/windows-hardware/drivers/print/v4-printer-driver).

## Symptoms

Functions specified in the message map of a CPrintDialog-derived class, including `OnInitDialog`, aren't called when using `DoModal` to display the **Print** dialog box. This behavior occurs when using a printer with a V4 printer driver, such as **Microsoft Print to PDF**.

## Cause

The [CPrintDialog](/cpp/mfc/reference/cprintdialog-class) class wraps the [PrintDlg](/previous-versions/windows/desktop/legacy/ms646940(v=vs.85)) function. [CPrintDialog::DoModal](/cpp/mfc/reference/cprintdialog-class#domodal) sets a WH_CBT window hook on the calling thread to obtain the window handle of the dialog box created by the `PrintDlg` function and attaches the handle to the `CPrintDialog` object.

Before the `PrintDlg` function creates the dialog box, it calls the [DocumentProperties](/windows/win32/printdocs/documentproperties) function on the selected printer to obtain a [DEVMODE](/windows/win32/api/wingdi/ns-wingdi-devmodea) structure from the printer driver, which is then used to initialize the dialog. A hidden window, using the window class name `URL Moniker Notification Window`, is created when `DocumentProperties` is called on a printer using a V4 printer driver.

The WH_CBT window hook procedure incorrectly attaches the `CPrintDialog` object to the window handle of the `URL Moniker Notification Window` Window instead of the dialog box. The result is that the functions in the `CPrintDialog` object's message map aren't invoked for the dialog box.

## Workaround

To work around the problem, use [printer-driver isolation](/windows/win32/printdocs/use-application-isolation). It improves an application's reliability by running printer drivers in a separate process instead of the process calling the [print spooler functions](/windows/win32/printdocs/printing-and-print-spooler-functions). This isolation prevents applications calling the print spooler functions from crashing if a printer driver has an error.

In this scenario, the reason for using printer-driver isolation is that the `URL Moniker Notification Window` window is created in a separate process.

To enable printer-driver isolation for an application, use one of the following methods:

- Update the app manifest of the application as described in [How To: Use Application Isolation](/windows/win32/printdocs/use-application-isolation).

- Apply the PrinterIsolationAware compatibility fix to the application using the [Compatibility Administrator tool](/windows/deployment/planning/using-the-compatibility-administrator-tool). For more information, see the [Compatibility Administrator User's Guide](/windows/deployment/planning/compatibility-administrator-users-guide).

## More information

- [TN003: Mapping of Windows Handles to Objects](/cpp/mfc/tn003-mapping-of-windows-handles-to-objects)

- [V4 printer driver](/windows-hardware/drivers/print/v4-printer-driver)
