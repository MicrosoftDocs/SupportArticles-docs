---
title: Outlook shows Disconnected if IPv6 is enabled
description: Describes a problem that blocks Outlook from accessing your Exchange Server mailbox. The connection status is shown as Disconnected.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Product Stability, startup or Shutdown and perform\Network disconnects, password or credentials prompt
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 07/06/2026
---
# Outlook displays a Disconnected status when IPv6 is enabled

_Original KB number:_ &nbsp; 3134780

## Symptoms

Microsoft Outlook cannot connect to your Microsoft Exchange mailbox, and the connection status is displayed as **Disconnected**.

## Cause

This issue may occur if you have IPv6 enabled on your network adapter and there are network connectivity issues on your IPv6 network.

## Resolution

To resolve this issue, fix the connectivity issues related to your IPv6 network. For details about the recommended IPv6 configuration, see [Configure IPv6 in Windows](/troubleshoot/windows-server/networking/configure-ipv6-in-windows).

## Workaround

If you are unable to resolve the issues on your IPv6 network, you can work around this issue by using one of the following methods.

Method 1: Disable IPv6 using the registry
Configure the  following registry key:

**Location**: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\`   
**Name**: DisabledComponents   
**Type**: REG_DWORD **  
Value**: 0xFF

Method 2: Use Prefer IPv4 over IPv6 in prefix policies. For details, see [Configure IPv6 in Windows](/troubleshoot/windows-server/networking/configure-ipv6-in-windows)
