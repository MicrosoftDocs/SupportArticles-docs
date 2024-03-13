---
title: Inventory activity exists for this manufacturing order error when accessing MO
description: When you try to access a manufacturing order, you receive an error that states Inventory activity exists for this manufacturing order. Provides a resolution.
ms.reviewer: theley, jimscha
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Inventory activity exists for this manufacturing order" error when accessing an MO via the Quick MO window

This article provides a resolution for the error **Inventory activity exists for this manufacturing order** that occurs when you access an MO in the Quick MO Entry window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2011445

## Symptoms

When you access an MO in the Quick MO Entry window, you receive the following error message:

> Inventory activity exists for this manufacturing order. You can no longer use this window to edit or close this manufacturing order.

## Cause

This problem occurs if any transactions, such as Issue Transactions, have been manually posted to the MO.

## Resolution

1. Select **Inquiry**, select **Manufacturing**, select **Manufacturing Orders**, and then select **MO Activity**.
2. Use the MO Activity window to verify the accuracy of the posted transactions.
3. Use the Component Transaction Entry, MO Receipt and MO Close windows to process the MO.

    - Component Transaction Entry - Select **Transactions**, select **Manufacturing**, select **Manufacturing Orders**, and then select **Component Transaction Entry**.
    - MO Receipt - Select **Transactions**, select **Manufacturing**, select **Manufacturing Order**, and then select **MO Receipt Entry**.
    - MO Close -Select **Transactions**, select **Manufacturing**, select **Manufacturing Order**, and then select **MO Close**.
