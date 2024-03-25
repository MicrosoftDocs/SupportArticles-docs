---
title: Authentication errors when client doesn't have TLS 1.2 support
description: You experience authentication and connection errors if the client doesn't support TLS 1.2.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sites\Other
  - CSSTroubleshoot
  - CI 144545
  - CI 147050
  - CI 152523
ms.collection: SPO_Content
ms.author: luche
appliesto: 
  - SharePoint Online
  - Microsoft 365
ms.date: 12/17/2023
---

# Authentication errors occur when client doesn't have TLS 1.2 support

## Summary

As previously communicated in the Microsoft 365 Admin Center (for example, communication MC240160 in February 2021), we're moving all online services to Transport Layer Security (TLS) 1.2+. This change started on October 15, 2020. Support for TLS 1.2+ will continue to be added to all Microsoft 365 environments for the next several months. If you haven't taken steps to prepare for this change, your connectivity to Microsoft 365 might be affected.


## .NET Framework not configured for TLS 1.2

### Symptom

You experience one or more of the following errors when you access SharePoint:

>Token request failed. ---> System.Net.WebException: The remote server returned an error: (401) Unauthorized.
at System.Net.HttpWebRequest.GetResponse()

>System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send.

>System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host.

>System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host.

>The Business Data Connectivity Metadata Store is currently unavailable.

### Resolution

For more information about how to configure .NET Framework to enable TLS 1.2+, see [Configure for strong cryptography](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client#configure-for-strong-cryptography).

## OS doesn't have TLS 1.2 enabled

### Symptom

Authentication issues occur in older operating systems and browsers that don’t have TLS 1.2 enabled, or in specific network configurations and proxy settings that force legacy TLS protocols.

### Resolution

### Windows 10

**Solution 1: Check cipher suites settings**

Even after you upgrade to TLS 1.2, it's important to make sure that the cipher suites settings match Azure Front Door requirements, because Microsoft 365 and Azure Front Door provide slightly different support for cipher suites.

For TLS 1.2, the following cipher suites are supported by Azure Front Door:

- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_DHE_RSA_WITH_AES_128_GCM_SHA256

To add cipher suites, either deploy a group policy or use local group policy as described in [Configuring TLS Cipher Suite Order by using Group Policy](/windows-server/security/tls/manage-tls#configuring-tls-cipher-suite-order-by-using-group-policy). 

> [!IMPORTANT]
> Edit the order of the cipher suites to ensure that these four suites are at the top of the list (the highest priority).

Alternativley, you can use the [Enable-TlsCipherSuite](/powershell/module/tls/enable-tlsciphersuite?view=windowsserver2019-ps&preserve-view=true) cmdlet to enable the TLS cipher suites. For example, run the following command to enable a cipher suite as the highest priority:

```powershell
Enable-TlsCipherSuite -Name "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384" -Position 0
```
This command adds the TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 cipher suite to the TLS cipher suite list at position 0, which is the highest priority.

> [!IMPORTANT]
> After you run Enable-TlsCipherSuite, you can verify the order of the cipher suites by running Get-TlsCipherSuite. If the order doesn't reflect the change, check if the [SSL Cipher Suite Order](/windows-server/security/tls/manage-tls#configuring-tls-cipher-suite-order-by-using-group-policy) Group Policy setting configures the default TLS cipher suite order.

For more information, see [What are the current cipher suites supported by Azure Front Door?](/azure/frontdoor/front-door-faq#what-are-the-current-cipher-suites-supported-by-azure-front-door-&preserve-view=true).

### Windows 8, Windows 7 or Windows Server 2012/2008 R2(SP1)

If you're using Windows 8, Windows 7 Service Pack 1 (SP1), Windows Server 2012 or Windows Server 2008 R2 SP1, see the following solutions.

- The [Easy Fix Tool](https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi) can add TLS 1.1 and TLS 1.2 Secure Protocol registry keys automatically. For more information, see [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392). 
- For Windows 8, install [KB 3140245](https://www.catalog.update.microsoft.com/search.aspx?q=kb3140245), and create a corresponding registry value.
- For Windows Server 2012, the [Easy Fix Tool](https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi) can add TLS 1.1 and TLS 1.2 Secure Protocol registry keys automatically. If you're still receiving intermittent connectivity errors after you run the Easy Fix Tool, consider [disabling DHE cipher suites](/security-updates/securitybulletins/2015/ms15-055#workarounds). For more information, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](/troubleshoot/windows-server/identity/apps-forcibly-closed-tls-connection-errors).

## Network drive mapped to a SharePoint library

### Symptom
   
Authentication issues or failures occur when you try to use a network drive that's mapped to a SharePoint library.

### Resolution
   
The issue might occur because of the operating system in use and whether the web client supports TLS 1.2. Support for TLS 1.2 is as follows:

- Windows 8 and Windows 7 will support TLS 1.2 after you install [KB 3140245](https://www.catalog.update.microsoft.com/search.aspx?q=kb3140245) and create a corresponding registry value. For more information, see [Update to enable TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/en-us/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392).
- Windows 8.1 will support TLS 1.2 after an update that's scheduled for the third quarter of 2021.
- Windows 10 already supports TLS 1.2.

## Browser doesn't support TLS 1.2

### Symptom
   
Authentication issues or failures to access SharePoint from known apps that don't support TLS 1.2+ occur. The following browsers don’t support TLS 1.2:

- Android 4.3 and earlier versions
- Firefox version 5.0 and earlier versions
- Internet Explorer 8-10 on Windows 7 and earlier
- Internet Explorer 10 on Windows Phone 8
- Safari 6.0.4/OS X10.8.4 and earlier versions

### Resolution
   
Upgrade to a later version of the browser.
   
## Azure App Service doesn't use the latest version of TLS and .NET Framework

### Symptom
   
Authentication issues when you use Azure App Service.

### Resolution
   
1. Set the minimum TLS version for your App Service instance to TLS 1.2. For more information, see [Enforce TLS versions](/azure/app-service/configure-ssl-bindings#enforce-tls-versions).
2. Make sure that you're using the latest version of .NET Framework.

## Hybrid search fails to crawl or return results

### Symptom
   
You experience one or more of the following issues when you use hybrid search in SharePoint in Microsoft 365:

- Crawling fails.
- No result is returned.
- You receive an error message, such as "An existing connection was forcibly closed".

### Resolution
   
To fix the issues, see [Hybrid search fails to crawl or return results](../../SharePointHybrid/search/hybrid-search-failures.md).
   
## References

- [TLS cipher suites supported by Microsoft 365](/microsoft-365/compliance/technical-reference-details-about-encryption?view=o365-worldwide#tls-cipher-suites-supported-by-office-365&preserve-view=true)
- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](/microsoft-365/compliance/prepare-tls-1.2-in-office-365?view=o365-worldwide&preserve-view=true)
- [Enable TLS Cipher Suites](/powershell/module/tls/enable-tlsciphersuite?view=windowsserver2019-ps&preserve-view=true)

