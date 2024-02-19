---
title: Troubleshoot known issues for printing
description: Overview of printing known issues.
ms.date: 12/26/2023
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# Troubleshoot known issues for printing

The article describes emerging and common issues that can occur during printing, and also provides possible solutions for those issues.

## Printing and scanning might fail when these devices use smart card authentication

After you install [KB5004237](https://support.microsoft.com/topic/july-13-2021-kb5004237-os-builds-19041-1110-19042-1110-and-19043-1110-ae798d3c-3de3-4c1f-b9d9-7391b71da889) on domain controllers in your environment, some printers, scanners, and multifunction devices might not print when you use smart card (PIV) authentication.

### Resolution

For more information about this issue, see [KB5005408 - Smart card authentication might cause print and scan failures](https://support.microsoft.com/topic/kb5005408-smart-card-authentication-might-cause-print-and-scan-failures-514f0bc5-ecde-4e5e-8c5a-2a776d7fb89a).

## Certain printers can't print through USB

After you install KB5003690 or later updates (including out-of-band updates KB5004760 and KB5004945), you might have issues when you try to print to certain printers. Various brands and models are affected, primarily receipt or label printers that connect through USB.

### Resolution

This issue is resolved by [Known Issue Rollback (KIR)](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/known-issue-rollback-helping-you-keep-windows-devices-protected/ba-p/2176831). This issue is not related to CVE-2021-34527 or CVE-2021-1675.

## Windows Print Spooler remote code execution vulnerability

After you install the [July 6, 2021—KB5004945 (OS Builds 19041.1083, 19042.1083, and 19043.1083) Out-of-band](https://support.microsoft.com/topic/july-6-2021-kb5004945-os-builds-19041-1083-19042-1083-and-19043-1083-out-of-band-44b34928-0a71-4473-aa22-ecf3b83eed0e) update and later Windows updates, users who aren't administrators can install only signed print drivers to a print server. By default, administrators can install both signed and unsigned printer drivers to a print server. The installed root certificates in the system's Trusted Root Certification Authorities trust signed drivers.

### Resolution

For more information, see [KB5005010: Restricting installation of new printer drivers after applying the July 6, 2021 updates](https://support.microsoft.com/topic/kb5005010-restricting-installation-of-new-printer-drivers-after-applying-the-july-6-2021-updates-31b91c02-05bc-4ada-a7ea-183b129578a7).

## A printer that's connected to a computer doesn't print

### Cause

A problem might exist in the physical printer, the print driver, a print server, or the application that you're trying to print from.

### Resolution

Try the following steps to identify and resolve the problem:

- Verify that the physical printer is in ready state, and that the correct default printer is set.
- Try to print a test page.
- Try to print from the command line (on non-PostScript printers only). Type `Dir > LPT1` at the command prompt.
- Try to print from a text editor, such as Notepad. If printing is successful, this confirms that the printer driver is correct and that the problem is caused by the application. If you can't print from Notepad, the problem is caused by the printer driver.
- Check the available disk space on the system drive. If there isn't enough room to spool the job, larger jobs might fail even though smaller jobs don't.

## A printer connected to the network doesn't print

### Cause

A problem might exist in the physical printer, the logical printer setting on the client computer, the application that you're trying to print from, network protocols, or hardware.

### Resolution

Try the following methods to isolate and solve the problem:

- Verify basic network connectivity. Check user rights, protocols, share names, and so on, to determine whether you can see the server. Try to copy a file to the server. If you can't access the server, you might not be able to access the printer.
- On the **Advanced** tab, make sure the printer availability time is correct.
- Create a local printer, and redirect the port to the network server. Using the **Add Printer Wizard**, select Local, and then type the server and printer name for the printer (*\\\\\<servername\>\\\<printername\>*). This determines whether you can copy files from the print server.
- Check the available disk space on the print server. If there isn't enough room to spool the job, larger jobs might fail even though smaller jobs don't.

## Access Denied message when you try to configure a printer from within an application

### Cause

You don't have the appropriate permission to change the printer configuration.

### Resolution

You have to have the Manage Printer permission to change the printer setup.

## The document doesn't print completely, or appears garbled

### Cause

The printer's driver is either corrupted or incorrect.

### Resolution

Verify or reinstall the correct printer driver on the client computer.

## Hard disk problems occur, and the document doesn't reach the print server

### Cause

The hard disk might not have enough space to spool the document.

### Resolution

Make sure that the hard disk has enough disk space, or relocate the spool folder to another volume.

## Documents on the print server don't print and can't be deleted

### Cause

The print spooler might be stalled.

### Resolution

On the print server, try to stop and restart the Print Spooler service.

## A driver is not listed

### Resolution

Windows printer drivers are developed through cooperation between Microsoft and the independent hardware vendor that manufactures the print device. For new and updated print drivers, see Microsoft printing support at the [How to download and install the latest printer drivers](https://support.microsoft.com/windows/how-to-download-and-install-the-latest-printer-drivers-4ff66446-a2ab-b77f-46f4-a6d3fe4bf661), and also check [Windows Update](https://go.microsoft.com/fwlink/?linkid=284).

## A new print driver that you downloaded from the internet has to be installed

### Cause

The print driver is not listed in the **Add Printer Wizard** list of printers, but was downloaded from the internet.

### Resolution

1. Download the printer driver to an empty folder.
2. Expand the files by typing the name of the executable file followed by the `-d` switch. For example, if the name of the file is *Nt4prn.exe*, type the following command at a command prompt: `nt4prn -d`.
3. Read the *Readme.txt* and the *License.txt* files.
4. Select the **Start** button, then select **Settings** > **Devices** > **Printers & scanners**.
5. On the right, under **Related Settings**, select **Print server properties**.
6. On the **Drivers** tab, check whether your printer is listed. If it is, you're all set.
7. If you don't see your printer listed, select **Add**, and then select **Next** in the **Welcome to the Add Printer Driver Wizard**.
8. In the **Processor Selection** dialog box, select your device's architecture, and then select **Next**.
9. In the **Printer Driver Selection** dialog box, select **Have Disk**, and then select **Browse button**.
10. Point to the folder to which you downloaded the driver in the step 1, and then follow the instructions to add your driver.

## Some printers cannot be located even though printer location tracking is enabled

### Cause

After printer location tracking is enabled, the default behavior is that the user will find only those printers whose location attribute matches the naming convention.

### Resolution

Set the location string again for this printer. To learn how to do this, see [Enable printer location tracking](/previous-versions/windows/it-pro/windows-server-2003/cc784120(v=ws.10)).

## The naming scheme has to change because the company changed its organization

### Resolution

Use Active Directory Sites and Services to update the sites and subnets. Then, you must update all the printer location fields for the affected printers in the organization. You can create an Active Directory Service Interfaces (ADSI) script to expedite the updates.

## The organization has a small network without any subnets

### Resolution

Active Directory cannot locate a node in the tree of your directory without having a subnet associated with it. If your organization is small enough, this situation isn't a problem because users can search for any printer in the organization. However, for larger organizations or organization that has many printers, you can still enable users to browse the location hierarchy as an aid to locate a printer. To do this, you have to create artificial subnets in Active Directory that correspond to the hierarchy that you want to create.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
