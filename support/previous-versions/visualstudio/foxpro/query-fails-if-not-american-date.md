---
title: Query fails if date is not AMERICAN date format
description: This article provides resolution for the problem that occurs when you run an ODBC query against Visual FoxPro tables by using the Visual FoxPro ODBC Driver.
ms.date: 09/07/2020
ms.prod-support-area-path: 
ms.prod: visual-studio-family
---
# Visual FoxPro ODBC Driver query fails if the date format is not the AMERICAN date format

This article helps you resolve the problem that occurs when you run an ODBC query against Visual FoxPro tables by using the Visual FoxPro ODBC Driver.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 229854

## Symptoms

When executing an ODBC query against Visual FoxPro tables using the Visual FoxPro ODBC Driver, no records are returned when the WHERE clause includes a date that is not in AMERICAN date format.

## Cause

The Visual FoxPro ODBC Driver only accepts dates in a strict AMERICAN date format.

## Resolution

Convert any dates that are passed in WHERE clause of the SELECT-SQL statement to an AMERICAN date format.

## Status

This behavior is by design.

## More information

The default Visual FoxPro date setting is AMERICAN. Date formats, however, may be set to the following formats:

|Date Setting|Date Format|
|---|---|
|AMERICAN|mm/dd/yy|
|ANSI|yy.mm.dd<br/>|
|BRITISH/FRENCH|dd/mm/yy|
|GERMAN|dd.mm.yy|
|ITALIAN|dd-mm-yy|
|JAPAN|yy/mm/dd|
|TAIWAN|yy/mm/dd|
|USA|mm-dd-yy|
|MDY|mm/dd/yy|
|DMY|dd/mm/yy|
|YMD|yy/mm/dd|
|SHORT|Short date format determined by the Windows Control Panel short date setting.|
|LONG|Long date format determined by the Windows Control Panel long date setting.|
|||

## Steps to Reproduce Behavior

1. Create a program file named *Odbctest.prg*, using the following code:

    ```console
    CLEAR
    DO CASE
        CASE "6.0"$VERSION()
            lcConnStr="DRIVER={Microsoft Visual FoxPro Driver};" + ;
            "Exclusive=No;SourceType=DBF;SourceDB="+HOME(2)+"DATA"
        CASE "5.0"$VERSION()
            lcConnStr="DRIVER={Microsoft Visual FoxPro Driver};" + ;
            "Exclusive=No;SourceType=DBF;SourceDB="+HOME()+"SAMPLES\DATA"
        CASE "3.0"$VERSION()
            lcConnStr="DRIVER={Microsoft Visual FoxPro Driver};" + ;
            "Exclusive=No;SourceType=DBF;SourceDB="+HOME()+"SAMPLES\DATA"
            OTHERWISE && Version is VFP 7.0,8.0, or 9.0
            lcConnStr="DRIVER={Microsoft Visual FoxPro Driver};" + ;
            "Exclusive=No;SourceType=DBF;SourceDB="+HOME(2)+"DATA"
    ENDCASE

    *!* Create An ADO Connection

    oConnection=CREATEOBJECT("ADODB.Connection")
    oConnection.ConnectionString = lcConnStr
    oConnection.CursorLocation = 3
    oConnection.OPEN

    * lcSQL="SELECT * FROM ORDERS WHERE ORDER_DATE < {07/22/93}"
    lcSQL="SELECT * FROM ORDERS WHERE ORDER_DATE < {93/07/22}"*!* Create An ADO recordset
    rs=CREATEOBJECT("ADODB.Recordset")
    rs.activeconnection = oConnection
    rs.CursorLocation = 3
    rs.cursortype = 1
    rs.LockType = 3
    rs.OPEN(lcSQL)
    IF !rs.EOF
        rs.movefirst
        DO WHILE !rs.EOF
            ? rs.FIELDS(0).VALUE
            rs.movenext
        ENDDO
    ENDIF
    rs.CLOSE
    oConnection.CLOSE
    ```

2. Observe that no records are returned or displayed.

3. Comment the following line of code:

    ```sql
    lcSQL="SELECT * FROM ORDERS WHERE ORDER_DATE < {93/07/22}"
    ```

4. Uncomment the following line of code:

    ```sql
    lcSQL="SELECT * FROM ORDERS WHERE ORDER_DATE < {07/22/93}"
    ```

5. Rerun the program and observe that data are returned and displayed on the screen.
