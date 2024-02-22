---
title: Description of Remote Server Administration Tools
description: Describes the tools that are available for installation as part of Remote Server Administration Tools
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, nedpyle, qianyu
ms.custom: sap:administration, csstroubleshoot
---
# Description of Remote Server Administration Tools

This article describes the tools that are available for installation as part of Remote Server Administration Tools.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 958830

## Introduction

This article describes the tools that are available for installation as part of Remote Server Administration Tools for Windows 7. Tools in this package can be used to manage technologies that run on Windows Server 2008 R2. They can also be used to manage some technologies that run on Windows Server 2003, Windows Server 2003 R2, or Windows Server 2008.

## More information

|Remote Server Administration Tools technology|Description|Manages technology on Windows Server 2003|Manages technology on Windows Server 2008|
|---|---|---|---|
|Active Directory Certificate Services Tools|Active Directory Certificate Services Tools include:<ul><li>Certification Authority</li><li>Certificate Templates</li><li>Enterprise PKI</li><li>Online Responder Management snap-ins</li></ul>| √, except Online Certificate Status Protocol (OCSP)| √ |
|Active Directory Domain Services (AD DS) Tools and Active Directory Lightweight Directory Services (AD LDS) Tools|AD DS Tools include:<ul><li>Active Directory Users and Computers</li><li>Active Directory Domains and Trusts</li><li>Active Directory Sites and Services</li><li>Active Directory Administrative Center (ADAC)</li><li>Server for Network Information Service (NIS) tools</li><li>Windows PowerShell module for Active Directory</li><li>Other snap-ins and command-line tools for remotely managing AD DS</li></ul><br/>AD LDS Tools include:<ul><li>Active Directory Sites and Services</li><li>ADSI Edit</li><li>Schema Manager</li><li>Other snap-ins and command-line tools for managing AD LDS</li></ul><br/>Server for NIS Tools includes:<ul><li>An extension to the Active Directory Users and Computers snap-in</li><li>The Ypclear.exe command-line tool</li></ul>| √, Windows PowerShell and ADAC remote management require the Active Directory Web Service download package.| √, PowerShell and ADAC remote management require the Active Directory Web Service download package.|
|BitLocker Active Directory Recovery Password Viewer|The BitLocker Active Directory Recovery Password Viewer tool is an extension for the Active Directory Users and Computers Microsoft Management Console (MMC) snap-in. Using this tool, you can open a computer object's **Properties** dialog box to view the corresponding BitLocker recovery passwords.|Not available|Not available|
|DHCP Server Tools|DHCP Server Tools include the DHCP Management Console, and the Netsh command-line tool.| √| √ |
|DNS Server Tools|DNS Server Tools include the DNS Manager snap-in, and the Ddnscmd.exe command-line tool.| √| √ |
|Failover Clustering Tools|Failover Clustering Tools include:<ul><li>Failover Cluster Manager</li><li>Windows PowerShell tools for managing Failover Clustering</li><li>The Cluster.exe command-line tool</li></ul>|Not available| √ |
|File Services Tools|File Services Tools include:<ul><li> Distributed File System Tools, including the DFS Management snap-in, and the Dfsradmin.exe, Dfsrdiag.exe, Dfscmd.exe, Dfsdiag.exe, and Dfsutil.exe command-line tools.</li><li>File Server Resource Manager tools, including the File Server Resource Manager snap-in, and the Dirquota.exe, Filescrn.exe, and Storrept.exe command-line tools.</li><li>Share and Storage Management Tools, including the Share and Storage Management snap-in.</li></ul>|Not available<br/>| √ |
|Group Policy Management Tools|Group Policy Management Tools include:<ul><li>Group Policy Management Console</li><li>Group Policy Management Editor</li><li>Group Policy Starter GPO Editor</li></ul>| √| √ |
|Hyper-V Tools|Hyper-V Tools include the Hyper-V Manager snap-in, and the Virtual Machine Connection remote access tool.|Not available| √ |
|Network Load-Balancing Tools|Network Load-Balancing Tools include:<ul><li>The Network Load-Balancing Manager snap-in</li><li>Windows PowerShell tools for managing Network Load Balancing</li><li>The Nlb.exe and Wlbs.exe command-line tools</li></ul>| √| √ |
|Remote Desktop Services Tools|Remote Desktop Services Tools include the Remote Desktop Services Manager, and Remote Desktop snap-ins.| √| √ |
|Server Manager|Server Manager includes the Server Manager console.<br/><br/>Remote management with Server Manager is available only in Windows Server 2008 R2.<br/>|Not available|Not available|
|SMTP Server Tools|Simple Mail Transfer Protocol (SMTP) Server Tools include the SMTP snap-in.| √| √ |
|Storage Explorer Tools|Storage Explorer Tools include the Storage Explorer snap-in.|Not available| √ |
|Storage Manager for Storage Area Networks (SANs) Tools|Storage Manager for SANs Tools includes:<ul><li>The Storage Manager for SANs snap-in</li><li>The Provisionstorage.exe command-line tool</li></ul>| √ <br/><br/>Storage Manager for SANs is available in Windows Server 2003 R2 and later versions.| √ |
|Windows System Resource Manager Tools|Windows System Resource Manager Tools include:<ul><li>The Windows System Resource Manager snap-in</li><li>The Wsrmc.exe command-line tool</li></ul>|Not available| √ |
