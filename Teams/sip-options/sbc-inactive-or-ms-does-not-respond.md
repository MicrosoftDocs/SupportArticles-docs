---
title: The SBC is inactive or is not responding
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
description: Why the SBC may be inactive or not respond as expected. 
---

# SBC is inactive or doesn’t respond

## Symptoms

You may experience intermittent periods when the SBC is displayed as inactive or the Microsoft servers don’t respond.

## Resolution

SBC may not be configured to send SIP OPTIONS to FQDNs (for example, sip.pstnhub.microsoft.com). It may, instead, be configured to send SIP OPTIONS to the specific IP addresses that the FQDNs resolve to. This isn’t a correct configuration. During maintenance or outages, IP address that the domain points to might change to a different datacenter while SBC continues to send SIP OPTIONS to the inactive and unresponsive datacenter.
