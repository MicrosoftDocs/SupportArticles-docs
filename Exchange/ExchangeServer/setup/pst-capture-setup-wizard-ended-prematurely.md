---
title: Installing PST Capture tool fails
description: Describes an error that occurs if the Windows Firewall service is disabled. Provides a resolution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.reviewer: sidd
ms.custom: 
- Exchange Server
- CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Windows Server 2008 R2 Standard
- Windows Server 2008 R2 Foundation
- Windows Server 2008 R2 Enterprise
- Windows Server 2008 R2 Datacenter
---
# Error when you install the PST Capture tool in Windows Server 2008 R2: Setup wizard ended prematurely because of an error

_Original KB number:_ &nbsp; 2844231

## Symptoms

When you try to install the PST Capture tool in Windows Server 2008 R2, the installation fails, and you receive the following error message:

> Setup wizard ended prematurely because of an error.

Additionally, the following error message may be logged in the setup file:

> ExecFirewallExceptions: Error 0x800706d9

The setup file is created when you run the PST Capture tool setup together with the following switch:

```console
PSTCapture.msi /lxv <Drive>:\log.txt
```  

> [!NOTE]
> In this command, the placeholder \<Drive> represents the drive location to which the setup logs will be saved.

## Cause

This issue may occur if the Windows Firewall service is disabled. For the PST Capture tool setup to succeed, the Windows Firewall service must be enabled.

> [!NOTE]
> By Default, the Windows Firewall service is enabled in Windows Server 2008 R2.

## Resolution

To resolve this issue, start the Windows Firewall service on the server on which you're installing the PST capture tool.
