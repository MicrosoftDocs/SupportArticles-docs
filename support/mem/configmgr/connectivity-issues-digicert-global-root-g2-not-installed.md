---
title: Connectivity issues when the DigiCert Global Root G2 root certificate is not installed
description: Fixes a connectivity issue where the DigiCert Global Root G2 root certificate is not installed.
ms.date: 10/22/2020
ms.prod-support-area-path:
---

# Connectivity issues when the DigiCert Global Root G2 root certificate is not installed

## Symptoms

Connectivity issues may occur on a Configuration Manager service connection point role, and you may see either of the below symptoms:

- You see the following status message IDs being generated on uploads or syncs to Configuration Manager cloud services which indicate a communication failure:

  - **9605: DMP_UPLOADER_UPLOAD_FAILED**
  - **9607: DMP_UPLOADER_UPLOAD_EXCEPTION**
  
- You see an error message in the Configuration Manager logs which says:

  - **Failed to check and load service signing certificate. System.ArgumentException: Fail to build chain**

## Cause

This issue can occur when any of the following conditions are true:

- The automatic root certificate mechanism is disabled.
- The **DigiCert Global Root G2** root certificate isn’t installed.
- The intermediate certificates aren’t installed in the **Intermediate Certification Authorities** store.
- Your environment allows outbound calls to only specific **Certificate Revocation List (CRL)** downloads and/or **Online Certificate Status Protocol (OCSP)** verification locations.

## Resolution

Install the latest root certificates. The root certificates may not automatically install if you’re running a disconnected environment, or if the needed internet endpoints are blocked.  

### Disconnected environments

Update trusted root and disallowed **Certificate Trust Lists (CTLs)** within disconnected environments.

However, within disconnected environments, administrators must set up either a file share or a web server to host the files internally. Group policy settings are also updated so that the clients and servers use the internal file share or web server, instead of the internet location.

Systems running within disconnected environments need to have the new roots added to the **Trusted Root Certification Authorities** store, and the intermediates added to the **Intermediate Certification Authorities** store.

Consider your environment disconnected if either of the following conditions are true:

- Direct access to Windows Update is blocked.
- The auto update mechanism for both trusted and untrusted CTLs is disabled.

For information on how to facilitate the distribution of trusted or untrusted certificates for disconnected environments, see [Configure Trusted Roots and Disallowed Certificates](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983%28v=ws.11%29).

### Internet endpoints

If you have an environment where rules are set to allow outbound calls to only specific **Certificate Revocation List (CRL)** downloads, and/or **Online Certificate Status Protocol (OCSP)** verification locations, then you must allow the following CRL and OCSP URLs:

- [http://crl3.digicert.com](http://crl3.digicert.com)
- [http://crl4.digicert.com](http://crl4.digicert.com)
- [http://ocsp.digicert.com](http://ocsp.digicert.com)
- [http://www.d-trust.net](http://www.d-trust.net)
- [http://root-c3-ca2-2009.ocsp.d-trust.net](http://root-c3-ca2-2009.ocsp.d-trust.net)
- [http://ctldl.windowsupdate.com](http://ctldl.windowsupdate.com)
- [https://mscrl.microsoft.com](http://mscrl.microsoft.com)
- [https://crl.microsoft.com](http://crl.microsoft.com)
- [https://oneocsp.microsoft.com](http://oneocsp.microsoft.com)
- [http://ocsp.msocsp.com](http://ocsp.msocsp.com)
