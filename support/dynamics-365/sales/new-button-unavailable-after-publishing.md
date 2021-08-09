---
title: New button is unavailable after publishing
description: Provides a solution to an issue where the New button for a custom entity isn't available immediately after publishing in Microsoft Dynamics CRM for Microsoft Outlook.
ms.reviewer: mmaasjo
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# The New button for a custom entity is not available immediately after publishing in Microsoft Dynamics CRM for Microsoft Outlook

This article provides a solution to an issue where the New button for a custom entity isn't available immediately after publishing in Microsoft Dynamics CRM for Microsoft Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2505203

## Symptoms

Consider the following scenario. You create a custom entity in Microsoft Dynamics CRM. You mark Available Offline, and then you publish the customizations.

When you go into Microsoft Dynamics CRM for Microsoft Office Outlook, one of the following symptoms is true:

- The custom entity doesn't appear in the left navigation.
- You're able to open the custom entity, but the **New** button isn't available in the ribbon.

## Cause

The Sitemap is refreshed on an hourly basis, so it may take some time for the new custom entity to appear in Microsoft Dynamics CRM for Microsoft Office Outlook.

## Resolution

Wait for approximately an hour before you attempt to access a new custom entity in Microsoft Dynamics CRM for Microsoft Office Outlook.
