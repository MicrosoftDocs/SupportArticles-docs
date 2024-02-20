---
title: How to launch processes inside the App-V 5.0 virtualized environment
description: Describes how to launch processes inside the App-V 5.0 virtualized environment.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:administration, csstroubleshoot
---
# How to launch processes inside the App-V 5.0 virtualized environment

This article describes how to launch processes inside the Microsoft Application Virtualization 5.0 client (App-V 5.0) virtualized environment.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2848278

## Summary

A common troubleshooting task for the App-V 5.0 is to investigate or modify a local package by opening a process inside the context of an App-V application. This is also known as opening a process "in the App-V bubble".  App-V 5.0 offers several alternative methods to perform this task that differ significantly from techniques available in previous versions of the product. Each method detailed below accomplishes essentially the same task, but some methods may be better suited for some applications than others depending on whether the virtualized application is already running.

## PowerShell cmdlet: Get-AppvClientPackage

You can use the `Start-AppVVirtualProcess` cmdlet to retrieve the package name and then start a process within the specified package's virtual environment (substitute the name of your package for \<Package>):

```powershell
$AppVName = Get-AppvClientPackage <Package>
Start-AppvVirtualProcess -AppvClientObject $AppVName cmd.exe
```

If you do not know the exact name of your package, you can use the command line `Get-AppvClientPackage executable`, substituting the name of the application for "executable"; for example: `Get-AppvClientPackage Word`.

This method allows you launch any command within the context of an App-V package whether the package is currently running or not. This is similar to using the `sfttray /exe cmd.exe /launch "App-V Application"` syntax in App-V 4.6.

## The command-line switch "/appvpid:\<PID>"

This allows you to apply the `/appvpid` switch to any command that will allow the command to run within the virtual process of the virtual process you selected by its PID (Process ID) as in the example below:

```console
cmd.exe /appvpid:8108
```

To obtain the process ID (PID) of your App-V process, use the command tasklist.exe from an elevated command prompt and obtain the PID of your process. This method has the advantage of launching the new executable in the same App-V environment as an already-running executable.

## The command-line hook switch "/appvve:\<GUID>"

Where the `/appvpid` switch requires the virtual process to already be running, this switch allows you to start a local command and allow it to run within the virtual environment of an App-V package and will initialize it. The syntax is `cmd.exe /appvve: <PACKAGEGUID_VERSIONGUID>`.

For example:

```console
cmd.exe /appvve: aaaaaaaa-bbbb-cccc-dddd-eeeeeeee_11111111-2222-3333-4444-55555555
```

To obtain the package GUID and version GUID, of your application, run the `Get-AppvClientPackage` cmdlet, then concatenate the package GUID and version GUIDs with an underscore between them. For example:

```powershell
PS C:\> Get-AppvClientPackage
```

Output:

> PackageId: aaaaaaaa-bbbb-cccc-dddd-eeeeeeee  
VersionId: 11111111-2222-3333-4444-55555555  
Name: MyApp 1.10

The output would yield the command line: `cmd.exe /appvve:aaaaaaaa-bbbb-cccc-dddd-eeeeeeee_11111111-2222-3333-4444-55555555`.

## The Run Virtual feature

If you are working within RDS environments, and have a package that is published globally, you can also take advantage of the "Run Virtual" feature. To do this, the add process executable names as subkeys of the following key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Client\RunVirtual`

For example, if you have a locally installed application named MyApp.exe and would like this application to run within the virtual environment, create a subkey called MyApp.exe. Edit the (Default) REG_SZ value that contains the package GUID and the version GUID separated by an underscore (for example, \<GUID>_\<GUID>).

For example, the application listed in the previous example would yield a registry export (.reg file) like the following:

```registry
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Client\RunVirtual]
@=""
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Client\RunVirtual\MyApp.exe]
@="aaaaaaaa-bbbb-cccc-dddd-eeeeeeee_11111111-2222-3333-4444-55555555"
```

Each native process that needs to run locally will require its own subkey beneath the Run Virtual key. As long as there is one version of the EXE on the system, placing the package\\version GUID combination in the default key value will suffice.

You may also specify the AppConnectionGroupID and VersionID of a globally published connection group in a similar format. Specify the main executable name in the connection group. For example, if your Connection Group XML looked like the following:

```xml
<?xml version="1.0" ?>
<appv:AppConnectionGroup xmlns="http://schemas.microsoft.com/appv/2010/virtualapplicationconnectiongroup" xmlns:appv="http://schemas.microsoft.com/appv/2010/virtualapplicationconnectiongroup" AppConnectionGroupId="CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCC" VersionId="33333333-3333-3333-3333-3333333333" Priority="0" DisplayName="MyApp Connection Group">
```

then you would add a registry key like this:

```registry
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Client\RunVirtual]
@=""
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Client\RunVirtual\MyApp.exe]
@="aaaaaaaa-bbbb-cccc-dddd-eeeeeeee_11111111-2222-3333-4444-555555555
```
