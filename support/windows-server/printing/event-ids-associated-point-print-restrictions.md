---
title: Event ID's with point and print restrictions
description: Provides a resolution for Event ID's commonly associated with point and print restrictions.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# Event ID's commonly associated with point and print restrictions

This article provides a resolution for Event ID's commonly associated with point and print restrictions.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2618460

## Symptoms

The following Event ID's are commonly associated with a Windows machine's inability to download a driver from a print server.  
>Log Name:      Application  
Source:        Group Policy Printers  
Event ID:      4098  
Description:  
The computer \<ComputerName or IP> preference item in the '{GUID}' Group Policy object did not apply because it failed with error code '0x80070bcb The specified printer driver was not found on the system and needs to be downloaded.' This error was suppressed.  

>Log Name:      Application  
Source:        Group Policy Printers  
Event ID:      8192  
Description:  
The user \<UserName> preference item in the '{GUID}' Group Policy object did not apply because it failed with error code '0x80070bcb The specified printer driver was not found on the system and needs to be downloaded.' For more information, see trace file.  

>Log Name:      System  
Source:        Microsoft-Windows-TerminalServices-Printers  
Event ID:      1111  
Description:  
Driver \<DriverName> required for printer \<PrinterName> is unknown. Contact the administrator to install the driver before you log in again.  

>Log Name: System  
Event Type: Error  
Event Source: Print  
Event ID: 23  
Description:  
Printer \<PrinterName> failed to initialize because a suitable \<DriverName> driver could not be found.  

>Log Name:      System  
Source:        Microsoft-Windows-PrintSpooler  
Event ID:      22  
Description:  
Failed to upgrade printer settings for printer \<PrinterName> driver \<DriverName>. Error: 1801. The device settings for the printer are set to those configured by the manufacturer.  

>Log Name:      System  
Source:        Microsoft-Windows-SpoolerWin32SPL  
Event ID:      1  
Description:  
The print spooler failed to import the printer driver that was downloaded from \<ServerName> into the driver store for driver \<DriverName>. Error code= 800f0242. This can occur if there is a problem with the driver or the digital signature of the driver.  

>Log Name:      Microsoft-Windows-PrintService/Admin  
Source:        Microsoft-Windows-PrintService  
Event ID:      215  
Description:  
Installing printer driver \<DriverName> failed, error code 0x23f, HRESULT 0x8007023f. See the event user data for context information.  

>Log Name:      Microsoft-Windows-PrintService/Admin  
Source:        Microsoft-Windows-PrintService  
Event ID:      808  
Description:  
The print spooler failed to load a plug-in module \<DLL Name>, error code 0x7e. See the event user data for context information.  

>Log Name:      Microsoft-Windows-PrintService/Admin  
Source:        Microsoft-Windows-PrintService  
Event ID:      215  
Description:  
Installing printer driver \<DriverName> failed, error code 0x0, HRESULT 0x80070705. See the event user data for context information.  

## Cause

These events may be logged due to Point and Print Restrictions.

## Resolution

Configure the Point and Print Restrictions policy to Disabled.  

- Computer Configuration / Administrative Templates / Printers
- User Configuration / Administrative Templates / Control Panel / Printers  

>[!Note]
>The User Configuration policy has been deprecated but is still available for backwards compatibility with legacy OS's.  It is generally recommended to configure both policies to "Disabled" for uniform behavior across all clients.

## More information

2307161 The Point and Print User configuration policy is ignored by Windows 7, Windows Server 2008 R2, and Service Pack 2 release of Windows Vista, Windows Server 2008.  
[https://support.microsoft.com/help/2307161](https://support.microsoft.com/help/2307161)  

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
