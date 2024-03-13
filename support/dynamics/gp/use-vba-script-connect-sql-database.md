---
title: Use a VBA script to connect to a SQL database
description: This article describes how to use a VBA script to connect to a Microsoft SQL database that is used by Microsoft Dynamics GP.
ms.reviewer: 
ms.topic: how-to
ms.date: 03/13/2024
---
# Use a VBA script to connect to a SQL database that is used by Microsoft Dynamics GP

This article describes how to use a VBA script to connect to a Microsoft SQL database that is used by Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 892700

## Introduction

This article describes how to use a Microsoft Visual Basic for Applications (VBA) script to connect to a Microsoft SQL database that is used by Microsoft Dynamics GP 9.0 and by Microsoft Business Solutions - Great Plains 8.0.

## More information

The following VBA script example can be used for the `Description_AfterGotFocus` event in the Microsoft Dynamics GP Account Maintenance window. This script will connect to the Microsoft Dynamics GP sample TWO database and log on as system administrator with a password. After the connection is made, the script creates a recordset of the data that is stored in the GL00105 account index master table. The script will then return the account index value to the **User-Defined1** field in the Account Maintenance window. The script returns this value when you enter a new account or use the **Account Lookup** button.

To use the example script, follow these steps:

1. Open the **Account Maintenance** window in Microsoft Dynamics GP.
2. On the **Tools** menu, click **Customize**, and then click **Add Current Window to Visual Basic**.
3. On the **Tools** menu, click **Customize**, click **Add Fields to Visual Basic**, and then click the **Account Number** field, the **Description** field, and the **User-Defined 1** field.
4. On the **Tools** menu, click **Customize**, and then click **Visual Basic Editor**.
5. In Visual Basic Editor, expand **Great Plains Objects**, and then double-click **AccountMaintenance** to open an **Account Maintenance** code window.
6. Copy the following code, and then paste it into the **Account Maintenance** code window.

    ```vb
    Private Sub Description_AfterGotFocus()
    Dim objRec
    Dim objConn
    Dim cmdString
    
    Set objRec = CreateObject("ADODB.Recordset")
    Set objConn = CreateObject("ADODB.Connection")
    
    objConn.ConnectionString = "Provider=MSDASQL;DSN=GreatPlains;Initial Catalog=TWO;User Id=sa;Password=password"
    objConn.Open
    
    cmdString = "Select ACTINDX from GL00105 where (ACTNUMST='" + Account + "')"
    
    Set objRec = objConn.Execute(cmdString)
    
    If objRec.EOF = True Then
    AccountMaintenance.UserDefined1 = ""
    Else
    AccountMaintenance.UserDefined1 = objRec!ACTINDX
    End If
    objConn.Close
    End Sub
    ```

You can also use the RetrieveGlobals_80.dll file for Microsoft Business Solutions - Great Plains 8.0 to retrieve the same information that this script example retrieves. To obtain the appropriate .dll file, see [MBS CustomerSource Retirement](https://mbs2.microsoft.com/Pages/csretirement.aspx).

A Readme file is included with each version of the .dll file. The Readme file describes how to declare the variables. For example, you can declare the variables in your code and then use the variables in the connection string.
