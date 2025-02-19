---
title: VBScript type mismatch error
description: Describes a problem that when using VBScript to perform a numeric comparison or calculation on an adNumeric (131) field type, type mismatch error occurs.
ms.date: 04/13/2020
ms.reviewer: estraley, jayapst
ms.custom: sap:Language or Compilers\Visual Basic .NET (VB.NET)
---
# VBScript runtime error (Type Mismatch) when you perform a numeric comparison on an adNumeric field type

This article helps you to resolve an error (type mismatch) that occurs when you use Visual Basic Scripting Edition (VBScript) to perform a numeric comparison or calculation on an `adNumeric` (131) field type.

_Original product version:_ &nbsp; Visual Basic Script  
_Original KB number:_ &nbsp; 306916

## Symptoms

When you use VBScript to perform a numeric comparison or calculation on an `adNumeric` (131) field type, you may receive the following error messages:

- Error message 1

    > Microsoft VBScript runtime error '800a000d'  
    > Type mismatch

- Error message 2

    > Microsoft VBScript runtime error '800a01ca'  
    > Variable uses an Automation type not supported in VBScript

## Cause

These error messages occur because VBScript cannot properly convert `adNumeric` values to a valid numeric type. This behavior is by design.

## Resolution

You can use one of the following two possible workarounds:

- Use the `CDbl` or `CInt` function to convert the `adNumeric` field.
- Use JScript, which does not exhibit this behavior.

You can reproduce this behavior in an Active Server Pages (ASP) page or through a simple Visual Basic Script (.vbs) file. The following steps demonstrate how to reproduce the problem in a simple .vbs file.

## Step 1 to reproduce the behavior: Create the Oracle table

Run the following script on your Oracle server to create the sample table:

```sql
DROP TABLE Cust;
CREATE TABLE Cust (CustID NUMBER(22,6) PRIMARY KEY, Name VARCHAR2(50));
INSERT INTO Cust VALUES(222,'Kent');
INSERT INTO Cust VALUES(333,'Sally');
COMMIT;
```

## Step 2 to reproduce the behavior: Create the VBS file

1. In Notepad, create a new text document named *Test.vbs*, and paste the following code into test.

    ```vbs
    Set oConn = CreateObject("ADODB.Connection")
    oConn.open "Provider=MSDAORA;user id=User;" & _
    "password=password;data source=Oracle816Server;"

    set oRS = oConn.Execute("Select CustID FROM Cust")
    MsgBox "Numeric field type is 131." & vbcrlf & _
    "Field Type = " & ors.fields("CustID").type

    MsgBox "Numeric field * 100 = " & oRS("CustID") * 100
    MsgBox "Numeric field * 100 = " & cdbl(oRS("Custid")) * 100
    ```

2. Modify the connection string so it points to your Oracle server and provides a valid user name and password.

3. Save *Test.vbs* to your desktop. You should receive a warning that changing the extension may make the file unstable. Click **OK** to continue. If you do not see this warning, you may want to ensure that you are showing extensions for known file types.

4. Close *Test.vbs*.
5. On your desktop, double-click *Test.vbs* to run the code. You receive the **Type Mismatch** error message.

6. Uncomment the following line of code, which converts the `adNumeric` field to a double data type:

    ```vbs
    MsgBox "Numeric field * 100 = " & cdbl(oRS("Custid")) * 100
    ```

7. Comment the following line of code:

    ```vbs
    MsgBox "Numeric field * 100 = " & oRS("CustID") * 100
    ```

8. Close and save *Test.vbs*.
9. On your desktop, double-click *Test.vbs* to run the code again, then you receive two message boxes and no error messages.
