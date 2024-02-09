---
title: SSL errors after upgrading to TLS 1.2
description: This article provides information about the SSL errors that you might encounter after you upgrade to TLS 1.2.
ms.date: 01/16/2024
ms.custom: sap:Connection issues
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
---

# SSL errors are reported after upgrading to TLS 1.2

This article provides information about the Secure Sockets Layer (SSL) errors that you might encounter after you upgrade to TLS 1.2. It also lists the methods by which you can retrieve the data manually. You can also run the SQLCHECK tool and review the information in the *SQLCHECK* log file.

## Symptoms

Consider the following scenario where you might see the following issues after you upgrade the TLS protocol to TLS 1.2.

- Microsoft SQL Server uses a certificate that's signed by a weak hash algorithm. Such certificates include MD5, SHA224, and SHA512.

- TLS 1.2 upgrades were applied to only the client or the server but not both.

- TLS 1.0 is disabled.

- There are no matching cryptographic algorithms between the client and the server.

In this scenario, you encounter the following issues after the upgrade is finished:

- Problems that affect the server certificate also affect local connections and connections from client computers. For more information, see [Encrypting Connections to SQL Server](/previous-versions/sql/sql-server-2008-r2/ms189067(v=sql.105)?redirectedfrom=MSDN).

- The application might generate one of the following error messages:

   **Named Pipes**
   > A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - No process on the other end of the pipe) Microsoft SQL Server, Error: 233.

  **TCP**
  > A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - The connection was forcibly closed by remote host 10054) Microsoft SQL Server, Error: 233.

If you have a network capture, it might resemble the following screenshot that shows that the server responds to the `Client Hello` packet by closing the connection.

  :::image type="content" source="media/ssl-errors-after-tls-1-2/ss-errors-after-upgrade-netwk-capture.png" alt-text="Screenshot of a network capture that shows how the server responds to the Client Hello packet.":::

## Resolution
  
To resolve these errors, follow these steps:

1. Open SQL Server Configuration Manager, right-click **Protocols for InstanceName**, and then select **Properties**.

1. Select the **Certificate** tab, and check which certificate is being used.

   :::image type="content" source="media/ssl-errors-after-tls-1-2/protocols-for-server-cert-tab.png" alt-text="Screenshot of the Certificate tab that shows which certificate is used.":::

1. If a certificate exists, select **View** to examine it, and then select **Clear**. Then, go to step 6.

1. If no certificate exists, examine the SQL Server error log file to get the hash code. You might see one of the following entries:

     `2023-05-30 14:59:30.89 spid15s The certificate [Cert Hash(sha1) "B3029394BB92AA8EDA0B8E37BAD09345B4992E3D"] was successfully loaded for encryption.`
      or
     `2023-05-19 04:58:56.42 spid11s A self-generated certificate was successfully loaded for encryption.`
    If the certificate is self-generated, skip to step 2.

1. Open the **Computer Certificate Store** in the Microsoft Management Console (MMC).

   :::image type="content" source="media/ssl-errors-after-tls-1-2/mmc-cert-properties.png" alt-text="Select Properties from SQL Server Configuration Manager.":::

   1. Navigate to **Personal Certificates**.
   1. Expand the **Intended Purposes** column, and double-click certificates that are enabled for server authentication.
   1. Check whether the thumbprint matches the thumbprint in the error log file. If it doesn't, try another certificate.
   1. Check the **Signature hash algorithm**. If it's MD5, SHA224, or SHA512, it won't support TLS 1.2. If it's one of the weak algorithms, disable **Server Authentication** so that SQL Server can't use it.
   1. If the certificate is explicitly specified in SQL Server Configuration Manager, select **Clear** to remove it.
   1. Locate the certificate in MMC.
   1. In MMC, right-click the certificate, and then select **Properties**.
   1. On the **General** tab, either disable the certificate completely or selectively disable **Server Authentication**.

      :::image type="content" source="media/ssl-errors-after-tls-1-2/add-security-snapins.png" alt-text="Disable the certificate or the server authentication.":::

1. Save the changes.
1. Restart SQL Server.

   The error log should now indicate that a self-generated certificate is used. If the problem is resolved, SQL Server can run successfully by using the self-signed certificate. If you want a Verisign or other certificate, then you must ask the certificate provider to make sure that a strong hash is used that's appropriate for TLS 1.2. If the problem isn't resolved, return to step 2.

## Check enabled and disabled TLS protocols

To check the enabled and disabled TLS protocols, follow these steps:

1. Check the Background and Basic Upgrade Workflow if you didn't already do this.

   Both the client and server must be upgraded to enforce TLS 1.2. If it's necessary, you can upgrade the server but leave TLS 1.0 enabled so that non-upgraded clients can connect.

1. Check the SSL or TLS registry by using REGEDIT.

   You can find the enabled and disabled SSL or TLS versions under the following registry subkey:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols`

   There are client and server subkeys for each version of SSL or TLS, and both have **Enabled** and **Disabled** values:

   `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2]`

   `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

   `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server] "DisabledByDefault"=dword:00000000 "Enabled"=dword:00000001`

    > [!NOTE]
    > Any non-zero value is treated as TRUE. However, **1** is generally preferred instead of **FFFFFFFF** (or **-1**).

1. Make sure that there are no incompatible settings.

   For instance, TLS 1.0 is disabled and TLS 1.2 is enabled on the server. This is because these settings might not match the settings on the client or the client driver might not be updated.

   You can test this situation by setting `Enabled=0` for TLS 1.2 (and also re-enable TLS 1.0 if it's disabled).

1. Restart SQL Server to check whether the issue is related to TLS 1.2 or it's a general issue.

## No matching cipher suites

You can examine the client and server TLS versions and cipher suites in the `Client Hello` and `Server Hello` packets. The `Client Hello` packet advertises all the client cipher suites, and the `Server Hello` packet specifies one cipher suite. If there are no matching suites, the server closes the connection instead of responding by sending the `Server Hello` packet.

:::image type="content" source="media/ssl-errors-after-tls-1-2/cipher-suites.png" alt-text="Screenshot of cipher suite details that you can examine to determine whether the suites match.":::

If a network trace isn't available, you can check the function value under the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Cryptography\Configuration\Local\SSL\00010002`

If you see no matching algorithms, contact Microsoft Support. To assist the support engineer, capture network traces or BID traces, as specified at Advanced SSL Data Capture.
