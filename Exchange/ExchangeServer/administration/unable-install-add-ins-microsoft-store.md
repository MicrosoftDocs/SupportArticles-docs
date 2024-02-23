---
title: Error (The app couldn't be downloaded) when you install add-ins using Microsoft Store on Exchange Server 2016
description: Provides a solution to an issue in which you can't install add-ins using Microsoft Store on Exchange Server 2016
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
  - CI 122584
ms.reviewer: cmcgurk, v-six
appliesto: 
  - Exchange Server 2016
  - Exchange Server 2013
search.appverid: MET150
ms.date: 01/24/2024
---

# Error when you install add-ins by using Microsoft Store on Exchange Server 2016: The app couldn't be downloaded

## Symptoms

When you install add-ins through Microsoft Store for mailboxes that are hosted on Microsoft Exchange Server 2016, you receive the following error message:

> The app couldn't be downloaded

## Cause

The TLS 1.2 Client functionality is disabled for the connection from Exchange Server-based computers to [Microsoft Store](https://appsource.microsoft.com).

To verify that this condition applies to your situation, run the following PowerShell command as an administrator on the servers that run Exchange Server:

```powershell
Invoke-WebRequest https://appsource.microsoft.com
```

You should receive the following error message:

> "Invoke-WebRequest : The underlying connection was closed: An unexpected error occurred on a send."  

## Resolution

### Enable TLS 1.2 for Schannel - All Windows Server versions

TLS protocols can be enabled or disabled in Windows Schannel by editing the Windows Registry. Each protocol version can be enabled or disabled independently. You don't have to enable or disable one protocol version in order to enable or disable another protocol version. The **Enabled** DWORD registry value defines whether the protocol version can be used.

- If the value is set to **0**, the protocol version can't be used, even if it's enabled by default or if the application explicitly requests that protocol version.
- If the value is set to **1**, the protocol version can be used if it's enabled by default or if the application explicitly requests that protocol version.
- If the value isn't defined, the operating system's default value is used.

We recommend that you configure the value consistently across your servers.

The **DisabledByDefault** DWORD registry value defines whether the protocol version is used by default. This setting applies only if the application doesn't explicitly request the protocol versions that are to be used.

- If the value is set to **0**, the protocol version is available by default.
- If the value is set to **1**, the protocol version isn't available by default.
- If the value isn't defined, the operating system's default value is used.

We recommend that you configure the value consistently across your servers.

For example, if the TLS 1.2 values are both set to **1** in a combination of **Enabled** and **DisabledByDefault**, applications can only use TLS 1.2 if they call specifically for TLS 1.2. If the application doesn't specifically call for TLS 1.2, it can't use TLS 1.2. In this case, the protocol is enabled, but it isn't in the default list of available protocols.

Here's how to enable TLS 1.2 for both server (inbound) and client (outbound) connections on a server that runs Exchange Server:

- Start Notepad, and create a text file that's named TLS12-Enable.reg.
- Copy and paste the following text to the new file:

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
- Select **Yes** to update the Windows registry.
- Restart the computer for the change to take effect.

### Enable TLS 1.2 for .NET 4.*x*

This step is required only for Microsoft Exchange Server 2013 or later installations that rely on .NET 4.*x*. The SystemDefaultTlsVersions registry value defines which security protocol version defaults are used by .NET Framework 4.*x*. If the value is set to **1**, .NET Framework 4.*x* inherits its defaults from the Windows Schannel DisabledByDefault registry values. Undefined values behave as if the value is set to **0**. Because you configure .NET Framework 4.*x* to inherit its values from Schannel, you are enabled to use the latest versions of TLS supported by the OS, including TLS 1.2.

- Start Notepad, and create a text file that's named NET4X-UseSchannelDefaults.reg.
- Copy and paste the following text to the new file:

    ```
    Windows Registry Editor Version 5.00
    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319]
    "SystemDefaultTlsVersions"=dword:00000001
    [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319]
    "SystemDefaultTlsVersions"=dword:00000001
    ```

- Save the NET4X-UseSchannelDefaults.reg file.
- Double-click the NET4X-UseSchannelDefaults.reg file.
- Select **Yes** to update the Windows registry.
- Restart your computer for the change to take effect.

> [!NOTE]
> To avoid multiple restarts when you configure a system for TLS 1.2, create the Schannel and .NET registry entries at the same time.

## More information

For more information about how to enable TLS 1.2, see [this Exchange Team Blog article](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-server-tls-guidance-part-2-enabling-tls-1-2-and/ba-p/607761).
