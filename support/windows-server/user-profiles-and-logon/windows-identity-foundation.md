---
title: Description of Windows Identity Foundation
description: Describes Windows Identity Foundation and how to obtain it.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User profiles
ms.technology: windows-server-user-profiles
---
# Description of Windows Identity Foundation

This article provides information about Windows Identity Foundation.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 974405

## Introduction

Windows Identity Foundation (WIF) is a new extension to the Microsoft .NET Framework that makes it easy for developers to enable advanced identity capabilities in the .NET Framework applications. Based on interoperable, standard protocols, Windows Identity Foundation and the claims-based identity model can be used to enable single sign-on (SSO), personalization, federation, strong authentication, identity delegation, and other identity capabilities in `ASP.NET` and Windows Communication Foundation (WCF) applications that run on-premises or in the cloud.

### System requirements

Windows Identity Foundation requires that one of the following operating systems be installed:

- Windows 7 (32-bit or 64-bit)
- Windows Server 2008 R2 (64-bit)
- Windows Server 2008 together with Service Pack 2 (32-bit or 64-bit)
- Windows Vista together with Service Pack 2 (32-bit or 64-bit)
- Windows Server 2003 together with Service Pack 2 (32-bit or 64-bit)
- Windows Server 2003 R2 (32-bit or 64-bit)  

Windows Identity Foundation requires the following to be installed:

- The Microsoft .NET Framework 3.5 together with Service Pack 1

### Supported languages

Windows Identity Foundation is supported in the following languages:

- English
- Dutch
- French
- German
- Italian
- Japanese
- Spanish

### Download information

The following files are available for download from the Microsoft Download Center.  

|Package name|Supported operating system|Platform|Download file size|
|---|---|---|---|
|Windows6.1-KB974405-x64.msu|Windows 7 and Windows Server 2008 R2|x64|965 KB|
|Windows6.1-KB974405-x86.msu|Windows 7|x86|858 KB|
|Windows6.0-KB974405-x64.msu|Windows Vista SP2 and Windows Server 2008 SP2|x64|969 KB|
|Windows6.0-KB974405-x86.msu|Windows Vista SP2 and Windows Server 2008 SP2|x86|861 KB|
|Windows5.2-KB974405-x64.exe|Windows Server 2003 SP2|x64|1.2 MB|
|Windows5.2-KB974405-x86.exe|Windows Server 2003 SP2|x86|1.2 MB|

For more information about how to download Microsoft support files, click the following article number to view the article in the Microsoft Knowledge Base:  
[119591](https://support.microsoft.com/help/119591) How to obtain Microsoft support files from online services
  
Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

## More information

For more information about technical details and white papers, go to the following Microsoft websites:  
[Microsoft Security Response Center](https://msdn.microsoft.com/security/aa570351.aspx)  

[Microsoft documentation and learning for developers and technology professionals](https://msdn.microsoft.com/library/ee748484.aspx)  

### Windows operating system upgrade information

If you have Windows Identity Foundation installed on Windows Server 2008 or on Windows Server 2003, Windows Identity Foundation will be automatically uninstalled when you upgrade your Windows operating system to Windows Server 2008 R2. You have to install the Windows Identity Foundation installation package for Windows Server 2008 R2 after your Windows operating system upgrade.

If you have Windows Identity Foundation installed on Windows Server 2003, Windows Identity Foundation will remain on the upgraded operating system when you upgrade your Windows operating system to Windows Server 2008. We recommend that you uninstall the Windows Identity Foundation before you upgrade your Windows operating system and then reinstall Windows Identity Foundation for Windows Server 2008. You can use the following command to silently uninstall Windows Identity Foundation on Windows Server 2003:
`%windir%\\$NtUninstallKB974405$\\spuninst\\spuninst.exe /quiet`.

If an error occurs when you run this command, we recommend that you uninstall Windows Identity Foundation by using Programs and Features in Control Panel.

## Technical revisions

The following table lists significant technical revisions to this article.

|Date|Revisions|
|---|---|
|November 18, 2009|Original publication date|
|December 18, 2009|Add Windows Server 2003 support|
