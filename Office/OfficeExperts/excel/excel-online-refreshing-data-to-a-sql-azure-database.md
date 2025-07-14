---
title: How to refresh data to a SQL Azure Database in Excel Online
description: Describe detailed steps to refresh data to a SQL Azure Database in Excel Online
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - Editing\Data\ImportExport
  - sap:office-experts
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: thempel
appliesto: 
  - Excel Online
ms.date: 06/06/2024
---

# How to refresh data to a SQL Azure Database in Excel Online

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

This article describes how to connect to Microsoft SQL Azure Database and refresh the data in Excel Online.

1. Open Excel client, click **Data** > **From Other Sources** > **From Data Connection Wizard**.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/from-data-connection-wizard.png" alt-text="Screenshot to select the From Data Connection Wizard item in the Data tab." border="false":::

1. Select **Other/Advanced**.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/data-connection-wizard.png" alt-text="Screenshot of the Data Connection Wizard page with Other/Advanced selected." border="false":::

1. Select **SQL Server Native Client 11.0**.

   > [!NOTE]
   > If you don't have [SQL Server Native Client 11.0](/sql/relational-databases/native-client/applications/installing-sql-server-native-client).

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/sql-server-native-client.png" alt-text="Screenshot to select the SQL Server Native Client 11.0 item." border="false":::

1. Enter your SQL Azure Database name, and then click **OK**.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/login-page.png" alt-text="Screenshot to log in with your SQL Azure Database name." border="false":::

1. Select the **Use a specific user name and password** option, and then enter the **User name** and **Password**. Select the correct database under **Select the database** dropdown, and then click **Test Connection** to make sure that the connection is successful.

   > [!IMPORTANT]
   > Select the **Allow saving password** check box.  

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/data-link-properties.png" alt-text="Screenshot shows steps to make sure that the connection is successful." border="false":::

1. Select the table that you want to use, and then click **Next**.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/select-table.png" alt-text="Screenshot to select the table on the Data Connection Wizard window." border="false":::

1. On the **Save Data Connection File and Finish** window, click **Finish**.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/data-connection-finish.png" alt-text="Screenshot to select the Finish option on the Save Data Connection File and Finish window." border="false":::

1. Select **Pivot Table Report** (in this example).

   > [!IMPORTANT]
   > For this report to refresh in Excel only, you must select the **Add this data to the Data Model** check box.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/import-data.png" alt-text="Screenshot shows an example of selecting the PivotTable Report option." border="false":::

1. If you are prompted to re-enter the password, re-enter it.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/reenter-password.png" alt-text="Screenshot of prompting to re-enter the password." border="false":::

1. Make sure that the password is embedded in the connection string. To do this, in the Excel client, select **Data** > **Connections** > **Properties** > **Definition** tab. Make sure that there is a check box next to **Save Password** and also make sure that the password is indeed embedded in the connection string (it should say **Password=<*YourPassword*>** at the end of the connection string), and then click **OK**.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/connection-properties.png" alt-text="Screenshot to make sure the password is embedded in the connection string." border="false":::

1. If you did have to select the **Save password** check box, the connection string will change. Therefore, you will be informed that the connection string is now different from the .odc file. The warning is ok, and you just click **Yes**.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/warning-message.png" alt-text="Screenshot of the warning says that the connection string is now different." border="false":::

1. Now, you see that a Data Model is added to the workbook. This is important to a successful refresh in Excel Online.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/workbook-connections.png" alt-text="Screenshot shows a Data Model is added to the workbook." border="false":::

1. Upload this workbook to Excel Online, and then test refreshing in the browser through **Data** > **Refresh All Connections**.

   :::image type="content" source="media/excel-online-refreshing-data-to-a-sql-azure-database/refresh-all-connections.png" alt-text="Screenshot to select the Refresh All Connections item under the Data tab." border="false":::
