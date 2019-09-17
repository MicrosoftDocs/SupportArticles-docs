---
title: How to create a script for the Rules Wizard in Outlook
description: Describes how to create a script for the Rules Wizard in Outlook. When you create a rule, the Outlook Rules Wizard allows you to run a script. It helps you to perform an action on incoming mail which is not supported using the UIs in the Rules Wizard.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
appliesto:
- Microsoft Outlook 2010
- Microsoft Office Outlook 2003
---

# How to create a script for the Rules Wizard in Outlook

## Summary

The Outlook Rules Wizard allows you to "run a script" when you create a specific rule. As a developer, this allows you to perform an action on incoming mail that is not possible using the regular features of the Rules Wizard.

## More Information

> [!IMPORTANT]
> Although the Rules Wizard refers to the custom code as "script," you must create the code in Outlook Visual Basic for Applications, not in Microsoft Visual Basic Scripting Edition (VBScript) or other scripting languages such as Microsoft JScript. Also, Outlook Visual Basic for Applications is not designed to be deployed, so deployment of this custom code requires manual configuration on each user's computer. You cannot create the custom code in an Outlook COM Add-in. For additional information about limitations related to distributing Visual Basic for Applications projects, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[290779](https://support.microsoft.com/help/290779) Description of managing and distributing Outlook 2002 Visual Basic for Applications (VBA) projects

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability and/or fitness for a particular purpose. This article assumes that you are familiar with the programming language being demonstrated and the tools used to create and debug procedures. Microsoft support professionals can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific needs. 

If you have limited programming experience, you may want to contact a Microsoft Certified Partner or Microsoft Advisory Services.

For more information about the support options that are available and about how to contact Microsoft, visit the following Microsoft Web site: [Microsoft Support](https://support.microsoft.com/)

To implement the custom code to process the message, create a subroutine in Visual Basic for Applications. The name of the subroutine does not matter, but it must accept one argument because the Rules Wizard will pass a mail message (MailItem) or meeting request (MeetingItem) to the subroutine. The argument must by of type MailItem or MeetingItem, otherwise the subroutine will not be available in the Rules Wizard. You cannot create one subroutine to handle both types of items by defining the argument to be of type Object. The following Outlook Visual Basic for Applications code illustrates how to create the subroutines:

```vb
Sub CustomMailMessageRule(Item As Outlook.MailItem)
   MsgBox "Mail message arrived: " & Item.Subject
End Sub

Sub CustomMeetingRequestRule(Item As Outlook.MeetingItem)
   MsgBox "Meeting request arrived: " & Item.Subject
End Sub
```

You can put the subroutine in any module, including ThisOutlookSession, but if you move the subroutine to another module or change the subroutine's name, you must modify the rule to point to the updated subroutine.