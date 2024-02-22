---
title: Hybrid search fails to crawl or return results
description: Hybrid search fails to crawl or return results. Or, it returns the error An existing connection was forcibly closed.
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: salarson
ms.custom: 
  - CSSTroubleshoot
  - CI 151765
appliesto: 
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
  - SharePoint in Microsoft 365
ms.date: 12/17/2023
---

# Hybrid search fails to crawl or return results

## Symptoms

You experience one or more of the following issues when you use [hybrid search in SharePoint in Microsoft 365](/sharepoint/hybrid/hybrid-search-in-sharepoint):

- Crawling fails.
- No result is returned.
- You receive an error message, such as "An existing connection was forcibly closed."

## Cause

We have begun deprecation of TLS 1.1 and 1.0 in Microsoft 365. Starting on June 30, 2021, the Search service will no longer accept connections that use TLS 1.1 or 1.0. If you're using the cloud Search service application (SSA) on older versions of Windows, you have to manually enable TLS 1.2 to have on-premises content indexed in SharePoint in Microsoft 365.

## Resolution

To fix this issue, enable TLS 1.2 by following these instructions:

- [Enable TLS and SSL support in SharePoint 2013](/sharepoint/security-for-sharepoint-server/enable-tls-and-ssl-support-in-sharepoint-2013)
- [Enable TLS 1.1 and TLS 1.2 support in SharePoint Server 2016](/sharepoint/security-for-sharepoint-server/enable-tls-1-1-and-tls-1-2-support-in-sharepoint-server-2016)
- [Enable TLS 1.1 and TLS 1.2 support in SharePoint Server 2019](/sharepoint/security-for-sharepoint-server/enable-tls-1-1-and-tls-1-2-support-in-sharepoint-server-2019)

> [!NOTE]
> If you still experience these issues in Windows Server 2012 or Windows Server 2008 R2 SP1, try the following solutions:
>
> - The [Easy Fix Tool](https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi) can add TLS 1.2 and TLS 1.1 Secure Protocol registry keys automatically. For more information, see [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392).
> - For Windows Server 2012, if you still receive intermittent connectivity errors after you run the Easy Fix Tool, consider [disabling DHE cipher suites](/security-updates/securitybulletins/2015/ms15-055#workarounds). For more information, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](/troubleshoot/windows-server/identity/apps-forcibly-closed-tls-connection-errors).

Also, check the supported cipher suites and cipher suite sort order. For TLS 1.2, the following cipher suites are supported by Azure Front Door:

- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_DHE_RSA_WITH_AES_128_GCM_SHA256

To add cipher suites, either deploy a Group Policy setting or use the Local Group Policy Editor, as described in [Configuring TLS Cipher Suite Order by using Group Policy](/windows-server/security/tls/manage-tls#configuring-tls-cipher-suite-order-by-using-group-policy).

> [!IMPORTANT]
> Change the order of the cipher suites to make sure that these four suites are at the top of the list (the highest priority).

For more information, see [What are the current cipher suites supported by Azure Front Door?](/azure/frontdoor/front-door-faq#what-are-the-current-cipher-suites-supported-by-azure-front-door-).

## References

- [Preparing for TLS 1.2 in Microsoft 365 and Microsoft 365 GCC](/microsoft-365/compliance/prepare-tls-1.2-in-office-365?view=o365-worldwide&preserve-view=true)
- [Authentication errors occur when client doesn't have TLS 1.2 support](../../SharePointOnline/administration/authentication-errors-tls12-support.md)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
