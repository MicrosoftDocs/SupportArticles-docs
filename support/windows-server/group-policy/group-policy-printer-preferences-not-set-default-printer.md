---
title: Printer Preferences can't set default printer
description: Works around an issue where Group Policy Printer Preferences fails to set the default printer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Group Policy\Managing printers through Group Policy, csstroubleshoot
---
# Group Policy Printer Preferences fails to set the default printer when new user profile is created

This article provides a workaround for an issue where Group Policy Printer Preferences fails to set the default printer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2787598

## Symptoms

Using Group Policy Preferences to create a new printer mapping and set that printer as the default printer fails on Windows Vista and higher clients when the user is logging on for the first time. The printer mapping is successfully created, but is not set as the default printer in the registry.  A printer preferences trace shows the following error:

>\<VALUE>The printer name is invalid.\</VALUE>\</PROPERTY>-\</INSTANCE>  
Event ID 4098 is logged in the Application Log:  
Log Name:      Application  
Source:        Group Policy Printers  
Date:          *\<DateTime>*  
Event ID:      4098  
Task Category: (2)  
Level:         Warning  
Keywords:      Classic  
User:          SYSTEM  
Computer:      `server.fabrikam.com`  
Description:  
The user 'HP Printer' preference item in the 'Define Printers {XXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX}' Group Policy object did not apply because it failed with error code '0x80070709 The printer name is invalid.' This error was suppressed.

## Cause

Group Policy Preferences creates the network printer mapping and calls the SetDefaultPrinterW() API before the user logon completes. At this point, the network connection under Software\\Microsoft\\Windows NT\\CurrentVersion\\Devices is not created yet. So when it calls the SetDefaultPrinterW() API, it fails with the error code 0x80070709 "The printer name is invalid."

The printer connection registry values will only be created by the Spooler Service when it receives the SERVICE_CONTROL_SESSIONCHANGE notification. This notification message will only be sent AFTER the user logon completes. So when Group Policy Preferences calls SetDefaultPrinterW() the first time, the default printer will not be set.

## Resolution

There is currently no hotfix available for this issue. Possible work-arounds include:

1. Force a group policy update after logon using the `GPUPDATE /FORCE` command
2. Restart the Print Spooler (spooler) service after user logon
3. Use a Scheduled Task to run a script after logon to define the default printer
4. Use Registry Preferences to configure the default printer

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
