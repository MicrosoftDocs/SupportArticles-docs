---
title: Create a statistics-only database using a generated statistics script  
description: Learn how to generate a statistic script using metadata to create a statistics-only database in SQL Server. 
ms.date: 06/12/2025
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.topic: how-to
ms.reviewer: ramakoni, v-jayaramanp, jopilov
---

# How to generate a statistics script to create a statistics-only database in SQL Server

In this article, you learn how to generate a statistics script using database metadata for creating a statistics-only database in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp;914288

## Introduction

The [DBCC CLONEDATABASE](/sql/t-sql/database-console-commands/dbcc-clonedatabase-transact-sql) is the preferred method to generate a schema-only clone of a database to investigate performance issues. Use the procedure in this article only when you aren't able to use `DBCC CLONEDATABASE`.

The query optimizer in Microsoft SQL Server uses the following types of information to determine an optimal query plan:

- database metadata
- hardware environment
- database session state

Typically, you must simulate all these same types of information to reproduce the behavior of the query optimizer on a test system.

Microsoft Customer Support Services might ask you to generate a script of the database metadata to investigate a query optimizer issue. This article describes the steps to generate the statistics script and also describes how the query optimizer uses the information.

> [!NOTE]
> The keys saved within this data might contain PII information. For example, if your table contains a **Phone number** column with a statistic on it, each step's high key value will be in the generated statistics script.

## Script the whole database

When you generate a statistics-only clone database, it might be easier and more reliable to script the whole database instead of scripting individual objects. When you script the whole database, you receive the following benefits:

- You avoid issues with missing dependent objects that are required to reproduce the issue.
- You require fewer steps to select the necessary objects.

Note that if you generate a script for a database, and the metadata for the database contains thousands of objects, the scripting process consumes significant CPU resources. It's recommended that you generate the script during off-peak hours, or you can use the second option [Script Individual Objects](#script-individual-objects) to generate the script for individual objects.

To script each database that is referenced by your query, follow these steps:

1. Open the SQL Server Management Studio.

1. In the **Object Explorer**, expand **Databases**, and then locate the database that you want to script.

1. Right-click the database, point to **Tasks**, and then select **Generate Scripts**.

1. In the script wizard, verify that the correct database is selected. Click to select the **Script entire database and all database objects**, and then select **Next**.

1. In the **Choose Script Options** dialog, select the **Advanced** button to change the following settings from the default value to the value that is listed in the following table.

    |Scripting option  |Value to select  |
    |---------|---------|
    |Ansi padding     |   True      |
    |Continue Scripting on Error| True |
    |Generate Script for Dependent Objects  | True |
    |Include System Constraint Names     | True  |
    |Script Collation     | True  |
    |Script Logins     | True  |
    |Script Object Level Permissions      | True |
    |Script Statistics      |Script statistics and histograms|
    |Script Indexes     | True |
    |Script Triggers     | True |

    > [!NOTE]
    > Note that the **Script Logins** option and the **Script Object Level Permissions** option might not be required unless the schema contains objects that are owned by logins other than **dbo**.

1. Select **OK** to save the changes, and close the **Advanced Scripting Options** page.

1. Select **Save to File** and select the **Single file** option.

1. Review your selections and select **Next**.

1. Select **Finish**.

## Script individual objects

You can only script the individual objects that are referenced by a particular query instead of scripting the complete database. However, unless all database objects were created using the `WITH SCHEMABINDING` clause, the dependency information in the `sys.depends` system table might not be always accurate. This inaccuracy might cause one of the following issues:

- The scripting process doesn't script a dependent object.

- The scripting process might script objects in the incorrect order. To run the script successfully, you must manually edit the generated script.

Therefore, it isn't recommended that you script individual objects unless the database has many objects and scripting would otherwise take too long. If you must use script individual objects, follow these steps:

1. In the SQL Server Management Studio, expand **Databases**, and then locate the database that you want to script.

1. Right-click the database, point to **Script Database As**, then point to **CREATE To**, and then select **File**.

1. Enter a file name, and then select **Save**.

   The core database container will be scripted. This container includes files, file groups, the database, and properties.

1. Right-click the database, point to **Tasks**, and then select **Generate Scripts**.

1. Make sure that the correct database is selected, and then select **Next**.

1. In the **Choose Object Types** dialog, choose **Select specific database objects**, and select all the database object types that the problematic query references.

    For example, if the query only references tables, select **Tables**. If the query references a view, select **Views and Tables**. If the problematic query uses a user-defined function, select **Functions**.

1. When you've selected all the object types that are referenced by the query, select **Next**.

