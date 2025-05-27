---
title: Can't perform an operation on a table
description: Describes three methods that you can use to solve the insufficient disk space problem or the insufficient memory problem. You must have knowledge of Registry Editor and also be familiar with the Visual Basic .NET.
author: helenclu
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: SHAYDEN
appliesto: 
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 05/26/2025
---

# "There isn't enough disk space or memory" error when you perform an operation on an Access table

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies only to a Microsoft Access database (.mdb).

## Symptoms

When you perform an operation on a table, you may receive the following error message if the operation creates a large number of page locks:  There isn't enough disk space or memory.

If you run an action query on a large table, you may receive the following error message:  There isn't enough disk space or memory to undo the data changes this action query is about to make.

## Cause

The page locks required for the transaction exceed the MaxLocksPerFile value, which defaults to 9500 locks. The MaxLocksPerFilesetting is stored in the Windows registry.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

There are several ways to work around this problem:

- You can use Regedit.exe to edit the registry and change the
MaxLocksPerFilevalue permanently.   
- You can use the SetOptionmethod of the DBEngine object to change the MaxLocksPerFilevalue temporarily in code.   
- If the error occurs when you run an action query, you can modify the query and set its UseTransactionproperty to No.   

### Method 1: Changing MaxLocksPerFile in the registry

Use Registry Editor to increase the MaxLocksPerFile value under the following key:

For Microsoft Access 2000, in Microsoft Access 2002, and in Microsoft Office Access 2003 that are running on a 32-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Jet\4.0\Engines\Jet 4.0**

For Microsoft Access 2000, in Microsoft Access 2002, and in Microsoft Office Access 2003 that are running on a 64-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Jet\4.0\Engines\Jet 4.0**

For Microsoft Office Access 2007 that is running on a 32-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\12.0\Access Connectivity Engine\Engines\ACE**

For Microsoft Office Access 2007 that is running on a 64-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\12.0\Access Connectivity Engine\Engines\ACE**

For Microsoft Access 2010 that is running on a 32-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\14.0\Access Connectivity Engine\Engines\ACE**

For Microsoft Office Access 2010 that is running on a 64-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\Access Connectivity Engine\Engines\ACE**

For Microsoft Access 2013 that is running on a 32-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\15.0\Access Connectivity Engine\Engines\ACE**

For Microsoft Office Access 2013 that is running on a 64-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Access Connectivity Engine\Engines\ACE**

For Microsoft Access 2016 that is running on a 32-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Access Connectivity Engine\Engines\ACE**

For Microsoft Office Access 2016 that is running on a 64-bit Windows operating system:

**HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Access Connectivity Engine\Engines\ACE**

**Note** that this method changes the registry setting for all applications that use Microsoft Jet database engine version 4.0.

### Method 2: Using SetOption to change MaxLocksPerFile Temporarily

> [!NOTE]
> The sample code in this article uses Microsoft Data Access Objects. For this code to run properly, you must reference the Microsoft DAO 3.6 Object Library. To do so, select References on the Tools menu in the Visual Basic Editor, and make sure that the Microsoft DAO 3.6 Object Library check box is selected.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements. The `SetOption` method temporarily overrides values for the Microsoft Jet database engine keys in the registry. The new value remains in effect until you change it again, or until the DBEngine object is closed.

> [!NOTE]
> Changes made to the MaxLocksPerFilesetting by using the `SetOption` method is only available through the current session of Data Access Objects (DAO). Queries that are run through the Microsoft Access user interface still use the settings in the registry.

The following code sample sets MaxLocksPerFile to 200,000 before executing an update operation inside a transaction:

```vb
Sub LargeUpdate()
   On Error GoTo LargeUpdate_Error
   Dim db As DAO.Database, ws As DAO.Workspace

' Set MaxLocksPerFile.
   DBEngine.SetOption dbMaxLocksPerFile, 200000

Set db = CurrentDb
   Set ws = Workspaces(0)

' Perform the update.
   ws.BeginTrans
   db.Execute "UPDATE BigTable SET Field1 = 'Updated Field'", _
         dbFailOnError

ws.CommitTrans

db.Close
   MsgBox "Done!"
   Exit Sub

LargeUpdate_Error:
   MsgBox Err & " " & Error
   ws.Rollback
   MsgBox "Operation Failed - Update Canceled"
   End Sub

```

### Method 3: Setting the UseTransaction property in an action query

If a stored action query causes the error, you can set its `UseTransaction` property to **No**. 

**Note**: If you do so, you can't roll back your changes if there's a problem or an error while the query is running.

1. Open the query in Design view.   
2. On the View menu, select Properties.   
3. Select an empty space in the upper half of the query window to display the Query Properties dialog box.   
4. Set the UseTransactionproperty to No.   
5. Save the query and close it.   

## More information

The `MaxLocksPerFilesetting` in the registry prevents transactions in the Microsoft Jet database engine from exceeding a specified value. If a transaction tries to create locks in excess of the MaxLocksPerFile value, the transaction is split into two or more parts and partially committed.

### Steps to reproduce the problem

The following example uses a Visual Basic procedure to create a table with 10,000 records in it, and then modifies the table in order to cause the error message:

1. Open the sample database Northwind.mdb.   
2. Create a module, and then type the following procedure:

```vb
Sub CreateBigTable()
   Dim db As Database, rs As Recordset
   Dim iCounter As Integer, strChar As String
   Set db = CurrentDb
   db.Execute "CREATE TABLE BigTable (ID LONG, Field1 TEXT(255), " & _
     "Field2 TEXT(255), Field3 TEXT(255), Field4 TEXT(255))", _
     dbFailOnError
   Set rs = db.OpenRecordset("BigTable", dbOpenDynaset)
   iCounter = 0
   strChar = String(255, " ")
   While iCounter <= 10000
      rs.AddNew
      rs!ID = iCounter
      rs!Field1 = strChar
      rs!Field2 = strChar
      rs!Field3 = strChar
      rs!Field4 = strChar
      rs.Update
      iCounter = iCounter + 1
   Wend
   MsgBox "Done!"
End Sub

```

3. To run the procedure, type the following line in the Immediate window, and then press ENTER: 

    ```vb
    CreateBigTable
    ```

   The procedure creates a table called BigTable with 10,000 records in it.   
4. Save the module as Module1, and then close it.   
5. Open the BigTable table in Design view.   
6. Change the FieldSizeproperty of Field4 to 253.   
7. Save the table. Click Yes when you are prompted that some data may be lost. 

   Note that, after a while, you receive the following error messages:
   
   ```adoc
   Microsoft Access can't change the data type.
   There isn't enough disk space or memory.  
   ```

   ```adoc
   Errors were encountered during the save operation. Data types were not changed. Properties were not updated.
   ```
