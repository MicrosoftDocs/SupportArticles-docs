---
title: Access Denied when you access Server Message Block (SMB) file share
description: Resolves an issue in which you can't access a shared folder through SMB2 protocol. 
ms.date: 07/09/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:network connectivity and file sharing\access to file shares (smb)
- pcy:WinComm Networking
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Access Denied when you access an SMB file share in Windows

## Summary

This article helps you resolve **Access Denied** errors that occur when you access a Server Message Block (SMB) file share on Windows. It provides step-by-step guidance to identify and fix common causes, including security changes in recent Windows versions and configuration mismatches. The solutions help ensure secure and seamless access to shared folders, improving productivity and reducing troubleshooting time. Use the **[Identify the cause first](#identify-the-cause-first)** section to determine the appropriate resolution.

> [!IMPORTANT]
> Starting with **Windows 11, version 24H2** and **Windows Server 2025**, several SMB security features are **enforced by default**. If Access Denied started **after an OS upgrade** and the share previously worked, review [Behavior changes by OS version](#behavior-changes-by-os-version) first.

## Symptoms

When you connect to a shared folder on a Windows file server, a third-party device, or a network-attached storage (NAS) appliance, one or more of the following symptoms occur:

- `Access is denied.` or `You do not have permission to access \\server\share.`
- `You can't access this shared folder because your organization's security policies block unauthenticated guest access.`
- The mapping fails with `System error 5` (`net use`), or status codes such as `0x80070035` (network path not found) or `STATUS_ACCESS_DENIED (0xC0000022)`.
- The connection worked before an upgrade to **Windows 11, version 24H2** or **Windows Server 2025** and now fails.

## Behavior changes by OS version

Most modern Access Denied cases are caused by secure-by-default changes rather than misconfiguration. Check these changes first.

| Change | Default starting in | Symptom when it applies |
|---|---|---|
| **Insecure (unauthenticated) guest access disabled** | Windows 10 1709 / Windows 11 (Pro, Enterprise, Education) / Windows Server | "…security policies block unauthenticated guest access"; SMBClient **Event ID 31017** |
| **SMB signing required (inbound and outbound)** | Windows 11 24H2 / Windows Server 2025 | Connections to devices that don't support signing are rejected |
| **SMB client NTLM blocking available; NTLM restricted** | Windows 11 24H2 | Access Denied to IP-address, workgroup, or NAS targets where Kerberos isn't available |
| **SMB authentication rate limiter** | Windows Server 2022+ | Repeated failed sign-ins are delayed (~2s), which can look like lockout or slowness |

## Identify the cause first

Run these checks on the SMB **client** to determine which condition applies:

```powershell
# What error and target?
net use
# Existing/attempted SMB sessions and dialect
Get-SmbConnection
# Client security posture (signing, guest, NTLM, encryption)
Get-SmbClientConfiguration
```

Also review **Event Viewer** > **Applications and Services Logs** > **Microsoft** > **Windows** > **SMBClient** (**Connectivity** and **Security** channels). The event ID and message point directly to the branches described in this article.

## Cause and resolution

### 1. Unauthenticated guest access is blocked (most common on modern clients)

**Applies when:** the message mentions "unauthenticated guest access," or SMBClient logs **Event ID 31017**. The server or NAS accepts guest, but Windows no longer allows guest sign-ins by default.

**Resolution:** Connect with **valid credentials** to the server or NAS instead of relying on guest access. Do **not** re-enable insecure guest logons as a fix except as a temporary, risk-accepted workaround, because it exposes the client to rogue-server and man-in-the-middle attacks. For details and the (discouraged) policy override, see [Enable insecure guest logons in SMB2 and SMB3](/windows-server/storage/file-server/enable-insecure-guest-logons-smb2-and-smb3).

### 2. SMB signing is required and the target doesn't support it

**Applies when:** the share is on a third-party server or NAS and the client is **Windows 11 24H2 / Windows Server 2025**, where signing is required by default.

**Resolution:** Enable SMB signing on the server or NAS (preferred). If the device cannot support signing, evaluate the security impact before changing the client requirement. See [Control SMB signing behavior](/windows-server/storage/file-server/smb-signing#smb-signing-behavior) and the overview in [SMB security hardening](/windows-server/storage/file-server/smb-security-hardening).

### 3. NTLM is blocked or unavailable

**Applies when:** connecting by **IP address**, to a **workgroup** device, or to a NAS where Kerberos can't be used, on clients with SMB NTLM blocking configured.

**Resolution:** Connect by the server's **Kerberos-capable name** (FQDN) rather than IP, ensure name resolution and SPNs are correct, or configure an NTLM exception list for required legacy targets. See [Block NTLM authentication over SMB](/windows-server/storage/file-server/smb-ntlm-blocking).

### 4. Repeated failures throttled by the SMB authentication rate limiter

**Applies when:** intermittent Access Denied or slow auth on **Windows Server 2022+** after multiple failed sign-in attempts.

**Resolution:** Resolve the underlying bad-credential or mapping problem. Adjust or disable the limiter only if it interferes with a legitimate high-volume scenario. See [Configure the SMB authentication rate limiter](/windows-server/storage/file-server/configure-smb-authentication-rate-limiter).

### 5. Share or NTFS permission mismatch (including Access-Based Enumeration)

**Applies when:** a specific user or group is denied while others succeed, or folders are hidden.

**Resolution:** Verify **both** Share and NTFS (Security) permissions grant the user the required access, and check Access-Based Enumeration. See [Can't access shared folders from File Explorer in Windows](/troubleshoot/windows-client/networking/cannot-access-shared-folder-file-explorer).

### 6. Missing SYNCHRONIZE access control entry (NetApp Filer / NAS edge case)

**Applies when:** access is denied through SMB2 to a folder on a **NetApp Filer** or other SMB2 server, and a network trace shows a `DesiredAccess` failure on the SMB2 **CREATE** for the folder. The target folder is missing the **SYNCHRONIZE** ACE.

**Resolution:** Use `ICACLS` to grant permissions that include the Synchronize bit:

```console
ICACLS h:\folder /grant domain\user:(RC,RD,REA,RA,X,S)
```

The rights in parentheses are: `RC` read control, `RD` read data or list directory, `REA` read extended attributes, `RA` read attributes, `X` execute or traverse, `S` synchronize.

**Verify:** Confirm the folder has the Synchronize bit set. On the folder ACL, `SYNCHRONIZE` should be listed (for example, via [AccessChk](/sysinternals/downloads/accesschk)):

```console
accesschk.exe -ld <folder>
```

See the [behavior of the SYNCHRONIZE bit on SMB2 clients](/openspecs/windows_protocols/ms-smb2/a64e55aa-1152-48e4-8206-edd96444e7f7).

## Collect data before opening a support case

If the preceding solutions don't resolve the issue, gather this data first so the support team can triage the case without back-and-forth:

```powershell
# Client posture
Get-SmbClientConfiguration | Out-File C:\SMBdata\client-config.txt
Get-SmbConnection          | Out-File C:\SMBdata\connections.txt

# Simultaneous network trace on client AND server, then reproduce
netsh trace start capture=yes scenario=NetConnection tracefile=C:\SMBdata\smb.etl
# ... reproduce the Access Denied ...
netsh trace stop
```

Also export the **SMBClient** and (on the server) **SMBServer** event logs covering the repro window.

## Related content

- [SMB security hardening](/windows-server/storage/file-server/smb-security-hardening)
- [SMB features in Windows and Windows Server](/windows-server/storage/file-server/smb-feature-descriptions)
- [Control SMB signing behavior](/windows-server/storage/file-server/smb-signing)
- [Enable insecure guest logons in SMB2 and SMB3](/windows-server/storage/file-server/enable-insecure-guest-logons-smb2-and-smb3)
- [Block NTLM authentication over SMB](/windows-server/storage/file-server/smb-ntlm-blocking)



