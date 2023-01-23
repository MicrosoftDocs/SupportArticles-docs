---
title: Troubleshoot controls from Customer Card Add-in if they don't find data
description: Learn how to fix an issue with capitalization in customer ID fields.
author: m-hartmann
ms.author: mhart
ms.date: 01/23/2023
---

# Troubleshoot controls from Customer Card Add-in if they don't find data

Resolve issues with empty controls on the Customer Card Add-in.

## Prerequisites

- Administrator permissions in Customer Insights.
- Make sure you configured the Card Add-in according to the instructions: [Configure the Customer Card Add-in](/dynamics365/customer-insights/customer-card-add-in.md#configure-the-customer-card-add-in).
- Ownership of the data source.

## Cause: Uppercase characters in the contactId GUID

If GUID of the contact ID contains capital letters, you need to transform them in the Power Query editor.

### Solution: Transform to lowercase

1. Edit the data source in Power Query Editor.
1. Select the contact ID column.
1. Select **Transform** in the header bar to see available actions.
1. Select **lowercase**. Validate if GUIDs in the table are now lowercase.
1. Save the data source.
1. Run a data refresh.

After the system has completed the full refresh, the Customer Card Add-in controls should show the expected data.
