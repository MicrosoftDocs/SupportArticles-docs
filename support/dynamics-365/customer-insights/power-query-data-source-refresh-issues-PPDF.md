---
title: Power Query data source refresh issues for data sources based on Power Platform Dataflows
description: Learn how to address issues with data sources based on Power Platform Dataflows in Dynamics 365 Customer Insights.
author: m-hartmann
ms.author: mhart
ms.date: 01/23/2023
---

# Power Query data source refresh issues for data sources based on Power Platform Dataflows

Resolve issues if the data is stale or you see errors after a data source refresh for Power Query data sources that are based on Power Platform Dataflows.

## Prerequisites

- Permission to see and update dataflows.

## Symptoms

Ownership of the data source has changed. If the **Status** of the dataflow is **Success**, the ownership of the Power Query-based data source might have changed.
Data refresh fails. If the **Status** of the dataflow is **Failed**.

## Resolution

1. Sign in to [Power Apps](https://make.powerapps.com).

1. Choose the **Environment** with your Customer Insights data and navigate to **Dataflows**

1. If the status is **Success**:

   1. Review the refresh schedule from the refresh history.
   1. Set the new owner's schedule and save the settings.

1. If the status is **Failed**:

   1. Download the refresh history file.
   1. Review the downloaded file for the reason for the failure.
   1. If the error cannot be resolved, open a support ticket. Include the downloaded refresh history file.
