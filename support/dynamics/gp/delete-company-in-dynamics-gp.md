---
title: Delete a company in Microsoft Dynamics GP
description: Describes how to delete a company in Microsoft Dynamics GP if you also run Microsoft SQL Server. The procedure requires that you delete the company both from the DYNAMICS database and from the computer that is running SQL Server.
ms.reviewer: kyouells
ms.date: 03/31/2021
---
# Delete a company in Microsoft Dynamics GP

This article provides the steps to properly delete a company from Microsoft Dynamics GP and prevent the error message stating the company already exists.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855361

## Introduction

When you try to create a new company, you may receive an error message that states that the company already exists. The following section describes how to delete a company in Microsoft Dynamics GP if you run Microsoft SQL Server.

## Delete a company that is no longer desired

1. Start Microsoft Dynamics GP, and log on with the "sa" login.

2. At the **Company Login** window, select a company that you do not want to delete, and then click **OK**.

    > [!NOTE]
    > The company being deleted cannot have a user logged into it.

3. Make sure that no users are logged on to the company that you want to delete. To do this, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **System**, and then click **User Activity**.

4. Select the company that you want to delete. To do this, follow these steps:
    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **System**, and then click **Delete Company**.
    2. Click the lookup button. Then, click the company that you want to delete.

5. Click **Delete**.

    > [!NOTE]
    > When you click **Delete**, the company is deleted from the DYNAMICS system database.

6. [Delete the company database from the computer that is running Microsoft SQL Server](#delete-the-company-database-from-the-computer-running-sql-server).

### Delete the company database from the computer running SQL Server

For Microsoft Dynamics GP 2013, to run the scripts to delete the company database from the computer that is running SQL Server yourself, use one of the following methods, depending on the version you are using:

- In SQL Server Enterprise Manager, follow these steps:
    1. Expand the folder of the computer that is running SQL Server.
    2. Expand the **Databases** folder.
    3. Right-click the company database, and then click **Delete**.

- In SQL Server Management Studio, follow these steps:
    1. Log on to SQL Server.
    2. In Object Explorer, expand the **Databases** folder.
    3. Right-click the company database, and then click **Delete**.

- In the Support Administrator Console utility, follow these steps:

    1. Log on to SQL Server.
    2. In the query window, type drop database **name of the company database**.
    3. To run the query, click the green arrow button on the toolbar.

    > [!NOTE]
    > If the company database was deleted in SQL Server Enterprise Manager or in SQL Server Management Studio before it was deleted from Microsoft Dynamics GP, you must remove the orphaned records.

An automated solution that deletes a company in Microsoft Dynamics GP may be available. All automated solutions are not available for all product versions.
