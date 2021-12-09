---
title: .NET Framework 3.5 installation errors
description: This article describes a problem where you receive an 0x800F0906, 0x800F081F, or 0x800F0907 error code when you try to install the .NET Framework 3.5 in Windows.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:.net-framework-installation, csstroubleshoot
ms.technology: windows-client-application-compatibility
adobe-target: true
---
# .NET Framework 3.5 installation errors: 0x800F0906, 0x800F081F, 0x800F0907, 0x800F0922

This article helps fix Microsoft .NET Framework 3.5 installation errors.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2734782

> [!NOTE]
> Installation of the .NET Framework may throw errors that are not listed in this article, but you might be able to try the following steps to fix those errors as well.

## Windows Server: error code 0x800F0906

This error code occurs because the computer can't download the required files from Windows Update.

To resolve this issue, use one of the following methods:

### Method 1: Check your internet connection

This behavior can be caused by configurations or failures of network, proxy, or firewall. To fix this issue, try to access [Windows Update: FAQ](https://support.microsoft.com/help/12373/windows-update-faq).

If you can't access this website, check your Internet connection. You can also check whether there's a network configuration that blocks access to the website.

### Method 2: Configure the Group Policy setting

This issue occurs because the computer uses Windows Server Update Services (WSUS) instead of the Windows Update server. To fix this issue, system administrator must enable the following Group Policy:

1. Start the Local Group Policy Editor or Group Policy Management Console.
2. Go to **Computer Configuration** \> **Administrative Templates** \> **System**

   :::image type="content" source="media/dotnet-framework-35-installation-error/system-option.svg" alt-text="Screenshot of the System group policy setting window." border="false":::

3. Open the **Specify settings for optional component installation and component repair** Group Policy setting, and then select **Enabled**.

   :::image type="content" source="media/dotnet-framework-35-installation-error/enabled-option.svg" alt-text="Screenshot of the Enabled option of the Specify settings for optional component installation and component repair item." border="false":::

4. Apply one of the following configurations:

   - In the **Alternate source file path** box, specify a fully qualified path of a shared folder. The folder should contain the contents of the `\sources\sxs` folder from the installation media.

     Example of a shared folder path: `\\server_name\share\Win8sxs`.

     Or, specify a WIM file. To do so, add the prefix **WIM:** to the path. Then, add the index of the image to be used in the WIM file as a suffix.

     Example of a WIM file path: `WIM:\\server_name\share\install.wim:3`

     > [!NOTE]
     > In this example, `3` represents the index of the image in which the feature files are found.

   - Select the **Download repair content and optional features directly from Windows Update instead of Windows Server Update Services (WSUS)** option.

5. Select **OK**.
6. At an elevated command prompt, run `gpupdate /force` to apply the policy immediately.

### Method 3: Use Windows installation media

You can use the Windows installation media as the file source for installing the .NET Framework 3.5 feature. To do so, follow these steps:

1. Insert the Windows installation media.
2. At an elevated command prompt, run the following command:

    ```console
    dism /online /enable-feature /featurename:NetFx3 /All /Source:<drive>:\sources\sxs /LimitAccess
    ```

    In this command, \<drive\> is a placeholder for the drive letter of the installation media. For example:

    ```console
    dism /online /enable-feature /featurename:NetFx3 /All /Source:D:\sources\sxs /LimitAccess
    ```

### Method 4: Alternative steps for Windows Server

In Windows Server 2012 R2, you can also specify an alternative source by using PowerShell cmdlets or by using the **Add Roles and Features Wizard**.  

To use Windows PowerShell, follow these steps:

1. Insert the Windows installation media.
2. In an elevated Windows PowerShell command window, run the following command:

   ```powershell
   Install-WindowsFeature name NET-Framework-Core source <drive>:\sources\sxs
   ```

   In this command, \<drive> is a placeholder for the drive letter of the Windows installation media. For example:

   ```powershell
   Install-WindowsFeature name NET-Framework-Core source D:\sources\sxs
   ```

To use the **Add Roles and Features Wizard**, follow these steps:

1. Insert the Windows installation media.
2. Start the **Add Roles and Features Wizard**.
3. On the **Select features** page, select the **.NET Framework 3.5 Features** check box, and then select **Next**.
4. On the **Confirm installation selections** page, select the **Specify an alternate source path** link. The screenshot for this step is listed below.

   :::image type="content" source="media/dotnet-framework-35-installation-error/specify-alternate-source-path.svg" alt-text="Screenshot of the Specify an alternate source path link on the Conform installation selections page." border="false":::  

5. On the **Specify Alternate Source Path** page, type the path of the *SxS* folder as a local path or as a network share path. The screenshot for this step is listed below.

   :::image type="content" source="media/dotnet-framework-35-installation-error/path-of-sxs-folder.svg" alt-text="Screenshot of the Specify Alternate Source Path page." border="false":::  

6. Select **OK**.
7. Select **Install** to finish the wizard.

## Windows Server: error code 0x800F081F

This error code can occur when an alternative installation source is specified and one of the following conditions is true:

- The location that is specified by the path doesn't contain the files that are required to install the feature.
- The user who tries to install the feature doesn't have at least READ access to the location and to the files.
- The set of installation files is corrupted, incomplete, or invalid for the version of Windows that you're running.  

To fix this problem, make sure that the full path of the source is correct (`x:\sources\sxs`) and that you have at least Read access to the location. To do so, try to access the source directly from the affected computer. Verify that the installation source contains a valid and complete set of files. If the problem persists, try to use a different installation source.  

### Windows Server: error code 0x800F0907

The error code occurs when the following conditions are true:

- The **Specify settings for optional component installation and component repair** Group Policy setting is configured to **Never attempt to download payload from Windows Update**
- An alternative installation source isn't specified or is invalid.

To fix this problem, review the policy setting to determine whether it's appropriate for your environment. If you don't want to download feature payloads from Windows Update, consider configuring the **Alternate source file path** value in the Group policy setting.

> [!NOTE]
> You must be a member of the Administrators group to change Group Policy settings on the local computer. If the Group Policy settings for the computer that you want to manage are controlled at the domain level, contact your system administrator.

To do so, follow these steps:

1. Start the Local Group Policy Editor or Group Policy Management Console.
2. Go to **Computer Configuration** \> **Administrative Templates** \> **System**.
3. Open the **Specify settings for optional component installation and component repair** Group Policy setting, and then select **Enabled**.
4. Determine whether the **Never attempt to download payload from Windows Update** Group Policy setting is enabled, and then determine the correct setting for your environment.
5. Apply one of the following configurations:

   - In the **Alternate source file path** box, specify a fully qualified path of a shared folder. The folder should contain the contents of the `\sources\sxs` folder from the installation media.

     Or, specify a WIM file. To do so, add the prefix **WIM:** to the path. Then, add the index of the image to be used in the WIM file as a suffix.

   - Select the **Download repair content and optional features directly from Windows Update instead of Windows Server Update Services (WSUS)** option.

6. Select **OK**.
7. At an elevated command prompt, run `gpupdate /force` to apply the policy immediately.

## Windows 10: error code 0x800F0906, 0x800F081F, or 0x800F0907

To fix the error codes for Windows 10, follow these steps:

1. Download the Windows Media Creation tool. Create an ISO image locally or create an image for the version of Windows that is installed.
2. Configure the Group Policy as in [Method 2](#method-2-configure-the-group-policy-setting), but also follow these steps:

   1. Mount the ISO image that's created in step 1.
   2. Point the **Alternate source file path** to the ISO `sources\sxs` folder from the ISO.
   3. Run the `gpupdate /force` command.
   4. Add the .NET Framework feature.  

## Windows 10: error code 0x800F0922

The following error message occurs when you do Windows 10 upgrade:

> 0x800F0922 CBS_E_INSTALLERS_FAILED: Processing advanced installers and generic commands failed.

> [!NOTE]
> This error code is not specific to .NET Framework.

To fix this issue, follow these steps:

1. Open the .NET Framework installation files folder.
2. Open *Sources* folder.
3. Right-click the *SXS* folder, and then select **Properties**.
4. Select **Security** and make sure that there's a check mark next to **Read & Execute**. If the check mark isn't there, select the **Edit** button and turn it on.
5. At an elevated command prompt, run the following command:

   ```console
   dism /online /enable-feature /featurename:netfx3 /all /source:c:\sxs /limitaccess
   ```

6. In the **Command Prompt** window, run the following command:

   ```console
   dism /online /Cleanup-Image /RestoreHealth
   ```

## More information

These errors may occur when you enable the .NET Framework 3.5 by using one of these methods:

- Installation wizard
- Deployment Image Servicing and Management (DISM) tool
- Windows PowerShell commands

In Windows 10 and Windows Server 2012 R2, the .NET Framework 3.5 is a Feature on Demand. The metadata for Features on Demand is included. However, the binaries and other files associated with the feature aren't included.

When you enable a feature, Windows tries to download the missing information from Windows Update to install the feature. The network configuration and update installation configuration can affect this process. So, you may receive errors when you first install these features.

### Error messages that are associated with these error codes

For error messages of these error codes, see [.NET Framework 3.5 deployment errors and resolution steps](/windows-hardware/manufacture/desktop/net-framework-35-deployment-errors-and-resolution-steps).

### Download the .NET Framework 3.5 outside of the Windows Update requirement

The .NET Framework 3.5 is available for customers with Volume Licensing or MSDN Subscription, as Feature on-Demand Media is available.

### Error codes aren't listed when you install .NET Framework 3.5

For other .NET Framework 3.5 installation error codes that aren't listed in this article, see the following articles:

- [Windows help](https://support.microsoft.com/hub/4338813/windows-help?os=windows-10)
- [Net Framework 3.5 and 4.5 error 0x80070002](https://social.msdn.microsoft.com/Forums/b3175c1d-1eae-414d-91c5-93bfbeba7bb7/net-framework-35-and-45-error-0x80070002?forum=netfxsetup)
- [Install the .NET Framework 3.5 in Windows 10](/dotnet/framework/install/dotnet-35-windows-10)
- [Microsoft .NET Framework 3.5 Deployment Considerations](/previous-versions/windows/it-pro/windows-8.1-and-8/dn482066(v=win.10))
