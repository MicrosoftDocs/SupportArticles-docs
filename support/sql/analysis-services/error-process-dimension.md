---
title: Error when you process a dimension
description: This article provides a resolution for the problem that occurs when you process a dimension in SQL Server Analysis Service.
ms.date: 11/05/2020
ms.prod-support-area-path: Analysis Services
ms.prod: sql
---
# Error message when processing a dimension

This article helps you resolve the problem that occurs when you process a dimension in SQL Server Analysis Service.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2002757

## Symptoms

In SQL Server Analysis Service, dimension processing and you may receive an error message that resembles the following:

> Errors in the OLAP storage engine: A duplicate attribute key has been found when processing: Table: 'TABLE_NAME', Column: 'ATTRIBUTE_COLUMN_NAME, Value: 'ATTRIBUTE_VALUE'. The attribute is 'ATTRIBUTENAME' .

## Cause

The behavior is by design. SQL Server Analysis services will detect the duplicate attribute key during processing.

The above error can also be triggered when the relational database is case-sensitive and the data values are in mixed-case. In Analysis services, when creating a dimension and its attribute(s), the default collation for the attribute is case-insensitive. The dimension by-default has **ErrorConfiguration**|**KeyDuplicate** set to be **ReportAndStop**. So if you have a case-sensitive relational database that, for example,  contains data values **BOOKNAME** and **Bookname**, during dimension processing, if the data **BOOKNAME** first was processed as attribute key, the subsequent processing will fail with the following error:

> A duplicate attribute key has been found when processing: Table: 'TABLE_NAME', Column: 'ATTRIBUTE_COLUMN_NAME, Value: 'Bookname'. The attribute is 'ATTRIBUTENAME'.

## Resolution

When designing dimensions, dimension attributes and attribute relationships, you should check the relational data values for duplicates and if they do exist, use one of the following procedures to address the issue:

- **Option 1**: Edit the named query in Data Source View to select only the data with the desired case.

  For example, you can use `UPPER` or `LOWER` case function in the named query.

- **Option 2**: You can work around the problem using either of the following options:

  > [!NOTE]
  > These options are not usually recommended as they may result in unexpected data, but can be used for troubleshooting purpose.

  - Set **KeyDuplicate** element's value to **ReportAndContinue** and **KeyErrorLimitAction** to StopLogging in **ErrorConfiguration**.

  - Using the Dimension Editor in Business Intelligence Development Studio (BIDS), open the dimension that the attribute belongs to and set the proper collation for the attribute by using the Collation property of the dimension.
  
    > [!NOTE]
    > This will cause the dimension to have a duplicate attribute key (different case values) after processing is complete.
