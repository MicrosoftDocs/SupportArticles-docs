---
title: Can't request certificate from web enrollment pages
description: Provides help to solve an error that occurs when you request certificates from CA Web enrollment pages.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, shawnrab, spat
ms.custom: sap:certificate-web-enrollment-pages-cwe, csstroubleshoot
---
# Error when a user requests certificate from CA web enrollment pages: No certificate templates could be found

This article provides help to solve an error "No certificate templates could be found" that occurs when you request certificates from CA web enrollment pages.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 811418

## Symptoms

When a user tries to request a certificate from the certification authority (CA) web enrollment pages, the user may receive the following error message:

> No certificate templates could be found. You do not have permission to request a certificate from this CA, or an error occurred while accessing the Active Directory.

This behavior occurs if the Web enrollment pages are in an Active Directory domain on an Enterprise CA server. It occurs whether the web enrollment pages are on the same server or on a different member server.

## Cause

The CA Web enrollment pages perform a case-sensitive string comparison of two values. One value is the **sServerConfig** value in the Certdat.inc file in the `%systemroot%\System32\Certsrv` folder on the certificate server, and the other value is the **dnsHostName** attribute on the **pkiEnrollmentService** object in Active Directory. If the two strings do not match, including the case match, the enrollment fails.

## Resolution

To correct this behavior, follow these steps:

1. View the Active Directory **dNSHostName** attribute on the **pkiEnrollmentService** object. This object is in the following location:

    CN= **CertificateServer**,CN=Enrollment Services,CN=Public Key Services,CN=Services,CN=Configuration,DC= **MyDomain**,DC=com

    To view the **dNSHostName** attribute, use ADSIEdit.msc or LDP.exe.

2. Edit the Certdat.inc file so that the value for sServerConfig is the same as the value for the dNSHostName attribute followed by the Certificate Authority Name.

    > [!NOTE]
    > The sServerConfig value must be in the same exact case as the dNSHostName attribute. If this is not true, you will continue to get the same error.

3. For example, if the DNS hostname for the Certification Authority is *server1.domain.local* and name of the Certification Authority is *MYCA*, then ensure the dNSHostName attribute for **CN=MYCA,CN=Enrollment Services,CN=Public Key Services,CN=Services,CN=Configuration,DC= *Domain*,DC=local** object is set to server1.domain.local and sServerConfig in the certdat.inc file in the `%systemroot%\system32\certsrv` folder on the Certification Authority should be set to **server1.domain.local\MYCA**.

4. Have the user who wants to request the certificate restart Internet Explorer. This permits the new credentials to pass to the CA.

    > [!NOTE]
    > Also make sure that the user is granted Read and Enroll permissions on the certificate template which that user is requesting. You can grant these permissions either by using the ADSIEdit snap-in or the Certificate Templates snap-in.
