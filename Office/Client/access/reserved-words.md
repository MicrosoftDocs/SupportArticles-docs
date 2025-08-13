---
title: List of reserved words in Access
description: Lists the reserved words that you should not use in field, object, and variable names. 
author: Cloud-Writer
ms.author: lindalu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: markdun, robdil
appliesto: 
  - Microsoft Office Access 2024
  - Microsoft Office Access 2021
  - Microsoft Office Access 2019
  - Microsoft Office Access 2016
search.appverid: MET150
ms.date: 08/12/2025
---
# List of reserved words in Access 2024 and previous versions

_Original KB number:_ &nbsp; 286335

> [!NOTE]
> Novice: Requires knowledge of the user interface on single-user computers. This article applies to a Microsoft Access database (.mdb) and to a Microsoft Access project (.adp).

## Summary

This article lists words and symbols that you should not use in field, object, and variable names in Microsoft Access 2024 and previous versions because they are "reserved words." Reserved words have a specific meaning to Access or to the Microsoft Jet database engine. If you use a reserved word or symbol, you may receive an error such as the following:

> The wizard was unable to preview your report, possibly because a table needed by your report is exclusively locked.

If you use a reserved word, such as date, value, name, text, and year, in Access 2007, you may receive the following message:

> The Name you supplied is a reserved word. Reserved words have a specific meaning to Microsoft Office Access or to the Microsoft Office Access database engine.

For existing objects with names that contain reserved words, you can avoid errors by surrounding the object name with brackets ([ ]).

## Reserved words

Because it isn't practical to provide a list of all reserved words, such as built-in function names or Microsoft Access user-defined names, please check your product documentation for additional reserved words. Note that if you set a reference to a type library, an object library, or an ActiveX control, that library's reserved words are also reserved words in your database. For example, if you add an ActiveX control to a form, a reference is set, and the names of the objects, methods, and properties of that control become reserved words in your database.

Access reserved words are not case-sensitive.

The following is a list of reserved words to avoid when choosing identifiers. 

