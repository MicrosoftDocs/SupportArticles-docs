---
title: Use Adminpak to remotely administer computers
description: Discusses how to remotely administer computers that are running Windows Server 2003, Windows XP, or Windows 2000 by using the Administration Tools Pack.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.subservice: active-directory
---
# How to use the Administration Tools Pack to remotely administer computers that are running Windows Server 2003, Windows XP, or Windows 2000

This article describes how to remotely administer computers by using the Administration Tools Pack.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 304718

## Summary

This article describes options to administer computers that are running Windows Server 2003, Windows XP, or Microsoft Windows 2000. Additionally, this article discusses how to download the Windows Server 2003 Administration Tools Pack (Adminpak). This article also discusses the various compatibility issues that occur when you remotely administer Windows 2000-based computers from Windows XP-based computers and from Windows Server 2003-based computers and vice versa.

## Introduction

The following topics are discussed in this article:  

- Options to remotely administer computers that are running Windows Server 2003, Windows XP, or Windows 2000.
- Download locations for the original-release (RTM), Service Pack 1, and Service Pack 2 versions of the Windows Server 2003 Administration Tools Pack
- Issues that are specific to the administration of 64-bit versions of Windows
- Compatibility issues that occur when Windows 2000 Professional-based computers that have Windows 2000 administration tools installed are upgraded to Windows XP.
- Compatibility issues that occur when Windows 2000-based domain controllers are upgraded to Windows Server 2003-based domain controllers.
- Known issues that may occur when you use administration tools from the original-release (RTM), Service Pack 1, and Service Pack 2 versions of the Windows Server 2003 Administration Tools Pack to manage Windows 2000-based, Windows XP-based, and Windows Server 2003-based computers

### Remote administration options

The most seamless administrative experience occurs when the computer that is used to perform administrative tasks runs the same operating system as the computer that is being remotely administered.

Windows Server 2003 and Windows 2000 installation media contain command-line and graphical administrative tools that can be used to locally and in most cases remotely administer up-level and down-level operating systems with a high degree of interoperability.

To remotely administer computers that are running Windows Server 2003 or Windows 2000 from computers that are running Windows Server 2003, Windows XP, or Windows 2000, use one of the following methods:  

- Install and use graphical administrative tools that are packaged in the Administration Tools Pack to remotely administer computers that are running Windows Server 2003, Windows XP, or Windows 2000. Where interoperability problems exist between operating systems, perform administrative tasks on the console of the target computer or on a computer that is running the same operating system as the computer that is being remotely administered.
- Use Terminal Services to remotely administer computers that have command-line and graphical user interface (GUI) administration tools locally installed. To avoid the two-session limit, you can use Application Server mode to create a Windows Server 2003-based or Windows 2000-based installation that is running Terminal Server or Terminal Services. Where interoperability problems exist between operating systems, perform administrative tasks from a server that has Terminal Server or Terminal Services enabled and that is running the same operating system as the remote computer that is being administered.
- Use command-line tools and scripts to locally and remotely administer computers that are running Windows Server 2003, Windows XP, or Windows 2000. These tools and scripts include Active Directory Service Interfaces (ADSI), Windows Net.exe commands, and the tools that are packaged with Suptools.msi. Where interoperability problems exist between operating systems, perform administrative tasks on the console of the target computer or on a designated computer for administrative tasks that is running the same operating system as the remote computer that is being administered. For example, the Windows Server 2003 Service Pack 2 (SP2) Support Tools will install on a computer that is running Windows XP Professional. However, the tools are not guaranteed to work correctly in this scenario. Tools that are known to have issues include the following:  

  - Dfsutil.exe
  - Netdiag.exe
  - Netcap.exe
  - Ntfrsutil.exe  
  
If you want to run these tools against a Windows Server 2003 SP2-based computer, we recommend that you run them from a computer that is running Windows Server 2003 SP2. You can use the Remote Desktop feature to connect to a Windows Server 2003 SP2-based computer that is running the Support Tools.

### Windows Server 2003 and Windows 2000 Server Administration Tools Packs

To make the remote management of your servers easier, Microsoft has included typically used graphical administrative tools in a self-extracting file that is named Adminpak.msi (Adminpak).

> [!NOTE]
> On 64-bit versions of Windows Server 2003, this file is called Wadminpak.msi.

The Windows 2000 Administration Tools Pack is located in the I386 folder on the Windows 2000 Server-family CD and installs on computers that are running Windows 2000. Most of the tools in the Windows 2000 Adminpak can remotely administer Windows 2000 in addition to the 32-bit and 64-bit versions of Windows XP Professional and the 32-bit and 64-bit versions of Windows Server 2003.

The Windows Server 2003 Administration Tools Pack is located in the I386 folder of the Windows Server 2003 CD and is available as a free download on `www.microsoft.com`. The following table summarizes the operating systems on which you can install the Adminpak from Windows 2000, from Windows Server 2003 original (RTM), from Windows Server 2003 Service Pack 1 (SP1), or from Windows Server 2003 Service Pack 2. Additionally, the table summarizes the operating systems that the Adminpaks from these sources can remotely administer.

