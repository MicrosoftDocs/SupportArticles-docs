---
title: Errors activating Microsoft 365 on older Windows versions
description: Describes errors that can occur during Windows apps activation if TLS 1.2 isn't activated.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: vikkarti, viwoods, libbyu
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\We're having trouble activating Office
  - CSSTroubleshoot
  - CI 155558
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 06/06/2024
---

# Errors activating Microsoft 365 on older Windows versions

## Summary

You receive one of the following error messages when you try to activate Microsoft 365 Apps on an older operating system, such as Windows 7 Service Pack 1 (SP1), Windows Server 2008 R2, or Windows Server 2012:

> We’re having trouble activating office<br>
> This might be due to a network or temporary service issue. Please make sure you're connected to the internet. We'll activate Office for you when the issue is resolved.

:::image type="content" source="media/errors-activating-on-older-windows/trouble-activating-office.png" alt-text="Screenshot of the error message, showing we're having trouble activating Office.":::

> Sorry, but we’re having trouble signing you in.
> AADSTS9002313: Invalid request. Request is malformed or invalid.

:::image type="content" source="media/errors-activating-on-older-windows/invalid-request.png" alt-text="Screenshot of the error message, showing request is malformed or invalid.":::

> Sorry, we are having some temporary server issues.

:::image type="content" source="media/errors-activating-on-older-windows/temp-server-issues.png" alt-text="Screenshot of the error message, showing we're having some temporary server issues.":::

## Cause

These errors typically occur if TLS 1.2 is not enabled, although there might also be other causes.

To activate Microsoft 365 Apps, TLS 1.2 must be enabled on the operating system. Some older operating systems, such as Windows 7 SP1, Windows Server 2008 R2, and Windows Server 2012, require an update to enable TLS 1.2 by default.

**Important**: Running Microsoft 365 Apps on these older operating systems isn't supported. For more information, see [End of support resources for Office](/deployoffice/endofsupport/resources#recent-end-of-support-events).

## Resolution

To resolve this issue:

1. If you are running Windows 7 or Windows Server 2008, make sure that [Service Pack 1](https://support.microsoft.com/topic/information-about-service-pack-1-for-windows-7-and-for-windows-server-2008-r2-df044624-55b8-3a97-de80-5d99cb689063) is installed.
1. Enable TLS 1.2 as the default protocol by using [this easy fix](https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi), and then restart the device.

For more information and troubleshooting guidance, see the following articles:

- [Update to enable TLS 1.1 and TLS 1.2 as default secure protocols in WinHTTP in Windows](https://support.microsoft.com/topic/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-winhttp-in-windows-c4bd73d2-31d7-761e-0178-11268bb10392)
- [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Unlicensed Product and activation errors in Office](https://support.microsoft.com/office/unlicensed-product-and-activation-errors-in-office-0d23d3c0-c19c-4b2f-9845-5344fedc4380)
- [Reset activation state for Microsoft 365 Apps for enterprise](/office/troubleshoot/activation/reset-office-365-proplus-activation-state)

## References

- [Authentication errors occur when client doesn't have TLS 1.2 support](/sharepoint/troubleshoot/administration/authentication-errors-tls12-support)
