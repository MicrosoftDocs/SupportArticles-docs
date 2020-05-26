---
title: Set the default font for Office applications
description: Provides detailed steps for administrators to set the default font for Office applications, such as Word, Excel, and PowerPoint.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro 
ms.topic: article
ms.prod: office-perpetual-itpro 
localization_priority: Normal
ms.custom: 
- CI 114991
- CSSTroubleshoot
ms.reviewer: vikartha, bhamv, subhbasu
appliesto:
- Word for Office 365
- Word 2016
- Excel for Office 365
- Excel 2016
- PowerPoint for Office 365
- PowerPoint 2016
search.appverid: MET150
---
# How to set the default font for Word, Excel, and PowerPoint

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

This article provides detailed steps for administrators to set the default font for Microsoft Office applications, such as Microsoft Word, Microsoft Excel, and Microsoft PowerPoint.

## Set the default font for Word

> [!NOTE]
> There are no direct Group Policy Objects (GPOs) to set the default font in Word (for both Office 365 and 2016).

1. Create a blank file that is configured by using the font and styles that you want to set as the default.
2. Select **File** > **Save As**.
3. Select the .dotm file name extension.
4. Save the file to **%Appdata%\Microsoft\Templates**.
5. Replace the Normal.dotm file.
6. After the Normal.dotm file is created on the administrator's computer, you can deploy the same file to the **%Appdata%\Microsoft\Template** location on users' computers.

For more information, see [Change the default settings for new documents](https://support.office.com/article/Change-the-default-settings-for-new-documents-430B4132-E129-46E4-97D2-19C326352C7F).

## Set the default font for Excel

- **Set a cloud policy (for Office 365):**

  1. Create a font policy from [Policy Management](https://config.office.com/officeSettings/officepolicies).
  2. Apply the cloud policy to a security group that target users are members of.

     ![Edit policy configuration in Policy Management](./media/set-default-font/policy.png)

- **Set a GPO (for Excel 2016):**

  |File name|Policy setting name|Scope|Policy path|Category|Registry information|Part|Default setting|Possible settings|Supported on|Help text|
  |---|---|---|---|---|---|---|---|---|---|---|
  |excel16.admx|Font|User|Microsoft Excel 2016\Excel Options\General|General|`HKEY_CURRENT_USER\software\policies\microsoft\office\16.0\excel\options!font`|Name, Size<br/>Arial, 10||[ ]|At least Windows Server 2008 R2 or Windows 7|Specifies the "Standard font" font name and size.|

  ![Set Font Group Policy Object](./media/set-default-font/gpo.png)

## Set the default font for PowerPoint (for both Office 365 and Office 2016)

To set default font for PowerPoint, set a default theme, and save it as a .potx file.

> [!NOTE]
> Setting the default template requires the following items:
> - The correct file name: **Default Theme.potx**
> - The correct location: **%appdata%\Microsoft\Template\Document Themes**

To set the default theme, follow these steps:

1. Start PowerPoint.
2. Open an existing PowerPoint template that you have configured by using the font and styles that you want to set as the default.
3. Select **File** > **Save As**.
4. Select **PowerPoint Template (*.potx)** in the file type list. This automatically changes the folder location to **Custom Office Templates** (a personal template folder).

   > [!NOTE]
   > Don't save it here because this enables you to view your template under **Custom Office Templates**.

5. Select **More options** to opens a file name dialog box, replace the whole file name with **%appdata%\Microsoft\Templates\\**, and then press Enter.
6. In the **Templates** folder, open the **Document Themes** folder. If you see a **Default Theme.potx** file existing in the folder, you can also make a backup of the file. To do this, select the file, press Ctrl+C, and then press Ctrl+V.
7. Enter the name "**Default Theme**" to manually name the file, and then save it. If a Default Theme.potx file exists, you can also select the Default Theme.potx file, and then select **Save** to overwrite it.
8. Close PowerPoint, and then select **File** > **New**. Now, you see the default template that's displayed as an option. 

   ![Default Theme shows as an option](./media/set-default-font/template.png)

For more information, see [Change the default font in PowerPoint](https://support.office.com/article/Change-the-default-font-in-PowerPoint-8e93c947-c160-4310-8070-afea7da78c33).
