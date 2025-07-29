---
title: Windows Activation or Validation Fails with Error Code 0x8004FE33
description: Provides a workaround to an issue in which Windows activation or validation fails with error code 0x8004FE33.
ms.date: 07/25/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
---
# Windows activation or validation fails with error code 0x8004FE33

## Symptoms

Windows activation or validation fails when you try to activate Windows operating systems over the Internet.

Additionally, you may receive one or more of the following errors:

- > Error code: 0x80004005 Description: License Activation (SLUI.exe) failed.
- > Error code: 0x8004FE33 Description: Acquisition of Secure Processor Certificate failed.
- > The activation failure does not prompt you for credentials.

These problems may occur when you connect to the Internet through a proxy server on which Basic authentication is enabled.

> [!Note]
> If the proxy server is configured for Basic authentication, the server requires that you type a username and a password. However, the activation user interface does not let you enter these credentials. Therefore, the Basic authentication fails, and activation fails.

If you experience other errors than those mentioned above when you try to activate Windows, go to the following Windows websites for more troubleshooting information:

- [Get help with activation errors](https://support.microsoft.com/windows/get-help-with-windows-activation-errors-09d8fb64-6768-4815-0c30-159fa7d89d85)
- [Why can't I activate Windows?](https://windows.microsoft.com/windows-8/why-activate-windows)

## Workaround

### Method 1: Activate Windows by telephone

Use the Windows Activation Wizard to activate Windows through the automated telephone system. To do this, follow these steps for your version of the operating system.  

Windows 8 and later versions:

1. Swipe in from the right edge of the screen, and then tap **Search**. Or, if you're using a mouse, point to the lower-right corner of the screen, and then select **Search**.
2. Type **SLUI 04**, and then tap or select the displayed icon to open the wizard.

Windows Vista and Windows 7:

1. Select **Start**, and then select **Run**.
2. Type **SLUI 04**, and then select **OK** to open the wizard.

### Method 2: Configure the proxy server to disable Basic authentication

Configure the proxy server to disable Basic authentication. For information about how to use this method, see the documentation that is included with the proxy software.

### Method 3: Configure the proxy server to exclude URLs for certificate revocation lists

Configure the proxy server to exclude the URLs for the certificate revocation lists (CRLs) from the requirements for Basic authentication. To do this, configure the following list of CRLs to be unauthenticated on the proxy server:

- `https://go.microsoft.com/`
- `http://go.microsoft.com/`
- `https://login.live.com`
- `https://activation.sls.microsoft.com/`
- `http://crl.microsoft.com/pki/crl/products/MicProSecSerCA_2007-12-04.crl`
- `https://validation.sls.microsoft.com/`
- `https://activation-v2.sls.microsoft.com/`
- `https://validation-v2.sls.microsoft.com/`
- `https://displaycatalog.mp.microsoft.com/`
- `https://licensing.mp.microsoft.com/`
- `https://purchase.mp.microsoft.com/`
- `https://displaycatalog.md.mp.microsoft.com/`
- `https://licensing.md.mp.microsoft.com/`
- `https://purchase.md.mp.microsoft.com/`

For information about how to use this method, see the documentation that is included with the proxy software.

> [!Note]
> Microsoft cannot supply IP addresses or ranges of the servers listed above. The URL must be used.

## More information

For more information about Windows Vista Volume Activation 2.0, see [Volume activation for Windows](/windows/deployment/volume-activation/volume-activation-windows).

For more information how to troubleshoot Volume Activation error codes, see [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes).

If these articles don't help you resolve the problem, search the Microsoft Knowledge Base for more information. To search the Microsoft Knowledge Base, go to [Microsoft Support](https://support.microsoft.com). Type the text of the error message that you receive, or type a description of the problem.
