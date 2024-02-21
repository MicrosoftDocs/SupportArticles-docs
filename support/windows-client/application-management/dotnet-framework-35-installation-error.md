---
title: .NET Framework 3.5 installation errors
description: This article describes a problem where you receive an 0x800F0906, 0x800F081F, or 0x800F0907 error code when you try to install the .NET Framework 3.5 in Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:.net-framework-installation, csstroubleshoot
adobe-target: true
---

<!---Internal note: The screenshots in the article are being or were already updated. Please contact "gsprad" and "christys" for triage before making the further changes to the screenshots.
--->

# .NET Framework 3.5 installation errors: 0x800F0906, 0x800F081F, 0x800F0907, 0x800F0922

This article helps fix Microsoft .NET Framework 3.5 installation errors.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2734782

> [!NOTE]
> Installation of the .NET Framework may throw errors that are not listed in this article, but you might be able to try the following steps to fix those errors as well.
> Microsoft is releasing Out-of-band (OOB) updates for .NET Framework. [.NET Framework Out-of-band update to address issues after installing the January 11, 2022 Windows update](/windows/release-health/windows-message-center#359)

## Resolutions for Windows Server

You may receive the following errors when you install the .NET Framework 3.5 in Windows Server:

- [Error code 0x800F0906](#error-code-0x800f0906)
- [Error code 0x800F081F](#error-code-0x800f081f)
- [Error code 0x800F0907](#error-code-0x800f0907)

### Error code 0x800F0906

This error code occurs because the computer cannot download the required files from Windows Update.

To resolve this issue, use one of the following methods:

#### Method 1: Check your internet connection

This behavior can be caused by network, proxy, or firewall configurations or by network, proxy, or firewall failures. To fix this problem, try to connect to the [Microsoft Update](https://support.microsoft.com/help/12373/windows-update-faq) website.

If you cannot access this website, check your Internet connection, or contact the network administrator to determine whether there is a configuration that blocks access to the website.

#### Method 2: Configure the Group Policy setting

This behavior can also be caused by a system administrator who configures the computer to use Windows Server Update Services (WSUS) instead of the Windows Update server for servicing. In this case, contact your system administrator and request that they enable the **Specify settings for optional component installation and component repair** Group Policy setting and configure the **Alternate source file path** value or select the **Contact Windows Update directly to download repair content instead of Windows Server Update Services (WSUS)** option.

To configure the Group Policy setting, follow these steps:

1. Start the Local Group Policy Editor or Group Policy Management Console.

    Point to the upper-right corner of the screen, click **Search**, type group policy, and then click **Edit group policy**.

2. Expand **Computer Configuration**, expand **Administrative Templates**, and then select **System**. The screenshot for this step is listed below.

    :::image type="content" source="media/dotnet-framework-35-installation-error/system-option.svg" alt-text="Screenshot of the System group policy setting window." border="false":::

3. Open the **Specify settings for optional component installation and component repair** Group Policy setting, and then select **Enabled**. The screenshot for this step is listed below.

    :::image type="content" source="media/dotnet-framework-35-installation-error/enabled-option.svg" alt-text="Screenshot of the Enabled option of the Specify settings for optional component installation and component repair item." border="false":::

4. If you want to specify an alternative source file, in the **Alternate source file path** box, specify a fully qualified path of a shared folder that contains the contents of the `\sources\sxs` folder from the installation media.  

    Example of a shared folder path: `\\server_name\share\Win8sxs`

    Or, specify a WIM file. To specify a WIM file as an alternative source file location, add the prefix **WIM:** to the path, and then add the index of the image that you want to use in the WIM file as a suffix.

    Example of a WIM file path: `WIM:\\server_name\share\install.wim:3`

    > [!NOTE]
    > In this example, `3` represents the index of the image in which the feature files are found.

5. If it is applicable to do this, select the **Contact Windows Update** directly to download repair content instead of **Windows Server Update Services (WSUS)** check box.

6. Tap or click **OK**.

7. At an elevated command prompt, type `gpupdate /force`, and then press **Enter** to apply the policy immediately.

#### Method 3: Use Windows installation media

You can use the Windows installation media as the file source when you enable the .NET Framework 3.5 feature. To do this, follow these steps:

1. Insert the Windows installation media.

1. At an elevated command prompt, run the following command:

    ```console
    Dism /online /enable-feature /featurename:NetFx3 /All /Source:<drive>:\sources\sxs /LimitAccess
    ```

    In this command, \<drive> is a placeholder for the drive letter for the DVD drive. For example, you run the following command:

    ```console
    Dism /online /enable-feature /featurename:NetFx3 /All /Source:D:\sources\sxs /LimitAccess
    ```

#### Method 4: Alternative steps for Windows Server

In Windows Server 2012 R2, you can also specify an alternative source by using Windows PowerShell cmdlets or by using the **Add Roles and Features Wizard**.  

To use Windows PowerShell, follow these steps:

1. Insert the Windows installation media.
2. In an elevated Windows PowerShell command window, run the following command:

    ```powershell
    Install-WindowsFeature name NET-Framework-Core source <drive>:\sources\sxs
    ```

     In this command, \<drive> is a placeholder for the drive letter for the DVD drive or for the Windows installation media. For example, you run the following command:

    ```powershell
    Install-WindowsFeature name NET-Framework-Core source D:\sources\sxs
    ```

To use the **Add Roles and Features Wizard**, follow these steps:

1. Insert the Windows installation media.
2. Start the **Add Roles and Features Wizard**.
3. On the **Select features** page, select the **.NET Framework 3.5 Features** check box, and then click **Next**.
4. On the **Confirm installation selections** page, click the **Specify an alternate source path** link. The screenshot for this step is listed below.

    :::image type="content" source="media/dotnet-framework-35-installation-error/specify-alternate-source-path.svg" alt-text="Screenshot of the Specify an alternate source path link on the Conform installation selections page." border="false":::  

5. On the **Specify Alternate Source Path** page, type the path of the _SxS_ folder as a local path or as a network share path. The screenshot for this step is listed below.

    :::image type="content" source="media/dotnet-framework-35-installation-error/path-of-sxs-folder.svg" alt-text="Screenshot of the Specify Alternate Source Path page." border="false":::  

6. Click **OK**.
7. Click **Install** to finish the wizard.

### Error code 0x800F081F

This error code can occur when an alternative installation source is specified and one of the following conditions is true:

- The location that is specified by the path does not contain the files that are required to install the feature.
- The user who tries to install the feature does not have at least READ access to the location and to the files.
- The set of installation files is corrupted, incomplete, or invalid for the version of Windows that you are running.  

To fix this problem, make sure that the full path of the source is correct (`x:\sources\sxs`) and that you have at least Read access to the location. To do this, try to access the source directly from the affected computer. Verify that the installation source contains a valid and complete set of files. If the problem persists, try to use a different installation source.  

### Error code 0x800F0907

This error code occurs if an alternative installation source is not specified or is invalid and if the **Specify settings for optional component installation and component repair** Group Policy setting is configured to **Never attempt to download payload from Windows Update**.

To fix this problem, review the policy setting to determine whether it is appropriate for your environment. If you do not want to download feature payloads from Windows Update, consider configuring the **Alternate source file path** value in the Group policy setting.

> [!NOTE]
> You must be a member of the Administrators group to change Group Policy settings on the local computer. If the Group Policy settings for the computer that you want to manage are controlled at the domain level, contact your system administrator.

To do this, follow these steps:

1. Start Local Group Policy Editor or Group Policy Management Console as applicable in your environment.

1. Expand **Computer Configuration**, expand **Administrative Templates**, and then select **System**.

1. Open the **Specify settings for optional component installation and component repair** Group Policy setting, and then select **Enabled**.

1. Determine whether the **Never attempt to download payload from Windows Update** Group Policy setting is enabled, and then determine the desired setting for your environment.

1. If you want to specify an alternate source file, in the **Alternate source file path** box, specify a fully qualified path of a shared folder that contains the contents of the `\sources\sxs` folder from the installation media. Or, specify a WIM file. To specify a WIM file as an alternative source file location, add the prefix **WIM:** to the path, and then add the index of the image that you want to use in the WIM file as a suffix. The following are examples of values that you can specify:

   - Path of a shared folder: `\\server_name\share\Win8sxs`
   - Path of a WIM file, in which `3` represents the index of the image in which the feature files are found:  
     `WIM:\\server_name\share\install.wim:3`

1. If you want, select the **Contact Windows Update directly to download repair content instead of Windows Server Update Services (WSUS)** check box.

1. Tap or click **OK**.

1. At an elevated command prompt, type the `gpupdate /force`, and then press **Enter** to apply the policy immediately.

## Resolution for Windows 10

- **Error code 0x800F0906, 0x800F081F, or 0x800F0907**

    To fix the error codes for Windows 10, follow these steps:

    1. Download the Windows Media Creation tool, and create an ISO image locally, or create an image for the version of Windows that you have installed.

    1. Configure the Group Policy as in [Method 2](#method-2-configure-the-group-policy-setting), but also follow these steps:

       1. Mount the ISO image that's created in step 1.
       2. Point the **Alternate source file path** to the ISO `sources\sxs` folder from the ISO.
       3. Run the `gpupdate /force` command.
       4. Add the .NET Framework feature.  

- **Error code 0x800F0922**

    The following error message occurs when you do Windows 10 upgrade:

    > 0x800F0922 CBS_E_INSTALLERS_FAILED: Processing advanced installers and generic commands failed.

    > [!NOTE]
    > This error code is not specific to .NET Framework.

    To fix this issue, follow these steps:

    1. Open the .NET Framework installation files folder.
    2. Open _Sources_ folder.
    3. Right-click the _SXS_ folder, and then click **Properties**.
    4. Click **Security** and make sure that there is a check mark next to **Read & Execute**. If the check mark isn't there, click the **Edit** button and turn it on.
    5. Press Windows Key + X keyboard shortcut.  
    6. Click **Command Prompt (Admin)**.  
    7. In the **Command Prompt** window, type the following command and press Enter:

        ```console
        dism /online /enable-feature /featurename:netfx3 /all /source:c:\sxs /limitaccess
        ```

    8. In the **Command Prompt** window, type the following command and press Enter:

        ```console
        dism /online /Cleanup-Image /RestoreHealth
        ```

## More information

These errors may occur when you use an installation wizard, the Deployment Image Servicing and Management (DISM) tool, or Windows PowerShell commands to enable the .NET Framework 3.5.

In Windows 10 and Windows Server 2012 R2, the .NET Framework 3.5 is a Feature on Demand. The metadata for Features on Demand is included. However, the binaries and other files associated with the feature are not included. When you enable a feature, Windows tries to contact Windows Update to download the missing information to install the feature. The network configuration and how computers are configured to install updates in the environment can affect this process. Therefore, you may encounter errors when you first install these features.

### Error messages that are associated with these error codes

| Error code| Error messages |
|---|---|
| 0x800F0906|The source files could not be downloaded. <br/> Use the **source** option to specify the location of the files that are required to restore the feature. For more information on specifying a source location, see `http://go.microsoft.com/fwlink/?LinkId=243077`. <br/> The DISM log file can be found at C:\Windows\Logs\DISM\dism.log. <br/><br/> Windows couldn't complete the requested changes. <br/> Windows couldn't connect to the Internet to download necessary files. Make sure that you're connected to the Internet, and click **Retry** to try again. <br/><br/> Installation of one or more roles, role services, or features failed. <br/> The source files could not be found. Try installing the roles, role services, or features again in a new Add Roles and Features Wizard session, and on the Confirmation page of the wizard, click **Specify an alternate source path** to specify a valid location of the source files that are required for the installation. The location must be accessible by the computer account of the destination server. <br/> <br/>0x800F0906 - CBS_E_DOWNLOAD_FAILURE <br/><br/> Error code: 0x800F0906 <br/><br/> Error: 0x800f0906|
| 0x800F081F|The source files could not be found.<br/> Use the **Source** option to specify the location of the files that are required to restore the feature. For more information on specifying a source location, see `http://go.microsoft.com/fwlink/?LinkId=243077`. <br/> The DISM log file can be found at C:\Windows\Logs\DISM\dism.log <br/> <br/>0x800F081F - CBS_E_SOURCE_MISSING <br/><br/> Error code: 0x800F081F <br/><br/> Error: 0x800F081F|
| 0x800F0907|DISM failed. No operation was performed.<br/>For more information, review the log file. <br/> The DISM log file can be found at C:\Windows\Logs\DISM\dism.log <br/><br/>Because of network policy settings, Windows couldn't connect to the Internet to download files that are required to complete the requested changes. Contact your network administrator for more information. <br/><br/> 0x800F0907 - CBS_E_GROUPPOLICY_DISALLOWED <br/><br/> Error code: 0x800F0907 <br/><br/>Error: 0x800F0907|
  
### Download the .NET Framework 3.5 outside of the Windows Update requirement

The .NET Framework 3.5 is available for customers with Volume Licensing or MSDN Subscription, as Feature on-Demand Media is available.

### Error codes are not listed when you install .NET Framework 3.5

When you install .NET Framework 3.5, you may encounter other error codes that are not listed in this article, for more information, go to the following articles:

- [Windows help](https://support.microsoft.com/hub/4338813/windows-help?os=windows-10)

- [Net Framework 3.5 and 4.5 error 0x80070002](https://social.msdn.microsoft.com/Forums/b3175c1d-1eae-414d-91c5-93bfbeba7bb7/net-framework-35-and-45-error-0x80070002?forum=netfxsetup)

- [Install the .NET Framework 3.5 in Windows 10](/dotnet/framework/install/dotnet-35-windows)

- [Microsoft .NET Framework 3.5 Deployment Considerations](/previous-versions/windows/it-pro/windows-8.1-and-8/dn482066(v=win.10))
