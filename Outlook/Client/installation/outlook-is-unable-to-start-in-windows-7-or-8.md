---
title: Cannot start Outlook in Windows 7 or 8
description: Outlook can't start on a computer that's running Windows 8 or Windows 7. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Install, Update, Activate, and Deploy\Outlook Deployment issues
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: TasitaE
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Outlook is unable to start in Windows 7 or 8

_Original KB number:_ &nbsp; 2968977

## Symptoms

When you try to start Outlook 2016, Outlook 2013 or Outlook 2010 on a computer that is running Windows 8 or Windows 7, you may receive one of the following error messages and Outlook cannot start.

### Outlook 2016 (MSI) on Windows 8

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/activation-wizard.png" alt-text="Screenshot of the Microsoft Office Activation Wizard window." border="false":::

> Activation Wizard

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/your-trial-has-expired-error.png" alt-text="Screenshot of the trial expired error." border="false":::

> Your trial has expired. Most of the features of Outlook have bene disabled. Choose an option below to reactivate.

### Outlook 2016 (Click-to-Run) or Outlook 2013 (Click-to-Run) on Windows 8  

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/outlook-has-run-into-an-error.png" alt-text="Screenshot of Outlook has run into an error details." border="false":::

> We're sorry, but Outlook has run into an error that is preventing it from working correctly. Outlook will need to be closed as a result. Would you like us to repair now?

### Outlook 2013 (MSI) on Windows 8

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/config-progress.png" alt-text="Screenshot of the error details when configuring Microsoft Office Professional Plus 2013." border="false":::

> Configuring Microsoft Office Professional Plus 2013...

Or

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/cannot-verify-the-license-for-this-product-error.png" alt-text="Screenshot of Microsoft Office cannot verify the license for this product error details." border="false":::

> Microsoft Office cannot verify the license for this product. You should repair the Office program by using Control Panel.

### Outlook 2016 (Click-to-Run or MSI) on Windows 7

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/0xc000001d.png" alt-text="Screenshot of The application was unable to start correctly (0xc000001d) error details." border="false":::

> The application was unable to start correctly (0xc000001d). Click OK to close the application.

### Outlook 2013 (Click-to-Run or MSI) on Windows 7

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/you-need-to-create-a-microsoft-outlook-profile.png" alt-text="Screenshot of You need to create a Microsoft Outlook profile error details." border="false":::

> You need to create a Microsoft Outlook profile. In Microsoft Windows, go to the Control Panel and open Mail. Click Show Profiles, and then click Add.

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/cannot-start-microsoft-outlook-error.png" alt-text="Screenshot of Cannot start Microsoft Outlook error details." border="false":::

> Cannot start Microsoft Outlook. Cannot open the Outlook window. The server is not available. Contact your administrator if this condition persists.

### Outlook 2010 on Windows 8.1 or Windows 8  

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/disconnected.png" alt-text="Screenshot of Disconnected status in the status bar." border="false":::

> Disconnected

### Outlook 2010 on Windows 7

:::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/no-profiles-has-been-created-error.png" alt-text="Screenshot of No Microsoft Outlook profiles have been created error details." border="false":::

> No Microsoft Outlook profiles have been created. In Microsoft Windows, click the Start button, and then click Control Panel. Click User Accounts, and then click Mail. Click Show Profiles, and then click Add.

## Cause

Outlook is running in compatibility mode for a different operating system.

## Resolution

Disable compatibility mode by using the following steps for the appropriate Outlook installation type and version of Windows.

### Outlook 2016 (MSI or Click-to-Run) on Windows 8.1, Windows 8, or Windows 7

1. Find Outlook.exe, which by default is in one of the following directories, depending on your installation type of Outlook and bitness of Windows and Outlook.

    - MSI-Based installation type:

      \<disk drive>\Program Files\Microsoft Office\Office16\  
      \<disk drive>\Program Files(x86)\Microsoft Office\Office16\

    - Click-to-Run installation type:

      \<disk drive>\Program Files\Microsoft Office\root\Office16\  
      \<disk drive>\Program Files(x86)\Microsoft Office\root\Office16\

