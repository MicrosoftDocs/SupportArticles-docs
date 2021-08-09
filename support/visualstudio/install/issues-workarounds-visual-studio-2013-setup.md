---
title: Common issues in Visual Studio 2013 setup
description: This article describes common issues during Visual Studio installation, and provides suggested workarounds.
ms.date: 04/13/2020
ms.prod-support-area-path: Installation
---
# Common issues and workarounds in Visual Studio 2013 setup

This article helps you resolve problems that occur when you install Microsoft Visual Studio 2013.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 2899270

## Symptoms

Visual Studio can't be installed, and you receive an error message that contains one of the following errors:

- [0x80200010, 0x80072efe, or 0x80072ee7 - connectivity issue during download](#0x80200010-0x80072efe-or-0x80072ee7---connectivity-issue-during-download)
- [0x80070005 - Access denied](#0x80070005---access-denied)
- [0x80070643 - Installation cache or ISO is corrupted](#0x80070643---installation-cache-or-iso-is-corrupted)
- [0x800713ec - .NET Framework installation is in progress](#0x800713ec---net-framework-installation-is-in-progress)
- [Multiple feature installation errors occur after warning about certificate updates is ignored](#multiple-feature-installation-errors-occur-after-warning-about-certificate-updates-is-ignored)
- [Shortcuts - Some shortcut names still indicate Preview after a newer version is installed](#shortcuts---some-shortcut-names-still-indicate-preview-after-a-newer-version-is-installed)

If the Visual Studio installation issue that you're experiencing isn't listed, see [More information](#more-information) for further helps.  

To work around these issues, try one or more of the following methods.

## 0x80200010, 0x80072efe, or 0x80072ee7 - connectivity issue during download

This error typically occurs when the Visual Studio installer experiences issues that affect your Internet connection during the download of required components. When you receive one of these error messages, try again to install Visual Studio after your Internet connection improves. If you continue to see this error, try the following methods:

- Install Visual Studio from a different source. For example, if you installed Visual Studio from [VisualStudio.com](https://visualstudio.microsoft.com/downloads/) or from the [Microsoft Download Center](https://www.microsoft.com/download), try downloading Visual Studio from [MSDN](https://msdn.microsoft.com//subscriptions/securedownloads).
- Install Visual Studio by using the `layout` switch or an ISO file. For more information about how to do it, see [Install Visual Studio 2015](/visualstudio/install/install-visual-studio-2015).

## 0x80070005 - Access Denied

This error occurs when Visual Studio can't access one or more of the required installation files. This error may occur for any of the following reasons:

- An outside process, such as an antivirus or anti-malware application, has locked a Visual Studio installation file at the same time that Visual Studio is trying to install the file. To work around this issue, coordinate with your system administrator or other IT professional to make sure that Visual Studio files aren't locked by these processes.

- The user who is trying to install Visual Studio doesn't have administrator credentials on the computer. To successfully install Visual Studio, you must be logged in as an administrator.

- Permissions on some registry hives can prevent Visual Studio from installing successfully. To resolve this issue, reference [Solving setup errors by using the SubInACL tool](/archive/blogs/astebner/solving-setup-errors-by-using-the-subinacl-tool-to-repair-file-and-registry-permissions).

## 0x80070643 - Installation cache or ISO is corrupted

This error typically occurs when a file that is related to the installation becomes corrupted. You may experience this [error when you install Visual Studio by using an ISO or DVD burned from ISO](#error-when-you-install-from-an-iso-or-a-dvd-burned-from-an-iso). You may also experience this [error during a repair](#error-during-a-repair) of Visual Studio.  

### Error when you install from an ISO or a DVD burned from an ISO

If you use an ISO file for your installation of Visual Studio, or if you use a digital video disc (DVD) that was burned from an ISO file, the ISO file may become corrupted during the download process. Follow these steps:

1. Download and install the Microsoft File Checksum Integrity Verifier tool.

    > [!NOTE]
    > To use this tool, you must know the file path of the ISO file.

2. During the installation of the tool, you're prompted to provide a directory in which the files are to be extracted.

    > [!NOTE]
    > The directory for later access. For example, you can extract the files to the `C:\TEMP\fciv` location.

3. At a command prompt, type the following command, and then press Enter.

    ```console
    <DIRECTORY_NAME>\fciv.exe -sha1 <ISO_NAME>
    ```

    > [!NOTE]
    >In this command, the *\<DIRECTORY NAME>* placeholder is the folder to which you extracted the files, and the *\<ISO_NAME>* placeholder is the path of the Visual Studio ISO file. For more information, see the *ReadMe.htm* file in the extraction directory.

4. Verify that the Secure Hash Algorithm 1 (SHA-1) value that is returned by the File Checksum tool matches the expected value. To determine the expected value, examine the folder to which you downloaded the ISO file.

    > [!NOTE]
    > The expected SHA-1 value is different for each download source.

    1. If you downloaded the ISO file from MSDN, the SHA-1 value is provided in the **Details** section for each ISO file.

    2. If you downloaded the ISO file from the [Download Center](https://www.microsoft.com/download), you can find the SHA-1 value by expanding the Install Instructions section of the product page.

If the expected SHA-1 value doesn't match the value that is returned by the File Checksum tool, the ISO file is corrupted. In this case, delete the file, and then download it again.

- If you obtained the ISO file from a DVD, try to download the Visual Studio web installer or ISO file from [MSDN](https://msdn.microsoft.com//subscriptions/securedownloads) or [Microsoft Download Center](https://www.microsoft.com/download), and then try the installation again.

- If you purchased the DVD from a retail store, you might also be able to download Visual Studio from the store's website. Then use the license key that was provided together with the DVD to activate Visual Studio. Contact the retail store for more information about this process.

### Error during a repair

If the error occurs when you try to repair Visual Studio, your installation cache may have become corrupted. To repair the cache, follow these steps:

1. Close Visual Studio.
2. Open an elevated command prompt. To do it, select **Start**, type *cmd* in the **Start** search box, right-click *cmd.exe* in the results list, and then select **Run as administrator**.
3. At the command prompt, type `cd C:\ProgramData\Package Cache`, and then press Enter.
4. To clear the *.msi* and *.cab* files from the cache, type the following commands at the command prompt, and press Enter after each command:

    ```console
    Delete /F /S *.msi Delete /F /S *.cab
    ```

5. Try again to repair Visual Studio.  

## 0x800713ec - .NET Framework installation is in progress

This error typically occurs when an installation of the .NET Framework that is separate from Visual Studio is already in progress. Because many components of the Visual Studio installer depend on the .NET Framework, an attempt to install the .NET Framework while Visual Studio is being installed can cause unexpected behavior.

To work around this issue, wait for the .NET Framework installer to finish before you install Visual Studio.

## Multiple feature installation errors occur after warning about certificate updates is ignored

When you install Visual Studio on Windows 7, you receive the following warning:

> Installation errors may occur because the security certificate updates that are required to install some Visual Studio components cannot be applied to this computer.

If you select **Continue** to proceed with the Visual Studio installation, you may encounter the **Unable to locate package source** errors that aren't resolved through the Download packages from the internet option. When the Visual Studio installation finishes, you see the following message:

> Setup Completed. However, not all features installed correctly.

You are also shown a list of multiple features that couldn't be installed because the system can't find the file specified. To fix the issue, try the following method:

- Ensure that you are on a computer that's connected to the internet.
In some cases, Visual Studio can programmatically retrieve and then apply the required certificate updates so that the affected features can be successfully installed.

- Check the group policy setting on your computer that controls automatic certificate updates. To check the setting, open the Group Policy Editor (gpedit.msc). From the Local Group Policy Editor, under **Computer Configuration**, expand **Administrative Templates**, expand **Internet Communication Management**, and then select **Internet Communication settings**. The setting that controls automatic certificate updates is **Turn off Automatic Root Certificates Update**. For Visual Studio to automatically retrieve and apply the required certificates, this setting should be **Disabled**.

    > [!NOTE]
    > We recommend that you contact your system administrator before you modify any group policy setting.

- If the above steps don't resolve the issue, you can also try to manually install the required certificate updates. For information on how to obtain Windows update root certificates, see [Configure Trusted Roots and Disallowed Certificates](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983(v=ws.11)).

If you have already installed Visual Studio 2013, try to repair Visual Studio after you have tried one or more of the above methods. This process attempts to successfully install the features that didn't install on the previous attempt. To repair Visual Studio, open **Programs and Features** (appwiz.cpl). From the **Programs and Features** window, right-click **Visual Studio 2013** and select **Change**, and then select **Repair** to initiate the repair process.

> [!NOTE]
> This error applies only to Windows 7 Service Pack 1 (SP1). Windows 8 and later versions of Windows have these certificate updates installed by default.

## Shortcuts - Some shortcut names still indicate Preview after a newer version is installed

If you installed Visual Studio 2013 Preview and then installed a newer version of Visual Studio 2013 without first uninstalling Preview, some Visual Studio shortcut names aren't correctly updated to indicate that a new version is installed. While the name is incorrect, the shortcuts correctly point to the newer Visual Studio installation, so it isn't necessary to take any action. However, if you prefer to fix the shortcut names, you can try the following steps:

1. Uninstall Visual Studio 2013. To uninstall, open **Programs and Features** (appwiz.cpl). From the **Programs and Features** window, right-click **Visual Studio 2013** and select **Change**, and then select **Uninstall**.

2. Manually delete any shortcuts that have been left behind.
    1. Open an elevated command prompt.
    2. At the command prompt, type the following command, and then press Enter:

        ```console
        rmdir /S "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Microsoft Visual Studio 2013"
        ```

3. Enter `Y` to confirm that you want to delete the folder and its contents.
4. Reinstall the latest version of Visual Studio.

## More information

If this article doesn't address the Visual Studio installation issue that you're experiencing, visit the [Visual Studio Setup and Installation forum](https://social.msdn.microsoft.com/Forums/vstudio/home?forum=vssetup) to find more information.

Or, you may post your Visual Studio installation log file to the [Visual Studio Setup and Installation forum](https://social.msdn.microsoft.com/Forums/vstudio/home?forum=vssetup) and [Microsoft Community](https://answers.microsoft.com/) for further helps.

To do it, follow these steps:

1. Download the [Microsoft Visual Studio and .NET Framework Log Collection Tool](https://www.microsoft.com/download/details.aspx?id=12493) (collect.exe).
2. Run the collect.exe tool from the directory where you saved the tool.
3. The utility creates a compressed cabinet file of all the Visual Studio and .NET logs to `%TEMP%\vslogs.cab`.
4. Post the *vslogs.cab* file with some descriptions of your issue to the forum.
