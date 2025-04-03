---
title: Can't Switch Between Different Teams Organizations Within the Dynamics 365 App
description: Explains the design limitation and provides guidance on switching between different Teams organizations in the Dynamics 365 app.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/24/2025
ms.custom: sap:Cases or Incidents, DFM
---
# Can't switch between different Teams organizations within the Dynamics 365 app

This article helps you mitigate the issue where you can't switch between different Teams organizations within the Dynamics 365 app, a functionality that's available in the standalone Teams mobile and desktop applications.

## Symptoms

You can't find an option to switch to a different organization's Teams within the Dynamics 365 app. This functionality is available in the standalone mobile and desktop Teams applications but not within Dynamics 365.

## Cause

This behavior is by design. Currently, there's no workaround or quick option to switch organizations directly within the Dynamics 365 app. You must manually sign in to the desired organization separately.

## Mitigation steps

To access Teams functionality for a different organization within Dynamics 365, follow these steps:

1. Sign out of the current organization in Dynamics 365.
1. Sign in to the desired organization separately.
1. Ensure that Teams integration is enabled for the specific organization within Dynamics 365. For more information, see [Configure Microsoft Teams chat in Customer Service](/dynamics365/customer-service/administer/configure-teams-chat).
1. Use the integrated Teams chat functionality associated with the newly signed-in organization.
