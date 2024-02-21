---
title: A CA can't use a certificate template
description: Provides a solution to an issue where a certificate template is unable to load and certificate requests are unsuccessful using the same template.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, slight
ms.custom: sap:active-directory-certificate-services, csstroubleshoot
---
# A Certification Authority can't use a certificate template

This article provides a solution to an issue where a certificate template is unable to load and certificate requests are unsuccessful using the same template.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 283218

## Summary

When Certificate Services starts on a Certification Authority (CA), a certificate template is unable to load and certificate requests are unsuccessful using the same template.

## More information

The behavior occurs because the Authenticated Users group is removed from the template's access control list (ACL). The Authenticated Users group is on a template ACL, by default. (The CA itself is included in this group.) If the Authenticated Users group is removed, the (enterprise) CA itself can no longer read the template in the Active Directory, and that's why certificate requests can be unsuccessful.

If an administrator wants to remove the Authenticated Users group, each and every CA's computer account must be added to the template ACLs and set to Read.

If authenticated users have been removed from the ACLs of a template, the following errors may be observed when the CA starts and when a certificate is requested against the template.

## Errors observed when enrollment is unsuccessful

- For the client:

    Enrollment by means of a Web page:

    > Certificate Request Denied  
    Your certificate request was denied.  
    Contact your administrator for further information.
    Enrollment by means of the Microsoft Management Console (MMC):
    Certificate Request Wizard:
    The certification authority denied the request. Unspecified error.

- For the CA:

    > Event Type:Warning  
    Event Source:CertSvc  
    Event Category:None  
    Event ID: 53  
    Date: *\<DateTime>*  
    Time: *\<DateTime>*  
    User:N/A  
    Computer: MUSGRAVE  
    Description:  
    Certificate Services denied request 9 because the requested certificate template is not supported by this CA. 0x80094800 (-2146875392). The request was for TED\administrator. Additional information: Denied by Policy Module. The request was for certificate template (\<template name>) that is not supported by the Certificate Services policy.

## Error on CA When Certificate Services starts

> Event Type:Error  
Event Source:CertSvc  
Event Category:None  
Event ID: 78  
Date: *\<DateTime>*  
Time: *\<DateTime>*  
User:N/A  
Computer: MUSGRAVE  
Description:  
The "Enterprise and Stand-alone Policy Module" Policy Module logged the following error: The \<template name> Certificate Template could not be loaded. Element not found. 0x80070490 (WIN32: 1168).
