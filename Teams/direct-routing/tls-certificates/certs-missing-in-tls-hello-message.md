---
title: 'TLS “Hello” message does not contain SBC or required certificates'
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
description: Describes how to resolve an issue where the SBC or required certificates are missing in the TLS Hello message.
---

# SBC or required certificates missing in TLS “Hello” message

## Symptoms

The SBC or all required intermediary certificates are missing in the SBC TLS “Hello” message.

## Resolution

Check that a valid certificate and all intermediate Certificate Authority certificates are installed correctly, and that the TLS connection settings are correct on SBC.

## More information

In some cases, everything may look correct. However, a closer examination of the packet capture might reveal that the TLS certificate of the Intermediate Certificate Authority isn’t provided to the Teams infrastructure.
