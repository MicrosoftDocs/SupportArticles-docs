---
title: Create multiple print queues for an IPP printer
description: Describes how to create multiple print queues for the same IPP printer by reusing its existing printer port.
ms.subservice: print
ms.date: 08/20/2026
ms.custom: sap:Print Driver
ms.reviewer: riwaida
ai-usage: ai-assisted
---

# Create multiple print queues for an IPP printer

This article describes how to create multiple print queues for the same Internet Printing Protocol (IPP) printer. Each queue can have different printing preferences, such as color mode, paper type, or paper source.

## Summary

When an IPP printer is added through **Settings** or **Control Panel**, Windows creates a printer port for the IPP device. Trying to add the same IPP device again by using the same host name or IP address might not create another queue.

To create additional queues, reuse the printer port that Windows created for the first queue. Specify the existing port and the **Microsoft IPP Class Driver** when you create each additional queue.

You can create the additional queues by using one of the following methods:

- The `Add-Printer` PowerShell cmdlet
- Print Management
- The Win32 `AddPrinter` function

## Prerequisites

- Add the IPP printer once through **Settings** or **Control Panel**. This step creates the IPP printer port that the additional queues use.
- Sign in with an account that has permission to add a printer. The `Add-Printer` cmdlet might require administrative credentials.
- Make sure that **Microsoft IPP Class Driver** is installed for the first queue.

## Identify the existing printer port

To identify the port that the existing IPP print queue uses, run the following command in PowerShell. Replace `<ExistingQueueName>` with the name of the queue that was created when you added the IPP printer.

```powershell
Get-Printer -Name "<ExistingQueueName>" | Select-Object Name, DriverName, PortName
```

You can also list all installed printer ports by running the following command:

```powershell
Get-PrinterPort | Select-Object Name, Description, PrinterHostAddress
```

Alternatively, open Print Management and inspect the **Port Name** column for the existing queue.

For troubleshooting, IPP port information is stored under the following registry paths:

- IPP over USB: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Monitors\USB Monitor\Ports`
- IPP over Web Services on Devices (WSD): `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Monitors\WSD Port\Ports`

> [!IMPORTANT]
> Don't modify the values under these registry paths. Use PowerShell or Print Management to identify the port whenever possible.

## Create an additional queue by using PowerShell

Run the following command in PowerShell. Replace the example port name and queue name with values for your environment.

```powershell
Add-Printer -Name "Contoso 2nd IPP Printer" `
    -DriverName "Microsoft IPP Class Driver" `
    -PortName "WSD-86066a6d-3dea-4c21-8434-9cb0152f1cc1"
```

The `-PortName` value must match the port used by the existing IPP queue. The value in this example is only a placeholder.

Repeat the command with a unique value for `-Name` to create more queues. Use the same values for `-DriverName` and `-PortName` for each queue that targets the same IPP printer.

## Create an additional queue by using Print Management

1. Open **Print Management**.
1. Expand **Print Servers**, expand the local print server, and then select **Printers**.
1. Select **More Actions** > **Add Printer**.
1. Select the option to add a printer by using an existing port.
1. Select the port used by the existing IPP print queue, and then select **Next**.
1. Select **Microsoft** as the manufacturer and **Microsoft IPP Class Driver** as the printer driver, and then select **Next**.
1. Enter a unique printer name, and complete the wizard.

Repeat these steps for each additional print queue.

## Create an additional queue by using the Win32 API

Applications can create an additional queue by calling the [`AddPrinter`](/windows/win32/printdocs/addprinter) function with a [`PRINTER_INFO_2`](/windows/win32/printdocs/printer-info-2) structure. Set the following members in the structure:

- `pPrinterName`: A unique name for the new print queue.
- `pPortName`: The port name used by the existing IPP queue.
- `pDriverName`: `Microsoft IPP Class Driver`.

The application must have the access rights that the `AddPrinter` function requires.

## Configure and verify the queues

After you create the queues, open **Settings** > **Bluetooth & devices** > **Printers & scanners**. Verify that each queue is listed, and configure the printing preferences for each queue as needed.

Because the queues share the same port and physical printer, pausing the printer, taking it offline, or changing port-level settings can affect printing through the other queues.

## References

- [Add-Printer](/powershell/module/printmanagement/add-printer)
- [Get-Printer](/powershell/module/printmanagement/get-printer)
- [Get-PrinterPort](/powershell/module/printmanagement/get-printerport)
- [AddPrinter function](/windows/win32/printdocs/addprinter)
- [PRINTER_INFO_2 structure](/windows/win32/printdocs/printer-info-2)