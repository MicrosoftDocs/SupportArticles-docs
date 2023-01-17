---
title: MDX query contains Aggregate returns error
description: This article describes a problem that occurs if the set in the Aggregate function contains a calculated member.
ms.date: 11/10/2020
ms.custom: sap:Analysis Services
ms.reviewer: yinnw
ms.prod: sql
---
# An MDX query that contains an Aggregate function returns error for the cell values in SQL Server Analysis Services

This article describes a problem that occurs if the set in the `Aggregate` function contains a calculated member.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 942981

## Symptoms

You have a Multidimensional Expressions (MDX) query that uses the `Aggregate` function. The set that is specified in the Aggregate function contains a calculated member. When you run the MDX query against an instance of Microsoft SQL Server Analysis Services, the query returns #Error for the cells values. If you click a cell, you receive the following error message in the **Cell Properties** dialog box:

> A set has been encountered that cannot contain calculated members

> [!NOTE]
> You receive the error message on the Value column of the `VALUE` property and of the `FORMATTED_VALUE` property.

## Cause

This problem occurs because a calculated member contains the `Aggregate` function, and this function has a set of non-aggregatable members.

For example, consider the MDX query that is mentioned in the [Steps to reproduce the problem](#steps-to-reproduce-the-problem) section. In the [Adventure works DW] sample database, the [Scenario].[Scenario] member is non-aggregatable. The property `IsAggregatable` for this dimension attribute is set to **False**. If you run this MDX query, you will receive the error message that is mentioned in the [Symptoms](#symptoms) section.

## Steps to reproduce the problem

1. In SQL Server Business Intelligence Development Studio, open the Adventure Works DW Enterprise Edition sample project.

    > [!NOTE]
    > The Adventure Works DW Enterprise Edition sample project is included in the Analysis Services database project. To download the Analysis Services database project, see [AdventureWorks sample databases](/sql/samples/adventureworks-install-configure).

2. Deploy the sample project to an instance of SQL Server Analysis Services.
3. Open SQL Server Management Studio, and then connect to the instance of Analysis Services.
4. Click **New Query**.
5. In the query window, run the following MDX query:

    ```sql
    WITH MEMBER
    [Scenario].[Scenario].[MyMember]
    AS
    AGGREGATE(
    {[Scenario].[Scenario].&[1],
    [Scenario].[Scenario].&[2],
    [Scenario].[Scenario].&[3],
    [Scenario].[Scenario].[Budget Variance]
    })

    SELECT
    {[Measures].[Amount]} ON AXIS(0)
    FROM
    [Adventure Works]
    WHERE [Scenario].[Scenario].[MyMember]
    ```
