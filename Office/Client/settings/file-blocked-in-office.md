---
title: Error message in Office when a file is blocked by registry policy settings
description: Describes an issue that occurs when you try to open or to save a file type that is blocked by your registry policy setting in one of the Office 2019 or Office 2016 apps.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto:
- Word 2016
- Excel 2016
- PowerPoint 2016
- Visio 2016
- PowerPoint 2019
- Excel 2019
- Word 2019
---

# Error message in Office when a file is blocked by registry policy settings

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

A file is blocked when you open or save the file in a Microsoft Office program. In this situation, you may receive an error message that resembles one of the following:

- You are attempting to open a file that is blocked by your registry policy setting.
- You are attempting to open a file type **\<File Type>** that has been blocked by your File Block settings in the Trust Center.
- You are attempting to open a file that was created in an earlier version of Microsoft Office. This file type is blocked from opening in this version by your registry policy setting.
- You are attempting to save a file that is blocked by your registry policy setting.
- You are attempting to save a file type **\<File Type>** that has been blocked by your File Block settings in the Trust Center.

## Resolution

To resolve this issue, try the following general resolutions to change the File Block settings to disable the restriction of certain file types:

1. Select **File** > **Options**.

    If you cannot open a file in Office, open a blank document to start the Office application. For example, if you cannot open a Word file, open a new document in Word 2019 or Word 2016 to see the option.
2. In the **Options** window, select **Trust Center** > **Trust Center Settings**.
3. In the **Trust Center** window, select **File Block Settings**, and then clear the "Open" or "Save" check box for the file type that you want to open or save.

    > [!NOTE]
    > Clear the option means allow user to open or save the file. Check the option means block the file.

    ![Trust Center window](./media/file-blocked-in-office/trust-center-window.png)
4. Select **OK** two times.
5. Try to open or save the file that was blocked again.

> [!NOTE]
> The **File Block Settings** can be controlled by a Group Policy Object (GPO) and are part of the recommended [security base line](https://techcommunity.microsoft.com/t5/microsoft-security-baselines/security-baseline-for-office-365-proplus-v1908-sept-2019-final/ba-p/873084) settings. If a file type that's blocked by default is enabled, there is a security implication.
>
> Here's how to open the GPO:
>
> 1. Open the Group Policy Management Console.
> 2. Navigate to the following GPO:
>
>     ***User Configuration\Administrative Templates\Microsoft \<Product Name>\\\<Product Name> Options\Security\Trust Center\File Block Settings***
>
>     Replace \<Product Name> with the affected Office application name, such as Word 2019.
>
> Additionally, you may need to download [Administrative Template files](https://www.microsoft.com/download/details.aspx?id=49030) to use the GPO.

## More Information

The issue can also occur when you open an embedded or linked Office file in an Office application. For example, you have a Visio object embedded in a Word document. When you try to open the Visio object, you receive a similar error message in Word. To resolve this issue, you must change the File Block settings in the application that owns the blocked file type. In this example, you must change the File Block settings in Visio instead of in Word. If the error message mentions Excel file type, go to Excel to change the File Block settings.
