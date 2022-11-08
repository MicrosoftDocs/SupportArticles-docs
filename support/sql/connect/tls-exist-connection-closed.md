---
title: An existing connection was forcibly closed
description: Describes scenarios in which an existing connection was forcibly closed by the remote host and provides resolutions for these scenarios
ms.date: 11/14/2021
ms.custom: sap:Connection issues
author: HaiyingYu
ms.author: haiyingyu
ms.prod: sql
---
# An existing connection was forcibly closed by the remote host

_Applies to:_ &nbsp; SQL Server

> [!NOTE]
> Before you start troubleshooting, we recommend that you check the [prerequisites](resolve-connectivity-errors-checklist.md) and go through the checklist.

This article details various causes and provides resolutions for the following errors:

- > A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - An existing connection was forcibly closed by the remote host.)
- > A connection was successfully established with the server, but then an error occurred during the pre-login handshake. (provider: TCP Provider, error: 0 - An existing connection was forcibly closed by the remote host.)

## When do you see the error?

Secure Channel, also known as [Schannel](/windows/win32/com/schannel), is a [Security Support Provider](/windows/win32/rpc/security-support-providers-ssps-) (SSP). It contains a set of security protocols that provide identity authentication and secure, private communication through encryption. One function of Schannel SSP is to implement different versions of the [Transport Layer Security (TLS) protocol](/windows-server/security/tls/transport-layer-security-protocol). This protocol is an industry standard that is designed to protect the privacy of information communicated over the Internet.

The TLS Handshake Protocol is responsible for the key exchange necessary to establish or resume secure sessions between two applications communicating over TCP. During the pre-login phase of the connection process, SQL Server and client applications use the TLS protocol to establish a secure channel for transmitting credentials.

The following scenarios detail errors that occur when the handshake can't be completed:

## Scenario 1: No matching TLS protocols exist between the client and the server

SSL and versions of TLS earlier than TLS 1.2 have several known vulnerabilities. You're encouraged to upgrade to TLS 1.2 and disable earlier versions wherever possible. Accordingly, system administrators could push out updates through group policy or other mechanisms to disable these insecure TLS versions on various computers within your environment.

Connectivity errors occur when your application uses an earlier version of Open Database Connectivity (ODBC) driver, OLE DB provider, .NET framework components, or a SQL Server version that doesn't support TLS 1.2. The issue occurs because the server and the client can't find a matching protocol (such as TLS 1.0 or TLS 1.1). A matching protocol is needed to complete the TLS handshake required to proceed with the connection.

### Resolution

To resolve this issue, use one of the following methods:

