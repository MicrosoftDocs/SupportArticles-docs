---
title: Error when you open a file type blocked by registry policy setting
description: Resolves an issue in which you receive an error message when you try to open a drawing file whose file type was blocked by an administrator in Visio 2013. This issue also occurs when you try to save a drawing file to a blocked file type.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Security\Trust
  - CSSTroubleshoot
ms.reviewer: dkuy, nathanad
search.appverid: 
  - MET150
appliesto: 
  - Visio Professional 2013
  - Visio Standard 2013
ms.date: 06/06/2024
---

# Error message when you open a file type that is blocked by registry policy settings in Visio 2013

## Symptoms

A user can't open a drawing file that uses one of the following formats or save a drawing file to one of the following formats by using Microsoft Visio 2013:

- Visio 2003-2010 Binary Drawings, Templates and Stencils    
- Visio 2000-2002 Binary Drawings, Templates and Stencils    
- Visio 5.0 or earlier Binary Drawing, Templates and Stencils   

Additionally, when the user tries to open the file or save the file to one of the formats, the user receives one of the following error messages that informs the user that the file is blocked: 

Error message 1

```adoc
You are attempting to open a file type that is blocked by your registry policy setting.
```

Error message 2

```adoc
You are attempting to open a file that was created in an earlier version of Microsoft Office. This file type is blocked from opening in this version by your registry policy setting.
```

Error message 3 

```adoc
You are attempting to open a file type <File_Type> that has been blocked by your File Block settings in the Trust Center. 
```

## Cause

This issue occurs because the file type that you want to open or save to is blocked in Visio 2013. 

**Note** The **File Block Settings** dialog box is new in Visio 2013. 

## Resolution

To open the blocked drawing file or save a file to a blocked file type, use one of the following methods.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756). 

### Method 1: Unblock the file type in the Trust Center

1. Click the **File** tab in Visio 2013, and then click **Options**.   
2. Click **Trust Center**, click **Trust Center Settings**, and then click **File Block Settings**.    
3. Clear the check box for the file type that you want to open or save to.   
4. Click **OK** two times.    

> [!NOTE]
> If the issue occurs in an embedded or linked Visio file in other Microsoft Office applications, clear both the **Save** and **Open** check boxes for the "Visio 2003-2010 Binary Drawings, Templates and Stencils" file type.

The following screen shot shows the default settings for the **File Block Settings** dialog box in Visio 2013:

:::image type="content" source="media/file-blocked-by-registry-policy/file-block-settings.png" alt-text="Screenshot shows the default settings for the File Block Settings dialog box in Visio 2013." border="false":::

If the Open and Save options are unavailable, your system administrator may have applied group policies to block the file types. 

### Method 2: Move the file to a trusted location

If you trust the file that you want to open in Visio 2013, override the registry policy settings by moving the file to a trusted location.

For more information about how to create, remove, or change a trusted location for files, go to the following Microsoft website:

[Plan and configure Trusted Locations settings for Office 2013](https://technet.microsoft.com/library/cc179039%28v=office.15%29.aspx)

### Method 3: Use a Group Policy template to override the file type that is blocked

If you are a domain administrator, you can override the settings for file types that are blocked by using a Group Policy template. You can download the [Office 2013 Administrative Template files (ADM, ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=35554).

This update provides updated Group Policy template files that you can use to override the settings for the files that are blocked by default or to block additional file types. 

**Note** You can control the restrictions for the following file types by using the **File Block Settings** dialog box:

- Visio 2003-2010 Binary Drawings, Templates and Stencils   
- Visio 2000-2002 Binary Drawings, Templates and Stencils   
- Visio 5.0 or earlier Binary Drawing, Templates and Stencils   

## More Information

### How to restrict files in Microsoft Visio 2013

To restrict the kinds of files that you can open or save in Visio 2013, an administrator can use the 2013 Office System Administrative Templates to configure the registry on the client computer. 

For more specific information about how to use settings to block users from opening and saving specific file formats in Office 2013 programs, see [Overview of Group Policy for Office 2013](https://technet.microsoft.com/library/cc179176.aspx).
