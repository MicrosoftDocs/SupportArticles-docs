---
title: Event ID 2160 when you map a user to a certificate in Exchange Server 2010
description: Fixes an account mapping issue in Exchange Server 2010 that occurs when you use the altSecurityIdentities attribute to map a user to a certificate.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: karywa, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Event ID 2160 after you map a user to a certificate using altSecurityIdentities in Exchange Server 2010

_Original KB number:_ &nbsp;2737853

## Symptoms

Assume that you use one of the following account mapping methods together with the `altSecurityIdentities` attribute to map a user to a certificate in Microsoft Exchange Server 2010:

- `Public Key SHA1 Hash`
- `Subject Key Identifier`
- `Issuer & Serial Number`
- `RFC822`

In this situation, the following event is logged in the Application log. Additionally, some Exchange Server 2010 functionality may not work as expected for the user.

```console
Log Name: Application
Source: MSExchange ADAccess
Event ID: 2160
Level: Warning
Computer: Exchange.domain.com
Description:
Process w3wp.exe (). Recipient object CN=<User>,OU=Users,OU=site,DC=lab,DC=contoso,DC=com read from DC.domain.com failed validation and will be excluded from the result set. Set event logging level for Validation category to Expert to get additional events about each failure.
```

## Cause

This issue occurs because Exchange Server 2010 doesn't support the account mapping methods listed in the "Symptoms" section.

## Resolution

To resolve this issue, use the following account mapping methods that are supported by Exchange Server 2010:

- `Subject and Issuer Name X509:<I>issuer<S>subject`
- `Issuer Name X509:<I>issuer`

## More information

Active Directory 2008 enables alternative account mappings by using the `altSecurityIdentities` attribute. This attribute contains the user's certificate information that's used by the Kerberos Authentication service to identify the associated Active Directory user account.

For more information about how to map a user to a certificate, see [How to map a user to a certificate by using all the methods that are available in the altSecurityIdentities attribute](/archive/blogs/spatdsg/howto-map-a-user-to-a-certificate-via-all-the-methods-available-in-the-altsecurityidentities-attribute).