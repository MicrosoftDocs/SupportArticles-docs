---
title: Segment not eligible for export for B2B audiences
description: Learn how to address export issues with ineligible segments in Dynamics 365 Customer Insights.
author: m-hartmann
ms.author: mhart
ms.date: 01/23/2023
---

# Segment not eligible for export for B2B audiences

Customer Insights environments for business accounts support contact segments and account segments. Due to that change, contact exports only work with segments based on contacts. Associate contact details to segments and update the refresh schedule to address the error.

## Prerequisites

- Contributor permissions in Customer Insights.
- Ownership of the segments to change.

## Symptoms

Within an environment of business accounts your exports fail with the error message:
"The following segment isn't eligible for this export destination: '{name of segment}'. Choose only segments of type ContactProfile and try again."

### Resolutions

1. Sign in to Customer Insights and open the B2B environment.

1. [Create a segment based on contacts](/dynamics365/customer-insights/segment-builder.md), which matches your previously used segment.

1. Once that contact segment is run, edit the respective export and select the new segment.

1. Select **Save** to save the configuration or **Save and run** to test this export right away.
