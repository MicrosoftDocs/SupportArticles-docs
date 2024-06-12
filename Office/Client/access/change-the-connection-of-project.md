---
title: Change connection of a project programmatically
description: Provides step-by-step information to change the connection of a Microsoft Access Project programmatically. A manual way to change the connection is also included.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: SHARMOR
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# How to programmatically change the connection of an Access project

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies only to a Microsoft Access project (.adp).

## Summary

This article shows you how to programmatically change the connection of a Microsoft Access project (ADP) file. 

## More information

The easiest way to change the connection of an ADP is to do it manually. You can access the current project's connection properties as follows in Access 2002 or in Access 2003: on the File menu, click Connection. The dialog box that appears gives you options to change the server name and security modes, among other properties.

**Note** In Access 2007, follow these steps to open the **Connection** tab of the **Data Link Properties** dialog box:

1. Click the **Microsoft Office Button**, and then click **Access Options**.   
2. On the **Customize** tab, click **All Commands** in the **Choose commands from** list.
3. Click **Connection** in the left pane, click **Add**, and then click **OK**.   
4. Click **Connection** in the **Quick Access Toolbar**.

However, sometimes, you might want to automate the process. You may want users to connect to a different SQL server for a specific section of your application, or you may want to control the connection process upon startup so that you can look for errors and handle them accordingly, perhaps by routing to another server.

The following steps use a function that demonstrates how to change the existing connection of an ADP by using the Access object model. The function returns True if it succeeds and False if it does not succeed. 

1. Start Access, and then open the sample Access project NorthwindCS.adp.   
2. In Access 2002 or in Access 2003, click **Modules** under **Objects** in the Database window, and then click **New** to open a new module.

   In Access 2007, click the down arrow below **Macro** in the **Other** group on the **Create** tab, and then click **Module**.   
3. Add the following code to the new module, and then save the module:
```vb
Function ChangeADPConnection(strServerName As String, strDBName As _
   String, Optional strUN As String, Optional strPW As String) As Boolean
Dim strConnect As String
On Error GoTo EH:
Application.CurrentProject.CloseConnection
'The Provider, Data Source, and Initial Catalog arguments are required.
strConnect = "Provider=SQLOLEDB.1" & _
";Data Source=" & strServerName & _
";Initial Catalog=" & strDBName
If strUN <> "" Then
    strConnect = strConnect & ";user id=" & strUN
    If strPW <> "" Then
        strConnect = strConnect & ";password=" & strPW
    End If
Else  'Try to use integrated security if no username is supplied.
    strConnect = strConnect & ";integrated security=SSPI"
End If
Application.CurrentProject.OpenConnection strConnect
ChangeADPConnection = True
Exit Function
EH:
MsgBox Err.Number & ": " & Err.Description, vbCritical, "Connection Error"
ChangeADPConnection = False
End Function

```

4. In Access 2002 or in Access 2003 click **Forms** under **Objects** in the Database window, click **New**, and then click **OK** to open a new form in Design view.

   In Access 2007, click **Form** on the **Create** tab.   
5. Add a command button to the form.   
6. Set the OnClick property of the command button to the following event procedure:
```vb
Dim bCheckConnection As Boolean
   'You must specify the correct parameters for your following server.
   'username and password parameters are optional.
bCheckConnection=ChangeADPConnection("ServerName","DBName","UserName","PW")
MsgBox bCheckConnection
```

7. Close the Visual Basic environment to return to the form.   
8. Save the form, and then switch the form to Form view.   
9. Click the command button to run the underlying code.

   You will receive a message box that says True if you supplied correct parameters for a connection in step 6.

   -OR-

   If you did not supply the correct parameters, you receive the error message. When you click **OK** to the error message, you get the message box that displays False.
