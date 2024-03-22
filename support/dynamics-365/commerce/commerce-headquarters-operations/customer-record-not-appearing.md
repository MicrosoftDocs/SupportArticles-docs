---
title: Customer records don't appear in Commerce headquarters
description: Provides a resolution for an issue where customer records don't immediately appear in Commerce headquarters.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 09/01/2023
ms.custom: sap:Customer accounts and loyalty\Issues with customer account in point of sale (POS)
---
# Customer records don't appear in Commerce headquarters

This article provides a resolution for an issue where customer records don't immediately appear after they're created in Commerce headquarters.

## Symptoms

When you create a new customer record by using the [sign-up flow](/dynamics365/commerce/create-user-flow-policies#create-a-sign-up-and-sign-in-user-flow-policy) in the [e-commerce storefront](/dynamics365/commerce/commerce-architecture#e-commerce-storefront), the corresponding customer record doesn't immediately appear in Commerce headquarters.

## Resolution

To solve this issue, disable customer creation in asynchronous (or async) mode.

> [!IMPORTANT]
> If you disable asynchronous customer creation, system performance could be affected, because the creation of each record will produce a real-time request to Commerce headquarters. In addition, if Commerce headquarters is down (for example, during servicing flows), new customer creation flows will produce errors.

To disable customer creation in async mode in Commerce headquarters, follow these steps:

1. Go to **Retail and Commerce** > **Channel setup** > **Online store setup** > **Functionality profiles**.
1. If you don't have a functionality profile for your online channel, create one.
1. Make sure that the **Create customer in async mode** option is set to **No**.
1. Go to **Retail and Commerce** > **Channels** > **Online stores**.
1. Select the online store for which you want to disable asynchronous customer creation.
1. On the **General** tab, make sure that the **Functionality profile** field is set to the functionality profile that you're using for your online channel.

## More information

For more information, see [Set up a B2C tenant in Commerce](/dynamics365/commerce/set-up-b2c-tenant).
