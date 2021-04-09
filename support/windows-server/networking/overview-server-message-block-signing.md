---
title: Overview of Server Message Block signing
description: Describes how to configure SMB signing and how to determine whether SMB signing is enabled. This article also describes the default configuration for SMB signing and also provides different examples of SMB signing scenarios.
ms.date: 12/04/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, bbenson
ms.prod-support-area-path: Access to remote file shares (SMB or DFS Namespace)
ms.technology: networking
---
# Overview of Server Message Block signing

This article describes Server Message Block (SMB) signing, and how to determine whether SMB signing is enabled.

_Original product version:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 887429

## Introduction

SMB signing is a security mechanism in the SMB protocol and is also known as security signatures. SMB signing is designed to help improve the security of the SMB protocol. SMB signing was first available in Microsoft Windows NT 4.0 Service Pack 3 (SP3) and Microsoft Windows 98.

The following SMB topics are described in this article:

- The default configuration of SMB signing.
- How to configure SMB signing in Microsoft Windows Server 2003, Microsoft Windows XP, Microsoft Windows 2000, Windows NT 4.0, and Windows 98.
- How to determine whether SMB signing is enabled in a Network Monitor trace.
- Example SMB signing scenarios.

## More Information

### Default configuration for the Workstation service and the Server service

SMB signing and security signatures can be configured for the Workstation service and for the Server service. The Workstation service is used for outgoing connections. The Server service is used for incoming connections.

When SMB signing is enabled, it is possible for clients that support SMB signing to connect and it is also possible for clients that do not support SMB signing to connect. When SMB signing is required, both computers in the SMB connection must support SMB signing. The SMB connection is not successful if one computer does not support SMB signing. By default, SMB signing is enabled for outgoing SMB sessions on the following operating systems:

- Windows Server 2003
- Windows XP
- Windows 2000
- Windows NT 4.0
- Windows 98

By default, SMB signing is enabled for incoming SMB sessions on the following operating systems:

- Windows Server 2003-based domain controllers
- Windows 2000 Server-based domain controllers
- Windows NT 4.0 Server-based domain controllers

By default, SMB signing is required for incoming SMB sessions on Windows Server 2003-based domain controllers.

### Configuring SMB signing

We recommend that you use Group Policies to configure SMB signing because a local registry value change does not function correctly if there is an overriding domain policy. The following registry values are changed when the associated Group Policy is configured.

#### Policy locations for SMB signing

> [!NOTE]
> The following Group Policy settings are located in the "Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options" Group Policy Object Editor path.

##### Windows Server 2003 - default domain controllers Group Policy

###### Workstation/Client

Microsoft network client: Digitally sign communications (always) Policy Setting: not defined

Microsoft network client: Digitally sign communications (if server agrees) Policy Setting: not defined Effective Setting: enabled (because of local policy)

###### Server

Microsoft network server: Digitally sign communications (always) Policy Setting: enabled

Microsoft network server: Digitally sign communications (if client agrees) Policy Setting: enabled

##### Windows XP and 2003 - local computer Group Policy

###### Workstation/Client

Microsoft network client: Digitally sign communications (always) Security Setting: disabled

Microsoft network client: Digitally sign communications (if server agrees) Security Setting: enabled

###### Server

Microsoft network server: Digitally sign communications (always) Security Setting: disabled

Microsoft network server: Digitally sign communications (if client agrees) Security Setting: disabled

##### Windows 2000 - default domain controllers Group Policy

###### Workstation/Client

Digitally sign client communication (always) Computer Setting: not defined

Digitally sign client communication (when possible) Computer Setting: not defined

###### Server

Digitally sign server communication (always) Computer Setting: not defined

Digitally sign server communication (when possible) Computer Setting: enabled

##### Windows 2000 - local computer Group Policy

###### Workstation/Client

Digitally sign client communication (always) Local Setting: Disabled Effective Setting: disabled

Digitally sign client communication (when possible) Local Setting: Enabled Effective Setting: enabled

###### Server

Digitally sign server communication (always) Local Setting: Disabled Effective Setting: disabled

Digitally sign server communication (when possible) Local Setting: Disabled Effective Setting: disabled

#### Registry values associated with Group Policy configuration for Windows Server 2003, Windows XP, and Windows 2000

##### Client

In Windows Server 2003 and Windows XP, the "Microsoft network client: Digitally sign communications (if server agrees)" Group Policy, and in Windows 2000, the "Digitally sign client communication (when possible)" Group Policy map to the following registry subkey:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters`

**Value Name**: EnableSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)  

> [!NOTE]
> The default value in Windows Server 2003, Windows XP, and Windows 2000 is 1 (enabled).

In Windows Server 2003 and Windows XP, the "Microsoft network client: Digitally sign communications (always)" Group Policy, and in Windows 2000, the "Digitally sign client communication (always)" Group Policy map to the following registry subkey:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters`

