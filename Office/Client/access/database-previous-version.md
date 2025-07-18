---
title: Cannot Open an Access database created with a previous version of your application
description: Works around an issue in which you receive an error message when you try to open an Access 97 database in Access 2013 or Access 2016.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
ms.date: 05/26/2025
---

# "Cannot Open a database created with a previous version of your application" in Access 2013 and Access 2016

This issue occurs when you try to use Access 2013 or later version of Microsoft Access to open an Access 97 database. To work around this issue, use a pre-Access 2013 version of Access to save the Access 97 database as an .accdb file: 

1. Open the Access 97 database in Access 2003.    
2. On the Tools menu, click Database Utilities, click Convert Database, and then click to Access 2002-2003 file format.    
3. Enter a name for the database, and then click Save.    
4. Exit Access 2003.    
5. Open the database in Access 2013 or later version of Access.    
6. On the File tab, click Save As, select Access Database (*.accdb), and then click Save As.   
7. In the Save As dialog box, click Save.   

## Cause

This issue occurs because recent versions of Access can't convert Access 97 files. 

## More Information

When you open an Access 97 database in Access 2010 or Access 2007, the Database Enhancement Wizard helps you convert the database to an .accdb file. For more information, see [Convert a database to the .accdb file format](https://office.microsoft.com/access-help/convert-a-database-to-the-accdb-file-format-ha102749625.aspx?ctt=1).

By design, recent versions of Access cannot convert Access 97 files.

Find [more tips, tricks, and learning opportunities for small business](https://smallbusiness.support.microsoft.com/en-us).
