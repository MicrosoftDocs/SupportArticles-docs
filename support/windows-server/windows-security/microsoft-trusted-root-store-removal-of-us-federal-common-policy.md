---
title: Removal of the U.S. Federal Common Policy CA certificate from the Microsoft trusted root
description: Discusses the removal of U.S. "G1" root certificate and provides solutions to avoid issues.
localization_priority: medium
audience: itpro
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
ms.topic: troubleshooting
ms.service: windows-server
ms.reviewer: hasokol,georgeri,gbock,jtierney,arrenc,roberg,kaushika
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.subservice: windows-security
ms.date: 09/28/2023
---
# Removal of the U.S. Federal Common Policy CA certificate from the Microsoft trusted root

This article discusses the removal of the U.S. Federal Common Policy CA root certificate in the May 24, 2022 Microsoft Root certificate update. This article also provides solutions to avoid or resolve issues that will occur if enterprises haven't transitioned to the Federal Common Policy CA G2 root certificate before the removal of the Federal Common Policy CA root certificate from the Microsoft Certificate Trust List (CTL) by May 24, 2022.

> [!NOTE]
> The root certificate that's being removed by the Microsoft Root Certificate Update is named "Federal Common Policy CA" and is commonly referred to as the "G1" root certificate even though "G1" does not appear in the certificate name.
>
> The root certificate that replaces the "G1" root certificate is named "Federal Common Policy CA G2" and is commonly referred to as the "G2" root certificate.

_Applies to:_ &nbsp; All versions of Windows

## Introduction

The [United States Federal PKI (FPKI)](https://playbooks.idmanagement.gov/fpki/) team that governs the U.S. Federal Common Policy CA formally requested the removal of the "G1" root certificate listed below from the Microsoft Trusted Root Program.

|Certificate name|SHA1 thumbprint|
|---|---|
|Federal Common Policy CA|905F942FD9F28F679B378180FD4F846347F645C1|

Applications and operations that depend on the "G1" root certificate will fail one to seven days after they receive the root certificate update. Administrators should migrate from the existing "G1" root certificate to the replacement "G2" root certificate listed below as your agency's federal trust anchor.

|Certificate name|SHA1 thumbprint|
|---|---|
|Federal Common Policy CA G2|99B4251E2EEE05D8292E8397A90165293D116028|

> [!NOTE]
> The "G2" root certificate can be downloaded directly from ["G2" root certificate crt file download](http://repo.fpki.gov/fcpca/fcpcag2.crt).

## Potential issues

After the "G1" root certificate is removed, users in environments that have not transitioned to the "G2" root certificate may experience issues that affect the following scenarios:

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

1. Verify changes in the [Test configuration setup](#test-configuration-setup) section to test what occurs with the removal of the "G1" from the CTL before the release date of the update.
2. After you use the [test configuration setup](#test-configuration-setup) section to verify that all relevant scenarios work, follow the steps in the "[Production configuration setup](#production-configuration-setup)" section in your production configuration.

> [!NOTE]
> Application-as-service scenarios such as Azure SQL or Azure App Service that chain to the "G1" root certificate will fail after the "G1" root certificate is removed.

### Test configuration setup

Before the release of the update, administrators can use the following steps to directly configure the Windows registry to a prerelease or staged location of the latest certificate update. You can also configure the settings by using Group Policy. See [To configure a custom administrative template for a GPO](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983%28v=ws.11%29#to-configure-a-custom-administrative-template-for-a-gpo).

> [!NOTE]
> The preview of the May release which includes the removal of the "G1" root certificate is staged on May 11, 2022.

1. Open _regedit_, and then navigate to the following registry subkey:  
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate`

2. Add or modify the following registry values:
   - Set **RootDirUrl** to `http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/test`.
   - Set **SyncFromDirUrl** to `http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/test`.

3. Delete the following registry values:
   - **EncodedCtl**
   - **LastSyncTime**

4. Delete the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\Certificates` subkey. This step deletes all stored root certificates.

   > [!NOTE]
   > By deleting all stored root certificates from `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\Certificates`, you can make sure that all stored root certificates are removed. This operation forces Windows to download new root certificates if associated public key infrastructure (PKI) chains are used that have new properties (if modified). Because the "G1" root certificate is being removed, this root certificate will not be downloaded.

5. Verify all scenarios that chain to the "G1" root certificate, including those that are listed in [Potential issues](#potential-issues).

> [!NOTE]
> The link to the test site never changes. However, the changes that are staged on the test site change from month to month.

### Production configuration setup

The following steps directly configure the Windows registry to use the production version of the CTL if the testing URL from the previous section is used:

1. Open _regedit_, and then navigate to the following registry subkey:
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate`

2. Add or modify the following registry values:
   - Set **RootDirUrl** to `http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en`.
   - Set **SyncFromDirUrl** to `http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en`.

3. Delete the following registry values:
   - **EncodedCtl**
   - **LastSyncTime**

4. Delete the `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\Certificates` registry subkey. This step deletes all stored root certificates.

### Configure the "G2" root certificate

Administrators should configure the "G2" root certificate per the following instructions before the "G1" root certificate is removed by the out-of-band (OOB) root certificate update.

1. Follow the guidance in [Obtain and verify the FCPCA root certificate](https://www.idmanagement.gov/implement/trust-fcpca/#step-1---obtain-and-verify-the-fcpca-root-certificate) to download and install the "G2" root certificate on all Windows workgroup, member, and domain controller computers.
2. There are multiple ways to deploy the root store to enterprise devices. See the "Microsoft Solutions" section in [Distribute to operating systems](https://www.idmanagement.gov/implement/trust-fcpca/#step-2---distribute-to-operating-systems).

> [!NOTE]
> In enterprises that have cross-certification dependencies for smart card logons or other scenarios on Windows devices but do not have internet access, see the "Do I Need to Distribute the Intermediate CA Certificates?" and "Certificates Issued by the Federal Common Policy CA G2" sections of [Distribute intermediate certificates](https://www.idmanagement.gov/implement/trust-fcpca/#step-5---distribute-intermediate-certificates).
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
   2. Run `certutil -verifyctl -v c:\roots\disallowedstl.cab c:\roots\disallowedcert.sst`.
   3. When you select disallowedcert.sst, this should open the Certificate Manager snap-in to display all roots in the Disallowed list.
3. To evaluate settings that are not shown in the UI, convert the SST file to a text file. To do this, run `certutil -dump -gmt -v c:\roots\trustedcerts.sst > c:\roots\trustedcerts.txt`.
4. Download the "G2" root certificate from [Obtain and verify the FCPCA root certificate](https://www.idmanagement.gov/implement/trust-fcpca/#download-a-copy-of-the-fcpca-root-certificate) and add it to your personal CTL.

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
