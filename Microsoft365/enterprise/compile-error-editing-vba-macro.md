---
title: The code in this project must be updated for use on 64-bit systems
description: Describes an issue in which you receive an error message when you edit a VBA macro in an Office 2010 program. Provides a resolution.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Compile error when you edit a VBA macro in the 64-bit version of an Office 2010 program

## Symptoms

Consider the following scenario:

- You write a Microsoft Visual Basic for Applications (VBA) macro code that uses Declare statements.
- Your VBA macro code uses compilation constants. For example, your macro code uses one the following compilation constants:
  - #If VBA7
  -  #If Win64

- You use an #Else block in a conditional block. In the #Else block, you use syntax for a Declare statement designed to run in Microsoft Visual Basic for Applications 6.0.
- You edit the code in a 64-bit version of a Microsoft Office 2010 program.
- You try to change the Declare statement in the #Else block.

In this scenario, you receive the following error message:

```asciidoc
Microsoft Visual Basic for Applications

Compile error:

The code in this project must be updated for use on 64-bit
systems. Please review and update Declare statements and then
mark them with the PtrSafe attribute.
```

> [!NOTE]
> This issue only occurs when you edit the VBA macro. This issue does not occur when you run the macro.

## Resolution

To resolve this issue, ignore the "Compile error" and run the VBA code in the 64-bit version of the Office 2010 program.

## More Information

### Steps to reproduce the problem

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability and/or fitness for a particular purpose. This article assumes that you are familiar with the programming language being demonstrated and the tools used to create and debug procedures. Microsoft support professionals can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific needs.

For more information about the support options that are available and about how to contact Microsoft, visit the following Microsoft Web site:

[https://support.microsoft.com/contactus](https://support.microsoft.com/contactus/)

1. Start the 64-bit version of Microsoft Excel 2010 that is running on a Windows 64-bit operating system.

   > [!NOTE]
   > By default, a new workbook is opened.
1. Press ALT+F11 to start the Visual Basic for Applications 7.0 IDE window.
1. On the **Insert** menu, click **Module**.
1. In the code window that appears, copy and paste the following code:

   ```vb
   #If VBA7 Then
       Private Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal ms As LongPtr)
   #Else
       Private Declare Sub Sleep Lib "kernel32" (ByVal ms as Long)
   #End If
   ```

1. In each Declare statement, manually change the name of any parameter that is passed from "ms" to "millisecs."

When you change the second Declare statement, Visual Basic for Applications 7.0 will report an error that indicates that you have to use PtrSafe. However, the report is incorrect because the line is in a section that only runs in Visual Basic for Applications 6.0. VBA 6.0 does not use PtrSafe. Therefore, you can safely ignore the error message.