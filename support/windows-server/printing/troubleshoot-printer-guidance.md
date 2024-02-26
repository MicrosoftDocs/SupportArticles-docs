---
title: Guidance for troubleshooting printing issues
description: Introduces general guidance for troubleshooting scenarios related to printers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
---
# Printing issue troubleshooting guidance

This article is designed to get you started on troubleshooting issues encountered when using printers.

> [!div class="nextstepaction"]
> <a href="https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=31806275" target='_blank'>Try our Virtual Agent</a> - It can help you quickly identify and fix common Print related issues.

## Troubleshooting checklist

Here's a list of basic steps to resolve most printing issues:

- Verify that the physical printer is operational. If other users can print, the cause is probably not the device or the print server.
- Verify that the printer on the print server is using the correct printer driver. If print clients are using other operating systems, make sure that you installed all necessary drivers for the other platforms.
- Verify the following:
  - The print server is operational.
  - There's sufficient disk space for spooling.
  - The print spool service is running.
- Verify that the client computer has the correct printer driver.
- Check whether the physical printer is in the ready state (ready to print). Most printers can print a test page to confirm correct operation.
- Check whether the printer data cable is connected correctly. If the printer is connected directly to the network by using a network adapter, check the status of the light on the card that indicates network connectivity.
- Make sure that you can communicate with the printer over the network. For example, if the printer communicates over the TCP/IP protocol, you can use the ping command to verify connectivity.
- Verify communication to the print server from other computers.
- Check whether any service that's required for the printer and the client that's submitting the print job is working correctly.
- Verify that the print spool service is running on the print server.

## Test each process of printing architecture

The modularity of the printing architecture makes diagnosing problems fairly easy. By testing each process, you can generally identify the problem. Follow the steps for each process that applies.

The administrator adds a printer and shares it.

1. Check the property of the logical printer. Make sure that the driver is correct for that printer.
2. Use the **Add Printer Wizard** to add another logical printer for the same physical printer. By doing this, you can quickly identify whether the problem is the logical printer.
3. Try to browse printer connections, or locate the printer port. If you can't do this, the problem might be the network connectivity.
4. Verify that you are logged on as administrator, or as a member of the Administrator group.

A network client connects to that share.

1. Check the property of the logical printer on the client computer. Make sure that the driver is correct for that printer.
2. Use the **Add Printer Wizard** to add another logical printer for the same physical printer. By doing this, you can quickly identify whether the problem is the logical printer.
3. Check the user permissions to print to that printer, and check which Group Policy settings for printers are enabled.
4. Try to browse printer connections. If you can't do this, the problem might be the network connectivity.

The client application creates a print job.

1. Check whether the document that the client is trying to print consists of text only or includes graphics. Check the printer driver and the fonts settings.
2. Check whether there's a problem that affects the separator page selection.
3. Try to reproduce the same print job from another client. If the job prints correctly from the other client, the problem is most likely not caused by this process.
4. Check whether the client system sends the print job to the printer share on the print server.
5. Check the network transport. For example, check the TCP/IP or NWLink status.
6. Check other network components that are required to print.

## Emerging issues

### Installation of printers via Internet Printing Protocol (IPP) might not succeed

