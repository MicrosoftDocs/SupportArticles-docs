---
title: Force a new line in a MsgBox message
description: Describes the method of forcing a new line in the message box. You can use the method in this article. Alternatively, you can use the vbCrLf constant to create multiple lines in a text box on a form or on a data access page.
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
ms.reviewer: SHANONG
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 06/06/2024
---

# How to force a new line in a MsgBox message in Access

Moderate: Requires basic macro, coding, and interoperability skills. 

This article applies to either a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file, and to a Microsoft Access project (.adp) file.

## Summary

If you want to force a new line in a message box, you can include one of the following:

- The Visual Basic for Applications constant for a carriage return and line feed, vbCrLf.   
- The character codes for a carriage return and line feed, Chr(13) & Chr(10).  

For example, if you had the following message:

**NOTICE: This is an Important Message!**

and you wanted the message to be displayed as  

```adoc
NOTICE:
 
This is an Important Message!
```
you would enter the message as a string expression as in either of the following examples: 

- Example Using the Visual Basic for Applications Constant: 

    ```vb
    MsgBox "NOTICE:" & vbCrLf & "This is an Important Message!"
    ```
- Example Using the Character Codes: 
    ```vb
    MsgBox "NOTICE:" & Chr(13) & Chr(10) & "This is an Important Message!"
    ```

 You can also use the vbCrLfconstant to create multiple lines in a text box on a form or on a data access page. 

## References

For more information about character codes, in the Visual Basic Editor, click Microsoft Visual Basic Help on the Help menu, type Chr function in the Office Assistant or the Answer Wizard, and then click Search to view the topic.
