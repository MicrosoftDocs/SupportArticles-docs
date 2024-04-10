---
title: Required updates for Internet Explorer 11
description: Describes the prerequisite updates for Internet Explorer 11.
ms.date: 06/09/2020
ms.reviewer: 
---
# Prerequisite updates for Internet Explorer 11

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a list of prerequisite updates and optional updates for Internet Explorer 11.

_Original product version:_ &nbsp; Internet Explorer 11  
_Original KB number:_ &nbsp; 2847882

## Summary

When you install Internet Explorer 11 for Windows 7, the installer program tries to automatically install some prerequisite components. If this part of the installation fails, Internet Explorer stops the installation process.

In this situation, you must install the prerequisite software manually before you can install Internet Explorer 11 for Windows 7.

To do this, use the links in the **List of prerequisite updates for Internet Explorer 11** section to obtain the individual update components.

### Make sure that the installation of other updates is complete

Internet Explorer 11 for Windows 7 cannot automatically install prerequisites if any update installation is in progress or if a system restart is pending.

To check whether you have an ongoing update installation or a pending restart in Windows 7, open Control Panel, click System and Security, and then click Windows Update. Then, take the following action, as appropriate:

- If an update installation is in progress, let that installation finish before you try to install Internet Explorer 11 for Windows 7.
- If all updates are installed but a system restart is pending, restart your computer before you try to install Internet Explorer 11 for Windows 7.

### List of prerequisite updates for Internet Explorer 11

The following table lists the prerequisite updates for Internet Explorer 11 in Windows 7 Service Pack 1 (SP1) or Windows Server 2008 R2 Service Pack 1 (SP1). You must have the following updates installed before you can install Internet Explorer 11 in Windows 7 SP1 and Windows Server 2008 R2 SP1.

To download the updates, click the link for the appropriate file, depending on whether you are running a 32-bit or 64-bit edition of the operating system.
For more information about specific updates, click the following article numbers to go to the Microsoft Knowledge Base articles.

