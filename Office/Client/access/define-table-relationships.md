---
title: Define relationships between tables in an Access database
description: Describes table relationships and how to define relationships in a Microsoft Access database.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: kswallow
appliesto: 
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---

# How to define relationships between tables in an Access database

_Original KB number:_ &nbsp; 304466

> [!NOTE]
> Novice: Requires knowledge of the user interface on single-user computers. This article applies only to a Microsoft Access database (.mdb or .accdb).

## Summary

This article describes how to define relationships in a Microsoft Access database. The article includes the following topics:

- What are table relationships?
- Kinds of table relationships
  - One-to-many relationships
  - Many-to-many relationships
  - One-to-one relationships
- How to define relationships between tables
  - How to define a one-to-many or one-to-one relationship
  - How to define a many-to-many relationship
- Referential integrity
- Cascading updates and deletes
- Join types

## What are table relationships?

In a relational database, relationships enable you to prevent redundant data. For example, if you are designing a database that will track information about books, you might have a table named "Titles" that stores information about each book, such as the book's title, date of publication, and publisher. There is also information that you might want to store about the publisher, such as the publisher's telephone number, address, and ZIP Code/Postal Code. If you were to store all this information in the "Titles" table, the publisher's telephone number would be duplicated for each title that the publisher prints.

A better solution is to store the publisher's information only one time, in a separate table that we will call "Publishers." You would then put a pointer in the "Titles" table that references an entry in the "Publishers" table.

To make sure that you data stays synchronized, you can enforce referential integrity between tables. Referential integrity relationships help make sure that information in one table matches information in another. For example, each title in the "Titles" table must be associated with a specific publisher in the "Publishers" table. A title cannot be added to the database for a publisher that does not exist in the database.

Logical relationships in a database enable you to efficiently query data and create reports.

## Kinds of table relationships

