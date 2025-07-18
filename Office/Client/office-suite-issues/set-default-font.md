---
title: Set the Default Font for Office Applications
description: Provides detailed steps for administrators to set the default font for Office applications, such as Word, Excel, and PowerPoint.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Fonts
  - CI 114991
  - CSSTroubleshoot
ms.reviewer: vikartha, bhamv, subhbasu
appliesto: 
  - Word for Microsoft 365
  - Word 2016
  - Excel for Microsoft 365
  - Excel 2016
  - PowerPoint for Microsoft 365
  - PowerPoint 2016
search.appverid: MET150
ms.date: 06/26/2025
---
# How to set the default font for Word, Excel, and PowerPoint

This article provides detailed steps for administrators to set the default font for Microsoft Office applications, such as Microsoft Word, Microsoft Excel, and Microsoft PowerPoint.

## Set the default font for Word

> [!NOTE]
> There are no direct Group Policy Objects (GPOs) to set the default font in Word.

Follow these steps:

1. Back up the existing template:

   1. Navigate to the `%APPDATA%\Microsoft\Templates` folder, and locate the `normal.dotm` file.
   1. Rename the file to `normal.dotm.bak`.
1. Open Word, and then close Word. This action creates a new, clean `normal.dotm` file in the `%APPDATA%\Microsoft\Templates` folder.
1. Open Word again.
1. Open the `%APPDATA%\Microsoft\Templates\normal.dotm` file.
1. Configure the font and style settings that you want for the default font.
1. Save and close the file.
1. Close Word.

The revised `normal.dotm` file now contains your customizations. You can distribute this file to other users by copying it to the same path on their computers.

For more information, see [Change the default settings for new documents](https://support.office.com/article/Change-the-default-settings-for-new-documents-430B4132-E129-46E4-97D2-19C326352C7F).

## Set the default font for Excel

- **Set a cloud policy (for Microsoft 365):**

  1. Create a font policy at [Policy Management](https://config.office.com/officeSettings/officepolicies).
  2. Apply the cloud policy to a security group that the target users are members of.

     :::image type="content" source="media/set-default-font/policy-management.svg" alt-text="Screenshot of the edit policy configuration in Policy Management." border="false":::

- **Set a GPO (for Excel 2016):**

  |File name|Policy setting name|Scope|Policy path|Category|Registry information|Part|Default setting|Possible settings|Supported on|Help text|
  |---|---|---|---|---|---|---|---|---|---|---|
  |excel16.admx|Font|User|Microsoft Excel 2016\Excel Options\General|General|`HKEY_CURRENT_USER\software\policies\microsoft\office\16.0\excel\options\font`|Name, Size<br/>Arial, 10||[ ]|At least Windows Server 2008 R2 or Windows 7|Specifies the "Standard font" font name and size.|

  :::image type="content" source="media/set-default-font/gpo-font.svg" alt-text="Screenshot to set Font Group Policy Object in Excel 2016." border="false":::

## Set the default font for PowerPoint

To set default font for PowerPoint, set a default theme, and save it as a .potx file.

> [!NOTE]
> Setting the default template requires the following items:
>
> - The correct file name: **Default Theme.potx**
> - The correct location: **%Appdata%\Microsoft\Templates\Document Themes**

To set the default theme, follow these steps:

1. Start PowerPoint.
1. Open an existing PowerPoint template that you configured by using the font and styles that you want to set as the default.
1. Select **File** > **Save As**.
1. Select **PowerPoint Template (\*.potx)** in the file type list. This selection automatically changes the folder location to **Custom Office Templates** (a personal template folder).

   > [!NOTE]
   > Don't save the file here because this enables you to view your template under **Custom Office Templates**.

1. Select **More options** to open a file name dialog box, replace the whole file name with **%Appdata%\Microsoft\Templates\\**, and then press Enter.
1. In the **Templates** folder, open the **Document Themes** folder. If you see a **Default Theme.potx** file in the folder, you can also make a backup of the file. To make a backup, select the file, press Ctrl+C, and then press Ctrl+V.
1. Manually name the file "**Default Theme**", and then save it. If a Default Theme.potx file exists, you can also select the Default Theme.potx file, and then select **Save** to overwrite it.
1. Close PowerPoint, and then select **File** > **New**. The default template is now displayed as an option.

   :::image type="content" source="media/set-default-font/default-template.svg" alt-text="Screenshot shows the Default Theme that's displayed as an option." border="false":::

For more information, see [Change the default font in PowerPoint](https://support.office.com/article/Change-the-default-font-in-PowerPoint-8e93c947-c160-4310-8070-afea7da78c33).
