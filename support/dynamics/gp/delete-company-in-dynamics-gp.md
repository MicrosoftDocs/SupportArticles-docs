---
title: Delete a company in Microsoft Dynamics GP
description: Describes how to delete a company in Microsoft Dynamics GP if you also run Microsoft SQL Server. The procedure requires that you delete the company both from the DYNAMICS database and from the computer that is running SQL Server.
ms.reviewer: theley, kyouells
ms.date: 03/13/2024
---
# Delete a company in Microsoft Dynamics GP

This article provides the steps to properly delete a company from Microsoft Dynamics GP and prevent the error message stating the company already exists.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855361

## Introduction

When you try to create a new company, you may receive an error message that states that the company already exists. To delete a company that is no longer desired, use one of the following methods:

## Method 1: in Microsoft Dynamics GP

1. Start Microsoft Dynamics GP, and sign in with "sa".

2. At the **Company Login** window, select a company that you don't want to delete, and then select **OK**.

    > [!NOTE]
    > The company being deleted cannot have a user logged into it.

3. Make sure that no users are logged on to the company that you want to delete. To do this, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **System**, and then select **User Activity**.

4. Select the company that you want to delete. To do this, follow these steps:
    1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **System**, and then select **Delete Company**.
    2. Select the lookup button. Then, select the company that you want to delete.

5. Select **Delete**.

    > [!NOTE]
    > When you select **Delete**, the company is deleted from the DYNAMICS system database.

## Method 2: in SQL Server Management Studio

In SQL Server Management Studio, follow these steps:

1. Sign in SQL Server.
2. In Object Explorer, expand the **Databases** folder.
3. Right-click the company database, and then select **Delete**.

> [!NOTE]
> If the company database was deleted in SQL Server Management Studio before it was deleted from Microsoft Dynamics GP, you must remove the orphaned records. To remove the orphaned records, run the [Clearcompanies.sql](https://mbs2.microsoft.com/fileexchange/downloadfile.aspx?fileid=e1140f50-afc0-4a4d-83ef-e9826aff6d64) script in SQL Query Analyzer or in SQL Server Management Studio.
