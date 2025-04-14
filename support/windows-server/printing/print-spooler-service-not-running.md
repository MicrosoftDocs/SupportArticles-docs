---
title: Printing issues caused by Print Spooler service not running
description: Helps troubleshoot printing issues caused by the Print Spooler service not running.
ms.date: 03/21/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, elenag, v-lianna
ms.custom:
- sap:print,fax,and scan\print configuration or management
- pcy:WinComm User Experience
---
# Troubleshoot printing issues caused by Print Spooler service not running

This article helps troubleshoot printing issues caused by the Print Spooler service not running.

You encounter issues with installing printers, connecting to network printers, or printing to a printer.

These issues might occur if the Print Spooler service isn't running on your system. The Print Spooler service usually starts with Windows and runs until the operating system shuts down. It contains Windows binaries and optional vendor-supplied components.

Here are some methods you can use to troubleshoot these issues:

- [Restart the Print Spooler service](#restart-the-print-spooler-service)
- [Check for system instability or resource issues](#check-for-system-instability-or-resource-issues)
- [Verify Group Policy settings](#verify-group-policy-settings)
- [Update drivers](#update-drivers)
- [Check for conflicts with anti-virus software](#check-for-conflicts-with-anti-virus-software)

## Restart the Print Spooler service

Restart the Print Spooler service to clear any stuck print jobs by using one of the following methods:

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

## Check for system instability or resource issues

The Print Spooler service might fail to start due to system instability or insufficient system resources. Check the event logs for errors that indicate issues with initializing the local print provider.

## Verify Group Policy settings

Ensure that no Group Policy settings disable or stop the Print Spooler service. Disabling the Print Spooler service can be part of security mitigations. Additionally, there might be an organizational unit (OU) with a Group Policy Object (GPO) for the domain controllers (DCs) to disable the Print Spooler service.

## Update drivers

Ensure all relevant drivers are up to date. Outdated drivers and print components might cause the Print Spooler service to stop responding.

## Check for conflicts with anti-virus software

Anti-virus software can sometimes interfere with the Print Spooler service. Ensure the anti-virus software isn't blocking any files needed by the Print Spooler service. Create exclusions for the spool folder.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-tss/gather-information-using-tss-user-experience.md#printing).
