---
title: Work can't be canceled because of its status
description: Provides a resolution for the Work can't be canceled because of its status error.
author: Mirzaab
ms.date: 04/15/2021
ms.topic: troubleshooting
ms.search.form: WHSWorkTable_WHSWorkCancel, WHSWorkTableListPage_WHSWorkCancel
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: mirzaab
ms.search.validFrom: 2021-05-15
ms.dyn365.ops.version: 10.0.18
ms.custom: sap:Warehouse management
---

# Work can't be canceled because of its status

Error code: WAX2190

## Symptoms

The system shows the following error message:

> You cannot cancel work %1 because it has a status of %2.

## Cause

The work can't be canceled in its current state.

The work header or work lines don't have the expected **Work status** value. The **Work status** field on the work header isn't set to **Open** or **In progress**.

## Resolution

To cancel the work, follow these steps.

1. Go to **Warehouse management** > **Periodic tasks** > **Clean up** > **Cancel work**.
1. In the **Work ID** field, specify the ID of the work that you want to cancel.
1. Select **OK**.
1. Select **Yes** to confirm that you want to cancel the work.

For more information, see [Cancel warehouse work for exception handling](/dynamics365/supply-chain/warehousing/cancel-warehouse-work).
