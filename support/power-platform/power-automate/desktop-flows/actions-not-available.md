---
title: Actions are unavailable or invisible
description: Provides a resolution for the issue that some actions aren't visible in Power Automate for desktop.
ms.reviewer: dipapa
ms.date: 09/21/2022
ms.subservice: power-automate-desktop-flows
---
# Actions aren't available in Power Automate for desktop

This article provides a resolution for an issue where you can't find some actions in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5001122

## Symptoms

In Power Automate for desktop, some actions appear to be missing or aren't visible.

## Cause

This issue is caused by the inability to perform certification revocation on the library files that comprise the group of actions inside Power Automate for desktop.

The prevention of the requisite checks is caused by limited access to the web, due to configurations and rules imposed on the user's PC.

## Resolution

Power Automate for desktop is required to be online to function properly.

Validating a certification requires checking for certification revocation by either downloading a certificate revocation list (CRL) or using Online Certificate Status Protocol (OCSP).

1. The following table lists endpoint data requirements for connectivity from a user's machine for desktop flows runs.

   These endpoints should be approved from the corporate network in order to allow access to them:

   |Endpoint type|Domains|Protocols|Uses|
   |---|---|---|---|
   |Worldwide endpoints|`ocsp.digicert.com`</br>`ocsp.msocsp.com`</br>`mscrl.microsoft.com`</br>`crl3.digicert.com`</br>`crl4.digicert.com`|http|Access to the CRL server for the public cloud.|

   For more information, see [Desktop flows services required for runtime](/power-automate/ip-address-configuration#desktop-flows-services-required-for-runtime).

2. If an enterprise has restricted online access, then group policy can be used to apply an appropriate policy for the preferred method for revocation check.

## More information

- [Manage Revocation Checking Policy](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753863(v=ws.11))
- The requisite certificates can be downloaded from [MicRooCerAut2011_2011_03_22](https://www.microsoft.com/pki/certs/MicRooCerAut2011_2011_03_22.crt) and [MicCodSigPCA2011_2011-07-08](https://www.microsoft.com/pkiops/certs/MicCodSigPCA2011_2011-07-08.crt).
- The certificate revocation lists can be downloaded from [MicRooCerAut2011_2011_03_22](https://crl.microsoft.com/pki/crl/products/MicRooCerAut2011_2011_03_22.crl) and [MicCodSigPCA2011_2011-07-08](https://www.microsoft.com/pkiops/crl/MicCodSigPCA2011_2011-07-08.crl).
