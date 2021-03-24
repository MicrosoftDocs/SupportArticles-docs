---
title: Split a Access database manually 
description: Describes how to manually split the database to either a front-end application or a back-end application. Performance improvement and other reasons are listed that describe why you may want to split your database.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
- CI 111294
- CSSTroubleshoot
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: SHAYDEN 
appliesto:
- Access 2007
- Access 2003
- Access 2002
---

# How to manually split a Access database in Microsoft Access

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file.

## Summary

For various reasons, you may decide to split the database into either a front-end application or a back-end application. The back-end database contains the tables and is stored on a file server. The front-end database that links to the back-end tables contains all the forms, the queries, the reports, the macros, and the modules. The front-end database is distributed to the workstations of the users. 

This article describes how to split the database manually instead of by using the Database Splitter utility.

## More information

To split the database in Microsoft Office Access 2003 and in earlier versions of Access, follow these steps: 

1. Create a new blank Access database.   
2. On the File menu, point to Get External Data, and then click Import.   
3. Locate and select the database that you want to split.   
4. On the **Tables** tab, click **Select All**, and then click **OK**.

   Notice that Access imports all of the tables into the new database, which is your back-end database.   
5. Store the new back-end database on a network share and make sure that all the users have full permissions to the share.   
6. Create a second new blank Access database.   
7. On the File menu, point to Get External Data, and then click Link Tables.   
8. Select the back-end database that you just created.   
9. On the **Tables** tab, click **Select All** and then click **OK**.

   Notice that Access links the tables in the back-end database to the front-end database.   
10. On the File menu, point to Get External Data, and then click Import.   
11. Select the original database that you are splitting, and then click Import.   
12. On the Forms tab, click Select All. Repeat this step on all tabs except the Tables tab. Because you have already linked to the tables, you now only need to import the rest of the objects.   
13. After you have selected all of the objects except for tables, click **OK**.

    Notice that you now have all the tables linked and have imported the remaining objects.   

To split the database in Microsoft Office Access 2007 or a later version, follow these steps:

1. Create a new blank Access database.   
2. On the **External Data** tab, click **Access** in the **Import** group.   
3. In the **Get External Data** dialog box, click **Browse** to locate and select the database that you want to split, click to select the **Import tables, queries, forms, reports, macros, and modules into the current database.** check box, and then click **OK**.   
4. In the **Import Objects** dialog box, click **Select All** on the **Tables** tab, and then click **OK**.

   Notice that Access imports all of the tables into the new database, which is your back-end database.   
5. Store the new back-end database on a network share, and make sure that all the users have full permissions to the share.   
6. Create a second new blank Access database.   
7. On the **External Data**, click **Access** in the **Import** group.   
8. In the **Get External Data** dialog box, click **Browse** to select the back-end database that you created, click to select the **Link to the data source by creating a linked table.** check box, and then click **OK**.   
9. In the **Import Objects** dialog box, click **Select All** on the **Tables** tab, and then click **OK**.

   Notice that Access links the tables in the back-end database to the front-end database.   
10. On the **External Data**, click **Access** in the **Import** group.   
11. In the **Get External Data** dialog box, click **Browse** to select the original database that you are splitting, click to select the **Import tables, queries, forms, reports, macros, and modules into the current database.** check box, and then click **OK**.   
12. In the **Import Objects** dialog box, click **Select All** on the **Forms** tab, repeat this step on all other tabs except the **Tables** tab because you have already linked to the tables. You now only need to import the rest of the objects, and then click **OK**.

    Notice that you now have all the tables linked and have imported the remaining objects.   

**Notes**

This database is the front-end database. You can distribute this front-end database to the workstations so that each user has his own copy of the front-end database. 

You have now successfully split your database, which will improve performance. Now when a user opens a form, the form opens locally on their computer, and is not sent across the network. The only data that comes across the network is the data in the linked tables.

### Reasons Why You May Want to Split Your Database

The following are typical reasons to split a database:

- You are sharing your database with multiple users on a network.   
- You have several people developing in the database and you do not have Microsoft Visual Source Safe installed.   
- You do not want your users to be able to make design changes to tables.   

The most common reason to split a database is that you are sharing the database with multiple users on a network. If you simply store the database on a network share, when your users open a form, query, macro, module, or report, these objects have to be sent across the network to each individual who uses the database. If you split the database, each user has their own copy of the forms, queries, macros, modules, and reports. Therefore, the only data that must be sent across the network is the data in the tables. 

**Note** To split the database, you can also use the Database Splitter utility.