||Windows 2000 Server Adminpak|Windows Server 2003 original (RTM) Adminpak|Windows Server 2003 SP1 Adminpak|Windows Server 2003 SP2 Adminpak|Remote Server Administration Tool (RSAT)|
|---|---|---|---|---|---|
| **Installs and runs on these operating systems** ||||||
|**Windows Server 2003 32-bit family**|No|Yes|Yes|Yes||
|**Windows Server 2003 64-bit family**|No|No|Yes|Yes||
|**Windows XP Professional with Service Pack 2**|No|Yes|Yes|Yes||
|**Windows XP Professional SP1 or later versions**|No|Yes|Yes|Yes||
|**Windows XP Professional 64-bit Edition**|No|No|Yes|Yes||
|**Windows 2000 Professional**|Yes|No|No|No||
|**Windows 2000 Server family**|Yes|No|No|No||
|**Windows Vista**|No|No|No|No|Yes, RSAT for Windows Vista|
|**Windows 7**|No|No|No|No|Yes, RSAT for Windows 7|
|**Windows Server 2008**|No|No|No|No|Yes, RSAT for Windows Server 2008|
|**Windows Server 2008 R2**|No|No|No|No|Yes, RSAT for Windows Server 2008|
| **Remotely manages these operating systems** ||||||
|**Windows Server 2003 32-bit family**|Yes|Yes|Yes|Yes||
|**Windows Server 2003 64-bit family**|Yes|Yes|Yes|Yes||
|**Windows 2000 Server family**|Yes|Yes|Yes|Yes||

### Windows Server 2003 Administration Tools Pack installation and compatibility overview

If you want to remotely administer Windows Server 2003 or Windows 2000 member-based computers and domain controllers from Windows Server 2003-based clients or from Windows XP Professional-based clients, note the following installation issues:  

- You must remove earlier beta versions of the Windows Server 2003 Administration Tools Pack before you install the final release version.

    > [!NOTE]
    > In some limited cases, servers must be administered from clients that are running the same operating system. For example, some remote administration operations against Windows 2000-based servers can be performed only from Windows 2000-based clients. Similarly, some operations against Windows Server 2003-based computers can be performed only from Windows Server 2003-based clients or from Windows XP-based clients. This article documents these limitations or restrictions for each tool that is included in the Administration Tools Pack.  

- If you do not uninstall earlier versions of the Administration Tools Pack (Adminpak.msi) before you upgrade to Windows Server 2003 Service Pack 2, the Administration Tools Pack cannot uninstall after you upgrade. If you try to uninstall the Administration Tools Pack through Add or Remove Programs or by running Adminpak.msi, you receive the following error messages:  

    Error message 1  
    > Windows Server 2003 Administration Tools Pack can only be installed on Windows XP Professional with hotfix Q329357 applied, on Windows XP Professional Service Pack 1 or later versions, or on computers that are running Windows Server 2003 operating systems.  

    Error message 2  
    > Setup Failed - Due to an error, Windows Server 2003 Administration Tools Pack Setup Wizard was unable to finish.

- You cannot install the Windows 2000 Adminpak.msi file on Windows Server 2003-based computers or on Windows XP-based clients. These tools no longer work on these operating systems and are not supported. Use the Windows Server 2003 version of the Administration Tools Pack on Windows XP-based computers.
- The Windows Server 2003 Administration Tools Pack cannot be installed or run on Windows 2000-based computers. If you try to install the Windows Server 2003 Administration Tools Pack on a Windows 2000-based computer, you receive the following error message: Windows Server 2003 Administration Tools Pack can only be installed on Windows XP Professional with hotfix Q329357 applied, or on Windows XP Professional SP1 or later, or on computers that are running Windows Server 2003 operating systems.

    Service pack level mismatch. Obtain the Administration Tools Pack that matches the service pack level of your operating system.

- Similarly, the command-line utilities from the Windows Server 2003 Administration Tools Pack run only on computers that are running Windows XP or Windows Server 2003. Command-line utilities in the Windows Server 2003 Administration Tools Pack do not run if there is a DLL mismatch or an entry-point error. Such a mismatch or error may occur if you copy the utilities to a Windows 2000-based computer. If you try to install the Windows 2000 Administration Tools Pack on a Windows Server 2003-based computer, you receive the following error message:

    Windows 2000 Administration Tools are incompatible with Windows Server 2003 operating systems. Install Windows Server 2003 Administration Tools Pack.

- Windows XP Professional does not include the Windows Server 2003 Adminpak.msi file because these tools are part of the Windows Server 2003 product and are shipped when that product is released.
- If you are using Windows XP Professional with Service Pack 2 and the Windows Server 2003 Administration Tools Pack, you cannot administer Cluster servers. However, if you are using Windows XP Professional with SP1 and the Windows Server 2003 Administration Tools Pack, you can manage Cluster servers.
- Most Windows Server 2003 administration tools work the same as their Windows 2000 counterparts. Sometimes, the Windows Server 2003 administration tools offer increased functionality with regard to their Windows 2000 counterparts. For example, the new drag-and-drop feature of the Windows Server 2003 Users and Computers snap-in is fully functional against Windows 2000-based domain controllers. In other cases, increased functionality in Windows Server 2003 administration tools is not turned on or is not supported when you administer Windows 2000-based computers.

