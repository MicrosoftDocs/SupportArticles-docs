---
title: Enable support for TLS 1.2 in your environment, in preparation for upcoming Azure AD TLS 1.0/1.1 deprecation
description: Describes how to enable support for TLS 1.2 in your environment, in preparation for upcoming Azure AD TLS 1.0/1.1 deprecation.
ms.date: 03/05/2021
ms.prod-support-area-path: 
ms.reviewer: dahans
---
# Enable support for TLS 1.2 in your environment, in preparation for upcoming Azure AD TLS 1.0/1.1 deprecation

In the near future, Azure Active Directory will remove support for the following services:

- TLS 1.0
- TLS 1.1
- 3DES cipher suite **(TLS_RSA_WITH_3DES_EDE_CBC_SHA)**

These services are being deprecated for the following reasons:

- To comply with the latest compliance standards for the [Federal Risk and Authorization Management Program (FedRAMP)](https://www.fedramp.gov/).
- To improve security posture when customer interact with our cloud services.
- Identity customers are asking to meet their compliance obligations to their customers.
- To stay aligned with **Office 365**. Office 365 has started deprecation of **Transport Layer Security (TLS) versions 1.1** and **1.0** for its services.

The services are being deprecated on the following dates:

- **TLS 1.0**, **1.1** and **3 DES Cipher suite** in US Gov instances starting **March 31st, 2020**.
- **TLS 1.0**, **1.1** and **3 DES Cipher suite** in Public instances starting **June 30th, 2021**.

## Enable support for TLS 1.2 in your environment

Use **TLS 1.2** and modern cipher suites with client-server and browser-server combination for maintaining a secure connection to **Azure Active Directory** (Azure AD), **Office 365** and **Microsoft 365** services.

Ensure your client apps, client operating system (OS) and servers are enabled for **TLS 1.2**.

### Steps to enable TLS 1.2 on clients

1. Update the **Windows OS** and default TLS used for **WinHTTP**.
2. Identify and reduce dependency on clients app that don’t support **TLS 1.2**.
3. Enable **TLS 1.2** on popular server roles communicating with **Azure AD**.
4. Update and configure the **.NET Framework** to support **TLS 1.2**.
5. Ensure you use the latest updated browser. Microsoft recommends the use of the new Edge browser (based on Chromium)  [Microsoft Edge release notes for Stable Channel](https://docs.microsoft.com/deployedge/microsoft-edge-relnote-stable-channel).
6. Ensure your web proxy supports **TLS 1.2**. Check with your vendor for additional information on how to update a web proxy.

For more information, see the following articles:

- [How to enable TLS 1.2 on clients](https://docs.microsoft.com/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Preparing for TLS 1.2 in Office 365 and Office 365 GCC - Microsoft 365 Compliance](https://docs.microsoft.com/microsoft-365/compliance/prepare-tls-1.2-in-office-365)

### Native support for Windows operating systems and servers

**Windows 8.1**, **Windows Server 2012 R2**, **Windows 10**, **Windows Server 2016**, and later versions of Windows natively support **TLS 1.2** for client-server communications over **WinHTTP**.

Earlier versions of Windows, such as **Windows 7** or **Windows Server 2012**, don't enable **TLS 1.1** or **TLS 1.2** by default for secure communications using **WinHTTP**.

For these earlier versions of Windows, install [Update 3140245](https://support.microsoft.com/help/3140245) to enable the following registry values, which can be set to add **TLS 1.1** and **TLS 1.2** to the default secure protocols list for **WinHTTP**.

For more information, see [How to enable TLS 1.2 on clients](https://docs.microsoft.com/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)

### Identify and reduce dependency on the following clients that are known to be unable to support TLS 1.2

Update your clients to ensure uninterrupted access:

- **Android version 4.3** and earlier.
- **Firefox version 5.0** and earlier.
- **Internet Explorer versions 8-10** on Windows 7 and earlier.
- **Internet Explorer 10** on Windows Phone 8.0.
- **Safari version 6.0.4** on OS X 10.8.4 and earlier.

For more information, see [Handshake Simulation for various clients connecting to www.microsoft.com, courtesy SSLLabs.com](https://docs.microsoft.com/security/engineering/solving-tls1-problem#appendix-a-handshake-simulation)

### Enable TLS 1.2 popular server roles communicating with Azure AD

While **TLS 1.2** is enabled by default on the supported Windows versions, you may want to explicitly add the following registry on the few Windows server roles interacting with Azure AD, including the following roles:

- Azure AD Connect
- Azure AD Connect Authentication Agent (Pass-through authentication)
- Azure Application Proxy
- Active Directory Federation Services (ADFS) servers configured to use Azure Multi-Factor Authentication (Azure MFA)
- Net Promoter Score (NPS) servers configured to use NPS extension for Azure AD MFA

Also ensure that you are running a recent version of the agent, service, or connector.

For more information, see:

- [TLS 1.2 enforcement - Azure Active Directory Registration Service](https://docs.microsoft.com/azure/active-directory/devices/reference-device-registration-tls-1-2)
- [Azure AD Connect: TLS 1.2 enforcement for Azure Active Directory Connect](https://docs.microsoft.com/azure/active-directory/hybrid/reference-connect-tls-enforcement)
- [Understand Azure AD Application Proxy connectors](https://docs.microsoft.com/azure/active-directory/manage-apps/application-proxy-connectors#requirements-and-deployment)

## Enable TLS 1.2

### Registry strings

Ensure that the following registry strings are configured as shown:

- **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client**

  - "DisabledByDefault"=dword:00000000
  - "Enabled"=dword:00000001
- **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server**

  - "DisabledByDefault"=dword:00000000
  - "Enabled"=dword:00000001
- **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft.NETFramework\v4.0.30319**
  - "SchUseStrongCrypto"=dword:00000001

You can use the **PowerShell script** to enable TLS 1.2.

For more information, see [TLS 1.2 enforcement for Azure AD Connect](https://docs.microsoft.com/azure/active-directory/hybrid/reference-connect-tls-enforcement).

### Update and configure the .NET Framework to support TLS 1.2

Dependencies may include managed applications and Windows PowerShell scripts using **.NET framework**.

#### Install .NET updates to enable strong cryptography

Some versions of **.NET Framework** might require updates to enable strong cryptography.

Use these guidelines:

- **NET Framework 4.6.2** and later supports TLS 1.1 and TLS 1.2. Confirm the registry settings, but no additional changes are required.

- Update **NET Framework 4.6** and earlier versions to support TLS 1.1 and TLS 1.2.

  For more information, see [.NET Framework versions and dependencies](https://docs.microsoft.com/dotnet/framework/migration-guide/versions-and-dependencies).

- If you're using **.NET Framework 4.5.1** or **4.5.2** on Windows 8.1 or Windows Server 2012, the relevant updates and details are also available from the [Download Center](https://www.microsoft.com/download/details.aspx?id=42883).

Set the following registry keys on any computer that communicates across the network with a TLS 1.2-enabled system.

For example, **Configuration Manager** clients, remote site system roles not installed on the site server, and the site server itself.

- For 32-bit applications that are running on **32-bit OSs** and for 64-bit applications that are running on **64-bit OSs**, update the following subkey values:

  - **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v2.0.50727**

    - "SystemDefaultTlsVersions" = dword:00000001
    - "SchUseStrongCrypto" = dword:00000001
  
  - **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0.30319**

    - "SystemDefaultTlsVersions" = dword:00000001
    - "SchUseStrongCrypto" = dword:00000001

For more information, see the following articles:

- [How to enable TLS 1.2 on clients](https://docs.microsoft.com/mem/configmgr/core/plan-design/security/enable-tls-1-2-client)
- [Solving the TLS 1.0 Problem - Security documentation](https://docs.microsoft.com/security/engineering/solving-tls1-problem)

- [TLS 1.0/1.1 Deprecation Report](https://servicetrust.microsoft.com/AdminPage/TlsDeprecationReport/Download) - This report shows you some dependencies on older TLS protocols.
