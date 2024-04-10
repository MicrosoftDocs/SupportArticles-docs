---
title: Common issues in Visual Studio setup
description: This article describes common issues during Visual Studio installation and provides suggested workarounds.
ms.date: 07/27/2022
ms.reviewer: v-jayaramanp
ms.custom: sap:Installation
---
# Common issues and workarounds in Visual Studio setup

This article helps you resolve issues that occur when you install Microsoft Visual Studio.

_Original product version:_ &nbsp; Visual Studio 2012, Visual Studio 2013, Visual Studio 2015  
_Original KB number:_ &nbsp; 2899270

## Symptoms

Visual Studio can't be installed, and you receive an error message that contains one of the following errors:

- [0x80200010, 0x80072efe, or 0x80072ee7 - connectivity issue during download](#0x80200010-0x80072efe-or-0x80072ee7---connectivity-issue-during-download)
- [0x80070005 - Access denied](#0x80070005---access-denied)
- [0x80070643 - Installation cache or ISO is corrupted](#0x80070643---installation-cache-or-iso-is-corrupted)
- [0x800713ec - .NET Framework installation is in progress](#0x800713ec---net-framework-installation-is-in-progress)
- [Multiple feature installation errors occur after warning about certificate updates is ignored in Visual Studio 2013 and 2015](#multiple-feature-installation-errors-occur-after-warning-about-certificate-updates-is-ignored-in-visual-studio-2013-and-2015)

If the Visual Studio installation issue that you're experiencing isn't listed, see [More information](#more-information) for further help.  

To work around these issues, try one or more of the following methods:

## 0x80200010, 0x80072efe, or 0x80072ee7 - connectivity issue during download

These errors typically occur when the Visual Studio installer experiences issues that affect your internet connection during the download of required components. When you receive one of these error messages, try again to install Visual Studio after your internet connection improves. If you continue to see this error, try the following methods:

- Install Visual Studio from a different source. For example, if you installed Visual Studio from [VisualStudio.com](https://visualstudio.microsoft.com/downloads/) or [Microsoft Download Center](https://www.microsoft.com/download), try downloading Visual Studio from [MSDN](https://msdn.microsoft.com//subscriptions/securedownloads).

- Install Visual Studio by using the `layout` switch or an ISO file. For more information about how to do it, see [Install Visual Studio 2015](/previous-versions/visualstudio/visual-studio-2015/install/install-visual-studio-2015).

## 0x80070005 - Access Denied

This error occurs when Visual Studio can't access one or more of the required installation files. This error may occur for any of the following reasons:

- An outside process, such as an antivirus or anti-malware application, has locked a Visual Studio installation file at the same time that Visual Studio is trying to install the file. To work around this issue, coordinate with your system administrator or other IT professional to make sure that these processes don't lock Visual Studio files.

- The user who is trying to install Visual Studio doesn't have administrator credentials on the computer. To successfully install Visual Studio, you must be logged in as an administrator.

- Permissions on some registry hives can prevent Visual Studio from installing successfully. To resolve this issue, see [Solving setup errors by using the SubInACL tool](/archive/blogs/astebner/solving-setup-errors-by-using-the-subinacl-tool-to-repair-file-and-registry-permissions).

## 0x80070643 - Installation cache or ISO is corrupted

This error typically occurs when a file related to the installation becomes corrupted. You may experience this [error when you install Visual Studio by using an ISO or DVD burned from ISO](#error-when-you-install-from-an-iso-or-a-dvd-burned-from-an-iso). You may also experience this [error during a repair](#error-during-a-repair) of Visual Studio.  

### Error when you install from an ISO or a DVD burned from an ISO

If you use an ISO file to install Visual Studio, or if you use a DVD that was burned from an ISO file, the ISO file may become corrupted during the download process. If you have the Microsoft File Checksum Integrity Verifier tool installed, use the tool to check if the ISO file is corrupted by following these steps:

1. In a **Command Prompt** window, type the following command and then press Enter.

    ```console
    <DIRECTORY_NAME>\fciv.exe -sha1 <ISO_NAME>
    ```

    > [!NOTE]
    > In this command, the _\<DIRECTORY NAME>_ placeholder is the folder to which you extracted the files and the _\<ISO_NAME>_ placeholder is the path of the Visual Studio ISO file. For more information, see the _ReadMe.htm_ file in the extraction directory.

2. Verify that the Secure Hash Algorithm 1 (SHA-1) value that is returned by the File Checksum tool matches the expected value. To determine the expected value, examine the folder to which you downloaded the ISO file.

    > [!NOTE]
    > The expected SHA-1 value is different for each download source.

    1. If you downloaded the ISO file from MSDN, the SHA-1 value is provided in the **Details** section for each ISO file.

    2. If you downloaded the ISO file from the [Download Center](https://www.microsoft.com/download), you can find the SHA-1 value by expanding the **Install Instructions** section of the product page.

If the expected SHA-1 value doesn't match the value that is returned by the File Checksum tool, the ISO file is corrupted. In this case, delete the file, and then download it again.

- If you obtained the ISO file from a DVD, try to download the Visual Studio web installer or ISO file from [MSDN](https://msdn.microsoft.com//subscriptions/securedownloads) or [Microsoft Download Center](https://www.microsoft.com/download), and then try the installation again.

- If you purchased the DVD from a retail store, you might also be able to download Visual Studio from the store's website. Then, use the license key that was provided together with the DVD to activate Visual Studio. Contact the retail store for more information about this process.

### Error during a repair

If the error occurs when you try to repair Visual Studio, your installation cache may have become corrupted. To repair the cache, follow these steps:

1. Close Visual Studio.
2. To open an elevated **Command Prompt**, select **Start**, type _cmd_ in the **Start** search box, right-click _cmd.exe_ in the results list, and then select **Run as administrator**.
3. In the **Command Prompt** window, type _cd C:\ProgramData\Package Cache_, and then press Enter.
4. To clear the _.msi_ and _.cab_ files from the cache, type the following commands in the **Command Prompt** window, and press Enter after each command:

    ```console
    Delete /F /S *.msi
    Delete /F /S *.cab
    ```

5. Try again to repair Visual Studio.  

## 0x800713ec - .NET Framework installation is in progress

This error typically occurs when an installation of the .NET Framework that is separate from Visual Studio is already in progress. Because many components of the Visual Studio installer depend on the .NET Framework, an attempt to install the .NET Framework while Visual Studio is being installed can cause unexpected behavior.

To work around this issue, wait for the .NET Framework installer to finish before you install Visual Studio.

## Multiple feature installation errors occur after warning about certificate updates is ignored in Visual Studio 2013 and 2015

When you install Visual Studio on Windows 7, you receive the following warning:

> Installation errors may occur because the security certificate updates that are required to install some Visual Studio components cannot be applied to this computer.

If you select **Continue** to proceed with the Visual Studio installation, you may encounter the "Unable to locate package source" errors that aren't resolved through the **Download packages from the internet** option. When the Visual Studio installation finishes, you see the following message:

> Setup Completed. However, not all features are installed correctly.

You're also shown a list of multiple features that couldn't be installed because the system can't find the specified file. To fix the issue, try the following methods:

- Ensure that you are on a computer that's connected to the internet.
In some cases, Visual Studio can programmatically retrieve and then apply the required certificate updates to successfully install the affected features.

- Check the group policy setting on your computer that controls automatic certificate updates. To automatically retrieve and apply the required certificates, follow these steps:

    1. Open the **Local Group Policy Editor** (_gpedit.msc_).

    1. Expand **Computer Configuration** > **Administrative Templates** > **System** > **Internet Communication Management**, and then select **Internet Communication settings**.

    1. Select **Turn off Automatic Root Certificates Update** > **Disabled**, and then select **OK** or **Apply**.

    > [!NOTE]
    > We recommend that you contact your system administrator before modifying any group policy setting.

- If the preceding steps don't resolve the issue, you can also try to manually install the required certificate updates. For more information on how to obtain Windows update root certificates, see [Configure Trusted Roots and Disallowed Certificates](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265983(v=ws.11)).

If you have already installed Visual Studio, try to repair Visual Studio after you've tried one or more of the preceding methods. This process tries to successfully install the features that weren't installed in the previous attempt. To repair Visual Studio, follow these steps:

1. Open **Programs and Features** (_appwiz.cpl_).

1. Right-click **Visual Studio \<VersionNumber>**, select **Change**, and then select **Repair** to initiate the repair process.

> [!NOTE]
> This error applies only to Windows 7 Service Pack 1 (SP1). Windows 8 and later versions of Windows have these certificate updates installed by default.

## More information

If this article doesn't address the Visual Studio installation issue that you're experiencing, see [Visual Studio setup Microsoft Q&A community](/answers/topics/vs-setup.html) or [Visual Studio Setup and Installation forum](https://social.msdn.microsoft.com/Forums/en-US/home?forum=vssetup). You may also post your issue along with the Visual Studio installation log file to the [community](/answers/topics/vs-setup.html) for further help.

For more steps on collecting the installation logs, see [Troubleshoot installation or upgrade issues](/visualstudio/install/troubleshooting-installation-issues#installation-logs).
