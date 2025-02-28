---
title: Exports fail with error stating that the following name already exists
description: Provides a resolution for the issue where exports fail because the segments are exported several times with the same name.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 09/25/2023
ms.custom: sap:Export destinations or Outbound connectors\Microsoft connectors
---
# "the following name already exists" error occurs during exports

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

If an export tries to create a new segment in the export destination, but there is already a segment with that name, then review all exports to that destination for segments that are exported several times.

## Prerequisites

- Administrator permissions in Dynamics 365 Customer Insights - Data or Contributor permissions with the ability to share access to the connection used for this export
- The name mentioned in the error message

## Symptoms

A specific export run fails, and you receive the "the following name already exists" error message followed by the output table name of a specific segment.

## Cause

If this error message repeatedly occurs across system refreshes, then it's likely that your exports are set up to export the same segment several times to the same destination, which in rare cases can cause this error message.

## Resolution

To resolve this issue,

1. Note the name mentioned in the error message.
1. Review the list of exported segments for all exports to the export destination that shows the error message.
1. If you find the same segment selected in different exports, change the exports so that each segment is exported only once.
1. Save changes to exports.
1. The next time all exports run, confirm that the error doesn't occur.
