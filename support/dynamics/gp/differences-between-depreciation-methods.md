---
title: Differences between depreciation methods
description: Discusses the differences between the daily depreciation method and the periodic depreciation method
ms.reviewer: theley, v-shanee, lmuelle
ms.date: 03/20/2024
ms.custom: sap:Financial - Fixed Assets
---
# Differences between the daily depreciation method and the periodic depreciation method in Microsoft Dynamics GP

This article discusses the differences between the daily depreciation method and the periodic depreciation method in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 934841

## Introduction

You select the depreciation method in the Book Setup window in Fixed Asset Management in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0.

## More information

A yearly depreciation amount is calculated for each asset. Microsoft Dynamics GP calculates the same yearly depreciation amount regardless of the depreciation method that you use.

When you use the daily depreciation method, the yearly depreciation amount is divided by the number of days in a calendar period. So the depreciation amount varies depending on the number of days in the month. For example, the depreciation amount in February is less than the depreciation amount for the months that have 31 days.

When you use the periodic depreciation method, the yearly depreciation amount is divided by the number of periods in the year. So the depreciation amount is the same for each period.

## Example of how depreciation is calculated

Consider the following data:

- Asset cost: $10,000
- Original life in years: five
- Original life in months: 60
- Place in service date: 01/01/2006
- Zero YTD depreciation
- Zero LTD depreciation
- Averaging convention: full period
- Period: calendar year

When this data is used, the following depreciation amounts are calculated when you use the daily depreciation method and when you use the periodic depreciation method.

|Month|Daily depreciation method|Periodic depreciation method|
|---|---|---|
|January|169.77|166.58|
|February|153.34|166.58|
|March|169.77|166.58|
|April|164.30|166.58|
|May|169.77|166.58|
|June|164.30|166.58|
|July|169.77|166.58|
|August|169.77|166.58|
|September|164.30|166.58|
|October|169.77|166.58|
|November|164.30|166.58|
|December|169.74|166.52|
|**Total**| **1998.90**| **1998.90** |
  
When you use the daily depreciation method, the depreciation amount is calculated as follows:

- $10,000 divided by 1,826 days equals a daily depreciation amount of $5.48. 1,826 is the total number of days in five years plus one day for leap year.
- The depreciation amount varies depending on the number of days in a particular month. For example, March has 31 days. So $5.48 × 31 days equal the depreciation amount of $164.30 for March.

When you use the periodic depreciation method, the depreciation amount is calculated as follows:

- $10,000 divided by 1,826 days × 365 days equals the yearly depreciation amount of $1,998.90. Then, $1,998.90 divided by 12 months equals the periodic depreciation amount of $166.56.

> [!NOTE]
> When a standard straight-line depreciation method is used, the depreciation amount is calculated as follows:
>
> - $10,000 divided by five years equals $2,000. Then, $2,000 divided by 12 months equals the depreciation amount of $166.67.
