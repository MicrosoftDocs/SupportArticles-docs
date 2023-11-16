---
title: Power Query data source refresh issues for data sources based on Power Platform dataflows
description: Learn how to address issues with data sources based on Power Platform dataflows in Dynamics 365 Customer Insights - Data.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 09/25/2023
---
# Power Query data source refresh issues for data sources based on Power Platform dataflows

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article can resolve issues if data is stale or you see errors after a data source refresh for Power Query data sources that are based on Power Platform dataflows.

## Prerequisites

You need permission to see and update dataflows.

## Symptoms

You may find the following issues:

- Ownership of the data source has changed. If the status of the dataflow is "Success," the ownership of the Power Query-based data source might have changed.
- The data refresh status of the dataflow is "Failed."

## Resolution

To solve the issue, take the following steps:

1. Sign in to [Power Apps](https://make.powerapps.com).
1. Choose the environment with your Dynamics 365 Customer Insights data and navigate to **Dataflows**.
1. If the status is "Success":

   1. Review the refresh schedule from the refresh history.
   1. Set the new owner's schedule and save the settings.

1. If the status is "Failed":

   1. Download the refresh history file.
   1. Review the downloaded file for the reason for the failure.
   1. If the error can't be resolved, open a support ticket. Include the downloaded refresh history file.
