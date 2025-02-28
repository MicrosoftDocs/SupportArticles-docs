---
title: Segment not eligible for export for B-to-B audiences
description: Learn how to address export issues with ineligible segments in Dynamics 365 Customer Insights - Data.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 09/25/2023
ms.custom: sap:Segments, measures, insights\Segments
---
# Segment not eligible for export for B-to-B audiences

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

Dynamics 365 Customer Insights environments for business accounts support contact segments and account segments. Due to this change, contact exports only work with segments based on contacts. Associate contact details with segments and update the refresh schedule to address the error.

## Prerequisites

- Contributor permissions in Customer Insights - Data
- Ownership of the segments to change

## Symptoms

In an environment of business accounts, your exports fail with the error message:

> The following segment isn't eligible for this export destination: '{name of segment}'. Choose only segments of type ContactProfile and try again.

## Resolution

1. Sign in to Customer Insights - Data and open your B-to-B environment.
1. [Create a segment based on contacts](/dynamics365/customer-insights/segment-builder) that matches your previously used segment.
1. Once that contact segment is run, edit the respective export and select the new segment.
1. Select **Save** to save the configuration or **Save and run** to test this export right away.
