---
title: How to use Automation to send messages using Access 2000
description: Describes how to use Automation to create and send an Outlook message in Access using VBA code. Using Automation enable you to use many features in Microsoft Outlook that are not available with the SendObject method.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
search.appverid: MET150
ms.reviewer: meshel, benjak, aruiz, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# How to use Automation to send a Microsoft Outlook message using Access 2000

This article applies to a Microsoft Access database (.mdb) and to a Microsoft Access project (.adp).

## Summary

This article shows you how to use Automation to create and send a Microsoft Outlook message in Microsoft Access 2000.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

> [!NOTE]
> The following code may not work properly if you have installed the Outlook E-mail Security Update.

You can use the `SendObject` method to send a MAPI mail message programmatically in Microsoft Access. However, the `SendObject` method does not give you access to complete mail functionality, such as the ability to attach an external file or set message importance. The example that follows uses Automation to create and send a mail message that you can use to take advantage of many features in Microsoft Outlook that are not available with the `SendObject` method.

There are six main steps to sending a Microsoft Outlook mail message by using Automation, as follows:

1. Initialize the Outlook session.
2. Create a new message.
3. Add the recipients (To, CC, and BCC) and resolve their names.
4. Set valid properties, such as the Subject, Body, and Importance.
5. Add attachments (if any).
6. Display/Send the message.

## Sending a Microsoft Outlook mail message programmatically

1. Create a sample text file named Customers.txt in the C:\My Documents folder.
2. Start Microsoft Access, and open the sample database Northwind.mdb.
3. Create a module and type the following line in the Declarations section if it is not already there:

    `Option Explicit`

4. On the **Tools** menu, select **References**.
5. In the **References** box, select the **Microsoft Outlook 9.0 Object Library**, and then select **OK**.

    > [!NOTE]
    > If the **Microsoft Outlook 9.0 Object Library** does not appear in the **Available References** box, browse your hard disk for the file, Msoutl9.olb. If you cannot locate this file, you must run the Microsoft Outlook Setup program to install it before you proceed with this example.

6. Type the following procedure in the new module:

    ```vb
    Sub SendMessage(Optional AttachmentPath)
        Dim objOutlook As Outlook.Application
        Dim objOutlookMsg As Outlook.MailItem
        Dim objOutlookRecip As Outlook.Recipient
        Dim objOutlookAttach As Outlook.Attachment
        
        ' Create the Outlook session.
        Set objOutlook = CreateObject("Outlook.Application")' Create the message.
        Set objOutlookMsg = objOutlook.CreateItem(olMailItem)
        
        With objOutlookMsg
        ' Add the To recipient(s) to the message.
        Set objOutlookRecip = .Recipients.Add("Nancy Davolio")
        objOutlookRecip.Type = olTo
        
        ' Add the CC recipient(s) to the message.
        Set objOutlookRecip = .Recipients.Add("Andrew Fuller")
        objOutlookRecip.Type = olCC
        
        ' Set the Subject, Body, and Importance of the message.
        .Subject = "This is an Automation test with Microsoft Outlook"
        .Body = "Last test - I promise." & vbCrLf & vbCrLf
        .Importance = olImportanceHigh 'High importance
        
        ' Add attachments to the message.
        If Not IsMissing(AttachmentPath) Then
        Set objOutlookAttach = .Attachments.Add(AttachmentPath)
        End If
        
        ' Resolve each Recipient's name.
        For Each objOutlookRecip In .Recipients
        objOutlookRecip.Resolve
        If Not objOutlookRecip.Resolve Then
        objOutlookMsg.Display
        End If
        Next
        .Send
        
        End With
        Set objOutlookMsg = Nothing
        Set objOutlook = Nothing
    End Sub
   ```

7. To test this procedure, type the following line in the **Immediate** window, and then press ENTER:

    `SendMessage "C:\My Documents\Customers.txt"`

    To send the message without specifying an attachment, omit the argument when calling the procedure, as follows:

    `SendMessage`
