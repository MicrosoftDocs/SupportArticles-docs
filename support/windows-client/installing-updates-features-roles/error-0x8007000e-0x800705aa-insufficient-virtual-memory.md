---
title: Troubleshoot Windows Update Error Code 0x8007000e or 0x800705aa
description: Discusses how to resolve Windows Update error code 0x8007000e or 0x800705aa.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:windows servicing, updates and features on demand\windows update - install errors starting with 0x8007 (error)
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
- ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
---

# Troubleshoot Windows Update error code 0x8007000e or 0x800705aa

This article discusses how to resolve Windows Update error code 0x8007000e or 0x800705aa.

## Symptoms

When you try to install a Windows update, the installation fails. When this error occurs, you receive one of the following error messages:

```output
Error - Installer encountered an error 0x8007000e. Not enough memory resources available to complete this operation.
```

```output
An error occurred - Error : 0x800705aa

Insufficient system resources exist to complete the requested service. 
```

> [!NOTE]  
> The second message typically occurs if you use `dism /online /add-package /packagepath:<path of .cab file>`to install the update.

When you review events in Event Viewer, you might also find Event ID 2004 recorded. The description of this event resembles the following example:

> Windows successfully diagnosed a low virtual memory condition. The following programs consumed the most virtual memory: java.exe (1152) consumed 33821605888 bytes, java.exe (6316) consumed 5259997184 bytes, and java.exe (12536) consumed 1569894400 bytes.

### Special case of error code 0x800705aa - Registry size limit

Error code 0x800705aa might indicate a registry issue instead of a general virtual memory issue. To determine the source of the issue, check the CBS.log file for entries that resemble the following example:

```output
2024-05-13 22:31:56, Info                  CBS    Failed to load the COMPONENTS hive from 'C:\Windows\System32\config\COMPONENTS' into registry key 'HKLM\COMPONENTS'. [HRESULT = 0x800705aa - ERROR_NO_SYSTEM_RESOURCES]
2024-05-13 22:31:56, Info                  CBS    Failed to load component store [HRESULT = 0x800705aa - ERROR_NO_SYSTEM_RESOURCES]
2024-05-13 22:31:56, Info                  CBS    Failed to get CSI store. [HRESULT = 0x800705aa - ERROR_NO_SYSTEM_RESOURCES]
2024-05-13 22:31:56, Info                  CBS    Failed to get CSI Inventory [HRESULT = 0x800705aa - ERROR_NO_SYSTEM_RESOURCES]
2024-05-13 22:31:56, Info                  CBS    Failed to get component state. [HRESULT = 0x800705aa - ERROR_NO_SYSTEM_RESOURCES]
2024-05-13 22:31:56, Info                  CBS    Failed to get current state of the deployment [HRESULT = 0x800705aa - ERROR_NO_SYSTEM_RESOURCES]
2024-05-13 22:31:56, Info                  CBS    Failed to get Transaction State for package: Microsoft-Windows-NetFx4-OC-Package~31bf3856ad364e35~amd64~~10.0.17763.1, update: NetFx4 [HRESULT = 0x800705aa - ERROR_NO_SYSTEM_RESOURCES]
```

For a contrasting example of CBS log entries that indicate a nonregistry cause, see [More information](#more-information).

For more information about how to use the CBS log, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

## Cause

In most cases, this issue occurs if the computer or virtual machine (VM) doesn't have enough available virtual memory for Windows to install the update. The most common causes of this issue are the following conditions:

- Third-party applications are consuming lots of virtual memory.
- The computer's virtual memory isn't managed automatically. Instead, it's manually configured.

If the CBS log indicates that the issue involved registry resources, the `RegistrySizeLimit` registry entry is set to a value other than **0**. This value restricts the registry's maximum size. When the registry size grows to meet the configured limit, Windows can't perform necessary servicing activities, such as updates.

## Workaround: Clean restart

When you start Windows by using a normal startup, several applications and services start automatically, and then they run in the background. These programs include basic system processes, antivirus software, and system utility applications. These applications and services can interfere with the update process.  

A clean restart, also known as a _clean boot_, starts Windows without these background applications and services. Follow these steps:  

1. Sign in to the affected computer as an administrator.
1. In the Search box, enter **msconfig**, and then select **System Configuration**.
1. In System Configuration, select **Services** > **Hide all Microsoft services** > **Disable all**.
1. Select **Startup** > **Open Task Manager**.
1. Under **Startup** in Task Manager, select each startup item, and then select **Disable**.
1. Close Task Manager.
1. In System Configuration, select **Startup** > **OK**.
1. Restart the computer.  

After the computer restarts, try again to update it.  

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

### General resource issues

> [!NOTE]  
> If the affected computer is a VM, consider upgrading the virtual hardware of the VM to increase its available memory resources.

To configure the computer to automatically manage its virtual memory, follow these steps:

1. Open **System Properties**: Select **Search**, and enter **sysdm.cpl**.
1. In **System Properties**, select **Advanced** > **Performance** > **Settings**.
1. In **Performance Options**, select **Advanced** > **Virtual memory** > **Change**.
1. Make sure that **Automatically manage paging file size for all drives** is selected, and then select **OK**.
1. Restart the computer.
1. To make sure that this issue doesn't occur again, monitor the computer's available memory resources.

### Registry size limit issue

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

To reset the registry size limit, follow these steps:

1. In the search bar of the affected computer or VM, type **regedit**, and then right-click **Registry Editor** in the search results.
1. Select **Run as administrator**.
1. Select `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`.
1. Right-click `RegistrySizeLimit`, and then do one of the following actions:

   - Select **Delete**.
   - Select **Modify**, enter **0** in the **Value data** field, and then select **OK**.

1. Restart the physical computer or VM.
1. On the affected computer or VM, try again to update Windows.

If the issue persists, contact Microsoft Support for more assistance. Attach copies of any relevant CBS.log data to your support request.

## More information

The following example shows how error code 0x800705aa might appear in the CBS.log file if the issue doesn't involve the registry size limit:

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
