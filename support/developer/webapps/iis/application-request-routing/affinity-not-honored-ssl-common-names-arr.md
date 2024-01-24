---
title: SSL Common Names aren't enforced by ARR
description: This article provides resolutions for the two problems where Affinity isn't honored and SSL Common Names aren't enforced using ARR in IIS.
ms.date: 04/17/2020
ms.custom: sap:Application Request and Routing (ARR)
ms.technology: application-request-routing
---
# Affinity is not honored and SSL Common Names aren't enforced using ARR in IIS

This article helps you resolve the problems where Affinity isn't honored and SSL Common Names aren't enforced by using Application Request Routing (ARR) in Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Internet Information Services 8.0, 7.5, 7.0  
_Original KB number:_ &nbsp; 2693489

## Issue 1: ARR client affinity fails

You have configured ARR with load balancing of two or more IIS servers. Your website is configured on an HTTP port other than port 80, or your website address isn't a fully qualified domain name (FQDN). You also have enabled client affinity in ARR. In this scenario, ARR client affinity fails. This could cause problems with a website that relies on session-based data for a request, because the request was forwarded to an IIS server other than the original one.

### Cause for Issue 1

This issue occurs due to ARR generating the session cookie with domain parameters that include the HTTP port number. This makes the web browser ignore the cookie for the website, causing affinity to fail on the next request due to the missing cookie.

### Resolution for Issue 1

This issue has been fixed as part of this software update to ARR.

## Issue 2: ARR doesn't enforce Common Name Restrictions

When proxying a request using Secure Socket Layers (SSL) to an application server, ARR doesn't enforce Common Name Restrictions on the SSL certificate hosted on the application server.

### Cause for Issue 2

In a standard IIS web application scenario where ARR isn't configured, this scenario would result in an error message in the web browser alerting the user that the website's address doesn't match the address in the security certificate; the user would then be given the opportunity to deny the name mismatch or to accept it and continue browsing to the site. The initial release of ARR doesn't have support for this alert functionality and the certificate name mismatch was silently ignored.

### Resolution for Issue 2

As part of this software update release, support has been added to allow administrators to configure ARR to enforce the common name match requirement. Full documentation of this new feature can be found in
[ARR: Support Added for WINHTTP_OPTION_SECURITY_FLAGS](/iis/extensions/configuring-application-request-routing-arr/arr-support-added-for-winhttpoptionsecurityflags).

To obtain this software update, follow one of the links below:

- [Hotfix for Microsoft Application Request Routing Version 2.5 for IIS8 and above (x64)](https://www.microsoft.com/download/details.aspx?id=35827)

## References

- [Server Affinity Page](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd443543(v=ws.10))

- [WinHTTP Option Flags](/windows/win32/winhttp/option-flags)
