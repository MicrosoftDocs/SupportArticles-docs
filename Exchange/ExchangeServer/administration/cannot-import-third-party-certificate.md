---
title: Certificate status could not be determined error
description: This article provides the resolution to solve the certificate status couldn't be determined because the revocation check failed error that occurs when you try to import a third-party certificate in Exchange Server 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Virtual Directories configuration
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, skumarg, batre, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Certificate status could not be determined because revocation check failed when importing third-party certificate

_Original KB number:_ &nbsp; 979694

## Symptoms

A valid third-party certificate is imported into an Exchange Server 2010 Client Access server (CAS). Then, the following status message is displayed in the Exchange Management Console:

> The certificate status could not be determined because the revocation check failed.

If you run the `Get-ExchangeCertificate` cmdlet in the Exchange Management Shell, you receive the following status for the third-party certificate:

> Status: RevocationCheckFailure

However, if you select the Certificate Revocation List (CRL) link that is specified on the certificate, you can still access the third-party certificate through the Exchange server.

## Cause

This issue occurs because Exchange Server 2010 uses Microsoft Windows HTTP Services (WinHTTP) to manage all HTTP and HTTPS traffic. And WinHTTP doesn't use the proxy settings that are configured for the Internet browser.

To view the WinHTTP proxy settings, at a command prompt, run the following command:

```cmd
netsh winhttp show proxy
```

## Resolution

To resolve this issue, you must configure the WinHTTP proxy setting and the server FQDN in the WinHTTP bypass list.

> [!NOTE]
> If you don't configure both the proxy setting and the server FQDN in the WinHTTP bypass list, the Exchange Management Shell and the Exchange Management Console cannot contact the Remote PowerShell.

To resolve this issue, open a command prompt, type the following command, and then press ENTER:

```cmd
netsh winhttp set proxy proxy-server="http=myproxy" bypass-list="*.host_name.com"  
```

The *myproxy* placeholder represents the proxy server name, and *host_name* represents the Exchange Server 2010 host name.

## References

For more information about WinHTTP and about how to set the proxy on the Exchange 2010 server, see:

- [Netsh Commands for Windows Hypertext Transfer Protocol (WINHTTP)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731131(v=ws.10))
- [Configure Proxy Settings for WinHTTP](/previous-versions/office/exchange-server-2010/bb430772(v=exchg.141))
- [WinHttpDetectAutoProxyConfigUrl function](/windows/win32/api/winhttp/nf-winhttp-winhttpdetectautoproxyconfigurl)
