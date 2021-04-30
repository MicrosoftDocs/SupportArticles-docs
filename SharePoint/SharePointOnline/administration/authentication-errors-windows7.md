---
title: Authentication errors occur when connecting to SharePoint or OneDrive from Windows 8 or 7
description: You experience authentication and connection errors if the client doesn't support TLS 1.2.
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

# Authentication errors when connecting to SharePoint or OneDrive from Windows 8 or 7

## Summary

As previously communicated in the Microsoft 365 Admin Center (for example, communication MC240160 in February 2021), we're moving all online services to Transport Layer Security (TLS) 1.2+. This change started on October 15, 2020. Support for TLS 1.2+ will continue to be added to all Microsoft 365 environments for the next several months. If you haven't taken steps to prepare for this change, your connectivity to Microsoft 365 might be affected.

## Symptoms

When you access a Microsoft SharePoint or OneDrive website from Windows 8 or Windows 7 Service Pack 1 (SP1), you receive one of the following error messages:

> Error code: 0x8004de40

> The remote server returned an error: (400) Bad Request

> The underlying connection was closed

## Resolution

To avoid this problem, Windows 8 and Windows 7 SP1 clients must have TLS 1.2 enabled.

Install KB 3140245, and then create the related registry value. For more information, see [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392).  

Windows 8 and Windows 7 SP1 clients must have the latest TLS cipher suites installed. For more information, see [Microsoft Security Advisory 3042058](/security-updates/SecurityAdvisories/2015/3042058). This update is already included in the latest cumulative update for Windows 7 and Windows 8.

For more information, see [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](/microsoft365/compliance/prepare-tls-1.2-in-office-365).