> [!NOTE]
> To apply these updates, you must have [Service Pack 1 (SP1) for Windows 7 and for Windows Server 2008 R2](https://support.microsoft.com/help/976932) installed.

|KB number|Download link|Title|Description|
|---|---|---|---|
| [2729094](https://support.microsoft.com/help/2729094)| [Download x86 package for the 32-bit version of Windows](https://download.microsoft.com/download/b/6/b/b6bf1d9b-2568-406b-88e8-e4a218dea90a/windows6.1-kb2729094-v2-x86.msu) <br/><br/> [Download x64 package for the 64-bit version of Windows](https://download.microsoft.com/download/6/c/a/6ca15546-a46c-4333-b405-ab18785abb66/windows6.1-kb2729094-v2-x64.msu)|An update for the Segoe UI symbol font in Windows 7 and in Windows Server 2008 R2 is available|This update adds support for emoji characters and some control glyphs that are included in Windows 8 and in Windows Server 2012. After you install this item, you may have to restart your computer.|
| [2731771](https://support.microsoft.com/help/2731771)| [Download x86 package for the 32-bit version of Windows](https://download.microsoft.com/download/a/0/b/a0ba0a59-1f11-4736-91c0-dfcb06224d99/windows6.1-kb2731771-x86.msu) <br/><br/> [Download x64 package for the 64-bit version of Windows](https://download.microsoft.com/download/9/f/e/9fe868f6-a0e1-4f46-96e5-87d7b6573356/windows6.1-kb2731771-x64.msu)|An update that provides new APIs for conversion between local time and UTC in Windows 7 or in Windows Server 2008 R2 is available|This update provides new APIs for conversion between local time and Coordinated Universal Time (UTC). After you install this item, you may have to restart your computer.|
| [2533623](https://support.microsoft.com/help/2533623)| [Download packages for Windows](https://www.catalog.update.microsoft.com/Search.aspx?q=2533623) |Microsoft Security Advisory: Insecure library loading could allow remote code execution|This update provides new API improvements for Windows to help developers correctly and securely load external libraries. After you install this item, you may have to restart your computer.|
| [2670838](https://support.microsoft.com/help/2670838)| [Download x86 package for the 32-bit version of Windows](https://download.microsoft.com/download/1/4/9/14936fe9-4d16-4019-a093-5e00182609eb/windows6.1-kb2670838-x86.msu) <br/><br/> [Download x64 package for the 64-bit version of Windows](https://download.microsoft.com/download/1/4/9/14936fe9-4d16-4019-a093-5e00182609eb/windows6.1-kb2670838-x64.msu)|A platform update is available for Windows 7 SP1 and Windows Server 2008 R2 SP1|This update provides improved features and performance in Windows 7 SP1 and Windows Server 2008 R2 SP1. It includes updates to the following DirectX components: Direct2D, DirectWrite, Direct3D, Windows Imaging Component (WIC), and Windows Advanced Rasterization Platform (WARP). Additionally, it includes updates to the Windows Animation Manager (WAM), the XPS Document API, and the MPEG-2 Video Decoder. After you install this item, you may have to restart your computer.<br/><br/>> [!NOTE]<br/>> If this update is uninstalled, Internet Explorer 10 will also automatically be uninstalled.|
| [2786081](https://support.microsoft.com/help/2786081)| [Download x86 package for the 32-bit version of Windows](https://download.microsoft.com/download/4/8/1/481c640e-d3ee-4adc-aa48-6d0ed2869d37/windows6.1-kb2786081-x86.msu) <br/><br/> [Download x64 package for the 64-bit version of Windows](https://download.microsoft.com/download/1/8/f/18f9ae2c-4a10-417a-8408-c205420c22c3/windows6.1-kb2786081-x64.msu)|Internet Explorer 10 does not save credentials for a website after you log off or restart a computer that is running Windows 7 SP1 or Windows Server 2008 R2 SP1|Internet Explorer 10 does not save credentials for a website after you log off from or restart a computer that is running Windows 7 SP1 or Windows Server 2008 R2 SP1. This issue occurs because the WinInet cache task is not notified to close when you log off from or restart the computer. This update corrects this issue. After you install this update, you may have to restart your computer.|
| [2834140](https://support.microsoft.com/help/2834140)| [Download x86 package for the 32-bit version of Windows](https://download.microsoft.com/download/f/1/4/f1424ad7-f754-4b6e-b0da-151c7cbae859/windows6.1-kb2834140-v2-x86.msu) <br/><br/> [Download x64 package for the 64-bit version of Windows](https://download.microsoft.com/download/5/a/5/5a548bfe-adc5-414b-b6bd-e1ec27a8dd80/windows6.1-kb2834140-v2-x64.msu)|"0x00000050" Stop error after you install update 2670838 on a computer that is running Windows 7 SP1 or Windows Server 2008 R2 SP1|Assume that you install update 2670838 on a computer that is running Windows 7 Service Pack 1 (SP1) or Windows Server 2008 R2 SP1. You have a combination of Intel and AMD video cards in a hybrid configuration on the computer. In this situation, the computer intermittently crashes.|
  
### List of optional updates for Internet Explorer 11

The following updates are not required to install Internet Explorer 11. However, these updates will provide a better experience when they are installed.

|KB number|Download link|Title|Description|
|---|---|---|---|
| [2888049](https://support.microsoft.com/help/2888049)| [Download x86 package for the 32-bit version of Windows](https://download.microsoft.com/download/3/9/d/39d85ca8-7bf3-47c1-9031-fd6e51d8bbeb/windows6.1-kb2888049-x86.msu) <br/><br/> [Download x64 package for the 64-bit version of Windows](https://download.microsoft.com/download/4/1/3/41321d2e-2d08-4699-a635-d9828aadb177/windows6.1-kb2888049-x64.msu)|Update is available that improves the network performance of Internet Explorer 11 in Windows 7 SP1 and Windows Server 2008 R2 SP1|After you install this update, Windows sends ACK messages without any delay when it uses Transmission Control Protocol (TCP) protocol connections.<br/><br/> **NOTE** <br/> The TCP protocol is a common protocol that a computer uses in network connections.|
| [2882822](https://support.microsoft.com/help/2882822)| [Download x86 package for the 32-bit version of Windows](https://download.microsoft.com/download/7/c/e/7ce5d2a0-3a08-427e-9aa9-8a79e47b87b9/windows6.1-kb2882822-x86.msu) <br/><br/> [Download x64 package for the 64-bit version of Windows](https://download.microsoft.com/download/6/1/4/6141bfd5-40fd-4148-a3c9-e355338a9ac8/windows6.1-kb2882822-x64.msu)|Update adds ITraceRelogger interface support to Windows Embedded Standard 7 SP1, Windows 7 SP1 and Windows Server 2008 R2 SP1|The iTraceRelogger interface is a dependency to enable certain features in Internet Explorer 11 F12 tools (for example, the [UI Responsiveness tool](/previous-versions/windows/internet-explorer/ie-developer/samples/dn255009(v=vs.85)). <br/><br/> After this update is installed, the application that is dependent on the iTraceRelogger interface can enable certain features that run in Windows Embedded Standard 7 SP1, Windows 7 SP1, and Windows Server 2008 R2 SP1.|
