---
title: Troubleshooting the SSL_PE_NO_CIPHER error
description: This article helps you to resolve the SSL_PE_NO_CIPHER error that occurs on endpoint 5022.
ms.date: 03/08/2024
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# The SSL_PE_NO_CIPHER error occurs on endpoint 5022

This article helps you resolve the error related to the `SSL_PE_NO_CIPHER`. It also provides scripts for enforcing Transport Layer Security (TLS) on different versions of .NET Framework.

## Symptoms

The Security Socket Layer (SSL) "SSL_PE_NO_CIPHER" error occurs on endpoint port 5022, and there is a time delay longer than 15 seconds, potentially leading to timeouts. It occurs when the SSL handshake fails due to a lack of compatible cipher suites between the client and server. This can happen if outdated or weak encryption algorithms are used.

## Resolution

To resolve this error, follow these steps:

1. Update SSL or TLS libraries.
   Make sure that both the client and server have up-to-date SSL or TLS libraries installed. Outdated versions might not support modern and secure cipher suites.

1. Check Cipher Suite configurations on both the client and server.
   Make sure that modern and secure cipher suites are allowed. Consider disabling outdated or weak cipher suites.

1. Verify SSL or TLS protocol versions.
   Confirm that both the client and server support the same SSL or TLS protocol versions. Outdated protocol versions might not be compatible with certain cipher suites. If TLS 1.2 isn't present on the servers, run the following script to enforce TLS 1.2 on .NET Framework:

    ```powershell
    # .NET Framework v2.0.50727 
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" -Force | Out-Null 
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" -Name "AspNetEnforceViewStateMac" -Value 1 
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" -Name "SystemDefaultTlsVersions" -Value 1 
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" -Name "SchUseStrongCrypto" -Value 1
    ```

    ```powershell
    # .NET Framework v4.0.30319 
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Force | Out-Null 
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "AspNetEnforceViewStateMac" -Value 1 
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SystemDefaultTlsVersions" -Value 1 
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Value 1
    ```

    ```powershell
    # Wow6432Node\Microsoft\.NETFramework\v2.0.50727 
    New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727" -Name "AspNetEnforceViewStateMac" -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727" -Name "SystemDefaultTlsVersions" -Value 1
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727" -Name "SchUseStrongCrypto" -Value 1
   ```

   ```powershell
   # Wow6432Node\Microsoft\.NETFramework\v4.0.30319 
   New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Force | Out-Null
   Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "AspNetEnforceViewStateMac" -Value 1
   Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SystemDefaultTlsVersions" -Value 1
   Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319" -Name "SchUseStrongCrypto" -Value 1
   ```

   ```powershell
   # WinHTTP
   New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" -Force | Out-Null
   Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" -Name "DefaultSecureProtocols" -Value 0x00000800
   ```

   ```powershell
   # Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp 
   New-Item -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet  Settings\WinHttp" -Force | Out-Null
   Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp" -Name "DefaultSecureProtocols" -Value 0x00000800
   ```

1. Enable TLS by running the following script:

     ```powershell
    # Enable TLS 1.2
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" -Name "DisabledByDefault" -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" -Name "Enabled" -Value 1
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" -Name "DisabledByDefault" -Value 0
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" -Name "Enabled" -Value 1
    ```

1. Disable TLS by running the following script:

    ```powershell
    # Disable TLS 1.1 
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "DisabledByDefault" -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "Enabled" -Value 0
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Force | Out-Null
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "DisabledByDefault" -Value 1
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "Enabled" -Value 0
    # Disable TLS 1.0 
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Force | Out-Null 
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "DisabledByDefault" -Value 1 
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "Enabled" -Value 0 
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Force | Out-Null 
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "DisabledByDefault" -Va. ue 1 
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "Enabled" -Value 0
    ```

1. Check system time and date.
   Accurate system time and date are essential for SSL certificate validation. Verify that the system time and date are correct on both the client and server.

1. Verify certificates.
   Make sure that the SSL certificate installed on the server is valid and hasn't expired. Check if the client can successfully validate the server's certificate.

1. Check the firewall and proxy settings.
   Verify that the required ports are open and that no firewall or proxy settings are blocking the SSL handshake.  

1. Run the script as an administrator on both the client and server computers.  

1. Reboot the servers after running the script.

   After completing these steps, the "SSL_PE_NO_CIPHER" error should be resolved.

> [!NOTE]
> Microsoft recommends you to back up the Windows registry.

## See also

[An existing connection was forcibly closed by the remote host (OS error 10054)](tls-exist-connection-closed.md)
