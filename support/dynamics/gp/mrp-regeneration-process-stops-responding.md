---
title: MRP Regeneration process stops responding
description: Describes that how to resolve the problems when you run the Material Requirements Planning (MRP) Regeneration process in Manufacturing.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Manufacturing Series
---
# The MRP Regeneration process in Manufacturing stops responding, locks up, or isn't processed completely in Microsoft Dynamics GP

This article describes that how to resolve the problems when you run the Material Requirements Planning (MRP) Regeneration process in Manufacturing.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 942508

## Symptoms

When you use the Material Requirements Planning (MRP) Regeneration process in Manufacturing in Microsoft Dynamics GP 9.0, one of the following symptoms may occur:

- The MRP Regeneration process stops responding.
- The MRP Regeneration process locks up.
- The MRP Regeneration process isn't completed.

## Cause

This problem may occur for one or more of the following reasons:

- The down day constraints in MRP are set incorrectly.

- The low-level codes are set incorrectly.
- There's a recursive Bill of Materials (BOM).
- There are multiple records in table MSSP0230.
- There's an incorrect company ID in table MSSP0230.
- There's a locked record in MRP security.
- There are sales orders, purchase orders, or manufacturing orders that have required dates that fall outside the acceptable MRP date ranges.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

### Resolution 1: The down day constraints in MRP are set incorrectly

The **Down Day Constraint** field in the MRP Preference Defaults window uses down days from the shop calendar to determine the lead time for the components. The MRP Regeneration process locks up if the following conditions are true:

- The **None** option is selected under **Company-wide Down Days settings** in the Shop Calendar window.
- The value in the **Down Day Constraint** field in the MRP Preference Defaults window is set to something other than None.

To resolve this problem, follow these steps depending on the version of Microsoft Dynamics GP that you're using.

#### Microsoft Dynamics GP 10.0

1. In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Manufacturing**, point to **System Defaults**, and then select **Calendar**.

2. Verify which one of the following options is selected under
**Company-wide Down Day settings**. The following options are under **Company-wide Down Day settings**:

   - **None**  
   - **Sundays Only**  
   - **Saturdays and Sundays**

3. On the **Tools** menu, point to **Setup**, point to **Manufacturing**, point to **System Defaults**, and then select **MRP**.
4. Determine whether the option in the **Down Day Constraints** drop-down list matches the **Shop Calendar Down Days** option. The following list displays the **Shop Calendar Down Days** options that match the **Down Day Constraints** options:
   - The **None** option - This option can contain the **None**, the **Saturdays and Sunday**, or the **Sundays Only** settings.
   - The **Made** option - This option can contain the
 **Saturdays and Sunday** or the **Sundays Only** settings.
   - The **Bought** option - This option can contain the
 **Saturdays and Sunday** or the **Sundays Only** settings.
   - The **Both** option - This option can contain the
 **Saturdays and Sunday** or the **Sundays Only** settings.

#### Microsoft Dynamics GP 9.0

1. In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **Manufacturing**, point to **System Defaults**, and then select **Calendar**.
2. Verify which one of the following options is selected under **Company-wide Down Day settings**. The following are the options under **Company-wide Down Day settings**:

    - **None**  
    - **Sundays Only**  
    - **Saturdays and Sundays**
3. On the **Tools** menu, point to **Setup**, point to **Manufacturing**, point to **System Defaults**, and then select **MRP**.
4. Determine whether the option in the **Down Day Constraints** drop-down list matches the **Shop Calendar Down Days** option. The following list displays the **Shop Calendar Down Days** options that match the **Down Day Constraints** options:
   - The **None** option - This option can contain the **None**, the **Saturdays and Sunday**, or the **Sundays Only** settings.
   - The **Made** option - This option can contain the
 **Saturdays and Sunday** or the **Sundays Only** settings.
   - The **Bought** option - This option can contain the
 **Saturdays and Sunday** or the **Sundays Only** settings.
   - The **Both** option - This option can contain the
 **Saturdays and Sunday** or the **Sundays Only** settings.

### Resolution 2: The low-level codes are set incorrectly

