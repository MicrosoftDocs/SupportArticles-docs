---

title: Products and categories are missing after environment copy
description: This article provides troubleshooting guidance that can help when products and categories are missing after a site is copied between environments or within the same environment.
author: Reza-Assadi
ms.author: josaw
ms.topic: troubleshooting
ms.date: 03/11/2021

---

# Products and categories missing after environment copy

This article provides troubleshooting guidance that can help when products and categories are missing after a site is copied between environments or within the same environment.

## Description

After a site is copied from one environment to another, or within the same environment, the products and categories are missing from the site. The products and categories will be missing from the e-commerce storefront and from the **Products** tab in Commerce site builder.

## Resolution

### Map the channel operating unit number to a newly copied site in Commerce site builder

To map the channel operating unit number (OUN) to a newly copied site in Commerce site builder, follow these steps.

1. Select the newly copied site.
1. Under **Site settings**, select **Channels**.
1. Next to the channel name, select the ellipsis (**...**), and then select **Change online store channel**.
1. In the **Change online store channel** dialog box, select the channel to map to the newly copied site, and then select **OK**.
1. Select **Save and publish**.

## Additional resources

[Associate a Dynamics 365 Commerce site with an online channel](/dynamics365/commerce/associate-site-online-store)
