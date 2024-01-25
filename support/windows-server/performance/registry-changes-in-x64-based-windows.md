---
title: Registry changes in x64-based versions of Windows
description: Describes some of the important registry changes that have been made in the x64 Edition version of the Windows operating system.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, joeswart
ms.custom: sap:applications, csstroubleshoot
ms.subservice: performance
---
# Registry changes in x64-based versions of Windows

This article describes some of the registry changes that have been made in x64-based versions of Microsoft Windows Server 2003 and Microsoft Windows XP Professional x64 Edition. It describes how the Windows x64 Edition operating system stores registry information for 32-bit programs and 64-bit programs. 

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 896459

## Summary

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

Computers that are running an x64-based version of Microsoft Windows Server 2003 or Microsoft Windows XP Professional x64 Edition use a different registry layout to handle both 32-bit and 64-bit programs. The registry layout changes in x64 Edition versions of the Windows operating system make sure that the programs hard-coded .dll paths, program settings, and other parameter values are not overwritten.

To prevent 32-bit registry settings from overwriting the 64-bit registry settings, computers that are running an x64-based version of Microsoft Store the settings for 32-bit programs in a new branch in the registry. Users do not notice any changes during program installation. The registry redirection process enables program installations and program configuration settings to access the correct registry subkey without user intervention.

32-bit programs and 64-bit programs that are running on an x64-based version of Windows operate in different modes and use the following sections in the registry:

- Native mode 64-bit programs run in Native mode and access keys and values that are stored in the following registry subkey:

    `HKEY_LOCAL_MACHINE\Software`

- 32-bit programs run in WOW64 mode and access keys and values that are stored in the following registry subkey:

    `HKEY_LOCAL_MACHINE\Software\WOW6432node`

## Registry redirection

To support the coexistence of 32-bit and 64-bit COM registration and program states, the WOW64 subsystem presents 32-bit programs by using another view of the registry. The WOW64 subsystem uses registry redirection to intercept registry calls at the bit level. Registry redirection also makes sure that the registry calls are directed to the correct branches in the registry.

When you install a new program or when you run a program on a Windows x64 Edition computer, registry calls made by 64-bit programs access the `HKEY_LOCAL_MACHINE\Software` registry subkey without redirection. WOW64 intercepts registry calls to `HKEY_LOCAL_MACHINE\Software` that are made by 32-bit programs, and then redirects them to the `HKEY_LOCAL_MACHINE\Software\WOW6432node` subkey. By redirecting only the 32-bit program calls, WOW64 makes sure that programs always write to the appropriate registry subkey. Registry redirection does not require program code modification, and this process is transparent to the user.

### Registry subkeys that are included in redirection

The following registry subkeys are redirected in current versions of the Windows x64 Edition operating system:

- `HKEY_LOCAL_MACHINE\Software\Classes` 
- `HKEY_LOCAL_MACHINE\Software\Microsoft\Ole` 
- `HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc` 
- `HKEY_LOCAL_MACHINE\Software\Microsoft\COM3` 
- `HKEY_LOCAL_MACHINE\Software\Microsoft\EventSystem`

> [!IMPORTANT]
> Registry key redirection may change in later operating system versions. Software developers are encouraged to avoid writing program code that is based on previously-documented lists of redirected keys. Instead, code should be written to verify redirection status before it makes calls to the 32-bit or 64-bit logical view of the registry.

## Registry reflection

Registry reflection provides a real-time method to hold the 32-bit and 64-bit sections of the registry open at all times. For example, consider a 32-bit program that is named Hello.exe that acts as a 32-bit OLE server, but that can also serve requests from 64-bit clients. Registry reflection makes it possible for the Hello.exe program to keep both the 32-bit registry and the 64-bit registry open to handle both 32-bit and 64-bit program calls.

Reflection makes it possible for the existence of two physical copies of the same registry to support simultaneous native and WOW64 operations. Most of the keys that are reflected are class keys. Class keys are written with a "last writer wins" philosophy, and the handle to the key is closed when either the 32-bit or 64-bit class key is written and closed.

The following list contains some examples of the "last writer wins" philosophy:

