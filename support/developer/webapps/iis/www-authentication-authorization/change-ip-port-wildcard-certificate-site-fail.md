---
title: Changing IP/port causes other sites to fail
description: This article provides resolutions for the problem where other sites on the same server don't work as expected when you change the IP/port binding of a site that is configured to use a wildcard certificate.
ms.date: 03/23/2020
ms.custom: sap:WWW authentication and authorization
ms.subservice: www-authentication-authorization
ms.reviewer: pattys
---
# Change the IP/port binding of a site that is configured to use a wildcard certificate causes other sites on the same server to fail

This article helps you resolve the problem where other sites on the same server don't work as expected when you change the IP/port binding of a site that is configured to use a wildcard certificate.

_Original product version:_ &nbsp; Internet Information Services 7.0  
_Original KB number:_ &nbsp; 2405568

## Symptom

Consider the following scenario:

- You have an Microsoft Internet Information Services (IIS) 7.0 web server that hosts multiple web sites, and all of the sites use the same IP address and port. For example, they all use the same wildcard Secure Sockets Layer (SSL) certificate and host headers.

If you use the IIS Manager to delete or change the certificate mapping for one of the sites, the same deletion or change will occur for all of the sites. Additionally if you use the IIS Manager to delete a site, the other sites that use the same IP/port binding will no longer work as expected.

## Cause

The problem occurs because the SSL certificate bindings specified by the `Http.sys` certificate configuration can only be registered using an IP/Port combination. This means that any site using the same IP/Port will have to use the same certificate regardless of the host name. This topic is described in [SSL certificates on Sites with Host Headers](https://blogs.iis.net/thomad/ssl-certificates-on-sites-with-host-headers).

The dilemma caused by this situation is how the `Microsoft.Web.Administration` handles sites with the same IP/Port combination. If a site binding changes, for example by deleting the site or changing the certificate configuration, it will apply the change to all other sites that use that specific wildcard certificate.

## Resolution

The problem only occurs when using the `Microsoft.Web.Administration` API to make the changes. For example, the problem occurs when using the IIS Manager, because the IIS Manager relies on the `Microsoft.Web.Administration` API. To avoid this problem, use the appcmd.exe tool to delete the site or certificate binding. The appcmd.exe tool doesn't use the `Microsoft.Web.Administration` API.

For example, to delete a site called *MyWebsite*, run the following  command:

```console
appcmd.exe delete site "MyWebsite"
```

## References

[Getting Started with AppCmd.exe](/iis/get-started/getting-started-with-iis/getting-started-with-appcmdexe)
