---
title: Troubleshoot issue with integrated search providers
description: Provides a resolution for issues with integrated search providers (preview) in Dynamics 365 Customer Service.
author: lalexms
ms.author: laalexan
ms.topic: troubleshooting
ms.date: 03/08/2023
---

# Data isn't updated on the Insights tab for integrated search providers (preview)

This article helps you troubleshoot issues with integrated search providers in Customer Service.

## Data isn't updated on the Insights tab for integrated search providers

### Symptom

Data isn't updated on the Insights tab even after the scheduled refresh interval time.

### Cause

There are a number of potential causes for this issue.

### Resolution

Perform the following troubleshooting steps to diagnose and fix the issue:

- Check whether the root URL and the sitemap URL are configured correctly. There is a possibility that there is some misconfiguration or the URLs provided don't exist. - Check the URLs on the browser to make sure that they are valid ones.
- Check if the External Reference Id field is mapped to a unique field in the source property. As the ID is expected to be unique, mapping repeated or non-unique fields for this field from the source will cause issues when articles are ingested.
- Make sure that you haven't selected the No refresh option for Refresh interval for a data provider.
- If the source is authenticated, make sure that the secret provided is correct.

If the issue persists, raise a Microsoft Support ticket.

For detailed information on managing a search provider, go to [Manage integrate search providers (preview)](/dynamics365/customer-service/add-search-provider#manage-integrated-search-providers-preview).
  
