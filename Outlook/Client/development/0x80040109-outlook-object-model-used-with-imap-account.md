---
title: 0x80040109 when Outlook Object Model is used with IMAP account
description: Fixes an issue that triggers an error message when you use Outlook Object Model to add a UserProperty object to an email message in Outlook 2013.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Office 2013 Service Pack 1
- Outlook 2013
search.appverid: MET150
ms.reviewer: akashb, aruiz, v-six
author: cloud-writer
ms.author: meerak
ms.date: 10/30/2023
---
# 0x80040109 error when Outlook Object Model is used with an IMAP account in Outlook 2013

## Symptoms

When you use the [Outlook object model](/visualstudio/vsto/outlook-object-model-overview) to add a [UserProperty](/office/vba/api/Outlook.UserProperty) object to an email message for an IMAP account in Microsoft Outlook 2013, you receive the following error message:

> Run time error '-2147221239 (80040109)': The operation cannot be performed because the message has been changed.

> [!NOTE]
>
> - This issue occurs only when you run the code in quick succession to add a UserProperty object to the same email message the second time.
> - This issue does not occur when the preview pane is disabled or if you switch between email messages before you run the code for the second time.

## Workaround

To work around this issue, close all items after you run the code to add a UserProperty object to an email message. Or, run the code only one time for the same email message. This issue occurs because editing and saving an email message multiple times for an IMAP account is inefficient. When an email message is saved, it must be uploaded to the server as a completely new email message, and the original email message is deleted. If the preview pane is enabled, the original email message remains in memory, whereas the underlying email message is changed because of the multiple uploads.

To reproduce this issue, follow these steps:

1. Select an email message in the message list.
2. Make sure that the preview pane is enabled.
3. Run the following code for the same email message two times in quick succession:

    ```vb
    Function ReproCode()
    Dim oExp As Outlook.Explorer
    Dim oSel As Outlook.Selection
    Dim oMail As Outlook.MailItem
    Dim oProp As UserProperty
    Dim oProps As UserProperties
    
    Set oExp = Application.ActiveExplorer
    Set oSel = oExp.Selection
    
    For iCount = 1 To oSel.Count
    If oSel.Item(iCount).Class = OlObjectClass.olMail Then
    Set oMail = oSel.Item(iCount)
    Set oProps = oMail.UserProperties
    Set oProp = oProps.Add("TextProp", olText, False, 1)
    oProp.Value = "Sample Text"
    oMail.Save
    End If
    Next iCount
    
    Set oExp = Nothing
    Set oSel = Nothing
    Set oMail = Nothing
    Set oProp = Nothing
    Set oProps = Nothing
    
    End Function
    ```

> [!NOTE]
> Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.