For example, features in the administration tools that depend on functionality in Windows Server 2003, such as the "Saved query for last logon time" functionality, are not supported against Windows 2000 Server-based computers because earlier-version servers do not have the required server-side support. In rare cases, Windows Server 2003 administration tools are incompatible with Windows 2000 Server-based computers and are unsupported for managing those computers. Similarly, in rare cases, Windows 2000 administration tools are incompatible with Windows Server 2003-based computers.

### Upgrade Windows 2000 computers to Windows Server 2003 or to Windows XP

When a Windows 2000-based computer that has the Windows 2000 Adminpak installed is upgraded to Windows Server 2003 or to Windows XP, the System Compatibility Report that is displayed in the upgrade process reports that the Windows 2000 administration tools are incompatible with Windows Server 2003 or with Windows XP. If you click **Details**, you receive the following error message: Setup has detected Windows 2000 Administration Tools on your computer. Windows 2000 Administration Tools are incompatible with Windows Server 2003 operating systems. Use one of the following methods:  

- Cancel this upgrade, remove Windows 2000 Administration Tools, and then restart the upgrade.
- Complete this upgrade, and then immediately install the Windows Server 2003 Administration Tools Pack by running the Adminpak.msi Windows Installer package file. Adminpak.msi is located in the \i386 folder of your Windows Server 2003 CD.

> [!NOTE]
> If the Windows 2000 administration tools were left in place when the Windows 2000-based computer was upgraded to Windows Server 2003, do not try to remove the Windows 2000 Administration Tools icon that appears in the Add or Remove Programs item in Control Panel.

If you try to remove the Windows 2000 administration tools by using the Add or Remove Programs tool, you may receive the following error message:  
> apphelp dialog cancelled thus preventing the application from starting.  

Ignore this error message. When you install the Windows Server 2003 Administration Tools Pack, the Windows 2000 Administration Tools icon is replaced by the Windows Server 2003 Administration Tools Pack icon.

### Download and install the Windows Server 2003 Administration Tools Pack on 32-bit and 64-bit Windows XP Professional and 32-bit and 64-bit Windows Server 2003

You can install the original-release version of the Windows Server 2003 Administration Tools Pack on computers that are running the following operating systems:  

- Windows XP Professional with Service Pack 2
- Windows XP Professional with Service Pack 1
- Windows Server 2003, 32-bit versions
 The original-release version of the Windows Server 2003 Adminpak.msi file was repackaged on the Microsoft Web site as Adminpak.exe after the release of Windows Server 2003.

You can install the Service Pack 1 version of the Windows Server 2003 Administration Tools Pack on computers that are running the following operating systems:  

- Windows XP Professional with Service Pack 2
- Windows XP Professional 64-bit Edition
- Windows Server 2003, 32-bit versions
- Windows Server 2003, 64-bit versions
 The latest revision of the Windows Server 2003 Administration Tools Pack is the Windows Server 2003 Service Pack 2 version. You can install the Service Pack 2 version of the Windows Server 2003 Administration Tools Pack on computers that are running the following operating systems:
- Windows XP Professional 64 Edition
- Windows Server 2003 All Editions (32-bit x86)
- Windows Server 2003 Itanium-based Edition
- Windows Server 2003 x64 Editions
- Windows Server 2003 R2 Editions
- Windows Server 2003 Storage Server R2 Edition
- Windows Server 2003 Compute Cluster Edition
- Windows Server 2003 for Small Business Servers R2 Edition

> [!NOTE]
> The version of Adminpak that is included in the I386 folder of the installation media for the 64-bit versions of Windows Server 2003 is called Wadminpak.msi. The Wadminpak.msi file is identical to and interchangeable with the Adminpak.msi file that can be downloaded from `www.microsoft.com` and that is included with 32-bit versions of Windows Server 2003 Service Pack 2. For ease of installation, you can install the Windows Server 2003 SP2 Adminpak.msi file on 32-bit or 64-bit versions of Windows XP Professional or on 32-bit or 64-bit versions of Windows Server 2003. Similarly, you can install Wadminpak.msi on 32-bit or 64-bit versions of Windows XP Professional or on 32-bit or 64-bit versions of Windows Server 2003.

To install the Windows Server 2003 Administration Tools Pack, follow these steps:  

