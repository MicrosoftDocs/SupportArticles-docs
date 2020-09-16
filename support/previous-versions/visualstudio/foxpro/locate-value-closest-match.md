---
title: Locate a value or closest match
description: This article describes how to locate a value or closest match in a Visual FoxPro table from VB .NET using the VFP OLE DB Provider.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: article
ms.prod: visual-studio-family
---
# Locate a value or closest match in a Visual FoxPro table from VB .NET using the VFP OLE DB Provider

This article describes how to locate a value or closest match in a Visual FoxPro table from VB .NET using the VFP OLE DB Provider.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 956277

## RAPID PUBLISHING

RAPID PUBLISHING ARTICLES PROVIDE INFORMATION DIRECTLY FROM WITHIN THE MICROSOFT SUPPORT ORGANIZATION. THE INFORMATION CONTAINED HEREIN IS CREATED IN RESPONSE TO EMERGING OR UNIQUE TOPICS, OR IS INTENDED SUPPLEMENT OTHER KNOWLEDGE BASE INFORMATION.

## Action

You have a Visual FoxPro (VFP) table you are accessing from Visual Basic .NET via the VFP OLE DB Provider. You wish to locate a particular value in a column, or the nearest match.

## Resolution

The VFP SET NEAR command controls what happens to the record pointer in a VFP table after an unsuccessful SEEK (or FIND) operation (SEEK uses an index on a VFP column to locate a value). When NEAR is on, the record pointer in the VFP table is positioned at the closest matching record after an unsuccessful SEEK.

The following VB .NET code demonstrates how to SEEK a record or the closest match thereto via the VFP OLE DB Provider. To use this code...

1. Create a sample VFP table and index using the following VFP code:

    ```console
    CLOSE DATA ALL
    DELETE FILE C:\CUSTS.DBF RECYCLE
    DELETE FILE C:\CUSTS.CDX RECYCLE
    CREATE TABLE C:\CUSTS (NAMES VarChar(30))
    INDEX ON UPPER(NAMES) TAG NAMES
    INSERT INTO CUSTS VALUES('FRED')
    INSERT INTO CUSTS VALUES('JOHN')
    INSERT INTO CUSTS VALUES('MARY')
    CLOSE DATA ALL
    ```

2. Create a new Visual Studio VB .NET Windows application. Drop a TextBox, a CheckBox, and a Button on the form.

3. Double-click the form surface to open the code editor (form1.vb) and then paste the code below into it, replacing the current contents.

The code does the following:

- Sets near ON/OFF depending on the state of the CheckBox on the VB form (checked = ON).
- Opens the free VFP table (C:\CUSTS) and SEEKs the customer name.
- In the VFP OLE DB Provider, creates a cursor to be returned to the .NET session.
- Populates the return cursor with the values of `FOUND()`, `RECNO('CUSTS')` and `RECCOUNT('CUSTS')`.
- Uses the VFP `SETRESULTSET()` function to return the VFP cursor to .NET.
- VB .NET uses a `OleDbDataReader` object to read the returned cursor and display the results of the SEEK in an `MSGBOX`.

> [!NOTE]
>
> - When the VFP SEEK finds an exact match, `FOUND()` (first column in the result set) is True. Other columns can be ignored.
>
> - When the VFP SEEK *does not* find an exact match and NEAR is ON, `FOUND()` (first column in the result set) is **False** and `RECNO()` (2nd column in result set) will either be a valid number or will be `RECCOUNT()` (3rd column in result set) +1 (indicating EOF in the VFP table).
>
> - When the VFP SEEK *does not* find an exact match and NEAR is **OFF**, `FOUND()` will be .F., RECNO() will be RECCOUNT() + 1.
>
> - Third column in result set is constant: `RECCOUNT('CUSTS')`. Use this to determine if you are on the nearest record when NEAR is on (i.e, column 2 is *not* column 3 +1).

```vb
Imports System.Data.OleDb
Imports System.Text

Public Class Form1
    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        TextBox1.Focus()
        TextBox1.Text = "JOHN"
        TextBox1.CharacterCasing = CharacterCasing.Upper
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        FindOperator(TextBox1.Text, CheckBox1.Checked)
        TextBox1.Focus()
    End Sub
    Function FindOperator(ByVal Name2Find As String, ByVal Near As Boolean) As VariantType
        Dim oConn As New OleDbConnection( _"Provider=VFPOLEDB;Data Source=C:\")
        Dim oCmd As New OleDbCommand("", oConn)
        Dim oStrBldr As New StringBuilder
        Dim oReader As OleDbDataReader
        Dim lcNear As String = IIf(Near, "ON", "OFF")

        With oStrBldr
        .Append("EXECS(").Append("[SET NEAR " & lcNear & "] + CHR(13) + ").Append("[USE CUSTS ORDER NAMES SHARED AGAIN IN 0] + CHR(13) + ").Append("[SEEK '" & Name2Find & "' IN CUSTS] + CHR(13) + ").Append("[SELECT 0] + CHR(13) + ").Append("[CREATE CURSOR SeekResults(lFound L, nRecno I, nReccount I)] + CHR(13) + ").Append("[INSERT INTO SeekResults VALUES ( FOUND('CUSTS'), RECNO('CUSTS'), RECCOUNT('CUSTS'))]+ CHR(13) + ").Append("[USE IN SELECT('CUSTS')] + CHR(13) + ").Append("[RETURN SETRESULTSET( 'SeekResults' )]").Append(")")
        oCmd.CommandText = .ToString
        End With

        oConn.Open()
        oReader = oCmd.ExecuteReader()
        While oReader.Read
        MsgBox("Found: " & oReader.GetBoolean(0).ToString & vbCrLf & _
        "RECNO(): " & oReader.GetInt32(1).ToString & vbCrLf & _
        "RECCOUNT(): " & oReader.GetInt32(2).ToString)
        End While

        oConn.Close()
        oConn.Dispose()
        oCmd.Dispose()
        oReader.Close()
    End Function
End Class
```

## More information

For more information about the VFP functions and commands used in this article (SEEK, SET NEAR, RECNO(), RECCOUNT(), SELECT(), SETRESULTSET(), etc.), see [Microsoft Visual FoxPro 9.0 SP2](/previous-versions/visualstudio/foxpro/724fd5h9(v=vs.80)).

The VFP OLE DB Provider is available as a free download and is the preferred way to access VFP data from non-VFP applications. It is available here: [Microsoft OLE DB Provider for Visual FoxPro 9.0](https://www.microsoft.com/download/details.aspx?id=14839).

## DISCLAIMER

MICROSOFT AND/OR ITS SUPPLIERS MAKE NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY, RELIABILITY OR ACCURACY OF THE INFORMATION CONTAINED IN THE DOCUMENTS AND RELATED GRAPHICS PUBLISHED ON THIS WEBSITE (THE "MATERIALS") FOR ANY PURPOSE. THE MATERIALS MAY INCLUDE TECHNICAL INACCURACIES OR TYPOGRAPHICAL ERRORS AND MAY BE REVISED AT ANY TIME WITHOUT NOTICE.

TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, MICROSOFT AND/OR ITS SUPPLIERS DISCLAIM AND EXCLUDE ALL REPRESENTATIONS, WARRANTIES, AND CONDITIONS WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO REPRESENTATIONS, WARRANTIES, OR CONDITIONS OF TITLE, NON INFRINGEMENT, SATISFACTORY CONDITION OR QUALITY, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, WITH RESPECT TO THE MATERIALS.
