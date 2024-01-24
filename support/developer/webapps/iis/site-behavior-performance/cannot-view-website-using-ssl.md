---
title: Web browsers can't connect by using SSL
description: This article provides resolutions for the problem where you cannot use a web browser to view a website by using SSL after KB2661254 is installed.
ms.date: 04/07/2020
ms.custom: sap:Site behavior and performance
ms.technology: site-behavior-performance
ms.reviewer: radomirz, bretb, mlaing, jtinder
---
# Web browsers can't connect to a website by using SSL with KB2661254 installed

This article helps you resolve the problem where web browsers can't connect to a website by using Secure Sockets Layer (SSL) in Internet Explorer.

_Original product version:_ &nbsp; Internet Information Services 8.0, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 2744241

## Symptoms

You have a web browser installed on a computer running a Windows-based operating system. You try to use the web browser to view a website over a secure Secure Sockets Layer (SSL)/Hypertext Transfer Protocol Secure (HTTPS) connection. In this configuration, you are unable to connect to the website over SSL/HTTPS. When the problem occurs, users may see an error message similar to the following, depending on the version of their web browser:

> Cannot find server or DNS Error

Or

> There is a problem with this website's security certificate. Security certificate problems may indicate an attempt to fool you or intercept any data you send to the server

Or

> Internet Explorer Cannot Display the Webpage

When the problem occurs, you may be able to view the same website over a standard HyperText Transfer Protocol (HTTP) connection (which doesn't use SSL), and you may be able to view other websites over an SSL/HTTPS connection.

## Cause

The problem occurs because the website the client is trying to browse to over SSL has an RSA security certificate that uses cryptographic keys that are less than 1024 bits in length. For more information regarding the security impact associated with the changes made by KB2661254, see [Microsoft Security Advisory 2661254](/security-updates/SecurityAdvisories/2012/2661254).

## Resolution

See the [Microsoft Security Advisory 2661254](/security-updates/SecurityAdvisories/2012/2661254) to resolve this issue.

If you are the website Administrator and the website is running on Microsoft Internet Information Services (IIS), see the **More information** section below for information on attaining and installing SSL certificates.

## More information

- [Microsoft Security Advisory: Update for minimum certificate key length](/security-updates/SecurityAdvisories/2012/2661254)

- [How to Set Up SSL on IIS7](/iis/manage/configuring-security/how-to-set-up-ssl-on-iis)