2. Right-click Outlook.exe, and then select **Properties**.
3. Under the **Compatibility** tab, clear the **Run this program in compatibility mode for** option.

   :::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/clear-run-this-program-in-compatibility-mode-for-option.png" alt-text="Screenshot of the Compatibility tab in Outlook Properties." border="false":::

4. Select **Change settings for all users**.
5. Under the **Compatibility for all users**, clear the **Run this program in compatibility mode for** option.

   :::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/compatibility-mode-setting.png" alt-text="Screenshot of the Compatibility for all users settings." border="false":::

6. Select **OK** two times.

### Outlook 2013 (MSI or Click-to-Run) on Windows 8.1

1. Find Outlook.exe, which by default is in one of the following directories, depending on your installation type of Outlook and bitness of Windows and Outlook:

    - MSI-based installation type:

      \<disk drive>\Program Files\Microsoft Office\Office15\  
      \<disk drive>\Program Files(x86)\Microsoft Office\Office15\

    - Click-to-Run installation type:

      \<disk drive>\Program Files\Microsoft Office 15\root\Office15\  
      \<disk drive>\Program Files(x86)\Microsoft Office 15\root\Office15\

2. Right-click Outlook.exe,  and then select **Troubleshoot compatibility**.
3. Select **Troubleshoot Program**.

   :::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/troubleshoot-program.png" alt-text="Screenshot for Outlook 2013 Compatibility mode setting." border="false":::

4. Clear all options, and then select **Next**.

   :::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/clear-all-options.png" alt-text="Screenshot of problems selection in Outlook 2013 Compatibility mode setting." border="false":::

5. Select the third option, **No, I am done investigating the problem...**, and then select **Next**.

   :::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/select-the-third-option.png" alt-text="Screenshot of the try again option in Outlook 2013 Compatibility mode setting." border="false":::

6. Select **Close**.

### Outlook 2013 (MSI or Click-to-Run) on Windows 8 or Windows 7

1. Find **Outlook.exe**, which by default is in one of the following directories:

   - MSI-based installation type:

     \<disk drive>\Program Files\Microsoft Office\Office15\
     \<disk drive>\Program Files(x86)\Microsoft Office\Office15\

   - Click-to-Run installation type:

      \<disk drive>\Program Files\Microsoft Office 15\root\Office15\
      \<disk drive>\Program Files(x86)\Microsoft Office 15\root\Office15\

2. Right-click **Outlook.exe**, select **Properties**.
3. Under the **Compatibility** tab, clear the **Run this program in compatibility mode for** option:

   :::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/compatibility-mode-setting-1.png" alt-text="Screenshot of the Compatibility tab in Outlook Properties in Outlook 2013." border="false":::

4. Select **Change settings for all users**.
5. On the **Compatibility for all users** tab, clear the **Run this program in compatibility mode for** option.

   :::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/compatibility-mode-setting-2.png" alt-text="Screenshot of the Compatibility for all users settings in Outlook 2013." border="false":::

6. Select **OK** two times.

### Outlook 2010 on Windows 8.1, Windows 8, or Windows 7

1. Find Outlook.exe, which by default is in one of the following directories, depending on your bitness of Windows and Outlook:

    \<disk drive>\Program Files\Microsoft Office\Office14\  
    \<disk drive>\Program Files(x86)\Microsoft Office\Office14\

2. Right-click Outlook.exe, and then select **Properties**.
3. Under the **Compatibility** tab, clear the **Run this program in compatibility mode for** option.

   :::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/compatibility-mode-setting-for-outlook-2010.png" alt-text="Screenshot of the Compatibility tab in Outlook Properties in Outlook 2010." border="false":::

4. Select **Change settings for all users**.
5. Under the **Compatibility for all users** tab, clear the **Run this program in compatibility mode for** option.

   :::image type="content" source="media/outlook-is-unable-to-start-in-windows-7-or-8/compatibility-for-all-user-tab.png" alt-text="Screenshot of the Compatibility for all users settings in Outlook 2010." border="false":::

6. Select **OK** two times.

## More information

For more information, see ["Microsoft Office cannot verify the license for this product" error when you start an Office app](/office/troubleshoot/activation/license-issue-when-start-office-application).