The Item Engineering Data window holds a low-level code for each component. The low-level code is the deepest level of the item in any BOM. You must run the MRP Low-Level Codes utility to determine whether the low-level codes are correct. You can run the MRP Low-Level Codes utility one of the following ways:

- In Microsoft Dynamics GP
- Manually by using SQL Query Analyzer or by using SQL Server Management Studio

#### How to run the Low-Level Codes utility in Microsoft GP

1. Follow one of the steps depending on the version of Microsoft Dynamics GP that you're using:

    - In Microsoft Dynamics GP 10.0, point to
    **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Manufacturing**, and then select **MRP Low-Level Codes**.
      - In Microsoft Dynamics GP 9.0, point to
    **Utilities** on the **Tools** menu, point to
    **Manufacturing**, and then select **MRP Low-Level Codes**.
2. In the **Maximum Number of Levels for any BOM** field, enter **110**.
3. Select **Generate**.

#### How to run the Low-Level Code utility in SQL Query Analyzer or in SQL Server Management Studio

Run the following script against the company database in SQL Query Analyzer or in SQL Server Management Studio.

```sql
execute mbomLLCUtility 110
```

### Resolution 3: Recursive BOM

A recursive BOM is a component of itself. It can be assigned directly as a component, or it can be assigned to a subassembly that is assigned to the BOM.

#### How to determine whether there's a recursive BOM

1. Run the following statement against the company database in SQL Query Analyzer or in SQL Server Management Studio.

    ```sql
    Select * from BM010115 where CPN_I=PPN_I
    ```

2. If results are returned, you have to remove the component from the BOM.

    To remove the recursive BOM, run the following statement against the company database in SQL Query Analyzer or in SQL Server Management Studio.

    > [!NOTE]
    > Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

    ```sql
    Delete BM010115 where PPN_I = CPN_I
    ```

#### How to determine whether the BOM is assigned to a subassembly that is assigned to the BOM

1. Verify that the Low-Level Code utility was run.
2. Run the following statement against the company database in SQL Query Analyzer or in SQL Server Management Studio.

    ```sql
    Select * from IVR10015 where LLC=110
    ```

    If records are returned, the item listed is a parent. However, somewhere in its BOM structure, the same part number exists as a component.
3. Remove the subassembly that contains the item that is in question.

    1. On the **Cards** menu, point to
    **Manufacturing**, and then select **Bill of Materials**.
    2. Enter the BOM number that is returned from the script in the **Item Number** field.
    3. In the Tree View, expand each subassembly, and then determine what components are underneath each subassembly.
    4. Remove the subassembly that contains the item that is in question.

### Resolution 4: Multiple records exist in table MPPS0230

Table MPPS0230 is the MRP Preferences Default table. Table MPPS0230 should contain only one line.

1. Run the following statement against the company database in SQL Query Analyzer or in SQL Server Management Studio.

    ```sql
    Select * from MPPS0230
    ```

