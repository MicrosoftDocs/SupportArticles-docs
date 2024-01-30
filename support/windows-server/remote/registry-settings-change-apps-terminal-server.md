---
title: Terminal Server registry settings for applications
description: Discusses the registry settings that can be used to modify application behavior on a Terminal Server computer.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:application-compatibility, csstroubleshoot
ms.subservice: rds
---
# Terminal Server registry settings for applications

This article discusses the registry settings that can be used to modify application behavior on a Terminal Server computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 186499

## Controlling Application Execution in Execute Mode

Several compatibility bits can be set for an application, registry path, or .ini file to change how a Terminal Server computer handles the merging of application initialization data when a session is in execute mode. These compatibility bits are set in the registry under the following subkey:

`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Terminal Server\Compatibility`

There are three separate keys for applications, .ini files, and registry entries under this registry path.

The default settings work for most applications, but they can be further tuned by using the following compatibility bits.

> [!WARNING]
> These compatibility bits should only be changed if an application is not working properly.

The first set of compatibility bits indicates the version of the application that the settings are for. Not all combinations are useful (for example, an MS-DOS application does make registry calls). Because the path to the file isn't specified and multiple applications may use the same file name (for example, Setup.exe and Install.exe are now regularly used for installation programs), specify the application type to help make sure that the compatibility settings don't affect other applications with the same file name.

To determine the String Value, add the values of the bits that you want to set. For example, to return the user name instead of the computer name for both 16-bit and 32-bit versions of Myapp.exe, create a subkey in the registry by performing the following steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

1. Start Registry Editor.
2. Locate the following registry subkey:  
`HKEY_LOCAL_MACHINE \Software\Microsoft\Windows NT\CurrentVersion\Terminal Server\Compatibility\Applications\Myapp`

3. On the Edit menu, click Add Value, and type the following information:

    Value Name: Flags  
    Type: REG_DWORD  
4. In the Data box, type the hex value of 11C (add 0x00000004 for 16-bit Windows applications, add 0x00000008 for 32-bit Windows applications, add 0x00000010 to return the user name instead of the computer name, and add 0x00000100 to disable registry mapping).

## Applications

The following compatibility bits affect the application when it's running. They're located in the following registry subkey (where *Appname* is the name of the application's executable file):

`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Terminal Server\Compatibility\Applications\\Appname`  

### Compatibility Bits

- MS-DOS application: 0x00000001
- OS/2 application: 0x00000002
- Windows 16-bit application: 0x00000004
- Windows 32-bit application: 0x00000008
- Return user name instead of computer name: 0x00000010
- Return Terminal Server build number: 0x00000020
- Disable registry mapping for this application: 0x00000100
- Do not substitute user Windows directory: 0x00000400
- Limit the reported memory: 0x00000800

Use the "Return user name instead of computer name" bit for applications that use the computer name as a unique identifier. This returns the user's name to the application and gives a unique identifier to each user of the application.

Use the "Disable registry mapping for this application" bit to retain only one global copy of the registry variables that are used by the application.

If the "Do not substitute user Windows directory" bit is set, it retains the SystemRoot directory for GetWindowsDirectory API calls. If this bit is not set, all paths to the Windows directory are replaced with the path to the user's Windows directory.

## .Ini Files

The following compatibility bits control .ini file propagation. They're located in the following registry subkey (where **Inifile** is the name of the .ini file):

`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Terminal Server\Compatibility\IniFiles\\Inifile`  

### Compatibility Bits

- Windows 16-bit application: 0x00000004
- Windows 32-bit application: 0x00000008
- Synchronize user .ini file to system version: 0x00000040
- Do not substitute user Windows directory: 0x00000080

If the "Synchronize user .ini file to system version" bit is set, it adds new entries from the system master .ini file when the application is started, but it doesn't delete any existing data in the user's .ini file. If this bit isn't set, it overwrites the user's .ini file if it's older than the system master .ini file.

If the "Do not substitute user Windows directory" bit is set, it retains the SystemRoot directory for file paths in the .ini file when the system master version of the .ini file is copied to the user's Windows directory. If this bit isn't set, it replaces all paths to the Windows directory with the path to the user's Windows directory.

## Registry Paths

The following compatibility bits control registry propagation. They're located in the following registry subkey (where **PathName** is the registry path under the key HKEY_CURRENT_USER\Software):  

`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Terminal Server\Compatibility\RegistryEntries\\PathName`  

### Compatibility Bits

- Windows 32-bit application: 0x00000008
- Disable registry mapping for application: 0x00000100

If the "Disable registry mapping for application" bit is set, new entries from the system master registry image aren't added to the user's registry. Additionally, the system doesn't delete any existing data in the user's registry. If this bit isn't set, the system deletes and overwrites the user's registry data if the data is older than the system master registry data. If the bit isn't set, the system also adds any new keys not in the user's registry.
