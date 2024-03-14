---
title: Use the left, right, mid, and len functions in visual basic for applications
description: Describes how to use the left, right, mid, and len functions in Visual Basic for Applications in Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Excel
ms.date: 03/31/2022
---

# Use the left, right, mid, and len functions in Visual Basic for Applications in Excel

## Summary

This article contains examples of how to manipulate text strings using the Left, Right, Mid, and Len functions in Microsoft Visual Basic for Applications in Microsoft Excel.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

To following procedure demonstrates the use of the Left, Right, Mid, and Len functions of Microsoft Visual Basic for Applications in Microsoft Excel:

1. Create a new, blank Excel workbook.   
2. Open the Visual Basic Editor by pressing ALT+F11.   
3. On the Insert menu, click Module.   
4. Type the following macro in the new module sheet.   

    ```vb
          Sub String_Len()
              ' Sets MyString.
              MyString = InputBox("Enter some text.")
              ' Displays length of string.
              MsgBox Prompt:="The length of the string is " & _
                  Len(MyString) & " characters."
          End Sub
    
          Sub String_Left()
              ' Sets MyString.
              MyString = InputBox("Enter some text.")
              StringLen = Len(MyString)
              Pos = InputBox("Please enter a number from 1 to " & StringLen)
              ' Takes the left number of specified characters.
              Result = Left(MyString, Pos)
              ' Displays the result.
              MsgBox Prompt:="The left " & Pos & " characters of """ & _
                  MyString & """ are: " & _
                  Chr(13) & Result
          End Sub
    
          Sub String_Right()
              ' Sets MyString.
              MyString = InputBox("Enter some text.")
              StringLen = Len(MyString)
              Pos = InputBox("Please enter a number from 1 to " & StringLen)
              ' Takes the right number of specified digits.
              Result = Right(MyString, Pos)
              ' Displays the result.
              MsgBox Prompt:="The right " & Pos & " characters of """ & _
                  MyString & """ are: " & _
                  Chr(13) & Result
          End Sub
    
          Sub String_Mid()
              ' Sets MyString.
              MyString = InputBox("Enter some text.")
              ' Sets starting position.
              StartPos = InputBox _
                  ("Give me a starting position (1 to " _
                  & Len(MyString) & ")")
              ' Determines length of string of text.
              StringLen = Len(MyString) - StartPos + 1
              ' Sets number of characters.
              NumChars = InputBox _
                  ("How many characters would you like? (From 1 to " & _
                  StringLen & ")")
              MsgBox prompt:="The result is: " & _
                  Mid(MyString, StartPos, NumChars)
          End Sub
    
    ```

To see an example of the Left, Right, Mid, and Len functions, use one of the following procedures, as appropriate for the version of Excel that you are running: 

- In Microsoft Office Excel 2007, click the **Developer** tab, click **Macros** in the **Code** group, select the macro for the function that you want, and then click **Run**   
- In Microsoft Office Excel 2003 and in earlier versions of Excel, click **Macros** on the **Tools** menu, select the macro for the function that you want, and then click **Run**.   

## References

For more information about these functions, type the following text on a module sheet:

- Len
- Right
- Left
- Mid

Highlight the function about which you want more information, and then press F1.
