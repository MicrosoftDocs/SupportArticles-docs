---
title: Duplicate Segment Export Errors in Customer Insights
description: The following name already exists error occurs when exports include the same segment multiple times. Discover how to resolve duplicate segment selections.
ms.reviewer: sstabbert, v-wendysmith
ms.date: 11/16/2026
ms.custom: sap:Export destinations or Outbound connectors\Microsoft connectors
---
# "The following name already exists" error during exports

## Summary

This article helps you resolve issues when exports fail with the "The following name already exists" error.

## Prerequisites

- Administrator permissions in Dynamics 365 Customer Insights - Data or Contributor permissions with the ability to share access to the connection used for this export
- The name mentioned in the error message

## Symptoms

A specific export run fails, and you receive the "The following name already exists" error message followed by the output table name of a specific segment.

## Cause

If this error message repeatedly occurs across system refreshes, your exports might export the same segment several times to the same destination. In rare cases, this setup causes this error message.

## Solution

To resolve this issue, take the following steps.

1. Note the name mentioned in the error message.
1. Review the list of exported segments for all exports to the export destination that shows the error message.
1. If you find the same segment selected in different exports, change the exports so that each segment is exported only once.
1. Save changes to exports.
1. The next time all exports run, confirm that the error doesn't occur.
