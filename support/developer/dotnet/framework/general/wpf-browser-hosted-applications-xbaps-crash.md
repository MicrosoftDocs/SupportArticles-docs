---
title: WPF XBAPs may crash during start-up
description: This article describes a problem that XAML browser applications may crash during start-up, and provides a solution.
ms.date: 05/07/2020
ms.reviewer: davean
---
# WPF browser-hosted applications (XBAPs) may crash during start-up

This article helps you resolve the problem where WPF XBAPs may crash during start-up.

_Original product version:_ &nbsp; Microsoft .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 972928

## Symptom

WPF XBAPs may crash during start-up.

## Cause

One cause of this problem is that system-level interface registrations are broken. In particular, registrations for the following interfaces may be missing:

- `IID_IWebBrowser2`
- `IID_IShellBrowser`

This can be because of failed installations or upgrades, or malware infections.

## Resolution

Re-register the broken interfaces by running the following commands:

```console
regsvr32 %SystemRoot%\System32\actxprxy.dll
regsvr32 "%ProgramFiles%\Internet Explorer\ieproxy.dll"
```

On 64-bit Windows, also run the following commands:

```console
regsvr32 %SystemRoot%\SysWOW64\actxprxy.dll
regsvr32 "%ProgramFiles(x86)%\Internet Explorer\ieproxy.dll"
```

On Windows XP and Windows Server 2003, these commands need to be run from a user account with administrative privileges on the machine.

On Windows Vista or later, these commands need to be run elevated. Select **Start** > **All Programs** > **Accessories**. Right-click Command Prompt and select **Run as Administrator**. At the command prompt, run the commands.

Check whether the problem is fixed. If the problem is fixed, you're finished with this section. If the problem isn't fixed, you can [contact support](https://support.microsoft.com/contactus/).
