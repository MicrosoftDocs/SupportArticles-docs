---
title: Set-SCDWRetentionPeriod doesn't work correctly
description: Discusses that the Set-SCDWRetentionPeriod cmdlet doesn't set the data retention period correctly. Provides a workaround.
author: Cloud-Writer
ms.author: meerak
ms.reviewer: aakashb, khusmeno
ms.date: 05/21/2024
---
# Set-SCDWRetentionPeriod doesn't set the data retention period correctly

*Applies to*: System Center 2019 Service Manager (Update Rollup 2 and earlier versions)

> [!NOTE]
> This issue has been fixed in Update Rollup 4 for System Center 2019 Service Manager.

When you run the [Set-SCDWRetentionPeriod](/powershell/module/microsoft.enterprisemanagement.warehouse.cmdlets/set-scdwretentionperiod) cmdlet, the cmdlet doesn't set the data retention period correctly.

## Workaround

To work around this issue, run a SQL command that resembles the following example after you run the cmdlet:

```sql
-- This example sets the data retention period to 10 years for all fact tables.
 
declare @RetentionPeriodInYears int = 10
UPDATE wegi
SET wegi.RetentionPeriodInMinutes = (@RetentionPeriodInYears*366*24*60)
FROM etl.WarehouseEntityGroomingInfo AS wegi JOIN etl.WarehouseEntity AS we ON we.WarehouseEntityId = wegi.WarehouseEntityId
WHERE we.WarehouseEntityName NOT IN ('EntityManagedTypeFact', 'EntityRelatesToEntityFact')
```

For more information about how to set the data retention period for specific fact tables, see the following article:

[How long does the Service Manager Data Warehouse retain historical data](https://techcommunity.microsoft.com/t5/system-center-blog/how-long-does-the-service-manager-data-warehouse-retain/ba-p/343507)
