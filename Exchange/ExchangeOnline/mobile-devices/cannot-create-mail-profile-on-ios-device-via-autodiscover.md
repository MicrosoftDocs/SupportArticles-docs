---
title: Cannot create mail profile on iOS device via Autodiscover
description: Describes an issue in which mobile devices that are running iOS7 and later versions cannot automatically configure the default mail app for an Exchange Online or on-premises Exchange Server mailbox. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: dalkim, jmartin, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't create a mail profile on an iOS device by using Autodiscover

_Original KB number:_ &nbsp; 3150466

## Symptoms

Mobile devices that are running iOS7 and later versions cannot automatically configure the default mail app for an Exchange Online mailbox or on-premises Exchange Server mailbox. When a user tries to verify their account, a message is displayed that says that their identity can't be verified by Exchange.

## Cause

The Autodiscover request for the secure root domain (`https://contoso.com/Autodiscover`) has an untrusted certificate. The root domain presents a certificate that doesn't match the HTTPS root domain name.

## Resolution

Make sure that the certificate matches the user's SMTP domain, or manually configure account settings for the Exchange Online mailbox.
