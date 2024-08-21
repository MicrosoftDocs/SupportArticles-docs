---
title: Set the default font for Office applications
description: Provides detailed steps for administrators to set the default font for Office applications, such as Word, Excel, and PowerPoint.
author: helenclu
ms.author: luche
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
ms.date: 06/06/2024
---
# How to set the default font for Word, Excel, and PowerPoint

This article provides detailed steps for administrators to set the default font for Microsoft Office applications, such as Microsoft Word, Microsoft Excel, and Microsoft PowerPoint.

## Set the default font for Word

> [!NOTE]
> There are no direct Group Policy Objects (GPOs) to set the default font in Word (for both Microsoft 365 and 2016).

1. Create a blank file that is configured by using the font and styles that you want to set as the default.
2. Select **File** > **Save As**.
3. Select the **.dotm** file name extension.
4. Save the file to **%Appdata%\Microsoft\Templates**.
5. Replace the **Normal.dotm** file.
6. After the **Normal.dotm** file is created on the administrator's computer, you can deploy the same file to the **%Appdata%\Microsoft\Templates** location on users' computers.

For more information, see [Change the default settings for new documents](https://support.office.com/article/Change-the-default-settings-for-new-documents-430B4132-E129-46E4-97D2-19C326352C7F).

## Set the default font for Excel

- **Set a cloud policy (for Microsoft 365):**

  1. Create a font policy from [Policy Management](https://config.office.com/officeSettings/officepolicies).
  2. Apply the cloud policy to a security group that target users are members of.

     :::image type="content" source="media/set-default-font/policy-management.svg" alt-text="Screenshot to edit policy configuration in Policy Management." border="false":::

- **Set a GPO (for Excel 2016):**

  |File name|Policy setting name|Scope|Policy path|Category|Registry information|Part|Default setting|Possible settings|Supported on|Help text|
  |---|---|---|---|---|---|---|---|---|---|---|
  |excel16.admx|Font|User|Microsoft Excel 2016\Excel Options\General|General|`HKEY_CURRENT_USER\software\policies\microsoft\office\16.0\excel\options\font`|Name, Size<br/>Arial, 10||[ ]|At least Windows Server 2008 R2 or Windows 7|Specifies the "Standard font" font name and size.|

  :::image type="content" source="media/set-default-font/gpo-font.svg" alt-text="Screenshot to set Font Group Policy Object in Excel 2016." border="false":::

## Set the default font for PowerPoint (for both Microsoft 365 and Office 2016)

To set default font for PowerPoint, set a default theme, and save it as a .potx file.

> [!NOTE]
> Setting the default template requires the following items:
> - The correct file name: **Default Theme.potx**
> - The correct location: **%Appdata%\Microsoft\Templates\Document Themes**

To set the default theme, follow these steps:

1. Start PowerPoint.
2. Open an existing PowerPoint template that you have configured by using the font and styles that you want to set as the default.
3. Select **File** > **Save As**.
4. Select **PowerPoint Template (*.potx)** in the file type list. This automatically changes the folder location to **Custom Office Templates** (a personal template folder).

   > [!NOTE]
   > Don't save it here because this enables you to view your template under **Custom Office Templates**.

5. Select **More options** to opens a file name dialog box, replace the whole file name with **%Appdata%\Microsoft\Templates\\**, and then press Enter.
6. In the **Templates** folder, open the **Document Themes** folder. If you see a **Default Theme.potx** file existing in the folder, you can also make a backup of the file. To do this, select the file, press Ctrl+C, and then press Ctrl+V.
7. Enter the name "**Default Theme**" to manually name the file, and then save it. If a Default Theme.potx file exists, you can also select the Default Theme.potx file, and then select **Save** to overwrite it.
8. Close PowerPoint, and then select **File** > **New**. Now, you see the default template that's displayed as an option. 

   :::image type="content" source="media/set-default-font/default-template.svg" alt-text="Screenshot shows the Default Theme that's displayed as an option." border="false":::

For more information, see [Change the default font in PowerPoint](https://support.office.com/article/Change-the-default-font-in-PowerPoint-8e93c947-c160-4310-8070-afea7da78c33).
