---
title: How to create a recurring e-mail message in Outlook
description: provides a method to create recurring e-mail messages in Outlook.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Outlook
---

# How to create a recurring e-mail message in Outlook

## Summary

This article describes a method for creating a recurring reminder e-mail message.

## More Information

Outlook does not provide a means to create recurring e-mail messages. For example, you might want to send an e-mail message every month to remind a group of people that a report is due. While you can set up appointments and tasks as recurring events, you cannot create a recurring e-mail message.

You can use Visual Basic Script and the recurrence settings of a task to automatically generate a recurring e-mail message. This procedure consists of the following tasks:

1. Publish a custom task form that creates an e-mail message when the task status equals completed.
2. Use the custom task form to create a recurring task.
3. When the task comes due, mark it as completed. The code will generate the boilerplate message, which you then send. At the same time, a new task is created because the original task was set to recur.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability and/or fitness for a particular purpose. This article assumes that you are familiar with the programming language being demonstrated and the tools used to create and debug procedures. Microsoft support professionals can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific needs.

If you have limited programming experience, you may want to contact a Microsoft Certified Partner or Microsoft Advisory Services. For more information, visit these Microsoft Web sites:

Microsoft Certified Partners - [Microsoft Partner Network](https://partner.microsoft.com)

Microsoft Advisory Services - [Support for business](https://support.microsoft.com/gp/advisoryservice)

For more information about the support options that are available and about how to contact Microsoft, visit the following Microsoft Web site: [Microsoft Support](https://support.microsoft.com)

### Publish a Custom Task Form

1. Start Outlook and open your Tasks folder.
2. On the **Actions** menu, click **New Task**.
3. On the **Tools** menu, point to **Forms**, and then click **Design This Form**.
4. On the **Form** menu, click **View Code**, and type the following code in the Script Editor:

    ```vb
    Sub Item_PropertyChange(ByVal Name)
    Select Case Name
        Case "Status"
            If Item.Status = 2 then '2 = Completed
            Set NewItem = Application.CreateItem(0)
            NewItem.To = "myemailaddress@myisp.com"
            NewItem.Recipients.ResolveAll
            NewItem.Subject = "This Is the message subject text"
            NewItem.Body = "This Is Text that will appear in the body of the message."
            NewItem.Display
        End If
    End Select
    End Sub
    ```

5. In the Script Editor, on the **File** menu, click **Close**.
6. On the **Tools** menu, point to **Forms**, and then click **Publish Form**.
7. In the **Look in** list, click **Tasks**. In the **Display Name** and **Form Name** boxes, type Reminder, and then click **Publish**.
8. On the **File** menu, click **Close**. Do not save changes.

> [!NOTE]
> In the code, substitute your own information inside the quotation marks for **NewItem.To, NewItem.Subject**, and **NewItem.Body**. These lines set the **To**, **Subject**, and body of your reminder message.

### Create a Recurring Task Using the Custom Form

1. Open your Tasks folder, where you published the custom reminder form.
2. On the **Actions** menu, click **New Reminder**. This will open a new task based on your custom form.
3. Type a subject for your reminder task. In **Due Date**, click to select a due date from the calendar. Click to select the **Reminder** check box.
4. On the **Actions** menu, click **Recurrence**, and set how often you want the reminder message sent.
5. Click **Save and Close**.

### To Send Reminder E-mail

When you receive the reminder that the task is due, click **Open Item**. In the **Status** box, click to select **Completed**.

-or-

Dismiss the reminder and in your Tasks list, click **Completed**.

Setting the task as completed will automatically generate a new task and display an e-mail message containing your boilerplate text. Click **Send** to send the message.

You can further automate the message. If you add the line **NewItem.Send** immediately below the **NewItem.Display** line, the message is automatically sent when you mark the task as completed.

> [!NOTE]
> In Microsoft Outlook 2002, after you click **Completed** in the **Status** box, you receive the following message:
>
> A program is trying to access e-mail address you have stored in Outlook. Do you want to allow this? Click Yes to send the message.