```console
-A
    ABSOLUTE
    ACTION
    ADD
    ADMINDB
    ALL
    ALPHANUMERIC
    ALTER
    AND
    ANY
    APPLICATION
    ARE
    AS
    ASC
    ASSERTION
    ASSISTANT
    AT
    AUTHORIZATION
    AUTOINCREMENT
    AVG
-B
    BACKUP
    BAND
    BEGIN
    BETWEEN
    BINARY
    BIT
    BIT_LENGTH
    BNOT
    BOOLEAN
    BOR
    BOTH
    BREAK
    BROWSE
    BULK
    BXOR
    BY
    BYTE
-C
    CASCADE
    CASCADED
    CASE
    CAST
    CATALOG
    CHAR
    CHAR_LENGTH
    CHARACTER
    CHARACTER_LENGTH
    CHECK
    CHECKPOINT
    CLOSE
    CLUSTERED
    COALESCE
    COLLATE
    COLLATION
    COLUMN
    COMMIT
    COMP
    COMPACTDATABASE
    COMPRESSION
    CONNECT
    CONNECTION
    CONSTRAINT
    CONSTRAINTS
    CONTAINER
    CONTAINS
    CONTINUE
    CONVERT
    CORRESPONDING
    COUNT
    COUNTER
    CREATE
    CREATEDATABASE
    CREATEDB
    CREATEFIELD
    CREATEGROUP
    CREATEINDEX
    CREATEOBJECT
    CREATEPROPERTY
    CREATERELATION
    CREATETABLEDEF
    CREATEUSER
    CREATEWORKSPACE
    CROSS
    CURRENCY
    CURRENT
    CURRENT_DATE
    CURRENT_TIME
    CURRENT_TIMESTAMP
    CURRENT_USER
    CURSOR
-D
    DATABASE
    DATE
    DATETIME
    DAY
    DBCC
    DEALLOCATE
    DEC
    DECIMAL
    DECLARE
    DEFAULT
    DEFERRABLE
    DEFERRED
    DELETE
    DENY
    DESC
    DESCRIBE
    DESCRIPTION
    DESCRIPTOR
    DIAGNOSTICS
    DISALLOW
    DISCONNECT
    DISK
    DISTINCT
    DISTINCTROW
    DISTRIBUTED
    DOCUMENT
    DOMAIN
    DOUBLE
    DROP
    DUMP
-E
    ECHO
    ELSE
    END
    END-EXEC
    EQV
    ERRLVL
    ERROR
    ESCAPE
    EXCEPT
    EXCEPTION
    EXCLUSIVECONNECT
    EXEC
    EXECUTE
    EXISTS
    EXIT
    EXTERNAL
    EXTRACT    
-F
    FALSE
    FETCH
    FIELD
    FIELDS
    FILLCACHE
    FILLFACTOR
    FIRST
    FLOAT
    FLOAT4
    FLOAT8
    FOR
    FOREIGN
    FORM
    FORMS
    FOUND
    FREETEXT
    FREETEXTTABLE
    FROM
    FULL
    FUNCTION
-G
    GENERAL
    GET
    GETOBJECT
    GETOPTION
    GLOBAL
    GO
    GOTO
    GOTOPAGE
    GRANT
    GROUP
    GROUPBY
    GUID
-H
    HAVING
    HOLDLOCK
    HOUR
-I
    IDENTITY
    IDENTITY_INSERT
    IDENTITYCOL
    IDLE
    IEEEDOUBLE
    IEEESINGLE
    IF
    IGNORE
    IMAGE
    IMMEDIATE
    IMP
    IN
    INDEX
    INDEXES
    INDICATOR
    INHERITABLE
    ININDEX
    INITIALLY
    INNER
    INPUT
    INSENSITIVE
    INSERT
    INSERTTEXT
    INT
    INTEGER
    INTEGER1
    INTEGER2
    INTEGER4
    INTERSECT
    INTERVAL
    INTO
    IS
    ISOLATION
-J
    JOIN
-K
    KEY
    KILL
-L
    LANGUAGE
    LAST
    LASTMODIFIED
    LEADING
    LEFT
    LEVEL
    LIKE
    LINENO
    LOAD
    LOCAL
    LOGICAL
    LOGICAL1
    LONG
    LONGBINARY
    LONGCHAR
    LONGTEXT
    LOWER
-M
    MACRO
    MATCH
    MAX
    MEMO
    MERGE
    MIN
    MINUTE
    MOD
    MODULE
    MONEY
    MONTH
    MOVE
-N
    NAME
    NAMES
    NATIONAL
    NATURAL
    NCHAR
    NEWPASSWORD
    NEXT
    NO
    NOCHECK
    NONCLUSTERED
    NOT
    NOTE
    NULL
    NULLIF
    NUMBER
    NUMERIC
-O
    OBJECT
    OCTET_LENGTH
    OF
    OFF
    OFFSET
    OFFSETS
    OLEOBJECT
    ON
    ONONLY
    OPEN
    OPENRECORDSET
    OPENDATASOURCE
    OPENQUERY
    OPENROWSET
    OPENXML
    OPTION
    OR
    ORDER
    ORIENTATION
    OUTER
    OUTPUT
    OVERLAPS
    OWNERACCESS
-P
    PAD
    PARAMETER
    PARAMETERS
    PARTIAL
    PASSWORD
    PERCENT
    PIVOT
    PLAN
    POSITION
    PRECISION
    PREPARE
    PRESERVE
    PRIMARY
    PRINT
    PRIOR
    PRIVILEGES
    PROC
    PROCEDURE
    PROPERTY
    PUBLIC
-Q
    QUERIES
    QUERY
    QUIT
-R
    RAISERROR
    READ
    READPAST
    READTEXT
    REAL
    RECALC
    RECONFIGURE
    RECORDSET
    REFERENCES
    REFRESH
    REFRESHLINK
    REGISTERDATABASE
    RELATION
    RELATIVE
    REPAINT
    REPAIRDATABASE
    REPORT
    REPORTS
    REQUERY
    RESTORE
    RESTRICT
    RETURN
    REVOKE
    RIGHT
    ROLLBACK
    ROWCOUNT
    ROWGUIDCOL
    ROWS
    RULE
-S
    SAVE
    SCHEMA
    SCREEN
    SCROLL
    SECOND
    SECTION
    SECURITYAUDIT
    SELECT
    SELECTSCHEMA
    SELECTSECURITY
    SESSION
    SESSION_USER
    SET
    SETFOCUS
    SETOPTION
    SETUSER
    SHORT
    SHUTDOWN
    SINGLE
    SIZE
    SMALLINT
    SOME
    SPACE
    SQL
    SQLCODE
    SQLERROR
    SQLSTATE
    STATISTICS
    STDEV
    STDEVP
    STRING
    SUBSTRING
    SUM
    SYSTEM_USER
-T
    TABLE
    TABLEDEF
    TABLEDEFS
    TABLEID
    TABLESAMPLE
    TEMPORARY
    TEXT
    TEXTSIZE
    THEN
    TIME
    TIMESTAMP
    TIMEZONE_HOUR
    TIMEZONE_MINUTE
    TO
    TOP
    TRAILING
    TRAN
    TRANSACTION
    TRANSFORM
    TRANSLATE
    TRANSLATION
    TRIGGER
    TRIM
    TRUE
    TRUNCATE
    TSEQUAL
    TYPE
-U
    UNION
    UNIQUE
    UNIQUEIDENTIFIER
    UNKNOWN
    UNPIVOT
    UPDATE
    UPDATEIDENTITY
    UPDATEOWNER
    UPDATESECURITY
    UPDATETEXT
    UPPER
    USAGE
    USE
    USER
    USING
-V
    VALUE
    VALUES
    VAR
    VARP
    VARBINARY
    VARCHAR
    VARYING
    VERSION
    VIEW
-W
    WAITFOR
    WHEN
    WHENEVER
    WHERE
    WHILE
    WITH
    WORK
    WORKSPACE
    WRITE
    WRITETEXT
-X
    XOR
-Y
    YEAR
    YES
    YESNO
-Z
    ZONE

```

## Reserved symbols

The following symbols must not be used as part of a field name or object name.

```console
.
/
*
;
:
!
#
&
-
?
"
'
$
%
```

For more information about special characters to avoid using when you work with the database object names or the field names in all versions of Access, see the following Microsoft Knowledge Base article.

[826763](https://support.microsoft.com/help/826763) Special characters you must avoid when you work with Access databases
