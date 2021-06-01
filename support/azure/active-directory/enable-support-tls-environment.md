---
title: Enable support for TLS 1.2 in your environment, in preparation for upcoming Azure AD TLS 1.0/1.1 deprecation
description: Describes how to enable support for TLS 1.2 in your environment, in preparation for upcoming Azure AD TLS 1.0/1.1 deprecation.
ms.date: 04/30/2021
ms.prod-support-area-path: 
ms.reviewer: dahans
---
# Enable support for TLS 1.2 in your environment for Azure AD TLS 1.1 and 1.0 deprecation

We will soon remove support in Azure Active Directory for the following services:

- TLS 1.1
- TLS 1.0
- 3DES cipher suite **(TLS_RSA_WITH_3DES_EDE_CBC_SHA)**

These protocols and ciphers are being deprecated for the following reasons:

- To comply with the latest compliance standards for the [Federal Risk and Authorization Management Program (FedRAMP)](https://www.fedramp.gov/).
- To improve security when users interact with our cloud services.

The services are being deprecated on the following dates:

- **TLS 1.0**, **1.1** and **3DES Cipher suite** in U.S. government instances starting on **March 31, 2021**.
- **TLS 1.0**, **1.1** and **3DES Cipher suite** in public instances starting **June 30, 2021**.

## Enable support for TLS 1.2 in your environment

To maintain a secure connection to Azure Active Directory (Azure AD) and Microsoft 365 services, make sure that your client apps and client and server operating system (OS) are enabled for TLS 1.2 and modern cipher suites that have client-server and browser-server combinations.

### Guidelines for enabling TLS 1.2 on clients

- Update Windows and the default TLS that you use for "WinHTTP."
- Identify and reduce you dependency on the client apps and operating systems that don’t support TLS 1.2.
- Enable TLS 1.2 on common server roles that communicate with Azure AD.
- Update and configure your .NET Framework installation to support TLS 1.2.
- Ensure applications and Powershell, using [Azure AD Graph](https://graph.windows.net) and [Microsoft Graph](https://graph.microsoft.com), are hosted and run on a platform that supports TLS 1.2.
- Make sure that you use the latest updated browser. We recommend that you use the new Microsoft Edge browser (based on Google Chromium). For more information, see the [Microsoft Edge release notes for Stable Channel](/deployedge/microsoft-edge-relnote-stable-channel).
- Make sure that your web proxy supports TLS 1.2. For more information about how to update a web proxy, check with the vendor of your app proxy solution.

For more information, see the following articles:

- [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC - Microsoft 365 Compliance](/microsoft-365/compliance/prepare-tls-1.2-in-office-365)

### Native support for Windows operating systems and servers

Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, and later versions of Windows and Windows Server natively support TLS 1.2 for client-server communications over WinHTTP. Verify that you have not explicitly disabled TLS 1.2 on these platforms.

By default, earlier versions of Windows, such as Windows 7 and Windows Server 2012, don't enable TLS 1.2 or TLS 1.1 for secure communications by using WinHTTP. For these earlier versions of Windows, install [Update 3140245](https://support.microsoft.com/help/3140245) to enable the registry values from the [Enable TLS 1.2](#enable-tls-12) section. You can configure those values to add TLS 1.2 and TLS 1.1 to the default secure protocols list for WinHTTP.

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

Although TLS 1.2 is enabled by default on the supported Windows versions that are later than Windows 2012 R2, you may want to explicitly add the registry values from the "[Enable TLS 1.2"](#enable-tls-12) section on the Windows server roles that interact with Azure AD, such as the following:

- Azure AD Connect (version 1.4.38.0 and later enforce TLS 1.2)
  - If you also want to enable TLS 1.2 between the sync engine server and a remote SQL Server, make sure that you have the required versions installed for [TLS 1.2 support for Microsoft SQL Server](https://support.microsoft.com/topic/kb3135244-tls-1-2-support-for-microsoft-sql-server-e4472ef8-90a9-13c1-e4d8-44aad198cdbe)
- Azure AD Connect Authentication Agent (pass-through authentication) (version 1.5.643.0 and later versions)
- Azure Application Proxy (version 1.5.1526.0 and later versions enforce TLS 1.2)
- Active Directory Federation Services (AD FS) for servers that are configured to use Azure Multi-Factor Authentication (Azure MFA)
- NPS servers that are configured to use the NPS extension for Azure AD MFA
- MFA Server version 8.x or higher
- Azure AD Password Protection proxy service

  > [!NOTE]
  > We highly recommend that you run a recent version of the agent, service, or connector.

For more information, see the following articles:

- [TLS 1.2 enforcement - Enforce TLS 1.2 for the Azure AD Registration Service](/azure/active-directory/devices/reference-device-registration-tls-1-2)
- [Azure AD Connect: TLS 1.2 enforcement for Azure Active Directory Connect](/azure/active-directory/hybrid/reference-connect-tls-enforcement)
- [Understand Azure AD Application Proxy connectors](/azure/active-directory/manage-apps/application-proxy-connectors#requirements-and-deployment)

## Enable TLS 1.2

### Registry strings

Make sure that the following registry DWORD values are configured for these subkeys:

- **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client**

  - "DisabledByDefault": **00000000**
  - "Enabled": **00000001**
- **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server**

  - "DisabledByDefault": **00000000**
  - "Enabled": **00000001**
- **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft.NETFramework\v4.0.30319**
  - "SchUseStrongCrypto": **00000001**

To enable TLS 1.2, use the PowerShell script that's provided in [TLS 1.2 enforcement for Azure AD Connect](/azure/active-directory/hybrid/reference-connect-tls-enforcement).

### Update and configure .NET Framework to support TLS 1.2

Dependencies might include managed applications and Windows PowerShell scripts (by using Azure AD PowerShell V1 (Microsoft Online), V2 (Azure Active Directory), or [Microsoft graph](https://graph.microsoft.com)) by using .NET Framework.

#### Install .NET updates to enable strong cryptography

Some versions of .NET Framework might have to be updated in order to enable strong cryptography.

Use these guidelines:

- NET Framework 4.6.2 and later versions support TLS 1.2 and TLS 1.1. You should verify the registry settings. However, no additional changes are required.

- Update NET Framework 4.6 and earlier versions to support TLS 1.2 and TLS 1.1.

  For more information, see [.NET Framework versions and dependencies](/dotnet/framework/migration-guide/versions-and-dependencies).

- If you're using .NET Framework 4.5.2 or 4.5.1 on Windows 8.1 or Windows Server 2012, the relevant updates and details are also available from the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=42883).

  - Also see [Microsoft Security Advisory 2960358](/security-updates/SecurityAdvisories/2015/2960358)

Set the following registry DWORD values on any computer that communicates across the network and runs a TLS 1.2-enabled system. For example, set these values on Configuration Manager clients, on remote site system roles that are not installed on the site server, and on the site server itself.

- For 32-bit applications that are running on a 32-bit OS and 64-bit applications that are running on a 64-bit OS, update the following subkey values:

  - **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727**

    - "SystemDefaultTlsVersions": **00000001**
    - "SchUseStrongCrypto": **00000001**
  
  - **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319**

    - "SystemDefaultTlsVersions": **00000001**
    - "SchUseStrongCrypto": **00000001**

For more information, see the following articles:

- [How to enable TLS 1.2 on clients](/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Solving the TLS 1.0 Problem - Security documentation](/security/engineering/solving-tls1-problem)
- [TLS 1.0/1.1 Deprecation Report](https://servicetrust.microsoft.com/AdminPage/TlsDeprecationReport/Download) (This report shows you some dependencies on older TLS protocols. The site might require you to sign in.)
