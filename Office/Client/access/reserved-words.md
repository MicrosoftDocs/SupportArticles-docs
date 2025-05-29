---
title: List of reserved words in Access
description: Lists the reserved words that you should not use in field, object, and variable names. It is not practical to provide a list of all reserved words, such as built-in function names or Access user-defined names.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: markdun, robdil
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
  - Microsoft Office Access 2002
search.appverid: MET150
ms.date: 05/26/2025
---
# List of reserved words in Access 2002 and in later versions of Access

_Original KB number:_ &nbsp; 286335

> [!NOTE]
> Novice: Requires knowledge of the user interface on single-user computers. This article applies to a Microsoft Access database (.mdb) and to a Microsoft Access project (.adp).

## Summary

This article lists words and symbols that you should not use in field, object, and variable names in Microsoft Access 2002 and later versions of Access because they are "reserved words." Reserved words have a specific meaning to Access or to the Microsoft Jet database engine. If you use a reserved word or symbol, you may receive an error such as the following:

> The wizard was unable to preview your report, possibly because a table needed by your report is exclusively locked.

If you use a reserved word, such as date, value, name, text, and year, in Access 2007, you may receive the following message:

> The Name you supplied is a reserved word. Reserved words have a specific meaning to Microsoft Office Access or to the Microsoft Office Access database engine.

For existing objects with names that contain reserved words, you can avoid errors by surrounding the object name with brackets ([ ]).

## More Information

Because it is not practical to provide a list of all reserved words, such as built-in function names or Microsoft Access user-defined names, please check your product documentation for additional reserved words. Note that if you set a reference to a type library, an object library, or an ActiveX control, that library's reserved words are also reserved words in your database. For example, if you add an ActiveX control to a form, a reference is set, and the names of the objects, methods, and properties of that control become reserved words in your database.

```console
-A
    ADD
    ALL
    Alphanumeric
    ALTER
    AND
    ANY
    Application
    AS
    ASC
    Assistant
    AUTOINCREMENT
    Avg
-B
    BETWEEN
    BINARY
    BIT
    BOOLEAN
    BY
    BYTE
-C
    CHAR, CHARACTER
    COLUMN
    CompactDatabase
    CONSTRAINT
    Container
    Count
    COUNTER
    CREATE
    CreateDatabase
    CreateField
    CreateGroup
    CreateIndex
    CreateObject
    CreateProperty
    CreateRelation
    CreateTableDef
    CreateUser
    CreateWorkspace
    CURRENCY
    CurrentUser
-D
    DATABASE
    DATE
    DATETIME
    DELETE
    DESC
    Description
    DISALLOW
    DISTINCT
    DISTINCTROW
    Document
    DOUBLE
    DROP
-E
    Echo
    Else
    End
    Eqv
    Error
    EXISTS
    Exit
-F
    FALSE
    Field, Fields
    FillCache
    FLOAT, FLOAT4, FLOAT8
    FOREIGN
    Form, Forms
    FROM
    Full
    FUNCTION
-G
    GENERAL
    GetObject
    GetOption
    GotoPage
    GROUP
    GROUP BY
    GUID
-H
    HAVING
-I
    Idle
    IEEEDOUBLE, IEEESINGLE
    If
    IGNORE
    Imp
    IN
    INDEX
    Index, Indexes
    INNER
    INSERT
    InsertText
    INT, INTEGER, INTEGER1, INTEGER2, INTEGER4
    INTO
    IS
-J
    JOIN
-K
    KEY
-L
    LastModified
    LEFT
    Level
    Like
    LOGICAL, LOGICAL1
    LONG, LONGBINARY, LONGTEXT
-M
    Macro
    Match
    Max, Min, Mod
    MEMO
    Module
    MONEY
    Move
-N
    NAME
    NewPassword
    NO
    Not
    Note
    NULL
    NUMBER, NUMERIC
-O
    Object
    OLEOBJECT
    OFF
    ON
    OpenRecordset
    OPTION
    OR
    ORDER
    Orientation
    Outer
    OWNERACCESS
-P
    Parameter
    PARAMETERS
    Partial
    PERCENT
    PIVOT
    PRIMARY
    PROCEDURE
    Property
-Q
    Queries
    Query
    Quit
-R
    REAL
    Recalc
    Recordset
    REFERENCES
    Refresh
    RefreshLink
    RegisterDatabase
    Relation
    Repaint
    RepairDatabase
    Report
    Reports
    Requery
    RIGHT
-S
    SCREEN
    SECTION
    SELECT
    SET
    SetFocus
    SetOption
    SHORT
    SINGLE
    SMALLINT
    SOME
    SQL
    StDev, StDevP
    STRING
    Sum
-T
    TABLE
    TableDef, TableDefs
    TableID
    TEXT
    TIME, TIMESTAMP
    TOP
    TRANSFORM
    TRUE
    Type
-U
    UNION
    UNIQUE
    UPDATE
    USER
-V
    VALUE
    VALUES
    Var, VarP
    VARBINARY, VARCHAR
    VERSION
-W
    WHERE
    WITH
    Workspace
-X
    Xor
-Y
    Year
    YES
    YESNO
```

For more information about special characters to avoid using when you work with the database object names or the field names in all versions of Access, click the following article number to view the article in the Microsoft Knowledge Base:

[826763](https://support.microsoft.com/help/826763) Special characters that you must avoid when you work with Access databases
