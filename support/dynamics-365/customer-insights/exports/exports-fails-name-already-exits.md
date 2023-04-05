---
title: Exports fail because name already exists in destination
description: Learn how to fix export failures due to list already existing in export destination.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 04/05/2023
---

# Exports fail with error stating that the following name already exists

If an export tries to create a new segment in the export destination but there's already a segment with that name, then review all exports to that destination for segments which are exported several times.

## Prerequisites

- Administrator permissions in Dynamics 365 Customer Insights or Contributor permissions with the ability to share access to the connection used for this export.
- The name mentioned in the error message. 

## Symptoms

A specific export run fails with the error message "the following name already exists" followed by the output table name of a specific segment. 
If this error happens repeatedly across Customer Insights' system refreshes, then it's likely your exports from Customer Insights are setup to export the same segment several times to the same destination, which in rare cases can cause this error.

## Resolution

1. Note the name mentioned in the error. 
1. Review the list of exported segments for all exports to the export destination that shows the error.
1. If you find the same segment selected in different exports, change the exports so that each segment is exported only once.
1. Save changes to exports.
1. Verify the next time when all exports run, that the error does not occur.


