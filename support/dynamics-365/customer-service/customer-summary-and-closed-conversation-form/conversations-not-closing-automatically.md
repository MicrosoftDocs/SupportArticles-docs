---
title: Conversations aren't closed automatically
description: Solves an issue where conversations aren't automatically closed after the configured wrap-up time in Microsoft Dynamics 365 Customer Service.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/20/2025
ms.custom: sap:Dynamics 365 Contact Center\Customer summary and Closed conversation form
---
# Conversations aren't closed automatically after the configured wrap-up time

This article provides guidance on resolving issues where conversations in Dynamics 365 Customer Service aren't closed automatically after the configured wrap-up time.

## Symptoms

Conversations in Dynamics 365 Customer Service aren't automatically transitioned from the **Wrap-up** state to a **Closed** state after the configured wrap-up time. This results in conversations remaining active in the **Wrap-up** state for an extended period.

## Cause

The issue occurs due to incorrect settings in the Channel State Configuration entity, which affects the automatic closure of conversations after the configured wrap-up time.

### Resolution 1: Verify and update configuration settings

1. Navigate to the Channel State Configuration entity (`msdyn_occhannelstateconfiguration`) in Dynamics 365 Customer Service.
2. Confirm that "Persistent Chat - Wrap Up" is set to **1 minute** or the desired wrap-up duration.
3. Save changes to the configuration and test the automatic conversation closure functionality.

## Resolution 2: Use the web API for automatic closure

Programmatically, you can change the default time and set it as per your organization's requirements using the Web APIs. Learn more in [Configure automatic closure of conversations using web API](/dynamics365/customer-service/develop/auto-close-conversation).

## More information

[Close conversations automatically](/dynamics365/customer-service/administer/auto-close-conversation-powerapps)
