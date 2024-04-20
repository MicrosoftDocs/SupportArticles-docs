---
title: Windows registry for advanced users
description: Describes the Windows registry and provides information about how to edit it.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:System Performance\System Performance (slow, unresponsive, high CPU, resource leak), csstroubleshoot
---
# Windows registry information for advanced users

This article describes the Windows registry and provides information about how to edit and back it up.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 256986

## Description of the registry

The _Microsoft Computer Dictionary_, Fifth Edition, defines the registry as:

A central hierarchical database used in Windows 98, Windows CE, Windows NT, and Windows 2000 used to store information that is necessary to configure the system for one or more users, applications, and hardware devices.

The Registry contains information that Windows continually references during operation, such as profiles for each user, the applications installed on the computer and the types of documents that each can create, property sheet settings for folders and application icons, what hardware exists on the system, and the ports that are being used.

The Registry replaces most of the text-based .ini files that are used in Windows 3.x and MS-DOS configuration files, such as the Autoexec.bat and Config.sys. Although the Registry is common to several Windows operating systems, there are some differences among them. A registry hive is a group of keys, subkeys, and values in the registry that has a set of supporting files that contain backups of its data. The supporting files for all hives except HKEY_CURRENT_USER are in the `%SystemRoot%\System32\Config` folder on Windows NT 4.0, Windows 2000, Windows XP, Windows Server 2003, and Windows Vista. The supporting files for HKEY_CURRENT_USER are in the `%SystemRoot%\Profiles\Username` folder. The file name extensions of the files in these folders indicate the type of data that they contain. Also, the lack of an extension may sometimes indicate the type of data that they contain.

| Registry hive| Supporting files |
|---|---|
|HKEY_LOCAL_MACHINE\SAM|Sam, Sam.log, Sam.sav|
|HKEY_LOCAL_MACHINE\Security|Security, Security.log, Security.sav|
|HKEY_LOCAL_MACHINE\Software|Software, Software.log, Software.sav|
|HKEY_LOCAL_MACHINE\System|System, System.alt, System.log, System.sav|
|HKEY_CURRENT_CONFIG|System, System.alt, System.log, System.sav, Ntuser.dat, Ntuser.dat.log|
|HKEY_USERS\DEFAULT|Default, Default.log, Default.sav|

In Windows 98, the registry files are named User.dat and System.dat. In Windows Millennium Edition, the registry files are named Classes.dat, User.dat, and System.dat.

> [!NOTE]
> Security features in Windows let an administrator control access to registry keys.

The following table lists the predefined keys that are used by the system. The maximum size of a key name is 255 characters.

| Folder/predefined key| Description |
|---|---|
|HKEY_CURRENT_USER|Contains the root of the configuration information for the user who is currently logged on. The user's folders, screen colors, and Control Panel settings are stored here. This information is associated with the user's profile. This key is sometimes abbreviated as _HKCU_.|
|HKEY_USERS|Contains all the actively loaded user profiles on the computer. HKEY_CURRENT_USER is a subkey of HKEY_USERS. HKEY_USERS is sometimes abbreviated as _HKU_.|
|HKEY_LOCAL_MACHINE|Contains configuration information particular to the computer (for any user). This key is sometimes abbreviated as _HKLM_.|
|HKEY_CLASSES_ROOT|Is a subkey of `HKEY_LOCAL_MACHINE\Software`. The information that is stored here makes sure that the correct program opens when you open a file by using Windows Explorer. This key is sometimes abbreviated as _HKCR_. Starting with Windows 2000, this information is stored under both the HKEY_LOCAL_MACHINE and HKEY_CURRENT_USER keys. The `HKEY_LOCAL_MACHINE\Software\Classes` key contains default settings that can apply to all users on the local computer. The `HKEY_CURRENT_USER\Software\Classes` key contains settings that override the default settings and apply only to the interactive user. The HKEY_CLASSES_ROOT key provides a view of the registry that merges the information from these two sources. HKEY_CLASSES_ROOT also provides this merged view for programs that are designed for earlier versions of Windows. To change the settings for the interactive user, changes must be made under `HKEY_CURRENT_USER\Software\Classes` instead of under HKEY_CLASSES_ROOT. To change the default settings, changes must be made under `HKEY_LOCAL_MACHINE\Software\Classes`. If you write keys to a key under HKEY_CLASSES_ROOT, the system stores the information under `HKEY_LOCAL_MACHINE\Software\Classes`. If you write values to a key under HKEY_CLASSES_ROOT, and the key already exists under `HKEY_CURRENT_USER\Software\Classes`, the system will store the information there instead of under `HKEY_LOCAL_MACHINE\Software\Classes`.|
|HKEY_CURRENT_CONFIG|Contains information about the hardware profile that is used by the local computer at system startup.|

