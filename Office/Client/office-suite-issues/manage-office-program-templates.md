---
title: Manage Office programs templates
description: Describes the different template categories and the locations of templates in 2007 Office programs and in 2010 Office programs. Also describes the registry settings that control where to find your custom templates.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Templates
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: of12sstr
appliesto: 
  - Office 2010
  - Office 2007
ms.date: 06/06/2024
---

# How to manage templates in 2007 Office programs and in 2010 Office programs

## Introduction

This article describes the different types and locations of templates in 2007 Microsoft Office programs and in 2010 Office programs. Additionally, this article contains information about registry settings that control where you find custom templates.

## More Information

2007 Office programs and 2010 Office programs save all new custom templates that you create. A Microsoft Office program looks in one of the following locations for the templates that belong to that program: 

- The user templates file location   
- The workgroup templates file location   
- The advertised and installed templates file location   
- The non-file-based templates file location   

### User templates file location

Newly created or newly modified templates are saved in a folder in your profile directory. The folders that are under your profile contain your configuration preferences and options. These folders contain everything that is needed for a roaming user profile.

By default, user templates files are stored in the following location: 

- In Windows XP: \Documents and Settings\\\<user name>\Application Data\Microsoft\Templates   
- In Windows Vista or Windows 7: \Users\\\<user name>\AppData\Roaming\Microsoft\Templates   

> [!NOTE]
> You can change the location of user templates files. 

### How to change the location in which templates are saved

You can use Microsoft Office Word to change the location in which your new templates are saved. To do this, follow these steps.

> [!NOTE]
> If you use Word 2007 or Word 2010 to change the location in which your new templates are saved, you also change the location in which all 2007 Office program templates or all 2010 Office program templates are saved.

1. Start Word.   
2. If you are using Word 2007, click the **Microsoft Office Button**, and then click **Word Options**.

   If you are using Word 2010 or later versions, select **File** > **Options**.
3. On the left pane, select **Advanced**.  
4. Under **General**, select **File Locations**.   
5. Select **User templates**, and then select **Modify**.   
6. In the **Modify Location** dialog box, change the setting in the **Folder name** list or the **Look in** list to the folder in which you want to save your new templates. Then, select **OK**.   
7. Select **OK** or **Close** to close the **Options** dialog box.   

The changed path is noted in the Windows registry. The path is used the next time that you want to save a new template. For more information, see the "Changes in the Windows registry settings for the user templates file location and for the workgroup templates file location" section.

> [!NOTE]
> Your network administrator can change the location in which your new templates are saved by using the policy templates that are included with the 2007 Microsoft Office Resource Kit. For more information, contact your network administrator.

You can also create custom tabs that appear in the **Templates** dialog box by creating a new folder in the Templates folder in your profile. Tabs that have the same name as a new folder appear in the **Templates** dialog box. These tabs let you categorize your new templates even more.

The template options are available when you click the **Microsoft Office Button**, and then click **New** in Office 2007, or from **New** under the **File** menu in Office 2010.

There are more templates available in the **Microsoft Office Online** area. 

> [!NOTE]
> Microsoft Office Publisher 2007 and Microsoft Office SharePoint Designer 2007 do not use the same user interface as the previously listed 2007 Office programs.

#### In Publisher 2007 or Publisher 2010

- On the **File** menu, click **New**, and then click one of the publication types.   

#### In SharePoint Designer 2007

- On the **File** menu, click **New**, and then click one of the templates.   

### Workgroup templates file location

The templates that are saved in this location are basically the same as the templates that are saved in your user templates file location. However, the location is typically a shared folder on a network drive.

> [!NOTE]
> Your network administrator may set a shared location as a source from which to provide templates that are used throughout your workgroup or company. The workgroup template file location typically is a read-only shared folder.

In addition to looking in your default user templates file location for existing templates, 2007 and 2010 Office programs look in the workgroup templates file location for more templates.

For more information about the workgroup templates file location and about how to share a template with your workgroup or your company, contact your network administrator.

### Advertised and installed templates file location

Advertised templates are the templates that are included with Office programs. These templates appear in the **Templates** dialog box. Depending on the type of Office installation, you may not have all the templates installed on the computer. However, each Office program displays the templates as they are available in the **Templates** dialog box.

When you select a template, the Office program determines whether the template is installed. If the template is installed, a new document that is based on the template opens. If the template is advertised but is not installed, the program prompts you to install the template.

You can remove installed templates for Publisher 2007 by starting the 2007 Office installation program. Then, set the template group to **Installed on First Use**. This effectively removes the templates from the computer. Then, the templates become advertised templates again. Microsoft Office Access 2007 does not allow for templates to be advertised. However, templates can be set to **Not Available** in Access 2007. The other 2007 Office programs do not list templates as a separate component.

By default, all templates that are installed with Microsoft Office are installed in the following folder: 

C:\Program Files\Microsoft Office\Templates\\\<Language ID Number>

> [!NOTE]
> The **Language ID Number** is a four-digit code that represents the language types that are currently installed. For example, the English (US) version of Office installs a 1033 folder. The Arabic version installs a 1025 folder. The German version installs a 1031 folder. 2007 Office programs support many other languages. Additionally, you can have multiple languages installed at the same time. Therefore, you may have a Templates folder that contains several language ID folders. 

### Non-file-based templates file location

Office programs use non-file-based templates to create new workbooks, documents, databases, and slides. As the name suggests, there is no physical template from which these special files are created. Each Office program has the necessary information to create a new file of the correct type.

For example, if the Word global template (Normal.dotm) is used to create a blank document, Word uses its internally stored settings to create a new blank document.

### Changes in the Windows registry settings for the user templates file location and for the workgroup templates file location

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Office programs use two registry keys to record the user templates file location and the workgroup templates file location. Both settings are recorded in the following registry key: 

Office 2007: 

`HKEY_CURRENT_USER\Software\Microsoft\Office\12.0\Common\General`

Office 2010: 

`HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\General`

The user templates location is stored in the **UserTemplates** string value.

The workgroup templates location is stored in the **SharedTemplates** string value.

These string values do not exist until you make a change to the default locations for your custom templates. By default, all Office programs look for their installed templates. Therefore, no string value is required for Office programs.

If you change the user templates file location to the default location as described in the "User templates file location" section, the **UserTemplates** string value is deleted from the registry. However, if you change the workgroup templates file location to the default location, the **SharedTemplates** string value is retained in the registry.
