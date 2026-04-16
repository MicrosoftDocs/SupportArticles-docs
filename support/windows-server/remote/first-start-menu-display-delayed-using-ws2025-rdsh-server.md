---
title: First display of the Start menu is delayed in a remote desktop session on a Windows Server 2025-based RDSH server
description: Describes why, when you use a Windows Server 2025 Remote Desktop Session Host (RDSH) server, remote desktop users might experience a lag in the performance of the Start menu.
ms.date: 04/17/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:Remote Desktop Services and Terminal Services\Slow performance in Remote Desktop Services or in a session
- pcy:WinComm User Experience
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# First display of the Start menu is delayed in a remote desktop session on a Windows Server 2025-based RDSH server

## Summary

This article describes why, when you use a Windows Server 2025 Remote Desktop Session Host (RDSH) server, remote desktop users might experience a lag in the performance of the Start menu. This lag only occurs the first time a user opens the Start menu during a remote desktop session. This article also explains how to configure the RDSH server to prelaunch Start menu processes if the delay is noticeable for users.

## Symptoms

You have a Remote Desktop Service deployment that uses Windows Server 2025-based computers as Remote Desktop Session Host (RDSH) servers. Users report that after they sign in to a remote desktop session, the first time they open the Start menu, it doesn't appear right away. It might take several seconds to display. However, after that the Start menu appears as quickly as expected.

## Cause

This behavior is expected. Windows Server 2025 and later versions don't prelaunch the processes that facilitate the Start menu experience. These processes include the following examples:

- SearchHost.exe
- StartMenuExperienceHost.exe
- Other infrastructure processes, such as RuntimeBroker, and other per-user services

## Resolution

You can configure Windows Server to use the previous behavior by changing the `PrelaunchOverride` registry entry.

> [!CAUTION]  
> Use the default setting unless users experience a noticeable delay when they first open the Start menu. The purpose of the default setting is to prevent heavy CPU load during "start of the workday" scenarios. In such scenarios, multiple users are likely to sign in to the same VM at the same time. When `PrelaunchOverride` is set to `1`, these processes start for all these users at the same time, causing longer sign-in times and reduced responsiveness for signed-in users.

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

To change the entry, follow these steps.

1. On the RDSH server, in Registry Editor, go to the `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\StartMenu` subkey.

1. Under this subkey, modify the following entry (if it doesn't exist, create it).

   - Name: `PrelaunchOverride`
   - Type: REG\_DWORD
   - Value data: `1`

   > [!NOTE]  
   > `PrelaunchOverride` has the following possible values:
    - `0`: Use the new default behavior. Don't start StartMenuExperienceHost.exe, SearchHost.exe, or similar processes until the user selects **Start**.
    - `1`: Use the previous behavior. StartMenuExperienceHost.exe SearchHost.exe, and similar processes start as soon as a user signs in.
