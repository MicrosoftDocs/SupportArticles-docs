---
title: Segment Not Eligible for Export for B2B Audiences
description: Learn how to fix B2B contact export errors in Dynamics 365 Customer Insights - Data by creating eligible contact segments.
ms.reviewer: sstabbert, v-wendysmith
ms.date: 11/16/2026
ms.custom: sap:Segments, measures, insights\Segments
---
# Segment not eligible for export for B2B audiences

## Summary

Dynamics 365 Customer Insights environments for business accounts support contact segments and account segments. Due to this change, contact exports only work with segments based on contacts. Associate contact details with segments and update the refresh schedule to address the error.

## Prerequisites

- Contributor permissions in Customer Insights - Data
- Ownership of the segments to change

## Symptoms

In an environment of business accounts, your exports fail with the following error message:

> The following segment isn't eligible for this export destination: '{name of segment}'. Choose only segments of type ContactProfile and try again.

## Solution

1. Sign in to Customer Insights - Data and open your B2B environment.
1. [Create a segment based on contacts](/dynamics365/customer-insights/segment-builder) that matches your previously used segment.
1. After running that contact segment, edit the respective export and select the new segment.
1. Select **Save** to save the configuration or **Save and run** to test this export right away.
