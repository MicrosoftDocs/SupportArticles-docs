---
title: CA can't use a certificate template
description: Provides a solution to an issue where a certificate template is unable to load and certificate requests are unsuccessful using the same template.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, slight
ms.custom: sap:Certificates and Public Key Infrastructure (PKI)\Active Directory Certificate Services (ADCS), csstroubleshoot
---
# Certification Authority can't use a certificate template

This article provides a solution to an issue where a certificate template can't load, and certificate requests fail to use the template.

_Original KB number:_ &nbsp; 283218

## Symptoms

When Certificate Services starts in the Certification Authority (CA), a certificate template is unable to load and certificate requests are unsuccessful using the template.

When requesting a certificate, once you select the template and click **Enroll**, you receive the error: "The requested certificate template is not supported by this CA. 0x80094800 (-2146875392 CERTSRV_E_UNSUPPORTED_CERT_TYPE)"

## Cause

The behavior occurs because the Authenticated Users group is removed from the template's access control list (ACL). The Authenticated Users group is on a template ACL, by default. (The Certification Authority object itself is included in this group.) If the Authenticated Users group is removed, the (enterprise) CA itself can no longer read the template in the Active Directory, and that's why certificate requests can be unsuccessful.

## Resolution

If an administrator wants to remove the Authenticated Users group, each and every CA's computer account must be added to the template ACLs and set to Read.

## More information

Minimum permissions required for an entity to request a certificate:  

Requesting user/machine: Read & Enroll, Certification Authority Object: Read 

If authenticated users group is removed from the ACLs of a template, the following errors may be observed when the CA starts and when a certificate is requested against the template. 

## Errors observed when enrollment is unsuccessful

- For the client:

    Enrollment with Web Enrollment page:
  
  > Certificate Request Denied  
  > Your certificate request was denied.  
  > Your Request Id is RequestID. The disposition message is "Denied by Policy Module 0x80094800, The request was for a certificate template that is not supported by the Active Directory Certificate Services policy: Template_information
  >
- Enrollment with Microsoft Management Console (MMC):

  > The requested certificate template is not supported by this CA.
  >
  > CA info  
  > Denied by Policy Module 0x80094800, The request was for a certificate template that is not supported by the Active Directory Certificate Services Policy: Template_information.
  >
  > The requested certificate template is not supported by this CA. 0x80094800 (-2146875392 CERTSRV_E_UNSUPPORTED_CERT_TYPE)
  >
  > A certification authority that can issue the requested certificate type is not available.
  
- For the CA:

  > Event Type:Warning  
  > Event Source: CertificationAuthority  
  > Event ID: 53  
  >
  > Description:  
  > Active Directory Certificate Services denied request RequestID because The requested certificate template is not supported by this CA. 0x80094800 (-2146875392 CERTSRV_E_UNSUPPORTED_CERT_TYPE).  The request was for Template_name.  Additional information: Denied by Policy Module  0x80094800, The request was for a certificate template that is not supported by the Active Directory Certificate Services policy: Template_Info
  
- Error on CA When Certificate Services starts:

  > Event Type:Warning
  > Event Source: CertificationAuthority  
  > Event ID: 77  
  > Description:  
  > The "Windows default" Policy Module logged the following warning: The template_name Certificate Template could not be loaded.  Element not found. 0x80070490 (WIN32: 1168 ERROR_NOT_FOUND).
