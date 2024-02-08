---
title: Relevance Search does not behave as expected
description: If Admin Mode is enabled, the Relevance Search does not behave as expected for sandbox instances. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-other-functionality
---
# Relevance Search does not behave as expected for sandbox instances when Admin Mode is enabled

This article provides a resolution for the issues that may occur when you use the Relevance Search feature in a Microsoft Dynamics 365 sandbox instance.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 3216783

## Symptoms

When using the Relevance Search feature in a Microsoft Dynamics 365 sandbox instance, you encounter one of the following symptoms:

- When Admin Mode is enabled, customization changes and data updates do not appear in Relevance Search results.
- If you enabled Relevance Search while Admin Mode is enabled, you may see **The search service is unavailable. Try again later or use Categorized Search** error.

## Cause

This issue can occur if Admin Mode is enabled for the organization.

## Resolution

Disable Admin Mode for the organization:

1. Sign in to the [Office 365 portal](https://www.office.com/?auth=2) as a user with an administrator role.
2. Select the Admin icon to navigate to the Admin Portal.
3. Select Admin centers and then select Dynamics 365 on the navigation menu.
4. Select the Dynamics 365 instance and select the Admin icon.
5. Uncheck the **Enable administration mode** checkbox and select **save**.

> [!NOTE]
> Admin Mode may be enabled after search is already running at steady state.
