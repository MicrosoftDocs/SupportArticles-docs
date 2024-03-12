---
title: Filter expression returns extra blank records in results 
description: Describes an issue where filter expressions return extra blank records in results for a formula.
author: lancedmicrosoft
ms.reviewer: tapanm
ms.date: 06/24/2022
ms.author: lanced
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - lancedmicrosoft
  - tapanm-msft
---
# Filter expression returns extra blank records in results

## Symptoms

Filter results sometimes have extra, unexpected, blank records in the result.

## Cause

Client-side filtering can result in blank records in the result when the **Formula-level error management** app setting is turned on. When a filter expression results in an unhandled error, blank records may be inserted in the result.

## Resolution

Use a formula pattern as follows:

```powerapps-dot
Filter(datasource, IfError(<query predicate>, false))
```

## See also

- [Get started with formulas in canvas apps](/power-apps/maker/canvas-apps/working-with-formulas)
- [Formula reference for Power Apps](/power-platform/power-fx/formula-reference)
