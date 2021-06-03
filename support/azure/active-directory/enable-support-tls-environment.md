---
title: Enable support for TLS 1.2 in your environment, in preparation for upcoming Azure AD TLS 1.0/1.1 deprecation
description: Describes how to enable support for TLS 1.2 in your environment, in preparation for upcoming Azure AD TLS 1.0/1.1 deprecation.
ms.date: 05/26/2021
ms.prod-support-area-path: 
ms.reviewer: dahans
---
# Enable support for TLS 1.2 in your environment for Azure AD TLS 1.1 and 1.0 deprecation

To improve the security posture of your tenant, and to remain in compliance with industry standards, Microsoft Azure Active directory (Azure AD) will soon stop supporting the following Transport Layer Security (TLS) protocols and ciphers:

- TLS 1.1
- TLS 1.0
- 3DES cipher suite **(TLS_RSA_WITH_3DES_EDE_CBC_SHA)**

## How this change might affect your organization

Applications that are communicating with or authenticating against Azure Active Directory might not work as expected if they are NOT able to use TLS 1.2 to communicate. This situation includes Azure AD Connect, Azure AD PowerShell, Azure AD Application Proxy connectors, PTA agents, legacy browsers, and applications that are integrated with Azure AD.

## Why this change is being made

These protocols and ciphers are being deprecated for the following reasons:

