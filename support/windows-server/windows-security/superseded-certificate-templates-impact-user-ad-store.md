---
title: Superseded Certificate Templates and impact on user's AD store
description: Provides a resolution for the issue superseded Certificate Templates and impact on user's AD store
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-certificate-services-adcs, csstroubleshoot
---
# Superseded Certificate Templates and impact on user's AD store

This article provides a resolution for the issue superseded Certificate Templates and impact on user's AD store.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 2884551

## Symptoms

The deletion of certificates, based on the certificate templates being superseded by other certificate templates, from user's AD store worked in XP/W2k3 as part of the autoenrollment.  
Repro Steps (Vista and later):

1. Configure user autoenrollment policy (make sure that policy is enabled and both check boxes are check in the autoenrollement configuration window.
2. Duplicate User certificate template (name it for example TestTemplate1), make sure that the certificate publishing in AD is activated and assign to the test user read, enroll, and autoenroll permissions on the template.
3. Publish the TestTemplate1 template on the CA.
4. Log on as test user and make sure that the user gets the certificate based on the template TestTemplate1 over autoenrollment.
5. Configure new certificate template by duplicating TestTemplate1 (name it for example TestTemplate2), set in the superseeded tab that TestTemplate2 superseeds the TestTemplate1, make sure that the certificate publishing in AD is activated and double check that test user has Read, Enroll, and Autoenroll permissions set for TestTemplate2.
6. Publish the TestTemplate2 template on the CA.
7. Log on as test user and check that the user gets certificate based on the new template TestTemplate2 over autoenrollment.
8. On the DC, open dsa.msc, find the test user, open the properties and there will be two certificates published in AD, one based on TestTemplate1 and the other based on TestTemplate2 (on XP/W2k3 there would be only one, since the certificate based on the template being superseded, TestTemplate1, would have been deleted).

## Cause

This feature has been removed in Vista and subsequent Windows versions.

## Resolution

Workaround is to delete all certs issued by a specific template:
For a V1 template: certutil -delstore -user ldap: InternalTemplateName
For a V2 or later template: certutil -delstore -user ldap: TemplateOID
InternalTemplateName is the non-localized template name (the CN of the template object in AD).
Above command will delete all certs from DS store, issued using a specific template.

## More information

The code change was made during Windows Vista/2008 time frame in order to address issues raised after certificate roaming feature has been introduced (for example, an end certificate can be created with an unknown CSP on a different machine and roam using credential roaming, or the issuing CA of a RSA-based certificate that roamed has an unknown signature algorithm -> both scenarios will result by the end certificate being removed from AD, even if it is valid).
