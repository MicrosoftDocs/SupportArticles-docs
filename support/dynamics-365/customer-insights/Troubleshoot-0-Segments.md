---
title: Troubleshoot Segments returning "0 members"
description: Learn how to identify the root cause when segment returns 0 members in Dynamics 365 Customer Insights.
author: ashwini-puranik
ms.author: aspuranik
ms.reviewer: mhart
ms.date: 03/08/2023
---

# Segments returning "0 members"

This article provides guidance that will help to identify the root cause of Segments returning "0 members".

## Prerequisites

Segment refresh Status is 'Successful'.
Last refresh date is within 28 days.

## Symptoms

You may find the following issues:

- Segment runs/refreshes successfully but does not include any members/profiles ("0 members").

## Root Cause Identification Steps

Take the following steps to investigate the issue:

1. Validate Basic Logic for contradictory rules:
Having contradictory ANDed conditions or rules on same attribute will always generate a 0-member Segment (e.g. "MyAttribute = 123 AND MyAttribute = 456").
To remove this possibility, analyze all the rules and conditions that would reveal such a broken logic. Of course it could be more complex where the contradiction is actually across several attributes and this would need more business knowledge of what can or cannot exists in the dataset(s) (e.g. "MyAttributeStatus = 1 AND MyAttributeStatusDescription = Inactive" when this is by nature impossible for this dataset where both attributes are functionally linked and "Status = 1" means "Active")

2. Missing Data for the attribute used in Segment Rule or Condition:
If the value of the attribute used in Segment rule or condition is missing for any reason, the segment is likely to return 0 members. This can be investigated further as:

    1. Check the steps described [here](https://learn.microsoft.com/en-us/dynamics365/customer-insights/entities#explore-a-specific-entitys-data) to explore entity data/attribute values. 
If available, closely observe the 'Summary' of attributes you are interested in and ensure they are not in 'Missing' or 'Error' state. 
Please note: 'Summary' view is not available for all system generated entities and is optional for entities ingested using 'Attach Azure Data Lake' ingestion pattern.

2.2 Check if the source records are not rejected for being identified as 'corrupt' as per this [link](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data-sources#corrupt-data-sources).

2.3 If the above steps were not useful to locate/identify the 
