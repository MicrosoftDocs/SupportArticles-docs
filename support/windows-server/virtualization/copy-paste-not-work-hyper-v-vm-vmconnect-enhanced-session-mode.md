---
title: Copy and paste do not work when you connect to a Hyper-V virtual machine by using VMConnect Enhanced Session Mode
description: Describes an issue in which clipboard file copy redirection may not work as expected when you connect to a Hyper-V virtual machine by using VMConnect Enhanced Session Mode. Provides a resolution.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: stevepar, eltons
---
# Copy and paste do not work when you connect to a Hyper-V virtual machine by using VMConnect Enhanced Session Mode

_Original product version:_ &nbsp; Windows Server 2019, all editions, Windows Server 2016 Datacenter, Windows Server 2016 Standard, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, Windows 10, Windows 8.1  
_Original KB number:_ &nbsp; 4090037

## Symptoms

You cannot copy and paste files between a system that is running [Virtual Machine Connection (VMConnect.exe)](https://docs.microsoft.com/windows-server/virtualization/hyper-v/learn-more/hyper-v-virtual-machine-connect) and a Hyper-V guest virtual machine when you use Enhanced Session Mode through Remote Desktop Protocol (RDP). 

## Cause

Enhanced Session Mode enables the transfer of files to and from virtual machines through the Clipboard copy and paste operations. However, if the **Do not allow drive redirection policy** option is enabled, copying and pasting files through the Clipboard is disabled.

## Resolution

To be able to successfully copy files to and from Hyper-V virtual machines when you use VMConnect through Enhanced Session Mode, make sure that the following policy is not enabled: 
 **Policy path:**  
 **Computer Configuration\Policies\Administrative Templates\Windows Components\Terminal Services\Terminal Server\Device and Resource Redirection**  
 **Note**  If you use the Local Group Policy Editor, the Policies folder is not part of the node path.  

**Policy setting:**  
 **Do not allow drive redirection**  
 This setting must be set to "Disabled" or "Not Configured" to allow file copy redirection in Remote Desktop Services and Hyper-V Enhanced Session Mode sessions. 

## More Information

[Use local resources on Hyper-V virtual machine with VMConnect](https://docs.microsoft.com/windows-server/virtualization/hyper-v/learn-more/use-local-resources-on-hyper-v-virtual-machine-with-vmconnect) 
 [Policy CSP - RemoteDesktopServices](https://docs.microsoft.com/windows/client-management/mdm/policy-csp-remotedesktopservices#remotedesktopservices-donotallowdriveredirection)
