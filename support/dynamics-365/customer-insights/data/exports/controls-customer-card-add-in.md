---
title: Controls from Customer Card Add-in if they don't find data
description: Learn how to fix an issue with capitalization in customer ID fields.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 09/25/2023
---
# Controls from Customer Card Add-in if they don't find data

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

If the GUID (Globally Unique Identifier) of the contact ID contains capital letters, you need to transform them in the Power Query editor.

## Prerequisites

- Administrator permissions in Dynamics 365 Customer Insights - Data.
- Make sure that you configured the Card Add-in according to the instructions: [Configure the Customer Card Add-in](/dynamics365/customer-insights/customer-card-add-in#configure-the-customer-card-add-in).
- Ownership of the data source.

## Symptoms

Some controls in the Customer Card Add-in don't show data.

## Resolution

1. Edit the data source in the Power Query editor.
1. Select the contact ID column.
1. Select **Transform** in the header bar to see available actions.
1. Select **lowercase**. Validate if GUIDs in the table are now lowercase.
1. Save the data source.
1. Run a data refresh.

After the system has completed the full refresh, the Customer Card Add-in controls should show the expected data.
