---
title: Remote Server Administration Tools
description: This article describes the tools that are available in Remote Server Administration Tools for Windows.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Server Manager
ms.technology: SysManagementComponents
---
# Remote Server Administration Tools (RSAT) for Windows

This article describes the tools that are available in Remote Server Administration Tools (RSAT) for Windows.

_Original product version:_ &nbsp; Windows 10, version 1909, Windows 10, version 1903, Windows 10, version 1809. Windows 7 Service Pack 1. Windows Server 2019. Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2693643

## Introduction

RSAT enables IT administrators to remotely manage roles and features in Windows Server from a computer that is running Windows 10 and Windows 7 Service Pack 1.

You cannot install RSAT on computers that are running Home or Standard editions of Windows. You can install RSAT only on Professional or Enterprise editions of the Windows client operating system. Unless the download page specifically states that RSAT applies to a beta, preview, or other prerelease version of Windows, you must be running a full (RTM) release of the Windows operating system to install and use RSAT. Although some users have found ways of manually cracking or hacking the RSAT MSU to install RSAT on unsupported releases or editions of Windows, this is a violation of the Windows end-user license agreement.

Installing RSAT is similar to installing Adminpak.msi in Windows 2000-based or Windows XP-based client computers. However, there's one major difference: in Windows 7, the tools aren't automatically available after you download and install RSAT. You must enable the tools that you want to use by using Control Panel. To do this, click **Start**, click **Control Panel**, click **Programs and Features**, and then click **Turn Windows features on or off**.

In the RSAT releases for Windows 10, tools are again all enabled by default. You can open **Turn Windows features on or off** to disable tools that you don't want to use for Windows 7.

:::image type="content" source="./media/remote-server-administration-tools/turn-windows-features-on-or-off.jpg" alt-text="Turn Windows features on or off option in Windows 7.":::

For RSAT in Windows 7, you must enable the tools for the roles and features that you want to manage after you run the downloaded installation package.

> [!NOTE]
> You cannot do the following changes for RSAT in Windows 8 or later versions.

:::image type="content" source="./media/remote-server-administration-tools/enable-rsat-tools-for-roles-and-features.jpg" alt-text="Enable RSAT in Windows 7.":::

If you have to install management tools in Windows Server 2012 R2 for specific roles or features that are running on remote servers, you don't have to install additional software. Start the Add Roles and Features Wizard in Windows Server 2012 R2 and later versions. Then, on the **Select Features** page, expand **Remote Server Administration Tools**, and then select the tools that you want to install. Complete the wizard to install your management tools.

![Complete the wizard to install your management tools.](./media/remote-server-administration-tools/select-features.jpg)

## Download locations for RSAT

