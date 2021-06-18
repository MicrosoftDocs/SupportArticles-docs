---
title: Shut down a custom Access application remotely
description: Describes how to gracefully shut down a front-end Access database application remotely. You can also use many of these concepts to compact or to repair the database and to  make backup copies.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
- CI 111294
- CSSTroubleshoot
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: luche
ms.reviewer: JMACLEOD 
appliesto:
- Access 2007
- Access 2003
- Access 2002
---

# How to shut down a custom Access application remotely

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies only to a Microsoft Access database (.mdb or .accdb). 

## Summary

Sometimes, you may have to perform maintenance tasks on a Microsoft Access database, such as compacting or repairing, making backup copies, or making design modifications. Many of these operations require that all users exit the database. However, there is no built in way to force users to quit Microsoft Access. And it is not a good idea to just disconnect the user from Network solutions. That can cause the database to become corrupted.

This article shows you one approach that you can use to gracefully shut down a front-end Access database application. You can also use many of these concepts to compact or repair the database, make backup copies, and so on. 

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. 

## More information

### How the Solution Works

The solution works as follow. On a server, there is a file in a folder. This file can be named anything. For this solution, a file named chkfile.ozx is used. When this file is renamed or deleted, it notifies the front-end Access application that it has to close. 

A form is built that opens when users start the front-end database application. This form checks for the existence of the file on the server at a set interval. It uses the TimerInterval property and the OnTimer event to do this. 

If the file is found, nothing happens. If the file is not found, the form will display another form to warn the user that the database will be automatically closed in a specified amount of time. 

> [!NOTE]
> This solution does not use the MsgBox function to warn the user. The MsgBox function will wait for user input before it runs any code. This would defeat the purpose of the solution. 

To gracefully close client sessions, this solution renames the file that is being checked. When everything that has to be accomplished is finished, this solution renames the file back to the original name. This lets the users know that they can start the front-end database again. 

This process can also be automated to provide unattended operation by using a scheduled service on the server that renames chkfile.ozx at specified times.

### Steps to Create a Sample Scenario

To demonstrate how this solution works, you will have to have the following: 

- A folder on your hard disk with a path of C:\MyData.   
- An empty file. This solution will check for the presence of this file.   
- A split database design with the tables in a back-end database file and links to that table in the front-end database. The front-end database will contain the code that checks for the existence of the file at a set interval, and then warns the user.   

#### Creating the folder for the sample application

Create a folder in the root directory of drive C, and name it MyData.

#### Creating the empty text file

1. Create a new text file in the MyData folder, and name it chkfile.txt.   
2. Rename the text file so that it has an extension of ozx (chkfile.ozx). When you are prompted, confirm that you want to change the file extension.   

#### Creating the back-end database

1. Create a new database in the C:\MyData folder, and name it Northwind_Be.mdb.   
2. Import the Customers table from the Northwind sample database into the Northwind_Be.mdb database. (By default, Northwind is located in the C:\Program Files\Microsoft Office\Office10\Samples.)   
3. Close the database.   

#### Creating the front-end database

1. Create another new database, and name it
 Northwind_Fe.mdb.   
2. Link the Customers table from the Northwind_Be.mdb database into the new Northwind_Fe.mdb   
3. Create an AutoForm based on the linked Customers table and save it as frmCustomers. Close this form.   

#### Creating the form with code that checks for the existence of the file

1. Create an unbound form, and save it with the name
 frmAppShutDown. In a production database, this form would normally always be open but not visible. For this sample, it can be left open as usual.   
2. Set the TimerInterval property of the form to 60000 milliseconds. This is equal to one minute. (For your own solution, you can increase or decease this time interval.)   
3. In Microsoft Office Access 2003 or in earlier versions of Access, in Design view of the frmAppShutDown form, click **Code** on the **View** menu. In Microsoft Office Access 2007, in Design view of the frmAppShutDown form, click the **Design** tab, and then click **View Code** in the **Tools** group. Type or paste the following code:

```vb
Option Explicit
Dim boolCountDown As Boolean
Dim intCountDownMinutes As Integer

Private Sub Form_Open(Cancel As Integer)
    ' Set Count Down variable to false
    ' on the initial opening of the form.
    boolCountDown = False
End Sub

Private Sub Form_Timer()
On Error GoTo Err_Form_Timer
    Dim strFileName As String
    strFileName = Dir("c:\MyData\chkfile.ozx")
    If boolCountDown = False Then
        ' Do nothing unless the check file is missing.
        If strFileName <> "chkfile.ozx" Then
            ' The check file is not found so 
            ' set the count down variable to true and
            ' number of minutes until this session
            ' of Access will be shut down.
            boolCountDown = True
            intCountDownMinutes = 2
        End If
    Else
        ' Count down variable is true so warn
        ' the user that the application will be shut down
        ' in X number of minutes.  The number of minutes
        ' will be 1 less than the initial value of the
        ' intCountDownMinutes variable because the form timer
        ' event is set to fire every 60 seconds
        intCountDownMinutes = intCountDownMinutes - 1
        DoCmd.OpenForm "frmAppShutDownWarn"
        Forms!frmAppShutDownWarn!txtWarning = "This application will be shut down in approximately " & intCountDownMinutes & " minute(s).  Please save all work."
        If intCountDownMinutes < 1 Then
            ' Shut down Access if the countdown is zero,
            ' saving all work by default.
            Application.Quit acQuitSaveAll
        End If
    End If

Exit_Form_Timer:
    Exit Sub

Err_Form_Timer:
    Resume Next
End Sub

```

4. Save and then close the form.

#### Creating the form that will serve to warn the user

> [!NOTE]
> Do not use the MsgBox function to warn the user. The MsgBox function will wait for user input before it runs any code. This would defeat the purpose of the solution.

1. Create an unbound form, and name it frmAppShutDownWarn. Add the following text box control:
   ```adoc
   Name: txtWarning
   Type: Textbox
   ```

2. Save and close the form.   
3. Create a macro that will open the frmCustomer form and the frmAppShutDown form at startup. Name the macro autoexec.   
4. Close and reopen the database.   
5. Rename chkfile.ozx to chkfile.old.   

### Timing of Solution Events

> [!NOTE]
> All of the following times are approximate, and they start after the renaming of chkfile.ozx.
> - One minute or less: Northwind_FE.mdb will notice that the file being checked is missing.   
> - Two minutes: A form will be opened in Northwind_FE.mdb, notifying you that the database will close in one minute.   
> - Three minutes: Northwind_FE.mdb will automatically close, and save all work.