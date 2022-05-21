---
title: FAQ about the Windows Installer .msp files
description: Contains frequently asked questions and the answers about the Windows Installer .msp files for Microsoft Dynamics GP.
ms.reviewer: kyouells
ms.date: 03/31/2021
---
# Frequently asked questions about the Windows Installer .msp files for Microsoft Dynamics GP

This article contains answers to these frequently asked questions about the Windows Installer .msp files for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 912997

## Introduction

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, see [32How to back up and restore the registry in Windows2756].

Microsoft Dynamics GP use Microsoft patch files (.MSP files) to install hotfixes, service packs, payroll tax updates, and payroll year-end updates. Microsoft has released a hot topic that contains frequently asked questions about .MSP files. This article contains answers to these frequently asked questions.

## Overview

Q1: What is an .MSP file?

A1: An .MSP file is a Windows Installer patch file that includes updates to an application that was installed with Windows Installer.

Q2: Why is Microsoft Dynamics GP now using .MSP files?

A2: An .MSP file must be used to patch any application installed with Windows Installer. Microsoft Dynamics GP now uses Windows Installer and must be patched with an .MSP file.

Q3: Are all .MSP files inclusive?

A3: Yes. All .MSP files include all hot fixes, service packs, tax update, and payroll year end updates that were previously released.

Q4: Is there a current list of all .MSP files released for Microsoft Dynamics GP 9.0 and later versions?

A4: Yes.

Q5: What is the difference between installing an .MSP file and installing a Microsoft Business Solutions - Great Plains 8.0 service pack?

A5: The Microsoft Business Solutions - Great Plains 8.0 installation used Install Shield. So all service packs were an .exe file that used Install Shield for the installation. Microsoft Dynamics GP 9.0 and later versions uses Windows Installer to install the application. So all service packs, hotfixes, tax updates, and payroll year end updates must be installed with an .MSP file. The Microsoft Business Solutions - Great Plains 8.0 service packs required the user to run the Perform Special Upgrade process on the computer that was running Microsoft SQL Server. Microsoft Dynamics GP users no longer have to run the Perform Special Upgrade process. When you install an .MSP file on the server, the users have to start Utilities and mark each company database for an update. This process is similar to running an update from Microsoft Business Solutions - Great Plains 8.0 to Microsoft Dynamics GP 9.0. This process may take several minutes for each database.

## Installation

Q1: Is there a preinstall checklist that I can follow before I install a service pack or a hotfix?

A1: Yes. Use the following service pack or hotfix pre-install checklist:

