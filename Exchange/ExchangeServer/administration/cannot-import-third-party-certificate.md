---
title: Certificate status could not be determined error
description: This article provides the resolution to solve the certificate status couldn't be determined because the revocation check failed error that occurs when you try to import a third-party certificate in Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Virtual Directories configuration
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 9950
ms.reviewer: batre, skumarg, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 07/28/2026
---

# Certificate status could not be determined error generated because revocation check failed when importing a non-Microsoft certificate

_Original KB number:_ &nbsp; 979694

## Summary

This article discusses a certificate status error in Exchange Server. You can resolve this issue by configuring the WinHTTP proxy setting and the server FQDN in the WinHTTP bypass list.

## Symptoms

You import a valid third-party certificate into an Exchange Server. Then, the Exchange admin center (EAC) displays a status message like the following message:

> The certificate status could not be determined because the revocation check failed.

If you run the [Get-ExchangeCertificate](/powershell/module/exchangepowershell/get-exchangecertificate) cmdlet in the Exchange Management Shell (EMS), you receive the following status for the non-Microsoft certificate:

> Status: RevocationCheckFailure

However, if you select the Certificate Revocation List (CRL) link that is specified on the certificate, you can still access the non-Microsoft certificate through the Exchange server.

## Cause

This problem occurs because Exchange Server uses Microsoft Windows HTTP Services (WinHTTP) to manage all HTTP and HTTPS traffic. WinHTTP doesn't use the proxy settings that you configure for the internet browser.

To view the WinHTTP proxy settings, at a command prompt, run the following command:

```cmd
netsh winhttp show proxy
```

## Resolution

To resolve this issue, configure the WinHTTP proxy setting and add the Exchange Server FQDN to the WinHTTP bypass list.

> [!NOTE]
> If you don't configure both the proxy setting and the Exchange Server FQDN in the WinHTTP bypass list, the Exchange Management Shell and the Exchange admin center can't use Remote PowerShell.

To resolve this issue, open a command prompt, type the following command, and then select Enter:

```cmd
netsh winhttp set proxy proxy-server="http=myproxy" bypass-list="*.hostname.com"  
```

The *myproxy* placeholder represents the proxy server name, and *hostname* represents the Exchange Server host name.

## References

For more information about WinHTTP and about how to set the proxy on the Exchange 2010 server, see:

- [WinHttpDetectAutoProxyConfigUrl function](/windows/win32/api/winhttp/nf-winhttp-winhttpdetectautoproxyconfigurl)
