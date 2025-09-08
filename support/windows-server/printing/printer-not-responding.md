---
title: Printer Not Responding
description: Provides solutions to an issue where a printer isn't responding.
ms.date: 04/02/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, elenag, v-lianna
ms.custom:
- sap:print,fax,and scan\print configuration or management
- pcy:WinComm User Experience
---
# Printer isn't responding

This article provides solutions to an issue where a printer isn't responding.

When a printer isn't responding, it generally means that the printer can't communicate with the computer device or the server. This issue occurs for several reasons, for example:

- Network communication problem with the device
- Unstable printer state or error state
- Driver outdated or corrupt

To resolve the issue, perform the following verifications in order:

## 1. Check the printer connection

Ensure that the printer is properly connected to your computer or network:

- For wired printers, make sure the cable is securely plugged in.
- For wireless printers, verify that the printer is connected to a functioning Wi-Fi network.

## 2. Check if the printer is in a problematic state

Check the printer's display panel or the printer status on your computer. If the printer is in a **Stopped** state, add the **Status Reason** column to see if there's an error, such as **Out of toner** or **Off-line**.

## 3. Check the printer properties

Right-click the printer icon and select **Properties**. Select the **General** tab and check the device status message. It might indicate a problem or provide an error code to check online or in the printer manual.

## 4. Restart the printer

Turn off the printer, wait about 30 seconds, and then turn it back on. This action can often resolve temporary issues.

## 5. Run the printer troubleshooter

Run the built-in printer troubleshooter on your Windows computer. To do so, go to **Settings** > **System** > **Troubleshoot** > **Other troubleshooters**, and then select **Run** next to **Printer**.

## 6. Reinstall the printer driver

Right-click your printer in Device Manager and select **Uninstall device**. Then, restart your computer and reinstall the driver.

If the driver is the latest original equipment manufacturer (OEM) version, try switching to a generic in-box driver.

## 7. Check the Print Spooler service state

Restart the Print Spooler service to clear any stuck print jobs by using one of the following methods. For more information, see [Printing issues caused by the Print Spooler service not running](print-spooler-service-not-running.md).

### Manually restart the service

In the **Services** application, right-click **Print Spooler** in the list, and select **Restart**.

### Use Command Prompt

Type **cmd** in the search bar, right-click **Command Prompt**, and select **Run as administrator** to open Command Prompt as an administrator. Run the following commands and press <kbd>Enter</kbd> after each one:

```console
-net stop spooler
```

```console
-net start spooler
```

### Use Windows PowerShell

Type **powershell** in the search bar, right-click **Windows PowerShell**, and select **Run as administrator** to open PowerShell as an administrator. Run the following cmdlet and press <kbd>Enter</kbd>:

```powershell
Restart-Service -Name spooler
```

## 8. Verify the printer queue status

If there are any stuck print jobs, clear the queue and resubmit the print job.

To delete any files stuck in the queue, follow these steps:

1. Stop the Print Spooler service.
2. Open File Explorer and navigate to **C:\\Windows\\System32\\spool\\PRINTERS**.
3. Delete all files (`.shd` files) in this folder. These files are the print jobs that are stuck in the queue.
4. Restart the Print Spooler service.

## 9. Update the printer firmware

Check the manufacturer's website for any firmware updates available for your printer.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for user experience-related issues](../../windows-client/windows-tss/gather-information-using-tss-user-experience.md#printing).
