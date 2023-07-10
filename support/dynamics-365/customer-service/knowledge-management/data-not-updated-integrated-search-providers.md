---
title: Data isn't updated on the Insights tab for integrated search providers
description: Provides a resolution for the issue where data isn't updated on the Insights tab for integrated search providers in Dynamics 365 Customer Service.
ms.author: ravimanne
ms.reviewer: sdas
ms.date: 07/10/2023
---
# Data isn't updated on the Insights tab for integrated search providers

This article provides a resolution for the issue where data isn't updated on the **Insights** tab for integrated search providers in Dynamics 365 Customer Service.

## Symptoms

Data isn't updated on the **Insights** tab for integrated search providers even after the scheduled refresh interval time.

## Cause

There are a number of potential causes for this issue.

## Resolution

Take the following troubleshooting steps to diagnose and fix the issue:

- Check whether the root URL and the sitemap URL are configured correctly. There's a possibility of some misconfiguration or the URLs provided don't exist.
- Check the URLs on the browser to make sure that they're valid.
- Check whether the **External Reference Id** field is mapped to a unique field in the source property. Because the ID is expected to be unique, mapping repeated or non-unique fields for this field from the source will cause issues when articles are ingested.
- Make sure you haven't selected the **No refresh** option for **Refresh interval** for a data provider.
- If the source is authenticated, make sure that the secret provided is correct.

If the issue persists, contact Microsoft Support to raise a ticket.

For more information about managing a search provider, see [Manage integrated search providers](/dynamics365/customer-service/add-search-provider#manage-integrated-search-providers).
