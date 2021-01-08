---
title: The SBC is inactive or not responding
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

## More information

SBC may not be configured to send SIP OPTIONS to FQDNs (for example, sip.pstnhub.microsoft.com). It may, instead, be configured to send SIP OPTIONS to the specific IP addresses that the FQDNs resolve to. This configuration isn’t correct. During maintenance or outages, IP address that the domain points to might change to a different datacenter while SBC continues to send SIP OPTIONS to the inactive and unresponsive datacenter.

To ensure successful reception of SIP OPTIONS from Microsoft endpoints, ensure that all network devices on the path (such as SBCs, FWs, etc.) will allow communication to and from all Microsoft signaling FQDNs.

SBC should be configured to use all three Microsoft SIP proxy FQDNs. All network devices on the path (SBC, firewall, routers, etc.) must allow incoming and outgoing traffic from (and to) all Microsoft SIP proxy FQDNs. (Devices that support these options can use sip-all.pstnhub.microsoft.com to resolve into all possible IPs.)

For more information, See [Plan Direct Routing - Microsoft Teams | Microsoft Docs](https://docs.microsoft.com/microsoftteams/direct-routing-plan#sip-signaling-fqdns).

