---
title: A corrupt global template causes errors when automating Word
description: Describes an issue where an invalid global template file may cause an out-of-process automation client to throw an error message. Rename the global template file to resolve this issue.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Templates
  - CSSTroubleshoot
appliesto: 
- Microsoft Word 2010
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 06/06/2024
---
# A corrupt global template causes errors when automating Word

## Symptoms

One or more invalid global template files may cause an out-of-process automation client to throw one of the following error messages:

- > HRESULT: 0x8001010A  
    VB Error: -2147417846  
    "The message filter indicated that the application is busy"
- > HRESULT: 0x800A175D  
    VB Error: 5981  
    "Cannot open macro storage"
- > HRESULT: 0x800A142D  
    VB Error: 5165  
    "Word cannot open the existing [square]"

## Cause

The global template file that is used by Word might be corrupt.

> [!NOTE]
> In Microsoft Office Word 2007, the global template is named Normal.dotm. In Microsoft Office Word 2003 and in earlier versions of Word, the global template is named Normal.dot.

## Resolution

If you are encountering one of the errors described in the Symptoms section, you can temporarily rename the global template to determine if it is the cause of the problem.

Renaming the global template resets several options back to their default settings, including custom styles, custom toolbars, macros, and AutoText entries. It is recommended that you rename the global template file rather than deleting it, so that you can restore these settings if the template is not corrupt.

Certain installations of Word may yield more than one legitimate global template file. These situations include multiple versions of Word running on the same computer or several user profiles on the same computer. In these situations, pay special attention so that you rename the correct copy of Normal.dot.

To rename the global template file, follow these steps.

> [!NOTE]
> Because there are several versions of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.  

1. Quit all instances of Word, including WordMail.
2. Select **Start** > **Find** > **Files or Folders**.
3. In the **Named** box, type the global template name for your version of Word.
4. In the **Look In** box, select your local hard disk drive (or an alternate user template location if you are running Word from a network server).
5. Select **Find Now** to search for the file.
6. For each occurrence of global template that appears in the **Find** dialog box, right-click the file and then select **Rename**. Give the file a new name, such as *OldNormal.dot* or *Normal-1.dot*.
7. Minimize the **Find** dialog box.
8. Restart your automation client to start Word.

If Word starts correctly, you have resolved the problem. In this case, the problem is a damaged global template. You might need to change a few settings to restore your favorite options. If the global template file you renamed contains customizations, such as styles, macros, or AutoText entries that cannot be easily recreated, you may be able to copy those customizations from the old global template file to the new global template file by using the organizer.

If your toolbar customizations are stored in a custom toolbar, you should be able to copy them using the organizer. Unfortunately, if the customizations were made to one of Word's built-in toolbars you might need to recreate them after you rename your template because you cannot copy those changes with the organizer.

## References

For more information about the error messages, see [Error 800A175D - Could Not Open Macro Storage](https://support.microsoft.com/help/224338).