- After you perform a clean installation of the Windows x64 Edition operating system, the 64-bit version of Wordpad.exe is registered to handle .doc files. The registry reflector copies the .doc registration from the 64-bit registry section into the 32-bit registry section.
- When you install a 32-bit version of Microsoft Office, Winword.exe is registered to handle .doc files in the 32-bit registry view. The registry reflector copies this information into the 64-bit registry section. Therefore, both 32-bit and 64-bit programs start the 32-bit version of Winword.exe for .doc files.
- When you install the 64-bit version of Microsoft Office, the 64-bit version of Winword.exe is registered in the 64-bit registry section to handle .doc files. The registry reflector also copies this information into the 32-bit registry section so both 32-bit and 64-bit programs start the 64-bit version of Winword.exe for .doc files.

> [!NOTE]
> Developers can use the RegQueryReflectionKey function to determine the reflection state for a particular key and use the RegDisableReflectionKey function and the RegEnableReflectionKey function to programmatically disable and enable registry reflection for a particular key.

## Shared registry keys

Certain registry subkeys contain constant information that exists in only one copy of the registry even though these keys appear in both the 32-bit and 64-bit registry views. This is referred to as registry reflection.

In current versions of the Windows x64 Edition operating systems, the following registry subkeys are shared across 32-bit and 64-bit program and are not rewritten based on the 32-bit or 64-bit level of the program or process:

- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\SYSTEMCERTIFICATES`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\CRYPTOGRAPHY\SERVICES`
- `HKEY_LOCAL_MACHINE\SOFTWARE\CLASSES\HCP`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\ENTERPRISECERTIFICATES`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\MSMQ`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\NETWORKCARDS`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\PROFILELIST`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\PERFLIB`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\PRINT`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\PORTS`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\CONTROL PANEL\CURSORS\SCHEMES`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\TELEPHONY\LOCATIONS`
- `HKEY_LOCAL_MACHINE\SOFTWARE\POLICIES`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\GROUP POLICY`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\POLICIES`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\SETUP\OC MANAGER`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\SOFTWARE\MICROSOFT\SHARED TOOLS\MSINFO`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\SETUP`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\CTF\TIP`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\CTF\SYSTEMSHARED`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\FONTS`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\FONTSUBSTITUTES`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\FONTDPI`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\FONTMAPPER`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\RAS`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\DRIVER SIGNING`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\NON-DRIVER SIGNING`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\CRYPTOGRAPHY\CALAIS\CURRENT`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\CRYPTOGRAPHY\CALAIS\READERS`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\CURRENTVERSION\TIME ZONE`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\TRANSACTION SERVER`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\DFS`
- `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\TERMSERVLICENSING`

> [!IMPORTANT]
> Registry key reflection may change in later operating system versions. Software developers are encouraged to avoid writing program code that is based on previously-documented lists of reflected keys. Instead, code should be written to verify reflection status before the program makes calls to the 32-bit or 64-bit logical view of the registry.

## Registry Editor changes

Both 32-bit and 64-bit versions of Registry Editor are included with x64 Edition operating systems. To better understand the 64-bit and 32-bit program sections of the registry on a Windows x64 Edition computer, use one of the following methods.

### To start the 64-bit version of Registry Editor

1. Log on to the Windows x64 Edition computer by using an account that has administrative permissions.
2. Click **Start**, click **Run**, type regedit in the **Open** box, and then click **OK**.
3. In Registry Editor, locate and examine the following registry subkey: `HKEY_LOCAL_MACHINE\Software\WOW6432node` 

### To start the 32-bit version of Registry Editor

Click **Start**, click **Run**, type drive letter where you installed Windows x64 Edition\Windows\syswow64\regedit.exe m in the **Open** box, and then click **OK**. The **m** switch lets you run multiple instances of Registry Editor.

> [!NOTE]
> When you log on to a Microsoft Windows Server 2003 Service Pack 1 (SP1) or later-based computer or a Windows x64 Edition-based computer and you use the Remote Desktop Protocol (RDP) to connect to another Windows Server 2003 SP1 or later-based computer or Windows x64 Edition-based computer, you can view the 64-bit section of the registry on the remote computer. However, when you log on to Microsoft Windows Server 2003 computer that has not been upgraded to SP1 or any other 32 -bit Windows operating system, you can only view the 32-bit section of the registry on the remote computer. 

## Technical support for x64-based versions of Windows

If your hardware came with a Windows x64 edition already installed, your hardware manufacturer provides technical support and assistance for the Windows x64 edition. In this case, your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation by using unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you must have technical help with a Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware. If you purchased a Windows x64 edition such as a Windows Server 2003 x64 edition separately, contact Microsoft for technical support.
