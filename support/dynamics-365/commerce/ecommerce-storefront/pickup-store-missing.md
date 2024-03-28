---
title: Retail store doesn't appear in the list of stores to pick up from in Dynamics 365 Commerce
description: Provides a resolution for an issue where a retail store doesn't appear in the list of stores where items can be picked up in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 09/01/2023
ms.custom: sap:Order management\Issues with cart and checkout in e-commerce storefront
---
# A retail store doesn't appear in the list of stores to pick up from

This article provides a resolution for an issue where a retail store doesn't appear in the list of stores where items can be picked up in Microsoft Dynamics 365 Commerce.

## Symptoms

A retail store doesn't appear in the list of stores where items can be picked up.

## Resolution

#### Configure the longitude and latitude for the store address in Commerce headquarters

To configure the longitude and latitude for the store address in Commerce headquarters, follow these steps:

1. Go to **Retail and Commerce** > **Channels** > **Stores** > **All stores**.
1. Find the store that you want to display among the pickup options on the e-commerce site. Make a note of its **Operating unit number** value.
1. Go to **Organization administration** > **Organizations** > **Operating units**.
1. Search for the operating unit number that you noted earlier, and then select the operating unit in the search results.
1. On the **Addresses** FastTab, select **More options** > **Advanced**.
1. On the **General** FastTab, make sure that the **Longitude** and **Latitude** fields are correctly set. As part of this step, make sure that the values are correctly specified as positive or negative numbers.

#### Configure fulfillment groups in Commerce headquarters

To configure fulfillment groups in Commerce headquarters, follow these steps:

1. Go to **Retail and Commerce** >**Channels** > **Online stores**.
1. Select the online store to configure.
1. On the Action Pane, select **Set up** > **Fulfillment group assignment**.
1. On the **Fulfillment group assignment** page, select the fulfillment group for the online store.
1. Under **Setup**, make sure that the retail store is correctly configured for the fulfillment group.

## More information

- [Create an operating unit](/dynamics365/fin-ops-core/fin-ops/organization-administration/tasks/create-operating-unit)
- [Set up an online channel](/dynamics365/commerce/channel-setup-online)
