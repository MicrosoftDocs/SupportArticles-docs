---
title: Sample user-defined function to hide formula errors
description: Provides information about a sample user-defined function that will hide formula errors in Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
search.appverid: 
  - MET150
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Excel 2007
  - Excel 2003
  - Excel 2002
  - Excel 2000
  - Excel 97
ms.date: 03/31/2022
---

# Sample user-defined function to hide formula errors in Excel

## Summary

Some formulas in Microsoft Excel return error values under certain conditions. For example, when you use a division formula that multiplies a number by zero, you receive the following error value:

**#DIV/0!**

Using the sample formula "=100/0", you can work around this behavior by hiding the error value. To do this, modify the formula as follows:

```excel
=IF(ISERROR(100/0),"",100/0)
```

> [!NOTE]
> The preceding formula works, but with longer formulas it can become cumbersome.

With the user-defined function that is provided in this article, the workaround formula is as follows:

```excel
=IFERROR(100/0,"")
```

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. 

### How to create the sample function

1. In Excel, open the Microsoft Visual Basic Editor.

    To do this in Microsoft Office Excel 2003 and in earlier versions of Excel, point to Macro on the Tools menu, and then click Visual Basic Editor. Alternatively, press ALT+F11.

    To do this in Microsoft Office Excel 2007, click the **Developer** tab, and then click
    **Visual Basic** in the **Code** group. Alternatively, press ALT + F11. 

    > [!NOTE]
    > To show the **Developer** tab in the Ribbon, click the
    **Microsoft Office Button**, click **Excel Options**, click the **Popular** category, click to select the **Show Developer tab in the Ribbon** check box, and then click **OK**.  
2. Click Module on the Insert menu, and then type the following macro.

    ```vb
    Function IfError(formula As Variant, show As String)
    
         On Error GoTo ErrorHandler
    
         If IsError(formula) Then
            IfError = show
        Else
            IfError = formula
        End If
    
        Exit Function
    
    ErrorHandler:
        Resume Next
    
    End Function
    ```

3. On the File menu, click **Close and Return to Microsoft Excel**.
4. To use the function, click Insert Function on the Insert menu. In the Insert Function dialog box, click User Defined under Categories, and then click IfError under Select a function. Click OK.
5. Next to Formula, type the formula for which you want to hide the error value. Do not include the equal sign (=).    
6. Next to Show, type what you want to show in place of the error value. If you want to hide the error value, type double quotes ("").
7. Click OK.

For more information about how to use the sample code in this article, see [How to run sample code from Knowledge Base articles in Office 2000](https://support.microsoft.com/help/212536).
