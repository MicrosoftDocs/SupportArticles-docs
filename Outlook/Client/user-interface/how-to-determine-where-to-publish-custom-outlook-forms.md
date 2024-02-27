---
title: How to decide where to publish custom form
description: Describes how to decide where to publish forms. Includes where to publish folder-based forms and where to publish message-based forms. Forms can be published to a Form (or Folder Forms Library), Organizational Forms Library, or Personal Forms Library.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, sercast
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
  - Microsoft Office Outlook 2003
search.appverid: MET150
ms.date: 01/30/2024
---
# How to determine where to publish a custom Outlook form

_Original KB number:_ &nbsp; 290802

## Summary

This article describes some of the considerations to take into account if you're trying to decide where to publish a custom Outlook form.

## More information

In Outlook, custom forms are typically published to a forms library so that only one copy of a form is stored on your computer. Individual items contain a Message Class field that indicates which form to use to display the data that is contained in the item. When you publish custom forms to a forms library, Microsoft Exchange Server-based computers and Outlook use considerably less resources and bandwidth because the form itself doesn't need to be stored within each individual item.

Outlook forms solutions can vary greatly, especially because Outlook has a number of different types of standard forms. It's often difficult to determine the best place to publish a form, and there are many factors to take into account when you make the decision.

## Where you can publish forms

Forms can be published to three locations. The following table outlines those locations.

|Location|Description|
|---|---|
|A folder (or Folder Forms Library)|For most folder-based forms solutions, publish the form to the folder so that it's available whenever someone is using the folder. If you publish the form in a public folder, the form is available to everyone who can access the folder. If you publish the form to one of your personal folders, it's available only to you when you are using that folder. Contact, Post, Task, and Journal forms are examples of the types of forms that are typically associated with a folder. One advantage to publishing a form to a folder is that the form is available on the Actions menu when you are in the folder.|
|Organizational Forms Library|Publish the form to this library if you want to make the form available to everyone in your organization, such as a form to report vacation time. This library is often used for e-mail message forms because they are typically not based on a specific folder. You can publish a form to the Organizational Forms Library when you want to use the same custom form in more than one folder. When you do this, you can maintain only a single published form. Forms that are published to this library are accessible to everyone in the organization as long as they are given permissions to the library by the administrator. The library is stored on the Microsoft Exchange Server-based computer. The administrator must give you permissions to publish to the Organizational Forms Library. This permission is typically given to only a few individuals or a department that manages the Exchange Server-based computer.|
|Personal Forms Library|Forms that are saved in this library are only accessible to you. When you publish a form to the Personal Forms Library, the form is stored as a hidden item in the root folder of your mailbox or Personal Folders (.pst) file, whichever is your default mail delivery location. Like forms that are stored in the Organizational Forms Library, these forms can be opened by using the Choose Form command. Save a form to this library when you create a form for your own personal use, such as a standard e-mail message form that is pre-addressed to recipients.|

It's also possible to store an Outlook form as a file in the file system or as an item in an Outlook folder. Microsoft recommends that you avoid both of these approaches, however, because the form will be a one-off form.

You can save an Outlook form to the file system as an Outlook Template (.oft) file. This allows you to attach the form to an e-mail message, and then send the form to someone else. You can also use the .oft file as a backup of the form. To save a form as an .oft file:

1. On the **File** menu, select **Save As**.
2. In the **File name** box, type a name for the form.
3. In the **Save as type** box, select **Outlook Template**, and then select **Save**.

You can also save the form as an item in the current folder. However, Microsoft doesn't recommend that you do this for the following reasons:

- It's easy to accidentally delete the form.
- It tends to blur the distinction between forms and items, and the typical result is a folder that is filled with different items that contain various versions of the same form. This is generally not a good practice when you design Outlook forms.
- Items that are stored in a folder typically have data associated with them, and you usually do not want data associated with your form. Therefore, Microsoft recommends that you not open an item in a folder and then enter design mode; open a new instance of the form and then enter design mode.
- Forms that are stored as items are one-off forms and have unwanted side effects.

To save a form in the current folder, select **Save** on the **File** menu.

## Considerations when you are deciding where to publish a form

There are many questions to take into account when you are deciding where to publish a form:

