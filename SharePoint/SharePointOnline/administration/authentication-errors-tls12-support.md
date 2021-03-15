---
title: Authentication errors when client doesn't have TLS 1.2 support
description: You experience authentication and connection errors if the client doesn't support TLS 1.2.
author: v-matham
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-solutions
ms.topic: article
ms.custom: CSSTroubleshoot
ms.collection: SPO_Content
ms.author: v-matham
appliesto:
- SharePoint Online
- Microsoft 365
---

# Authentication errors occur if client doesn't have TLS 1.2 support

## Summary

As previously communicated in the Microsoft 365 Admin Center (for example, communication MC240160 in February 2021), we're moving all online services to Transport Layer Security (TLS) 1.2+. This change started on October 15, 2020. Support for TLS 1.2+ will continue to be added to all Microsoft 365 environments for the next several months. If you haven't taken steps to prepare for this change, your connectivity to Microsoft 365 might be affected.

## Known issues

- **Issue 1**

   **Symptom**

   You experience one or more of the following errors when you access SharePoint:

   System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send.

   System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host.

   System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host.

   **Resolution**
   
   For more information about how to configure .NET Framework to enable TLS 1.2+, see [Configure for strong cryptography](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client#configure-for-strong-cryptography).

- **Issue 2**

   **Symptom**
   
   Authentication issues occur in older operating systems and browsers that don’t have TLS1.2 enabled, or in specific network configurations and proxy settings that force legacy TLS protocols.

   **Resolution**
   
   For more information, see [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](/microsoft-365/compliance/prepare-tls-1.2-in-office-365?view=o365-worldwide&preserve-view=true).<br/>

- **Issue 3**

   **Symptom**
   
   Authentication issues or failures occur when you try to use a network drive that's mapped to a SharePoint library.

   **Resolution**
   
   The issue might occur because the operating system is in use and whether the web client supports TLS 1.2. Web Client. Support for TLS 1.2 is as follows:

   Windows 8 and Windows 7 will support TLS 1.2 after you install [KB 3140245](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392) and create a corresponding registry value. For more information, see [Update to enable TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/en-us/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392).

   Windows 8.1 will support TLS 1.2 after an update that's scheduled for the third quarter of 2021.

   Windows 10 already supports TLS 1.2.

- **Issue 4**

   **Symptom**
   
   Authentication issues or failures to access SharePoint from known apps that do not support TLS 1.2+ occur. The following browsers don’t support TLS 1.2:

    - Android 4.3 and earlier versions
    - Firefox version 5.0 and earlier versions
    - Internet Explorer 8-10 on Windows 7 and earlier
    - Internet Explorer 10 on Windows Phone 8
    - Safari 6.0.4/OS X10.8.4 and earlier versions


   **Resolution**
   
   Upgrade to a later version of the browser.
