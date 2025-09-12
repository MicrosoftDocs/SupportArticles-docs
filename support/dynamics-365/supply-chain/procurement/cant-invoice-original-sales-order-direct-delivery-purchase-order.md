---
title: You can't invoice a customer-facing sales order
description: Provides a resolution for the issue that you can't invoice the original sales order and the original direct delivery purchase order after you enable the Post invoice automatically option.
author: Henrikan
ms.date: 05/16/2024
ms.search.form: SalesEditLines
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: henrikan
ms.search.validFrom: 2021-04-11
ms.dyn365.ops.version: 10.0.19
ms.custom: sap:Purchase order procurement and sourcing\Issues with intercompany
---
# You can't invoice a customer-facing sales order

KB number: 4611793

## Symptoms

You can no longer invoice the original sales order and the original direct delivery purchase order after you enable the **Post invoice automatically** option on the **Intercompany** page for a vendor.

## Resolution

The synchronization behavior for intercompany and direct delivery order invoices is controlled and forced by the parameters that are described in [Set up parameters to post an intercompany order](/dynamicsax-2012/appuser-itpro/set-up-parameters-to-post-an-intercompany-order).

After you set those parameters, you must invoice the intercompany sales order first. The original sales orders and purchase orders will then be synchronized.
