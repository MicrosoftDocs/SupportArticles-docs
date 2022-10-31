---
title: No result when running a query from different sources
description: Workaround an issue in which a query may not return any data when you run the query in an Access database that joins linked SQL Server tables from different sources or databases.
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
  - Access 2010
search.appverid: MET150
ms.date: 3/31/2022
---
# Results don't appear when you run a query linked SQL Server tables from different sources

_Original KB number:_ &nbsp; 824169

> [!NOTE]
> This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file. Requires basic macro, coding, and interoperability skills.

## Symptoms

When you run a query in a Microsoft Access database that joins linked Microsoft SQL Server tables from different sources or databases, the query may not return any data.

However, when you run a similar query that refers to the linked SQL Server tables from the same source or database, this problem does not occur.

## Workaround

To work around this problem, use one of the following methods:

### Rewrite the query

You can rewrite the Microsoft Access query to use the join criteria with the LIKE keyword. You can use the LIKE operator to compare one field to the other field in the linked tables from different databases instead of using ANSI JOIN.

For example, if the original query is the following, where dbo_db1_table1 is linked from the SQL Server database DB1 and dbo_db2_table1, dbo_db2_table2 are linked from the SQL Server database DB2:

```sql
SELECT 
dbo_db1_table1.db1_table1_col1, 
dbo_db2_table1.db2_table1_col1, 
dbo_db2_table2.db2_table2_col1
FROM 
(
dbo_db1_table1 INNER JOIN dbo_db2_table1 
ON
dbo_db1_table1.db1_table1_col2 = dbo_db2_table1.db2_table1_col2
) INNER JOIN dbo_db2_table2 
ON 
dbo_db2_table1.db2_table1_col3 = dbo_db2_table2.db2_table2_col3;
```

rephrase the query as the following:

```sql
SELECT 
dbo_db1_table1.db1_table1_col1, 
dbo_db2_table1.db2_table1_col1, 
dbo_db2_table2.db2_table2_col1
FROM 
dbo_db1_table1, 
dbo_db2_table1 INNER JOIN dbo_db2_table2 
ON 
dbo_db2_table1.db2_table1_col3 = dbo_db2_table2.db2_table2_col3;
WHERE 
(((dbo_db1_table1.db1_table1_col2 LIKE dbo_db2_table1.db2_table1_col2));
```

> [!NOTE]
> Here, both ANSI JOIN and NON ANSI JOIN syntax appear in the same query.

### Use an Access database project

To avoid the problem that is mentioned in the "Symptoms" section of this article, use a Microsoft Access database project instead of a Microsoft Access database. Link the appropriate SQL Server tables in the Microsoft Access database project, and then create a stored procedure to include the following query (where dbo_db1_table1 is linked from the SQL Server database DB1 and dbo_db2_table1, dbo_db2_table2 are linked from the SQL Server database DB2):

```sql
SELECT 
dbo_db1_table1.db1_table1_col1, 
dbo_db2_table1.db2_table1_col1, 
dbo_db2_table2.db2_table2_col1
FROM 
(
dbo_db1_table1 INNER JOIN dbo_db2_table1 
ON
dbo_db1_table1.db1_table1_col2 = dbo_db2_table1.db2_table1_col2
) INNER JOIN dbo_db2_table2 
ON 
dbo_db2_table1.db2_table1_col3 = dbo_db2_table2.db2_table2_col3;
```

The result set will appear when you run this stored procedure.

### Import the SQL Server tables

To avoid the problem that is mentioned in the "Symptoms" section of this article, import the SQL Server tables to the Microsoft Access database instead of linking the SQL Server tables to the Access database.

> [!NOTE]
> If you import the SQL Server tables to the Access database, you cannot use the latest data in the imported table because the imported table contains the snapshot of the data at the time you import the table.

## More Information

You can filter the data in Microsoft Access by using the JOIN keyword in the queries. The JOIN keyword is classified as ANSI JOIN and NON ANSI JOIN. ANSI JOIN uses JOIN and ON keywords in the query. NON ANSI JOIN uses a WHERE clause in the query.

NON ANSI JOIN was used more frequently before the evolution of ANSI 92 SQL and was upsized to ANSI JOIN. Microsoft recommends that you use ANSI JOIN in your queries to filter the data.

## References

For more information about how to run the Upsizing Wizard, click **Microsoft Office Access Help** on the **Help** menu, type *Upsizing Wizard* in the **Search for** box in the Assistance pane, and then click **Start searching** to view the topic.
