---
title: Create Stored Procedures in Visual FoxPro programs
description: This article describes how to create Stored Procedures in Visual FoxPro Programs.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to
---
# Create Stored Procedures in Visual FoxPro Programs

This article introduces how to create Stored Procedures in Visual FoxPro Programs.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 130304

## Summary

A Visual FoxPro program can create a database by using the CREATE DATABASE command, but the CREATE DATABASE command does not offer a way to create stored procedures. This article describes how a Visual FoxPro program can add stored procedures to a new or existing database.

## More information

To add a stored procedure to an existing table, use the APPEND PROCEDURE command to take a procedure from an existing text file and add it to a database's stored procedure.

### Step-by-Step Example

1. Create a new database, or open an existing one. For example, use the following command to create a database:

    ```sql
     CREATE DATABASE mydata
    ```

2. Create a text file that will contain the desired procedure(s) or open an existing procedure file. The text file should contain procedure code. Here is an example:

    ```sql
     PROCEDURE check_stuff
     IF state <> "WA" or state <>"NC"
     WAIT WINDOW 'Invalid State'
     ENDIF
     ENDPROC
    ```

    The procedure file may contain as many procedures as you want to appear in the database's Stored Procedures.

3. To append the procedure(s) to an existing database's Stored Procedures be sure the database is open, and issue the `APPEND PROCEDURES` command, as in this example:

    ```sql
     OPEN DATABASE mydata EXCLUSIVE
     APPEND PROCEDURE FROM textfile.txt && Replace textfile.txt with the
     && actual name of your text file.
    ```

    > [!NOTE]
    > APPEND PROCEDURES requires that the database be opened exclusively. Also, `APPEND PROCEDURES` may be used to overwrite the existing stored procedures by using the optional OVERWRITE clause, for example:

    ```sql
     APPEND PROCEDURE FROM textfile.txt OVERWRITE
    ```
