---
title: Return code 17 when you run the Depreciation process in Fixed Asset Management in Microsoft Dynamics GP
description: Describes a problem that occurs when you run the Depreciation process in Fixed Asset Management in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Fixed Assets
---
# "Return code 17" error messages when you run the Depreciation process in Fixed Asset Management in Microsoft Dynamics GP

This article helps resolve the "return code 17" error messages.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 897747

## Symptoms

When you run the Depreciation process in Fixed Asset Management in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, you receive some return code 17 error messages. These return code 17 error messages appear in the Error Log Inquiry window.

> [!NOTE]
> To open the Error Log Inquiry window, click **Inquiry** > **Fixed Assets** > **Error Log**.

The return code 17 error messages are as follows:

> - Return code 17 (Duplicate record) on file FA_Financial_DTL_MSTR while attempting a save operation

> - Return code 17 (Duplicate record) on script FA_Write_Financial_Detail

> - Return code 17 (Duplicate record) on script FA_Write_Depreciation_Expense_To_Financial_Detail

> - Return code 17 (Duplicate record) on script FA_Write_and_Update_FA_Financial_Detail

> - FA_Write_Financial_Detail Return code 17 (Duplicate record) on file FA_Financial_DTL_MSTR while attempting a save operation. Financial Index: 1

> - FA_Write_Depreciation_Expense_To_Financial_Detail Return code 17 (Duplicate record) on script FA_Write_Financial_Detail

> - FA_Write_and_Update_FA_Financial_Detail Return code 17 (Duplicate record) on script FA_Write_Depreciation_Expense_To_Financial_Detail. Source Doc: FADEP

> - FA_Depreciator Return code 17 (Duplicate record) on script FA_Write_and_Update_FA_Financial_Detail. Depr This Cycle: 9477.11670

> - FA_Locate_Books_Not_Fully_Depreciated Return code 17 (Duplicate record) on script FA_Depreciator. Asset Index: 1 Book Index: 1

> - FA_Depreciate_All_Assets Return code 17 (Duplicate record) on script FA_Locate_Books_Not_Fully_Depreciated

> - FA_Write_Financial_Detail Return code 17 (Duplicate record) on file FA_Financial_DTL_MSTR while attempting a save operation. Financial Index: 2

## Cause

This problem occurs when the DEX_ROW_ID column isn't marked as an identity column and when the FINANCIALINDX field isn't marked as the primary key in the `FA00902` table.

## Resolution

