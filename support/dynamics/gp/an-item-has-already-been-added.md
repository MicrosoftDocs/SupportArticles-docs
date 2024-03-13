---
title: An item has already been added
description: Describes an error message that may occur during the FiscalYearProvider to Fiscal Year task in Microsoft Management Reporter.
ms.reviewer: davidtre
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "An item with the same key has already been added" Error message displays in Management Reporter 2012 FiscalYearProvider to Fiscal Year task

This article provides a solution to an error that occurs when you use Microsoft Management Reporter 2012 with Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2983920

## Symptoms

When you use Microsoft Management Reporter 2012 with Microsoft Dynamics GP, you may receive the following error message during the FiscalYearProvider to Fiscal Year integration task:

> An item with the same key has already been added

## Cause

There may be duplicate `Dex_Row_Id` values within the SY40100 and SY40101 tables.

## Resolution

Run both scripts against the company database(s) to check for duplicate `Dex_Row_Id` values within the period tables.

```powershell
select top 1 DEX_ROW_ID from sy40100 group by DEX_ROW_ID having count(*) > '1'
```

```powershell
select top 1 DEX_ROW_ID from sy40101 group by DEX_ROW_ID having count(*) > '1'
```

If a record is returned, contact support for further assistance.

Use the Support Topic: Financial - General Ledger, and the Sub-Topic: Fiscal Periods

To reach the Message Center to open a support incident, call 1-888-477-7877. Provide as many details as you can.
