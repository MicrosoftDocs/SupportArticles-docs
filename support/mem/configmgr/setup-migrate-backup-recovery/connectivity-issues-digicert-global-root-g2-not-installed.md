---
title: Connectivity issues if the DigiCert Global Root G2 root certificate is not installed
description: Fixes a connectivity issue in which the DigiCert Global Root G2 root certificate is not installed.
ms.date: 12/05/2023
author: helenclu
ms.author: vinpa
ms.reviewer: kaushika, vinpa
---

# Connectivity issues if the DigiCert Global Root G2 root certificate is not installed

## Symptoms

You experience connectivity issues on a Microsoft Endpoint Configuration Manager service connection point role. When these issues occur, you experience either of the following symptoms:

- During uploads or syncs to Configuration Manager cloud services, you receive the following status message IDs that indicate a communications failure:

  - **9605: DMP_UPLOADER_UPLOAD_FAILED**
  - **9607: DMP_UPLOADER_UPLOAD_EXCEPTION**
  
- The following error entry is logged in the Configuration Manager logs:

  - **Failed to check and load service signing certificate. System.ArgumentException: Fail to build chain**

## Cause

This issue can occur if any of the following conditions are true:

- The automatic root certificate mechanism is disabled.
- The **DigiCert Global Root G2** root certificate isn't installed.
- The intermediate certificates aren't installed in the **Intermediate Certification Authorities** store.
- Your environment allows outbound calls to only specific **Certificate Revocation List (CRL)** downloads or **Online Certificate Status Protocol (OCSP)** verification locations.

## Resolution

Install the latest root certificates. The root certificates may not automatically install if you're running a disconnected environment, or if the necessary internet endpoints are blocked.

### Disconnected environments

Update trusted root certificates and disallowed **Certificate Trust Lists (CTLs)** within disconnected environments.

Within disconnected environments, administrators must set up either a file share or a web server to host the files internally. Group Policy settings are also updated so that the clients and servers use the internal file share or web server instead of the internet location.

Systems that are running within disconnected environments have to have the new roots added to the **Trusted Root Certification Authorities** store, and have the intermediates added to the **Intermediate Certification Authorities** store.

You can consider your environment to be disconnected if either of the following conditions is true:

- Direct access to Windows Update is blocked.
- The auto update mechanism for both trusted and untrusted CTLs is disabled.

For information about how to facilitate the distribution of trusted or untrusted certificates for disconnected environments, see [Configure Trusted Roots and Disallowed Certificates](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983%28v=ws.11%29).

### Internet endpoints

If you have an environment in which rules are set to allow outbound calls to only specific **Certificate Revocation List (CRL)** downloads, or **Online Certificate Status Protocol (OCSP)** verification locations, you must allow the following CRL and OCSP URLs:

- `http://crl3.digicert.com`
- `http://crl4.digicert.com`
- `http://ocsp.digicert.com`
- `http://www.d-trust.net`
- `http://root-c3-ca2-2009.ocsp.d-trust.net`
- `http://ctldl.windowsupdate.com`
- `https://mscrl.microsoft.com`
- `https://crl.microsoft.com`
- `https://oneocsp.microsoft.com`
- `http://ocsp.msocsp.com`

## More Information

Microsoft maintains the list of root certificates that are distributed by the **Windows Root Certificate Program**, on the program website.

For more information about the **Windows Root Certificate Program** and the list of certification authorities (CAs) who are members, see [Release notes - Microsoft Trusted Root Certificate Program](/security/trusted-root/release-notes).

Root certificate update mechanisms are available in different versions of Windows. This includes the automatic root update mechanisms.

 For more information about how to update the root certificate list in different versions of Windows, see [Configure Trusted Roots and Disallowed Certificates](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983%28v=ws.11%29?redirectedfrom=MSDN).

By default, the automatic root update mechanism is enabled in different versions of Windows. However, if this mechanism is disabled, and  the service connection point server doesn't have the **DigiCert Global Root G2** root certificate installed, connectivity issues with **Configuration Manager** cloud services may occur. The **Configuration Manager** on premises hierarchy may no longer be able to access the **Microsoft Configuration Manager** cloud services and other such resources.

 For more information, see [Azure TLS certificate changes](/azure/security/fundamentals/tls-certificate-changes) and [Azure IoT TLS: Changes are coming](https://techcommunity.microsoft.com/t5/internet-of-things/azure-iot-tls-changes-are-coming-and-why-you-should-care/ba-p/1658456).

### Next steps

For additional information about connectivity requirements and troubleshooting for **Configuration Manager**, see the following items:

- [Internet endpoint requirements for Configuration Manager](/mem/configmgr/core/plan-design/network/internet-endpoints)
- [Troubleshooting update and servicing issues for Configuration Manager](understand-troubleshoot-updates-servicing.md)
