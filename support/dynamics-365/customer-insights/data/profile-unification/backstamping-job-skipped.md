---
title: Backstamping job skipped in Dynamics 365 Customer Insights - Data
description: Provides a resolution for an issue where data unification fails due to backstamping job errors in Microsoft Dynamics 365 Customer Insights - Data.
ms.date: 02/26/2026
ms.reviewer: sstabbert, v-wendysmith
ms.custom: sap:Data Unification\Match
---
# "Backstamping job skipped" message appears on the System status page

This article provides a resolution for an issue where data unification fails due to a skipped backstamping job.

## Symptom

The following message appears on the **System** > **Status** page under the CustomerId Backstamping Hydration job.

> Backstamping job skipped

## Cause

If the backstamping job is skipped, the automatic linking requirements aren't met.

## Resolution

Verify the requirements at [Link to a customer profile](/dynamics365/customer-insights/data/integrate-d365-apps#link-to-a-customer-profile).