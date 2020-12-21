---
title: The SBC certificate is not valid
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
description: Resolves an issue where the SBC certificate is expired or revoked.
---

# SBC certificate is invalid

## Symptoms

Teams SIP proxy is rejecting incoming and/or outgoing connection attempts. After packet capture or certificate inspection, you find that the SBC certificate is invalid (for example, expired or revoked).

## Resolution

Request or renew the certificate from your CA. Then, install it on the SBC according to the vendor’s SBC configuration guide.
