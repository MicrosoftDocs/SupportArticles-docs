---
title: Can't Access a New Customer Insights - Data Environment
description: Learn how to resolve a disabled service principal error when you can't access a new Customer Insights - Data environment.
ms.reviewer: sstabbert, v-wendysmith
ms.date: 11/16/2026
ms.custom: sap:Environment management\Environment licensing
---
# Can't access a new Customer Insights - Data environment

## Summary

This article provides a resolution if you can't access a new Dynamics 365 Customer Insights - Data environment due to a disabled service principal.

## Symptoms

When you sign in to Customer Insights - Data, you receive the following error message:

> The service principal for resource \<application ID> is disabled.

## Cause

This issue occurs most likely because an administrator disabled user sign-in for the `<application ID>` enterprise application in Azure.

## Solution

To solve this issue, follow these steps to enable user sign-in for the `<application ID>` enterprise application.

> [!NOTE]
> To enable user sign-in, you need admin permissions for Microsoft Entra ID.

1. Sign in to Microsoft Entra ID in the [Azure portal](https://portal.azure.com/).
1. Go to **Manage** >**Enterprise applications**.
1. Open the **Properties** setting of the `<application ID>` enterprise application.
1. Set **Enabled for users to sign-in?** to **Yes**.
1. Select **Save**.
