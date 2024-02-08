---
title: How to disable HTTP proxy features
description: Describes how to disable specific features of Windows HTTP proxies.
ms.date: 03/12/2022
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:tcp/ip-communications, csstroubleshoot
ms.subservice: networking
keywords: http proxy, authentication, loopback, WPAD
---

# How to disable HTTP proxy features

This article describes how to disable specific features of Windows HTTP proxies.

_Applies to:_ &nbsp; Windows Server 2022, all editions, Windows 11, all editions

## How to disable an authentication protocol

HTTP proxies can use any of several different authentication protocols. Some of these protocols are considered to be not secure. You should support such protocols only if you have to provide backward compatibility with earlier versions of Windows.

Starting in Windows Server 2022 and Windows 11, you can disable individual authentication protocols. To disable protocols, configure the value of the following registry subkey:

```console
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\DisableProxyAuthenticationSchemes
```

The following table lists the hexadecimal values that correspond to each of the protocols that you can disable.

|Authentication method to disable |DWORD value |
| --- | --- |
|Basic |**0x00000001** |
|Digest |**0x00000002** |
|NTLM |**0x00000004** |
|Kerberos |**0x00000008** |
|Negotiate |**0x00000010** |

## How to disable authentication over loopback interfaces

Windows can authenticate over a loopback interface. This is similar to any other network interface. However, if you want to limit the sign-in interface to only known and trusted services, you might want to disable the loopback authentication capability.

Starting in Windows Server 2022 and Windows 11, you can disable loopback authentication by setting the DWORD value of `DisableProxyAuthenticationSchemes` to **0x00000100** (Local Service).

## How to disable WPAD

Windows uses Web Proxy Auto-Discovery protocol (WPAD) to discover Proxy Auto-Config (PAC) files from the local network. If you prefer to manage endpoints directly, you can disable WPAD.

Starting in Windows Server 2019 and Windows 10, version 1809, you can disable WPAD by setting a DWORD value for the following registry subkey to **1**:

```console
HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp\DisableWpad
```

After you disable WPAD, you have to manually configure all proxies.
