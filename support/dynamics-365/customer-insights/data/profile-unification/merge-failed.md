---
title: Merge failed error occurs on the Unified data view card
description: Provides a resolution for an issue where merge failures occur in Microsoft Dynamics 365 Customer Insights - Data.
author: Scott-Stabbert
ms.author: sstabbert
ms.date: 12/13/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---
# "Merge failed" error occurs on the Unified data view card

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article resolves an issue where data unification fails due to a merge error.

## Symptoms

The following error message displays on the **Unified data view** card on the **Data unification** page.

> Merge failed.

## Resolution

1. Verify upstream dependencies.

   Ensure the data sources refreshed and the *Match* processes completed successfully without any errors. Check the logs or status reports of these dependencies to ensure they are functioning as expected. Resolve any issues encountered in these upstream processes.

1. Retry the *Merge* process by going to **Data** > **Unify** > **Unify customer profiles**.
