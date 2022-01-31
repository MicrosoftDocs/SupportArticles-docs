---
title: Error when you process a database or a cube
description: This article provides a resolution for the problem where you receive error messages when you try to process a database or a cube in SQL Server Analysis Services.
ms.date: 09/22/2020
ms.custom: sap:Analysis Services
ms.prod: sql
---
# Error messages when you try to process a database or a cube

This article helps you resolve the problem where you receive error messages when you try to process a database or a cube in SQL Server Analysis Services.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 922673

## Symptoms

In SQL Server Analysis Services, you try to process a database or a cube by using SQL Server Business Intelligence Development Studio or SQL Server Management Studio. However, the process operation fails, and you receive the following error messages:

- Error message 1

    > Errors in the OLAP storage engine`:` The attribute key cannot be found`:` Table`:` TableName, Column`:` ColumnName1, Value`:` Value1. Table`:` TableName, Column`:` ColumnName2, Value: Value2.

- Error message 2

    > Errors in the OLAP storage engine: The record was skipped because the attribute key was not found. Attribute: generated attribute X of Dimension: DimensionName from Database: DatabaseName, Cube: CubeName, Measure Group: MeasureGroupName, Partition: PartitionName, Record: RecordNumber.

## Cause

This issue occurs because a fact table for a cube has one or more records that contain an attribute key, and this attribute key does not exist in the corresponding dimension table. This behavior may occur when you have not processed the corresponding dimension before you process the cube or when the underlying tables actually have mismatched data. If the "Value:" field in the message has no number after it, the fact table must contain null data.

## Resolution

To resolve this issue, you must verify that your data source points to the following locations:

- The correct underlying data source instance, such as an instance of SQL Server.
- The correct database.

Then, correct the underlying records that contain the problematic attribute key. To do this, use one of the following methods.

### Use an existing attribute key

Update the records to use an existing attribute key by running a statement resembles the following:

```sql
Update <TableName> set <KeyName>=<ExistingKeyValue> where <KeyName>=<BadKeyValue> or <KeyName> IS NULL
```

### Match the key values in the fact table

Insert additional rows into the dimension table to match the key values in the fact table. If null values exist, use one of the following methods:

- Replace the null values with actual values.

- Configure the dimension or dimensions to have an unknown member by setting the `UnknownMember` and `UnknownMemberName` properties. You can make the unknown member either visible or hidden depending on your needs.

- Use all the following settings in the **Change Settings** dialog box:

  - Set the `KeyErrorAction` property to **ConvertToUnknown**.
  - Set the `NullKeyNotAllowed` property to **IgnoreError** or **ReportAndContinue**.
  - Set the `NullKeyConvertedtoUnknown` property to **IgnoreError** or **ReportAndContinue**.
  - Click **Ignore errors count**.
  
  You can set these settings instance-wide, or you can use a custom configuration for each dimension.

### Ignore the error

If you want to process the database or the cube without correcting the data, you can set the error configuration for the process operation to ignore the error. You should only do this as a temporary workaround when you fix the underlying data. Otherwise, you may receive unexpected results from your multidimensional expressions (MDX) queries. To ignore the errors, follow these steps:

1. In the **Process Database -**DatabaseName**** dialog box or the **Process Cube -**CubeName**** dialog box, click **Change Settings**.
2. In the **Change Settings** dialog box, click the **Dimension key errors** tab.
3. Click **Use custom error configuration**.
4. In the **Key not found** list, change the default value from **Report and continue** to **Ignore error**.
5. Click **Ignore errors count**.
6. Click **OK** to close the **Change Settings** dialog box.
7. Click **OK** to process the database or the cube.

Additionally, you can set the error configuration for the cube or the partition to ignore the error. For more information, see [Error Configuration for Cube, Partition, and Dimension Processing](/analysis-services/multidimensional-models/error-configuration-for-cube-partition-and-dimension-processing).

## Status

This behavior is by design.
