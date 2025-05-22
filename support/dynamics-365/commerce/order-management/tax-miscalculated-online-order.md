---
title: Taxes on online orders are incorrectly calculated in Dynamics 365 Commerce
description: Resolves an issue where the taxes on online orders are incorrectly calculated, or the tax group on the sales line isn't correctly set in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 05/22/2025
ms.custom: sap:Pricing, discounts, and taxes\Issues with taxes and charges in e-commerce storefront
---
# Taxes on online orders are incorrectly calculated or the tax group on the sales line isn't correctly set

This article provides a resolution for an issue where the taxes on online orders are incorrectly calculated, or the tax group on the sales line isn't correctly set in Microsoft Dynamics 365 Commerce.

## Symptoms

When an e-commerce order is placed, the taxes are incorrectly calculated, or the tax group on the sales line is incorrectly set.

## Resolution

To solve the issue, follow these steps:

#### Step 1: Configure general sales tax groups in Commerce headquarters

To configure general sales tax groups in Commerce headquarters, follow these steps:

1. Go to **Tax** > **Indirect taxes** > **Sales tax** > **Sales tax group**.
1. In the left navigation pane, select the tax group to configure.
1. On the **Retail destination based tax** FastTab, configure the taxes for the sales tax group.

> [!NOTE]
> For shipping that doesn't include sales tax that is determined by the customer's address, the delivery address of the line and the destination-based taxes that are configured for the tax group determine the tax group. For more information, see [Set up taxes for online stores based on destination](/dynamicsax-2012/appuser-itpro/set-up-taxes-for-online-stores-based-on-destination).

#### Step 2: Configure the sales tax for a retail store in Commerce headquarters

To configure the sales tax for a retail store in Commerce headquarters, follow these steps:

1. Go to **Retail and Commerce** > **Channels** > **All stores**.
1. Select the store for which you want to configure sales tax.
1. On the **General** FastTab, in the **Sales tax** section, configure the sales tax information for the store.

> [!NOTE]
> For product pickup from a store, the tax group comes from the store that is selected for pickup. For more information, see [Set other tax options for stores](/dynamicsax-2012/appuser-itpro/set-other-tax-options-for-stores).

#### Step 3: Configure the sales tax for a customer's address in Commerce headquarters

To configure the sales tax for a customer's address in Commerce headquarters, follow these steps:

1. Go to **Accounts receivable** > **Customers** > **All customers**.
1. Select the customer for whom you want to configure sales taxes.
1. On the **Addresses** FastTab, select the address for which you want to configure sales taxes, and then select **More options** > **Advanced**.
1. On the **General** FastTab, select **Tax group**.
1. In the **Sales tax** field, select the appropriate value.

> [!NOTE]
> For shipping that involves sales tax on the customer's address, the delivery address of the line determines the tax group for the line. If the customer is shipping to an existing address that has a tax group that is already configured, the existing tax group will be used. By default, addresses don't have a tax group when they are created.

## More information

[Configure sales tax for online orders](/dynamics365/commerce/sales-tax-config)