1. Verify that you're signed in as a domain administrator. This step eliminates any permissions issues to where the package or the installation file is located.
2. Run Windows Updates, and verify that you have all critical updates downloaded and installed.
3. Verify that you have Microsoft Windows Installer 3.1 installed. To do it, open the **Add or Remove Programs** item in Control Panel.

    For more information about how to obtain Windows Installer 3.1, see [Windows Installer 3.1 v2 (3.1.4000.2435) is available](https://support.microsoft.com/help/893803).

4. Make sure that the Microsoft .NET Framework 1.1 is installed and up-to-date. Update the .NET Framework through Windows Update. Verify that the updates are installed by looking for Microsoft .NET Framework 1.1 in the **Add/Remove Programs** item in Control Panel.
5. Update the Windows Scripts for Windows XP. This step isn't automatically done through Windows Update. However, you can follow this step by visiting one of the following Microsoft Web sites:

    - [Windows Script 5.7 for Windows XP](https://www.microsoft.com/download/details.aspx?id=8247)

    - [Windows Script 5.7 for Windows Server 2003](https://www.microsoft.com/download/details.aspx?id=24059)

6. Copy the .msp file to the local hard disk drive. Don't install the update over the network.

Q2: Does the user have to have specific rights on the workstation where the .MSP file has to be installed?

A2: Yes. The user must be a Power User or an Administrator on the workstation where the .MSP file is installed. If the user isn't a Power User or an Administrator, the user receives the following error message:
> Failed patching Microsoft Dynamics GP 9.0 with error code 1625

Q3: Are there special steps to install a service pack or a hotfix on a Windows Vista-based, Windows Server 2008, or Windows 7 computer?

A3: Use one of the following methods:

- Temporarily disable User Account Control (UAC). To do it, follow these steps:
    1. Turn off User Account Control (UAC).
    2. Double-click the .msp file to install.

- Use UAC. To do it, follow these steps:
    1. Open the Command Prompt window as a user who has administrative permissions on the local computer. This command is located in the **Accessories** group. To do it, right-click the **Command Prompt** shortcut, and then select **Run as administrator**.
    2. Copy the path file to the root folder of drive C.
    3. Type the following command, and then press ENTER:  
        `cd c:\`
    4. Type the following command, and then press ENTER to install the patch file:  
        `Msiexec /p c:\ **PatchFile** /l*v C:\MSPErrorlog.txt`

        > [!NOTE]
        > **PatchFile** represents the name of the service pack or the hotfix that you're installing.

Q4: Can I run the .MSP file and copy the .CNK files out of the Microsoft Dynamics GP folder and then install these .CNK files at other client workstations?

A4: No. The .CNK files can't be copied from the Microsoft Dynamics GP folder. Windows Installer tracks the addition of all .MSP files. If only the .CNK files were copied and installed, Windows Installer doesn't know which products were patched. There are also more files than the .CNK files that get patched. Copying only the .CNK files would cause other problems if a user ran a repair on the Microsoft Dynamics GP installation.

Q5: Why is it required to start Utilities and update the company databases after installing an .MSP file on the server?

A5: In Microsoft Business Solutions - Great Plains 8.0, users ran the Perform Special Upgrade process when we released changes to database objects in the service packs. Microsoft Dynamics GP users must mark each company for an update in Utilities. It will make the appropriate database object changes for each database.

Q6: How long will the Utilities process for updating my company databases take?

A6: The update process may take several minutes for each company database depending on the size of the database.

Q7: Do I have to start Utilities at each client workstation after the .MSP file is installed?

A7: Yes. After the .MSP file is installed on the server, the user will be prompted to run Utilities at each client workstation.

Q8: Can I easily roll out an .MSP file to my clients?

A8: Yes. After the .MSP file is installed on the server, you can use the Automatic Client Updates feature to roll out the patch to all clients. See Chapter 5 in the SystemAdminGuide.pdf on the Release 9.0 Volume 1 CD-ROM under Documentation or on the Microsoft Dynamics GP 10.0 and later DVD.

Q9: If I don't install the .MSP on one client, will that cause issues?

A9: After the .MSP file is installed on the server, the database version has been updated for that patch. If a client workstation doesn't have the .MSP file installed, the version information won't match. That client will receive an error message that the version doesn't match and won't be able to sign in.

Q10: Can third-party products use an .MSP file to install service packs?

A10: Yes. Third-party product can also use the Automatic Client Updates Feature to install the .MSP files automatically. Refer to Chapter 5 in the SystemAdminGuide.pdf on the Release 9.0 Volume 1 CD-ROM under Documentation.

Q11: Can I install the .MSP file on a client workstation first before installing the .MSP file on the server?

A11: Yes. However, the client won't be able to sign into any company database until the .MSP file has been installed on the server. Utilities must also be started on the server to update all company databases.

Q12: Can I create an installation package (install template) from the Microsoft Dynamics GP CD or DVD that includes the .MSP service packs?

A12: At this time, the service packs can't be included within the installation package file. However, you can set up an Automatic Client Update to automate the installation for the .MSP service packs. Refer to Chapter 5 in the SystemAdminGuide.pdf on the Release 9.0 Volume 1 CD-ROM under Documentation or on the Microsoft Dynamics GP 10.0 and later DVD.

Q13: If I have a test server that has multiple installations of Microsoft Dynamics GP 9.0 or later versions, will the .MSP installation patch all the installations?

A13: Yes. If you run the .MSP installation, all Microsoft Dynamics GP installations will be patched. If you want to patch only one Microsoft Dynamics GP installation, follow these steps:

1. Select **Start**, select **Run**, type **regedit**, and then select **OK**.
2. Locate and then select the following registry subkey:

    - Microsoft Dynamics GP 9.0 32-bit environment  
     `HKEY_LOCAL_MACHINE\Software\Microsoft\Business Solutions\Great Plains`

    - 64-bit environment  
    `HKEY_LOCAL_MACHINE\Software\wow6432Node\Microsoft\Business Solutions\Great Plains`

    - Microsoft Dynamics GP 10.0 and later versions 32-bit environment  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\Business Solutions\Great Plains\1033`

    - 64-bit environment  
    `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Business Solutions\Great Plains\1033`

3. Expand the folder for the instance of Microsoft Dynamics GP you want to patch.

    > [!NOTE]
    > The DEFAULT folder is for the default installation. The Inst01 folder is for the second instance of Microsoft Dynamics GP. For example, if you want to patch the second installation, expand the Inst01 folder.
4. Select the SETUP folder, double-click the Product Code, and then copy the code.
5. Exit Registry Editor.
6. Select **Start**, and then select **Run**.
7. To install the .MSP file, type the following, and then select **OK**:  
   `C:\updatename.msp /n {E979C594-95F9-4E3A-985D-A1DFDF403227}`
    > [!NOTE]
    > Replace `C:\updatename.msp` with the path to the .MSP file and the name of the .MSP patch file. Replace `{E979C594-95F9-4E3A-985D-A1DFDF403227}` with the Product Code the you copied in step 4.

## Troubleshooting

Q1: Is there a list of common error messages that may appear when running Windows Installer .MSP files?

A1: Yes. Visit [Windows Installer Error Messages (for Developers)](/windows/win32/msi/windows-installer-error-messages) to view an article that describes the error messages that may be generated when you install .MSP files.

Q2: Why am I being prompted to insert the Microsoft Dynamics GP 9.0 CD when I'm installing a service pack for Microsoft Dynamics GP 9.0?
> The upgrade patch cannot be installed by the Windows Installer service because the program to be upgrade may be missing, or the upgrade patch may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct update patch.

A2: This error message may indicate potential issues with the current install of Microsoft Dynamics GP 9.0 on this computer. Insert the Microsoft Dynamics GP 9.0 to continue the service pack installation. If the installation doesn't continue, remove Microsoft Dynamics GP 9.0 from this computer. Then, reinstall Microsoft Dynamics GP 9.0, and then install the latest service pack.

Q3: Why do I receive the following error message when I'm installing a service pack for Microsoft Dynamics GP 9.0?
> The upgrade patch cannot be installed by the Windows Installer service because the program to be upgrade may be missing, or the upgrade patch may update a different version of the program. Verify that the program to be upgraded exists on your computer and that you have the correct update patch.

A3: If you've only one installation of Microsoft Dynamics GP 9.0, this error message may indicate potential issues with the current installation of Microsoft Dynamics GP 9.0 on this computer. To resolve the problem, follow these steps:

1. Select **Start**, select **Control Panel**, and then double-click **Add or Remove Programs**.
2. In the **Currently installed programs** list, select **Microsoft Dynamics GP 9.0**, and then select **Change**.
3. Run a repair on the Microsoft Dynamics GP 9.0 installation.

If the problem isn't resolved, remove Microsoft Dynamics GP 9.0 on this computer. Then, reinstall Microsoft Dynamics GP 9.0, and then install the latest service pack again. If you've multiple installations of Microsoft Dynamics GP 9.0 on your computer, and you're installing an .MSP update that is older than other .MSP files that have been installed, you'll receive the error message. For example, if you've installed Service Pack 1 and you're now installing the 2005 Payroll Year End Update .MSP file, you may receive the error message. If you would like to patch an installation with an older .MSP file, follow the steps in the answer to question 17 to manually patch only one installation.

> [!NOTE]
> All .MSP files include all the previous .MSP file fixes.

Q4: Why do I receive the following error message when I'm installing a service pack for Microsoft Dynamics GP?
> DEX.DIC version 9.00.xxxx.0 is not compatible with executable version 9.00.xxxx.0.

A4: This error may occur if the workstation isn't restarted after you're prompted to restart.

1. Restart the workstation, and then start Microsoft Dynamics GP again.
2. Rename the Dex.dic file in the Microsoft Dynamics GP folder, and then run the msp patch installation again.

This error may occur when you attempt to start Microsoft Dynamics GP if the DEX.DIC isn't at the correct build.

1. Browse to the Microsoft Dynamics GP Code folder on the server (the default path is `C:\Program Files\Microsoft Dynamics\GP`) and rename the current DEX.DIC to DEXOLD.DIC.
2. Open **Control Panel**, select **Add/Remove Programs** and select **Microsoft Dynamics GP 9.0** or **Microsoft Dynamics GP 10.0** and select **Change**.
3. In the Program Maintenance window, select the **Repair** option.
4. Start Microsoft Dynamics GP by double-clicking on the **Microsoft Dynamics GP** icon to verify the error is resolved.

Q5: When I try to install a service pack for Microsoft Dynamics GP 9.0, I receive the following error message:
> Windows installer is not able to find the GreatPlains.msi file in the location where Dynamics GP was originally installed based on the path is stored in the Windows registry.

When I browse to the GreatPlains.msi file on the installation CD, I receive the same error message. What is the problem?

A5: This problem occurs if the path to the original GreatPlains.msi file was changed or if the file was moved. You must correct the registry entry for the path of the GreatPlains.msi file. To do it, follow these steps.

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

1. Select **Start**, select **Run**, type **regedit**, and then select **OK**.
2. On the **File** menu, select **Export**.
3. In the **File name** box, type registry backup, select **All** under **Export Range**, and then select **Save**.
4. Press CTRL+F, type **GreatPlains.msi**, and then select **Find Next**. A registry subkey that resembles the following example will be returned:  
    `HKEY_CLASSES_ROOT\Installer\Products\495C979E9F59A3E489D51AFDFD042372\SourceList`

5. Right-click **LastUsedSource**, and then select **Modify**.
6. Replace the current path with the path to the GreatPlains.msi file on the Microsoft Dynamics GP 9.0 installation CD. For example, if the CD is in the D drive, the Value data information is as follows:  
    `D:\Bin\`

7. Select **OK**, and then exit Registry Editor.
8. Retry the installation of the service pack.

    > [!NOTE]
    > If you've multiple instances of Microsoft Dynamics GP installed, you may have to repeat these steps to fix any other instances of the GreatPlains.msi file.

Q6: When I install a service pack, the following error appears:
> The installer has encountered an unexpected error installing this package. This may indicate a problem with this package.

The error code is 2755. What is causing this error?

A6: This error occurs for either of the following reasons.

- The service pack or the hotfix isn't physically on the same drive partition as the Microsoft Dynamics GP application folder. For example, the service pack file exists on the C drive and the Microsoft Dynamics GP folder is on the D drive. To resolve this problem, download and then run the service pack file or the hotfix file on the same physical drive as the Microsoft Dynamics GP directory.
- The service pack or the hotfix is installed from a network location. To resolve this problem if the service pack or the hotfix is on a network share, copy this file locally to the workstation, and then install the file.

Q7: When I try to uninstall Microsoft Dynamics GP 9.0, I receive the following error message:
> A network error occurred while attempting to read from the file: C:\WINDOWS\Installer\GreatPlains.msi

How can I resolve it?

A7: When you uninstall the Microsoft Dynamics GP program, the GreatPlains.msi file is accessed. If this file cannot be found, you receive this error message. To resolve this issue, copy the GreatPlains.msi file from the Microsoft Dynamics GP installation CD to the location that is displayed in the error message. The GreatPlains.msi file is located in the Bin folder on the Microsoft Dynamics GP installation CD. After you copy the file, try to uninstall Microsoft Dynamics GP again. In this example, you copy the GreatPlains.msi file to following location:  
`C:\WINDOWS\Installer\`

Q8. When you try to apply a service pack or hotfix for either Microsoft Dynamics GP on a Windows Vista computer, the following error is given:
> "New code must be included in the Dynamics.set dictionary. However, you do not have sufficient privileges to do so. You can choose to continue, but the new code will not be used."

A8: This error message is occurring because of the User Access Control (UAC) in Windows Vista. Use one of the following methods to resolve the issue:

- Run the installation of the service pack or hotfix as an Administrator. To do it, right-click the file, on the shortcut menu, select **Run As Administrator**, and then continue through the installation of the service pack or hotfix.
- Disable User Access Control. To do it, follow these steps:
  1. In Control Panel, select **Add or remove user accounts**.
  2. Select the user account that you're signing into the computer as, and then select **Go to the main User Accounts Page**.
  3. Select **Change security settings**, clear the **Use User Account Control (UAC) to help protect your computer** option, and then select **OK**.
  4. Restart the computer when you're prompted.
  5. Install by double-clicking the installation file.
  6. As soon as the installation has finished, reset the changes that you made in steps 1-4 to enable UAC.