- Upgrade your SQL Server or your client providers to a version that supports TLS 1.2. For more information, see [TLS 1.2 support for Microsoft SQL Server](https://support.microsoft.com/topic/kb3135244-tls-1-2-support-for-microsoft-sql-server-e4472ef8-90a9-13c1-e4d8-44aad198cdbe).
- Ask your system administrators to temporarily enable TLS 1.0 or TLS 1.1 on both the client and the server computers by performing one of the following actions:
  - Use the [IIS Crypto](https://www.nartac.com/Products/IISCrypto/) tool (Ciphers suites section) to validate and make changes to the current TLS settings.
  - Start Registry Editor, and locate the Schannel-specific registry keys: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL`.  
      For more information, see [TLS 1.2 Upgrade Workflow](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0700-TLS-1.2-Upgrade-Workflow) and [SSL Errors after Upgrading to TLS 1.2](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0710-SSL-Errors-after-Upgrading-to-TLS-1.2).

## Scenario 2: Matching TLS protocols on the client and the server, but no matching TLS cipher suites

This scenario occurs when you or your administrator restricted certain algorithms on the client or the server for extra security.

The client and server TLS versions, [cipher suites](/windows/win32/secauthn/cipher-suites-in-schannel) can be easily examined in the **Client Hello** and **Server Hello** packets in a network trace. The **Client Hello** packet advertises all the client cipher suites, while the **Server Hello** packet specifies one of them. If there are no matching suites, the server will close the connection instead of responding to the **Server Hello** packet.

### Resolution

To check the issue, follow these steps:

1. If a network trace isn't available, check the functions value under this registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002`

   Use this PowerShell command to find the TLS functions
  
   ```Powershell
   Get-ItemPropertyValue  -Path HKLM:\System\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002\ -Name Functions
   ```

1. Use a tool such as IIS Crypto (Ciphers suites section) to check whether there are any matching algorithms. If no matching algorithms are found, contact Microsoft support.

For more information, see [TLS 1.2 Upgrade Workflow](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0700-TLS-1.2-Upgrade-Workflow) and [Transport Layer Security (TLS) connections might fail or timeout when connecting or attempting a resumption](https://support.microsoft.com/topic/transport-layer-security-tls-connections-might-fail-or-timeout-when-connecting-or-attempting-a-resumption-326bd5b1-52a1-b367-8179-b154e5c01e90).

## Scenario 3: SQL Server uses a certificate signed by a weak-hash algorithm, such as MD5, SHA224, or SHA512

SQL Server always encrypts network packets that are related to sign in. For this purpose, it uses a manually provisioned certificate or a [self-signed certificate](/dotnet/core/additional-tools/self-signed-certificates-guide). If SQL Server finds a certificate that supports the server authentication function in the certificate store, it will use the certificate. SQL Server will use this certificate even if it hasn't been manually provisioned. If these certificates use a weak-hash algorithm (thumbprint algorithm) such as [MD5](/dotnet/api/system.security.cryptography.md5), SHA224, or SHA512, they won't work with TLS 1.2 and cause the previously mentioned error.

> [!NOTE]
> Self-signed certificates are not affected by this issue.

### Resolution

To resolve the issue, follow these steps:

1. In [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager), expand **SQL Server Network Configuration** in the **Console** pane.
1. Select Protocols for \<instance name\>.
1. Select the **Certificate** tab and follow the relevant step:
    - If a certificate is displayed, select  **View** to examine the Thumbprint algorithm to confirm whether it's using a weak-hash algorithm. Then, select  **Clear**  and go to step 4.
    - If a certificate isn't displayed, review the SQL Server error log for an entry that resembles the following and note down the hash/thumbprint value:  
    `2017-05-30 14:59:30.89 spid15s The certificate [Cert Hash(sha1) "B3029394BB92AA8EDA0B8E37BAD09345B4992E3D"] was successfully loaded for encryption`
1. Use the following steps to remove server authentication:
    1. Select **Start** > **Run**, and type *MMC*. (MMC also known as the Microsoft Management Console.)
    1. In MMC, open the certificates and select **Computer Account** in the **Certificates** snap-in screen.
    1. Expand **Personal** > **Certificates**.
    1. Locate the certificate that SQL Server is using by its name or by examining the Thumbprint value of different certificates in the certificate store and open its **Properties** pane.
    1. On the **General** tab, select **Enable only the following purposes** and deselect **Server Authentication**.
1. Restart the SQL Server service.

## Scenario 4: The client and the server are using TLS_DHE cipher suite for TLS handshake, but one of the systems doesn't have leading zero fixes for the TLS_DHE installed

For more information about this scenario, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](../../windows-server/identity/apps-forcibly-closed-tls-connection-errors.md).

> [!NOTE]
> If this article has not resolved your issue, you can check if the [common connectivity issues articles](resolve-connectivity-errors-overview.md#common-connectivity-issues) can help.

## See also

- [Troubleshoot connectivity issues in SQL Server](resolve-connectivity-errors-overview.md)

- [Error for SSIS packages on SQL servers configured to use encryption and network packet size](/troubleshoot/sql/integration-services/use-encryption-network-packet-size)

- [Recommended prerequisites and checklist for troubleshooting connectivity issues](resolve-connectivity-errors-checklist.md)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
