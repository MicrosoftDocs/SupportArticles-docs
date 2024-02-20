---
title: Internet firewalls prevent file sharing
description: Explains that a firewall may keep you from searching or sharing files with other computers on a home network.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-firewall-with-advanced-security-wfas, csstroubleshoot
---
# Internet firewalls can prevent browsing and file sharing

Turning on a firewall may prevent you from searching or sharing files with other computers on a home network.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 298804

## Symptoms

After you enable an Internet firewall, you may not be able to search, or browse, for other computers on your home or office network. And you may not be able to share files with other computers on your home or office network. For example, when you enable the Internet Connection Firewall (ICF) feature in Windows XP, you find that you can't browse your network by using My Network Places. Also, if you use the `net view \\computername` command to view shares on a computer on your home or office network, you may receive the following error message:

> System error 6118 has occurred. The list of servers for this workgroup is not currently available.

## Cause

This behavior may occur if you enable a firewall on the network connection that you use for your home or office network. By default, a firewall closes the ports that are used for file and print sharing. The purpose is to prevent Internet computers from connecting to file and print shares on your computer.

## Resolution

To resolve this behavior, use a firewall only for network connections that you use to connect directly to the Internet. For example, use a firewall on a single computer that is connected to the Internet directly through a cable modem, a DSL modem, or a dial-up modem. If you use the same network connection to connect to both the Internet and a home or office network, use a router or firewall that prevents Internet computers from connecting to the shared resources on the home or office computers.

Don't use a firewall on network connections that you use to connect to your home or office network, unless the firewall can be configured to open ports only for your home or office network. If you connect to the Internet by using your home or office network, a firewall can be used only on the computer or the other device, such as a router, that provides the connection to the Internet. For example, if you connect to the Internet through a network that you manage, and that network uses connection sharing to provide Internet access to multiple computers, you can install or enable a firewall only on the shared Internet connection. If you connect to the Internet through a network that you do not manage, verify that your network administrator is using a firewall.

## Status

This behavior is by design.

## More information

A firewall is software or hardware that creates a protective barrier between your computer and potentially damaging content on the Internet. It helps guard your computer against malicious users and against many computer viruses and worms.

> [!IMPORTANT]
> If you set up a firewall to help protect computer ports that are connected to the Internet, we do not recommend that you open these ports because they can be exposed to other computers on the Internet. Additionally, specific computers cannot be granted access to the open ports.

The following ports are associated with file sharing and server message block (SMB) communications:

- Microsoft file sharing SMB: User Datagram Protocol (UDP) ports from 135 through 139 and Transmission Control Protocol (TCP) ports from 135 through 139.
- Direct-hosted SMB traffic without a network basic input/output system (NetBIOS): port 445 (TCP and UDP).

### Technical support for Windows x64 editions

Your hardware manufacturer provides technical support and assistance for Microsoft Windows x64 editions. Your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation with unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with your Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware.

For more information, see [Protect my PC from viruses](https://support.microsoft.com/help/17228/windows-protect-my-pc-from-viruses).
