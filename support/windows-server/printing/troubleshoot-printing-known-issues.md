---
title: Troubleshoot printing known issues
description: Overview of printing known issues.
ms.date: 09/27/2021
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
ms.technology: windows-server-printing
---
# Troubleshoot printing known issues

The article describes emerging and common issues that can occur during printing, and also provides possible solutions to those issues.

## Printing and scanning might fail when these devices use smart-card authentication

After installing [KB5004237](https://support.microsoft.com/topic/july-13-2021-kb5004237-os-builds-19041-1110-19042-1110-and-19043-1110-ae798d3c-3de3-4c1f-b9d9-7391b71da889) on domain controllers (DCs) in your environment, some printers, scanners, and multifunction devices might fail to print when using smart-card (PIV) authentication.

### Solution

For more information on this issue, see [KB5005408 - Smart card authentication might cause print and scan failures](https://support.microsoft.com/topic/kb5005408-smart-card-authentication-might-cause-print-and-scan-failures-514f0bc5-ecde-4e5e-8c5a-2a776d7fb89a).

## Certain printers unable to print via USB

After installing KB5003690 or later updates (including out of band updates, KB5004760 and KB5004945), you might have issues printing to certain printers. Various brands and models are affected, primarily receipt or label printers that connect via USB.

### Solution

This issue is resolved by [Known Issue Rollback (KIR)](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/known-issue-rollback-helping-you-keep-windows-devices-protected/ba-p/2176831). This issue is not related to CVE-2021-34527 or CVE-2021-1675.

## Windows Print Spooler Remote Code Execution Vulnerability

After installing update [July 6, 2021—KB5004945 (OS Builds 19041.1083, 19042.1083, and 19043.1083) Out-of-band](https://support.microsoft.com/topic/july-6-2021-kb5004945-os-builds-19041-1083-19042-1083-and-19043-1083-out-of-band-44b34928-0a71-4473-aa22-ecf3b83eed0e) and later Windows updates, users who aren't administrators can only install signed print drivers to a print server. By default, administrators can install both signed and unsigned printer drivers to a print server. The installed root certificates in the system's Trusted Root Certification Authorities trust signed drivers.

### Solution

For more information, see [KB5005010: Restricting installation of new printer drivers after applying the July 6, 2021 updates](https://support.microsoft.com/topic/kb5005010-restricting-installation-of-new-printer-drivers-after-applying-the-july-6-2021-updates-31b91c02-05bc-4ada-a7ea-183b129578a7).

## A printer connected to a computer does not print

### Cause

A problem might exist with the physical printer, the print driver, a print server, or the application you are trying to print from.

### Solution

Try the following steps to identify and solve the problem.

- Verify the physical printer is in ready state, and that the correct default printer is set.
- Try to print a test page.
- Try printing from the command line (on non-PostScript printers only). Type `Dir > LPT1` at the command prompt.
- Try printing from Notepad. It verifies that the printer driver is correct, and confirms that the problem lies with the application. If you cannot print from Notepad, the problem lies with the printer driver.
- Check the available disk space on the system drive. If there is not enough room to spool the job, larger jobs might fail where smaller jobs do not.

## A printer connected to the network does not print

### Cause

A problem might exist with the physical printer, the logical printer setting on the client computer, the application you are trying to print from, network protocols, or hardware.

### Solution

Try the following to isolate and solve the problem:

- Verify basic network connectivity. Check user rights, protocols, share names, and so on, to determine whether you can see the server. Try to copy a file to the server, if you can't access the server, you might not be able to access the printer.
- On the **Advanced** tab, make sure the printer availability time is correct.
- Create a local printer and redirect the port to the network server. Using the **Add Printer Wizard**, select Local, and then type the server and printer name for the printer (*\\\\\<servername\>\\\<printername\>*). It determines whether you can copy files from the print server.
- Check the available disk space on the print server. If there is not enough room to spool the job, larger jobs might fail where smaller jobs do not.

## Access Denied message when trying to configure a printer from within an application

### Cause

You do not have the appropriate permission to change printer configuration.

### Solution

You need Manage Printer permission to change the printer's setup.

## The document does not print completely, or comes out garbled

### Cause

The printer's driver is either corrupted or incorrect.

### Solution

Verify or reinstall the correct printer driver on the client computer.

## Hard disk problems occur, and the document does not reach the print server

### Cause

The hard disk might not have enough space for spooling the document.

### Solution

Make sure the hard disk has enough disk space, or relocate the spool folder to another volume.

## Documents on the print server will not print and cannot be deleted

### Cause

The print spooler might be stalled.

### Solution

On the print server, try to stop and restart the Print Spooler service.

## An application on a 16-bit version of Windows (such as Windows for Workgroups) gives an out-of-memory error on startup

### Cause

A default printer is not selected.

### Solution

Add a printer and set it as the default printer.

## A driver is not listed

### Solution

Windows printer drivers are developed through cooperation between Microsoft and the independent hardware vendor (IHV) that manufactures the print device. For new and updated print drivers, see Microsoft printing support at the [Microsoft Web site](https://go.microsoft.com/fwlink/?linkid=303), and also check [Windows Update](https://go.microsoft.com/fwlink/?linkid=284).

## A new print driver downloaded from the Internet needs to be installed

### Cause

The print driver is not listed in the **Add Printer Wizard**'s list of printers, but instead was downloaded from the Internet.

### Solution

1. Download the printer driver to an empty folder.
2. Expand the files by typing the name of the executable followed by the `-d` switch. For example, if the name of the file is *Nt4prn.exe*, type the following command at a command prompt: `nt4prn -d`.
3. Read the *Readme.txt* and the *License.txt* files.
4. Select the **Start** button, then select **Settings** > **Devices** > **Printers & scanners**.
5. On the right, under **Related Settings**, select **Print server properties**.
6. On the **Drivers** tab, see if your printer listed. If it is, you're all set.
7. If you don't see your printer listed, select **Add**, and in the **Welcome to the Add Printer Driver Wizard**, select **Next**.
8. In the **Processor Selection** dialog box, select your device's architecture, and then select **Next**.
9. In the **Printer Driver Selection** dialog box, select **Have Disk** and then select **Browse button**.
10. Point to the folder where you downloaded the driver in the Step 1, and follow the instructions to add your driver.

## With printer location tracking enabled, some printers cannot be located

### Cause

After printer location tracking is enabled, the default behavior is that the user will find only those printers whose location attribute matches the naming convention.

### Solution

Set the location string again for this printer. For information on how to do it, see [Enable printer location tracking](/previous-versions/windows/it-pro/windows-server-2003/cc784120(v=ws.10)).

## The company has changed its organization, and as a result the naming scheme has to change

### Solution

First, use Active Directory Sites and Services to update the sites and subnets. Next, you need to update all the printer location fields for the affected printers in the organization. You can create an Active Directory Service Interfaces (ADSI) script to expedite the updates.

## My organization has a small network without any subnets

### Solution

Active Directory cannot locate a node in the tree of your directory without having a subnet associated with it. If your organization is small enough, then it is not a problem, and users can search for any printer in the organization. But for larger organizations, or ones with many printers, you can still allow users to browse the location hierarchy as an aid to locate a printer. To do it, you need to create artificial subnets in Active Directory to correspond to the hierarchy you want to create.
