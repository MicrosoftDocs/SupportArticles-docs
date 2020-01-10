---
title: How to refresh data to a SQL Azure Database in Excel Online
description: Describe detailed steps to refresh data to a SQL Azure Database in Excel Online
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.service: o365-solutions
ms.topic: article
ms.author: thempel
appliesto:
- Excel Online
---

# How to refresh data to a SQL Azure Database in Excel Online

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

This article describes how to connect to Microsoft SQL Azure Database and refresh the data in Excel Online.

1. Open Excel client, click **Data** > **From Other Sources** > **From Data Connection Wizard**.

   ![Selecting From Data Connection Wizard in Data tab](./media/excel-online-refreshing-data-to-a-sql-azure-database/data.png)

1. Select **Other/Advanced**.

   ![Selecting Other/Advanced](./media/excel-online-refreshing-data-to-a-sql-azure-database/data-connection-wizard.png)

1. Select **SQL Server Native Client 11.0**.
   
   > [!NOTE]
   > If you don't have SQL Server Native Client 11.0, you have to install it from [www.microsoft.com/en-us/download/details.aspx?id=35580](https://www.microsoft.com/en-us/download/details.aspx?id=35580).
   
   ![Selecting SQL Server Native Client 11.0](./media/excel-online-refreshing-data-to-a-sql-azure-database/sql-server-native-client.png)

1. Enter your SQL Azure Database name, and then click **OK**.

   ![Log in with your SQL Azure Database name](./media/excel-online-refreshing-data-to-a-sql-azure-database/login.png)

1. Select the **Use a specific user name and password** option, and then enter the **User name** and **Password**. Select the correct database under **Select the database** dropdown, and then click **Test Connection** to make sure that the connection is successful.

   > [!IMPORTANT]
   > Select the **Allow saving password** check box.  

   ![Enter a specific User name and Password, select database and then test connection](./media/excel-online-refreshing-data-to-a-sql-azure-database/data-link-properties.png)

1. Select the table that you want to use, and then click **Next**.

   ![Selecting database and table](./media/excel-online-refreshing-data-to-a-sql-azure-database/select-table.png)

1. On the **Save Data Connection File and Finish** window, click **Finish**.

   ![Save Data Connection File fish](./media/excel-online-refreshing-data-to-a-sql-azure-database/data-connection-finish.png)

1. Select **Pivot Table Report** (in this example).

   > [!IMPORTANT]
   > For this report to refresh in Excel only, you must select the **Add this data to the Data Model** check box.

   ![Select how you want to view data in your workbook](./media/excel-online-refreshing-data-to-a-sql-azure-database/import-data.png)

1. If you are prompted to re-enter the password, re-enter it.

   ![Reenter password](./media/excel-online-refreshing-data-to-a-sql-azure-database/reenter-password.png)

1. Make sure that the password is embedded in the connection string. To do this, in the Excel client, select **Data** > **Connections** > **Properties** > **Definition** tab. Make sure that there is a check box next to **Save Password** and also make sure that the password is indeed embedded in the connection string (it should say **Password=<*YourPassword*>** at the end of the connection string), and then click **OK**.

   ![Make sure the password is embedded in the connection string](./media/excel-online-refreshing-data-to-a-sql-azure-database/connection-properties.png)

1. If you did have to select the **Save password** check box, the connection string will change. Therefore, you will be informed that the connection string is now different from the .odc file. The warning is ok, and you just click **Yes**.

   ![A warning says that the connection string is now different](./media/excel-online-refreshing-data-to-a-sql-azure-database/warning.png)

1. Now, you see that a Data Model is added to the workbook. This is important to a successful refresh in Excel Online.

   ![A Data Model is added to the workbook](./media/excel-online-refreshing-data-to-a-sql-azure-database/workbook-connections.png)

1. Upload this workbook to Excel Online, and then test refreshing in the browser through **Data** > **Refresh All Connections**.

   ![Refresh All Connections](./media/excel-online-refreshing-data-to-a-sql-azure-database/refresh-all-connections.png)