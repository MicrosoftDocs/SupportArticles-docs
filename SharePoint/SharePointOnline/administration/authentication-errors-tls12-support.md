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

# Authentication errors when client doesn't have TLS 1.2 support

## Summary

As previously communicated in the Microsoft Admin Center (such as communication MC240160 in February 2021) we're moving all our online services to Transport Layer Security (TLS) 1.2+. The changes to enforce TLS 1.2+ in our services started on October 15, 2020 and will continue to be added to all Microsoft 365 environments for the next few months. If you haven't taken steps to prepare for this change, your connectivity to Microsoft 365 might be affected.

## Known Issues

- **Symptom:** You might experience the following error(s) when accessing SharePoint:
    - System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send.
    - System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host.
    - System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host.
- **Resolution:** For more information about configuring .NET framework to enable TLS1.2+, see [Configure for strong cryptography](https://docs.microsoft.com/mem/configmgr/core/plan-design/security/enable-tls-1-2-client#configure-for-strong-cryptography).<br/><br/>

- **Symptom:** Authentication issues from older operating systems/browsers that don’t have TLS1.2 enabled or specific network configuration/proxy settings that force one of the legacy TLS protocols.
- **Resolution:** For more information, see [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](https://docs.microsoft.com/microsoft-365/compliance/prepare-tls-1.2-in-office-365?view=o365-worldwide).<br/><br/>

- **Symptom:** Authentication issues or failures when attempting to use a mapped network drive to a SharePoint library.
- **Resolution:** The issue might be because of the operating system in use and whether the web client supports TLS 1.2. Web Client. Support for TLS 1.2 is as follows:
    - Windows 8 and Windows 7 will support TLS 1.2 after installing [KB3140245](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392) and creating a registry value. For more information, see [Update to enable TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/en-us/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392).
    - Windows 8.1 will support TLS 1.2 after an update scheduled for the third quarter of 2021.
    - Windows 10 already supports TLS 1.2.
<br/><br/>
- **Symptom:** Authentication issues or failures accessing SharePoint from known apps that do not support TLS 1.2+. The following browsers don’t support TLS 1.2: 
    - Android 4.3 and earlier versions.
    - Firefox version 5.0 and earlier versions.
    - Internet Explorer 8-10 on Windows 7 and earlier.
    - Internet Explorer 10 on Windows Phone 8.
    - Safari 6.0.4/OS X10.8.4 and earlier versions.
- **Resolution:** Upgrade to a later version of your browser.
