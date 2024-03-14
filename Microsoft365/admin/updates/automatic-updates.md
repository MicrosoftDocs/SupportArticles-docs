---
title: Automatic updating for Microsoft Office is not enabled
description: Provides the steps to re-enable the automatic updates for Office 2016 and 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: gregmans
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365 Apps
  - Office LTSC Standard 2021
  - Office LTSC Professional Plus 2021
  - Office Standard 2019
  - Office Professional Plus 2016
  - Office Standard 2016
  - Office Home and Business 2013
  - Office Home and Student 2013
  - Office Professional 2013
  - Office Professional Plus 2013
  - Office Standard 2013
ms.date: 03/31/2022
---

# Automatic updating for Microsoft Office is not enabled

## Symptoms

By default, installations of Microsoft Office are configured to automatically update your Office installation when new updates are made publicly available. However, if you examine the Account section of the backstage, you may see that updates are disabled or that the command to manage updates is disabled or hidden. For example, the following figure indicates that updates are disabled in the backstage.

:::image type="content" source="./media/automatic-updates/updates-are-disabled-in-the-backstage.png" alt-text="Screenshot indicates that updates are disabled in the backstage.":::

## Cause

This issue occurs if updates have been manually disabled or are managed through Group Policy settings.

## Resolution

We recommend that you keep automatic updating enabled for Office installations because this configuration allows Office to automatically update with the latest fixes and security features. To re-enable automatic updates for Office, follow the steps below.

- **Manually configure automatic updates**

  If your Office installation is not managed by Group Policy, you can manually re-enable automatic updates by following these steps. If you cannot follow these steps because the **Update Options** control is disabled or missing, your updates are being managed by Group Policy.
  1. Start any program.
  1. On the **File** tab, select **Account**. <br/>**Note:** In Outlook, select **Office Account**.
  1. On the right side, select **Update Options**, and then select **Enable Updates**.
  1. If you are asked whether you want to let Microsoft Office make changes to your computer, select **Yes**.

- **Automatic updates managed by Group Policy**

  > [!WARNING]
  > Follow the steps in this section carefully. Serious problems might occur if you modify the  registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

  If you cannot follow the steps in the "Manually configure automatic updates" section, this is because the **Update Options** control is disabled or missing due to a Group Policy. For example, the following figure shows the **Update Options** control when the **Enable Updates** option is hidden through a Group Policy:

     :::image type="content" source="./media/automatic-updates/update-options.png" alt-text="Screenshot shows the Update Options control when the Enable Updates option is hidden through a Group Policy.":::

  To examine the registry data that is associated with the Group Policy settings which control this feature, follow these steps:

   1. Start Registry Editor. To do this, take one of the following actions:  

      - In Windows 10 or Windows 8, press the Windows key + X, select **Run**, type regedit in the **Open** box, and then press **Enter**.
      - In Windows 7 and Windows Vista, select **Start**, type regedit in the **Start Search** box, and then press Enter. If you are prompted for an administrator password or for confirmation, type the password, or select **Allow**.

   2. Locate and then select the following registry key:

        **Note:** If this key does not exist in your Registry Editor, see How to add the registry key via policy below.

        **Microsoft 365 Apps for enterprise, Office LTSC 2021, Office 2019, and Office 2016**

        `HKEY_LOCAL_MACHINE\software\policies\microsoft\office\16.0\common\OfficeUpdate`

        **Office 2013**

        `HKEY_LOCAL_MACHINE\software\Wow6432Node\microsoft\office\15.0\common\OfficeUpdate`
  
   3. Examine the following registry values under the \OfficeUpdate key:

        - DWORD: EnableAutomaticUpdates<br/>
          Values:<br/>
          0 = automatic updates are disabled<br/>
          1 = automatic updates are enabled

        - DWORD: HideEnableDisableUpdates<br/>
          Values:<br/>
          1 = hide the menu option to enable or disable automatic updates<br/>
          0 = show the menu option to enable or disable automatic updates

   4. If you have any questions or concerns about these policy settings, see your domain administrator.

### How to add the registry key via policy

The registry key is added automatically when you install ADMX/ADML files. To do this:

#### Microsoft 365 Apps for enterprise, Office LTSC 2021, Office 2019, and Office 2016

1. Always download the LATEST admin templates to a location of your choice:

    [Administrative Template files (ADMX/ADML) and Office Customization Tool for Microsoft 365 Apps for enterprise, Office 2019, and Office 2016](https://www.microsoft.com/download/details.aspx?id=49030)

1. Select the **Download** button.
1. Select either the x64 or the x86 build.
1. Select **Run** and follow the prompts to install the software.
1. Copy the \*.admx files into the *C:/Windows/PolicyDefinitions/* folder.
1. Copy the \*.adml files from the language-locale subfolder (for instance, "en-US") into the respective language-locale folder under *C:/Windows/PolicyDefinitions/*.

> [!WARNING]
> Be sure to preserve the same language-locale PolicyDefinitions folder which is applicable to your environment.

#### Office 2013

1.    Go to the [Office 2013 Administrative Template files (ADMX/ADML) and Office Customization Tool](https://www.microsoft.com/download/details.aspx?id=35554) page. 
2.    Select the **Download** button. 
3.    Select either the x64 or the x86 build. 
4.    Select **Run** and follow the prompts to install the software. 
5.    Copy the *.admx files into the C:/Windows/PolicyDefinitions/ folder.
6.    Copy the *.adml files from the language-locale subfolder (for instance, "en-US") into the respective language-locale folder under C:/Windows/PolicyDefinitions/.

> [!WARNING]
> Be sure to preserve the same language-locale PolicyDefinitions folder which is applicable to your environment.

After you copy the Administrative Template files to AD DS, you'll find the update policy settings under **Computer Configuration** > **Policies** > **Administrative Templates** > **Microsoft Office 2016 (Machine)** > **Updates in the Group Policy Management Console**. You'll also find a description of how to configure each policy setting.

## More information

For more information about configuring the update settings via GPO, see [Configure update settings for Microsoft 365 Apps for enterprise](/deployoffice/configure-update-settings-for-office-365-proplus).
