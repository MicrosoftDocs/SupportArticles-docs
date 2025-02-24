---
title: Required trusted root certificates
description: Lists the trusted root certificates that are required by Windows operating systems. These trusted root certificates are required for the operating system to run correctly.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:certificates and public key infrastructure (pki)\active directory certificate services (adcs)
- pcy:WinComm Directory Services
---
# Required trusted root certificates

This article lists the trusted root certificates that are required by Windows operating systems. These trusted root certificates are required for the operating system to run correctly.

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client  
_Original KB number:_ &nbsp; 293781

## Summary

As part of a public key infrastructure (PKI) trust management procedure, some administrators may decide to remove trusted root certificates from a Windows-based domain, server, or client. However, the root certificates that are listed in the [Necessary and trusted root certificates](#necessary-and-trusted-root-certificates) section in this article are required for the operating system to operate correctly. Removal of the following certificates may limit functionality of the operating system or may cause the computer to fail. Do not remove them.

## Necessary and trusted root certificates

The following ROOT certificates are necessary and trusted in Windows 10 and newer operating systems:

|Issued to|Issued by|Serial number|Expiration date|Intended purposes|Friendly name|
|---|---|---|---|---|---|
|Microsoft Root Authority|Microsoft Root Authority|00c1008b3c3c8811d13ef663ecdf40|12/31/2020|All|Microsoft Root Authority|
|Microsoft Root Certificate Authority|Microsoft Root Certificate Authority|79ad16a14aa0a5ad4c7358f407132e65|5/9/2021|All|Microsoft Root Certificate Authority|
|Microsoft Root Certificate Authority 2010|Microsoft Root Certificate Authority 2010|28cc3a25bfba44ac449a9b586b4339aa|6/23/2035|All|Microsoft Root Certificate Authority 2010|
|Microsoft Root Certificate Authority 2011|Microsoft Root Certificate Authority 2011|3f8bc8b5fc9fb29643b569d66c42e144|3/22/2036|All|Microsoft Root Certificate Authority 2011|
|Copyright (c) 1997 Microsoft Corp.|Copyright (c) 1997 Microsoft Corp.|01|12/30/1999|Time Stamping|Microsoft Timestamp Root|
|Microsoft Authenticode(tm) Root Authority|Microsoft Authenticode(tm) Root Authority|01|12/31/1999|Secure E-mail, Code Signing|Microsoft Authenticode(tm) Root|
|NO LIABILITY ACCEPTED, (c)97 VeriSign, Inc.|NO LIABILITY ACCEPTED, (c)97 VeriSign, Inc.|4a19d2388c82591ca55d735f155ddca3|1/7/2004|Time Stamping|VeriSign Time Stamping CA|
|Thawte Timestamping CA|Thawte Timestamping CA|00|12/31/2020|Time Stamping|Thawte Timestamping CA|

The following trusted root certificates were not included in Windows 8 / Windows Server 2012, but are included in Windows 10 and newer operating systems:

|Issued to|Issued by|Serial number|Expiration date|Intended purposes|Friendly name|
|---|---|---|---|---|---|
|Symantec Enterprise Mobile Root for Microsoft|Symantec Enterprise Mobile Root for Microsoft|0f6b552f9ebf907b0f6629a9bdf4d8ce|3/14/2032|Code Signing|None|
|Microsoft ECC Product Root Certificate Authority 2018|Microsoft ECC Product Root Certificate Authority 2018|14982666dc7ccd8f4053677bb999ec85|2/27/2043|All|Microsoft ECC Product Root Certificate Authority 2018|
|Microsoft ECC TS Root Certificate Authority 2018|Microsoft ECC TS Root Certificate Authority 2018|153875e1647ed1b047b4efaf41128245|2/27/2043|All|Microsoft ECC TS Root Certificate Authority 2018|
|Microsoft Time Stamp Root Certificate Authority 2014|Microsoft Time Stamp Root Certificate Authority 2014|2fd67a432293329045e953343ee27466|10/22/2039|All|Microsoft Time Stamp Root Certificate Authority 2014|

Some certificates that are listed in the previous tables have expired. However, these certificates are necessary for backward compatibility. Even if there's an expired trusted root certificate, anything that was signed by using that certificate _before_ the expiration date requires that the trusted root certificate is validated. As long as expired certificates aren't revoked, they can be used to validate anything that was signed before their expiration.
