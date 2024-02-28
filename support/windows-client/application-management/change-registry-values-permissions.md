---
title: Change registry values or permissions
description: Describes how to change registry values or permissions from a command line or a script.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-script-host-cscript-or-wscript, csstroubleshoot
---
# How to change registry values or permissions from a command line or a script

This article describes how to change registry values or permissions from a command line or a script.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 264584

## Summary

To change a registry value or registry permissions from a command line or from a script, use the Regini.exe utility. The Regini.exe utility is included in the Windows NT Server 4.0 Resource Kit, in the Microsoft Windows 2000 Resource Kit, and in the Microsoft Windows Server 2003 Resource Kit.

> [!NOTE]
> The Regini.exe utility for Windows 2000 is no longer supported and isn't available for download from Microsoft. This tool is available on the original Microsoft Windows 2000 Resource Kit CD-ROM only.

## More information

The syntax for changing registry values or permissions with Regini is:  
    REGINI [-m \\\\*machinename*] *files*

Here, the `-m \\machinename` option is used to modify the registry of a remote machine, and *files* represents the names of the script files that contain the changes to the registry.

The text file or files should contain the registry changes in the following format.  
    **\Registry\Hiveroot\Subkeys registry value=data [permissions]**  

The Regini utility works with kernel registry strings. When you gain access to the registry in User mode with `HKEY_LOCAL_MACHINE, HKEY_CURRENT_USER`, and so on, the string is converted in Kernel mode as follows:

- HKEY_LOCAL_MACHINE is converted to `\registry\machine`.
- HKEY_USERS is converted to `\registry\user`.
- HKEY_CURRENT_USER is converted to `\registry\user\user_sid`, where user_sid is the Security ID associated with the user.
- HKEY_CLASSES_ROOT is converted to `\registry\machine\software\classes`.

For example, a script file to change the registry value `DiskSpaceThreshold` located in the HKEY_LOCAL_MACHINE hive to the value 0x00000000 would be written as follows.

```console
\registry\machine\system\currentcontrolset\services\lanmanserver\parameters DiskSpaceThreshold = REG_DWORD 0x00000000
```

Registry key permissions are specified by binary numbers separated by spaces, corresponding to Regini.doc file numbers that specify certain permissions given to specific groups. (For example, the number 1 specifies Administrators - Full Control). You can use the Resource Kit utility REGDMP to get the current permissions of a registry key in the binary number format.

> [!CAUTION]
> When you use Regini to change permissions, the current permissions are replaced, not edited.

The following example script file shows the syntax for changing permissions on a registry key.

```console
\Registry\Machine\Software [1 5 10]
```

This script modifies `HKEY_LOCAL_MACHINE\Software` to have the permissions.

```console
Administrators - Full Control
Creator/Owner - Full Control
Everyone - Read
```

In Windows XP and in Windows Server 2003, you must enclose the value in quotation marks. For example, you could use the following script to call AUoptions.txt.

```console
regini.exe -m \\remoteworkstation auoptions.txt HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update "ConfigVer"= REG_DWORD 1 "AUOptions"= REG_DWORD 4 "ScheduledInstallDay"= REG_DWORD 0 "ScheduledInstallTime"= REG_DWORD 1
```

For more information, see the Regini.doc file that is included in the resource kit for your specific operation system.
