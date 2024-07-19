---
title: Can't run a query in a database
description: Fixes an issue in which you receive an error message when you run a query in an Access database that uses an aggregate function.
author: helenclu
ms.author: luche
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
ms.date: 06/06/2024
---
# "Cannot group on fields selected with '*'" error when you run a query in Access

_Original KB number:_ &nbsp; 835414

> [!NOTE]
> This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file. Requires basic macro, coding, and interoperability skills.

## Symptoms

You may receive an error message when you run a query in a Microsoft Access database that uses one of the following aggregate functions:

- Sum
- Min
- Max

The error message that you receive is as follow:

> Cannot group on fields selected with '*'.

## Cause

This problem occurs when you use aggregate functions in the query, and you do not set the **Output All Fields** property of the query to **No**.

When you set the **Output All Fields** property of the query to **Yes**, an asterisk (\*) wildcard character that represents all columns of the database table is added to the select clause of the Access query. However, you cannot have an asterisk (\*) wildcard character together with an aggregate function in the select clause of the Access query. Therefore, when you run the Access query, you may receive the error message that is mentioned in the "Symptoms" section.

## Resolution

To resolve this problem, set the **Output All Fields** property of the query to **No**, and then run the Access query that uses an aggregate function. To do this, follow these steps:

1. Start Access.
2. Open the Access database that contains the problem query.
3. In the Database window, click **Queries** under the **Objects** section.

   > [!NOTE]
   > In Access 2007, click the **Queries** group in the left Navigation Pane.

4. Right-click the query that you want to modify, and then click **Design View**.
5. On the **View** menu, click **Properties**.

   > [!NOTE]
   > In Access 2007, click the **Design** tab, and then click **Property Sheet** in the **Tools** group.

6. In the **Query Properties** dialog box, set the value of the **Output All Fields** query property to **No**.

   > [!NOTE]
   > In Access 2007, click the **Stored Procedure** tab in the **Property** dialog box. Make sure that the **Output all columns** option is not selected.

7. On the **Query** menu, click **Run**.

   > [!NOTE]
   > In Access 2007, click the **Design** tab, and then click **Run** in the **Tools** group.

## More Information

You can use the **Output all fields** option to automatically include all the fields from the underlying tables in the results of the final query. You can also use the **Output all fields** option to automatically include all the fields from the queries in the results of the final query. When you do this, you do not have to add all the fields from the underlying tables or all the fields from the queries to the design grid.

To do this in Access 2003 and in earlier versions of Access, follow these steps:

1. Start Access.
2. In the Database window, click **Options** on the **Tools** menu.
3. In the **Options** dialog box, click to select the **Output all fields** check box on the **Tables/Queries** tab.
4. Click **Apply**, and then click **OK**.

In Access 2007, follow these steps:

1. Start Access.
2. Click **Microsoft Office Button**, and then click **Access Options**.
3. Click **Object Designers**.
4. Click to select the **Output all fields** check box under **Query design**, and then click **OK**.

> [!NOTE]
> When you change the **Output all fields** option, this only affects the property setting for new queries that you create. When you change the **Output all fields** option, this does not affect existing queries.

### Steps to reproduce the problem in Access 2003

1. Start Access.
2. Open the Northwind.mdb sample database.
3. Run the Order Subtotals query in the Northwind.mdb sample database to make sure that the Order Subtotals query runs successfully. To do this, follow these steps:

   1. In the Database window, click **Queries** under the **Objects** section.
   2. In the right pane, right-click the Order Subtotals query, and then click **Open**.
   3. On the **File** menu, click **Close**.
   
   Notice that the Order Subtotals query uses theSum() aggregate function.

4. Open the Order Subtotals query in Design view. To do this, follow these steps:

   1. In the Database window, click **Queries** under the **Objects** section.
   2. In the right pane, right-click the Order Subtotals query, and then click **Design View**.

5. Click anywhere in the Query window outside the query grid and outside the field lists.
6. On the **View** menu, click **Properties**.
7. In the **Query Properties** dialog box, set the value of the **Output All Fields** query property to **Yes**.
8. Close the **Query Properties** dialog box.
9. On the **Query** menu, click **Run**.

   When you run the query, you may receive the error message that is mentioned in the "Symptoms" section.
