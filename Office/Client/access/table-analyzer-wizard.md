---
title: How Table Analyzer Wizard works
description: Provides information about how to run the Table Analyzer Wizard and how the Table Analyzer Wizard works.
author: helenclu
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
ms.author: luche
ms.reviewer: V-SHIRAP
appliesto:
- Access 2007
- Access 2003
- Access 2002
---

# How the Table Analyzer Wizard works

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

Novice: Requires knowledge of the user interface on single-user computers. 

This article applies only to a Microsoft Access database (.mdb) or a Microsoft Office Access 2007 database (.accdb).

## Summary

The Table Analyzer Wizard can help you create a relational database from a set of data. When you use the Table Analyzer Wizard, you do not have to know relational database design principles. This article explains how the Table Analyzer Wizard deciphers a single-table database and proposes a way of splitting the original table into a set of related tables. 

## More information

The Table Analyzer Wizard can automatically analyze a nonrelational database and "normalize" it for you. Normalization is the process of taking a single-table database and breaking it into a set of smaller, related tables, with each table focused on a single topic or grouping of information. 

A normalized relational database has a number of advantages over a nonrelational one. First, updating information is faster and easier because fewer data changes are required. Second, only the minimum information is stored; therefore, the database is smaller. Finally, a relational database keeps data consistent automatically because data is stored once. 

Although the Table Analyzer Wizard can help you create a relational database, if you have database experience, the Table Analyzer Wizard enables you to modify any suggestions it makes. You can split up tables, rearrange fields in tables, and create relationships between tables. You can modify Table Analyzer Wizard decisions during every step of the database-creation process.

### How to Run the Table Analyzer Wizard

To run the Table Analyzer Wizard, follow these steps: 

1. In Microsoft Office Access 2003 or in Microsoft Access 2002, point to **Analyze** on the **Tools** menu, and then click **Table**. 

   In Microsoft Office Access 2007 or a later version, click the **Database Tools** tab, and then click **Analyze Table** in the **Analyze** group.   
2. Follow the instructions in the Table Analyzer Wizard dialog boxes. Note that the first two dialog boxes explain what normalization is and why it is useful. The third dialog box asks if you want to manually split a database or if you want to let the wizard do it for you.    

### How the Table Analyzer Wizard Works

If you choose to let the Table Analyzer Wizard split a database, the Table Analyzer Wizard runs through the following process: 

1. The Table Analyzer Wizard starts with a single-table database, which can be any set of data created with, or imported into, Microsoft Access. The wizard then breaks the table into a set of smaller tables. Each of these smaller tables contains the minimum set of information that is grouped together.    
2. The wizard looks for unique values that can identify a grouping of data. These unique values are labeled as primary keys for each of the groupings. If no unique value is identified, the wizard creates a primary key using an auto-incrementing long integer field. In addition, the wizard creates a foreign key in related tables.    
3. The wizard creates relationships that control how the new tables work together. These relationships enforce referential integrity (data consistency) with cascading updates. The wizard does not automatically add cascading deletes to the relationships because of the risk that you may accidentally delete large portions of data.    
4. The wizard creates an initial proposal and asks you to confirm or change it.    
5. If you confirm the proposal, the wizard then searches the new tables for inconsistent data (for example the same customer with two different phone numbers) and presents a list of records that you can change or accept.    
6. Finally, you can choose to create a query that simulates the original, single-table database. The wizard first backs up the original table and renames it by appending "_OLD" to its name. Then, the wizard creates a query using the original table name. This assures that any existing forms or reports based on the original table will work with the new table structure.   
