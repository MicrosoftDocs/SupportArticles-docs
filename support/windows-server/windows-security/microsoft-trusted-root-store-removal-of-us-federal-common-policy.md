---
title: Microsoft Trusted Root Store removal of US Federal Common Policy
description: US Government Common Policy Root Removal.
localization_priority: medium
audience: itpro
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
ms.topic: troubleshooting
ms.prod: windows-server
ms.reviewer: hasokol,georgeri,gbock,jtierney,arrenc,roberg
ms.custom: sap:certificates-and-public-key-infrastructure-pki, csstroubleshoot
ms.technology: windows-server-security
ms.date: 02/16/2022
---
# Microsoft Trusted Root Store removal of US Federal Common Policy

This article introduces the removal of the US Federal Common Policy certificate and how to fix the issues that occur after the removal.

_Applies to:_ &nbsp; Windows Server - all editions, Windows 11 - all editions, Windows 10 - all editions

## Introduction of the change

The [United States Federal PKI](https://www.idmanagement.gov/) Team governing the Federal Common Policy Root Certificate Authority, formally requested the removal of the following root certificate from the Microsoft Trusted Root Program:

Certificate Name: US Federal Common Policy  
SHA1 Thumbprint: 905F942FD9F28F679B378180FD4F846347F645C1

Applications and operations that depend on the US Federal Common Policy (FCPCA) Root will fail after receiving the Root Certificate update 1 to 18 days after <!-- release date -->. Administrators should migrate from the existing FCPCA "G1" Root CA to the following RootCA as your agency's federal trust anchor:

Certificate Name: US Federal Common Policy G2 Root  
SHA1 Thumbprint: 99B4251E2EEE05D8292E8397A90165293D116028

> [!Note]
> The US Federal Common Policy G2 Root can be obtained from [here](http://repo.fpki.gov/fcpca/fcpcag2.crt)

## Potential issues

After the US Federal Common Policy G1 Root is removed, you may encounter issues with the following scenarios:

- TLS or SSL connections
- Secure/Multipurpose internet Mail Extensions (S/MIME) or secure email
- Signed documents in Word. PDF and Adobe Acrobat will not be affected.
- Client authentication including establishing VPN connections
- Smartcard or PIV authenticated access including badge access relying on Windows software only

The following Errors may be seen in pop-up and other dialog boxes.

- > The site's security certificate is not trusted.
- > The security certificate presented by this website was not issued by a trusted CA.
- > A certificate chain processed, but terminated in a ROOT certificate that is not trusted by the trust provider.
- > Certificate Chaining Error.
- > The certificate chain was issued by an authority that is not trusted.
- > The certificate or associated chain is invalid.

## How to fix the issues

1. Validate changes in the [Set up test configuration](#set-up-test-configuration) section being made to your root certificate between now and <!-- release date -->.
2. After verifying that all relevant scenarios work with the [Set up test configuration](#set-up-test-configuration) section, implement steps in the [set up production configuration](#set-up-production-configuration) section in your production configuration.
3. If you experience outages caused by Root CA based removal after <!-- release date -->, manually download the G2 root using the steps in [Migrate to the Federal Common Policy CA G2](https://playbooks.idmanagement.gov/fpki/common/migrate/).

> [!Note]
> Application-as-a-service scenarios like Azure SQL or Azure App Service that chain to the G1 root Will be blocked because the root will be available after removal.

### Set up test configuration

The following steps directly configure the Windows registry to a pre-release or staged location of the latest root update. You can also configure the settings by using group policy. See [To configure a custom administrative template for a GPO](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983%28v=ws.11%29#to-configure-a-custom-administrative-template-for-a-gpo).

1. Open *regedit*, navigate to the following registry key:  
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate`

2. Add or modify the following registry values:
   - Set **RootDirUrl** to **http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/test**.
   - Set **SyncFromDirUrl** to **http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/test**

3. Delete the following registry values:
   - **EncodedCtl**
   - **LastSyncTime**

4. Delete all registry values for cached certificates under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\Certificates`. <!-- key or values? -->

5. Validate all scenarios that chain to the G1 including those listed in [Potential issues](#potential-issues).

> [!Note]
> The URL above never changes. However, the changes that are staged change from month to month. As of February 15, 2022, the testing URL above is staged with about 20 continuous deprecation changes that do not currently include the removal of hte US Federal Common Policy G1 Root. That change will be staged in March 2022. This article will be updated with the exact staging date. <!-- remove it after we have the date -->

### Set up production configuration

The following steps directly configure the Windows registry to use production version of the certificate trust list (CTL) if the testing URL above is used:

1. Open _regedit_, navigate to the following registry key:  
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate`

2. Add or modify the following registry values:
   - Set **RootDirUrl** to **http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en**.
   - Set **SyncFromDirUrl** to **http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en**

3. Delete the following registry values:
   - **EncodedCtl**
   - **LastSyncTime**

4. Delete all registry values for cached certificates under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\Certificates`.



Administrators should implement G2 root CA as per the instructions below before the G1 root CA is removed by the OOB Root Certificate update.

1. Follow the guidance in [2: Obtain and verify a copy of the Federal Common Policy CA G2 certificate](https://playbooks.idmanagement.gov/fpki/common/obtain-and-verify/) to download and install the [Federal Common Policy CA G2 certificate](http://repo.fpki.gov/fcpca/fcpcag2.crt) on all Windows workgroup, member and domain controller computers.
2. There are multiple ways to deploy root CAs to enterprise devices. See the "Microsoft Solutions" section in [3: Distribute the certificate to operating systems](https://playbooks.idmanagement.gov/fpki/common/distribute-os/).

> [!Note]
> In enterprises that have cross-certification dependencies for smartcard logons or other scenarios on Windows devices but do not have internet-access, see the "Do I Need to Distribute the Intermediate CA Certificates?" and "Certificates Issued by the Federal Common Policy CA G2" sections of [Section 6: Distribute the CA certificates issued by the Federal Common Policy CA G2](https://playbooks.idmanagement.gov/fpki/common/certificates/).
>
> Many federal enterprises will either need US Treasury Root CA, or Entrust Managed Services Root CA. Both CAs are documented in Section 6 with the following text:
>
> > Important! To ensure PIV credential certificates issued by the Entrust Federal SSP before August 13, 2019 validate to the Federal Common Policy CA G2, you'll need to distribute an additional intermediate CA certificate to systems that are unable to perform dynamic path validation. Learn more on our Frequently Asked Questions page.



### Manual steps to get the Certificate Trust list

For disconnected environments where Windows devices are not allowed to access Windows Update or the internet, follow these steps to manually get the Certificate Trust list:

1. Download Certificate Trust List:
   1. Run `certutil -generateSSTFromWU c:\roots\trustedcerts.sst`
   2. When clicking on the **trustedcerts.sst** file it should open up CertMgr and display the complete Certificate Trust List
2. Download Certificate Disallowed List:
   1. Run `certutil -syncwithwu c:\roots`
   2. Run `certutil -verifyctl -v c:\rootsdisallowedstl.cab c:\roots\disallowedcert.sst`
   3. When clicking on disallowedcert.sst it should open up CertMgr and display all roots in the disallowed list.
3. Convert SST file to Text File:  
   To evaluate settings not shown in the UI, run `certutil -dump -gmt -v c:\roots\trustedcerts.sst > c:\roots\trustedcerts.txt`
4. Download and add the US Federal Common Policy G2 Root to your personal CTL.
   - Download [US Federal Common Policy G2 Root](http://http.fpki.gov/fcpca/fcpca.crt).
   - Follow the guidance in FICAM Playbooks: [Migrate to the Federal Common Policy CA G2](https://playbooks.idmanagement.gov/fpki/common/migrate/) for each operating systems that are deployed in your enterprise.

## How to collect and analyze troubleshooting data

The following data can help you troubleshoot this issue:

1. Enable CAPI2 logging. See [Windows PKI Troubleshooting and CAPI2 Diagnostics](https://social.technet.microsoft.com/wiki/contents/articles/242.windows-pki-troubleshooting-capi2-diagnostics.aspx).
2. Create filters in Event Viewer on the following event logs, event sources and event IDs:

   Under the _Applications and Services Logs\Microsoft\Windows\CAPI2\Operational_ log with source as **CAPI2**:

   - Event ID 11: This event shows you chaining failures.
   - Event ID 30: This event shows you Policy chain failures, such as NTAuth failures, SSL Policy check and so on.
   - Event ID 90: This event shows you all certificates that were used to build all possible certificate chains on the system.
   - Event ID 40 - 43: This event series shows all cached CRL's and event certificates that are accessed via AIA paths.
   - Event ID 50 - 53: This event series shows all attempts to access the CRLs from the network. The event is related to the following error:  
     > A certificate chain processed, but terminated in a ROOT certificate that is not trusted by the trust provider

   In the System event log with source as **Microsoft-Windows-Kerberos-Key-Distribution-Center**:

   - Error 19: This event indicates an attempt was made to use smartcard logon, but the KDC cannot use the PKINIT protocol because a suitable certificate is missing.
   - Event 21: A certificate chain could not be built to a trusted root authority.
   - Event 29: The Key Distribution Center (KDC) cannot find a suitable certificate to use for smart card logons, or the KDC certificate could not be verified. Smart card logon may not function correctly if this problem is not resolved. To correct this problem, either verify the existing KDC certificate by using certutil.exe or enroll for a new KDC certificate.