> [!NOTE]
> The registry in 64-bit versions of Windows XP, Windows Server 2003, and Windows Vista is divided into 32-bit and 64-bit keys. Many of the 32-bit keys have the same names as their 64-bit counterparts, and vice versa. The default 64-bit version of Registry Editor that is included with 64-bit versions of Windows XP, Windows Server 2003, and Windows Vista displays the 32-bit keys under the node `HKEY_LOCAL_MACHINE\Software\WOW6432Node`.
 For more information about how to view the registry on 64-Bit versions of Windows, see
 [How to view the system registry by using 64-bit versions of Windows](https://support.microsoft.com/help/305097).

The following table lists the data types that are currently defined and that are used by Windows. The maximum size of a value name is as follows:

- Windows Server 2003, Windows XP, and Windows Vista: 16,383 characters
- Windows 2000: 260 ANSI characters or 16,383 Unicode characters
- Windows Millennium Edition/Windows 98/Windows 95: 255 characters

Long values (more than 2,048 bytes) must be stored as files with the file names stored in the registry. This helps the registry perform efficiently. The maximum size of a value is as follows:

- Windows NT 4.0/Windows 2000/Windows XP/Windows Server 2003/Windows Vista: Available memory
- Windows Millennium Edition/Windows 98/Windows 95: 16,300 bytes

> [!NOTE]
> There is a 64K limit for the total size of all values of a key.

|Name| Data type| Description|
|---|---|---|
|Binary Value|REG_BINARY|Raw binary data. Most hardware component information is stored as binary data and is displayed in Registry Editor in hexadecimal format.|
|DWORD Value|REG_DWORD|Data represented by a number that is 4 bytes long (a 32-bit integer). Many parameters for device drivers and services are this type and are displayed in Registry Editor in binary, hexadecimal, or decimal format. Related values are DWORD_LITTLE_ENDIAN (least significant byte is at the lowest address) and REG_DWORD_BIG_ENDIAN (least significant byte is at the highest address).|
|Expandable String Value|REG_EXPAND_SZ|A variable-length data string. This data type includes variables that are resolved when a program or service uses the data.|
|Multi-String Value|REG_MULTI_SZ|A multiple string. Values that contain lists or multiple values in a form that people can read are generally this type. Entries are separated by spaces, commas, or other marks.|
|String Value|REG_SZ|A fixed-length text string.|
|Binary Value|REG_RESOURCE_LIST|A series of nested arrays that is designed to store a resource list that is used by a hardware device driver or one of the physical devices it controls. This data is detected and written in the \ResourceMap tree by the system and is displayed in Registry Editor in hexadecimal format as a Binary Value.|
|Binary Value|REG_RESOURCE_REQUIREMENTS_LIST|A series of nested arrays that is designed to store a device driver's list of possible hardware resources the driver or one of the physical devices it controls can use. The system writes a subset of this list in the \ResourceMap tree. This data is detected by the system and is displayed in Registry Editor in hexadecimal format as a Binary Value.|
|Binary Value|REG_FULL_RESOURCE_DESCRIPTOR|A series of nested arrays that is designed to store a resource list that is used by a physical hardware device. This data is detected and written in the \HardwareDescription tree by the system and is displayed in Registry Editor in hexadecimal format as a Binary Value.|
|None|REG_NONE|Data without any particular type. This data is written to the registry by the system or applications and is displayed in Registry Editor in hexadecimal format as a Binary Value|
|Link|REG_LINK|A Unicode string naming a symbolic link.|
|QWORD Value|REG_QWORD|Data represented by a number that is a 64-bit integer. This data is displayed in Registry Editor as a Binary Value and was introduced in Windows 2000.|
  
## Back up the registry

Before you edit the registry, export the keys in the registry that you plan to edit, or back up the whole registry. If a problem occurs, you can then follow the steps in the [Restore the registry](#restore-the-registry) section to restore the registry to its previous state. To back up the whole registry, use the Backup utility to back up the system state. The system state includes the registry, the COM+ Class Registration Database, and your boot files. For more information about how to use the Backup utility to back up the system state, see the following articles:

- [Back up and restore your PC](https://support.microsoft.com/help/17127/windows-back-up-restore)

- [How to use the backup feature to back up and restore data in Windows Server 2003](https://support.microsoft.com/help/326216)

## Edit the registry

To modify registry data, a program must use the registry functions that are defined in [Registry Functions](/windows/win32/sysinfo/registry-functions).

Administrators can modify the registry by using Registry Editor (Regedit.exe or Regedt32.exe), Group Policy, System Policy, Registry (.reg) files, or by running scripts such as VisualBasic script files.

### Use the Windows user interface

We recommend that you use the Windows user interface to change your system settings instead of manually editing the registry. However, editing the registry may sometimes be the best method to resolve a product issue. If the issue is documented in the Microsoft Knowledge Base, an article with step-by-step instructions to edit the registry for that issue will be available. We recommend that you follow those instructions exactly.

### Use Registry Editor

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

You can use Registry Editor to do the following actions:

- Locate a subtree, key, subkey, or value
- Add a subkey or a value
- Change a value
- Delete a subkey or a value
- Rename a subkey or a value

The navigation area of Registry Editor displays folders. Each folder represents a predefined key on the local computer. When you access the registry of a remote computer, only two predefined keys appear: HKEY_USERS and HKEY_LOCAL_MACHINE.

### Use Group Policy

Microsoft Management Console (MMC) hosts administrative tools that you can use to administer networks, computers, services, and other system components. The Group Policy MMC snap-in lets administrators define policy settings that are applied to computers or users. You can implement Group Policy on local computers by using the local Group Policy MMC snap-in, Gpedit.msc. You can implement Group Policy in Active Directory by using the Active Directory Users and Computers MMC snap-in. For more information about how to use Group Policy, see the Help topics in the appropriate Group Policy MMC snap-in.

### Use a Registration Entries (.reg) file

Create a Registration Entries (.reg) file that contains the registry changes, and then run the .reg file on the computer where you want to make the changes. You can run the .reg file manually or by using a logon script. For more information, see [How to add, modify, or delete registry subkeys and values by using a Registration Entries (.reg) file](https://support.microsoft.com/help/310516).

### Use Windows Script Host

The Windows Script Host lets you run VBScript and JScript scripts directly in the operating system. You can create VBScript and JScript files that use Windows Script Host methods to delete, to read, and to write registry keys and values. For more information about these methods, visit the following Microsoft Web sites:

- [RegDelete method](/previous-versions/293bt9hh(v=vs.80))

- [RegRead method](/previous-versions//x05fawxd(v=vs.85))

- [RegWrite method](/previous-versions//yfdfhz1b(v=vs.85))

### Use Windows Management Instrumentation

Windows Management Instrumentation (WMI) is a component of the Microsoft Windows operating system and is the Microsoft implementation of Web-Based Enterprise Management (WBEM). WBEM is an industry initiative to develop a standard technology for accessing management information in an enterprise environment. You can use WMI to automate administrative tasks (such as editing the registry) in an enterprise environment. You can use WMI in scripting languages that have an engine on Windows and that handle Microsoft ActiveX objects. You can also use the WMI Command-Line utility (Wmic.exe) to modify the Windows registry.

For more information about WMI, see [Windows Management Instrumentation](/windows/win32/wmisdk/wmi-start-page).

For more information about the WMI Command-Line utility, see [A description of the Windows Management Instrumentation (WMI) command-line utility (Wmic.exe)](https://support.microsoft.com/help/290216).  

### Use Console Registry Tool for Windows

You can use the Console Registry Tool for Windows (Reg.exe) to edit the registry. For help with the Reg.exe tool, type `reg /?` at the Command Prompt, and then click **OK**.

## Restore the registry

To restore the registry, use the appropriate method.

### Method 1: Restore the registry keys

To restore registry subkeys that you exported, double-click the Registration Entries (.reg) file that you saved in the Export registry subkeys section. Or, you can restore the whole registry from a backup. For more information about how to restore the whole registry, see the [Method 2: Restore the whole registry](#method-2-restore-the-whole-registry) section later in this article.

### Method 2: Restore the whole registry

To restore the whole registry, restore the system state from a backup. For more information about how to restore the system state from a backup, see [How to use Backup to protect data and restore files and folders on your computer in Windows XP and Windows Vista](https://support.microsoft.com/help/309340).

> [!NOTE]
> Backing up the system state also creates updated copies of the registry files in the `%SystemRoot%\Repair` folder.

## References

For more information, visit the following Web sites:

- [Windows 2000 Server Resources Kit](/previous-versions/windows/it-pro/windows-2000-server/cc984339(v=msdn.10))

- [Inside the Registry](/previous-versions//cc750583(v=technet.10))

The [Windows Server Catalog](https://www.windowsservercatalog.com/results.aspx?text=backup&bCatID=1282&OR=5&chtext=&cstext=&csttext=&chbtext=) of Tested Products is a reference for products that have been tested for Windows Server compatibility.

Data Protection Manager (DPM) is a key member of the Microsoft System Center family of management products and is designed to help IT professionals manage their Windows environment. DPM is the new standard for Windows backup and recovery and delivers continuous data protection for Microsoft application and file servers that use seamlessly integrated disk and tape media. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows XP and Windows Vista](https://support.microsoft.com/help/322756).
