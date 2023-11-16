---
title: Ratings refiner appears on search results and category pages unexpectedly
description: Resolves an issue where the ratings refiner appears on search results and category pages when the Microsoft Dynamics 365 Commerce ratings and reviews solution isn't enabled for an e-commerce site.
author: josaw1 
ms.author: josaw
ms.reviewer: brstor
ms.date: 09/01/2023
---
# Ratings refiner appears on search results and category pages when the ratings and reviews solution isn't enabled

This article provides a resolution to hide the ratings refiner on search results and category pages when the Microsoft Dynamics 365 Commerce ratings and reviews solution isn't enabled for an e-commerce site.

## Symptoms

The ratings refiner appears on search results and category pages in an e-commerce channel that doesn't use the ratings and reviews solution.

## Resolution

To solve this issue, enable the **Hide rating** setting in Commerce site builder, so that the ratings refiner is hidden on search results and category pages.

1. Go to **Site Settings** > **Extensions**.
1. Under **Ratings and Reviews**, select the **Hide rating** checkbox.
1. Select **Save and publish**.

## More information

- [Ratings and reviews overview](/dynamics365/commerce/ratings-reviews-overview)
- [Opt in to use ratings and reviews](/dynamics365/commerce/opt-in-ratings-reviews)
