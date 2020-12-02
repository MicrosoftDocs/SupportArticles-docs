---
title: The connection closes immediately and SIP OPTIONS fail to be sent
ms.author: v-todmc
author: mccoybot
manager: dcscontentpm
ms.date: 11/5/2020
audience: Admin
ms.topic: article
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 124780
- CSSTroubleshoot 
ms.reviewer: mikebis
description: Resolves an issue where the connection closes immediately and the SIP OPTIONS are not sent.
---

# Connection closes immediately and sending SIP OPTIONS fails

## Symptoms

One of the following situations occurs:

- The connection closes immediately, and sending the SIP Options fails.
- The “200 OK” message isn’t received.

## Cause

Either situation can be caused by one of the following conditions:

- The TLS certificate is not the minimum required version of TLS 1.2.
- The SBC certificate is self-signed or not assigned by a trusted CA.

## Resolution

To resolve this issue, obtain a certificate from a trusted certification authority (CA). This certificate must contain at least one fully qualified domain name (FQDN) that belongs to any Office365 tenant.

## More information

For a list of supported CAs, see the “Public trusted certificate for the SBC” section of [Plan Direct Routing](https://docs.microsoft.com/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
