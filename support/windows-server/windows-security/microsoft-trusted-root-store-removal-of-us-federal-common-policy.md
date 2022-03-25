---
title: Removal of the U.S. Federal Common Policy CA certificate from the Microsoft trusted root
description: Discusses the removal of U.S. "G1" root certificate and provides solutions to avoid issues.
localization_priority: medium
audience: itpro
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
ms.topic: troubleshooting
ms.prod: windows-server
ms.reviewer: hasokol,georgeri,gbock,jtierney,arrenc,roberg,kaushika
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
ms.date: 02/16/2022
---
# Removal of the U.S. Federal Common Policy CA certificate from the Microsoft trusted root

This article discusses the removal of the U.S. Federal Common Policy CA root certificate. This article also provides solutions to avoid issues that will occur if enterprises haven't transition to the Federal Common Policy CA G2 root certificate before the removal of the Federal Common Policy CA root certificate from the Microsoft Certificate Trust List (CTL).

A Microsoft Root Certificate Update is scheduled to be released on the third Tuesday of one of the months between March, 22, 2022 and August 23, 2022.

> [!Note]
> The root certificate that's being removed by the Microsoft Root Certificate Update is named "Federal Common Policy CA" and is commonly referred to as the "G1" root certificate even though "G1" does not appear in the certificate name.
>
> The root certificate that replaces the "G1" root certificate is named "Federal Common Policy CA G2" and is commonly referred to as the "G2" root certificate.

_Applies to:_ &nbsp; All versions of Windows

## Introduction

