---
title: Unable to install Secure Web Services on Devices (WSD) Printer
description: Fixes an issue in which you can't install a Secure Web Services on Devices (WSD) printer from Print Management Console.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting:-general-issues, csstroubleshoot
---
# Unable to install Secure Web Services on Devices (WSD) Printer using Print Management console

This article helps fix an issue where you can't install a Secure Web Services on Devices (WSD) printer from Print Management Console (PrintManagement.msc) by using "Search the network for printers".

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2701603

## Symptoms

Consider the following scenario:

- You have a Secure Web Services on Devices (WSD) printer that always connects with SSL connection.
- You're unable to install the printer from Print Management Console (PrintManagement.msc) by using "Search the network for printers".

In this scenario, you try to install the printer using from following steps:

1. Open Print Management Console (`PrintManagement.msc`)
2. Expand **print servers** server name **printer** on the left pane
3. Right-click **Printer**
4. Select **Add Printer...**
5. Select **Search the network for printers**
6. Select **Secure WSD printer** on the **Network Printer Search Result**.
7. Click **Next**
8. Click **Next** to start installation.

## Cause

"Search the network for printers" in Print Management Console doesn't properly use SSL to communicate with the printer.

## Resolution

You can install Secure Web Services on Devices (WSD) printer from the following methods:

Method 1: From Devices and Printers using "Add a printer using a TCP/IP address or hostname"

1. Click on Start and then click Devices and Printers
2. Run Add printer Wizard
3. Click "Add a network, wireless or Bluetooth printer"
4. Click "The printer that I want isn't listed"
5. Select Add a printer using a TCP/IP address or hostname and Click "Next" button
6. Enter the printer's host name or IP address

Method 2: From Print Management console using "Add a TCP/IP or Web Services Printer by IP address or hostname"

1. Open Print Management Console (PrintManagement.msc)
2. In the Print Management console, right-click Printers and then click Add Printer
3. The Network Printer Installation Wizard starts
4. Click Add a TCP/IP or Web Services printer by IP address or hostname and then click Next
5. Enter the printer's host name or IP address (the port name will be the same by default), and then click Next
6. Make any necessary changes to the printer name, contact information, or sharing status, and then click Next

## More information

[Web Services on Devices (WSD) Roadmap](https://msdn.microsoft.com/library/bb756908.aspx)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
