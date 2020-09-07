---
title: Error (The app couldn't be downloaded) when installing add-ins using Microsoft Store on Exchange Server 2016
description: Provides a solution to an issue in which you can't install add-ins using Microsoft Store on Exchange Server 2016
author: TobyTu
ms.author: cmcgurk
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 122584
ms.reviewer: cmcgurk
appliesto:
- Exchange Server 2016
- Exchange Server 2013
search.appverid: MET150
---

# Error when installing add-ins using Microsoft Store on Exchange Server 2016: The app couldn't be downloaded

## Symptoms

When installing add-ins through Microsoft Store for mailboxes hosted on Microsoft Exchange Server 2016, you receive this error message:

> "The app couldn't be downloaded" 

## Cause

The TLS 1.2 Client functionality is disabled for the connection from Exchange servers to Microsoft Store (https://appsource.microsoft.com).  

To verify this is the case, run this PowerShell command as an administrator on the Exchange servers:

```powershell
Invoke-WebRequest https://appsource.microsoft.com
```

You should receive this error message:

> "Invoke-WebRequest : The underlying connection was closed: An unexpected error occurred on a send."  

## Resolution

### Enable TLS 1.2 for Schannel - All Windows Server versions

TLS protocols can be enabled or disabled in Windows Schannel by editing the Windows Registry. Each protocol version can be enabled or disabled independently. You don't need to enable or disable one protocol version to enable or disable another protocol version. The **Enabled** DWORD registry value defines whether the protocol version can be used. 

- If the value is set to 0, the protocol version can't be used, even if enabled by default or if the application explicitly requests that protocol version. 
- If the value is set to 1, the protocol version can be used if enabled by default or if the application explicitly requests that protocol version. 
- If the value isn't defined, the operating system's default value will be used. 

We recommend configuring the value consistently across your servers.

The **DisabledByDefault** DWORD registry value defines whether the protocol version is used by default. This setting only applies when the application doesn't explicitly request the protocol versions to be used. 

- If the value is set to 0, the protocol version will be available by default. 
- If the value is set to 1, the protocol version won't be available by default. 
- If the value isn't defined, the operating system's default value will be used. 

We recommend configuring the value consistently across your servers. 

For example, if TLS 1.2's values are both set to 1 in a combination of **Enabled** and **DisabledByDefault**, applications can only use TLS 1.2 if they call specifically for TLS 1.2. If the application didn't specifically call for TLS 1.2, it won't be able to use TLS 1.2. The protocol is enabled, but isn't in the default list of available protocols. 

Here's how to enable TLS 1.2 for both server (inbound) and client (outbound) connections on an Exchange Server:

- Open Notepad.exe and create a text file named TLS12-Enable.reg.
- Copy and paste this text in the file:

    ```
    Windows Registry Editor Version 5.00
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client]
    "DisabledByDefault"=dword:00000000
    "Enabled"=dword:00000001
    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server]
    "DisabledByDefault"=dword:00000000
    "Enabled"=dword:00000001
    ```

- Save TLS12-Enable.reg.
- Double-click the TLS12-Enable.reg file.
- Select **Yes** to update your Windows Registry.
- Restart the machine for the change to take effect.

### Enable TLS 1.2 for .NET 4.x

This step is only required for Exchange Server 2013 or later installations relying on .NET 4.x. The SystemDefaultTlsVersions registry value defines which security protocol version defaults will be used by .NET Framework 4.x. If the value is set to 1, .NET Framework 4.x will inherit its defaults from the Windows Schannel DisabledByDefault registry values. Undefined values will behave as if the value was set to 0. Configuring .NET Framework 4.x to inherit its values from Schannel enables you to use the latest versions of TLS supported by the OS, including TLS 1.2.

- Open Notepad.exe and create a text file named NET4X-UseSchannelDefaults.reg.
- Copy and paste this text:

    ```
    Windows Registry Editor Version 5.00
    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319]
    "SystemDefaultTlsVersions"=dword:00000001
    [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319]
    "SystemDefaultTlsVersions"=dword:00000001
    ```

- Save the NET4X-UseSchannelDefaults.reg file.
- Double-click the NET4X-UseSchannelDefaults.reg file.
- Select **Yes** to update your Windows Registry.
- Restart your computer for the change to take effect.

> [!NOTE]
> To reboot the server only once when configuring a system for TLS 1.2, make the Schannel and .NET registry keys at the same time. 

## More information

For more information about enabling TLS 1.2, read [this blog](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-2-enabling-tls-1-2-and/ba-p/607761). 