1. In the **Set Scripting Options** dialog, select the **Advanced** button and change the following settings from the default value to the value that is listed in the following table on the **Advanced Scripting Options** page.

    |Scripting option  |Value to select  |
    |---------|---------|
    |Ansi Padding     | True        |
    |Continue Scripting on Error    |  True       |
    |Include System Constraint Names | True        |
    |Generate Script for Dependent Objects | True        |
    |Script Collation      |  True       |
    |Script Logins     |  True       |
    |Script Object Level Permissions |  True       |
    |Script Statistics     | Script statistics and histograms|
    |Script USE DATABASE     | True        |
    |Script Indexes     | True         |
    |Script Triggers      | True        |

     > [!NOTE]
     > Note that the **Script Logins** and **Script Object Level Permissions** options might not be required unless the schema contains objects that are owned by logins other than **dbo**.

1. Select **OK** to save and close the **Advanced Scripting Options** page.

   A dialog appears for each database object type that you selected in step 7.

1. In each dialog, select the specific tables, views, functions, or other database objects, and then select **Next**.

1. Select the **Script to File** option, and then specify the same file name that you entered in step 3.

1. Select **Finish** to start the scripting.

   When the scripting has finished, send the script file to the Microsoft Support Engineer. The Microsoft Support Engineer might also request the following information:

   - Hardware configuration, including the number of processors and how much physical memory exists.

   - SET options that were active when you ran the query.

   Note that you might have already provided this information by sending a SQLDiag report or a SQL Profiler trace. You might have also used another method to provide this information.

## How the information is used

The following tables help explain how the query optimizer uses this information to select a query plan.

**Metadata**

|Option  |Explanation  |
|---------|---------|
|Constraints| The query optimizer frequently uses constraints to detect contradictions between the query and the underlying schema. For example, if the query contains the `WHERE col = 5` clause and a `CHECK (col < 5)` constraint exists on the underlying table, the query optimizer knows that no rows will match. The query optimizer makes similar types of deductions about nullability. For example, the `WHERE col IS NULL` clause is known to be true or false depending on the nullability of the column and whether the column is from the outer table of an outer join. The presence of FOREIGN KEY constraints is useful to determine cardinality and the appropriate join order. The query optimizer can use constraint information to eliminate joins or simplify predicates. These changes might remove the requirement to access the base tables.         |
|Statistics     |   The statistics information contains density and a histogram that shows the distribution of the leading column of the index and statistics key. Depending on the nature of the predicate, the query optimizer might use density, the histogram, or both to estimate the cardinality of a predicate. Up-to-date statistics are required for accurate cardinality estimates. The cardinality estimates are used as an input in estimating the cost of an operator. Therefore, you must have good cardinality estimates to obtain optimal query plans. |
|Table size (number of rows and pages) | The query optimizer uses the histograms and density to calculate the probability that a given predicate is true or false. The final cardinality estimate is calculated by multiplying the probability by the number of rows that the child operator returns. The number of pages in the table or the index is a factor in estimating the IO cost. The table size is used to calculate the cost of a scan, and it's useful when you estimate the number of pages that will be accessed during an index seek.|
|Database options | Several database options can affect optimization. The `AUTO_CREATE_STATISTICS` and `AUTO_UPDATE_STATISTICS` options affect whether the query optimizer will create new statistics or update statistics that are out of date. The Parameterization level affects how the input query is parameterized before the input query is handed to the query optimizer. Parameterization can affect cardinality estimation and can also prevent matching against indexed views and other types of optimizations. The `DATE_CORRELATION_OPTIMIZATION` setting causes the optimizer to search for correlations between columns. This setting affects cardinality and cost estimation.          |

**Environment**

|Option  |Explanation  |
|---------|---------|
|Session SET options   | The `ANSI_NULLS` setting affects whether the `NULL = NULL` expression evaluates as true. Cardinality estimation for outer joins might change depending on the current setting. Additionally, ambiguous expressions might also change. For example, the `col = NULL` expression evaluates differently based on the setting. However, the `col IS NULL` expression always evaluates the same way.|
|Hardware resources   | The cost for sort and hash operators depends on the relative amount of memory that is available to SQL Server. For example, if the size of the data is larger than the cache, the query optimizer knows that the data must always be spooled to disk. However, if the size of the data is much smaller than the cache, the operation is likely to be done in memory. SQL Server also considers different optimizations if the server has more than one processor and if parallelism hasn't been disabled by using a `MAXDOP` hint or the max degree of parallelism configuration option. |

## See also

- [Script objects in SQL Server Management Studio](/sql/ssms/tutorials/scripting-ssms)

- [Data-tier Applications](/sql/relational-databases/data-tier-applications/data-tier-applications)

- [Use PowerShell to Script SQL Database Objects](https://devblogs.microsoft.com/scripting/use-powershell-to-script-sql-database-objects/)

