---
title: Divide by zero error when printing the Historical Stock Status report
description: Provides a solution to the error that occurs when you print the Historical Stock Status report in Microsoft Dynamics GP.
ms.reviewer: cwaswick, Angela, theley
ms.date: 03/20/2024
ms.custom: sap:Distribution - Inventory
---
# "Divide by zero" error when you print the Historical Stock Status report in Microsoft Dynamics GP

This article provides a solution to the error that occurs when you print the Historical Stock Status report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3210333

## Symptoms

When you print the Historical Stock Status report (HSSR) in Microsoft Dynamics GP, you receive the following error message:

> Unhandled Script Exception  
SCRIPTS - data area  
EXCEPTION_CLASS_SCRIPT_DIVIDE_BY_ZERO  
SCRIPT_CMD_DIV

## Cause

This problem is typically caused by some type of data corruption in the IV30300 table. Here are the most common causes:

### Cause 1: Specific document types in the IV30300 are missing a transaction source

#### Resolution

Each document that's posted through Microsoft Dynamics GP should have a transaction source associated with it. Because of a posting interruption or an integration/customization issue, this value may be missing. Use the following script to identify any documents that have a blank transaction source. All these document types listed should have a transaction source. If they don't have a transaction source, the records need to be fixed or removed.

1. Run the following statement against the company database in SQL Server Management Studio to identify transactions with this condition:

    ```sql
    SELECT * FROM IV30300 WHERE TRXSORCE = '' and doctype in (1, 2, 3, 4, 5, 6, 7) 
    ```

2. If any documents get returned using the above script, run a select statement on the document number listed against the following Inventory tables (IV30300, SEE30303, IV10200, IV10201). And investigate where the corruption is or if it's only in the IV30300 table. It might be a corrupt record, or it might be partially updated. Each line returned will have to be investigated and determine how to continue with fixing. If it can be deleted, we suggest deleting it based on DEX_ROW_ID.

    For example:

    ```sql
    DELETE IV30300 WHERE DEX_ROW_ID = XXX
    ```

As you review your data in the select statement above, typically, you'll have two lines versus one line. You'll want to remove the corrupt record missing the transaction source.

### Cause 2: Specific document types with invalid values of 0 in the DECPLCUR and DECPLQTY fields

#### Resolution

> [!NOTE]
> The `DECPLCUR` field refers to the captured currency decimal place, and the `DECPLQTY` field refers to the captured quantity decimal place for the item. On all valid transactions, this should be populated with a value.

Run the following statement against the company database in SQL Server Management Studio to identify transactions with this condition:

```sql
Select * from IV30300 where (DECPLQTY = 0 or DECPLCUR = 0) and doctype in (1, 2, 3, 4, 5, 6, 7) 
```

If you find documents with `0` decimal places, they need to be investigated. Correct the corrupted transaction by using SQL Query Analyzer and update the fields to the appropriate value.

Decimal place values in the IV30300 are as follows:

|Value in table|Value shows in GP (Actual value)|
|---|---|
|1|0|
|2|1|
|3|2|
|4|3|
|5|4|
|6|5|
  
Example of the update statement:

```sql
UPDATE IV30300 set DECPLQTY = 3 WHERE DEX_ROW_ID = XXX
```

If the results are all old transactions and you prefer to remove history for the corrupted transactions, you can remove history by selecting **Tools** on the Microsoft Dynamics GP menu and then by selecting **Utilities** > **Inventory** > **Remove Transaction History** to remove the appropriate document number(s).

## More information

If the script from cause 1 or 2 doesn't return any results, focus on identifying the problem item by printing the Historical Stock Status report by item number. Narrow in on the item numbers using a range. Start with a smaller range and work through the alphabet to identify the problem item. For example, enter a range of items starting with the letter A through D. Print that range and see if you receive the error. Don't continue down the alphabet until you've identified the item with the issue. Once you identify the item, get the results of the IV30300 table for that item and start investigating.

If you still are unable to find the issue item or document, run a SQL Profiler trace and trap the error. Make sure to leave the error on the screen (don't select past it) and then stop the trace. Typically, at the end of the trace, you should see the document number causing the error and can investigate from there. If you clean up the item and still receive the error, create a new trace and see if it's finding another culprit transaction.

Possible workaround:

Another option is to try printing with or without the Use GL Posting date on the Report Option to see if one option works. It might give you the option to print the report while you investigate the issue and identify the problem.