The [United States Federal PKI (FPKI)](https://www.idmanagement.gov/) team that governs the U.S. Federal Common Policy CA formally requested the removal of the "G1" root certificate listed below from the Microsoft Trusted Root Program.

|Certificate name|SHA1 thumbprint|
|---|---|
|Federal Common Policy CA|905F942FD9F28F679B378180FD4F846347F645C1|

Applications and operations that depend on the "G1" root certificate will fail one to seven days after they receive the root certificate update. Administrators should migrate from the existing "G1" root certificate to the replacement "G2" root certificate listed below as your agency's federal trust anchor.

|Certificate name|SHA1 thumbprint|
|---|---|
|Federal Common Policy CA G2|99B4251E2EEE05D8292E8397A90165293D116028|

> [!Note]
> The "G2" root certificate can be downloaded directly from ["G2" root certificate crt file download](http://repo.fpki.gov/fcpca/fcpcag2.crt).

## Potential issues

After the "G1" root certificate is removed, you may experience issues that affect the following scenarios:

- TLS or SSL connections.
- Secure or multipurpose internet Mail Extensions (S/MIME) or secure email.
- Signed documents in Microsoft Word. (PDF and Adobe Acrobat files will not be affected.)
- Client authentication, including establishing VPN connections.
- Smart card or PIV authenticated access, including badge access that relies completely on Windows software.

The following error messages may be displayed in pop-up windows and dialog boxes:

- > The site's security certificate is not trusted.
- > The security certificate presented by this website was not issued by a trusted CA.
- > A certificate chain processed but terminated in a ROOT certificate that is not trusted by the trust provider.
- > Certificate Chaining Error.
- > The certificate chain was issued by an authority that is not trusted.
- > The certificate or associated chain is invalid.

## Steps to avoid these issues

To proactively avoid these issues, or if you are experiencing outages, manually download the "G2" root certificate by using the steps in [Migrate to the Federal Common Policy CA G2](https://playbooks.idmanagement.gov/fpki/common/migrate/).

> [!Note]
> Application-as-service scenarios such as Azure SQL or Azure App Service that chain to the "G1" root certificate will fail after the "G1" root certificate is removed.

### Configure the "G2" root certificate

Administrators should configure the "G2" root certificate per the following instructions before the "G1" root certificate is removed by the out-of-band (OOB) root certificate update.

> [!Note]
> The "G2" root certificate is not trusted by Microsoft. By adding this root certificate, you are implicitly trusting the "G2" root certificate.

1. Follow the guidance in [Obtain and verify a copy of the Federal Common Policy CA G2 certificate](https://playbooks.idmanagement.gov/fpki/common/obtain-and-verify) to download and install the "G2" root certificate on all Windows workgroup, member, and domain controller computers.
2. There are multiple ways to deploy the root store to enterprise devices. See the "Microsoft Solutions" section in [Distribute the certificate to operating systems](https://playbooks.idmanagement.gov/fpki/common/distribute-os/).

> [!Note]
> In enterprises that have cross-certification dependencies for smart card logons or other scenarios on Windows devices but do not have internet access, see the "Do I Need to Distribute the Intermediate CA Certificates?" and "Certificates Issued by the Federal Common Policy CA G2" sections of [Distribute the CA certificates issued by the Federal Common Policy CA G2](https://playbooks.idmanagement.gov/fpki/common/certificates/).
>
> Many federal enterprises must have either the U.S. Treasury CA certificates or the Entrust Managed Services CA certificates. Both CA certificates are documented in the "Distribute the CA certificates" article, as follows:
>
> > Important! To ensure PIV credential certificates issued by the Entrust Federal SSP before August 13, 2019 validate to the Federal Common Policy CA G2, you'll need to distribute an additional intermediate CA certificate to systems that are unable to perform dynamic path validation. Learn more on our Frequently Asked Questions page.

### Manual steps to get the CTL

For disconnected environments in which Windows devices are not allowed to access Windows Update or the internet, follow these steps to manually get the CTL:

1. Download the CTL:
   1. Run `certutil -generateSSTFromWU c:\roots\trustedcerts.sst`.
   2. When you select the **trustedcerts.sst** file, this should open the Certificate Manager snap-in to display the complete CTL.
2. Download Certificate Disallowed List:
   1. Run `certutil -syncwithwu c:\roots`.
   2. Run `certutil -verifyctl -v c:\rootsdisallowedstl.cab c:\roots\disallowedcert.sst`.
   3. When you select disallowedcert.sst, this should open the Certificate Manager snap-in to display all roots in the Disallowed list.
3. To evaluate settings that are not shown in the UI, convert the SST file to a text file. To do this, run `certutil -dump -gmt -v c:\roots\trustedcerts.sst > c:\roots\trustedcerts.txt`.
4. Download and add the "G2" root certificate to your personal CTL.
   - Download the "G2" root certificate from [Obtain and verify a copy of the Federal Common Policy CA G2 certificate](https://playbooks.idmanagement.gov/fpki/common/obtain-and-verify/#download-a-copy-of-fcpca-g2).
   - Follow the guidance in FICAM Playbooks: [Migrate to the Federal Common Policy CA G2](https://playbooks.idmanagement.gov/fpki/common/migrate/) for each operating system that's deployed in your enterprise.

## Troubleshoot and analyze root chaining issues

The following data can help you troubleshoot operations that are affected by the removal of the "G1" root certificate:

1. Enable CAPI2 logging. See [Windows PKI Troubleshooting and CAPI2 Diagnostics](https://social.technet.microsoft.com/wiki/contents/articles/242.windows-pki-troubleshooting-capi2-diagnostics.aspx).
2. Create filters in Event Viewer on the following event logs, event sources, and event IDs.

   Under the _Applications and Services Logs\Microsoft\Windows\CAPI2\Operational_ log that uses **CAPI2** as its source:

   - Event ID 11: This event shows you chaining failures.
   - Event ID 30: This event shows you Policy chain failures, such as NTAuth failures and SSL Policy check.
   - Event ID 90: This event shows you all certificates that were used to build all possible certificate chains on the system.
   - Event ID 40–43: This event series shows all stored CRLs and event certificates that are accessed through AIA paths.
   - Event ID 50–53: This event series shows all attempts to access the CRLs from the network. The event is related to the following error message:  
     > A certificate chain processed, but terminated in a ROOT certificate that is not trusted by the trust provider

   In the System event log that uses **Microsoft-Windows-Kerberos-Key-Distribution-Center** as its source:

   - Error 19: This event indicates that an attempt was made to use a smart card logon, but the KDC cannot use the PKINIT protocol because a suitable certificate is missing.
   - Event 21: A certificate chain could not be built to a trusted root authority.
   - Event 29: The Key Distribution Center (KDC) cannot find a suitable certificate to use for smart card logons, or the KDC certificate could not be verified. Smart card logon may not function correctly if this problem is not resolved. To correct this problem, either verify the existing KDC certificate by using Certutil.exe or enroll for a new KDC certificate.
