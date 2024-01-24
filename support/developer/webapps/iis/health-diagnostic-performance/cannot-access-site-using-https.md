---
title: Error page can't be displayed
description: This article describes an error (Page cannot be displayed) that occurs when you try to access an IIS site by using HTTPS after an exported certificate is installed on a Web site.
ms.date: 05/28/2020
ms.custom: sap:Health, diagnostic, and performance features
ms.technology: health-diagnostic-performance
---
# Error when you try to access a site by using HTTPS: Page cannot be displayed

This article helps you resolve the error (Page cannot be displayed) that occurs when you try to access a site by using Hypertext Transfer Protocol Secure (HTTPS).

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 824035

## Symptoms

When you try to access a site that is hosted in Microsoft Internet Information Services (IIS) and that is configured to use Secure Sockets Layer (SSL) by using the HTTPS protocol, you may receive the following error message:
> Page cannot be displayed

The following error message is logged in the Web server event logs:

> Event Type:Error
>
> Event Source:Schannel  
> Event Category:None
> Event ID:36869  
> Date:12/18/2000  
> Time:9:12:46 AM  
> User:N/A  
> Computer:<**ServerName**>  
> Description: The SSL server credential's certificate does not have a private key information property attached to it. This most often occurs when a certificate is backed up incorrectly and then later restored. This message can also indicate a certificate enrollment failure.

## Cause

This problem occurs because the Web site has been bound to a certificate that doesn't have a matching private key. If you try to export this certificate from the Certificates Microsoft Management Console (MMC), you can't export the private key. When you try to export the certificate, you receive the following warning message:
> #You DON'T have a private key that corresponds to this certificate.

## Resolution

To resolve the problem, create a new certificate with a private key. To do it, follow these steps:

1. Remove the current certificate that doesn't have a private key.

2. Obtain and install the new certificate with private key.

> [!NOTE]
> The original certificate may be repairable (from the server that initially requested the Certificate). For more information about how to repair a certificate, see [How to assign a private key to a new certificate after you use the Certificates snap-in to delete the original certificate in Internet Information Services](https://support.microsoft.com/help/889651).
