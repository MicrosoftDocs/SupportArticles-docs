---
title: Unable to request certificate with web enrollment
description: Provides solutions to an issue where you fail to request a certificate by using web enrollment.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: akhleshs, kaushika
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
---
# Not able to request certificate using web enrollment

This article provides solutions to an issue where you fail to request a certificate by using web enrollment.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2885758

## Symptoms

When you browse the CA website to request a certificate, and click on "Request a certificate" and then click on "Create and submit a request to this CA", you get the following message:

> In order to complete certificate enrollment, the web site for the CA must be configured to use HTTPS authentication

You may also see the following message next to address bar:

> Internet explorer has blocked this site from using an activeX control in an unsafe manner. As a result, this page might not display correctly.

To resolve the above errors, if you add the website URL in the trusted site zone and enable the setting "*Initialize and script ActiveX controls not marked as safe for scripting*" and then try to browse the website for certificate request, you'll get the following message:

> This web site is attempting to perform a digital certificate operation on your behalf:  
> `https://CAWebsiteURL`  
> You should only allow known web sites to perform digital certificate operations on your behalf. Do you want to allow this operation?

If you hit "OK" on the above message, you get a pop-up window with the following message:

> No certificate templates could be found. You do not have permission to request a certificate from this CA, or an error occurred while accessing the active directory.  

## Cause

If you're running CA servers on Windows 2008 R2 and above and trying to request a computer certificate templates V3 using web enrollment (CAWE), it will not work.

This was an enhancement that we introduced in Windows 2008 R2.

Now web enrollment (CAWE) doesn't support V3 templates.

You can use mmc, auto enrollment, and certreq.exe to request a V3 template.

## Resolution

Here are some possible solutions of this issue:

- Use mmc, auto enrollment, or certreq.exe to request a V3 certificate template.
- If you're hosting CA web enrollment (CAWE) on a server other than CA server, then please ensure that constrained delegation for Kerberos is enabled on the computer account of the server hosting CAWE role.
- Also, make your CA website is using SSL that is, https and not http.
