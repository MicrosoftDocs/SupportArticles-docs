---
title: Products and categories are missing after copying a site in Dynamics 365 Commerce
description: Resolves an issue where products and categories are missing after a site is copied between environments or within the same environment in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 09/01/2023
---
# Products and categories are missing after you copy an e-commerce site

This article provides a solution for an issue where products and categories are missing after you [copy an e-commerce site](/dynamics365/commerce/copy-ecommerce-site) between environments or within the same environment in Microsoft Dynamics 365 Commerce.

## Symptoms

After a site is copied from one environment to another or within the same environment, the products and categories are missing from the site. The products and categories will be missing from the e-commerce storefront and the **Products** tab in Commerce site builder.

## Resolution

To solve this issue, follow these steps to map the channel operating unit number (OUN) to a newly copied site in Commerce site builder:

1. Select the newly copied site.
1. Under **Site settings**, select **Channels**.
1. Next to the channel name, select the ellipsis (**...**), and then select **Change online store channel**.
1. In the **Change online store channel** dialog box, select the channel to map to the newly copied site, and then select **OK**.
1. Select **Save and publish**.

## More information

[Associate a Dynamics 365 Commerce site with an online channel](/dynamics365/commerce/associate-site-online-store)
