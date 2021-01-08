---
title: The SBC connection is interrupted
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
description: Resolves an issue where the SBC connection is interrupted.
---

# SBC connection is interrupted

## Symptoms 

The connection is interrupted or does not finish, even though there are no issues caused by certificates or settings on the SBC.

## Resolution

In some cases, the connection may be closed by one of the intermediary devices (for example, the firewall or a router) on the path between the SBC and the Microsoft network. To resolve this issue, verify that there are no connection issues within your managed network.