A relationship works by matching data in key columns, usually columns (or fields) that have the same name in both tables. In most cases, the relationship connects the primary key, or the unique identifier column for each row, from one table to a field in another table. The column in the other table is known as the "foreign key." For example, if you want to track sales of each book title, you create a relationship between the primary key column (let's call it **title_ID**) in the "Titles" table and a column in the "Sales" table that is named **title_ID**. The **title_ID** column in the "Sales" table is the foreign key.

There are three kinds of relationships between tables. The kind of relationship that is created depends on how the related columns are defined.

### One-to-many relationships

A one-to-many relationship is the most common kind of relationship. In this kind of relationship, a row in table A can have many matching rows in table B. But a row in table B can have only one matching row in table A. For example, the "Publishers" and "Titles" tables have a one-to-many relationship. That is, each publisher produces many titles. But each title comes from only one publisher.

A one-to-many relationship is created if only one of the related columns is a primary key or has a unique constraint.

In the relationship window in Access, the primary key side of a one-to-many relationship is denoted by a number 1. The foreign key side of a relationship is denoted by an infinity symbol.

:::image type="content" source="./media/define-table-relationships/one-to-many-relationships.png" alt-text="Screenshot of an example for one-to-many relationships in the relationships window in Access.":::

#### Many-to-many relationships

In a many-to-many relationship, a row in table A can have many matching rows in table B, and vice versa. You create such a relationship by defining a third table that is called a junction table. The primary key of the junction table consists of the foreign keys from both table A and table B. For example, the "Authors" table and the "Titles" table have a many-to-many relationship that is defined by a one-to-many relationship from each of these tables to the "TitleAuthors" table. The primary key of the "TitleAuthors" table is the combination of the **au_ID** column (the "Authors" table's primary key) and the **title_ID** column (the "Titles" table's primary key).

:::image type="content" source="./media/define-table-relationships/many-to-many-relationships.png" alt-text="Screenshot of an example for many-to-many relationships in the relationships window in Access.":::

#### One-to-one relationships

In a one-to-one relationship, a row in table A can have no more than one matching row in table B, and vice versa. A one-to-one relationship is created if both of the related columns are primary keys or have unique constraints.

This kind of relationship is not common, because most information that is related in this manner would be in one table. You might use a one-to-one relationship to take the following actions:

- Divide a table with many columns.
- Isolate part of a table for security reasons.
- Store data that is short-lived and could be easily deleted by deleting the table.
- Store information that applies only to a subset of the main table.

In Access, the primary key side of a one-to-one relationship is denoted by a key symbol. The foreign key side is also denoted by a key symbol.

## How to define relationships between tables

When you create a relationship between tables, the related fields do not have to have the same names. However, related fields must have the same data type unless the primary key field is an AutoNumber field. You can match an AutoNumber field with a Number field only if theFieldSizeproperty of both of the matching fields is the same. For example, you can match an AutoNumber field and a Number field if theFieldSizeproperty of both fields isLong Integer. Even when both matching fields are Number fields, they must have the sameFieldSizeproperty setting.

### How to define a one-to-many or one-to-one relationship

To create a one-to-many or a one-to-one relationship, follow these steps:

1. Close all tables. You cannot create or change relationships between open tables.
2. In Access 2002 or Access 2003, follow these steps:

   1. Press F11 to switch to the Database window.
   2. On the **Tools** menu, click **Relationships**.
   
   In Access 2007, Access 2010, or Access 2013, click **Relationships** in the **Show/Hide** group on the **Database Tools** tab.
3. If you have not yet defined any relationships in your database, the **Show Table** dialog box is automatically displayed. If you want to add the tables that you want to relate but the **Show Table** dialog box does not appear, click **Show Table** on the **Relationships** menu.
4. Double-click the names of the tables that you want to relate, and then close the **Show Table** dialog box. To create a relationship between a table and itself, add that table two times.
5. Drag the field that you want to relate from one table to the related field in the other table. To drag multiple fields, press Ctrl, click each field, and then drag them.

   In most cases, you drag the primary key field (this field is displayed in bold text) from one table to a similar field (this field frequently has the same name) that is called the foreign key in the other table.
6. The **Edit Relationships** dialog box appears. Make sure that the field names that are displayed in the two columns are correct. You can change the names if it is necessary. 

   Set the relationship options if it is necessary. If you have to have information about a specific item in the **Edit Relationships** dialog box, click the question mark button, and then click the item. (These options will be explained in detail later in this article.)
7. Click **Create** to create the relationship.
8. Repeat steps 4 through 7 for each pair of tables that you want to relate.

   When you close the **Edit Relationships** dialog box, Access asks whether you want to save the layout. Whether you save the layout or do not save the layout, the relationships that you create are saved in the database.

   > [!NOTE]
   > You can create relationships not only in tables but also in queries. However, referential integrity is not enforced with queries.

#### How to define a many-to-many relationship

To create a many-to-many relationship, follow these steps:

1. Create the two tables that will have a many-to-many relationship.
2. Create a third table. This is the junction table. In the junction table, add new fields that have the same definitions as the primary key fields from each table that you created in step 1. In the junction table, the primary key fields function as foreign keys. You can add other fields to the junction table, just as you can to any other table.
3. In the junction table, set the primary key to include the primary key fields from the other two tables. For example, in a "TitleAuthors" junction table, the primary key would be made up of the **OrderID** and **ProductID** fields.

   > [!NOTE]
   > To create a primary key, follow these steps:
   1. Open a table in Design view.
   2. Select the field or fields that you want to define as the primary key. To select one field, click the row selector for the desired field. To select multiple fields, hold down the Ctrl key, and then click the row selector for each field.
   3. In Access 2002 or in Access 2003, click **Primary Key** on the toolbar.

      In Access 2007, click **Primary Key** in the **Tools** group on the **Design** tab.

      > [!NOTE]
      > If you want the order of the fields in a multiple-field primary key to differ from the order of those fields in the table, click Indexes on the toolbar to display the Indexes dialog box, and then reorder the field names for the index named PrimaryKey.
4. Define a one-to-many relationship between each primary table and the junction table.

## Referential integrity

Referential integrity is a system of rules that Access uses to make sure that relationships between records in related tables are valid, and that you do not accidentally delete or change related data. You can set referential integrity when all the following conditions are true:

- The matching field from the primary table is a primary key or has a unique index.
- The related fields have the same data type. There are two exceptions. An **AutoNumber** field can be related to a **Number** field that has a `FieldSize` property setting of Long Integer, and an **AutoNumber** field that has a `FieldSize` property setting of Replication ID can be related to a **Number** field that has a `FieldSize` property setting of Replication ID.
- Both tables belong to the same Access database. If the tables are linked tables, they must be tables in Access format, and you must open the database in which they are stored to set referential integrity. Referential integrity cannot be enforced for linked tables from databases in other formats.

The following rules apply when you use referential integrity:

- You cannot enter a value in the foreign key field of the related table that does not exist in the primary key of the primary table. However, you can enter a Null value in the foreign key. This specifies that the records are unrelated. For example, you cannot have an order that is assigned to a customer who does not exist. However, you can have an order that is assigned to no one by entering a Null value in the **CustomerID** field.
- You cannot delete a record from a primary table if matching records exist in a related table. For example, you cannot delete an employee record from the "Employees" table if there are orders assigned to the employee in the "Orders" table.
- You cannot change a primary key value in the primary table if that record has related records. For example, you cannot change an employee's ID in the "Employees" table if there are orders assigned to that employee in the "Orders" table.

## Cascading updates and deletes

For relationships in which referential integrity is enforced, you can specify whether you want Access to automatically cascade update or cascade delete related records. If you set these options, delete and update operations that would usually be prevented by referential integrity rules are enabled. When you delete records or change primary key values in a primary table, Access makes the necessary changes to related tables to preserve referential integrity.

If you click to select the **Cascade Update Related Fields** check box when you define a relationship, any time that you change the primary key of a record in the primary table, Microsoft Access automatically updates the primary key to the new value in all related records. For example, if you change a customer's ID in the "Customers" table, the **CustomerID** field in the "Orders" table is automatically updated for every one of that customer's orders so that the relationship is not broken. Access cascades updates without displaying any message.

> [!NOTE]
> If the primary key in the primary table is an AutoNumber field, selecting the **Cascade Update Related Fields** check box has no effect because you cannot change the value in an AutoNumber field.

If you select the **Cascade Delete Related Records** check box when you define a relationship, any time that you delete records in the primary table, Access automatically deletes related records in the related table. For example, if you delete a customer record from the "Customers" table, all the customer's orders are automatically deleted from the "Orders" table. (This includes records in the "Order Details" table that are related to the "Orders" records). When you delete records from a form or datasheet when the **Cascade Delete Related Records** check box selected, Access warns you that related records may also be deleted. However, when you delete records by using a delete query, Access automatically deletes the records in related tables without displaying a warning.

## Join types

There are three join types. You can see them in the following screen shot:

:::image type="content" source="./media/define-table-relationships/join-properties.png" alt-text="Screenshot of Join Properties, which shows three join types.":::

Option 1 defines an inner join. An inner join is a join in which records from two tables are combined in a query's results only if values in the joined fields meet a specified condition. In a query, the default join is an inner join that selects records only if values in the joined fields match.

Option 2 defines a left outer join. A left outer join is a join in which all the records from the left side of the LEFT JOIN operation in the query's SQL statement are added to the query's results, even if there are no matching values in the joined field from the table on the right side.

Option 3 defines a right outer join. A right outer join is a join in which all the records from the right side of the RIGHT JOIN operation in the query's SQL statement are added to the query's results, even if there are no matching values in the joined field from the table on the left side.