- Is the form based on a folder solution, or is it an e-mail message form that is designed to be sent to recipients?
- Are you using an Exchange Server-based computer? If you are using an Exchange Server-based computer, is it possible to publish the form to the Organizational Forms Library, or has your organization placed restrictions on what types of forms can be stored there?
- How many people need access to the form?
- Will the form be updated often, making it important to have only one copy of the form deployed centrally?
- Does the form need to be available offline?
- If this is an e-mail message form, will it be used only inside the organization, or will it be sent to other recipients outside of the organization?
- How will the new form be opened?

### Deciding where to publish folder-based forms

When you create a folder-based solution where the primary focus of the form is to display the items in a single folder, typically publish the form to the folder itself. When you publish the form to the folder, the folder is a self-contained entity and the form is available on the Actions menu.

However, there are scenarios where you may not want to publish a typical folder-based form to a folder. If you use a form in more than one folder, and each folder always uses the same version of the form, consider publishing the form into either the Organizational Forms Library or the Personal Forms Library. When you do this, there is only one copy of the published form and it's easier to update if you need to make changes. If you are the only person who needs access to this form, publish the form in Personal Forms Library. If other people need to access to the form, and the form is typical in a public folder on an Exchange Server-based computer, investigate whether or not you may be able to publish the form to the Organizational Forms Library. One potential disadvantage to this approach is that the form will not be available under the Actions menu unless it's published to the folder. However, if it's the default form for the folder, as is typically the case, this will not make too much of a difference because you or the users can use a toolbar button to open new items.

### Deciding where to publish message-based forms

If the form is based on an e-mail message and it's used by you and only a couple of other users, publish the form to the Personal Forms Library for all of the users. However, if you are going to create new items based on this form, you may want to publish it to your Inbox so that you can access it on the Actions menu. If the form is going to be used by many people within an organization, publish it in the Organizational Forms Library so that there is only one copy of the form to maintain and all of the users have access to it. This approach, however, can make the form more difficult to open.

## Considerations and options for opening forms

The following table describes how users typically open Outlook forms depending on where the forms are stored:

|Form Type|Where to open|
|---|---|
|Folder forms|If you open the folder that contains the forms, the forms are available on the **Actions** menu.|
|Organizational Forms Library<br/><br/>-and-<br/><br/>Personal Forms Library|Forms stored in the Organizational Forms Library and Personal Forms Library are designed to be accessed by using the **Choose Form** dialog box. To access these forms, point to **New** on the **File** menu, and then select **Choose Form**.|

You can use the following methods to make forms more accessible to users.

### Add the Choose Form command to the toolbar

Outlook 2007 and Outlook 2003

To shorten the number of steps that are needed to access the Choose Form command, add the command to the toolbar so that you can display the dialog box with a single select:

1. On the **View** menu, point to **Toolbars**, and then select **Customize**.
2. Select the **Commands** tab in the **Customize** dialog box.
3. In the **Categories** box, make sure that **File** is selected.
4. In the **Commands** box, locate the Choose Form command, and then drag it up to the toolbar location that you want.
5. Select **Close**.

Outlook 2013 and Outlook 2010

To shorten the number of steps that are needed to access the Choose Form command, add the **Developer** tab to the ribbon so that you can display the **Choose Form** dialog box with a couple of selects:

1. Right-click the Outlook ribbon, and then select **Customize the Ribbon**.
2. In the list of Main Tabs, select **Developer**, and then select **OK**.

On the **Developer** tab on the Outlook ribbon, you should see **Choose Form** displayed.

### Open a Form by Using Visual Basic for Applications or a COM Add-in

### Publish the Form to a Folder

If a form is published to either the Personal Forms Library or the Organizational Form Library, you may want to consider publishing a form to a folder so that it appears on the Actions menu. However, if the form is updated, be sure that the form is redeployed so that you do not create problems with the Outlook forms cache.

### Save an .oft file to the Desktop or Start menu

Although Microsoft doesn't typically recommend saving an .oft file to the desktop or to the **Start** menu, you can save an Outlook Template (.oft) file to either location. The items that are created by doing this contain one-off forms that typically cause unwanted side effects depending on the design of the form and how it's used.
