---
title: Set-SCDWRetentionPeriod doesn't work correctly
description: The Set-SCDWRetentionPeriod doesn't set the data retention period correctly. Provides a workaround.
author: helenclu
ms.author: luche
ms.reviewer: aakashb
ms.date: 05/13/2021
appliesto: 
- System Center Service Manager
---
# Set-SCDWRetentionPeriod doesn't set the data retention period correctly

When you use the [Set-SCDWRetentionPeriod](/powershell/module/microsoft.enterprisemanagement.warehouse.cmdlets/set-scdwretentionperiod) cmdlet, it doesn't set the data retention period correctly.

## Workaround

To work around this issue, after you run the cmdlet, run a SQL command that's similar to the following example:

```sql
-- This example sets the data retention period to 10 years for all fact tables.
 
declare @RetentionPeriodInYears int = 10
UPDATE wegi
SET wegi.RetentionPeriodInMinutes = (@RetentionPeriodInYears*366*24*60)
FROM etl.WarehouseEntityGroomingInfo AS wegi JOIN etl.WarehouseEntity AS we ON we.WarehouseEntityId = wegi.WarehouseEntityId
WHERE we.WarehouseEntityName NOT IN ('EntityManagedTypeFact', 'EntityRelatesToEntityFact')
```

For more information about setting the data retention period for specific fact tables, see the following article:

[How long does the Service Manager Data Warehouse retain historical data](https://techcommunity.microsoft.com/t5/system-center-blog/how-long-does-the-service-manager-data-warehouse-retain/ba-p/343507)
