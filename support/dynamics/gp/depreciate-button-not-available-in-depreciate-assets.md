---
title: Depreciate not available in Depreciate Assets
description: The Depreciate button is not available in the Depreciate Assets window when you try to depreciate assets in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Fixed Assets
---
# The Depreciate button is not available in the Depreciate Assets window when you try to depreciate assets in Microsoft Dynamics GP

This article provides a resolution for the issue that the Depreciate button is unavailable in the Depreciate Assets window when depreciating assets in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852399

## Symptoms

In Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, when you try to depreciate one or more assets, you may experience the following symptoms:

- In the Depreciation Process Information window, the Depreciate button is unavailable.
- You cannot select a book in the Depreciate Asset window.

## Resolution

To resolve these issues, follow these steps.

> [!NOTE]
> If you are not familiar with the following steps, please ask assistance from an IT person.

### Step 1 - Back up the company database

Before you follow the steps to resolve these issues, make a complete backup of the company database to prevent data loss.

> [!NOTE]
> You may want to use a test company database that has a copy of live company data. When you do this, users will not have to log off from Microsoft Dynamics GP or from Microsoft Business Solutions - Great Plains while you test the steps to resolve these issues. After you have tested the steps, you can process these steps against the live company data after all the users have logged off at the end of the workday. For more information about how to set up a test company database that uses live company data, see
 [Set up a test company that has a copy of live company data for Microsoft Dynamics GP by using Microsoft SQL Server](https://support.microsoft.com/topic/kb-set-up-a-test-company-that-has-a-copy-of-live-company-data-for-microsoft-dynamics-gp-by-using-microsoft-sql-server-6199295b-fc49-d963-3865-2d24a4b49211).

#### Perform a backup of the company database in Microsoft Dynamics GP 10.0

1. On the **Microsoft Dynamics GP** menu, point to **Maintenance** and then select **Backup**.
2. Select the company that you want to back up.
3. Select **OK** to make the backup.

The **Back Up Company** window will close and a message will appear when the backup is complete.

#### Perform a backup of the company database in Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0

Make a backup of the live company database. To do this, use one of the following methods, as appropriate for your situation.

Method 1: Using SQL Server Enterprise Manager

If you are using SQL Server Enterprise Manager, follow these steps:

1. Select **Start**, and then select **Programs**.
2. Point to **Microsoft SQL Server**, and then select **Enterprise Manager**.
3. Expand **Microsoft SQL Servers**, expand **SQL Server Group**, and then expand the instance of SQL Server.
4. Expand **Databases**, right-click the live company database, select **All Tasks**, and then select **Backup Database**.
5. In the SQL Server Backup window, select **Add** in the **Destination** section.
6. In the Select Backup Destination window, select the ellipsis button next to the **File name** field.
7. In the Backup Device Location window, expand the folders, and then select the location for the backup file.
8. Type a name for the backup file. For example, type *Live.bak*.
9. Select **OK** repeatedly until you return to the SQL Server Backup window.
10. Select **OK** to start the backup.
11. When the backup has completed successfully, select **OK**.

Method 2: Using SQL Server Management Studio

If you are using SQL Server Management Studio, follow these steps:

1. Select **Start**, and then select **Programs**.
2. Point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**. The Connect to Server window opens.
3. In the **Server name** box, type the name of the instance of SQL Server.
4. In the **Authentication** list, select **SQL Authentication**.
5. In the **User name** box, type *sa*.
6. In the **Password** box, type the password for the sa user, and then select **Connect**.
7. In the **Object Explorer** section, expand **Databases**.
8. Right-click the live company database, point to **Tasks**, and then select **Backup**.
9. In the **Destination** area, select **Remove**, and then select **Add**.
10. In the **Destination on disk** area, select the ellipsis button.
11. Find the location where you want to create the backup file, type a name for the backup file, such as *LIVE.bak*, and then select **OK**.
12. Select **OK** repeatedly until you return to the Backup Database window.
13. Select **OK** to start the backup.

### Step 2 - Unlock the Depreciation process

1. Have all users signed off from Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains.

2. Start SQL Server.

    - To start SQL Server 2000, select **Start**, point to **All Programs**, point to **Microsoft SQL Server** and then select **Query Analyzer**.
    - To start SQL Server Management Studio:

      1. Select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**. The **Connect to Server** window opens.
      2. In the **Server name** box, type the name of the instance of SQL Server.
      3. In the **Authentication** list, select **SQL Authentication**.
      4. In the **User name** box, type *sa*.
      5. In the **Password** box, type the password for the sa user, and then select **Connect**.

3. Select **New Query**, and then select the correct company database.
4. Run the following query to unlock the depreciation process:

   ```sql
   DELETE FA40203
   ```

5. Log back on to Microsoft Dynamics GP or to Microsoft Business Solutions - Great Plains.
6. Open the **Depreciation Process Information** window. To do this, use the appropriate method:

    - In Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Fixed Assets**, and then select **Depreciate**.
    - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Routines** on the **Tools** menu, point to **Fixed Assets**, and then select **Depreciate**.

7. Verify that the **Depreciate** button is available.
