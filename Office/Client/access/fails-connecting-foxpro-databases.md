---
title: Unable to import, export, or link to FoxPro databases
description: Describes a problem in which you can't import, export, or link to FoxPro databases directly in Access. Use Microsoft Visual FoxPro ODBC driver to resolve this problem.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 3/31/2022
---
# You cannot connect directly to FoxPro databases in Access 2007 and in Access 2003

_Original KB number:_ &nbsp; 824264

> [!NOTE]
> This article applies only to a Microsoft Access database (.mdb or .accdb). Requires basic macro, coding, and interoperability skills.

## Symptoms

In Microsoft Office Access 2007 and in Microsoft Office Access 2003, you may not be able to import, export, or link to Microsoft FoxPro databases directly because the **Import**, **Export**, and **Link** dialog boxes do not include the FoxPro database as an option in the **Files of type** list.

## Cause

This problem occurs because the Microsoft FoxPro ISAM driver is not included in Access 2007 and in Access 2003.

## Resolution

### Import from a FoxPro database

To import data from a FoxPro database, use the Microsoft Visual FoxPro ODBC driver. To do so, follow these steps:

1. Click **Start**, and then click **Control Panel**.
2. In **Control Panel**, double-click **Administrative Tools**.
3. In the **Administrative Tools** window, double-click **Data Sources (ODBC)**, and then add a new ODBC data source for your FoxPro database or tables by selecting the appropriate Visual FoxPro driver.
4. Start Access, and then open your Access database.
5. On the **File** menu, point to **Get External Data**, and then click **Import**.

   > [!NOTE]
   > If you use Access 2007, click **More** in the **Import** group on the **External Data** tab, and then select **ODBC Database**.

6. In the **Import** dialog box, click **ODBC Databases** in the **Files of type** list.

   > [!NOTE]
   > If you use Access 2007, click to select the **Import the source data into a new table in the current database** option in the **Select the source and destination of the data** dialog box, and then click **OK**.
7. In the **Select Data Source** dialog box, click the Visual FoxPro data source that you created in step 3, and then click **OK**.
8. In the **Import Objects** dialog box, click the tables that you want to link, and then click **OK**.

### Link to a FoxPro database

To link to a FoxPro database, use the Microsoft Visual FoxPro ODBC driver. To do so, follow these steps:

1. Click **Start**, and then click **Control Panel**.
2. In **Control Panel**, double-click **Administrative Tools**.
3. In the **Administrative Tools** window, double-click **Data Sources (ODBC)**, and then add a new ODBC data source for your FoxPro database or tables by selecting the appropriate Visual FoxPro driver.
4. Start Microsoft Access, and then open your Access database.
5. On the **File** menu, point to **Get External Data**, and then click **Link Tables**.

   > [!NOTE]
   > If you use Access 2007, click **More** in the **Import** group on the **External Data** tab, and then select **ODBC Database**.
6. In the **Link** dialog box, click **ODBC Databases** in the **Files of type** list.
 
   > [!NOTE]
   > If you use Access 2007, click to select the **Link to the data source by creating a linked table** option in the **Select the source and destination of the data** dialog box, and then click **OK**.
7. In the **Select Data Source** dialog box, click the Visual FoxPro data source that you created in step 3, and then click **OK**.
8. In the **Link Tables** dialog box, click the tables that you want to import, and then click **OK**.

### Export to a FoxPro database

To export data to a FoxPro database, use the Microsoft Visual FoxPro ODBC driver. To do so, follow these steps:

1. Click **Start**, and then click **Control Panel**.
2. In **Control Panel**, double-click **Administrative Tools**.
3. In the **Administrative Tools** window, double-click **Data Sources (ODBC)**, and then add a new ODBC data source for your FoxPro database or tables by selecting the appropriate Visual FoxPro driver.
4. Start Microsoft Access, and then open your Access database.
5. On the **File** menu, click **Export**.
   
   > [!NOTE]
   > If you use Access 2007, follow these steps:
   > 1. Click the Microsoft Office button, and then click **Access Options**.
   > 2. In the list in the left pane, click **Customize**.
   > 3. In the **Choose commands from** list, select **All commands**.

6. In the **Export Table 'tablename' To...** dialog box, click **ODBC Databases** in the **Save as type** list.

   > [!NOTE]
   > If you use Access 2007, follow these steps:
   > 1. Click **Export selected object to an ODBC database**, click **Add**, and then click **OK**.
   > 2. On the Quick Access toolbar, click **Export selected object to an ODBC database**.

7. In the **Export** dialog box, type the name of the new table, and then click **OK**.
8. In the **Select Data Source** dialog box, click the Visual FoxPro data source that you created in step 3, and then click **OK**.

## More Information

In earlier versions of Access and the Microsoft Jet database engine, you can move data between FoxPro databases and Access databases. The Microsoft FoxPro ISAM driver connects Access to FoxPro databases. However, the Microsoft FoxPro ISAM driver is not included in Access 2000 and later. As a result, you can no longer access FoxPro data through the Microsoft Jet database engine. You can only access FoxPro data by using the Microsoft Visual FoxPro ODBC driver.

### Steps to reproduce the problem in Access 2003

1. Open an Access database.
2. On the **File** menu, point to **Get External Data**, and then click **Import**.
3. In the **Import** dialog box, click the **Files of type** list.

> [!NOTE]
> The Microsoft FoxPro ISAM driver is not listed in the **Files of type** list.

## References

For more information about how to set up ODBC data sources, click **Microsoft Office Access Help** on the **Help** menu, typeset up or change ODBC data sourcesin the **Search for** box in the Assistance pane, and then click **Start searching** to view the topic.
