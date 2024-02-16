---
title: How to remove a company that is no longer being used
description: Describes how to remove a company that is no longer being used in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 02/16/2024
---
# How to remove a company that is no longer being used in Microsoft Dynamics GP

This article explains how to remove a company that is no longer being used in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 849249

To remove a company that is no longer being used in Microsoft Dynamics GP, follow these steps:

1. Follow the appropriate step:
   Select **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **System**, and then select **Delete Company**.

2. Select the **Company Name** lookup.

3. Select the company that you want to delete, select **Select**, and then select **Delete**.

4. Verify that the company database was removed. To do this, follow the steps for the database that you're using with Microsoft Dynamics GP.

    - Microsoft SQL Server

      1. Start SQL Server Management Studio.
      2. Expand the instance of SQL Server for Microsoft Dynamics GP, and then expand **Databases**.
      3. Verify that the company database was removed. If the company database is listed, right-click the company database, and then select **Delete**.

       > [!NOTE]
         > Replace **XXX** with the database name of the company that you want to delete.

5. If the database has been manually removed or removed by the DROP script mentioned in step c of step 4, then there may be some references from the deleted database still within the DYNAMICS/system database. These references need to be removed. To do this, download the [ClearCompanies.sql script](https://mbs2.microsoft.com/fileexchange/downloadfile.aspx?fileid=e1140f50-afc0-4a4d-83ef-e9826aff6d64) and then follow the steps:

   - Microsoft SQL Server

      1. Start SQL Server Management Studio.
      2. Select **New Query** from the menu bar to start a new query window.
      3. Paste the contents of the ClearCompanies.sql scripts into the empty query window.
      4. Select **Execute** or press F5 to run the script.

         > [!NOTE]
         > ClearCompanies.sql is a script that is automatically setup to run against the appropriate databases.

6. Sign in to Microsoft Dynamics GP to verify the company no longer exists.
