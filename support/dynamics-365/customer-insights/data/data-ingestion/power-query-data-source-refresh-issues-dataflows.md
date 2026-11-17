---
title: Power Query Data Source Refresh Issues or Failures
description: Power Query data source refresh issues can cause stale data or failures. Find steps to restore refreshes in Customer Insights - Data.
ms.reviewer: sstabbert, v-wendysmith
ms.date: 11/16/2026
ms.custom: sap:Data Ingestion\Connect to a Power Query data source
---
# Power Query data source refresh issues for data sources based on Power Platform dataflows

## Summary

This article helps you resolve issues with stale data or errors after a data source refresh for Power Query data sources that are based on Power Platform dataflows.

## Prerequisites

You need permission to view and update dataflows.

## Symptoms

You might encounter the following issues:

- Ownership of the data source changed. If the status of the dataflow is **Success**, the ownership of the Power Query-based data source might have changed.
- The data refresh status of the dataflow is **Failed**.

## Solution

To resolve the issue, follow these steps:

1. Sign in to [Power Apps](https://make.powerapps.com).
1. Select the environment with your Dynamics 365 Customer Insights data and go to **Dataflows**.
1. If the status is **Success**:

   1. Review the refresh schedule from the refresh history.
   1. Set the new owner's schedule and save the settings.

1. If the status is **Failed**:

   1. Download the refresh history file.
   1. Review the downloaded file for the reason for the failure.
   1. If you can't resolve the error, open a support ticket. Include the downloaded refresh history file.
