---
title: Divide by zero error
description: Provides a solution to an error that occurs when you print the Historical Stock Status report in Microsoft Dynamics GP.
ms.reviewer: cwaswick, Angela
ms.topic: troubleshooting
ms.date: 01/12/2023
---
# "Divide by zero" error when you print the Historical Stock Status report in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you print the Historical Stock Status report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3210333

## Symptoms

Error message when you print the Historical Stock Status report (HSSR) in Microsoft Dynamics GP:

> Unhandled Script Exception  
SCRIPTS - data area  
EXCEPTION_CLASS_SCRIPT_DIVIDE_BY_ZERO  
SCRIPT_CMD_DIV

## Cause

This problem is typically caused by some type of data corruption in the IV30300 table. Most common are:

1. Specific document types in the IV30300 are missing a transaction source.
2. Specific document types with invalid values of 0 in the DECPLCUR and DECPLQTY fields.

## Resolution

Cause 1

Specific document types in the IV30300 are missing a transaction source. Each document that is posted through Microsoft Dynamics GP should have a transaction source associated with it. Because of a posting interruptions or an integration/customization issue, this value may be missing. Use the script below to identify any documents that have a blank transaction source. All of these document types listed should have a transaction source. If they don't have a transaction source, the records need to be fixed or removed.

1. Run the following statement against the company database in SQL Server Management Studio to identify transactions with this condition:

    ```sql
    SELECT * FROM IV30300 WHERE TRXSORCE = '' and doctype in (1, 2, 3, 4, 5, 6, 7) 
    ```

2. If any documents get returned using the script above, run a select statement on the document number listed against the following Inventory tables (IV30300, SEE30303, IV10200, IV10201) and investigate where the corruption is or if it's only in the IV30300. It might be a corrupt record or it might be partially updated. Each line returned will have to be investigated and determined how to continue with fixing. If it's something that can be deleted, we suggest deleting based on DEX_ROW_ID.
Example:

    ```sql
    DELETE IV30300 WHERE DEX_ROW_ID = XXX
    ```

As you review your data in the select statement above, typically you will have 2 lines vs 1 line.  You will want to remove the corrupt record missing the transaction source.

Cause 2

Specific document types with invalid values of 0 in the DECPLCUR and DECPLQTY fields.

> [!NOTE]
> The DECPLCUR field refers to the captured currency decimal place and the DECPLQTY field refers to the captured quantity decimal place for the item. On all valid transactions this should be populated with a value.

Run the following statement against the company database in SQL Server Management Studio to identify transactions with this condition:

```sql
Select * from IV30300 where (DECPLQTY = 0 or DECPLCUR = 0) and doctype in (1, 2, 3, 4, 5, 6, 7) 
```

If you find documents with 0 decimal places, they need to be investigated. Correct the corrupted transaction by using SQL Query Analyzer by updating the fields to the appropriate value.

Decimal place values in the IV30300 are as follows:

|Value in table|Value shows in GP (Actual value)|
|---|---|
|1|0|
|2|1|
|3|2|
|4|3|
|5|4|
|6|5|
  
Example update statement below:

```sql
UPDATE IV30300 set DECPLQTY = 3 WHERE DEX_ROW_ID = XXX
```

If the results are all old transactions and you prefer to Remove history for the corrupted transactions, you can remove history by pointing to **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Inventory**, and then select **Remove Transaction History** and removing the appropriate document number(s).

## More information

If neither script from Cause 1 or 2 return any results, focus on identifying the problem item by printing the Historical Stock Status Report by item number. Narrow in on the item numbers using a range. Start with a smaller range and work your way through the alphabet to identify the problem item. For example, enter a range of items starting with the letter A through D. Print that range and see if you receive the error. If you don't continue down the alphabet until you've identified the item with the issue. Once you identified the item, get the results of the IV30300 for that item and start investigating.

If you still are unable to find the issue item/document, run a SQL Profile Trace and trap the error. Make sure to leave the error on the screen (don't select past it) and then stop the trace. Typically, at the end of the trace you should see the document number that's causing the error and can investigate from there. If you clean up the one item and still receive the error, create a new trace and see if it's finding another culprit transaction.

Possible Workaround:

Another option is to try printing with or without the Use GL Posting date on the Report Option to see if one option works versus the other. It might give you an option to print the report while you investigate the issue and identified the problem.
