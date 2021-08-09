---
title: Common issues in Visual Studio 2012 setup
description: This article describes common problems during Visual Studio installation, and provides suggested workarounds.
ms.date: 04/15/2020
ms.prod-support-area-path: Installation
---
# Common issues and workarounds in Visual Studio 2012 setup

This article helps you resolve problems that occur when you install Microsoft Visual Studio 2012.

_Original product version:_ &nbsp; Visual Studio 2012  
_Original KB number:_ &nbsp; 2872457

## Symptoms

Visual Studio can't be installed, and you receive an error message that contains one of the following errors:

- [0x80200010, 0x80072efe, or 0x80072ee7 - connectivity issue during download](#0x80200010-0x80072efe-or-0x80072ee7---connectivity-issue-during-download)
- [0x80070005 - Access denied](#0x80070005---access-denied)
- [0x80070643 - Installation cache or ISO is corrupted](#0x80070643---installation-cache-or-iso-is-corrupted)
- [0x800713ec - .NET Framework installation is in progress](#0x800713ec---net-framework-installation-is-in-progress)
- [Web Deploy 3.0 - Certificate warning or Unable to locate package source error](#web-deploy-30---certificate-warning-or-unable-to-locate-package-source-error)

If this article doesn't address the Visual Studio installation issues that you're experiencing or you receive an error message of other error codes, see [Visual Studio Setup and Installation forum](https://social.msdn.microsoft.com/Forums/vstudio/home?forum=vssetup).

To work around these issues, try one or more of the following methods.

## 0x80200010, 0x80072efe, or 0x80072ee7 - connectivity issue during download

This error typically occurs when the Visual Studio installer experiences issues that affect your Internet connection during the download of required components. If you receive one of these error messages, try again to install Visual Studio after your Internet connection improves. If you continue to see this error, try the following methods:

- Install Visual Studio from a different source. For example, if you installed Visual Studio from [VisualStudio.com](https://www.visualstudio.com/downloads) or from the [Microsoft Download Center](https://www.microsoft.com/download), try downloading Visual Studio from [MSDN](https://msdn.microsoft.com//subscriptions/securedownloads).
- Install Visual Studio by using the `layout` switch or an ISO file. For more information about how to do it, visit the following articles:

  - [Install Visual Studio 2015](/visualstudio/install/install-visual-studio-2015)
  - [How to: Install Visual Studio 2012 Update 1 Offline](/archive/blogs/robcaron/how-to-install-visual-studio-2012-update-1-offline)

## 0x80070005 - Access Denied

This error occurs when Visual Studio can't access one or more of the required installation files. This error may occur for any of the following reasons:

- An outside process, such as an antivirus or anti-malware application, has locked a Visual Studio installation file at the same time that Visual Studio is trying to install the file. To work around this issue, coordinate with your system administrator or other IT professional to make sure that Visual Studio files are not locked by these processes.

- The user who is trying to install Visual Studio doesn't have administrator credentials on the computer. To successfully install Visual Studio, you must be logged in as an administrator.

- Permissions on some registry hives can prevent Visual Studio from installing successfully. For more information, see [Solving setup errors by using the SubInACL tool to repair file and registry permissions](/archive/blogs/astebner/solving-setup-errors-by-using-the-subinacl-tool-to-repair-file-and-registry-permissions).

## 0x80070643 - Installation cache or ISO is corrupted

This error typically occurs when a file that is related to the installation becomes corrupted. You may experience this error when you [install Visual Studio by using an ISO or DVD burned from ISO](#error-when-you-install-from-an-iso-or-a-dvd-burned-from-an-iso). You may also experience this [error during a repair](#error-during-a-repair) of Visual Studio.  

### Error when you install from an ISO or a DVD burned from an ISO

If you use an ISO file for your installation of Visual Studio, or if you use a digital video disc (DVD) that was burned from an ISO file, the ISO file may become corrupted during the download process. Follow these steps:

1. Download and install the Microsoft File Checksum Integrity Verifier.

    > [!NOTE]
    >To use this tool, you must know the file path of the ISO file.

2. During the installation of the tool, you're prompted to provide a directory in which the files are to be extracted.

    > [!NOTE]
    > The directory for later access. For example, you can extract the files to the `C:\TEMP\fciv` location.

3. At a command prompt, type the following command, and then press Enter:

    ```console
    <DIRECTORY_NAME>\fciv.exe -sha1 <ISO_NAME>
    ```

    > [!NOTE]
    > In this command, *\<DIRECTORY NAME>* is the folder to which you extracted the files, and *\<ISO_NAME>* is the path of the Visual Studio ISO file. For more information, see the *ReadMe.htm* file in the extraction directory.

4. Verify that the Secure Hash Algorithm 1 (SHA-1) value that is returned by the File Checksum tool matches the expected value. To determine the expected value, examine the folder to which you downloaded the ISO file.

    > [!NOTE]
    > The expected SHA-1 value is different for each download source.

    1. If you downloaded the ISO file from [MSDN](/previous-versions/dn292944(v=msdn.10)), the SHA-1 value is provided in the Details section for each ISO file.

    2. If you downloaded the ISO file from the [Download Center](https://www.microsoft.com/download), you can find the SHA-1 value by expanding the Install Instructions section of the product page.

If the expected SHA-1 value doesn't match the value that is returned by the File Checksum tool, the ISO file is corrupted. In this case, delete the file, and then download it again.

- If you obtained the ISO file from a DVD, you can try to download the Visual Studio web installer or ISO file from MSDN or the Download Center, and then try the installation again.

- If you purchased the DVD from a retail store, you might also be able to download Visual Studio from the store's website, and then use the license key that was provided together with the DVD to activate Visual Studio. Contact the retail store for more information about this process.  

### Error during a repair

If the error occurs when you try to repair Visual Studio, your installation cache may have become corrupted. To repair the cache, follow these steps:

1. Close Visual Studio.
2. Open an elevated command prompt. To do it, click **Start**, type *cmd* in the **Start search** box, right-click **cmd.exe** in the results list, and then click **Run as administrator**.
3. At the command prompt, type `cd C:\ProgramData\Package Cache`, and then press Enter.
4. To clear the *.msi* and *.cab* files from the cache, type the following commands at the command prompt, and press Enter after each command:

    ```console
    Delete /F /S *.msi Delete /F /S *.cab
    ```

5. Try again to repair Visual Studio.  

## 0x800713ec - .NET Framework installation is in progress

This error typically occurs when an installation of the .NET Framework that is separate from Visual Studio is already in progress. Because many components of the Visual Studio installer depend on the .NET Framework, an attempt to install the .NET Framework while Visual Studio is being installed can cause unexpected behavior. To work around this issue, wait for the .NET Framework installer to finish before you install Visual Studio.

## Web Deploy 3.0 - Certificate warning or unable to locate package source error

A warning related to WebDeploy 3.0 may cause two types of problems:

1. During installation, you may meet an **Unable to locate package source** error that isn't resolved via the Download packages from the internet option.
2. After installation is complete, you see a message that indicates setup has completed but not all features have installed correctly, along with the following warning:

    > Microsoft Web Deploy 3.0  
    > A required certificate is not within its validity period when verifying against the current system clock or the timestamp in the signed file.

To work around these issues and successfully install Web Deploy 3.0, you can try any of the following approaches:

- Obtain an updated installer that has been published at the distribution channel of your choice (such as [MSDN](https://msdn.microsoft.com/subscriptions/securedownloads)).
- Install the [latest Visual Studio Update](https://visualstudio.microsoft.com/).

## More information

If this article doesn't address the Visual Studio installation issue that you're experiencing, see [Visual Studio Setup and Installation forum](https://social.msdn.microsoft.com/Forums/vstudio/home?forum=vssetup) to find more information.

Or, you may post your Visual Studio installation log file to the [Visual Studio Setup and Installation forum](https://social.msdn.microsoft.com/Forums/vstudio/home?forum=vssetup) and [Microsoft Community](https://answers.microsoft.com/) for further helps.

To do it, follow these steps:

1. Download the [Microsoft Visual Studio and .NET Framework Log Collection Tool](https://www.microsoft.com/download/details.aspx?id=12493) (*collect.exe*).
2. Run the *collect.exe* tool from the directory where you saved the tool.
3. The utility creates a compressed cabinet file of all the Visual Studio and .NET logs to `%TEMP%\vslogs.cab`.
4. Post the *vslogs.cab* file with some descriptions of your issue to the forum.
