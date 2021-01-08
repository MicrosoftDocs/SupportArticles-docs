---
title: SBC doesn't trust SIP proxy certificate 
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
description: Resolves an issue where the SBC doesn't trust the SIP proxy certificate.
---

# Teams SIP proxy certificate not trusted by SBC

## Symptoms

The SBC doesn’t trust the Teams SIP proxy certificate.

## Resolution

Download and install the Baltimore CyberTrust Root Certificate in the SBC Trusted Root Store of the Teams TLS context.

## More information

For important information about certificates, see the “Public trusted certificate for the SBC” section of [Plan Direct Routing](https://docs.microsoft.com/MicrosoftTeams/direct-routing-plan#public-trusted-certificate-for-the-sbc).