**Value Name**: RequireSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> The default value in Windows Server 2003, Windows XP, and Windows 2000 is 0 (not required).

##### Server

In Windows Server 2003 and Windows XP, the Group Policy named "Microsoft network client: Digitally sign communications (if client agrees)", and in Windows 2000, the Group Policy named "Digitally sign server communication (when possible)" map to the following registry key:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters`

**Value Name**: EnableSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> The default value in Windows Server 2003 domain controllers and Windows 2000 domain controllers is 1 (enabled). The default value in Windows NT 4.0 domain controllers is 0 (disabled).
Windows Server 2003 and Windows XP policy is named "Microsoft network server: Digitally sign communications (always)"

Windows 2000 policy is named "Digitally sign server communication (always)" and both map to the following registry key:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters`

**Value Name**: RequireSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> The default value in Windows Server 2003 domain controllers and Windows 2000 domain controllers is 1 (required). The default value in Windows NT 4.0 domain controllers is 0 (not required).

For Windows NT 4.0-based computers to be able to connect to Windows 2000-based computers by using SMB signing, you must create the following registry value on the Windows 2000-based computers:  
**Value Name**: enableW9xsecuritysignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> There is no Group Policy associated with the EnableW9xsecuritysignature registry value.

#### Configuring SMB signing in Windows NT 4.0

Digitally sign client:
> [!Note]
> This is the RDR key - not LanmanWorkstation as in Windows 2000

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Rdr\Parameters`

**Value Name**: EnableSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> The default value is 1 (enabled) on computers that are running Windows NT 4.0 SP3 or later versions of Windows.

**Value Name**: RequireSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> The default value is 0 (not required) on computers that are running Windows NT 4.0 SP3 or later versions of Windows.

"Digitally sign server" in the policy maps to the following registry key:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters`

**Value Name**: EnableSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> The default value is 1 (enabled) on Windows Server 2003 domain controllers, Windows 2000 domain controllers, and Windows NT 4.0 domain controllers. The default value for all other computers that are running Windows NT 4.0 SP3 or later versions of Windows is 0 (disabled).

**Value Name**: RequireSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> The default value is 1 (required) on Windows Server 2003 domain controllers. The default value for all other computers that are running Windows NT 4.0 SP3 or later versions of Windows is 0 (not required).

#### Configuring SMB signing in Windows 98

Add the following two registry values to this registry subkey:  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VxD\VNetsup`

**Value Name**: EnableSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> The default value in Windows 98 is 1 (enable).

**Value Name**: RequireSecuritySignature  
**Data Type**: REG_DWORD  
**Data**: 0 (disable), 1 (enable)

> [!NOTE]
> The default value in Windows 98 is 0 (disabled).

### How to determine whether SMB signing is enabled in a network monitor trace

To determine whether SMB signing is enabled, required at the server, or both, view the Negotiate Dialect Response from the server:

```output
SMB: R negotiate, Dialect # = 5  
SMB: Command = R negotiate  
SMB: Security Mode Summary (NT) = [a value of 3, 7 or 15]  
SMB: .......1 = User level security  
SMB: ......1. = Encrypt passwords
```

In this Response, the "Security Mode Summary (NT) =" field represents the configured options on the Server. This value will be either 3, 7 or 15.

The following information helps explain what the Negotiate Dialect Response numbers represent:  
UCHAR SecurityMode; Security mode:

bit 0: 0 = share

bit 0: 1 = user

bit 1: 1 = encrypt passwords

bit 2: 1 = Security Signatures (SMB sequence numbers) enabled

bit 3: 1 = Security Signatures (SMB sequence numbers) required

If SMB signing is disabled at the server, the value is 3.

"SMB: Security Mode Summary (NT) = 3 (0x3)"

If SMB signing is enabled and not required at the server, the value is 7.

"SMB: Security Mode Summary (NT) = 7 (0x7)"

If SMB signing is enabled and required at the server, the value is 15.

"SMB: Security Mode Summary (NT) = 15 (0xF)"  
For additional information about CIFS, visit the following Microsoft Web site:  
[CIFS](/previous-versions/aa302188(v=msdn.10))

### SMB signing scenarios

The behavior of the SMB session after the Dialect Negotiation shows the client configuration.

If SMB Signing is enabled and required at both the client and the server, or if SMB signing is disabled at both the client and the server, the connection is successful.

If SMB signing is enabled and required at the client and disabled at the server, the connection to the TCP session is gracefully closed after the Dialect Negotiation, and the client receives the following "1240 (ERROR_LOGIN_WKSTA_RESTRICTION)" error message:  
> System error 1240 has occurred. The account is not authorized to log in from this station.

If SMB signing is disabled at the client and enabled and required at the server, the client receives the "STATUS_ACCESS_DENIED" error message when it receives a response to a Tree Connect or Transact2 for DFS referrals.
