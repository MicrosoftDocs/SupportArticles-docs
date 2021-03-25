---
title: Troubleshoot Windows Server Update Services (WSUS) synchronization and import issues
description: Describes common scenarios when WSUS synchronization and import fail. Provide common troubleshooting guides.
author: helenclu
ms.author: luche
ms.reviewer: lamosley
ms.date: 03/22/2021
---
# Troubleshoot WSUS synchronization and import issues

*Applies to*: Windows Server Update Services

Starting near the end of July 2020, users have experienced WSUS synchronization and import problems with the Windows Update (WU) or Microsoft Update (MU) endpoints.

This article describes how to troubleshoot some common problems. You can use some of the troubleshooting techniques (such as network captures) for many other issues.

## Endpoints

Currently WSUS uses the following two endpoints to synchronize metadata:

- [https://sws.update.microsoft.com](https://sws.update.microsoft.com)

  It's the new endpoint that most WSUS servers should synchronize with. Starting from July 2020, this endpoint accepts only Transport Layer Security (TLS) 1.2 connections, and some ciphers were disabled.
- [https://fe2.update.microsoft.com](https://fe2.update.microsoft.com)
  
  It's the old endpoint that will be decommissioned someday. It's used by some WSUS 3.0 servers that can't connect with the new endpoint. This endpoint supports TLS 1.0, TLS 1.1, and TLS 1.2 connections.

When you experience WSUS synchronization or manual import problems, first check which endpoint you're synchronizing with:

1. Open an elevated PowerShell command prompt on the WSUS server.
2. Run the following PowerShell script to find the current synchronization endpoint:

   ```powershell
   $server = Get-WsusServer
   $config = $server.GetConfiguration()
   # Check current settings before you change them 
   $config.MUUrl
   ```

Windows Server 2012 and later versions should be configured to use the [https://sws.update.microsoft.com](https://sws.update.microsoft.com) endpoint. If you're still using the [https://fe2.update.microsoft.com](https://fe2.update.microsoft.com) endpoint, change it to the new endpoint with the steps in [WSUS synchronization fails with SoapException](wsus-synchronization-fails-with-soapexception.md#resolution). If necessary, troubleshoot connection issues with [https://sws.update.microsoft.com](https://sws.update.microsoft.com).

## Issue 1: Manual import fails, but synchronization succeeds

Many users import updates into WSUS manually, and some updates must be imported manually. For example, preview updates that are released in the third and fourth weeks of the month must be manually imported. Since the end of July 2020, you may find you can't manually import updates.

:::image type="content" source="media/troubleshoot-wsus-import-sync-issues/import-failure.png" alt-text="Import fails":::

However, some WSUS servers can still import updates successfully. And normal synchronization with WU and MU works.

This issue occurs on WSUS servers running Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019.

### Troubleshoot issue 1

1. Run the PowerShell script in [Endpoints](#endpoints) to determine which endpoints the WSUS servers use. You'll probably find that working servers are communicating with [https://fe2.update.microsoft.com](https://fe2.update.microsoft.com), and failing servers are communicating with [https://sws.update.microsoft.com](https://sws.update.microsoft.com).
2. Check the `%Program Files%\Update Services\LogFiles\SoftwareDistribution.log` file for errors when you manually import updates. Look for errors that are similar to the following example:

   ```output
   ProcessWebServiceProxyException found Exception was WebException. Action: Retry. Exception Details: System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send. ---> System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host. ---> System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host
      at System.Net.Sockets.NetworkStream.Read(Byte[] buffer, Int32 offset, Int32 size)
      -- End of inner exception stack trace ---
      ...
      at System.Net.TlsStream.ProcessAuthentication(LazyAsyncResult result)
      at System.Net.TlsStream.Write(Byte[] buffer, Int32 offset, Int32 size)
      at System.Net.PooledStream.Write(Byte[] buffer, Int32 offset, Int32 size)
      at System.Net.ConnectStream.WriteHeaders(Boolean async)
   ```

The following message in the error indicates that the WSUS server tried to connect to WU/MU with TLS, but WU/MU closed the connection:

**An existing connection was forcibly closed by the remote host.**

Let's look at the network capture of the connection attempt:

:::image type="content" source="media/troubleshoot-wsus-import-sync-issues/network-capture-1.png" alt-text="Network capture 1":::

In the network capture, frame 874 is the Client Hello packet using TLS 1.0. Frame 877 is the server response, which includes the flags ACK (A) and RST (R). Because the [https://sws.update.microsoft.com](https://sws.update.microsoft.com) endpoint supports only TLS 1.2 connections, it denies the connection and issues a reset response.

### Resolution for issue 1

This issue occurs because WSUS import functionality can't use TLS 1.2.

To fix this issue, use one of the following methods:

- Configure .NET Framework to use TLS 1.2 by using registry keys

  To set the registry keys, see [Configure for strong cryptography](/mem/configmgr/core/plan-design/security/enable-tls-1-2-server#configure-for-strong-cryptography). Restart the server after you set the registry keys.
- Create or update the w3wp.exe.config file to enable TLS 1.2

  > [!NOTE]
  > This change will apply to all w3wp.exe instances that are created, whether or not they are for WSUS. W3wp.exe will use TLS 1.2 if the remote side supports it. If TLS 1.0 and TLS 1.1 are enabled, it will negotiate these protocols if the target site doesn't support TLS 1.2.

  If the `%SystemRoot%\system32\inetsrv\w3wp.exe.config` file doesn't exist, follow these steps:

  1. Create a new file named w3wp.exe.config in the `%SystemRoot%\system32\inetsrv` directory.
  2. Open it in Notepad, or another text editor.
  3. Add the following lines to the file, and then save the file.
  
     ```xml
     <?xml version="1.0" encoding="utf-8"?>
     <configuration>
        <runtime>
           <AppContextSwitchOverrides value="Switch.System.Net.DontEnableSystemDefaultTlsVersions=false"/>
        </runtime>
     </configuration>
     ```

  If the `%SystemRoot%\system32\inetsrv\w3wp.exe.config` file already exists, follow these steps:

  1. Open the file in Notepad, or another text editor.
  2. Add the following lines immediately under the \<configuration> element, and then save the file:
  
     ```xml
     <runtime>
        <AppContextSwitchOverrides value="Switch.System.Net.DontEnableSystemDefaultTlsVersions=false"/>
     </runtime>
     ```
  
  After you create or update the w3wp.exe.config file, open an elevated command prompt window, run `iisreset` to restart all worker processes. Test if manual import works.

## Issue 2: Manual import fails after you disable TLS 1.0 or TLS 1.1

TLS 1.0 and TLS 1.1 are being phased out because they're considered insecure. After you disable these protocols, you can no longer import updates, but synchronization continues to work.

This issue occurs on WSUS servers running Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019.

## Troubleshoot issue 2

WSUS logs which SSL/TLS versions are enabled when it starts. To determine the SSL/TLS versions, follow these steps:

1. Restart the WSUS service.
2. Run `iisreset` from an elevated command prompt to force WSUS to go through the startup sequence.
3. Open the WSUS console, and connect to the server.
4. Open `%Program Files%\Update Services\LogFiles\SoftwareDistribution.log`, look for entries that start with **SCHANNEL Protocol**. You should see entries that are similar to the following example:

   ```output
   SCHANNEL Protocol 'TLS 1.0' disabled
   SCHANNEL Protocol 'TLS 1.1' disabled
   SCHANNEL Protocols subkey for 'TLS 1.2' not found. Protocol is enabled
   ```

   These entries show that TLS 1.0 and TLS 1.1 are disabled, and TLS 1.2 is enabled.

When import fails, SoftwareDistribution.log logs the following error message:

```output
ProcessWebServiceProxyException found Exception was WebException. Action: Retry. Exception Details: System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a receive. ---> System.ComponentModel.Win32Exception: The client and server cannot communicate, because they do not possess a common algorithm
```

Let's look at the network capture of the connection attempt:

:::image type="content" source="media/troubleshoot-wsus-import-sync-issues/network-capture-2.png" alt-text="Network capture 2":::

In the network capture, frames 1518-1520 show the three-way handshake (SYN, SYN ACK, ACK) between the client and server. Frame 1536 is an ACK FIN packet from the WSUS server.

WSUS closes the connection, because all protocols it knows how to use for import (SSL3, TLS 1.0, TLS 1.1) are disabled and it can't use TLS 1.2.

### Resolution for issue 2

This issue is similar to issue 1, where WSUS import can't use TLS 1.2. To fix the issue, use [Resolution for issue 1](#resolution-for-issue-1).

## Issue 3: Synchronization fails on Windows Server 2012 and Windows Server 2012 R2 WSUS servers that apply only security-only updates

Windows Server 2012 and Windows Server 2012 R2 servicing contains the following two patch tracks:

- A security-only update, which isn't cumulative. It contains only security fixes. For example, [June 9, 2020—KB4561673 (Security-only update)](https://support.microsoft.com/topic/june-9-2020-kb4561673-security-only-update-d96ab2c7-9a80-d9de-7f8b-cd59c3ae6d4a).
- A Monthly Rollup, which is cumulative. It contains all security fixes from the security-only update, and other non-security fixes. For example, [June 9, 2020—KB4561666 (Monthly Rollup)](https://support.microsoft.com/topic/june-9-2020-kb4561666-monthly-rollup-25c80876-4902-1fe8-6606-80fd28074f67).

WSUS on Windows Server 2012 and Windows Server 2012 R2 can't use TLS 1.2 for synchronization, unless one of the following or later Monthly Rollups is installed:

- [June 27, 2017—KB4022721 (Preview of Monthly Rollup)](https://support.microsoft.com/topic/june-27-2017-kb4022721-preview-of-monthly-rollup-16a4b074-5202-c1c3-2c8a-34c1edd452f8) for Windows Server 2012
- [June 27, 2017—KB4022720 (Preview of Monthly Rollup)](https://support.microsoft.com/topic/june-27-2017-kb4022720-preview-of-monthly-rollup-b98970bb-6f11-46c3-8681-a6b85d5d8eb4) for Windows Server 2012 R2

The change that enables WSUS to use TLS 1.2 is a non-security fix, it's included only in the Monthly Rollups.

Some users opt to install only the security-only updates and never install the Monthly Rollups, so their WSUS servers don't have the update that enables TLS 1.2 installed. After the [https://sws.update.microsoft.com](https://sws.update.microsoft.com) endpoint is changed to accept only TLS 1.2 connections, these WSUS servers can no longer synchronize with the endpoint. This issue also occurs on a freshly installed Windows Server 2012 or Windows Server 2012 R2 WSUS server that hasn't installed any Monthly Rollups.

## Troubleshoot issue 3

If the WSUS server has the proper updates installed, WSUS will log which SSL/TLS versions are enabled when it starts. Follow these steps on the WSUS server:

1. Restart the WSUS service.
2. Run `iisreset` from an elevated command prompt to force WSUS to go through the startup sequence.
3. Open the WSUS console, and connect to the server.
4. Open `%Program Files%\Update Services\LogFiles\SoftwareDistribution.log`, look for entries that start with **SCHANNEL Protocol**. You should see entries that are similar to the following example:

   ```output
   SCHANNEL Protocol 'TLS 1.0' disabled
   SCHANNEL Protocol 'TLS 1.1' disabled
   SCHANNEL Protocols subkey for 'TLS 1.2' not found. Protocol is enabled
   ```

   If you can't find these entries, it means the update that enables TLS 1.2 isn't installed. 

When synchronization fails, SoftwareDistribution.log logs the following error message:

```output
WebServiceCommunicationHelper.ProcessWebServiceProxyException	ProcessWebServiceProxyException found Exception was WebException. Action: Retry. Exception Details: System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send. ---> System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host. ---> System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host   at System.Net.Sockets.NetworkStream.Read(Byte[] buffer, Int32 offset, Int32 size)
```

Let's look at the network capture of the connection attempt:

:::image type="content" source="media/troubleshoot-wsus-import-sync-issues/network-capture-3.png" alt-text="Network capture 3":::

In the network capture, frame 95 is the Client Hello packet using TLS 1.0. Frame 96 is the RST packet from [https://sws.update.microsoft.com](https://sws.update.microsoft.com). Because the endpoint supports only TLS 1.2 connections, it denies the connection and issues a reset response. The WSUS server will try several times before it gives up, so this sequence is repeated.

### Resolution for issue 3

To fix the issue, install the latest Monthly Rollup for Windows Server 2012 or Windows Server 2012 R2. Also apply [Resolution for issue 1](#resolution-for-issue-1) to prevent the manual import failure.

## Issue 4: Synchronization fails after July 2020 when WSUS is integrated with Configuration Manager

Many WSUS installations are integrated with Microsoft Endpoint Configuration Manager software update points (SUPs). After July 2020, you may experience synchronization failures if Configuration Manager is configured to synchronize Surface drivers.

This issue occurs on WSUS servers running Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019.

### Troubleshoot issue 4

When this issue occurs, entries similar to the following example are logged in Wsyncmgr.log:

```output
Calling ImportUpdateFromCatalogSite for driver update GUIDs
Generic exception : ImportUpdateFromCatalogSite failed. Arg = 001d4517-c586-4bb1-9e66-ed6ff8e8d34f. Error =The underlying connection was closed: An unexpected error occurred on a receive.
Generic exception : ImportUpdateFromCatalogSite failed. Arg = 0037641d-bb9b-4530-9568-11e413223106. Error =The underlying connection was closed: An unexpected error occurred on a receive.
```

And the `%Program Files\Update Services\LogFiles\SoftwareDistribution.log` file logs the following errors:

```output
ProcessWebServiceProxyException found Exception was WebException. Action: Retry. Exception Details: System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a receive. ---> System.ComponentModel.Win32Exception: The client and server cannot communicate, because they do not possess a common algorithm
```

These errors indicate that the connection was closed. This issue occurs because Configuration Manager uses the WSUS import functionality and has the same limitations.

### Resolution for issue 4

To fix the issue, use [Resolution for issue 1](#resolution-for-issue-1).

## Issue 5: Synchronization fails after July 2020 because of limited ciphers

You may disable various ciphers to secure TLS connections. Starting from July 2020, your WSUS servers can no longer synchronize with WU or MU. Also, when [https://sws.update.microsoft.com](https://sws.update.microsoft.com) is changed to accept only TLS 1.2 connections, some ciphers are removed.

This issue occurs on WSUS servers running Windows Server 2012, Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019.

## Troubleshoot issue 5

The `%Program Files\Update Services\LogFiles\SoftwareDistribution.log` file logs the following errors when synchronizing:

```output
ProcessWebServiceProxyException found Exception was WebException. Action: Retry. Exception Details: System.Net.WebException: The underlying connection was closed: An unexpected error occurred on a send. ---> System.IO.IOException: Unable to read data from the transport connection: An existing connection was forcibly closed by the remote host. ---> System.Net.Sockets.SocketException: An existing connection was forcibly closed by the remote host
```

However, these entries aren't useful to determine if you have a cipher problem.

In this situation, use a network capture, or check the applied Group Policy Objects (GPOs). To check the applied GPOs, run the following command in an elevated command prompt:

```console
gpresult /scope computer /h GPReport.html
```

Open GPReport.html in a browser.

:::image type="content" source="media/troubleshoot-wsus-import-sync-issues/gpreport.png" alt-text="Group Policy information":::

Look for **SSL Cipher Suite Order**, and the **SSL Cipher Suites** setting. Usually this setting isn't configured. If it's configured, the issue may occur because there's no common cipher with WU/MU.

As of August 2020, [https://sws.update.microsoft.com](https://sws.update.microsoft.com) supports the following ciphers:

- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256

> [!NOTE]
> This list will change over time, because ciphers will gradually grow weaker as technology improves.

If the GPO is applied and doesn't specify one of these ciphers, communication with WU or MU fails.

Let's look at the network capture:

:::image type="content" source="media/troubleshoot-wsus-import-sync-issues/network-capture-4.png" alt-text="Network capture 4":::

In the network capture, frame 400 is the Client Hello packet using TLS 1.2. The frame detail shows which ciphers were sent by the client. Frame 404 is the RST packet from [https://sws.update.microsoft.com](https://sws.update.microsoft.com). Because there's no common cipher, the synchronization fails.

### Resolution for issue 5

To fix the issue, follow these steps:

1. Use the output of `gpresult` to determine the GPO that specifies the SSL Cipher Suite Order, and remove the GPO. Or change it to include ciphers that are supported by [https://sws.update.microsoft.com](https://sws.update.microsoft.com).

   For Windows Server 2016 and Windows Server 2019, include one of the following ciphers:

   - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
   - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
   - TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
   - TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256

   For Windows Server 2012 and 2012 R2, include one of the following ciphers:

   - TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256
   - TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384
   - TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256
   - TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P384
2. If the ciphers aren't set by GPO, locate the following registry subkey:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002`

   Add one of the required ciphers to the **Functions** value of the registry key.
3. Restart the WSUS server.

Also apply [Resolution for issue 1](#resolution-for-issue-1) to prevent manual import failures.

## A successful connection

Let's look at an example of successful connection. Here's a network capture when a Windows Server 2016 WSUS server synchronizes updates:

:::image type="content" source="media/troubleshoot-wsus-import-sync-issues/network-capture-5.png" alt-text="Network capture 5":::

:::image type="content" source="media/troubleshoot-wsus-import-sync-issues/network-capture-6.png" alt-text="Network capture 6":::

In the network capture, frame 191 is the Client Hello packet using TLS 1.2. The frame detail shows which ciphers were sent by the client. Frame 195 is the Server Hello packet from the endpoint. The TLSCipherSuite chosen by WU is TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384. The server certificate is also sent in the Server Hello packet.

Additional connection setup occurs in frames 196-203. Then the data transfer by the application (WSUS) and the [https://sws.update.microsoft.com](https://sws.update.microsoft.com) endpoint begins in frame 207.

## A note about proxy servers

When you use a proxy server, the network capture will look different. The WSUS server connects to the proxy, and you may see a CONNECT request with the destination [https://sws.update.microsoft.com](https://sws.update.microsoft.com) or [https://fe2.update.microsoft.com](https://fe2.update.microsoft.com). WSUS will issue a Client Hello packet with the ciphers it supports. If the connection isn't successful because of wrong TLS version or there is no common cipher, you may or may not see an RST packet. Proxies tend to send a FIN back to the client indicating the end of the connection. But it may not be true for every proxy server. Some proxy servers send an RST packet, or something else.

When you use a proxy, you need to know the IP address of internal interface of the proxy server, because WSUS isn't communicating directly with the WU endpoints. If you can't get the IP address of the proxy server, search the network capture for CONNECT requests, and look for the URL of the Windows Update endpoint.

## References

- [WSUS Synchronization fails with SoapException](wsus-synchronization-fails-with-soapexception.md)
- [How to enable TLS 1.2 on the site servers and remote site systems](/mem/configmgr/core/plan-design/security/enable-tls-1-2-server)
- [TLS registry settings](/windows-server/security/tls/tls-registry-settings)
