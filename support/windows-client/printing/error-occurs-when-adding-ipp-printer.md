---
title: Error occurs when adding an IPP printer
description: Provides a solution to an error that occurs when you try to add an IPP printer over HTTPS.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, mattburr
ms.custom: sap:errors-and-troubleshooting:-general-issues, csstroubleshoot
---
# When attempting to add an IPP printer over HTTPS, you receive an error

This article provides a solution to an error that occurs when you try to add an IPP printer over HTTPS.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2021626

## Symptoms

When attempting to add an IPP printer to a Windows Vista or Windows 7 workstation over HTTPS, the queue may fail to install with the following error:

> Add Printer  
Connect to Printer  
Windows couldn't connect to the printer. Check the printer name and try again. If this is a network printer, make sure that the printer is turned on, and that the printer address is correct.

## Cause

This issue occurs because Windows does not trust or cannot validate the SSL certificate being used by the print server, or the print server is using a self-signed certificate.

## Resolution

This can be resolved by either:

- Configuring the print server to use a valid SSL certificate from an external certificate authority trusted by the workstation.
- If both the print server and the workstation are in the same domain, configuring the print server to use a valid SSL certificate from an enterprise certificate authority.
- If the print server is using a self-signed certificate, installing the self-signed certificate on the workstation.

### How to Install an IPP Print Server's Self-Signed Certificate on a Windows Client

If your print server is using self-signed certificates, the following steps can be used to install the self-signed certificate on the client(s) so they are able to use the printer.

> [!NOTE]
> This should only be performed for SSL certificates from servers you trust.

1. Log on to the client as an administrator
2. Find Internet Explorer in the start menu, right-click on it, and click **Run as administrator**.
3. In Internet Explorer, browse to the Print Server using HTTPS (for example, `https://PrintServerName/`)
4. In the address bar, the words "Certificate Error" should appear on the right side next to a Red shield icon - click on the error.
5. Click **View Certificates**.
6. On the certificate window, click **Install Certificate...**.
7. Select **Place all certificates in the following store**.
8. Click **Browse...**.
9. Select **Trusted Root Certification Authorities** and click **OK**.
10. Click **Next**, then click **Finish**.
11. A security warning will appear that you are adding a certificate from a source that cannot be validated.  Click **Yes** to trust this SSL certificate.
12. Close Internet Explorer.
13. The printer can now be installed.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#printing).
