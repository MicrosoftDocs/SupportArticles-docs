---
title: Outlook Web App doesn't redirect to ADFS login
description: Describes a problem in which Outlook Web App published through WAP with ADFS pre-authentication doesn't redirect to ADFS login after the ADFS SSO token expires.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: tasitae, v-six
ms.custom: 
  - sap:Plan and Deploy\Need help to deploy Oauth, HMA, ADFS
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
ms.date: 01/24/2024
---
# Outlook Web App published through WAP with ADFS pre-authentication doesn't redirect to ADFS login after the ADFS SSO token expires

_Original KB number:_ &nbsp; 4012524

## Symptoms

In an Exchange Server 2013 or Exchange Server 2016 environment, you publish Outlook Web App through WAP and enable ADFS pre-authentication. When you log on to Outlook Web App but take no actions after a certain time, you experience these symptoms:

- You don't receive any new email or notifications, unless you manually refresh the webpage.
- When you click on the navigation menu or any buttons in Outlook Web App, you'll receive connectivity error messages like the following one:

    > Your request can't be completed right now. Please try again later.

## Cause

This issue occurs because the Single Sign-On (SSO) authentication token from ADFS (which is managed by ADFS's SsoLifetime attribute) has expired. WAP returns an HTTP 307 response to Outlook Web App to redirect the user to ADFS for reauthentication, but Outlook Web App doesn't process this response, and the user remains unauthenticated.

## Workaround  

This is a known issue and will be fixed in a future release. To work around this issue, publish Outlook Web App through WAP by using pass-through authentication instead of ADFS pre-authentication.
