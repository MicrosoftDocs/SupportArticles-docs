---
title: The FQDN does not match the CN or SAN certificates
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
description: Describes a resolution to an issue where the FQDN may not match the contents of a CN or SAN certificate. 
---

# FQDN doesn’t match CN or SAN certificates

## Symptoms

The FQDN doesn’t match the contents of common name (CN) or subject alternate name (SAN)  certificates (for example. a wildcard does not match lower-level subdomain names).

## Resolution

Request a certificate that matches your chosen domains. You can't have multiple-level subdomains under a wildcard. For example, the wildcard *.contoso.com would match sbc1.contoso.com, but not customer10.sbc1.contoso.com.

## More information

For more information about certificates, see the “Public trusted certificate for the SBC” section of [Plan Direct Routing](https://docs.microsoft.com/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
