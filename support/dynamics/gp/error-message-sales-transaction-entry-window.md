---
title: Error message in the Sales Transaction Entry window
description: This article provides a resolution for the problem that occurs when you try to access, to enter, to save, to print, or to post transactions in the Sales Transaction Entry window in Microsoft Dynamics GP.
ms.reviewer: aeckman
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# You receive an error message when you try to access, to enter, to save, to print, or to post transactions in the Sales Transaction Entry window in Microsoft Dynamics GP

This article helps you resolve the problem that occurs when you try to access, to enter, to save, to print, or to post transactions in the Sales Transaction Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 931648

## Symptoms

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

When you try to access, to enter, to save, to print, or to post transactions in the Sales Transaction Entry window in Microsoft Dynamics GP, you receive one of the following error messages:

> A get/change operation on table <table_name> failed accessing SQL data  
A get/change operation on table 'SOP_HDR_WORK' failed accessing SQL data  
A get/change operation on table 'SOP_LINE_WORK' failed accessing SQL data  
A save operation on <table_name> cannot find the table  
A remove operation on <table_name> failed accessing SQL data  
A get/change operation on table 'SOP_HDR_HIST' failed accessing SQL data

> [!NOTE]
> The **<table_name>** placeholder represents the actual table name.

## Cause

This problem occurs if a Sales Order Processing table contains damaged or duplicate records.

## Resolution

To resolve this problem, follow these steps.

### Run the Check Links procedure

1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
2. In the **Series** list, click **Sales**.
3. In the **Logical Tables** list, click the table that appears in the error message that you received.
4. Click **Insert**, and then click **OK**.
5. If you are prompted to print the Error log, select a destination, and then click **OK**.

    > [!NOTE]
    > For more information about table names, use the Resource Descriptions window. To open the Resource Descriptions window, point to **Resource Descriptions** on the **Tools** menu, and then click **Tables**.

6. Perform the action that caused the error message that you received.

If you still receive the error message, follow these steps.

### Re-create the auto procedure

1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **SQL**.
2. In the **Database** list, click the company database, and then click the auto procedure that you want to re-create.
3. Click to select the **Drop Auto Procedure** and **Create Auto Procedure** check boxes, and then click **Process**.
4. Perform the action that caused the error message that you received.

If you still receive the error message, follow these steps.

### Re-create the table

To re-create the table without deleting records that are in the table, use the Toolkit. The Toolkit is a tool in the Professional Services Tools Library.

For more information about the Professional Services Tools Library (PSTL), use one of the following options:

- Customers:

  For more information about PSTL, contact your partner of record. If you do not have a partner of record, see [Microsoft Pinpoint](https://pinpoint.microsoft.com/home).

- Partners:

  For more information about PSTL, see [Sell Dynamics on-premises](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem).

To re-create the table, follow these steps:

1. Exit Microsoft Dynamics GP.
2. Back up the Microsoft Dynamics GP code folder.

   > [!NOTE]
   > By default, the Microsoft Dynamics GP code folder is in the following location:C:\Program Files\Microsoft Dynamics\GP

3. Install the Professional Services Tools Library.
4. Start Microsoft Dynamics GP.
5. When you are prompted to include new code, click **Yes**.
6. Add the Professional Services Tools Library to the **Shortcuts** area. To do this, follow these steps:

   1. In the **Shortcuts** area, click **Add**, and then click **Other Window**.
   2. Expand **Technical Service Tools**, expand **Project**, and then click **Professional Services Tools Library**.
   3. Click **Add**, and then click **Done**.

7. In the **Shortcuts** area, click **Professional Services Tools Library**.
8. When you are prompted to enter registration keys, click **Cancel**.
9. Click **Toolkit**, and then click **Next**.
10. Click **Recreate SQL Objects**, and then click **Next**.
11. In the **Series** list, click **Sales**.
12. In the **Table** list, click the table that appears in the error message that you received.
13. Click **Recreate Selected Table**, click to select the **Recreate data for selected table(s)** check box, and then click **Perform Selected Maintenance**.

    > [!NOTE]
    > If the table has a custom trigger, you must manually re-create the trigger.

14. Perform the action that caused the error message that you received.

## More information

If you still receive one of the error messages that is described in the "Resolution" section, try these troubleshooting suggestions.

- Create a Dexsql.log file, and then locate the error message that you received in the Dexsql.log file. The data that comes before the error message may help you determine the cause of the error message.

  For more information about how to create a Dexsql.log file, see [KB 850996 - How to create a Dexsql.log file to troubleshoot error messages in Microsoft Dynamics GP](https://support.microsoft.com/help/850996).

- Determine whether the error message that you received is caused by a particular report. For example, if you receive the error message only when you print a particular order or invoice report, the problem may be caused by this report. In this situation, restore the Reports.dic file from a backup copy.

  > [!NOTE]
  > By default, the Microsoft Dynamics GP Reports.dic file is in the location:`C:\Program Files\Microsoft Dynamics\GP`.

- Determine whether the error message that you received is caused by a modified report. To do this, print the original report. If you do not receive the error message when you print the original report, re-create the Reports.dic file.

  For more information about how to re-create the Reports.dic file, see [How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/help/850465).

- Determine whether the error message that you received is caused by a particular user ID or workstation. To do this, start Microsoft Dynamics GP on a different workstation. Log on by using the user ID that was used when you received the error message. If you do not receive the error message, reinstall Microsoft Dynamics GP on the workstation on which you received the error message. If you do receive the error message on another workstation, the problem may be caused by the user ID. In this situation, create a new user ID.

- Determine whether the error message that you received is caused by a particular document number. If you receive the error message only when you use a particular document number, delete this document number. Then, reenter it.

- If you imported the data, manually enter a document in the Sales Transaction Entry window. If you do not receive the error message, the problem may be caused by the import process.

- Determine whether the error message that you received is caused by a customization or by a third-party product. To do this, disable the customization or the third-party products.

- Verify that the Open Database Connectivity (ODBC) data source on the workstation is set up correctly.

- Determine whether the table contains damaged information. To do this, run the following statement in SQL Query Analyzer. Then, verify the records that are returned.

    ```sql
    Select * from <table_name>
    ```

    > [!NOTE]
    > The **<table_name>** placeholder represents the actual table name.
