---
title: Rebuild performance counter library values
description: This article describes how to manually rebuild performance counter library values.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# Manually rebuild performance counter library values

This article describes how to manually rebuild the performance counter library values.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 300956

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

When you use the System Monitor tool, some counters may be missing or don't contain counter data. The base set of performance counter libraries may become corrupted and may need to be rebuilt. Additionally, you may need to rebuild any custom (Microsoft .NET Framework application created) counters or any extensible counters.

This behavior may occur in the following situations:

- certain extensible counters corrupt the registry.
- some Windows Management Instrumentation (WMI)-based programs modify the registry.

## Rebuild the base performance counters

Extensible counter information is stored in both of the following locations:

- The registry subkey: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Perflib\009`.

- The `%Systemroot%\System32\Perfc009.dat` file and the `%Systemroot%\System32\Perfh009.dat` file.

To rebuild the base performance counter libraries manually, follow these steps:

1. Expand the *Perfc009.dat* file and the *Perfh009.dat* file. These files are located on the Windows Installation Disc. The compressed files are found at `DriveLetter:\i386\perfc009.da_` and at `DriveLetter:\i386\perfh009.da_`. Replace the files that are in the `%Systemroot%\System32` folder.

2. Start Registry Editor, and then locate the following key in the registry:  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Perflib`

3. In the registry, change the **Last Counter** value to **1846** (decimal), and change the **Last Help** value to **1847** (decimal).

4. Locate the following registry key to search for services that have a **Performance** subkey:  
    `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services`

5. Remove the following values from the **Performance** subkey (if they exist):

    - **First Counter**  
    - **First Help**  
    - **Last Counter**  
    - **Last Help**

    You can also use the Exctrlst.exe tool to locate the performance counter dynamic-link library files (DLLs) that are installed. Then access the registry to remove the DWORD values. You now have a workable performance registry that contains only system base counters.

    > [!NOTE]
    > Removing the values from the **Performance** subkey in the registry may cause any installed .NET Framework applications not to work the next time that they are started. If this occurs, use the `lodctr /R` command in the [Re-add the extensible counters](#re-add-the-extensible-counters) section to rebuild the Performance counters. If you continue to have problems when you start a .NET Framework application, see the [Reinstall custom .NET Framework assembly performance counters](#reinstall-custom-net-framework-assembly-performance-counters) section in this article.

## Re-add the extensible counters

You must add the extensible counters again from the list of services. Before you do so, you must identify the .ini file that is used to load the counters:

1. Open a Command Prompt window.
2. At the command prompt, type `cd %Systemroot%\System32`, and then press ENTER.
3. At the command prompt, type `findstr drivername *.ini`, and then press ENTER.
4. Note the name of the .ini file for each driver name in the list.
5. At the command prompt, type the `lodctr <inifile>` command, and then press ENTER.

    > [!NOTE]
    > In this command, \<inifile> represents the name of the .ini file for the driver that you want to reload.

    For example, if you want to reload the ASP driver, the list that you noted in step 4 shows that Axperf.ini is the .ini file for the ASP driver (`axperf.ini:drivername=ASP`). To reload the ASP driver, type `lodctr axperf.ini` at the command prompt, and then press ENTER.

6. Repeat step 5 for each .ini file in the list.

7. Restart your computer.

To rebuild all Performance counters including extensible and third-party counters in Windows Server type the following commands at a command prompt. Press ENTER after each command.

```console
cd \windows\system32
lodctr /R
```

> [!NOTE]
>
> - `/R` is uppercase. You must have administrative rights on the computer to successfully perform this command.
> - On a computer that is running a 32-bit edition of Windows, the `Lodctr /R:<filename>` command is the standard method to restore performance counter registry strings and information by using a file name.

Windows Server rebuilds all the counters because it reads all the .ini files in the `C:\Windows\inf\009` folder for the English operating system.

> [!NOTE]
>
> - If you are running a Cluster or Datacenter product, you must fail over the node to refresh the counter list. You must do this after you perform the steps under [Re-add the extensible counters](#re-add-the-extensible-counters) for both base counters and extensible counters.
> - On systems that are running applications that add their own performance counters, such as Exchange or SQL Server, the .ini file that is used to load the performance counter may not be located in `%Systemroot%\System32`. These .ini files can usually be found under the applications folder structure.
> - If you receive an error message about the performance library when you use the previous steps, you may have to unload and reload the IIS performance dynamic link libraries (DLLs).
> - If you continue to experience problems when you start a .NET Framework application, see the [Reinstall custom .NET Framework assembly performance counters](#reinstall-custom-net-framework-assembly-performance-counters) section.

## Reinstall custom .NET Framework assembly performance counters

If you continue to have problems when you start a .NET Framework application after you perform the procedures that are listed here, you may have to rebuild the Performance counters for the custom .NET Framework application. To do so, use the `/i` option in the .NET Framework Installer Tool (Installutil.exe). You must know the file names of the DLL files that create the performance counters.

If you follow these procedures and remove the counters from the registry for all services installed on a system that has Microsoft System Center Operations Manager 2007 installed, you might have a broken Management Server. The counters for the Config Service, SDK Service, and Database Write modules aren't provided in the form of extensible counters in INI files. Instead, they are registered at the time of installation. So, when you try to start System Center Operations Manager 2007, you may receive an error message similar to the following example because the performance counters are missing:

```output
Event Type: Error  
Event Source: OpsMgr SDK Service  
Event Category: None  
Event ID: 26380  
Date: date  
Time: time  
User: N/A  
Computer: MOM  
Description: The System Center Operations Manager SDK Service failed due to an unhandled exception.
```

To resolve this problem in System Center Operations Manager 2007, you must reinstall the .NET Framework assemblies that created the performance counters. To do so, use the `/i` option in the .NET Framework Installer Tool (Installutil.exe) to reinstall the following assemblies:

- Microsoft.Mom.ConfigService.dll
- Microsoft.Mom.Sdk.ServiceDataLayer.dll
- Microsoft.Mom.DatabaseWriteModules.dll
- Microsoft.EnterpriseManagement.HealthService.Modules.DataWarehouse.dll

For example, at the command prompt, type the following commands, and then press ENTER after each command:

```console
InstallUtil /i Microsoft.Mom.ConfigService.dll
InstallUtil /i Microsoft.Mom.Sdk.ServiceDataLayer.dll
InstallUtil /i Microsoft.Mom.DatabaseWriteModules.dll
InstallUtil /i Microsoft.EnterpriseManagement.HealthService.Modules.DataWarehouse.dll
```

> [!NOTE]
> You must have administrative rights on the computer to successfully perform these commands.