1. Download the Windows Server 2003 Service Pack 2 Administration Tools Pack. To do this, visit the following Microsoft Web site: [Microsoft Download Center](https://www.microsoft.com/download/search.aspx?displaylang=en)  

    Perform a keyword search for "adminpak" for the "Windows XP" or "Windows Server" operating system.

2. Log on to the local computer by using administrator credentials.

3. Remove earlier versions of the Administration Tools Pack.

    You must remove earlier versions of the Administration Tools Pack before you can install a later version, including the final release.

    If you cannot use Add or Remove Programs in Control Panel to remove earlier versions of the Administration Tools Pack, you can use the MSIZap tool from the Support\Tools\Suptools.msi package to remove the older cached package.

    If the Windows Server 2003 Beta 3 version of the Administration Tools Pack is installed, follow these steps:  

    1. Save the following text as a file that is named Rrasreg.cmd:

        ```console
        rem  
        rem RAS user snap-in extension - registry key cleanup, Beta 3 to RC1  
        rem upgrades only.  
        rem  
        rem use Reg.exe to delete the old key that was created by the Beta 3  
        rem RAS user extension snapin.  
        rem  
        reg delete HKEY_CLASSES_ROOT\RasDialin.UserAdminExt /f  
        reg delete HKEY_CLASSES_ROOT\RasDialin.UserAdminExt.1 /f  
        reg delete HKLM\SOFTWARE\Microsoft\MMC\NodeTypes\{19195a5b-6da0-11d0-afd3-00c04fd930c9}\Extensions\NameSpace /f
        ```

    2. Type `Rrasreg.cmd` at the command prompt.

4. Install the Administration Tools Pack.

    Adminpak.exe is a self-extracting file that creates the Adminpak-readme.txt file and the Adminpak.msi file in a folder that you specify when you install the file. To install the Administration Tools Pack, right-click the .msi file, and then click **Install**, or double-click the .msi file. Alternatively, by using Group Policy, you can use Active Directory to remotely install or to publish the file to a Windows XP-based computer or to a Windows Server 2003-based computer when a user logs on to the computer.

    For more information about how to remotely install the Administration Tools Pack, click the following article numbers to view the articles in the Microsoft Knowledge Base:  
     [816102](https://support.microsoft.com/help/816102) How to use Group Policy to remotely install software in Windows Server 2003  

    > [!NOTE]
    > When you upgrade a Windows 2000-based server to Windows Server 2003, the system compatibility check in Windows Server 2003 Winnt32.exe or in the Winnt32 /checkupgradeonly process may incorrectly detect that the Administration Tools Pack has been installed on your Windows 2000 domain controller. This issue occurs because the Active Directory Installation Wizard (Dcpromo.exe) on Windows 2000 uses a feature in the Windows 2000 Adminpak file to create shortcut menu items for the domain administration tools. You may safely ignore this message and continue with the upgrade process from Windows 2000 to Windows Server 2003.

### What to expect from the original-release version of the Windows Server 2003 Administration Tools Pack

- Before you contact Microsoft Customer Support Services (CSS), see the known compatibility issues that are described in this article, and note the release date of their resolution.

- You must remove earlier versions of Adminpak.msi (Beta 3, RC1, RC2) before you install Windows XP SP1 on your Windows XP-based computer. If you have installed Windows XP SP1 on a Windows XP-based computer that has the Administration Tools Pack beta 3 version installed, you cannot use Add or Remove Programs in Control Panel to remove earlier versions of the Administration Tools Pack.
- Windows XP Home Edition-based computers cannot join Microsoft Windows NT 4.0-based, Windows 2000-based, or Windows Server 2003-based domains. Windows XP Home Edition is not a supported operating system for Administration Tools Pack installations.

### What to do when you experience remote administration problems

1. Confirm that you are using the latest supported version of the Adminpak.msi snap-ins and DLL files that are available from the Microsoft Web site. You can use the APVer.vbs script that is included with the original-release version of the Adminpak Web download package to determine the version of the Administration Tools Pack that you have installed on your computer. To do this, change to the folder where you expanded Adminpak.exe, and then type apver /? to see a list of options for this diagnostic script.

2. See the known compatibility issues that are described in this article to determine whether the issue is known.

3. Notify Microsoft Customer Support or your support provider.

## More information

### Known issues for the Windows Server 2003 original-release version of Adminpak.msi

#### Installation and upgrade issues

Windows Server 2003 Winnt32.exe and the Winnt32 /checkupgradeonly process on Windows 2000 domain controllers report that Adminpak.msi is installed when it was never installed or when it has already been removed.

This issue occurs because the Active Directory Installation Wizard (Dcpromo.exe) in Windows 2000 uses an internal feature of the Windows 2000 version of Adminpak.msi to install menu shortcuts on domain controllers. You can safely ignore this warning in Winnt32.exe and continue the upgrade. After the upgrade is complete, install the Windows Server 2003 version of Adminpak.msi from the I386 folder of the installation media to make sure that you have the latest version of the domain administration tools.

#### Active Directory Domains and Trusts

- The original-release version of the Windows Server 2003 Administration Tools Pack introduces Lightweight Directory Access Protocol (LDAP) signing. Windows 2000 domain controllers that are being remotely administered by Windows 2000-based computers that are running Service Pack 4 (SP4), by Windows XP-based computers, or by Windows Server 2003-based computers that are using NTLM authentication must have Windows 2000 Service Pack 3 installed.

If you use a Windows 2000-based computer to administer Windows Server 2003-based domains, you do not see advanced user interface (UI) features that are supported by Windows Server 2003-based domains. For example, you do not see domain and forest functionality or advanced trusts.

#### Active Directory Schema

- The original-release version of the Windows Server 2003 Administration Tools Pack introduces LDAP signing. Windows 2000 domain controllers that are being remotely administered by Windows 2000-based computers that are running Service Pack 4 (SP4), by Windows XP-based computers, or by Windows Server 2003-based computers that are using NTLM authentication must have Windows 2000 SP3 installed.  

- The **Schema may be modified on this Domain Controller** check box has been removed from the **Change Schema Master** dialog box. By default, schema updates are enabled on Windows Server 2003-based domain controllers.  

#### Active Directory Sites and Services

- The original-release version of the Windows Server 2003 Administration Tools Pack includes LDAP signing. Windows 2000 domain controllers that are being remotely administered by Windows 2000-based computers that are running Service Pack 4 (SP4), by Windows XP-based computers, or by Windows Server 2003-based computers that are using NTLM authentication must have Windows 2000 SP3 installed.  

- There is no support for editing certificate templates.  

- When you click **Show Services Node** on the **View** menu, the Services Node enabled command has been removed on Windows XP clients.

- When the Service Pack 1 version of Active Directory Sites and Services is started on 64-bit systems, it may not edit Group Policy. Additionally, you receive the following error message:

    Windows cannot find gpedit.msc. Make sure you typed the name correctly, and then try again. To search for a file, click the Start button, and then click Search.

    Modify the syntax of your command line or shortcut to use the following syntax: `%windir%\syswow64\mmc.exe %systemroot%\system32\dssite.msc -32`  

- There are no known issues when Windows 2000-based forests are administered from Windows Server 2003-based clients or from Windows XP Professional-based clients.

#### Active Directory Users and Computers

- The original-release version of the Windows Server 2003 Administration Tools Pack includes LDAP signing. Windows 2000 domain controllers that are being remotely administered by Windows 2000-based computers that are running Service Pack 4 (SP4), by Windows XP-based computers, or by Windows Server 2003-based computers that are using NTLM authentication must have Windows 2000 SP3 installed.  

- The **Dial-in** tab that configures Routing and Remote Access dial-in or VPN access and callback settings is removed when the original-release version of the Administration Tools Pack is installed on Windows XP-based clients.

  Fixes or workarounds for this problem include the following:  

  - Install Q837490 on the pre-Service Pack 2 Windows XP-based client. This hotfix adds the remote access dial-in tab on pre-Service Pack 2 Windows XP-based clients that are running the original-release version of the Windows Server 2003 Active Directory Users and Computers snap-in, Dsa.msc, that is installed by the original-release version of the Windows Server 2003 Adminpak.msi.

  - Install the Windows Server 2003 Service Pack 2 version of Adminpak on Windows XP-based computers that have Windows XP Service Pack 2 or later versions installed.
  - Use Remote Access Policy.
  - Start Active Directory Users and Computers from a Windows Server 2003-based computer or from a Windows 2000-based computer that is accessed over Terminal Services or Remote Desktop Access.
  - Start Active Directory Users and Computers from the console of a Windows Server 2003-based computer or of a Windows 2000-based computer.  

  To manage dial-in properties on the user account, use the remote access policy administration model. The remote access policy administration model was introduced in Windows 2000 to address the limitations of the earlier dial-in account permission model. The remote access policy administration model uses Windows groups to manage remote access permissions.

Customers who use the recommended administration model that is named "remote access policy administration model," can use the administration package from Windows XP to manage remote access permission for users in Active Directory. Settings on the **Dial-in** tab are not typically used for VPN or wireless deployments. There are several exceptions. For example, administrators who deploy dial-up networks may use callback number. In these cases, use Terminal Services or Remote Desktop to access a Windows Server 2003-based or Windows 2000-based computer, or log on to the console of a Windows Server 2003-based computer or of a Windows 2000-based computer to manage the **Dial-in** tab.

The remote access policy administration model has the following benefits:  

- Detailed administration

Administrators who manage dial-in permission must also have access to the whole user account. The user account has many more security properties. In the policy administrative model, a separate group can be created to grant dial-in permissions. Additionally, permissions to manage access to that group can be granted to a different administrator.

- Groups for access control

Most Microsoft Windows programs use groups for access control. Groups reduce the additional attempt of managing separate permissions network access. You can use the same groups for controlling access to dial-up, VPN, wireless network, or file shares.

- Precise connection-specific Access Policy control

There are many challenges that are introduced when you are deploying more than one access technology at the same time. The permissions and the settings for dial-up, VPN, and wireless technologies may be different. For example, contractors may be permitted to access wireless networks but may not be permitted to connect from home by VPN. Wireless may require different security settings with regard to VPN and dial-up connections. Callback settings may be useful when you are connecting from a local area code. However, you may want to disable callback when the user is connecting from an international telephone number.

You can configure the remote access policy administration model in the **Remote Access Policies** node of the Routing and Remote Access snap-in when the domain is configured in Windows 2000 native mode or a later version. To remotely manage the remote access dial-in tab in Active Directory Users or Computers or in Internet Authentication Server (IAS) from a Windows XP-based computer, use Terminal Services or Remote Desktop to access a Windows Server 2003-based or Windows 2000-based computer. Or, log on to the console of a Windows Server 2003-based computer or of a Windows 2000-based computer to configure these settings directly.

- Windows XP-based computers that are joined to Windows 2000-based domain controller domains do not support the enhanced functionality to select multiple users and to make bulk edits for attributes such as the home folder and the profile path. The multiple-select functionality is supported in forests where the schema version is 15 or later versions. For example, executing the Windows Server 2003 ADDPREP /ForestPrep and /DomainPrep in a Windows 2000-based forest and domain would enable multiple-selection support on systems that have the Windows Server 2003 Active Directory Users and Computers snap-in installed.

- When the Service Pack 1 version of Active Directory Users and Computers is started on 64-bit systems, it may not always edit Group Policy. Additionally, you receive the following error message:

Windows cannot find gpedit.msc. Make sure you typed the name correctly, and then try again. To search for a file, click the Start button, and then click Search.

Modify the syntax of your command line or shortcut to use the following syntax: `%windir%\syswow64\mmc.exe %systemroot%\system32\dsa.msc -32 back`  

#### Authorization Manager

This has been added to the Administration Tools Pack in the Windows Server 2003 RC1 version and later versions.

#### Certification Authority

Because of extensive schema changes, you cannot use Windows XP Professional-based clients to administer Windows 2000-based computers, and you cannot use Windows 2000-based clients to administer Windows Server 2003-based computers. To administer Windows Server 2003-based computers, perform remote administration from the console or from a Terminal Services session on the destination computer, or use Windows 2000-based clients to manage Windows 2000 Server-based computers and Windows XP-based and Windows Server 2003-based clients.

#### Cluster Administrator

If you are using Windows XP Professional with Service Pack 2 and the Windows Server 2003 Administration Tools Pack, you cannot administer Cluster servers. However, if you use Windows XP Professional with SP1 and Windows Server 2003 Administration Tools Pack, you can manage Cluster servers.

#### Connection Manager Administration Kit

We do not recommend cross-version administration from Windows 2000 to Windows Server 2003 because this does not produce Windows XP profiles.

#### Delegation Wizard

No known issues.

#### DHCP

- Windows 2000 tools cannot generate a dump file of Windows Server 2003 Dynamic Host Configuration Protocol (DHCP) configurations because of code changes.

- There are no new issues in Windows Server 2003 Service Pack 2.

#### Distributed File System (DFS)

- Adds ring, hub and spoke, and custom topology support for File Replication Service (FRS) replication of DFS roots and links.

- Configures connection priority in the Q321557 and SP3 release of Windows 2000 Ntfrs.exe.

- If you are using a Windows XP-based client, you must use the Windows XP SP1 update to administer Windows Server 2003 DFS.

- Adminpak now includes the Windows Server 2003 DFS Server Help file.

#### DNS

When you access a Domain Name System (DNS) server through an IP address, some information that is returned, such as Forwarder information, will be incorrect. To work around this problem, access the DNS server through a host name instead of through an IP address. This issue applies to the original-release version of the Windows Server 2003 Administration Tools Pack.

#### Directory Service command-line utilities

The original-release version of the Windows Server 2003 Administration Tools Pack includes LDAP signing. Windows 2000 domain controllers that are being remotely administered by Windows 2000-based computers that are running Service Pack 4 (SP4), by Windows XP-based computers, or by Windows Server 2003-based computers that are using NTLM authentication must either have Windows 2000 SP3 installed.  

#### Drag-and-drop functionality of Active Directory snap-ins

The original release version of Windows Server 2003 Adminpak.msi added drag-and-drop capabilities to the following snap-ins:  

- Active Directory Users and Computers
- Active Directory Sites and ServicesBe careful that you do not accidentally or unknowingly move organizational units (OUs) under different parent OUs. This action may have the following results:
- User and computer accounts do not apply Group Policy as expected. Specifically, Group Policy objects (GPOs) that are applied to user and computer accounts may no longer apply because of a different OU hierarchy or because new GPOs may now apply that are based on the objects' new location. The application or nonapplication of Group Policy may affect the operating system behavior. For example, access to operating system features and to shared resources on the network may be affected.
- Programs that are configured to use hard-coded distinguished name paths may not always locate required objects.

##### Drag-and-drop behavior changes in the Windows Server 2003 SP2 version of Adminpak.msi

In the Windows Server 2003 SP2 version of Adminpak.msi, two new options are available to control drag-and-drop behavior in the Active Directory Users and Computers snap-in and in the Active Directory Sites and Services snap-in:  

- By default, a warning dialog box is presented when you try to perform a drag-and-drop operation. You can dismiss the warning dialog box for the session. However, the dialog box will appear again the next time that you start the snap-in.
- You can disable drag-and-drop capabilities by setting the first part of the **DisplaySpecifiers** attribute to 0 (zero) in the configuration naming context in Active Directory. Because this is a forest-wide setting, drag-and-drop capabilities will be disabled for every domain in the forest. To disable the drag-and-drop feature, follow these steps:

    > [!NOTE]
    > You must have the Active Directory Service Interfaces (ADSI) Edit tool installed to complete this procedure. ADSI Edit is included with the Windows Server 2003 SP2 Support Tools. For more information, click the following article number to view the article in the Microsoft Knowledge Base:  
    > [892777](https://support.microsoft.com/help/892777) Updates to the Windows Server 2003 Support Tools are included in Windows Server 2003 Service Pack 2  

    1. If you have the Active Directory Users and Computers snap-in or the Active Directory Sites and Services snap-in open, close the snap-ins.  
    2. Click **Start**, click **Run**, type adsiedit.msc in the **Open** box, and then click **OK**.  
    3. Expand **Configuration**.
    4. Expand **CN=Configuration,DC=**ForestRootName****.
    5. Right-click **CN=DisplaySpecifiers**, and then click **Properties**.
    6. In the list of attributes, double-click **flags**.
    7. In the **Integer Attribute Editor** dialog box, type 1 in the **Value** box.
    8. Click **OK** two times.
    9. Close ADSI Edit.

#### Microsoft Exchange

- The Microsoft Exchange Simple Mail Transfer Protocol (SMTP) and Network News Transfer Protocol (NNTP) DLL files were added to Adminpak.msi. The additional Staxmem.dll, Smtpapi.dll, Smtpadm.dll, Smtpsnap.hlp, and Nntpsnap.hlp files were added to Adminpak.msi to allow 32-bit Windows XP Professional-based clients to administer the release of Exchange after Microsoft Exchange 2000.

- Administration of Exchange-based servers after the Exchange 2000 version from 64-bit clients is not supported.

#### Help

- The Ntcmds.chm Help file was added to support command-line administration.
- The Windows XP Professional Help files are reinstalled when the Administration Tools Pack is removed. Windows XP Professional versions of the Ntart.chm and Ntcmds.chm files are backed up during the installation of the Administration Tools Pack and are restored during removal.

#### Internet Information Services command-line utilities

This section applies to the following utilities:  

- IisApp.vbs

- Iisback.vbs

- IisCnfg.vbs

- IisFtp.vbs

- IisFtpdr.vbs

- Iisvdir.vbs

- Iisweb.vbs

The following issues have been reported:  

- All scripts are compatible with Microsoft Internet Information Services (IIS) 6.0 only.

- IISCnfg: When you use the `iiscnfg /export` command, the destination file (the file that you specify after the /f switch) is created on the remote computer (the Windows Server-based computer). For example, to export the metabase, type the following command:

    ```console
    iiscnfg /s RemoteServer /u UserName /p UserPwd /export /f d:\Config.xml /sp /LM/W3SVC/1
    ```

    When you run this command, the D:\Config.xml file is created on the remote server. To import the metabase, type the following command:

    ```console
    iiscnfg /s RemoteServer /u UserName /p UserPwd /import /f d:\Config.xml /sp /LM/W3SVC/1 /dp /LM/W3SVC/2  
    ```  

    > [!NOTE]
    > These commands are one line each. They have been wrapped for readability.

    IISCnfg checks that the D:\Config.xml file (the file that you specify after the /f switch) exists on both the local and the remote computer (RemoteServer). However, the actual import uses only the file on the remote server. When you import or copy the Config.xml file from the remote server, use the same path on the local computer.

#### Internet Authentication Service

The Internet Authentication Service (IAS) snap-in has been removed from the Administration Tools Pack.

#### Netsh

- The netsh dhcp server ip dump command output is truncated. The output from this command that is issued from a Windows Server 2003-based computer against a Windows Server 2003-based DHCP server returns the following output:

    > Dhcp Server 157.59.136.135 Add Optiondef 100 "Byte Array" BYTE 1 comment="" 4 3 2 1 0 Dhcp Server 157.59.136.135 Add Optiondef 101 "String Array" STRING 1 comment="" "hello" "cathy" "jim" "bob" Dhcp Server 157.59.136.135 Add Optiondef 102 "IP Array" IPADDRESS 1 comment="" 4.4.4.4 3.3.3.3 2.2.2.2 1.1.1.1  

    The same command that is issued from a Windows XP-based client is truncated as follows:

    > Dhcp Server 220.0.80.23 Add Optiondef 100 "Byte Array" BYTE 1 comment="" 4 Dhcp Server 220.0.80.23 Add Optiondef 101 "String Array" STRING 1 comment="" hello Dhcp Server 220.0.80.23 Add Optiondef 102 "IP Array" IPADDRESS 1 comment="" 4.4.4.4

- By default, the `netsh dhcp server` command does not run from Windows XP-based clients. For example, the following command runs successfully from a Windows Server 2003-based computer but does not run from a Windows XP-based client:

    Dhcp Server 157.59.136.135 Add Optiondef 101 "String Array" STRING 1 comment="" "hello" "cathy" "jim" "bob"  

    If you run this command from a Windows XP-based client, you receive the following error message:

    > DHCP Server Add OptionDef failed.
    >
    > Parameter(s) passed are either incomplete or invalid.

    To remotely administer a DHCP server from a Windows XP-based client, install the Administration Tools Pack, and then type the following command at the command prompt:

    ```console
    netsh add helper dhcpmon.dll  
    ```

#### Network Load Balancing Manager

- No known issues in the release version of the Windows Server 2003 Adminpak.

- The Service Pack 2 Adminpak installs a 32-bit Network Load Balancing Manager that does not bind on 64-bit versions of Windows.  

#### Ntdsutil.exe

The authoritative restore command in Ntdsutil depends on Ntdsbsrv.dll. Ntdsbsrv.dll is not included in Windows XP Professional or in the Windows Server 2003 Administration Tools Pack. Perform authoritative restores from the console of Active Directory-based domain controllers. If you must run this command on Windows XP-based clients, copy the Ntdsbsrv.dll file from a release version of a Windows Server 2003 installation.

#### Object Picker

The original-release version of the Windows Server 2003 Administration Tools Pack introduces LDAP signing. Windows 2000 domain controllers that are being remotely administered by Windows 2000-based computers that are running Service Pack 4 (SP4), by Windows XP-based computers, or by Windows Server 2003-based computers that are using NTLM authentication must have Windows 2000 SP3 installed.  

#### Remote Access User Extensions

Remote Access User Extensions have been removed from the original-release version of the Windows Server 2003 Administration Tools Pack. The Remote Access User Extensions are available if the version of the Adminpak.msi file that is included in Windows Server 2003 Service Pack 2 (SP2) is installed on your Windows XP Professional-based computer. If you have the RTM or SP1 version of the Adminpak.msi file installed, you must uninstall it and then install the Windows Server 2003 SP2 version.

#### Remote Desktop

Connect to Console mode is supported against Windows Server 2003-based and Windows XP-based computers only.  

#### Remote Storage

- Cross-version administration is not supported. Remote Storage administration from Windows 2000-based computers is not supported against Windows Server 2003-based and Windows XP-based computers. Perform remote administration from a Windows 2000-based computer, from the console of the destination computer, or over a Terminal Services session.

- Cross-version administration is not supported. Versions of Windows Server 2003 and Windows XP that are running the Windows Server 2003 Administration Tools Pack cannot administer Windows 2000-based computers. Perform remote administration from a Windows Server 2003-based computer, from a Windows XP-based computer, from the console of the destination computer, or from a Terminal Services session.

#### Remote Installation Services (RIS) UI Administration Extension

No known issues.

#### Routing and Remote Access

This has been removed from the Administration Tools Pack.

#### Telephony

Telephony administrators cannot administer remote lines on a Windows 2000 Server-based computer from a Windows XP Professional-based computer. Specifically, the **Edit users** option is unavailable.

#### Terminal Services Licensing Manager

No known issues.

#### UDDI

No known issues.

#### Windows Server 2003 Administration Tools issues on x64-based versions of Windows Server 2003

When you try to modify a Group Policy on an x64-based version of Windows Server 2003 from the Active Directory Users and Computers snap-in, the Active Directory Sites and Services snap-in, or the Group Policy Management Console snap-in, you receive the following error message:  
> Windows cannot find 'gpedit.msc'. Make sure you typed the name correctly and then try again.
To search for a file click the Start button and then click Search  

When you try to modify a GPO from any one of the snap-ins that is listed earlier, a call is made to start the Gpedit.msc file. Currently, the snap-ins that call the Gpedit.msc file are 32-bit tools. However, on x64-based versions of Windows Server 2003, Gpedit.msc is a 64-bit snap-in. This problem will be corrected in a future release of a 64-bit Adminpak.msi package. To work around this problem, use either of the following methods.

##### Method one

Modify the GPOs from a computer that is running a 32-bit version of Windows Server 2003, a 32-bit version of Windows XP, or a version of Windows 2000.

##### Method two

Use the following commands to start the snap-ins, and then modify the GPOs:  

- To start the Active Directory Users and Computers snap-in: `%windir%\syswow64\mmc.exe %windir%\system32\dsa.msc -32`  

- To start the Active Directory Sites and Service snap-in: `%windir%\syswow64\mmc.exe %windir%\system32\dssite.msc -32`  

#### Compatibility of the out-of-band (OOB) version of Microsoft Group Policy Management Console (GPMC) with 64-bit versions of Windows XP, Windows Server 2003 and Windows Server R2

The OOB version of GPMC must be run on 32-bit platforms. The OOB version of GPMC is not supported on 64-bit versions of Microsoft Windows. There are no plans to update the OOB version of GPMC to support 64-bit versions of Microsoft Windows for Windows Server 2003 or Windows XP Service Pack 2 (SP2). In 64-bit versions of Windows Vista and of Windows Server 2008. the 64-bit version of GPMC is supported. However, GPMC Reporting cannot be installed on all 64-bit versions of Microsoft Windows. This version of GPMC is not part of any current Administration Tools package.  

Also, you may receive the following error message when you try to open GPMC:Windows cannot find GPEDIT.MSC.
This problem occurs even though you use the following command to open GPMC:  `%windir%\syswow64\mmc.exe %windir%\system32\gpmc.msc -32`  
For more information, click the following article number to view the article in the Microsoft Knowledge Base:

[304718](https://support.microsoft.com/help/304718) How to use the Administration Tools Pack to remotely administer computers that are running Windows Server 2003, Windows XP, or Windows 2000  

#### WINS

The change to the Windows Internet Name Service (WINS) remote procedure call (RPC) API among Windows Server 2003, Windows XP Professional, Windows 2000, and Windows NT 4.0 prevents the remote administration of Windows NT 4.0-based WINS servers from Windows 2000 versions of the WINS Microsoft Management Console (MMC) snap-in and from Windows Server 2003 versions of the WINS MMC snap-in. This is not a regression, because Windows 2000 shares the same limitation.
