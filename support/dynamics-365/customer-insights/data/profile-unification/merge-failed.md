---
title: Merge failed error on the Unified data view card
description: Provides a resolution for an issue where merge failures occur in Microsoft Dynamics 365 Customer Insights - Data.
author: Scott-Stabbert
ms.author: sstabbert
ms.date: 12/18/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---
# "Merge failed" error occurs on the "Unified data view" card in Dynamics 365 Customer Insights - Data

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article resolves an issue where data unification fails due to a merge error.

## Symptoms

The following error message appears on the **Unified data view** card on the **Data unification** page.

> Merge failed.

## Resolution

1. Verify upstream dependencies.

   Ensure the data sources are refreshed and the *Match* processes are completed successfully without any errors. Check the logs or status reports of these dependencies to ensure they're functioning as expected. Resolve any issues encountered in these upstream processes. For more information, see [Define matching rules for data unification](/dynamics365/customer-insights/data/data-unification-match-tables).

1. Retry the *Merge* process by going to **Data** > **Unify** > **Unify customer profiles**.
