---
title: Guest access in SMB2 and SMB3 is disabled
description: Guest access in SMB2 disabled by default in Windows 10, Windows Server 2019.
ms.date: 07/30/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:access-to-remote-file-shares-smb-or-dfs-namespace, csstroubleshoot
ms.technology: networking
---
# Guest access in SMB2 and SMB3 disabled by default in Windows

This article describes information about Windows disabling guest access in SMB2 and SMB3 by default, and provides settings to enable insecure guest logons in Group Policy. However, this is generally not recommended.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019  
_Original KB number:_ &nbsp; 4046019

## Symptoms

Starting in Windows 10, version 1709 and Windows Server 2019, SMB2 and SMB3 clients no longer allow the following actions by default:

- Guest account access to a remote server.
- Fall back to the Guest account after invalid credentials are provided.

SMB2 and SMB3 has the following behavior in these versions of Windows:

- Windows 10 Enterprise and Windows 10 Education no longer allow a user to connect to a remote share by using guest credentials by default, even if the remote server requests guest credentials.
- Windows Server 2019 Datacenter and Standard editions no longer allow a user to connect to a remote share by using guest credentials by default, even if the remote server requests guest credentials.
- Windows 10 Home and Pro are unchanged from their previous default behavior; they allow guest authentication by default.

> [!NOTE]
> This Windows 10 behavior occurs in Windows 10 1709, Windows 10 1803, Windows 10 1903, Windows 10 1909 as well as Windows 10 2004, Windows 10 20H2, & Windows 10 21H1 as long as [KB5003173](https://support.microsoft.com/topic/may-11-2021-kb5003173-os-builds-19041-985-19042-985-and-19043-985-2824ace2-eabe-4c3c-8a49-06e249f52527) is installed. This default behavior was previously implemented in Windows 10 1709 but later regressed in Windows 10 2004, Windows 10 20H2, and Windows 10 21H1 where guest auth was not disabled by default but could still be disabled by an administrator. See below for details on ensuring that guest authentication is disabled.

If you try to connect to devices that request credentials of a guest instead of appropriate authenticated principals, you may receive the following error message:

> You can't access this shared folder because your organization's security policies block unauthenticated guest access. These policies help protect your PC from unsafe or malicious devices on the network.

Also, if a remote server tries to force you to use guest access, or if an administrator enables guest access, the following entries are logged in the SMB Client event log:

### Log entry 1

```output
Log Name: Microsoft-Windows-SmbClient/Security  
Source: Microsoft-Windows-SMBClient  
Date: Date/Time  
Event ID: 31017  
Task Category: None  
Level: Error  
Keywords: (128)  
User: NETWORK SERVICE  
Computer: ServerName.contoso.com  
Description: Rejected an insecure guest logon.  
User name: Ned  
Server name: ServerName
```

#### Guidance

This event indicates that the server tried to log on the user as an unauthenticated guest but was denied by the client. Guest logons do not support standard security features such as signing and encryption. So, guest logons are vulnerable to man-in-the-middle attacks that can expose sensitive data on the network. Windows disables **insecure** (nonsecure) guest logons by default. We recommend that you don't enable insecure guest logons.

### Log entry 2

```output
Log Name: Microsoft-Windows-SmbClient/Security  
Source: Microsoft-Windows-SMBClient  
Date: Date/Time  
Event ID: 31018  
Task Category: None  
Level: Warning  
Keywords: (128)  
User: NETWORK SERVICE  
Computer: ServerName.contoso.com  
Description: The AllowInsecureGuestAuth registry value is not configured with default settings.
```

Default registry value:  
`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters] "AllowInsecureGuestAuth"=dword:0`

Configured registry value:  
`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters] "AllowInsecureGuestAuth"=dword:1`

#### Guidance

This event indicates that an administrator has enabled insecure guest logons. An insecure guest logon occurs when a server logs on the user as an unauthenticated guest. It typically occurs in response to an authentication failure. Guest logons do not support standard security features, such as signing and encryption. So, allowing guest logons makes the client vulnerable to man-in-the-middle attacks that can expose sensitive data on the network. Windows disables insecure guest logons by default. We recommend that you don't enable insecure guest logons.

## Cause

This change in default behavior is by design and is recommended by Microsoft for security.

A malicious computer that impersonates a legitimate file server could allow users to connect as guests without their knowledge. We recommend that you don't change this default setting. If a remote device is configured to use guest credentials, an administrator should disable guest access to that remote device and configure correct authentication and authorization.

Windows and Windows Server have not enabled guest access or allowed remote users to connect as guest or anonymous users since Windows 2000. Only third-party remote devices might require guest access by default. Microsoft-provided operating systems do not.

## Resolution

If you want to enable insecure guest access, you can configure the following Group Policy settings:

1. Open the **Local Group Policy Editor** (gpedit.msc).
2. In the console tree, select **Computer Configuration** > **Administrative Templates** > **Network** > **Lanman Workstation**.
3. For the setting, right-click **Enable insecure guest logons** and select **Edit**.
4. Select **Enabled** and select **OK**.

> [!NOTE]
> If modifying Active Directory domain-based group policy, use **Group Policy Management** (gpmc.msc).

For monitoring and inventory purposes: this group policy is setting the following DWORD registry value to 1 (insecure guest auth enabled) or 0 (insecure guest auth disabled):

`HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\LanmanWorkstation\`  
`AllowInsecureGuestAuth`

To set the value without using group policy, set the following following DWORD registry value to 1 (insecure guest auth enabled) or 0 (insecure guest auth disabled):

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters`  
`AllowInsecureGuestAuth`

> [!NOTE]
> As usual, the value setting in group policy will override the value setting in the non-group policy registry value.

On Windows 10 1709, Windows 10 1803, Windows 10 1903, Windows 10 1909, and Windows Server 2019, guest authentication is disabled if AllowInsecureGuestAuth exists with a value of 0 in `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters] AllowInsecureGuestAuth`.

On Windows 10 2004, Windows 10 20H2, and Windows 10 21H1 Enterprise and Education editions with KB5003173 installed, guest authentication is disabled if AllowInsecureGuestAuth does not exist or if it exists with a value of 0 in `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters] AllowInsecureGuestAuth`. Home and Pro editions allow guest authentication by default unless you disable it using group policy or registry settings.

> [!NOTE]
> By enabling insecure guest logons, this setting reduces the security of Windows clients.

## More information

This setting has no effect on SMB1 behavior. SMB1 continues to use guest access and guest fallback.

> [!NOTE]
> SMB1 is uninstalled by default in latest Windows 10 and Windows Server configurations. For more information, see [SMBv1 is not installed by default in Windows 10 version 1709, Windows Server version 1709 and later versions](/windows-server/storage/file-server/troubleshoot/smbv1-not-installed-by-default-in-windows).
