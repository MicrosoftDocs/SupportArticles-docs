---
title: Data isn't updated on the Insights tab for integrated search providers
description: Provides a resolution for the issue where data isn't updated on the Insights tab for integrated search providers in Dynamics 365 Customer Service.
ms.author: sdas
ms.reviewer: sdas, ankugupta
ms.date: 07/10/2023
---
# Integrated search provider data on the Insights tab isn't updated after a scheduled refresh

This article provides a resolution for the issue where the search provider may have been configured incorrectly in Dynamics 365 Customer Service.

## Symptoms

Data isn't updated on the **Insights** tab for integrated search providers even after the scheduled refresh interval time.

## Resolution

Take the following troubleshooting steps to diagnose and fix the issue:

1. Make sure the provider's root URL and sitemap URL are correct. Browse through the URLs to confirm they're valid addresses.
2. Make sure the **External Reference Id** field is mapped to a unique field in the source property. The ID is expected to be unique. Mapping this field to nonunique fields in the source will cause issues when articles are ingested.
3. Make sure you haven't set the **Refresh interval** to **No refresh**.
4. If the source is authenticated, make sure the secret you provided is correct.

If the issue persists, contact Microsoft Support to raise a ticket.

## See also

For more information about managing a search provider, see [Manage integrated search providers](/dynamics365/customer-service/add-search-provider#manage-integrated-search-providers).
