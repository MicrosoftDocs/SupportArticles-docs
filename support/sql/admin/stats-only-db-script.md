---
title: How to generate a script of the necessary database metadata to create a statistics-only database in SQL Server  
description: This is a how-to article that helps you create a statistics-only database in SQL Server. 
ms.date: 07/18/2022
ms.custom: sap:Administration and Management
ms.topic: how-to
author: ramakoni1
ms.prod: sql
ms.author: v-jayaramanp
---

# Introduction

This article describes the steps to generate the statistics script.

_Original product version:_ &nbsp; SQL Server 2014 Developer, SQL Server 2014 Enterprise

The query optimizer in Microsoft SQL Server uses the following types of information to determine an optimal query plan:

- database metadata
- hardware environment
- database session state

Typically, you must simulate all of these types of information to reproduce the behavior of the query optimizer on a test system.

Microsoft Customer Support Services may ask you to generate a script of the database metadata. Microsoft Customer Support Services uses this script to investigate an optimizer issue. This article describes the steps to generate the statistics script. It also describes how the query optimizer uses the information.

[DBCC CLONEDATABASE](/sql/t-sql/database-console-commands/dbcc-clonedatabase-transact-sql?view=sql-server-ver15) is the preferred method to generate schema-only clone of a database to investigate performance issues. Use the procedure in this article only when you aren't able to use DBCC CLONEDATABASE.

## Script the whole database

When you generate a statistics-only clone database, it may be easier and more reliable to script the whole database instead of scripting individual objects. When you script the whole database, you receive the following benefits:

- You avoid issues with missing dependent objects that are required to reproduce the issue.
- You require significantly fewer steps to select the necessary objects.

Note If you generate a script for a database, and the metadata for the database contains thousands of objects, the scripting process consumes significant CPU resources. It is  recommended that you generate the script during off-peak hours or you can use the second option to generate the script for individual objects.

To script each database that is referenced by your query, follow these steps:

1. Open SQL Server Management Studio.

1. In the **Object Explorer**, expand **Databases**, and then locate the database that you want to script.

1. Right-click the database, point to **Tasks**, and then click **Generate Scripts**.

1. In the Script Wizard, verify that the correct database is selected. Click to select the **Script entire database and all database objects**, and then click **Next**.

1. In the **Choose Script Options** dialog box, click on the **Advanced** button to change the following settings from the default value to the value that is listed in the following table.


|Scripting option  |Value to select  |
|---------|---------|
|ANSI padding     |   True      |
|Continue Scripting on Error| True        |
|Row3     | True      |
|Row4     | True       |
|Row5     | True      |
|Row6     | True       |
|Row7     | True       |
|Row8     | True      |
|Row9     | True       |
|Row10     | True        |
|Row11     |         |
|Row12     |         |

