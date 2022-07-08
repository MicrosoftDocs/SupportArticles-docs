---
title: Enforce or disable startup options in database
description: Explains how to disable the functionality of the SHIFT key that permits you to bypass the startup options. Explains how to enforce the startup options in an Access database. Requires basic macro, coding, and interoperability skills.
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
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
  - Access 2000
ms.date: 3/31/2022
---

# How to enforce or disable the startup options in an Access database

This article applies only to a Microsoft Access project (.adp). 

Moderate: Requires basic macro, coding, and interoperability skills. 

## Summary

This article describes how to disable the functionality of the SHIFT key that permits you to bypass the startup options. This article also describes how to enforce the startup options in a Microsoft Access database project.

## More information

The startup options that are defined for an Access file determine how the file looks and how the file behaves when you open the file. You can set the startup options by using the startup user interface or by using the AutoExec macro. 

To bypass the startup options that are set for the Access database project, hold down the SHIFT key while you open the Access database project. 

Alternatively, to enforce the startup options that are set for the Access database project, disable the functionality of the SHIFT key that permits you to bypass the startup options. To do this, set the AllowBypassKey property to False.

To set the AllowBypassKey property to False, follow these steps.

### Steps for an Access project (.adp)

1. Start Access.   
2. Open an Access database project.   
3. Press ALT + F11 to open the Visual Basic editor.   
4. In the Visual Basic editor, click **Immediate Window** on the **View** menu.   
5. Type the following code or paste the following code in the Immediate window, and then press ENTER.
    ```vb
    CurrentProject.Properties.Add "AllowBypassKey", False
    ```
6. Close the Visual Basic Editor, and then close the Access database project.
7. Open the Access database project. Try to bypass the startup options that are set for the Access database project by holding down the SHIFT key while you open the Access database project.

   The functionality of the SHIFT key that permits you to bypass the startup option is disabled. Although you hold down the SHIFT key to bypass the startup options, the startup options are executed. You cannot bypass the startup options.   

### Steps for an Access database (.mdb or .accdb)

1. Start Access.   
2. Create a new module, and then add the following two functions:
    ```vb
    Function ap_DisableShift()
    'This function disable the shift at startup. This action causes
    'the Autoexec macro and Startup properties to always be executed.
    
    On Error GoTo errDisableShift
    
    Dim db As DAO.Database
    Dim prop as DAO.Property
    Const conPropNotFound = 3270
    
    Set db = CurrentDb()
    
    'This next line disables the shift key on startup.
    db.Properties("AllowByPassKey") = False
    
    'The function is successful.
    Exit Function
    
    errDisableShift:
    'The first part of this error routine creates the "AllowByPassKey
    'property if it does not exist.
    If Err = conPropNotFound Then
    Set prop = db.CreateProperty("AllowByPassKey", _
    dbBoolean, False)
    db.Properties.Append prop
    Resume Next
    Else
    MsgBox "Function 'ap_DisableShift' did not complete successfully."
    Exit Function
    End If
    
    End Function
    
    Function ap_EnableShift()
    'This function enables the SHIFT key at startup. This action causes
    'the Autoexec macro and the Startup properties to be bypassed
    'if the user holds down the SHIFT key when the user opens the database.
    
    On Error GoTo errEnableShift
    
    Dim db as DAO.Database
    Dim prop as DAO.Property
    Const conPropNotFound = 3270
    
    Set db = CurrentDb()
    
    'This next line of code disables the SHIFT key on startup.
    db.Properties("AllowByPassKey") = True
    
    'function successful
    Exit Function
    
    errEnableShift:
    'The first part of this error routine creates the "AllowByPassKey
    'property if it does not exist.
    If Err = conPropNotFound Then
    Set prop = db.CreateProperty("AllowByPassKey", _
    dbBoolean, True)
    db.Properties.Append prop
    Resume Next
    Else
    MsgBox "Function 'ap_DisableShift' did not complete successfully."
    Exit Function
    End If
    
    End Function
    ```

3. In the Visual Basic editor, click **Immediate Window** on the **View** menu.   
4. If you want to disable the SHIFT key, type ap_DisableShift in the **Immediate** window, and then press ENTER. If you want to enable the shift key, type ap_EnableShift in the **Immediate** window, and then press ENTER.   
