---
title: The domain name isn't fully activated on the Microsoft server
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
description: Resolves an issue where the domain isn't fully activated on a Microsoft server side.
---

# Domain name is not fully activated on the Microsoft server

## Symptoms

After the successful addition and verification of a domain to the Microsoft tenant, there is no response to SIP messages (including SIP OPTIONS). Further investigation reveals that there are no users with valid licenses assigned to the tenant.

## Resolution

In order for you to fully activate a domain for a tenant and distribute it over Microsoft systems, we require you to assign at least one user who has a valid license to the subdomain that's used by SBC. After all required criteria are met, it can take up to 24 hours for the changes to take effect.

## More information

For a list of the licenses that are required for Direct Routing, see the  ”Licensing and other requirements” section of [Plan Direct Routing](https://docs.microsoft.com/MicrosoftTeams/direct-routing-plan#licensing-and-other-requirements). 

For more information about this process, see the ”Connect the SBC to the tenant” section of [Connect your Session Border Controller (SBC) to Direct Routing](https://docs.microsoft.com/microsoftteams/direct-routing-connect-the-sbc#connect-the-sbc-to-the-tenant).
