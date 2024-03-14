---
title: The operation could not be completed due to a problem in the data provider framework error when creating a report
description: Describes an error that occurs when you generate a report in Management Reporter that includes budget information from Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, gbyer, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# "The operation could not be completed due to a problem in the data provider framework" error when you create a report

This article provides a resolution for the issue that you can't create a report in Microsoft Management Reporter that includes Dynamics GP budget information.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2739480

## Symptoms

When you generate a report in Microsoft Management Reporter that includes Dynamics GP budget information, you receive the following error message:

> The operation could not be completed due to a problem in the data provider framework.

## Cause

This error is caused by a blank budget ID in Microsoft Dynamics GP.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this error message, follow these steps:

1. Open SQL Server Management Studio and sign in with the sa credentials.
2. Run the following query against your GP company database:

    ```sql
    Select * from GL00200
    ```

3. Check the BudgetID column for any blank IDs.
4. If there are blank IDs, you can run the following query against the GP company database to remove them:

    ```sql
    Delete from GL00200 where budgetid = ' '
    ```

You should now be able to generate the report in MR without receiving the error message.
