---
title: Error when you save Vendor Maintenance information in Payables Management
description: Provides a solution to an error message that occurs when saving Vendor Maintenance information in Payables Management using Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: cwaswick
ms.date: 03/13/2024
---
# Error message when you save Vendor Maintenance information in Payables Management using Microsoft Dynamics GP: "A save operation on table 'PM_Vendor_MSTR' (45)."

This article provides a solution to an error that occurs when you save Vendor Maintenance information in Payables Management using Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2564866

## Symptoms

When you save new information or changes to the Vendor Maintenance card in Payables Management using Microsoft Dynamics GP, you receive the following error message that prevents changes from being saved:

> A save operation on table 'PM_Vendor_MSTR' (45).
>
> Error converting datatype char to numeric.

## Cause

The message is caused by a trigger on the PM00200 table that is damaged or outdated.

Use these steps to determine which trigger is causing the issue:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following Methods depending on the program that you are using.

    - Method 1: For SQL Server Desktop Engine

        If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, click **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then click **Support Administrator Console**.

    - Method 2: For SQL Server 2000

        If you are using SQL Server 2000, start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

    - Method 3: For SQL Server 2005

        If you are using SQL Server 2005, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

    - Method 4: For SQL Server 2008

        If you are using SQL Server 2008, start SQL Server Management Studio. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.

2. Execute the following script against the company database to view triggers on the PM00200 PM Vendor Master File table:

    ```sql
    SP_Helptrigger PM00200
    ```

3. Review all the triggers returned by the script above. Here is some information on some of the triggers you may see:

    - zDT_PM00200U - This is a default trigger on the table and is normal to have.
    - taVendorInsert - This trigger is created from having Professional Tools Services Library installed. (See Resolution for Method 1.)
    - aagTR_PM00200Del, aagTR_PM00200Ins - These delete/insert triggers are from Analytical Accounting.
    - ep_Audit_I_PM00200, ep_Audit_U_PM00200, ep_Audit_D_PM00200 - These insert/update/delete triggers are from Audit Trails. (See Resolution for Method 2.)
    - If you have any other triggers, determine where they came from. (See Resolution for Method 3.)

4. Review the error message in detail to see if it references which trigger is causing the issue. If not, you can use the scripts below to disable all the triggers and then enable them back one at a time and test in between to determine which one is causing the issue:

To disable each trigger, use the following script:

```sql
Alter table PM00200 disable trigger XXXX
```

> [!NOTE]
> *XXXX* is a placeholder for the trigger name.

To enable each trigger, use the following script:

```sql
Alter table PM00200 enable trigger XXXX
```

> [!NOTE]
> *XXXX* is a placeholder for the trigger name.

## Resolution

Use the appropriate Method below, depending on which trigger is causing the issue:

- Method 1: If the taVendorInsert trigger is causing the issue, follow these steps to refresh this trigger:

    1. In Microsoft Dynamics GP, click the shortcut to open Professional Services Tools Library (PSTL).

    2. Click the **Register** button in the lower left corner of the window.

    3. A window will pop up prompting you to enter the registration code. Just click **OK, as you do not need to change the keys.

    4. This will trigger PSTL to recreate its procedures.

    5. When completed, test the issue again to see if the error message still happens.

        > [!NOTE]
        > If the issue persists, repeat the steps above to refresh PSTL a second time. Sometimes it works the second time. If the issue still persists, then you may want to look at reinstalling a newer version of PSTL.

- Method 2: If any of the ep_Audit triggers are causing the issue, follow these steps to recreate these triggers:

    1. Make a current backup of the Dynamics database, company database and also the Audit database before following these steps.

    2. In Microsoft Dynamics GP, click **Microsoft Dynamics GP**, point to **Tools**, point to **Setup**, point to **Company**, point to **Audit Trails** and click on **Audit Trail Maintenance**.

    3. In the **Audit Trail Maintenance** window, in the **Audited Tables** section in the lower right corner, review to see any audits for the PM00200 table and click to select it.

    4. Click **Stop Auditing**.

    5. If this is the only company database that writes to the **Audit Trail** database for this PM00200 table, then click the **Remove** button to remove the audit and the trigger will be removed from the table.

        > [!NOTE]
        > Clicking **Remove** will also completely remove the PM00200_Audit 'table' in the Audit database, *so all the history that has been tracked to date will also be removed*. Therefore, make sure to have a current backup of the Audit database before doing this step.

    6. Test to make sure the error message no longer occurs.

    7. Now go back into the Audit Trail Maintenance window and re-setup the audit on the PM00200 table if needed.

- Method 3: If you have a custom trigger, you can use these steps to script out the trigger details so you can review:

    1. Open SQL Server Management Studio.

    2. In the **Object Explorer** section in the left-hand margin, click to expand the SQL instance.

    3. Click to expand **Databases**.

    4. Click to expand the appropriate company database.

    5. Click to expand **Tables**.

    6. Click to expand the dbo.PM00200 table.

    7. Click to expand **Triggers**.

    8. Right-click on the custom trigger and select Script Trigger As and Create To and New Query Editor Window (or File).

    9. Review the details of the trigger. You will need to consult whoever created the trigger to have them update it as needed. Microsoft Support is unable to support any custom triggers.
