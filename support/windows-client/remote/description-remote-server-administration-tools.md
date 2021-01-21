---
title: Description of Remote Server Administration Tools 
description: Describes the tools that are available for installation as part of Remote Server Administration Tools 
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, nedpyle, qianyu
ms.prod-support-area-path: Administration
ms.technology: windows-client-rds
---
# Description of Remote Server Administration Tools

This article describes the tools that are available for installation as part of Remote Server Administration Tools.

_Original product version:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 958830

## Introduction

This article describes the tools that are available for installation as part of Remote Server Administration Tools for Windows 7. Tools in this package can be used to manage technologies that run on Windows Server 2008 R2 and also some technologies that run on Windows Server 2003, Windows Server 2003 R2, or Windows Server 2008.

## More information

|Remote Server Administration Tools technology|Description|Manages technology on Windows Server 2003|Manages technology on Windows Server 2008|
|---|---|---|---|
|Active Directory Certificate Services Tools|Active Directory Certificate Services Tools includes the Certification Authority, Certificate Templates, Enterprise PKI, and Online Responder Management snap-ins.| √, except Online Certificate Status Protocol (OCSP)| √ |
|Active Directory Domain Services (AD DS) Tools and Active Directory Lightweight Directory Services (AD LDS) Tools|Active Directory Domain Services includes Active Directory Users and Computers, Active Directory Domains and Trusts, Active Directory Sites and Services, Active Directory Administrative Center (ADAC), Server for Network Information Service (NIS) tools, the Windows PowerShell module for Active Directory, and other snap-ins and command-line tools for remotely managing Active Directory Domain Services.<br/><br/>- Active Directory Lightweight Directory Services Tools includes Active Directory Sites and Services, ADSI Edit, Schema Manager, and other snap-ins and command-line tools for managing Active Directory Lightweight Directory Services.<br/><br/>- Server for NIS Tools includes an extension to the Active Directory Users and Computers snap-in, and the Ypclear.exe command-line tool.| √, Windows PowerShell and ADAC remote management require the Active Directory Web Service download package.| √, PowerShell and ADAC remote management require the Active Directory Web Service download package.|
|BitLocker Active Directory Recovery Password Viewer|The BitLocker Active Directory Recovery Password Viewer tool is an extension for the Active Directory Users and Computers Microsoft Management Console (MMC) snap-in. Using this tool, you can open a computer object's **Properties** dialog box to view the corresponding BitLocker recovery passwords.|Not available|Not available|
|DHCP Server Tools|DHCP Server Tools include the DHCP Management Console and the Netsh command-line tool.| √| √ |
|DNS Server Tools|DNS Server Tools include the DNS Manager snap-in and the Ddnscmd.exe command-line tool.| √| √ |
|Failover Clustering Tools|Failover Clustering Tools include Failover Cluster Manager, Windows PowerShell tools for managing Failover Clustering, and the Cluster.exe command-line tool.|Not available| √ |
|File Services Tools|File Services Tools include the following:<br/><br/>- Distributed File System Tools include the DFS Management snap-in, and the Dfsradmin.exe, Dfsrdiag.exe, Dfscmd.exe, Dfsdiag.exe, and Dfsutil.exe command-line tools.<br/>- File Server Resource Manager tools include the File Server Resource Manager snap-in, and the Dirquota.exe, Filescrn.exe, and Storrept.exe command line tools.<br/>- Share and Storage Management Tools include the Share and Storage Management snap-in.|Not available<br/>| √ |
|Group Policy Management Tools|Group Policy Management Tools include Group Policy Management Console, Group Policy Management Editor, and Group Policy Starter GPO Editor.| √| √ |
|Hyper-V Tools|Hyper-V Tools include the Hyper-V Manager snap-in and the Virtual Machine Connection remote access tool.|Not available| √ |
|Network Load Balancing Tools|Network Load Balancing Tools include the Network Load Balancing Manager snap-in, Windows PowerShell tools for managing Network Load Balancing, and the Nlb.exe and Wlbs.exe command-line tools.| √| √ |
|Remote Desktop Services Tools|Remote Desktop Services Tools include the Remote Desktop Services Manager and Remote Desktop snap-ins.| √| √ |
|Server Manager|Server Manager includes the Server Manager console.<br/><br/>Remote management with Server Manager is available only in Windows Server 2008 R2.<br/>|Not available|Not available<br/><br/><br/><br/>|
|SMTP Server Tools|SMTP Server Tools include the Simple Mail Transfer Protocol (SMTP) snap-in.| √| √ |
|Storage Explorer Tools|Storage Explorer Tools include the Storage Explorer snap-in.|Not available| √ |
|Storage Manager for Storage Area Networks (SANs) Tools|Storage Manager for SANs Tools includes the Storage Manager for SANs snap-in and the Provisionstorage.exe command-line tool.| √ <br/><br/>Storage Manager for SANs is available in Windows Server 2003 R2 and later versions.| √ |
|Windows System Resource Manager Tools|Windows System Resource Manager Tools include the Windows System Resource Manager snap-in and the Wsrmc.exe command-line tool.|Not available| √ |
