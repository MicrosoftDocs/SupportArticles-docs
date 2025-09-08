---
title: Currency USD doesn't exist for company  
description: Provides a solution to an error that occurs when you generate a report.
ms.reviewer: theley, gbyer, jopankow
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Management Reporter
---
# "Currency USD does not exist for company" Error displays when you generate a report in Management Reporter

This article provides a solution to an error that occurs when you generate a report.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3058400

## Symptoms

When you generate a report, you receive the following error message:

> Currency USD does not exist for company xxxx. No values will be returned.

## Cause

It's caused by the way the currencies configured in Dynamics GP are recognized differently between the Legacy provider and the Data Mart provider.

The legacy provider will recognize a currency from Dynamics GP based on the Currency ID set for the currency. The default currencies for the TWO company include IDs such as **Z-US$**.

The data mart provider will recognize a currency from Dynamics GP based on the ISO Code set for the currency. The default currencies for the TWO company include ISO Codes such as **USD**.

## Resolution

In the column definition, check the **Currency Display** cell in the **FD** columns. If you're using the Data Mart provider, you should see USD and not Z-US$.

In the tree definition, check the **Company**. If the companies are set to Legacy company (the company code includes -Curr), the **Currency Display** in the column should be set to use the currency for the Legacy provider, such as Z-US$. If the companies are using Data Mart, then the **Currency Display** in the column definition should be USD.

If you switch from the Legacy provider to the Data Mart, you can run the script below to check your columns for any that will need to update the Currency Code. You'll need to update data mart database name in the script.

```powershell
select CCM.Name as ColumnDefinition, CSS.Name as BuildingBlockGroup
from ControlColumnCriteria CCC
join ControlColumnDetail CCD on CCC.ColumnDetailID = CCD.ID
join ControlColumnMaster CCM on CCD.ColumnLayoutID = CCM.ID
join ControlSpecificationSet CSS on CSS.ID = CCM.SpecificationSetID
where (CCC.CriteriaType = 8 or CCC.CriteriaType = 7)
and LOW not in ('FUNCTIONAL','NATURAL/ORIGINATING')
and LOW not in (select Name from 
[DDM-GP]..UnitOfMeasure --<<-- Update name of the data mart database
) 
group by CCM.name, CSS.Name
order by CCM.Name
```