- [Remote Server Administration Tools for Windows 10](https://www.microsoft.com/download/details.aspx?id=45520)

- [Remote Server Administration Tools (RSAT) for Windows 7 with SP1 (both x86 and x64)](https://www.microsoft.com/download/details.aspx?id=7887)

## RSAT for Windows 10 platform and tools support matrix

|Remote Server Administration Tools Technology|Description|Manages technology in Windows Server 2012 R2|Manages technology in Windows Server 2016 Technical Preview and Windows Server 2012 R2|
|---|---|---|---|
|**Active Directory Certificate Services (AD CS) tools**|AD CS tools include the Certification Authority, Certificate Templates, Enterprise PKI, and Online Responder Management snap-ins.| **√**| **√** |
|**Active Directory Domain Services (AD DS) tools and Active Directory Lightweight Directory Services (AD LDS) tools**|AD DS and Active Directory Lightweight Directory Services (AD LDS) tools include Active Directory Administrative Center, Active Directory Domains and Trusts, Active Directory Sites and Services, Active Directory Users and Computers, ADSI Edit, Active Directory module for Windows PowerShell; plus tools such as DCPromo.exe, LDP.exe, NetDom.exe, NTDSUtil.exe, RepAdmin.exe, DCDiag.exe, DSACLs.exe, DSAdd.exe, DSDBUtil.exe, DSMgmt.exe, DSMod.exe, DSMove.exe, DSQuery.exe, DSRm.exe, GPFixup.exe, KSetup.exe, NlTest.exe, NSLookup.exe, W32tm.exe.| | **√** |
|**Best Practices Analyzer**|Best Practices Analyzer cmdlets for Windows PowerShell| **√**| **√** |
|**BitLocker Drive Encryption Administration Utilities**|Manage-bde, Windows PowerShell cmdlets for BitLocker, BitLocker Recovery Password Viewer for Active Directory| **√**| **√** |
|**DHCP Server tools**|DHCP Server tools include the DHCP Management Console, the DHCP Server cmdlet module for Windows PowerShell, and the **Netsh** command-line tool.| **√**| **√** |
|**DirectAccess, Routing and Remote Access**|Routing and Remote Access management console, Connection Manager Administration Kit console, Remote Access provider for Windows PowerShell, Web Application Proxy| **√** | **√**  |
|**DNS Server tools**|DNS Server tools include the DNS Manager snap-in, the DNS module for Windows PowerShell, and the **Ddnscmd.exe** command-line tool.| **√**| **√**  |
|**Failover Clustering tools**|Failover Clustering tools include Failover Cluster Manager, Failover Clusters (Windows PowerShell cmdlets), MSClus, Cluster.exe, Cluster-Aware Updating management console, Cluster-Aware Updating cmdlets for Windows PowerShell| **√**| **√** <br/><br/>GUI tools support Windows Server 2016 Technical Preview and Windows Server 2012 R2. Only PowerShell tools work in Windows Server 2012.|
|**File Services tools**|File Services tools include the following: Share and Storage Management tools, Distributed File System tools, File Server Resource Manager tools, Services for NFS Administration tools, iSCSI management cmdlets for Windows PowerShell; Work Folders Management Tools - Distributed File System Tools include the DFS Management snap-in, and the **Dfsradmin.exe**, **Dfsrdiag.exe**, **Dfscmd.exe**, **Dfsdiag.exe**, and **Dfsutil.exe** command-line tools and PowerShell modules for DFSN and DFSR - File Server Resource Manager Tools include the File Server Resource Manager snap-in, and the **Dirquota.exe**, **Filescrn.exe**, and **Storrept.exe** command-line tools.| **√**| **√** <br/><br/>The Share and Storage Management snap-in is deprecated after the release of Windows Server 2016.Storage Replica is new in Windows Server 2016 Technical Preview, and won't work in Windows Server 2012 R2.|
|**Group Policy Management tools**|Group Policy Management tools include Group Policy Management Console, Group Policy Management Editor, and Group Policy Starter GPO Editor.| **√**| **√** <br/><br/>Group Policy has some new features in Windows Server 2016 Technical Preview that are not available on older operating systems.|
|**Hyper-V tools**|Hyper-V tools include the Hyper-V Manager snap-in and the Virtual Machine Connection remote access tool.|Hyper-V tools are not part of Remote Server Administration Tools for Windows 10. These tools are available as part of Windows 10. You do not have to install RSAT to use the tools. The Hyper-V Manager console for Windows Server 2016 Technical Preview doesn't support managing Hyper-V servers running Server 2008 or Server 2008 R2.|Hyper-V in Windows 10 can manage Hyper-V in Windows Server 2012 R2.|
|**IP Address Management (IPAM) Management tools**|IP Address Management client console|**√**<br/><br/> IPAM tools in Remote Server Administration Tools for Windows 10 cannot be used to manage IPAM running in Windows Server 2012 R2.|**√**<br/><br/> IPAM tools in Remote Server Administration Tools for Windows 10 cannot be used to manage IPAM running in Windows Server 2012 R2.|
|**Network Adapter Teaming, or NIC Teaming**|NIC Teaming management console| **√**| **√** |
|**Network Controller**|Network Controller PowerShell module|Not available| **√** |
|**Network Load Balancing tools**|Network Load Balancing tools include the Network Load Balancing Manager, Network Load Balancing Windows PowerShell cmdlets, and the **NLB.exe** and **WLBS.exe** command-line tools.| **√**| **√**  |
|**Remote Desktop Services tools**|Remote Desktop Services tools include the Remote Desktop snap-ins, RD Gateway Manager, tsgateway.msc, RD Licensing Manager, licmgr.exe, RD Licensing Diagnoser, lsdiag.msc. Use Server Manager to administer all other RDS role services except RD Gateway and RD Licensing.| **√**| **√** |
|**Server for NIS tools**|Server for NIS tools include an extension to the Active Directory Users and Computers snap-in, and the **Ypclear.exe** command-line tool|These tools are not available in RSAT for Windows 10 and later releases.| |
|**Server Manager**|Server Manager includes the Server Manager console.<br/><br/>Remote management with Server Manager is available in Windows Server 2016 Technical Preview, Windows Server 2012 R2, and Windows Server 2012.| **√**| **√**  |
|**SMTP Server tools**|SMTP Server tools include the Simple Mail Transfer Protocol (SMTP) snap-in.|These tools are not available in RSAT for Windows 8 and later releases.| |
|**Storage Explorer tools**|Storage Explorer tools include the Storage Explorer snap-in.|These tools are not available in RSAT for Windows 8 and later releases.| |
|**Storage Manager for Storage Area Networks (SANs) tools**|Storage Manager for SANs tools include the Storage Manager for SANs snap-in and the **Provisionstorage.exe** command-line tool.|These tools are not available in RSAT for Windows 8 and later releases.| |
|**Volume Activation**|Manage Volume Activation, vmw.exe| **√**| **√**|
|**Windows System Resource Manager tools**|Windows System Resource Manager tools include the Windows System Resource Manager snap-in and the **Wsrmc.exe** command-line tool.| **√**<br/><br/> WSRM has been deprecated in Windows Server 2012 R2, and tools for managing WSRM are not available in Remote Server Administration Tools for Windows 8.1 and later releases of RSAT.| |
| **Windows Server Update Services tools**| Windows Server Update Services tools include the Windows Server Update Services snap-in, WSUS.msc, and PowerShell cmdlets.| **√**| **√** |
|||||

## References

- [Deploy Remote Server Administration Tools](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831501(v=ws.11))

- [Remotely managing your Server Core using RSAT](https://dirteam.com/sander/2008/04/27/remotely-managing-your-server-core-using-rsat/)

- [Screencast: How to Install and Enable Microsoft RSAT (Remote Server Administration Tools) for Windows Vista](http://www.netometer.com/video/tutorials/vista-remote-server-administration-tools/)

- [Using MMC Snap-ins and RSAT](/previous-versions/tn-archive/dd163507(v=technet.10))
