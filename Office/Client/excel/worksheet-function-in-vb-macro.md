---
title: Use a worksheet function in a Visual Basic macro
description: Describes how to use a built-in worksheet function in a macro.
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

# Using a worksheet function in a Visual Basic macro in Excel

## Summary

You can call most built-in Microsoft Excel worksheet functions directly from a Microsoft Visual Basic for Applications macro. This article describes how to use a built-in worksheet function in a macro.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

### Using a Worksheet Function

You can use most built-in worksheet functions in a macro by calling the function as a method of the Application object or the WorksheetFunction object. For example, to successfully call the ACOS worksheet function, you can use the following line of code in a macro:

```vb
X = WorksheetFunction.Acos(-1)
```

> [!NOTE]
> If you attempt to use a built-in worksheet function without qualifying the function with the Application or WorksheetFunction object, you may receive the following error message:
>
> **Sub or Function Not Defined**

Visual Basic for Applications provides many functions that are equivalent to the built-in worksheet functions in Microsoft Excel. However, not all of the built-in worksheet functions will work with the Application or WorksheetFunction objects. You can't use a built-in worksheet function in a macro by calling the function as a method of the Application object or the WorksheetFunction object if there is an equivalent function in Visual Basic.

## References

For additional information about the worksheet functions that are not supported with the Application or WorksheetFunction objects, see [Not All Worksheet Functions Supported As Methods of Application Object](https://support.microsoft.com/help/213660).