To resolve this problem, follow these steps:

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.
>
> You may want to use a test company database that has a copy of live company data. When you do this, users will not have to log off from Microsoft Dynamics GP or from Microsoft Great Plains 8.0 while you test the steps to resolve these issues. After you have tested the steps, you can process these steps against the live company data after all the users have logged off at the end of the workday.
For more information, click the following article number to view the article in the Microsoft Knowledge Base:
>
> [871973](https://support.microsoft.com/help/871973) How to set up a test company that has a copy of live company data by using SQL Server 7.0, SQL Server 2000, or SQL Server 2005  

### Step 1: Back up the company database

#### Perform a backup of the company database in Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010

1. Have all users exist Microsoft Dynamics GP.
2. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Backup**.
3. Select the company that you want to back up.
4. Click **OK** to create the backup.

The Back Up Company window will close, and a message will appear when the backup is complete.

#### Perform a backup of the company database in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

Make a backup of the live company database. To do it, use one of the following methods, as appropriate for your situation.

Method 1: Using SQL Server Enterprise Manager

If you're using SQL Server Enterprise Manager, follow these steps:

1. Click **Start** > **All Programs**.
2. Point to **Microsoft SQL Server**, and then click **Enterprise Manager**.
3. Expand **Microsoft SQL Servers**, expand **SQL Server Group**, and then expand the instance of SQL Server.
4. Expand **Databases**, right-click the live company database, click **All Tasks** > **Backup Database**.
5. In the SQL Server Backup window, click **Add** in the **Destination** section.
6. In the Select Backup Destination window, click the ellipsis button next to the **File name** field.
7. In the Backup Device Location window, expand the folders, and then select the location for the backup file.
8. Type a name for the backup file. For example, type *Live.bak*.
9. Click **OK** repeatedly until you return to the SQL Server Backup window.
10. Click **OK** to start the backup.
11. When the backup has completed successfully, click **OK**.

Method 2: Using SQL Server Management Studio

If you're using SQL Server Management Studio, follow these steps:

1. Click **Start** > **Programs**.
2. Point to **Microsoft SQL Server 2005** or **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**. The Connect to Server window opens.
3. In the **Server name** box, type the name of the instance of SQL Server.
4. In the **Authentication** list, click **SQL Authentication**.
5. In the **User name** box, type *sa*.
6. In the **Password** box, type the password for the sa user, and then click **Connect**.
7. In the **Object Explorer** section, expand **Databases**.
8. Right-click the live company database, point to **Tasks**, and then click **Backup**.
9. In the **Destination** area, click **Remove**, and then click **Add**.
10. In the **Destination on disk** area, click the ellipsis button.
11. Find the location where you want to create the backup file, type a name for the backup file, such as *LIVE.bak*, and then click **OK**.
12. Click **OK** repeatedly until you return to the Backup Database window.
13. Click **OK** to start the backup.

### Step 2: Delete the contents of the FAINDEX table

To delete the contents of the `FAINDEX` table, run scripts yourself. To do it, follow these steps:

1. Have all users exit Microsoft Dynamics GP or Microsoft Great Plains 8.0.
2. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    **Method 1: For SQL Server Desktop Engine**

    If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, click **Start**, point to **All Programs** > **Microsoft Administrator Console**, and then click **Support Administrator Console**.

    **Method 2: For SQL Server 2000**

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server**, and then click **Query Analyzer**.

    **Method 3: For SQL Server 2005**

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.

    **Method 4: For SQL Server 2008**

    If you're using SQL Server 2008, start SQL Management Studio. to do it, click **Start**, point to **All Programs** > **Microsoft SQL Server 2008**, and then click **SQL Server Management Studio**.  

3. Run the following scripts.

    ```console
    DELETE DYNAMICS..ACTIVITY
    DELETE DYNAMICS..SY00800
    DELETE DYNAMICS..SY00801
    DELETE TEMPDB..DEX_LOCK
    DELETE TEMPDB..DEX_SESSION
    DELETE <XXXXX>..FAINDEX
    ```

    > [!NOTE]
    > The *\<XXXXX>* placeholder represents the actual company database.

4. Sign in Microsoft Dynamics GP or Microsoft Great Plains 8.0, and then try to depreciate your assets. If the error persists, proceed to "Step 3."

### Step 3: Mark the DEX_ROW_ID column as an identity column, and mark the FINANCIALINDX field as the primary key

To do it, follow these steps:

1. Mark the DEX_ROW_ID column as an identity column. If you're using SQL Server Enterprise Manager, follow these steps:
      1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Enterprise Manager**.
      2. Expand the Microsoft SQL Server group in which the server is located.
      3. Expand the server, and then click **Databases**.
      4. Expand the company database that is experiencing the problem.
      5. Click **Tables**.
      6. Right-click the `FA00902` table.
      7. Click **Design Table**.
      8. Under **Column Name**, click **DEX_ROW_ID**.
      9. Under **Columns**, change the identity to **Yes**.

    If you're using SQL Server Management Studio, follow these steps:

    1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005** or **Microsoft SQL Server 2008**, and then click **Microsoft SQL Server Management Studio**.
    2. Expand the Microsoft SQL Server group in which the server is located.
    3. Expand the server, and then click **Databases**.
    4. Expand the company database that is experiencing the problem.
    5. Click **Tables**.
    6. Right-click the `FA00902` table, and then click **Modify**.
    7. Click the DEX_ROW_ID column.
    8. Under **Column Properties**, expand **Identity Specification**.
    9. Change the identity to **Yes**.
    10. Set the **Identity Seed** value and the **Identity Increment** value to **1**.
1. Mark the FINANCIALINDX field as the primary key. If you're using SQL Server Enterprise Manager, follow these steps:
      1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Enterprise Manager**.
      2. Expand the SQL Server group in which the server is located.
      3. Expand the server, and then click **Databases**.
      4. Expand the company database that is experiencing the problem.
      5. Click **Tables**.
      6. Right-click the `FA00902` table.
      7. Click **Design Table**.
      8. Under **Column Name**, click **FINANCIALINDX**.
      9. Examine the **FINANCIALINDX** field. If the **FINANCIALINDX** field has a picture of a key next to it, this field is already set as the primary key. If the key doesn't appear next to the **FINANCIALINDX** field, click **Set Primary Key** on the menu bar.

    > [!NOTE]
    > This button has a picture of a key on it.

    When you click **Set Primary Key**, a picture of a key appears next to the **FINANCIALINDX** field, and the **FINANCIALINDX** field becomes the primary key.

    If you're using SQL Server Management Studio, follow these steps:
  
      1. Click **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005** or **Microsoft SQL Server 2008**, and then click **Microsoft SQL Server Management Studio**.
      2. Expand the SQL Server group in which the server is located.
      3. Expand the server, and then click **Databases**.
      4. Expand the company database that is experiencing the problem.
      5. Click **Tables**.
      6. Right-click the `FA00902` table, and then click **Modify**.
      7. Click the **FINANCIALINDX** column.
      8. Under **Column Name**, click **FINANCIALINDX**.
      9. Examine the **FINANCIALINDX** field. If the **FINANCIALINDX** field has a picture of a key next to it, this field is already set as the primary key. If the key doesn't appear next to the **FINANCIALINDX** field, right-click the **FINANCIALINDX** field, and then click **Set Primary Key**.

    > [!NOTE]
    > This button has a picture of a key on it.

    When you click **Set Primary Key**, a picture of a key appears next to the **FINANCIALINDX** field, and the **FINANCIALINDX** field becomes the primary key.
