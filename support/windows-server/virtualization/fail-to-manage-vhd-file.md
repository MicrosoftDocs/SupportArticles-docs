---
title: Error when you manage a VHD file
description: Provides a solution to an error that occurs when you create a virtual machine in Hyper-V Manager.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtual-machine-creation, csstroubleshoot
---
# Error when you manage a VHD file in Windows Server: "A Virtual Disk Provider for the specified file was not found"

This article provides a solution to an error that occurs when you create a virtual machine in Hyper-V Manager.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2013544

## Symptoms

You receive the following error message when you try to create a virtual machine in Hyper-V Manager in Windows Server:

> Log Name: Microsoft-Windows-Hyper-V-VMMS-Admin  
Source: Microsoft-Windows-Hyper-V-VMMS  
Event ID: 14098  
Level: Error  
Description:  
'Storage Virtualization Service Provider' driver required by the Virtual Machine Management service is not installed or is disabled. Check your settings or try reinstalling the Hyper-V role.  
>
> Log Name: Microsoft-Windows-Hyper-V-Image-Management-Service-Admin  
Source: Microsoft-Windows-Hyper-V-Image-Management-Service  
Event ID: 15062  
Level: Error  
Description:  
'The system failed to create 'E:\VMachine\Virtual Machines\TEST\TEST.vhd'. **Error Code: 2424869**  

When you try to interact with a virtual hard disk (VHD) file by using a tool such as Hyper-V Manager, Storage Manager, or Diskpart, you receive the following error message:  
> **Title**: Virtual Disk Manager  
 **Description**: A Virtual Disk Provider for the specified file was not found.  

You may also see the following event logged in the VHDMP log:  
> **Event ID 3** : Failed to surface VHD \<Drive Letter\Path\virtual hard drives\VMNAME_########-####-####-####-############.vhd>. Error Status: 0xC0000061  

When you try to start a virtual machine by using Hyper-V Manager, you receive the following error message:  
> [!Note]
> Machine names, paths, and GUIDs will be different as they are unique to each environment.  

> **Title**: Hyper-V Manager  
 **Description: An error occurred while attempting to start the selected virtual machine(s)**'\<VM Name>' failed to start.  
>
> Microsoft Emulated IDE Controller (Instance ID {########-####-####-####-############}): Failed to Power on with Error: 'A device attached to the system is not functioning.'  
>
> Failed to open attachment 'Drive Letter:\path\Virtual Hard drivers\VMNAME_########-####-####-####-############.vhd'. Error: 'A device attached to the system is not functioning'  
>
> Failed to open attachment 'Drive Letter:\path\Virtual Hard drivers\VMNAME_########-####-####-####-############.vhd'. Error: 'A device attached to the system is not functioning'  
>
> 'VM NAME' failed to start (Virtual Machine ID ########-####-####-####-############)  
>
> 'VM NAME' Microsoft Emulated IDE Controller (Instance ID {########-####-####-####-############}): Failed to Power on with Error: 'A device attached to the system is not functioning.' (0x8007001F) (Virtual Machine ID: ########-####-####-####-############)  
>
> 'VM NAME': Failed to open attachment 'Drive Letter:\path\Virtual Hard drivers\VMNAME_########-####-####-####-############.vhd'. Error: 'A device attached to the system is not functioning' (0x8007001F) (Virtual Machine ID: ########-####-####-####-############)  
>
> 'VM NAME': Failed to open attachment 'Drive Letter:\path\Virtual Hard drivers\VMNAME_########-####-####-####-############.vhd'. Error: 'A device attached to the system is not functioning' (0x8007001F) (Virtual Machine ID: ########-####-####-####-############)  

## Cause

There is a timing issue with FSDepends.sys and with VHDMP.sys. This timing issue occurs when certain backup programs are installed on Windows Server computers. By default, the FSDepends.sys start value in the registry is set to **Manual**. When any third-party backup software loads its tape device driver, the software can sometimes result in FSDepends.sys and VHDMP.sys not initializing correctly.  

## Resolution  

To work around these problems, FSDepends.sys should be set to a start value of Boot (0x0).  

Make sure that you back up the registry before you change it. Also make sure that you know how to restore the registry if a problem occurs.  

For more information about how to back up, restore, and change the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/kb/322756/) How to back up and restore the registry in Windows

To work around these problems, follow these steps:  

1. Start Registry Editor.
2. Locate the following registry key:  
 `HKLM\SYSTEM\CurrentControlSet\Services\FsDepends`  

3. Under the "FsDepends" key, change REG_DWORD value "Start" from **3** to **0**.
4. Restart the computer.  

## More information

As soon as the computer is restarted, FSDepends.sys starts immediately and the timing issue no longer occurs.  
Or, you can try one of the following two workarounds. **Neither of these methods is recommended.** However, they work to correct the problems if editing the registry is not possible or desirable:  

- Turn off any attached tape device and restart the server. As soon as the server is started, turn on the tape device.  
- Disable the device driver that's named TPFilter.sys.  