2. If this statement returns more than one row, you have to determine which line is the incorrect line. Then, you must delete this line from the table.
3. Make sure that the remaining line has the correct company ID. To do it, follow the steps in the [Resolution 5](#resolution-5-table-mpps0230-has-an-incorrect-company-id) section.

### Resolution 5: Table MPPS0230 has an incorrect company ID

1. Run the following script against the DYNAMICS database in SQL Query Analyzer or in SQL Server Management Studio to determine the correct Company ID for the database.

    ```sql
    Select * from SY01500
    ```

2. Locate the **CMPANYID** field that corresponds with the **CMPNYNAM** field f with which you have issues in MRP.
3. Run the following statement against the company database in SQL Query Analyzer or in SQL Server Management Studio.

    ```sql
    Select * from MPPS0230
    ```

4. Verify that the **CMPANYID** field is correct based on the result that was returned from table SY01500 in step 1.
5. If the company ID is incorrect in table MPPS0230, run the following script against the company database in Query Analyzer or in SQL Server Management Studio.

    ```sql
    /******************************************************************************/ 
    /* Description: */ 
    /* Updates any table that contains a company ID or database name value */ 
    /* with the appropriate values as they are stored in the DYNAMICS.dbo.SY01500 table */ 
    /* */ 
    /******************************************************************************/ 
    if not exists(select 1 from tempdb.dbo.sysobjects where name = '##updatedTables') 
    create table [##updatedTables] ([tableName] char(100)) 
    truncate table ##updatedTables 
    
    declare @cStatement varchar(255) 
    
    declare G_cursor CURSOR for 
    select 
    case 
    when UPPER(a.COLUMN_NAME) in ('COMPANYID','CMPANYID') 
    then 'update '+a.TABLE_NAME+' set '+a.COLUMN_NAME+' = '+ cast(b.CMPANYID as char(3)) 
    else 
    'update '+a.TABLE_NAME+' set '+a.COLUMN_NAME+' = '''+ db_name()+'''' 
    end 
    from INFORMATION_SCHEMA.COLUMNS a, DYNAMICS.dbo.SY01500 b, INFORMATION_SCHEMA.TABLES c 
    where UPPER(a.COLUMN_NAME) in ('COMPANYID','CMPANYID','INTERID','DB_NAME','DBNAME', 'COMPANYCODE_I') 
    and b.INTERID = db_name() and a.TABLE_NAME = c.TABLE_NAME and c.TABLE_CATALOG = db_name() and c.TABLE_TYPE = 'BASE TABLE' 
    
    set nocount on 
    OPEN G_cursor 
    FETCH NEXT FROM G_cursor INTO @cStatement 
    WHILE (@@FETCH_STATUS <> -1) 
    begin 
    insert ##updatedTables select 
    substring(@cStatement,8,patindex('%set%',@cStatement)-9) 
    Exec (@cStatement) 
    FETCH NEXT FROM G_cursor INTO @cStatement 
    end 
    DEALLOCATE G_cursor 
    
    select [tableName] as 'Tables that were Updated' from ##updatedTables 
    ```

### Resolution 6: A record is locked in MRP security

Locked records can cause MRP to freeze when you run the MRP Regeneration process.

1. On the **Transactions** menu, point to **Manufacturing**, point to **MRP**, and then select **Security**.

    All the active sessions that are running MRP are displayed. If you're currently not running the MRP Regeneration process, there shouldn't be a record in this table.
2. If you aren't running the MRP Regeneration process and you have a record (or records) here, delete this line.
3. Verify the MRP Planned Order security. To do it, point to **Manufacturing** on the **Transactions** menu, point to **MRP**, and then select **Planned Order Security**. MRP Planned Order Security will display planned orders that are locked by other processes.
4. If you aren't running the MRP Regeneration process and have a record (or records) here, delete this line.
5. Verify other Manufacturing security windows to determine whether records that are necessary for MRP to regenerate aren't locked. The following list is the different Manufacturing security windows in which you can find locked records:

    - On the **Transactions** menu, select
    **Manufacturing**, select **Manufacturing Order**, and then select **Security**. Only manufacturing orders that are currently active can appear in the window. An active manufacturing order is a manufacturing order that a user is currently working on and that is opened in a Manufacturing window. If there are manufacturing orders that are currently not active, delete them.
      - On the **Transactions** menu, point to
    **Manufacturing**, point to **Bill of Materials**, and then select **Security**. BOMs are locked when users are working with them. Additionally, BOMs are locked when they're opened in a Manufacturing window. If there are BOMs that are currently not active, delete them.
      - On the **Transactions** menu, point to
    **Manufacturing**, point to **Routings**, and then select **Security**. Routings are locked when users are working with them. Additionally, routings are locked when they're opened in a Manufacturing window. If there are routings that are currently not active, delete them.
      - On the **Transactions** menu, point to
    **Manufacturing**, point to **WIP**, and then select
    **TRX Security**. Work in progress (WIP) transactions are locked when users are working with them. Additionally, WIP transactions are locked when they're opened in a Manufacturing window. If there are WIP transactions that are currently not active, delete them.

### Resolution 7: There are outdated records

Table DD040000 is the Up_Days_Work table. This table is repopulated every time that the MRP Regeneration process is completed. MRP determines what dates are valid up days, and then stores these dates in this table. It's the date range within which the MRP demand must fall.

The number of days that appear in this table and the first date entered in this table will vary depending on the run time of the MRP Regeneration process. If the regeneration is completed for under 300 days, this table will be populated approximately 600 days before the start date of MRP Regeneration process and 600 days past the MRP Regeneration process start date. If the MRP Regeneration process run time is extended past 300 days, the number of "up days" that are contained in the table will increase.

When the MRP Regeneration process is determining planning orders, the dates of these orders must fall within the dates that are specified in table DD040000. If the MRP Regeneration process can't find the date in this table, it can't process the planned order. This behavior causes looping. Generally, there's an up day requirement that is earlier than the earliest up day that is written to table DD040000.

1. If you increase the number of days in the MRP Regeneration process, the number of days that are included in table DD040000 is also increased. To increase the number of days in the MRP Regeneration process, follow these steps:
    1. On the **Transactions** menu, point to
    **Manufacturing**, point to **MRP**, and then select
    **Regeneration**.
    2. In the **Run for** field, double the numbers of days, the numbers of weeks, or the numbers of months for which the MRP Regeneration process is being generated, and then select **Process**.
2. Decrease the number of past due orders that the MRP Regeneration process is including. When you reduce the number of days in the past, you eliminate some other transactions from the MRP Regeneration process. To do it, follow one of the steps depending on the version of Microsoft Dynamics GP that you're using:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the
    **Microsoft Dynamics GP** menu, point to **Setup**, point to **Manufacturing**, point to **System Defaults**, and then select **MRP**.
      - In Microsoft Dynamics GP 9.0, point to
    **Setup** on the **Tools** menu, point to
    **Manufacturing**, point to **System Defaults**, and then select **MRP**.
3. In the **Include Past Due for prior Days** field, reduce the number of days in the past that the MRP Regeneration process is looking.
4. Run the MRP Regeneration process again.

If this problem still exists after you increase the number of days, follow these steps:

1. Create a Dexsql.log file while you run the MPR Regeneration process to determine the date on which MRP is failing.

2. Locate the GP folder or the GP Data folder, and then open the Dexsql.log file.
3. Locate the bottom of the opened Dexsql.log file. If invalid demand dates are your issue, you'll see the following line repeated together with an UPDAYS_I date in the past. This date must be at least a year in the past to create an issue. In the following script, "2005.02.11" is the date that causes the issue:

    ```sql
    SELECT TOP 25 UPDAYS_I,SEQ_I,DEX_ROW_ID FROM WAVE.dbo.DD040000 WHERE (UPDAYS_I < '2005.02.11') ORDER BY UPDAYS_I DESC
    ```

4. The following script will search for manufacturing orders that have a start date earlier than a specific date:

    ```sql
    Select * from WO010032 where MANUFACTUREORDERST_I<>8 and STRTDATE<'yyyy-mm-dd' and STRTDATE<>'1900-01-01'
    ```

    > [!NOTE]
    > *yyyy-mm-dd* is a placeholder for the incorrect date from the Dexsql.log file.
5. If results are returned, change the **Start Date** field to a more current date in the Manufacturing Order Entry window for the line item in question. To open the Manufacturing Order Entry window, point to **Manufacturing** on the **Transactions** menu, point to **Manufacturing Orders**, and then select **Entry**.
6. The following script will search for manufacturing orders components that have a required date that is earlier than a specific date.

    ```sql
    Select * from PK010033 where REQDATE<'yyyy-mm-dd' and REQDATE<>'1900-01-01' and MANUFACTUREORDER_I IN (select MANUFACTUREORDER_I from WO010032 where MANUFACTUREORDERST_I<>8)
    ```

    > [!NOTE]
    > *yyyy-mm-dd* is a placeholder for the incorrect date from the Dexsql.log file.
7. If results are returned, change the **Required Date** field to a more current date in the Picklist window for the line item in question. To open the Picklist window, point to **Manufacturing** on the **Transactions** menu, point to **Manufacturing Orders**, and then select **Picklist**.
8. In the Dex.ini file, set the following statements back to FALSE:

    - SQLLogSQLStmt=FALSE
    - SQLLogODBCMessages=FALSE
