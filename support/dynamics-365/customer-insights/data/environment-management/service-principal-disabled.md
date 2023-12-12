---
title: Can't access a new Customer Insights - Data environment
description: Provides a resolution for an issue where you can't access a new Dynamics 365 Customer Insights - Data environment because the user sign-in is disabled.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 12/12/2023
ms.custom: sap:create-reset-delete-env
---
# Can't access a new Customer Insights - Data environment

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article provides a resolution for an issue where you can't access a new Dynamics 365 Customer Insights - Data environment due to a disabled service principal.

## Symptoms

When you sign in to Customer Insights - Data, you receive the following error message:

> The service principal for resource \<application ID> is disabled.

## Cause

This issue occurs most likely because an administrator disabled user sign-in for the `<application ID>` enterprise application in Azure.

## Resolution

To solve this issue, follow these steps to enable user sign-in for the `<application ID>` enterprise application.

> [!NOTE]
> To enable user sign-in, you need admin permissions of Microsoft Entra ID.

1. Sign in to Microsoft Entra ID in the [Azure portal](https://portal.azure.com/).
1. Go to **Enterprise applications**.
1. Open the **Properties** setting of the `<application ID>` enterprise application.
1. Set **Enabled for users to sign-in?** to **Yes**.
1. Select **Save**.
