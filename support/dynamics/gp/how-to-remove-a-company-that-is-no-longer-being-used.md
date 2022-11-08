---
title: How to remove a company that is no longer being used
description: Describes how to remove a company that is no longer being used in Microsoft Dynamics GP.
ms.reviewer: kyouells
ms.topic: how-to
ms.date: 04/22/2021
---
# How to remove a company that is no longer being used in Microsoft Dynamics GP

This article explains how to remove a company that is no longer being used in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 849249

To remove a company that is no longer being used in Microsoft Dynamics GP, follow these steps:

1. Follow the appropriate step:
   - If you're using Microsoft Dynamics GP 10.0 or later, select **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **System**, and then select **Delete Company**.
   - If you're using Microsoft Dynamics GP 9.0, point to **Utilities** on the **Tools** menu, point to **System**, and then select **Delete Company**.
   - If you're using Microsoft Business Solutions - Great Plains 8.0, select **Setup** on the **Tools** menu, point to **System**, and then select **Company**.
   - If you're using a version that is earlier than Microsoft Business Solutions - Great Plains 8.0, select **System** on the **Setup** menu, and then select **Company**.

2. Select the **Company Name** lookup.
3. Select the company that you want to delete, select **Select**, and then select **Delete**.
4. Verify that the company database was removed. To do this, follow the steps for the database that you're using with Microsoft Dynamics GP.

    - Microsoft SQL Server 2005/Microsoft SQL Server 2008/Microsoft SQL Server 2008 R2/Microsoft SQL Server 2012

      1. Start SQL Server Management Studio.
      2. Expand the instance of SQL Server for Microsoft Dynamics GP, and then expand **Databases**.
      3. Verify that the company database was removed. If the company database is listed, right-click the company database, and then select **Delete**.

    - Microsoft SQL Server 2000

      1. Start Enterprise Manager.
      2. Expand the instance of SQL Server for Microsoft Dynamics GP, and then expand **Databases**.
      3. Verify that the company database was removed. If the company database is listed, right-click the company database, and then select **Delete**.

    - Microsoft SQL Server Desktop Engine (MSDE)

      1. Start Support Administrator Console.
      2. Run the following command to verify that the company database still exists.

         ```sql
         SELECT name FROM MASTER..SYSDATABASES
         ```

      3. If the company database is listed, run the following command to delete the database.

         ```sql
         DROP DATABASE XXX
         ```

         > [!NOTE]
         > Replace **XXX** with the database name of the company that you want to delete.

5. If the database has been manually removed or removed by the DROP script mentioned in step c of step 4, then there may be some references from the deleted database still within the DYNAMICS/system database. These references need to be removed. To do this, download the [ClearCompanies.sql script](https://mbs2.microsoft.com/fileexchange/downloadfile.aspx?fileid=e1140f50-afc0-4a4d-83ef-e9826aff6d64) and then follow the steps:

   - Microsoft SQL Server 2005/Microsoft SQL Server 2008/Microsoft SQL Server 2008 R2/Microsoft SQL Server 2012/Microsoft SQL Server 2014/Microsoft SQL Server 2016/Microsoft SQL Server 2019

      1. Start SQL Server Management Studio.
      2. Select **New Query** from the menu bar to start a new query window.
      3. Paste the contents of the ClearCompanies.sql scripts into the empty query window.
      4. Select **Execute** or press F5 to run the script.

         > [!NOTE]
         > ClearCompanies.sql is a script that is automatically setup to run against the appropriate databases.

   - Microsoft SQL Server 2000

     1. Start Query Analyzer.
     2. Select **Query** and then select **New Query** to open a blank query window.
     3. Paste the contents of ClearCompanies.sql into this empty query window.
     4. Select the Execute button or press F5 to run the script.

        > [!NOTE]
        > ClearCompanies.sql is a script that is automatically setup to run against the appropriate databases.

6. Sign in to Microsoft Dynamics GP to verify the company no longer exists.
