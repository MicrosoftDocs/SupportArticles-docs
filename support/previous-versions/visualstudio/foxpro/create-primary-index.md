---
title: Create a Primary Index
description: This article describes how to create a Primary Index in a Visual FoxPro Program.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
ms.prod: visual-studio-family
---
# Create a Primary Index in a Visual FoxPro Program

This article describes how to create a Primary Index in a Visual FoxPro Program.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 130601

## Summary

Visual FoxPro has a new index type, Primary. The Primary index, however, cannot be created in a program by using the `INDEX` command. This article shows how to add or modify a Primary index in a program.

## More information

A Primary index is an index that never permits duplicate values on the specified field or expression. The Primary index may be established in the database container interface or in a program by using the `CREATE TABLE` or `ALTER TABLE` command.

A table with a Primary index must be part of a database and cannot be a free table. The first example shows how to create a table with a Primary index. The second example shows how to alter an existing table to change a Primary key. The third example adds a Primary index to an existing table.

## Example 1 - Create a New Table with a Primary Index

1. Create a new database, or open an existing one.

2. Issue the following command in the Command window to create a table with a Primary index on the cSsn key field:

    ```console
    CREATE TABLE employee (cSsn C(11) PRIMARY KEY, cLast C(20),;
    cFirst C(20))
    ```

## Example 2 - Modify an Existing Table to change a Primary Index

1. Open the database used in example 1.

2. Issue the following command from the Command window to move the Primary index from the cSsn field to the cLast field:

    ```console
    ALTER TABLE employee DROP PRIMARY KEY ADD PRIMARY KEY cLast TAG cLast
    ```

## Example 3 - Modify an Existing Table to add a Primary Index

1. Add a new table to an existing database with this command:

    ```console
    CREATE TABLE noprime (cLast C(20))
    ```

2. From the Command window, add a Primary index to the existing table by using one of the following commands:

    ```console
    ALTER TABLE noprime ADD PRIMARY KEY cLast TAG cLast
    ```

    ```console
    ALTER TABLE noprime ALTER COLUMN cLast C(20) PRIMARY KEY
    ```
