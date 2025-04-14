---
title: Chatbot Workstream Fails To Detect User's Location
description: Helps resolve an issue where the chatbot workstream fails to detect the user's location even after proper configuration in Microsoft Dynamics 365 Customer Service.
ms.reviewer: courtser
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/10/2025
ms.custom: sap:Cases or Incidents, DFM
---
# Chatbot workstream fails to detect user's location

This article addresses an issue where the chatbot workstream fails to detect the user's location, even after proper configuration in Dynamics 365 Customer Service.

## Symptoms

After you [set up visitor location detection](/dynamics365/customer-service/administer/geo-location-provider) in a chatbot workstream within Dynamics 365 Customer Service, the user's location details aren't being captured or displayed to the agent.

## Cause

This issue can occur if the Bing Map API key used for location detection was created in a different tenant than the one used by the Dynamics 365 Customer Service application. As a result, the chatbot fails to detect the user's location.

## Resolution

To resolve this issue, ensure that the Bing Map API key is created and configured in the same tenant as the Dynamics 365 Customer Service application. For more information, see [Getting a Bing Maps Key](/bingmaps/getting-started/bing-maps-dev-center-help/getting-a-bing-maps-key).
