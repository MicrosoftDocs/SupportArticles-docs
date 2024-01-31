---
title: Enable Windows Installer logging
description: This article describes how to enable Windows Installer logging.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:msi, csstroubleshoot
ms.subservice: application-compatibility
---
# Enable Windows Installer logging

Windows includes a registry-activated logging service to help diagnose Windows Installer issues. This article describes how to enable this logging service.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 223300

> [!NOTE]
> The registry entry in this article is valid for all Windows operating systems.

## Windows Installer logging

Windows Installer can use logging to help assist in troubleshooting issues with installing software packages. This logging is enabled by adding keys and values to the registry. After the entries have been added and enabled, you can retry the problem installation and Windows Installer will track the progress and post it to the Temp folder. The new log's file name is random. However, the first letters are *Msi* and the file name has a .log extension. To locate the Temp folder, type the following line at a command prompt:  

```console
cd %temp%
```

To enable Windows Installer logging manually, see the following section.

## Enable Windows Installer logging manually

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To enable Windows Installer logging yourself, open the registry by using Regedit.exe, and then create the following subkey and keys:

- Path:`HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer`
- Type: Reg_SZ
- Value: Logging
- Data: voicewarmupx

The letters in the value field can be in any order. Each letter turns on a different logging mode. Each letter's actual function is as follows for MSI version 1.1:

- v - Verbose output
- o - Out-of-disk-space messages
- i - Status messages
- c - Initial UI parameters
- e - All error messages
- w - Non-fatal warnings
- a - Start up of actions
- r - Action-specific records
- m - Out-of-memory or fatal exit information
- u - User requests
- p - Terminal properties
- \+ - Append to existing file
- ! - Flush each line to the log
- x - Extra debugging information. The x flag is available only in Windows Server 2003 and later operating systems, and on the MSI redistributable version 3.0, and on later versions of the MSI redistributable.
- \* - Wildcard. Log all information except the v and the x option. To include the v and the x option, specify /l*vx.

> [!NOTE]
> This change should be used only for troubleshooting and should not be left on because it will have adverse effects on system performance and disk space. Each time that you use the **Add or Remove Programs** item in **Control Panel**, a new Msi*.log file is created. To disable the logging, remove the **Logging** registry value.

## Enable Windows Installer logging with Group Policies

You can enable logging with Group Policies by editing the appropriate OU or Directory Group Policy. Under **Group Policy**, expand **Computer Configuration**, expand **Administrative Templates**, expand **Windows Components**, and then select **Windows Installer**.

Double-click **Logging**, and then click **Enabled**. In the **Logging** box, enter the options you want to log. The log file, Msi.log, appears in the Temp folder of the system volume.

For more information about MSI logging, see Windows Help. To do this, search by using the phrase *msi logging*, and then select **Managing options for computers through Group Policy**.

> [!NOTE]
> The addition of the x flag is available natively in Windows Server 2003 and later operating systems, on the MSI redistributable version 3.0, and on later versions of the MSI redistributable.
