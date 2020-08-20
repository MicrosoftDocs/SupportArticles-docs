---
title: Windows Automation API 3.0 improves Visual Studio 2010
description: This article describes Windows Automation API 3.0, which improves the speed and performance of Visual Studio 2010.
ms.date: 04/28/2020
ms.prod-support-area-path:
ms.reviewer: jbartlet, robcap
---
# Visual Studio 2010 runs faster when Windows Automation API 3.0 is installed

This article introduces Windows Automation API 3.0 improves the speed of Microsoft Visual Studio 2010, and provides a Windows Automation API 3.0 update.

_Original product version:_ &nbsp; Visual Studio Ultimate 2010, Visual Studio Professional 2010, Visual Studio 2010 SDK  
_Original KB number:_ &nbsp; 981741

## Introduction

Applications that use Windows Automation APIs can significantly decrease Visual Studio IntelliSense performance if Windows Automation API 3.0 isn't installed. For example, the Windows pen and touch services can significantly decrease Visual Studio IntelliSense performance if Windows Automation API 3.0 isn't installed. This article describes how to install the Windows Automation API 3.0 update. This update is available as a stand-alone download for Windows Server 2003. The Windows Automation API is a component of the platform update for Windows Vista and of the platform update for Windows Server 2008.

## Windows Automation API

The Windows Automation API library enables accessibility tools, test automations, and pen services to access a standard user interface across operating system versions.

For more information about the Windows Automation API, see [Overview of Windows Automation API 3.0](/windows/win32/winauto/windows-automation-api-overview).

## Download information

The following file is available for download from the Microsoft Download Center:  

- Update for all supported x86-based versions of Windows Server 2008

    [Download the Update for Windows Server 2008 for x86-based systems package now.](https://www.microsoft.com/download/details.aspx?FamilyId=468e4f78-d411-4932-8719-76a0b2eb1443)

- Update for all supported x64-based versions of Windows Server 2008

    [Download the Update for Windows Server 2008 for x64-based systems package now.](https://www.microsoft.com/download/details.aspx?FamilyId=5cc9aaae-9f7a-442a-8af6-113fa0068c48)

## More information

Customers who can't install the update can set the following registry key to prevent the notification from being displayed:  

- Location: `HKEY_CURRENT_USER\Software\Microsoft\VisualStudio\10.0\General`
- Type: DWORD
- Name: UIAOverride
- Value: 00000001

> [!NOTE]
> The integrated installation of this package may function incorrectly when you use the procedures that are described in [How to integrate software updates into your Windows installation source files](https://support.microsoft.com/help/828930). This is a known issue.

For more information about how to download Microsoft support files, see
[How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.
