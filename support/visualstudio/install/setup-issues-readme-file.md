---
title: Setup issues Readme file
description: This article describes the Microsoft Visual Studio 2005 Express Edition Setup issues Readme file.
ms.date: 10/26/2020
ms.prod-support-area-path: installation
---
# Contents of Microsoft Visual Studio 2005 Express Edition Setup issues Readme file

This article describes the Visual Studio 2005 Express Edition Setup issues Readme file.

_Original product version:_ &nbsp; Visual Studio 2005 Express Edition  
_Original KB number:_ &nbsp; 908451

## Summary

This article contains the Microsoft Visual Studio 2005 Express Edition Setup issues Readme file.

## More information

This document lists issues that concern installation, uninstallation, repair, and other setup procedures.

## 1.1. System Requirements

|System Requirements for Installing Visual Studio Express 2005|Require Values|
|---|---|
|Processor|Minimum:<ul><li> 600 megahertz (MHz) Pentium processorRecommended</li><li>1 gigahertz (GHz) Pentium processor recommended</li></ul>|
|Operating System|Visual Studio 2005 can be installed on any of the following systems: <ul><li>Microsoft Windows 2000 Professional SP4</li><li> Microsoft Windows 2000 Server SP4</li><li> Microsoft Windows 2000 Advanced Server SP4</li><li>Microsoft Windows 2000 Datacenter Server SP4</li><li>Microsoft Windows XP Professional x64 Edition (WOW)</li><li>Microsoft Windows XP Professional SP2</li><li>Microsoft Windows XP Home Edition SP2</li><li>Microsoft Windows XP Media Center Edition 2002 SP2</li><li>Microsoft Windows XP Media Center Edition 2004 SP2</li><li>Microsoft Windows XP Media Center Edition 2005</li><li>Microsoft Windows XP Tablet PC Edition SP2</li><li>Microsoft Windows Server 2003, Standard Edition SP1</li><li>Microsoft Windows Server 2003, Enterprise Edition SP1</li><li>Microsoft Windows Server 2003, Datacenter Edition SP1</li><li>Microsoft Windows Server 2003, Web Edition SP1</li><li>Microsoft Windows Server 2003, Standard x64 Edition (WOW)</li><li>Microsoft Windows Server 2003, Enterprise x64 Edition (WOW)</li><li>Microsoft Windows Server 2003, Datacenter x64 Edition (WOW)</li><li>Microsoft Windows Server 2003 R2, Standard Edition</li><li>Microsoft Windows Server 2003 R2, Standard x64 Edition (WOW)</li><li>Microsoft Windows Server 2003 R2, Enterprise Edition</li><li>Microsoft Windows Server 2003 R2, Enterprise x64 Edition (WOW)</li><li>Microsoft Windows Server 2003 R2, Datacenter Edition</li><li> Microsoft Windows Server 2003 R2, Datacenter x64 Edition (WOW)</li><li>Microsoft Windows VistaInstallation of Visual Studio 2005 on the Intel Itanium (IA64) is not supported.<br/>|
|RAM *1*|Minimum:</li><li>192 megabytes (MB) <br/>Recommended:</li><li>256 MB|
|Hard Disk *2*|Up to 1.3 GB of available space may be required|
|CD or DVD Drive|Not required|
|Display|Minimum:</li><li>800 x 600 256 colors<br/> Recommended:</li><li>1024 x 768 High Color - 16-bit|
|Mouse|Microsoft mouse or compatible pointing device|
||

### 1.1.1. Performance improvement

Performance has not been tuned for minimum system configurations. Increasing your computer's RAM will improve its performance, especially when running multiple applications, working with large projects, or doing enterprise-level development.

### 1.1.2. Installation drive

When you start the Express installer, the default installation location is your system drive, which is the drive that boots your system. However, you can install the application on any drive. Regardless of the application's location, the installation process installs some files on your system drive. Consequently, ensure that the required amount of space is available on your system drive regardless of the application's location, and ensure that additional space is available on the drive on which you install the application.

## 1.2. Uninstalling Express Editions

If you have installed previous versions of Visual Studio 2005, such as Beta 2 or Community Technical Preview (CTP) builds, then you must follow these steps shown below before installing Visual Studio 2005 Express Edition products:

