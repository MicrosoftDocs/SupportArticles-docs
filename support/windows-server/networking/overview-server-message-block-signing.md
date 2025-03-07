---
title: Overview of Server Message Block signing
description: Describes how to configure SMB signing and how to determine whether SMB signing is enabled.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, nedpyle
ms.custom:
- sap:network connectivity and file sharing\access to file shares (smb)
- pcy:WinComm Networking
---
# Overview of Server Message Block signing

This article describes Server Message Block (SMB) 2.x and 3.x signing, and how to determine whether SMB signing is required.

## Introduction

SMB signing (also known as security signatures) is a security mechanism in the SMB protocol. SMB signing means that every SMB message contains a signature that is generated by using the session key. The client puts a hash of the entire message into the signature field of the SMB header.

SMB signing first appeared in Microsoft Windows 2000, Microsoft Windows NT 4.0, and Microsoft Windows 98. Signing algorithms have evolved over time. SMB 2.02 signing was improved by the introduction of hash-based message authentication code (HMAC) SHA-256, replacing the old MD5 method from the late 1990s that was used in SMB1. SMB 3.0 added AES-CMAC algorithms. In Windows Server 2022 and Windows 11, we added [AES-128-GMAC signing acceleration](/windows-server/storage/file-server/smb-security#new-signing-algorithm). If you want the best performance and protection combination, consider upgrading to the latest Windows versions.

## How SMB signing protects the connection

If someone changes a message during transmission, the hash won't match, and SMB will know that someone tampered with the data. The signature also confirms the sender's and receiver's identities. This prevents relay attacks. Ideally, you are using Kerberos instead of NTLMv2 so that your session key starts strong. Don't connect to shares by using IP addresses and don't use CNAME records, or you will use NTLM instead of Kerberos. Use Kerberos instead. See [Using Computer Name Aliases in place of DNS CNAME Records](https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/using-computer-name-aliases-in-place-of-dns-cname-records/ba-p/259064) for more information.

## Policy locations for SMB signing

The policies for SMB signing are located in **Computer Configuration** > **Windows Settings** > **Security Settings** > **Local Policies** > **Security Options**.

- **Microsoft network client: Digitally sign communications (always)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters`  
  Registry value: **RequireSecuritySignature**  
  Data Type: REG_DWORD  
  Data: 0 (disable), 1 (enable)
- **Microsoft network client: Digitally sign communications (if server agrees)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters`  
  Registry value: **EnableSecuritySignature**  
  Data Type: REG_DWORD  
  Data: 0 (disable), 1 (enable)
- **Microsoft network server: Digitally sign communications (always)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters`  
  Registry value: **RequireSecuritySignature**  
  Data Type: REG_DWORD  
  Data: 0 (disable), 1 (enable)
- **Microsoft network server: Digitally sign communications (if client agrees)**  
  Registry key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters`  
  Registry value: **EnableSecuritySignature**  
  Data Type: REG_DWORD  
  Data: 0 (disable), 1 (enable)

**Note** In these policies, "always" indicates that SMB signing is required, and "if server agrees" or "if client agrees" indicates that SMB signing is enabled.

### Understanding "RequireSecuritySignature" and "EnableSecuritySignature"

The **EnableSecuritySignature** registry setting for SMB2+ client and SMB2+ server is ignored. Therefore, this setting does nothing unless you're using SMB1. SMB 2.02 and later signing is controlled solely by being required or not. This setting is used when either the server or client requires SMB signing. Only if both have signing set to **0** will signing not occur.

|-|Server – RequireSecuritySignature=1|Server – RequireSecuritySignature=0|
|---|---|---|
|Client – RequireSecuritySignature=1|Signed|Signed|
|Client – RequireSecuritySignature=0|Signed|Not signed|

## Reference

[Configure SMB Signing with Confidence](https://techcommunity.microsoft.com/t5/storage-at-microsoft/configure-smb-signing-with-confidence/ba-p/2418102)

[How to Defend Users from Interception Attacks via SMB Client Defense](https://techcommunity.microsoft.com/t5/itops-talk-blog/how-to-defend-users-from-interception-attacks-via-smb-client/ba-p/1494995)

[SMB 2 and SMB 3 security in Windows 10: the anatomy of signing and cryptographic keys](/archive/blogs/openspecification/smb-2-and-smb-3-security-in-windows-10-the-anatomy-of-signing-and-cryptographic-keys)

[SMBv1 is not installed by default in Windows 10 version 1709, Windows Server version 1709 and later versions](/windows-server/storage/file-server/troubleshoot/smbv1-not-installed-by-default-in-windows)

[Netdom computername](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc835082(v=ws.11))