- To comply with the latest compliance standards for the [Federal Risk and Authorization Management Program (FedRAMP)](https://www.fedramp.gov/).
- To improve security when users interact with our cloud services.

The services are being deprecated on the following dates:

- **TLS 1.0**, **1.1** and **3DES Cipher suite** in U.S. government instances starting on **March 31, 2021**.
- **TLS 1.0**, **1.1** and **3DES Cipher suite** in public instances starting **June 30, 2021**.

## Enable support for TLS 1.2 in your environment

To maintain a secure connection to Azure Active Directory (Azure AD) and Microsoft 365 services, make sure that your client apps and client and server operating system (OS) are enabled for TLS 1.2 and modern cipher suites.

### Guidelines for enabling TLS 1.2 on clients

- Update Windows and the default TLS that you use for "WinHTTP".
- Identify and reduce you dependency on the client apps and operating systems that don’t support TLS 1.2.
- Enable TLS 1.2 for applications and services that communicate with Azure AD.
- Update and configure your .NET Framework installation to support TLS 1.2.
- Make sure that applications and PowerShell (that use [Azure AD Graph](https://graph.windows.net) and [Microsoft Graph](https://graph.microsoft.com)) and Azure AD PowerShell scripts are hosted and run on a platform that supports TLS 1.2.
- Make sure that your web browser has the latest updates. We recommend that you use the new Microsoft Edge browser (based on Chromium). For more information, see the [Microsoft Edge release notes for Stable Channel](/deployedge/microsoft-edge-relnote-stable-channel).
- Make sure that your web proxy supports TLS 1.2. For more information about how to update a web proxy, check with the vendor of your web proxy solution.

For more information, see the following articles:

- [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC - Microsoft 365 Compliance](/microsoft-365/compliance/prepare-tls-1.2-in-office-365)

### Update the Windows OS and the default TLS that you use for WinHTTP

Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, and later versions of Windows and Windows Server natively support TLS 1.2 for client-server communications over WinHTTP. Verify that you have not explicitly disabled TLS 1.2 on these platforms.

By default, earlier versions of Windows, such as Windows 8 and Windows Server 2012, don't enable TLS 1.2 or TLS 1.1 for secure communications by using WinHTTP. For these earlier versions of Windows, install [Update 3140245](https://support.microsoft.com/help/3140245) and enable the registry values from the "[Enable TLS 1.2 on client or server operating systems](#enable-tls-12)" section. You can configure those values to add TLS 1.2 and TLS 1.1 to the default secure protocols list for WinHTTP.

For more information, see [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client).

### Identify and reduce dependency on clients that don't support TLS 1.2

Update the following clients to provide uninterrupted access:

- Android version 4.3 and earlier versions
- Firefox version 5.0 and earlier versions
- Internet Explorer versions 8-10 on Windows 7 and earlier versions
- Internet Explorer 10 on Windows Phone 8.0
- Safari 6.0.4 on OS X 10.8.4 and earlier versions

For more information, see [Handshake Simulation for various clients connecting to www.microsoft.com, courtesy SSLLabs.com](/security/engineering/solving-tls1-problem#appendix-a-handshake-simulation).

### Enable TLS 1.2 common server roles that communicate with Azure AD

- Azure AD Connect (install the latest version)
  - If you also want to enable TLS 1.2 between the sync engine server and a remote SQL Server, make sure that you have the required versions installed for [TLS 1.2 support for Microsoft SQL Server](https://support.microsoft.com/topic/kb3135244-tls-1-2-support-for-microsoft-sql-server-e4472ef8-90a9-13c1-e4d8-44aad198cdbe)
- Azure AD Connect Authentication Agent (pass-through authentication) (version 1.5.643.0 and later versions)
- Azure Application Proxy (version 1.5.1526.0 and later versions enforce TLS 1.2)
- Active Directory Federation Services (AD FS) for servers that are configured to use Azure Multi-Factor Authentication (Azure MFA)
- NPS servers that are configured to use the NPS extension for Azure AD MFA
- MFA Server version 8.0._x_ or later versions
- Azure AD Password Protection proxy service

  **Action required**

  1. We highly recommend that you run the latest version of the agent, service, or connector.
  2. By default, TLS 1.2 is enabled on Windows Server 2012 R2 and later versions. In rare instances, the default OS configuration might have been modified to disable TLS 1.

      In order to make sure that TLS 1.2 is enabled, we recommend that you explicitly add the registry values from the "[Enable TLS 1.2 on client or server operating systems](#enable-tls-12)" section on servers that are running Windows Server and that communicate with Azure AD.

  3. Most of the previously listed services are dependent on .Net Framework. Ensure that it's updated as the following section, [Update and configure .NET Framework to support TLS 1.2](#update-configure-tls-12)

  For more information, see the following articles:
  - [TLS 1.2 enforcement - Enforce TLS 1.2 for the Azure AD Registration Service](/azure/active-directory/devices/reference-device-registration-tls-1-2)
  - [Azure AD Connect: TLS 1.2 enforcement for Azure Active Directory Connect](/azure/active-directory/hybrid/reference-connect-tls-enforcement)
  - [Understand Azure AD Application Proxy connectors](/azure/active-directory/manage-apps/application-proxy-connectors#requirements-and-deployment)

## Enable TLS 1.2 on client or server operating systems <a name="enable-tls-12"></a>

### Registry strings

Make sure that the following registry DWORD values are configured for these subkeys:

- **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client**
  - "DisabledByDefault": **00000000**
  - "Enabled": **00000001**
- **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server**
  - "DisabledByDefault": **00000000**
  - "Enabled": **00000001**
- **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft&#92;.NETFramework\v4.0.30319**
  - "SchUseStrongCrypto": **00000001**

To enable TLS 1.2, use the PowerShell script that's provided in [TLS 1.2 enforcement for Azure AD Connect](/azure/active-directory/hybrid/reference-connect-tls-enforcement).

## Update and configure .NET Framework to support TLS 1.2 <a name="update-configure-tls-12"></a>

Managed Azure AD integrated applications and Windows PowerShell scripts (using Azure AD PowerShell V1 (Microsoft MSOnline), V2 (AzureAD), [Azure AD Graph](https://graph.windows.net/), or [Microsoft graph](https://graph.microsoft.com)) may use .NET Framework.

### Install .NET updates to enable strong cryptography

#### Determine the .NET version

First, determine the installed .NET versions.

- For more information, see [Determine which versions and service pack levels of .NET Framework are installed](/dotnet/framework/determine-dotnet-versions-service-pack-levels).

#### Install .NET updates

Install the .NET updates so that you can enable strong cryptography. Some versions of .NET Framework might have to be updated to enable strong cryptography.

Use these guidelines:

- NET Framework 4.6.2 and later versions support TLS 1.2 and TLS 1.1. Check the registry settings. No other changes are required.

- Update NET Framework 4.6 and earlier versions to support TLS 1.2 and TLS 1.1.

  For more information, see [.NET Framework versions and dependencies](/dotnet/framework/migration-guide/versions-and-dependencies).
- If you're using .NET Framework 4.5.2 or 4.5.1 on Windows 8.1 or Windows Server 2012, the relevant updates and details are also available from the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=42883).

  - Also see [Microsoft Security Advisory 2960358](/security-updates/SecurityAdvisories/2015/2960358)

Set the following registry DWORD values on any computer that communicates across the network and runs a TLS 1.2-enabled system. For example, set these values on Configuration Manager clients, on remote site system roles that are not installed on the site server, and on the site server itself.

- For 32-bit applications that are running on a 32-bit OS and 64-bit applications that are running on a 64-bit OS, update the following subkey values:

  - **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft&#92;.NETFramework\v2.0.50727**
    - "SystemDefaultTlsVersions": **00000001**
    - "SchUseStrongCrypto": **00000001**
  
  - **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft&#92;.NETFramework\v4.0.30319**
    - "SystemDefaultTlsVersions": **00000001**
    - "SchUseStrongCrypto": **00000001**
- For 32-bit applications that are running on 64-bit OSs, update the following subkey values:
  - **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft&#92;.NETFramework\v2.0.50727**
    - "SystemDefaultTlsVersions": **dword:00000001**
    - "SchUseStrongCrypto": **dword:00000001**
  - **HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft&#92;.NETFramework\v4.0.30319**
    - "SystemDefaultTlsVersions": **dword:00000001**
    - "SchUseStrongCrypto": **dword:00000001**

For more information, see the following articles:

- [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Transport Layer Security (TLS) best practices with the .NET Framework](/dotnet/framework/network-programming/tls#configuring-schannel-protocols-in-the-windows-registry)
- [Solving the TLS 1.0 Problem - Security documentation](/security/engineering/solving-tls1-problem)
