---
title: Cannot verify the license for this product when start an Office app
description: Describes an issue that triggers a licensing error when you try to start an Office 2013 and Office 2016 application. A resolution is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto:
- Office Professional Plus 2016
- Office Standard 2016
- Access 2016
- Excel 2016
- Microsoft Publisher 2016
- OneNote 2016
- Outlook 2016
- PowerPoint 2016
- Word 2016
- Office Home and Business 2013
- Office Home and Student 2013
- Office Home and Student 2013 RT
- Office Professional 2013
- Office Professional Plus 2013
- Office Standard 2013
- Access 2013
- Excel 2013
- OneNote 2013
- Outlook 2013
- PowerPoint 2013
- Publisher 2013
- Word 2013
---

# "Microsoft Office cannot verify the license for this product" error when you start an Office app

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

> [!NOTE]
> -  If you use Azure Multi-Factor Authentication, contact your administrator for help.
> -  For more information about two-factor authorization, see [Sign in to your work or school account using your two-factor verification method](https://docs.microsoft.com/azure/active-directory/user-help/multi-factor-authentication-end-user-signin). 
> -  To reset your password, see [Reset my Office 365 tenant admin password](https://docs.microsoft.com/microsoft-365/admin/add-users/reset-passwords?view=o365-worldwide#reset-my-office-365-tenant-admin-password).

When you start a Microsoft Office 2016 or Office 2013 application, such as Outlook, Word, Excel, or PowerPoint, you may receive the following error message:

![Microsoft Office cannot verify the license for this product. You should repair the Office program by using Control Panel.](./media/license-issue-when-start-office-application/error-message.png)

Microsoft Office cannot verify the license for this product. You should repair the Office program by using Control Panel.

## Cause

The Office application is running in compatibility mode for a different operating system.

## Resolution

To fix this issue, follow these steps to stop running the application in compatibility mode:

1. Exit the Office application that triggers this error.
2. Locate your Office application, depending on your installation type of Outlook and bitness of Windows and Outlook:

    - MSI-Based installation type:

        \<disk drive>\Program Files\Microsoft Office\Office**1x**

        \<disk drive>\Program Files(x86)\Microsoft Office\Office**1x**

    - Click-to-Run installation type:

        \<disk drive>\Program Files\Microsoft Office\root\Office**1x**

        \<disk drive>\Program Files(x86)\Microsoft Office\root\Office**1x**

    > [!NOTE]
    > The **1x** placeholder represents your version of Office (16 = Office 2016, 15 = Office 2013)

3. Right-click the Office application that triggers the error, and then click **Properties**.
4. If the **Compatibility** tab is available, click it, and then follow these steps. If the **Compatibility** tab does not exist, go to step 5.

   1. On the **Compatibility** tab, clear the **Run this program in compatibility mode for** option.
   2. Click **Change settings for all users**.
   3. On the **Compatibility for all users** tab, clear the **Run this program in compatibility mode for** option.
   4. Click **OK** two times.

5. If the **Compatibility** tab does not exist, click **Cancel** on the application Properties page to close it, and then follow these steps:

   1. Right-click Outlook.exe, and then select **Troubleshoot compatibility**.
   2. Select **Troubleshoot Program**.
   3. Clear all options, and then click **Next**.
   4. Select the **No, I am done investigating the problem** option, and then click **Next**.
   5. Click **Close**.

## More Information

For more information, see [Outlook is unable to start in Windows 7 or 8](https://support.microsoft.com/help/2968977).