After installing [KB5005565](https://support.microsoft.com/help/5005565), installation of printers using Internet Printing Protocol (IPP) might not complete successfully. Devices which had connected to and installed the printer prior to the installation of KB5005565 are unaffected and print operations to that printer will succeed as usual.

Resolution: This issue has been resolved in [KB5006738](https://support.microsoft.com/help/5006738).

### Installation of printers might fail when attempted over some network connections

Devices which attempt to connect to a network printer for the first time might fail to download and install the necessary printer drivers.
This issue has been observed in devices which access printers via a print server, using HTTP connections. When a client connects to the server to install the printer, a directory mismatch occurs, which causes the installer files to generate incorrectly. As a result, the drivers may not download.

Workaround: Users with admin privileges can still install printer drivers on the client through other means, such as copying packaged drivers from a known good package location. Only the automatic download and installation processes are impacted by this issue.

Resolution: This issue has been resolved in [KB5006746](https://support.microsoft.com/help/5006746).

### Connections to printers shared via print server might encounter errors

After installation of [KB5006674](https://support.microsoft.com/help/5006674), Windows print clients might encounter the following errors when connecting to a remote printer shared on a Windows print server:

- > 0x000006e4 (RPC_S_CANNOT_SUPPORT)
- > 0x0000007c (ERROR_INVALID_LEVEL)
- > 0x00000709 (ERROR_INVALID_PRINTER_NAME)

The printer connection issues described in this issue are specific to print servers and aren't commonly observed in devices designed for home use. Printing environments affected by this issue are more commonly found in enterprises and organizations.

Workaround: You can take steps to workaround this issue on print servers that meet the prerequisite. See [Windows 11 known issues and notifications](/windows/release-health/status-windows-11-21h2#2737msgdesc)

### Point and Print default behavior change requires administrator credentials to print

After installing [KB5005033](https://support.microsoft.com/topic/kb5005652-manage-new-point-and-print-default-driver-installation-behavior-cve-2021-34481-873642bf-2634-49c5-a23b-6d8e9a302872) or a later update, certain printer drivers using Point and Print might be prompted for administrator credentials every time an app attempts to print to a print server or a print client connects to a print server. This is caused by a print driver on the print client and the print server using the same filename, but the server has a newer version of the driver file. When the print client connects to the print server, it finds a newer driver file and is prompted to update the drivers on the print client, but the file in the package it's offered for installation doesn't include the later file version. 

Resolution: Verify that you're using the latest drivers for all your printing devices and where possible, use the same version of the print driver on the print client and print server.

### Printing and scanning might fail when these devices use smart-card authentication

After installing KB5004237 on domain controllers (DCs) in your environment, some printers, scanners, and multifunction devices might fail to print when using smart-card (PIV) authentication.

Next steps: For more information on this issue, see [KB5005408](https://support.microsoft.com/topic/kb5005408-smart-card-authentication-might-cause-print-and-scan-failures-514f0bc5-ecde-4e5e-8c5a-2a776d7fb89a).

### Certain printers unable to print via USB

After installing KB5003690 or later updates (including out of band updates, KB5004760 and KB5004945), you might have issues printing to certain printers. Various brands and models are affected, primarily receipt or label printers that connect via USB.

Resolution: This issue is resolved by [Known Issue Rollback (KIR)](https://techcommunity.microsoft.com/t5/windows-it-pro-blog/known-issue-rollback-helping-you-keep-windows-devices-protected/ba-p/2176831).

> [!Note]
> This issue isn't related to CVE-2021-34527 or CVE-2021-1675.

### Windows Print Spooler Remote Code Execution Vulnerability

After installing update [July 6, 2021—KB5004945 (OS Builds 19041.1083, 19042.1083, and 19043.1083) Out-of-band](https://support.microsoft.com/topic/july-6-2021-kb5004945-os-builds-19041-1083-19042-1083-and-19043-1083-out-of-band-44b34928-0a71-4473-aa22-ecf3b83eed0e) and later Windows updates, users who aren't administrators can only install signed print drivers to a print server. By default, administrators can install both signed and unsigned printer drivers to a print server. The installed root certificates in the system's Trusted Root Certification Authorities trust signed drivers.

Resolution: For more information, see [KB5005010: Restricting installation of new printer drivers after applying the July 6, 2021 updates](https://support.microsoft.com/topic/kb5005010-restricting-installation-of-new-printer-drivers-after-applying-the-july-6-2021-updates-31b91c02-05bc-4ada-a7ea-183b129578a7).

## Reference

- [Troubleshooting various scenarios for printing](troubleshoot-printing-scenarios.md)
- [Known issues for printing](troubleshoot-printing-known-issues.md)
- [Point and Print Default Behavior Change](https://msrc.microsoft.com/blog/2021/08/point-and-print-default-behavior-change/)
- [Windows Print Spooler Remote Code Execution Vulnerability](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-34527)
- [Windows Release Health: Take action: Out-of-band update to address a remote code execution exploit in the Windows Print Spooler service](/windows/release-health/windows-message-center#1646)
- [Windows Key Distribution Center Information Disclosure Vulnerability](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-33764)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
