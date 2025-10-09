---
title: Troubleshoot Windows Update Error Code 0x8007000e or 0x800705aa
description: Describes how to resolve Windows Update error code 0x8007000e or 0x800705aa.
ms.date: 10/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:windows servicing, updates and features on demand\windows update - install errors unknown or code not listed
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error code 0x8007000e or 0x800705aa

This article describes how to resolve Windows Update error code 0x8007000e or 0x800705aa.

## Symptoms

You install a Windows Update, and the installation fails. You see one of the following error messages:

```output
Error - Installer encountered an error 0x8007000e. Not enough memory resources available to complete this operation.
```

```output
An error occurred - Error : 0x800705aa

Insufficient system resources exist to complete the requested service. 
```

> [!NOTE]  
> The second message typically occurs when you use `dism /online /add-package /packagepath:<path of .cab file>`to install the update.

## Cause

This issue occurs when the computer doesn't have enough available virtual memory for Windows to install the update. The most common causes of this issue are the following conditions:

- Third-party applications consume a large amount of virtual memory.
- The computer's virtual memory isn't managed automatically. Instead, it's' manually configured.

## Workaround: Clean restart

When you start Windows by using a normal startup, several applications and services start automatically, and then run in the background. These programs include basic system processes, antivirus software, system utility applications, and other software. These applications and services can interfere with the update process.  

A clean restart, also known as a clean boot, starts Windows without these background applications and services. Follow these steps:  

1. Sign in to the affected computer as administrator.
1. In the search box, type **msconfig** and then select **System Configuration**.
1. In System Configuration, select **Services** > **Hide all Microsoft services** > **Disable all**.
1. Select **Startup** > **Open Task Manager**.
1. Under **Startup** in Task Manager, for each startup item, select the item and then select **Disable**.
1. Close Task Manager.
1. In System Configuration, select **Startup** > **OK**.
1. Restart the computer.  

After the computer restarts, try to update or upgrade it again.  

## Resolution

To configure the computer to automatically manage its virtual memory, follow these steps.

1. To open **System Properties**, select Search and then enter **sysdm.cpl**.
1. In **System Properties**, select **Advanced**, and then under **Performance**, select **Settings**.
1. In **Performance Options**, select **Advanced**, and then under **Virtual memory**, select **Change**.
1. Make sure that **Automatically manage paging file size for all drives** is selected, and then select **OK**.
1. Restart the computer.

## More information

As an example of this issue, the following excerpt shows how error code 0x800705aa appears in the CBS.log file.

```output
2024-02-06 02:20:51, Info          
       DPX    Ended DPX phase: Apply Deltas
Provided In File
2024-02-06 02:20:51, Info          
       DPX    Started DPX phase: Apply Deltas
Provided In File
2024-02-06 02:23:42, Info          
       DPX    DpxException hr=0x800705aa code=0x02060e
2024-02-06 02:23:42, Info          
       DPX    DpxException hr=0x800705aa
code=0x02060e
2024-02-06 02:23:42, Info          
       DPX    DpxException hr=0x800705aa
code=0x02060e
2024-02-06 02:23:42, Info          
       DPX    Failed to create file [file://%3f/C:/windows/SoftwareDistribution/Download/90fbe639b26d2696e96c2f268353e77c/inst/_windows10.0-kb5034127-x64.cab_/$dpx$.tmp/f8d13c2b8403f04db9eddfe6c7ae2060.tmp]\\?\C:\windows\SoftwareDistribution\Download\90fbe639b26d2696e96c2f268353e77c\inst\_windows10.0-kb5034127-x64.cab_\$dpx$.tmp\f8d13c2b8403f04db9eddfe6c7ae2060.tmp
2024-02-06 02:23:42, Info          
       DPX    ProvideRequestedDataByFile: [file://%3f/C:/windows/SoftwareDistribution/Download/90fbe639b26d2696e96c2f268353e77c/inst/_windows10.0-kb5034127-x64.cab_/Cab_2_for_KB5034127_PSFX.cab]\\?\C:\windows\SoftwareDistribution\Download\90fbe639b26d2696e96c2f268353e77c\inst\_windows10.0-kb5034127-x64.cab_\Cab_2_for_KB5034127_PSFX.cab
failed, Response file Name: ExtractFromCabInFile
2024-02-06 02:23:42, Info          
       DPX    Ended DPX phase: Apply Deltas
Provided In File
2024-02-06 02:23:42, Info          
       DPX    DpxException hr=0x800705aa
code=0x020201
2024-02-06 02:23:42, Info          
       DPX    Ended DPX phase: Resume and
Download Job
2024-02-06 02:23:42, Info          
       DPX    DpxException hr=0x800705aa
code=0x020217
```
