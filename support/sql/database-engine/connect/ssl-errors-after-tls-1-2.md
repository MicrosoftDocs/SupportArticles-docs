---
title: SSL errors after upgrading to TLS 1.2
description: This article provides information about the SSL errors that you might see after you  upgrade to TLS 1.2.
ms.date: 01/04/2024
ms.custom: sap:Connection issues
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
---

# SSL errors are seen after upgrading to TLS 1.2

This article provides information about the SSL errors that you might see after you upgrade to TLS 1.2. It also lists the methods by which you can retrieve the data manually. You can also run SQLCHECK tool and check all the information in the SQLCHECK log file.

## Symptoms

Consider a scenario where you encounter the following issues after you upgrade to TLS 1.2:

- SQL Server uses a certificate that's signed by a weak hash algorithm. These include MD5, SHA224, and SHA512.

- TLS 1.2 upgrades were only applied to the client or the server but not both and TLS 1.0 are disabled.

- There are no matching cryptographic algorithms between the client and the server.

## Cause

  Problems with the server certificate affect local connections and connections from client computers. For more information, see Encrypting Connections to SQL Server.

  The application might generate one of the following errors:

  > Named Pipes - A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - No process on the other end of the pipe) Microsoft SQL Server, Error: 233.
  > TCP - A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - The connection was forcibly closed by remote host 10054) Microsoft SQL Server, Error: 233.

  If you have a network capture, it may look like this, where the server responds to the Client Hello packet by closing the connection:

  :::image type="content" source="media/ssl-errors-after-tls-1-2/ss-errors-after-upgrade-netwk-capture.png" alt-text="network capture that shows how the server responds to the Client Hello packet.":::

## Resolution
  
To resolve these errors, follow these steps:

1. In the SQL Server Configuration Manager, right-click on **Protocols for InstanceName**, and select **Properties**.

1. Select the **Certificate** tab and check which certificate is being used:

   :::image type="content" source="media/ssl-errors-after-tls-1-2/protocols-for-server-cert-tab.png" alt-text="Check which certificate is used in the Certificate tab.":::

  1. If a certificate is present, select **View** to examine it and then select **Clear**. Skip to step 6.

  1. If the certificate isn't present (as shown in the previous screenshot), look in the SQL Server error log file and get the hash code. You might see one of the following two entries:

     `2023-05-30 14:59:30.89 spid15s The certificate [Cert Hash(sha1) "B3029394BB92AA8EDA0B8E37BAD09345B4992E3D"] was successfully loaded for encryption.`
      or
     `2023-05-19 04:58:56.42 spid11s A self-generated certificate was successfully loaded for encryption.`
    If the certificate is self-generated, skip to step b.

  1. Open the **Computer Certificate Store** in the Microsoft Management Console (MMC).<br/>

      :::image type="content" source="media/ssl-errors-after-tls-1-2/mmc-cert-properties.png" alt-text="Select Properties from SQL Server Configuration Manager.":::

  1. Navigate to **Personal Certificates**.
  1. Expand the **Intended Purposes** column and double-click certificates that're enabled for server authentication.
  1. Check if the thumbprint matches the thumbprint in the error log file. If not, try another certificate.
  1. Check the **Signature hash algorithm**. If it's one of MD5, SHA224, or SHA512, then it won't support TLS 1.2.
  1. If it's one of the weak algorithms, then disable **Server Authentication** so that SQL Server can't use it.
  1. If the certificate is explicitly specified in SQL Server Configuration Manager, select **Clear** to remove it.
  1. Locate the certificate in MMC.
  1. In MMC, right-click the certificate, and select **Properties**.
  1. In the **General** tab, either disable the certificate completely, or you can selectively disable **Server Authentication**.

     :::image type="content" source="media/ssl-errors-after-tls-1-2/add-security-snapins.png" alt-text="Disable the certificate or the server authentication.":::

  1. Save the changes.
  1. Restart SQL Server.

     The error log should now indicate a self-generated certificate is being used. If the problem is resolved, SQL Server can run fine with the self-signed certificate. If you want a Verisign or other certificate, then you need to talk to the certificate provider to make sure a strong hash is used that's suitable for TLS 1.2. If the problem isn't resolved, continue with step 2.

### Check Enabled and Disabled TLS Protocols

Check the Background and Basic Upgrade Workflow if not already done. Both the client and server need to be upgraded to enforce TLS 1.2. It might be okay to upgrade the server but leave TLS 1.0 enabled so non-upgraded clients can connect.

Check the SSL or TLS registry using REGEDIT.

You can find the enabled and disabled SSL or TLS versions under the following registry key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols`

There is a client and server sub-key for each version of SSL or TLS, with **Enabled** and **Disabled** values.

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

> [!NOTE]
> Please note that any non-zero value is treated as TRUE. However, *1* is generally preferred over FFFFFFFF (or *-1*).

Make sure that there're no incompatible settings. For instance, TLS 1.0 is disabled and TLS 1.2 is enabled on the server. This might not be the case on the client or the client driver might not be updated.

You can test by setting `Enabled=0` for TLS 1.2 (and re-enable TLS 1.0 if disabled).

Restart SQL Server to check whether the issue is related to TLS 1.2 or a general issue.

### No matching cipher suites

The client and server TLS versions and cipher suites may be readily examined in the `Client Hello` and `Server Hello` packets. The `Client Hello` packet advertises all the client cipher suites, while the `Server Hello` packet will specify one of them. If there're no matching suites, the server closes the connection instead of responding with the `Server Hello` packet.

:::image type="content" source="media/ssl-errors-after-tls-1-2/cipher-suites.png" alt-text="Examine the cipher suites and check if they match.":::

If a network trace isn't available, you can check the function's value under the following registry key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002`

If no matching algorithms are found, contact Microsoft Support. But while waiting for the engineer, you can also capture network traces and/or BID traces as specified at Advanced SSL Data Capture.
