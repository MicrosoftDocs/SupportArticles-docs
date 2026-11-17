---
title: Customer Card Add-in Controls Don't Find Data
description: Customer Card Add-in controls don't displaying contact data. Convert uppercase GUID characters to lowercase, then refresh the connected data source.
ms.reviewer: sstabbert, v-wendysmith
ms.date: 11/16/2026
ms.custom: sap:Export destinations or Outbound connectors\Microsoft connectors
---
# Customer Card Add-in controls don't find data

## Summary

This article helps you resolve issues with Customer Card Add-in controls that don't show data.

## Prerequisites

- Administrator permissions in Dynamics 365 Customer Insights - Data.
- Make sure that you configured the Card Add-in according to the instructions in [Configure the Customer Card Add-in](/dynamics365/customer-insights/customer-card-add-in#configure-the-customer-card-add-in).
- Ownership of the data source.

## Symptoms

Some controls in the Customer Card Add-in don't show data.

## Solution

If the GUID (Globally Unique Identifier) of the contact ID contains capital letters, you need to transform them in the Power Query editor.

1. Edit the data source in the Power Query editor.
1. Select the contact ID column.
1. Select **Transform** in the header bar to see available actions.
1. Select **lowercase**. Check if GUIDs in the table are now lowercase.
1. Save the data source.
1. Run a data refresh.

After the system completes the full refresh, the Customer Card Add-in controls should show the expected data.
