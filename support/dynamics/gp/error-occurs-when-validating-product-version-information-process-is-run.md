---
title: Error when Validating Product Version Information is run
description: Describes a problem that occurs if the collations and the sort orders of the DYNAMICS database and of the company database do not match the collations and the sort orders of the SQL Server system databases. A resolution is provided.
ms.reviewer: kyouells
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# You receive an error message when the Validating Product Version Information process is run in Microsoft Dynamics GP Utilities

This article provides a resolution for the issue that an error message occurs when you try to run the Validating Product Version Information process in Microsoft Dynamics GP Utilities.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943966

## Symptoms

When the Validating Product Version Information process is run in Microsoft Dynamics GP Utilities, you receive the following error message:

> The stored procedure verifyVersionInformation() of form duSQLInstall Pass Through SQL returned the following results: DBMS: 468, Microsoft Dynamics GP: 0.

## Cause

This problem occurs if the collations and the sort orders of the DYNAMICS database and of the company database do not match the collations and the sort orders of the Microsoft SQL Server system databases.

To compare the collations and the sort orders of the databases, see the More Information section.

## Resolution

To resolve this problem, correct the collations and the sort orders so that they are the same for the DYNAMICS database, for the company database, and for the SQL Server system databases. To do this, use one of the following methods.

### Method 1

Contact your partner of record or Microsoft Advisory Services for information about a billable service to correct the collations and the sort orders. To do this, use one of the following options, depending on whether you are a partner or a customer.

Customers:

For more information about services to correct the collations and the sort orders, contact your partner of record. If you do not have a partner of record, visit the following web site to identify a partner: [Microsoft Pinpoint](https://pinpoint.microsoft.com/home).

Partners:

For more information about services to correct the collations and the sort orders, contact Microsoft Advisory Services at 800-MPN-SOLVE or via email at [askpts@microsoft.com](mailto:askpts@microsoft.com).

### Method 2

Change the collations and the sort orders of the DYNAMICS database and of the company database by using the Bulk Copy Process (BCP) feature of SQL Server.

For more information about scripts when you use the BCP process to change the SQL Server sort order, see [How to use the Bulk Copy Process (BCP) to export Microsoft Dynamics GP data from one database and import data into a new database](https://support.microsoft.com/topic/how-to-use-the-bulk-copy-process-bcp-to-export-microsoft-dynamics-gp-data-from-one-database-and-import-data-into-a-new-database-134e6435-c90d-20bc-3102-59d427fe51d3).

> [!NOTE]
> For more information about consulting services to change the SQL Server sort order, contact your partner of record or Microsoft Advisory Services, depending on whether you are a customer or a partner.

Customers:

For more information about consulting services, contact your partner of record. If you do not have a partner of record, visit the following web site to identify a partner: [Microsoft Pinpoint](https://pinpoint.microsoft.com/home).

Partners:

For more information about consulting services, contact Microsoft Advisory Services at 800-MPN-SOLVE or via email at [askpts@microsoft.com](mailto:askpts@microsoft.com).

### Method 3

If this issue occurs after moving Microsoft Dynamics GP to a new server, uninstall SQL Server and reinstall SQL Server choosing the same sort order as your previous server was using. To determine the correct sort order, see the More Information section.

## More information

The SQL Server system databases can be the following databases:

- master
- model
- msdb
- tempdb

To compare the collations and the sort orders of the databases, follow these steps:

1. Run the `sp_helpdb` command in a query tool. To do this, use one of the following methods.

   Method 1: If you use SQL Server Management Studio

   1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005** or to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
   2. In the Connect to Server window, follow these steps:

      1. In the **Server name** box, type the name of the server that is running SQL Server.
      2. In the **Authentication** box, select **SQL Authentication**.
      3. In the **Login** box, type *sa*.
      4. In the **Password** box, type the password for the sa user, and then select **Connect**.
   3. Select **File**, point to **New**, and then select **Query with Current Connection**.
   4. In the blank query window, type the following script.

        ```console
        sp_helpdb
        ```

   5. On the **Query** menu, select **Execute**.

   Method 2: If you use SQL Query Analyzer

   1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   2. In the Connect to SQL Server window, follow these steps:

      1. In the **SQL Server** box, type the name of the old server that is running SQL Server.
      2. In the **Connect using** area, select **SQL Server Authentication**.
      3. In the **Login name** box, type *sa*.
      4. In the **Password** box, type the password for the sa user, and then select **OK**.
   3. In the blank query window, type the following script

        ```console
        sp_helpdb
        ```

   4. On the **Query** menu, select **Execute**.

   Method 3: If you use Support Administrator Console

   1. Select **Start**, point to **All Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**.
   2. In the "Connect to Server" window, follow these steps:

      1. In the **SQL Server** box, type the name of the new server that is running SQL Server.
      2. In the **Login Name** box, type *sa*.
      3. In the **Password** box, type the password for the sa user, and then select **OK**.
   3. In the blank query window, type the following script.

        ```console
        sp_helpdb
        ```

   4. On the **File** menu, select **Execute**.

2. To view the data, expand the **Status** column in the results.
3. Compare the values after the following statements:

    Collation=  
    SQLSortOrder=For example, you may see a statement that resembles the following statement.

    ```console
    Collation=SQL_Latin1_General_CP1_CI_AS, SQLSortOrder=52
    ```

    > [!NOTE]
    > The following SQL Server sort orders are supported by Microsoft Dynamics GP:
    >
    > - Binary Sort Order: 0 and 50
    > - Dictionary Order Case-Insensitive (DOCI) Sort Order: 52
