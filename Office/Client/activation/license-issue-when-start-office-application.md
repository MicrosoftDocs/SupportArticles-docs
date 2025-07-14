---
title: Cannot verify the license for this product when you start an Office app
description: Describes an issue that triggers a licensing error when you try to start an Office 2016 or 2013 application. Provides a resolution.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - Activation\Errors\Couldn't verify account or subscription or license
  - CSSTroubleshoot
  - CI 159180
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
ms.date: 06/06/2024
---

# "Microsoft Office cannot verify the license for this product" error when you start an Office app

## Symptoms

> [!NOTE]
>
> - If you use Azure Multi-Factor Authentication, contact your administrator for help.
> - For more information about two-factor authentication, see [Sign in to your work or school account using your two-factor verification method](/azure/active-directory/user-help/multi-factor-authentication-end-user-signin).
> - To reset your password, see [Reset passwords](/microsoft-365/admin/add-users/reset-passwords?view=o365-worldwide#reset-my-office-365-tenant-admin-password&preserve-view=true).

When you start a Microsoft Office 2016 or 2013 application, such as Outlook, Word, Excel, or PowerPoint, you might receive the following error message:

> Microsoft Office cannot verify the license for this product. You should repair the Office program by using Control Panel.

:::image type="content" source="media/license-issue-when-start-office-application/office-cannot-verify-the-license-for-this-product-error.png" alt-text="Screenshot of the error message that states that Microsoft Office cannot verify the license for this product." border="false":::

## Cause

The Office application is running in compatibility mode for a different operating system, or the software protection platform registry key was deleted during an update of Windows from version 1909 to any other version.

## Resolution

### Check the software protection platform registry entry

1. Select **Start**, enter *regedit*, and then select **Registry Editor** from the search results.

1. Navigate to the following subkey:

    `HKEY_USERS\S-1-5-20\Software\Microsoft\Windows NT\CurrentVersion`

1. If there is a **SoftwareProtectionPlatform** value in the **Current Version** folder, go to the <a href="#stop">Stop running the app in compatibility mode</a>. If there is no such value, go to step 4.

1. On a device that has Office installed and working, open Registry Editor, and navigate to the following subkey:

    `HKEY_USERS\S-1-5-20\Software\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform`

1. Right-click **SoftwareProtectionPlatform**, and select **Export**. Save the registry value as a .reg file to storage media or another location that you can access from the original device.

1. Copy the .reg file to the original device. Then, right-click the file, and select **Merge**.

1. In Registry Editor on the original device, navigate to the following subkey:

    `HKEY_USERS\S-1-5-20\Software\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform`

1. Right-click **SoftwareProtectionPlatform**, and select **Permissions**.

1. Under **Group or user names**, look for an entry for **NETWORK SERVICE**. If you find the entry, go to step 10. If you don't find the entry, select **Add**, enter *network service* in the **Enter the object names to select** field, and then select **OK**.

1. Select **NETWORK SERVICE**, make sure that the **Allow** checkbox next to **Full control** is selected, and then select **Apply** > **OK**.

1. Restart the device, and try again to open an Office app.

<h3 id="stop">Stop running the app in compatibility mode</h3>

1. Exit the Office application that triggers this error.
2. Locate the same Office application. By default, it will be in the following folder, depending on your installation type of Outlook and the bit version of Windows and Outlook:

    - MSI-Based installation type:

        \<disk drive>\Program Files\Microsoft Office\Office**1x**

        \<disk drive>\Program Files(x86)\Microsoft Office\Office**1x**

    - Click-to-Run installation type:

        \<disk drive>\Program Files\Microsoft Office\root\Office**1x**

        \<disk drive>\Program Files(x86)\Microsoft Office\root\Office**1x**

    > [!NOTE]
    > The **1x** placeholder represents your version of Office (16 = Office 2016, 15 = Office 2013).

3. Right-click the Office application that triggers the error, and then select **Properties**.
4. If the **Compatibility** tab is available, select it, and then follow these steps. If the **Compatibility** tab isn't available, go to step 5.

   1. On the **Compatibility** tab, clear the **Run this program in compatibility mode for** option.
   2. Select **Change settings for all users**.
   3. On the **Compatibility for all users** tab, clear the **Run this program in compatibility mode for** option.
   4. Select **OK** two times.

5. If the **Compatibility** tab isn't available, select **Cancel** on the application **Properties** page to close it, and then follow these steps:

   1. Right-click **Outlook.exe**, and then select **Troubleshoot compatibility**.
   2. Select **Troubleshoot Program**.
   3. Clear all options, and then select **Next**.
   4. Select the **No, I am done investigating the problem** option, and then select **Next**.
   5. Select **Close**.

## More information

For more information, see [Outlook is unable to start in Windows 7 or 8](https://support.microsoft.com/help/2968977).
