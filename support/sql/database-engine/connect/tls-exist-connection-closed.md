---
title: An existing connection was forcibly closed (OS error 10054)
description: Troubleshoot the SQL Server connectivity error "An existing connection was forcibly closed by the remote host" caused by TLS handshake failures, mismatched protocols, or cipher suite issues.
ms.date: 05/21/2026
ms.custom: sap:Database Connectivity and Authentication
ms.reviewer: jopilov, v-jayaramanp, v-shaywood
---

# An existing connection was forcibly closed by the remote host (OS error 10054)

_Applies to:_ &nbsp; SQL Server

## Summary

This article describes scenarios in which the SQL Server connectivity error "An existing connection was forcibly closed by the remote host" occurs, and it provides resolutions. The error is tied to a failed TLS handshake between the client and SQL Server, often because the client and server can't agree on a TLS protocol version (for example, TLS 1.2 or TLS 1.3) or a cipher suite. The article covers the following error messages:

> A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - An existing connection was forcibly closed by the remote host.)

> A connection was successfully established with the server, but then an error occurred during the pre-login handshake. (provider: TCP Provider, error: 0 - An existing connection was forcibly closed by the remote host.)

The operating system error 10054 is raised in the Windows sockets layer. For more information, see [Windows Sockets Error Codes: WSAECONNRESET 10054](/windows/win32/winsock/windows-sockets-error-codes-2#:~:text=WSAECONNRESET,10054).

Before you start troubleshooting, check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

## When this error occurs

Secure Channel, also known as [Schannel](/windows/win32/com/schannel), is a [Security Support Provider](/windows/win32/rpc/security-support-providers-ssps-) (SSP). It contains a set of security protocols that provide identity authentication and secure private communication through encryption. One function of Schannel SSP is to implement different versions of the [Transport Layer Security (TLS) protocol](/windows-server/security/tls/transport-layer-security-protocol). TLS is an industry standard that's designed to protect the privacy of information communicated over the internet.

The *TLS handshake protocol* is responsible for the key exchange that's needed to establish or resume secure sessions between two applications communicating over TCP. During the pre-login phase of the connection process, SQL Server and client applications use the TLS protocol to set up a secure channel for transmitting credentials.

### TLS versions at a glance

The following table compares the TLS versions you might encounter when troubleshooting this error:

| Version | Current status on Windows | Recommendation for SQL Server |
|---|---|---|
| TLS 1.0 / 1.1 | Disabled by default on Windows 11, Windows Server 2022, and later. Considered insecure. | Don't use. Upgrade clients and servers to TLS 1.2 or later. |
| TLS 1.2 | Enabled by default on all supported Windows versions. Broadly supported by SQL Server and modern client drivers. | Recommended baseline. |
| TLS 1.3 | Supported on Windows 11 and Windows Server 2022 and later. Supported by SQL Server 2022 and later with current client drivers (for example, Microsoft ODBC Driver 18 and Microsoft.Data.SqlClient 5.x). | Use where both client and server support it. |

For the current support state of TLS protocols on Windows, see [Protocols in TLS/SSL (Schannel SSP)](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-).

## Identify which scenario applies in your environment

The following sections describe different scenarios that can cause the handshake to fail. If you're not sure which one matches your environment, use these starting points to narrow it down:

- Capture a network trace at the client and the server during a failing connection. Then, inspect the **Client Hello** and **Server Hello** packets to confirm the negotiated TLS version and cipher suite.
- Check the SQL Server error log for the `successfully loaded for encryption` entry to confirm which certificate is in use. Check its thumbprint algorithm.
- Compare the enabled TLS versions and cipher suites on the client and server by using `Get-TlsCipherSuite` and the registry keys under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols`.
- Confirm that the client driver supports TLS 1.2 or later. Older drivers, like SQL Server Native Client, are deprecated and aren't recommended.

## No matching TLS protocol between client and server

Secure Sockets Layer (SSL) and versions of TLS earlier than TLS 1.2 have several known vulnerabilities. On modern Windows releases (Windows 11, Windows Server 2022, and later), TLS 1.0 and TLS 1.1 are disabled by default. Administrators often also push out Group Policy or registry settings to disable these older protocols in older environments.

Connectivity errors occur when your application uses an older Open Database Connectivity (ODBC) driver, OLE DB provider, .NET Framework component, or SQL Server version that doesn't support TLS 1.2 or later. The issue occurs because the server and the client can't find a matching protocol. A matching protocol is needed to complete the TLS handshake.

### Fix protocol mismatch between client and server

To fix this issue, use one of the following methods:

- Upgrade SQL Server or your client providers to a version that supports TLS 1.2 (and, where possible, TLS 1.3). For more information, see [TLS 1.2 support for Microsoft SQL Server](tls-1-2-support-microsoft-sql-server.md).
- As a short-term workaround, ask your system administrators to temporarily enable TLS 1.0 or TLS 1.1 on both the client and the server. Do this only until the components can be upgraded. Use one of the following actions:
  - Use the **Cipher Suites** tab in the [**IIS Crypto**](https://www.nartac.com/Products/IISCrypto/) tool to check and change the current TLS settings.
  - Start Registry Editor, and go to the Schannel-specific registry keys under `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL`. For more information, see [TLS 1.2 Upgrade Workflow](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0700-TLS-1.2-Upgrade-Workflow) and [SSL errors after upgrading to TLS 1.2](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0710-SSL-Errors-after-Upgrading-to-TLS-1.2).

### Example: minimum client driver versions for TLS 1.2

Use client components that natively support TLS 1.2 or later. The following components are common safe baselines:

- Microsoft ODBC Driver 17 or 18 for SQL Server.
- Microsoft OLE DB Driver 18 or 19 for SQL Server.
- .NET Framework 4.6.2 or later, or any supported version of .NET (.NET 6 and later).
- Microsoft JDBC Driver 9.4 or later.

The legacy SQL Server Native Client (SNAC) and the SQL Server OLE DB provider that shipped with Windows (SQLOLEDB) are deprecated. Replace them with the components in the previous list.

## Matching TLS protocols but no matching cipher suites

This scenario occurs when you or an administrator restricts certain algorithms on the client or the server for extra security.

You can examine the client and server TLS versions and [cipher suites](/windows/win32/secauthn/cipher-suites-in-schannel) in the **Client Hello** and **Server Hello** packets in a network trace. The **Client Hello** packet advertises all the client cipher suites, and the **Server Hello** packet returns the one the server picked. If there are no matching suites, the server closes the connection instead of sending a **Server Hello** packet.

### Fix cipher suite mismatch

To check the issue, follow these steps:

1. If a network trace isn't available, check the `Functions` value under this registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002`.

   Use the following PowerShell command to list the configured TLS cipher suites:

   ```powershell
   Get-ItemPropertyValue -Path 'HKLM:\System\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002\' -Name Functions
   ```

   On Windows 10, Windows 11, Windows Server 2016, and later, you can also run `Get-TlsCipherSuite` to list the enabled suites in a more readable form.

1. Use the **Cipher Suites** tab in the [**IIS Crypto**](https://www.nartac.com/Products/IISCrypto/) tool to check whether there are any matching algorithms. If no matching algorithms are found, contact Microsoft Support.

For more information, see [TLS 1.2 Upgrade Workflow](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0700-TLS-1.2-Upgrade-Workflow) and [Transport Layer Security (TLS) connections might fail or timeout when connecting or attempting a resumption](https://support.microsoft.com/topic/transport-layer-security-tls-connections-might-fail-or-timeout-when-connecting-or-attempting-a-resumption-326bd5b1-52a1-b367-8179-b154e5c01e90).

## TLS_DHE cipher suites enabled on different Windows versions

This issue can occur when the client and server run on different Windows versions (for example, Windows Server 2012 and Windows Server 2016 or later) and both advertise `TLS_DHE_*` cipher suites. Those Windows versions handle Diffie-Hellman key exchange inside TLS differently, which can cause the handshake to fail.

### Solution

To fix this issue, remove all cipher suites that start with `TLS_DHE_` from the local policy. For more information about errors that occur when applications try to connect to SQL Server in Windows, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](../../../windows-server/certificates-and-public-key-infrastructure-pki/apps-forcibly-closed-tls-connection-errors.md).

## SQL Server certificate uses a weak hash algorithm

SQL Server always encrypts network packets that are related to sign in. For this purpose, it uses a manually provisioned certificate or a [self-signed certificate](/dotnet/core/additional-tools/self-signed-certificates-guide). If SQL Server finds a certificate that supports the server authentication function in the certificate store, it uses that certificate even if it wasn't manually provisioned. If the certificate uses a weak hash (thumbprint) algorithm like [MD5](/dotnet/api/system.security.cryptography.md5), SHA224, or SHA512, it doesn't work with TLS 1.2 and causes the error.

> [!NOTE]
> Self-signed certificates aren't affected by this issue.

### Replace or reconfigure certificates with weak hash algorithms

To fix the issue, follow these steps:

1. In [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager), expand **SQL Server Network Configuration** in the **Console** pane.
1. Select **Protocols for \<instance name\>**.
1. Select the **Certificate** tab, and then do one of the following actions:
    - If a certificate appears, select **View** to check the thumbprint algorithm and confirm whether it uses a weak hash algorithm. Then, select **Clear** and go to step 4.
    - If no certificate appears, review the SQL Server error log for an entry like the following and note the hash or thumbprint value:

      `2017-05-30 14:59:30.89 spid15s The certificate [Cert Hash(sha1) "AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00"] was successfully loaded for encryption`

1. Remove server authentication from the certificate:
    1. Select **Start** > **Run**, and enter *MMC* (Microsoft Management Console).
    1. In MMC, add the **Certificates** snap-in and select **Computer account**.
    1. Expand **Personal** > **Certificates**.
    1. Find the certificate that SQL Server uses by name or by thumbprint, and open its **Properties** pane.
    1. On the **General** tab, select **Enable only the following purposes** and clear **Server Authentication**.
1. Restart the SQL Server service.

## TLS_DHE leading zero fix not installed

This scenario occurs when the client and the server negotiate a `TLS_DHE_*` cipher suite for the TLS handshake, but one side doesn't have the Windows update that adds the leading-zero fix for the Diffie-Hellman key exchange. For more information about this scenario, see [Applications experience forcibly closed TLS connection errors when connecting SQL Servers in Windows](../../../windows-server/identity/apps-forcibly-closed-tls-connection-errors.md).

> [!NOTE]
> If this article doesn't fix your issue, check whether the [common connectivity issues articles](../connect/resolve-connectivity-errors-overview.md#common-connectivity-issues) can help.

## TCP three-way handshake timeout from IOCP worker shortage

On systems with high workloads that run SQL Server 2017 or earlier, you might see intermittent 10054 errors caused by TCP three-way handshake failures, which lead to TCP rejections. The root cause is often a delay in processing `TCPAcceptEx` requests. The delay can be caused by a shortage of [Input/Output Completion Port (IOCP) listener](https://techcommunity.microsoft.com/blog/sqlserversupport/is-the-iocp-listener-actually-listening/333989) workers, which manage the acceptance of incoming connections. When IOCP workers are too few or are busy servicing other requests, connection requests are processed late, which results in handshake failures and TCP rejections. You might also see sign-in timeouts during the SSL handshake or during the processing of sign-in requests, which involve authentication checks.

### Mitigate IOCP worker shortages and handshake timeouts

A shortage of IOCP workers and of SOS Worker resources allocated to authentication and encryption operations is the main cause of these TCP three-way handshake timeouts and sign-in timeouts. SQL Server 2019 and later include several performance improvements in this area. One notable enhancement is a dedicated login dispatcher pool, which optimizes resource allocation for sign-in tasks. This change reduces timeouts and improves overall system performance. If you're affected by this issue, plan an upgrade to a currently supported SQL Server version.

## Other TLS connection failure scenarios

If the error message you encounter doesn't correspond to any of the previous scenarios, refer to the following additional scenarios:

- [Local SQL Server can't connect to a linked server when RSA encryption is used](client-machine-cannot-connect-to-sqlserver.md)
- [A connection error 10054 might occur post SQL Server upgrade](error-messages-areshown-after-upgrade-sql-version.md)
- [Intermittent connection errors occur when adding a node to the Always On environment in SQL Server](intermittent-connection-errors-when-a-new-node-is-added.md)
- [Intermittent connection errors occur when using SQLCMD utility](intermittent-connection-errors-sqlcmd.md)
- [The SSL_PE_NO_CIPHER error occurs on endpoint 5022 in SQL Server](ssl-pe-no-cipher-error-endpoint-5022.md)
- [Connectivity error 0x80004005 occurs from SQL Sever Agent SSIS failures](sql-server-faces-connectivity-issue-ssispack-fail.md)
- ["Client unable to establish connection" error after implementing the cipher suite policies on a SQL Server machine](issues-connection-after-implementing-cipher-suite-policies.md)
- ["Connection to the linked server has failed" error after you update Windows Server](connection-to-linked-server-failed.md)
- [SQL Server Agent fails to start while connecting to SQL Server](unable-to-start-sql-agent.md)
- [Error connecting higher to lower version of SQL Server using SQL Server Linked Server functionality](linked-server-cannot-be-created.md)

## Related content

- [Troubleshoot connectivity issues in SQL Server](../connect/resolve-connectivity-errors-overview.md)
- [Error for SSIS packages on SQL servers configured to use encryption and network packet size](../../integration-services/use-encryption-network-packet-size.md)
- [Recommended prerequisites and checklist for troubleshooting connectivity issues](../connect/resolve-connectivity-errors-checklist.md)
- [Protocols in TLS/SSL (Schannel SSP)](/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