1. Go to the **Control Panel** and launch **Add/Remove Programs**
2. Remove **Microsoft SQL Server 2005 Express Edition**
3. Remove **Microsoft SQL Server 2005 Tools Express Edition**
4. Remove **Microsoft SQL Native Client**
5. Remove **Microsoft MSDN Express Library 2005 Beta**
6. Remove all Microsoft Visual Studio Express Editions (such as Visual C# 2005 Express Edition Beta)
7. Remove **Microsoft Visual Studio 2005 Remote Debugger Light** (This step is needed only if Visual Studio is installed on a 64-bit machine)
8. Remove **Microsoft Visual J# .NET Redistributable 2.0 Beta Language Pack** (This step is not needed if you have only the English Edition)
9. Remove **Microsoft Visual J# .NET Redistributable Package 2.0 Beta**
10. Ensure all Visual Studio 2005 products have been removed from your system
11. Remove **Microsoft .NET Framework 2.0 Beta Language Pack** (This step is not needed if you have only the English Edition)
12. Remove **Microsoft .NET Framework 2.0 Beta**

> [!NOTE]
> This tool is not supported or thoroughly tested by Microsoft. This is a free tool and you should use it at your own risk. No warranty or support is provided, expressed, or implied.

You may now install the Visual Studio 2005 Express Edition products you wish to use.

You can visit the [Visual Studio Express Forum](https://social.msdn.microsoft.com/Forums/home?forum=vsexpress) and report your specific issue.

## 1.3. Product installation

### 1.3.1 Installation of Visual Studio 2005 on the Intel Itanium (IA64) is not supported

Visual Studio 2005 does not support the Intel Itanium (IA64) processor.

To resolve this issue

If you need to develop Itanium applications, install Visual Studio on another computer and use the cross compilers to target the Itanium platform.

### 1.3.2 SQL Express installation fails when pre-released SQL Express components are not uninstalled

SQL Express component setup will fail if any of the following pre-released SQL Express components are left on the computer:

- Microsoft SQL Server 2005 Express Edition
- Microsoft SQL Server 2005 Tools Express Edition
- Microsoft SQL Native Client

In most cases, setup only displays a list of Beta components detected on the targeted computer. However, SQL Express components will always appear in this list if any other Beta components are detected. In other words, these SQL Express components could appear in the list even after the user uninstalls them.

To resolve this issue

Ensure the matching .NET Framework Beta is on the computer before performing the following steps:

1. Remove **Microsoft SQL Server 2005 Express Edition**
2. Remove **Microsoft SQL Server 2005 Tools Express Edition**
3. Remove **Microsoft SQL Native Client**

You may ignore the Beta warning message about these components if they were uninstalled previously.

### 1.3.3 Setup fails when installing from a mounted drive in a Virtual PC environment

When installing Visual Studio 2005 on a Virtual PC, setup fails because it cannot access certain files.
This happens when the drive is mounted using the CD Drive mount software provided with Virtual PC or your Visual Studio 2005 media is a DVD because the mounting software can only support 2.2 Gigabytes of data.

To resolve this issue

You can use a third-party DVD Drive mounting software. Alternatively, you can copy the contents of the Visual Studio 2005 DVD to your computer's hard drive, share the folder with your Virtual PC, and then direct Visual Studio 2005 installation setup to the folder.

### 1.3.4 Upgrade from previous releases of Visual Studio 2005

First of all, thank you for contributing to the release of Visual Studio 2005 by helping us to test our pre-release versions, such as Beta 1, Beta 2 or Community Tech Preview, and for installing this final-release version! However, final-release setup does not support uninstalling pre-release versions. For best results, it is recommended you install on a clean computer that has not had a pre-release version of Visual Studio 2005 previously installed on it. While it is not officially supported, we tried to ensure the scenario of uninstalling and reinstalling from Visual Studio 2005 Beta 2 to the released version has as few issues as possible. To uninstall Visual Studio 2005 Beta 2, you must uninstall in the order specified in section 1.2 of this readme file. Most Beta 2 projects can be carried forward to the final release version. For details on any changes needed for forward compatibility, see [Runtime Breaking Changes](/previous-versions/aa497239(v=msdn.10)).

To resolve this issue

If you have Visual Studio 2005 Beta installed and want to install the released version, you must uninstall in the order specified in section 1.2 of this readme or use the uninstall tool.

### 1.3.5 Installing Visual Studio 2005 using the runas command fails

Unless you are logged in as an administrator, using the runas command to install Visual Studio 2005 is not supported and will fail. Running Visual Studio 2005 after it is installed is supported for non-administrators.

To resolve this issue

Log in as an administrator to install Visual Studio 2005.

### 1.3.6 Installing Visual Studio 2005 from CD fails

The media that Visual Studio 2005 shipped on may be bad, preventing a successful installation.

To resolve this issue

Visual Studio 2005 setup may be run from a network share as an alternative to running setup from CDs or DVDs. The following procedure illustrates how to prepare Visual Studio 2005 for installation from a network share. The procedure refers to the Visual Studio 2005 CDs, but the steps are the same for DVDs.

1. Create a folder (for example, VS2005) on the server.
2. Create two subfolders, named VS, and MSDN within the top-level folder. For example: *VS2005\VS*, *VS2005\MSDN*.
3. Copy the contents of the Visual Studio 2005 CDs into the *VS2005\VS* folder. Select Yes if prompted to overwrite any existing files.
4. Copy the contents from all the CDs labeled MSDN Library for Visual Studio 2005 to the subfolder named MSDN. Select **Yes** if prompted to overwrite any existing files.
5. Open Setup.ini in the VS subfolder using a text editor, such as Notepad.
6. In the **Documentation** section, change the line that starts with `DIR=` as follows:

    ```console
    [Documentation]
    DIR=..\MSDN
    ```

7. Save your changes and close the file.

    > [!NOTE]
    > Completing this step prevents disk-swapping requests during setup and informs the setup program of the correct path to the MSDN Library CDs.

8. In the VS subfolder, open the **Setup** folder.
9. Open setup.sdb in a text editor, such as Notepad, and add the following lines to the end of the file:

    ```console
    [Product Key]
    XXXXXXXXXXXXXXXXXXXXXXXXX
    ```

    > [!NOTE]
    > `XXXXXXXXXXXXXXXXXXXXXXXXX` is the 25 digit product key, entered without dashes, found on the CD packaging.

10. Save your changes and close the file.

    > [!NOTE]
    > Completing this step enables pre-populating the product key for the user who will install from the network share.

11. Share the VS2005 folder on the network and set the appropriate security settings. The path to Visual Studio 2005 setup from the network looks like `\\[servername]\VS2005\VS\setup.exe`

    > [!NOTE]
    > Setup will fail if any path and file name combination exceeds 260 characters. The maximum length of a path in Visual Studio is 221 characters. You should copy files to a path with less than 70 characters. If you create a network share for a network image, the UNC path to the root installation location should contain fewer than 39 characters.

    > [!NOTE]
    > Setup might fail if the folder names in this path include embedded spaces, for example:
    >
    > - `\\[servername]\VS2005\MSDN\`
    > - `\\[servername]\VS2005\Visual Studio\`

### 1.3.7 Installing any edition of Visual Studio 2005 from an installation path that is longer 100 characters fails on Windows 2000

When setup is launched from a path that is longer than 100 characters, setup fails due to a maximum path limitation in Windows 2000. Path length is not an issue on Windows XP or Windows 2003 Server.

To resolve this issue

When installing from a network, map the network path to a local drive and install from that drive. For example, if the path is `\\computername\programs\test folder\development tools\external\Microsoft\Visual Studio 2005\beta release`, you can map it to a network drive by doing the following:

1. From the **Start** menu, choose **Run**.
2. Type **cmd** and then click **OK**.
3. At the command prompt, type the following:

    ```console
    net use * "\\computername\programs\test folder\development tools\external\Microsoft\Visual Studio 2005\beta release"
    ```

Windows maps the network drive for you. The drive letter is displayed in the console window.

When installing from a local folder, copy the contents of Visual Studio to another folder on the computer that has a total path length of less than 100 characters.

> [!NOTE]
> If you install Visual Studio from a CD or DVD, you will not encounter any path length issues.

### 1.3.8 Installation path cannot accept non-ANSI characters on Japanese MUI OS

On JPN MUI OS, when installing Visual Studio Team Suite to path with non-ANSI characters such as `c:\program files\噂 浬 詰 圭 構 蚕 十 觸 Microsoft Visual Studio 8`, a dialog box pops up saying **can't accept non-ANSI characters**.

This problem occurs on all JPN MUI OS (including Windows 2000, Windows 2003 and Windows XP series operating systems). It does not occur on JPN OS.

To resolve this issue

Use ANSI characters for the destination path.

### 1.3.9 Antivirus applications that are configured to clean the Temp folder might cause setup to fail

If setup needs to reboot and your antivirus application is set to clean the Temp folder on launch, necessary setup files will be deleted and setup will fail due to a program-not-found error.

To resolve this issue

Before running Visual Studio setup, reset the antivirus application to leave Temp folder contents intact on launch or reboot. Reference your Antivirus help documentation for steps on how to do this.

### 1.3.10 Setup does not check disk space when autolaunching after selecting reboot later

When reboot later is selected and the available space on the hard drive is filled beyond the amount of space needed by setup, an out-of-space error will occur after reboot.

To resolve this issue

Ensure that enough disk space will be available by rebooting before installing or opening other applications. The required disk space is displayed when you select the location to install the product.

### 1.3.11 Visual Studio file extensions are unregistered when Express Edition is uninstalled

If multiple Express Editions are installed on the same computer and then one is uninstalled, the uninstall un-registers file extensions it has in common with the other Express Editions. This disables double-clicking on file icons in Windows Explorer to open a Visual Studio file type (.cs or .vb, for example).

To resolve this issue

There are two ways to work around this problem:
Go to the **Windows Folder Options** dialog box by using the Explorer's **Tools** | **Folder Options** menu and reassociate the Visual Studio file-type extensions.

Or

Uninstall and then reinstall the Express Editions, which will cause the file extensions to be re-registered.

### 1.3.12 MSDN Express Library provides a specific version for each Express Edition

MSDN Express Library provides versions specific to each of Visual Basic 2005 Express Edition, Visual C++ 2005 Express Edition, Visual C# 2005 Express Edition, Visual J# 2005 Express Edition, and Visual Web Developer 2005 Express Edition. The desired set of documentation must be explicitly installed.

To resolve this issue

If you did not specify the desired documentation when you installed your Express Edition, you can install it by using **Add** or **Remove Programs** in the **Windows Control Panel**.

### 1.3.13 SQL Server Express is the only version of SQL Server that will work with Express Editions other than Visual Web Developer Express Edition

SQL Server Express is the only version of SQL Server that will work with Visual Basic 2005 Express Edition, Visual C++ 2005 Express Edition, Visual C# 2005 Express Edition, and Visual J# 2005 Express Edition.

To resolve this issue

If you did not specify SQL Server Express when you installed your Express Edition, you can install it by using **Add** or **Remove Programs** in the **Windows Control Panel**.

### 1.3.14 Administrator deployment is not supported for Express Editions

Administrator deployment using SMS or Active Directory is not supported for Visual Studio 2005 Express Editions. On a clean computer that is running Windows XP Professional, if you run the utility to create an .ini file for deployment (using admin docs), setup will launch but then hang after the feature selection screens.

To resolve this issue

There is no known resolution.

### 1.3.15 Removing the .NET Framework breaks SQL Server 2005 and MSDN Express Library

You must uninstall SQL Server 2005 and MSDN Library before uninstalling .NET Framework 2.0 or you will encounter an error. You can install newer versions of SQL Server 2005 and MSDN Library only after removing all previous SQL Server 2005 components and MSDN library components, as listed below.

To resolve this issue

1. From the **Control Panel**, select **Add or Remove Programs**.
2. Select SQL Server 2005 components and then click **Remove** to remove each component below.

   - Remove **Microsoft SQL Server 2005 Express Edition**
   - Remove **Microsoft SQL Server 2005 Tools Express Edition**
   - Remove **Microsoft SQL server setup support files**
   - Remove **Microsoft XML 6.0**
   - Remove **Microsoft SQLXML 4.0**
   - Remove **Microsoft SQL Native Client**
   - Remove **Microsoft MSDN library**

3. Select .NET Framework 2.0 and click **Remove**.
4. Install SQL Server 2005.

> [!NOTE]
> If you remove the Beta .NET Framework 2.0 before removing all SQL Server 2005 components or MSDN Library, you must reinstall .NET Framework 2.0 before you can successfully perform the steps above.

### 1.3.16 Ensuring that your applications execute on all versions of Visual Studio 2005

The .NET Framework common language runtime (CLR) provides configuration options that allow developers to specify which version of the CLR their application should run against. However, this makes it difficult to test the applications against CLR versions other than the one specified, because it requires manually reconfiguring options in each application's config file.

To resolve this issue

Visual Studio 2005 provides a switch that, when turned on, forces all applications executing on a given computer to run on the latest version of the runtime. This switch overrides settings specified in the app.exe.config and host.config files, which normally specify that the application run on either version 1.0 or version 1.1 of the CLR.

You can control this switch either by setting a registry key or by setting an environment variable:

In the registry, activate the switch by using `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\OnlyUseLatestCLR=dword:00000001`or deactivate it by using `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\OnlyUseLatestCLR=dword:00000000`

Or

Using an environment variable, activate the switch with `COMPLUS_OnlyUseLatestCLR=1` or deactivate it with `COMPLUS_OnlyUseLatestCLR=0`.

### 1.3.17 MSDN documentation for Express Editions of Visual Studio 2005 is not installed to a user-specified folder, but instead to a default folder

During installation of the MSDN documentation for Express Editions, you will be prompted to select a destination folder for the documentation files. However, your selected path is not respected and the documents are installed to this location: `C:\Program Files\Microsoft MSDN Quarterly\NETDOCS\V20`.

To resolve this issue

There is no known resolution.

### 1.3.18 Under some conditions, uninstalling Visual Studio .NET 2003 will corrupt your installation of Visual Studio 2005

If Visual Studio 2005 is installed and then Visual Studio .NET 2003 is installed on the same computer, uninstalling Visual Studio .NET 2003 will corrupt your installation of Visual Studio 2005.

To resolve this issue

You must rerun Visual Studio 2005 setup from the CD and select the **Repair/Reinstall** option.

### 1.3.19 Installation appears to hang when installing MSDN Express

During an installation, the user may be prompted to reboot after certain components are installed. After a reboot, installation should continue. However, when the installer is trying to install MSDN Express after a reboot, the progress bar looks full and the product is marked as installed even though setup has not yet completed and the product is not fully installed. This condition makes it look like setup is hung even though MSDN Express is being installed in the background.

To resolve this issue

Wait about 10 minutes for MSDN Express install to complete. The progress bar will not change during that time.

### 1.3.20 After being uninstalled, SQL Server Express requires a reboot before it can be reinstalled

When all SQL Server Express components are uninstalled, and then SQL Server Express is reinstalled using Maintenance Mode (for VSTS, you will need to install MSXML 6.0 first.), the reinstallation fails. No cause is written to the VS logs.

To resolve this issue

After uninstalling, reboot the computer before reinstalling SQL Server Express.

### 1.3.21 Launching Maintenance Mode from Add or Remove Program can take several minutes and might give the appearance that setup has failed

If you have other processes running when you launch Maintenance Mode, such as virus scanning software, these processes can slow setup considerably and give the appearance that setup has failed.

To resolve this issue

Setup has not failed. Wait until it is finished or close other processes and try again.

### 1.3.22 Download failure when downloading and installing an Express SKU

The download and installation of an Express SKU will intermittently fail due to the unreliability of the internet.

To resolve this issue

Visit Troubleshoot_Guide.htm on your CD or temp directory and rerun the bootstrapper from the website and try the download again.

## 2.1 C++ Tools for Itanium Setup location for Itanium redistributable

The *redistributable* files for Itanium are installed to the incorrect location during the Visual Studio Tools for 64-bit Setup (available only in Visual Studio 2005 Team System products).

To resolve this issue

You can find the Itanium *redistributable* in the `Visual Studio 2005\VC\Redist\x86` folder.

## 3.1 Installing SDK hangs at "setup is configuring the install..."

Installation hangs for an hour or more at **setup is configuring the install...**" and then gives the error message **invalid directory...**

This problem is caused by a lack of available disk space.

To resolve this issue

Free up sufficient space on the disk drive.

## 3.2 x64 .NET Framework Language Pack 2.0 ProductVersion says 1.1 instead of 2.0

When deployed through Active Directory, the language pack version number is displayed in the Group Policy Object - Software installation table. This can be confusing when the product name states 2.0 but the version data says 1.1.

To resolve this issue

There is no known resolution.

## 3.3 Installing Windows Server 2003, followed by the .NET Framework 2.0, and then upgrading to Windows Server 2003 SP1 using a full CD, breaks .NET Framework 2.0 applications

Upgrading using a CD with the full Windows Server 2003 SP1 installation replaces the shared file mscoree.dll on the user's computer with the .NET Framework 1.1 mscoree.dll file.

As a result, applications compiled against the .NET Framework 2.0 will fail to run after the Service Pack is installed.

> [!NOTE]
> This does not happen when Windows Server 2003 is updated with just the Service Pack.

To resolve this issue

After installing the Windows Server 2003 Service Pack, the .NET Framework needs to be repaired.

1. From the **Control Panel**, select **Add or Remove Programs**.
2. Select Microsoft .NET Framework 2.0.
3. Click **Change/Remove**.
4. When the dialog box appears, select **Repair** and click **Next**.
5. If prompted to do so, reboot the computer.

## 3.4 Installing on 64-bit OS when IIS 6 is in WoW64 mode will disable ASP.NET 1.1 in IIS

Existing ASP.NET 1.1 applications will be disabled when the 64-bit .NET Framework 2.0 Beta 2 is installed on a 64-bit operating system that has IIS6 in WoW64 mode and ASP.NET 1.1 enabled. This happens because the Framework setup incorrectly maps the `aspnet_filter` to the 64-bit version and removes version 1.1 of the `aspnet_isapi` extension.

To resolve this issue

You must manually change IIS to use the 32-bit version of the `aspnet_filter` and reinstall the ASP.NET 1.1 ISAPI extension.

1. Start Internet Information Services Manager (inetmgr.exe).
2. Expand the local computer node, then click the **Web Sites** node.
3. From the **Action** menu, select **Properties**.
4. In the **Web Site Properties** dialog box, select the **ISAPI Filters** tab.
5. In the list of filters, select the ASP.NET 2.0 filter and click **Remove**.
6. Click **Add** and then enter the following:

    ```console
    Filter Name: ASP.NET_ 1.1.4322
    Executable: C:\WINDOWS\Microsoft.NET\Framework\v1.1.4322\aspnet_filter.dll
    ```

7. Click **OK**.
8. Under the **Local Computer** node, click the **Web Service Extensions node**.
9. Under **Tasks**, click **Add a new Web Service Extension**.
10. In the **New Web Service Extension** dialog box, enter: *Extension Name: ASP.NET v1.1.4322*.

    For Required files, click **Add**... and then enter: `C:\WINDOWS\Microsoft.NET\Framework\v1.1.4322\aspnet_isapi.dll`. Check **Set Extension** status to **Allowed**. Click **OK**.

## 3.5 x64 netfx SDK JPN has ProductVersion = 1.1 instead of 2.0

When deployed through Active Directory, the version number is displayed in the Group Policy Object - Software installation table. This can be confusing when the product name states 2.0 but the version data says 1.1.

To resolve this issue

There is no known resolution.

## 4.1 Help documentation missing after uninstalling the MSDN Express Library or the .NET Framework

In certain uninstall scenarios, Windows Forms Help documentation will disappear. The problem occurs when the product that was installed last, MSDN Express Library or the .NET Framework, is subsequently uninstalled. The uninstall of the product unplugs the documentation from the Help system.

- Scenario 1 - Uninstalling the .NET Framework
The MSDN Express Library is installed first, followed by the .NET Framework. If the .NET Framework is then uninstalled, the Windows Forms Help documentation will not appear when viewing the MSDN Express Library.

- Scenario 2 - Uninstalling the MSDN Express Library
The .NET Framework is installed first, followed by the MSDN Express Library. If the MSDN Express Library is uninstalled, the Windows Forms Help documentation will not appear when viewing the .NET Framework Help.

To resolve this issue

Choose the repair option that better matches your scenario:

.NET Framework uninstalled and the MSDN Express Library still installed. Run a repair of the MSDN Express Library using the following steps:

1. On the **Start** menu, open the **Control Panel**.
2. In the control panel, double-click **Add** or **Remove Programs**.
3. Select Microsoft MSDN 2005 Express Edition.
4. Click the **Change/Remove** button.
5. Select **Repair**.
6. Click **Next**. Once the repair has finished, the MSDN Express Library will once again contain the Windows Forms Help documentation.

MSDN Express Library uninstalled and the .NET Framework is still installed. Run a repair of the .NET Framework using the following steps:

1. On the **Start** menu, open the **Control Panel**.
2. In the control panel, double-click **Add** or **Remove Programs**.
3. Select **Microsoft .NET Framework 2.0**.
4. Click the **Change/Remove** button.
5. Select **Repair**.
6. Click **Next**. Once the repair has finished, the .NET Framework will once again contain the Windows Forms Help documentation.
