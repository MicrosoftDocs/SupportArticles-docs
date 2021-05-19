---
title: Authentication errors occur when connecting to SharePoint or OneDrive from Windows 7 or 8
description: You experience authentication errors when connecting to SharePoint or OneDrive from Windows 7 or Windows 8.
author: v-matham
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.custom: 
- CSSTroubleshoot
- CI 148433
ms.collection: SPO_Content
ms.author: v-matham
appliesto:
- SharePoint Online
- Windows 7
- Windows 8
---

# Authentication errors when connecting to SharePoint or OneDrive from Windows 7 or 8

## Summary

As previously communicated in the Microsoft 365 Admin Center (for example, communication MC240160 in February 2021), we're moving all online services to Transport Layer Security (TLS) 1.2+. This change started on October 15, 2020. Support for TLS 1.2+ will continue to be added to all Microsoft 365 environments for the next several months. If you haven't taken steps to prepare for this change, your connectivity to Microsoft 365 might be affected.

Make sure that you carefully review information about [TLS deprecation](/microsoft-365/compliance/tls-1.0-and-1.1-deprecation-for-office-365?view=o365-worldwide&preserve-view=true). That change might also cause this error.

 > [!NOTE]
 > Even after you upgrade to TLS 1.2, it's important to make sure that the cipher suites settings match Azure Front Door requirements because Microsoft 365 and Azure Front Door provide slightly different support for cipher suites.
>
> For TLS 1.2, the following cipher suites are supported by Azure Front Door:
>
> - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
> - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
> - TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
> - TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
> 
> To add cipher suites, either deploy a group policy as described in [Configuring TLS Cipher Suite Order by using Group Policy](/windows-server/security/tls/manage-tls#configuring-tls-cipher-suite-order-by-using-group-policy&preserve-view=true)
> 
> or use PowerShell by following the instructions to [Enable-TlsCipherSuite](/powershell/module/tls/enable-tlsciphersuite?view=windowsserver2019-ps&preserve-view=true).
>
> For more information, see [What are the current cipher suites supported by Azure Front Door?](/azure/frontdoor/front-door-faq#what-are-the-current-cipher-suites-supported-by-azure-front-door-&preserve-view=true).

## Symptoms

When you access a Microsoft SharePoint or OneDrive website from Windows 8 or Windows 7 Service Pack 1 (SP1), you receive one of the following error messages:

> Error code: 0x8004de40

> The remote server returned an error: (400) Bad Request

> The underlying connection was closed

## Resolution

To avoid this problem, Windows 8 and Windows 7 SP1 clients must have TLS 1.2 enabled.

Install KB 3140245, and then create the related registry value. For more information, see [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392).  

Windows 8 and Windows 7 SP1 clients must have the latest TLS cipher suites installed. For more information, see [Microsoft Security Advisory 3042058](/security-updates/SecurityAdvisories/2015/3042058). This update is already included in the latest cumulative update for Windows 7 and Windows 8.


## References 

- [TLS cipher suites supported by Office 365](/microsoft-365/compliance/technical-reference-details-about-encryption?view=o365-worldwide#tls-cipher-suites-supported-by-office-365&preserve-view=true)

- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](/microsoft-365/compliance/prepare-tls-1.2-in-office-365?view=o365-worldwide&preserve-view=true)

- [Enable TLS Cipher Suites](/powershell/module/tls/enable-tlsciphersuite?view=windowsserver2019-ps&preserve-view=true)
