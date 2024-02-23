---
title: Authentication errors occur when connecting to SharePoint or OneDrive from Windows 7 or 8
description: You experience authentication errors when connecting to SharePoint or OneDrive from Windows 7 or Windows 8.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 148433
ms.collection: SPO_Content
ms.author: luche
appliesto: 
  - SharePoint Online
  - Windows 7
  - Windows 8
ms.date: 12/17/2023
---

# Authentication errors when connecting to SharePoint or OneDrive from Windows 7 or 8

## Summary

As previously communicated in the Microsoft 365 Admin Center (for example, communication MC240160 in February 2021), we're moving all online services to Transport Layer Security (TLS) 1.2+. This change started on October 15, 2020. Support for TLS 1.2+ will continue to be added to all Microsoft 365 environments for the next several months. If you haven't taken steps to prepare for this change, your connectivity to Microsoft 365 might be affected.

Make sure that you carefully review information about [TLS deprecation](/microsoft-365/compliance/tls-1.0-and-1.1-deprecation-for-office-365). That change might also cause this error.


## Symptoms

When you access a Microsoft SharePoint or OneDrive website from Windows 8 or Windows 7 Service Pack 1 (SP1), you receive one of the following error messages:

> Error code: 0x8004de40

> The remote server returned an error: (400) Bad Request

> The underlying connection was closed

## Resolution

- Windows 8 and Windows 7 will support TLS 1.2 after you install [KB 3140245](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392) and create a corresponding registry value.
- For Windows 7, you may opt to add TLS 1.1/1.2 secure protocol registry keys automatically by running the [Easy Fix Tool](https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi). For more information, see [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392).

## References

- [TLS cipher suites supported by Microsoft 365](/microsoft-365/compliance/technical-reference-details-about-encryption?view=o365-worldwide#tls-cipher-suites-supported-by-office-365&preserve-view=true)

- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](/microsoft-365/compliance/prepare-tls-1.2-in-office-365?view=o365-worldwide&preserve-view=true)


