---
title: Use Saved property to determine if workbook has changed
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Excel
---

# Use Saved property to determine if a workbook has changed

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

You can determine if changes have been made to a workbook by checking the Saved property of the workbook. The Saved property returns a True or False value depending on whether changes have been made to the workbook. 

> [!NOTE]
> It is possible to set the Saved property to True or False. The "More Information" section of this article contains sample macros that demonstrate the use of the Saved property.

Various conditions in your worksheet, such as the presence of volatile functions, may affect the Saved property.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

### Example 1: Macro to Display Message If Active Workbook Has Unsaved Changes

```vb
Sub TestForUnsavedChanges()
    If ActiveWorkbook.Saved = False Then
        MsgBox "This workbook contains unsaved changes."
    End If
End Sub
```

### Example 2: Macro to Close Workbook and Discard Changes

This macro closes the workbook that contains the sample code and discards any changes to the workbook by setting the Saved property to True:

```vb
Sub CloseWithoutChanges()
    ThisWorkbook.Saved = True
    ThisWorkbook.Close
End Sub
```

### Example 3: Another Macro to Close Workbook and Discard Changes

```vb
Sub CloseWithoutChanges()
    ThisWorkbook.Close SaveChanges:=False
End Sub
```

## References

For more information about how to use the sample code in this article, see [How to run sample code from Knowledge Base articles in Office 2000](https://support.microsoft.com/help/212536).
