---
title: Untrusted Certificate Authority Error When You Connect to SQL Server
description: Resolve the "certificate received from the remote server was issued by an untrusted certificate authority" error when you make an encrypted connection to SQL Server.
ms.date: 08/26/2026
ms.custom: sap:Database Connectivity and Authentication
ms.reviewer: masank, jopilov
---
# "The certificate received from the remote server was issued by an untrusted certificate authority" error when you connect to SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2007728

## Summary

This article helps you resolve the "The certificate received from the remote server was issued by an untrusted certificate authority" error that occurs when a client makes an encrypted (TLS) connection to SQL Server. The error means that the client can't validate the certificate that the SQL Server instance presents during the TLS handshake, usually because the issuing certificate authority (CA) isn't in the client's Trusted Root Certification Authorities store, or because SQL Server uses a self-signed certificate.

You resolve the error by installing the issuing CA certificate on the client computer, by trusting the server certificate without validation (the **Trust Server Certificate** setting), or by changing the encryption configuration on the client or the server. Recent versions of several client drivers and tools changed their defaults to require encryption, so you might see this error after a driver or tool upgrade even though nothing changed on the server.

## Symptoms

When you connect to SQL Server, you might receive the following error message:

> A connection was successfully established with the server, but then an error occurred during the login process. (provider: SSL Provider, error: 0 - The certificate chain was issued by an authority that is not trusted.) (.Net SqlClient Data Provider)

Additionally, the following error message is logged in the Windows System event log:

```output
Log Name:      System  
Source:        Schannel  
Date:          10/13/2020 3:03:31 PM  
Event ID:      36882  
Task Category: None  
Level:         Error  
Keywords:  
User:        USERNAME  
Computer:     COMPUTERNAME  
Description:  
The certificate received from the remote server was issued by an untrusted certificate authority. Because of this, none of the data contained in the certificate can be validated. The TLS connection request has failed. The attached data contains the server certificate.
```

## Cause

This error occurs when you make an encrypted connection to SQL Server by using a certificate that the client can't verify. This behavior happens in the following scenarios:

|Scenario|Server-side encryption|Client-side encryption|Certificate type|Certificate issuing authority present in Trusted Root Certification Authorities store|
|---|---|---|---|---|
|1|Yes|No|A certificate from a source that the client doesn't trust (the issuing authority isn't listed in Trusted Root Certification Authorities on the client computer)|No|
|2|No|Yes|A self-signed certificate that SQL Server generates|No. Self-signed certificates don't appear in this store.|

When a client establishes an encrypted connection to SQL Server, Secure Channel (Schannel) builds the list of trusted certificate authorities by searching the Trusted Root Certification Authorities store on the local computer. During the TLS handshake, the server sends its public key certificate to the client. The issuer of a public key certificate is known as a certificate authority (CA). The client must confirm that it trusts the CA, which it does by knowing the public keys of trusted CAs in advance. When Schannel detects a certificate that an untrusted certification authority issued, such as in the previous two scenarios, you get the error message listed in the [Symptoms](#symptoms) section.

If no suitable certificate is configured or detected, the Database Engine generates a self-signed fallback certificate during startup. It uses this certificate to encrypt login credentials and, when server-side or client-side encryption is enabled, the entire connection. No client trusts a self-signed certificate by default, which is why this error can occur on a default installation of SQL Server, even when the client and the server run on the same computer. For more information, see [Login packet encryption versus data packet encryption](/sql/database-engine/configure-windows/configure-sql-server-encryption#login-packet-encryption-vs-data-packet-encryption).

### Why this error appears after a driver or tool upgrade

The client driver and tool versions in the following table changed their defaults to require encryption. After you upgrade to one of these versions, the client encrypts the connection and validates the server certificate even though the server configuration didn't change. Earlier versions didn't require encryption by default, so the certificate wasn't validated unless you explicitly requested encryption.

|Client driver or tool|Version|Default encryption behavior|
|---|---|---|
|Microsoft OLE DB Driver for SQL Server (`MSOLEDBSQL19`)|19 and later versions|`Encrypt` defaults to `Mandatory`|
|Microsoft ODBC Driver for SQL Server|18 and later versions|`Encrypt` defaults to `Mandatory`|
|`Microsoft.Data.SqlClient`|4.0 and later versions|`Encrypt` defaults to `True`|
|SQL Server Management Studio (SSMS)|20 and later versions|**Encryption** defaults to **Mandatory**|

If you see this error immediately after you migrate an application from SQL Server Native Client 11.0 (SNAC) to Microsoft OLE DB Driver 19 or Microsoft ODBC Driver 18, see [Certificate chain not trusted after driver upgrade](certificate-chain-not-trusted.md).

SNAC isn't shipped with SQL Server 2022 (16.x) and later versions or with SSMS 19 and later versions, and it isn't recommended for new development. Use the Microsoft OLE DB Driver for SQL Server, the Microsoft ODBC Driver for SQL Server, or `Microsoft.Data.SqlClient` instead. For more information, see [Support policies for SQL Server Native Client](/sql/relational-databases/native-client/applications/support-policies-for-sql-server-native-client).

## Solution

If you intentionally use either a certificate from a nontrusted authority or a self-signed certificate to encrypt connections to SQL Server, use one of the following options:

- To keep certificate validation and permanently fix the trust problem, use [Option 1: Install the certificate authority on the client computer](#option-1-install-the-certificate-authority-on-the-client-computer).
- To connect immediately without installing a certificate, use [Option 2: Trust the server certificate without validating it](#option-2-trust-the-server-certificate-without-validating-it). This option is the quickest fix, and it's the option that most users need when SQL Server uses its default self-signed certificate.
- To stop requiring encryption, or to replace the certificate with one from a trusted authority, use [Option 3: Change the encryption configuration](#option-3-change-the-encryption-configuration).

### Option 1: Install the certificate authority on the client computer

For scenario 1, add the certificate authority to the Trusted Root Certification Authorities store on the client computer that initiates the encrypted connection. To do this, complete the [Step 1: Export the server certificate to a file](#step-1-export-the-server-certificate-to-a-file) and [Step 2: Install the root certificate authority (CA) on the client computer](#step-2-install-the-root-certificate-authority-ca-on-the-client-computer) procedures in that sequence.

#### Step 1: Export the server certificate to a file

On the SQL Server computer, export the certificate that SQL Server uses to a file. The following steps use *caCert.cer* as an example file name. This file doesn't exist until you create it in this procedure. You choose the name and location.

1. Select **Start**, enter *mmc*, and then open **Microsoft Management Console**.

1. Select **File** > **Add/Remove Snap-in**.

1. In the **Available snap-ins** list, select **Certificates**, and then select **Add**.

1. Select **Computer account**, select **Next**, select **Local computer: (the computer this console is running on)**, and then select **Finish**.

    > [!NOTE]
    > SQL Server certificates are installed in the **Local Computer\Personal** certificate store. If you select **My user account**, MMC opens a different certificate store, and the SQL Server certificate doesn't appear.

1. Select **OK** to close the **Add or Remove Snap-ins** dialog box.

1. In the left pane, expand **Certificates (Local Computer)**, expand **Personal**, and then select **Certificates**.

1. Right-click the certificate that SQL Server uses, and then select **All Tasks** > **Export**.

    > [!TIP]
    > To identify the certificate that SQL Server uses, open SQL Server Configuration Manager, expand **SQL Server Network Configuration**, right-click **Protocols for \<instance name>**, select **Properties**, and then select the **Certificate** tab. If the SQL Server error log contains the "A self-generated certificate was successfully loaded for encryption" entry, SQL Server uses a generated fallback certificate. You can't export that certificate, so use [Option 2](#option-2-trust-the-server-certificate-without-validating-it) or [Option 3](#option-3-change-the-encryption-configuration) instead.

1. Select **Next** to move past the **Welcome** page of the **Certificate Export Wizard**.

1. Confirm that **No, do not export the private key** is selected, and then select **Next**.

1. Make sure that either **DER encoded binary X.509 (.CER)** or **Base-64 encoded X.509 (.CER)** is selected, and then select **Next**.

1. Enter an export file name, such as *caCert.cer*.

1. Select **Next**, and then select **Finish** to export the certificate.

1. Copy the exported *.cer* file to the client computer.

#### Step 2: Install the root certificate authority (CA) on the client computer

1. On the client computer, open MMC, select **File** > **Add/Remove Snap-in**, select **Certificates** in the **Available snap-ins** list, and then select **Add**.

1. In the **Certificates snap-in** dialog box, select **Computer account**, and then select **Next**.

1. In the **Select Computer** pane, select **Local computer: (the computer this console is running on)**, and then select **Finish**.

1. Select **OK** to close the **Add or Remove Snap-ins** dialog box.

1. In the left pane of MMC, expand the **Certificates (Local Computer)** node.

1. Expand the **Trusted Root Certification Authorities** node, right-click the **Certificates** subfolder, select **All Tasks**, and then select **Import**.

1. In the **Certificate Import Wizard**, on the **Welcome** page, select **Next**.

1. On the **File to Import** page, select **Browse**.

1. Browse to the location of the *caCert.cer* certificate file, select the file, and then select **Open**.

1. On the **File to Import** page, select **Next**.

1. On the **Certificate Store** page, accept the default selection, and then select **Next**.

1. On the **Completing the Certificate Import Wizard** page, select **Finish**.

### Option 2: Trust the server certificate without validating it

For scenarios 1 and 2, set the **Trust Server Certificate** setting in your client application. This setting keeps the connection encrypted but skips certificate validation. The keyword name and accepted values depend on the client library:

|Client library|Connection string keyword|
|---|---|
|`Microsoft.Data.SqlClient`|`TrustServerCertificate=True`|
|Microsoft ODBC Driver for SQL Server|`TrustServerCertificate=yes`|
|Microsoft OLE DB Driver for SQL Server (provider string)|`TrustServerCertificate=yes`|
|Microsoft OLE DB Driver for SQL Server (ADO or `IDataInitialize`)|`Trust Server Certificate=true`|
|Microsoft JDBC Driver for SQL Server|`trustServerCertificate=true`|

If you connect by using SQL Server Management Studio (SSMS) 20 or a later version, select the **Trust server certificate** check box on the **Login** page of the **Connect to Server** dialog box. In earlier versions of SSMS, select **Options** in the **Connect to Server** window, select the **Connection Properties** tab, and then select **Trust server certificate**.

For more information about how to configure this setting for your client library, see the following articles:

- [Encryption and certificate validation in Microsoft.Data.SqlClient](/sql/connect/ado-net/encryption-and-certificate-validation)
- [Encryption and certificate validation in the OLE DB Driver for SQL Server](/sql/connect/oledb/features/encryption-and-certificate-validation)
- [DSN and connection string keywords and attributes for the ODBC Driver for SQL Server](/sql/connect/odbc/dsn-connection-string-attribute)
- [Connecting with encryption using the Microsoft JDBC Driver for SQL Server](/sql/connect/jdbc/connecting-with-ssl-encryption)
- [Use encryption without validation in SQL Server Native Client](/sql/relational-databases/native-client/features/using-encryption-without-validation) (legacy client)

> [!NOTE]
> The **Trust Server Certificate** setting doesn't disable encryption. The connection stays encrypted, but the client doesn't verify the identity of the server.

> [!CAUTION]
> Encrypted connections that use a self-signed certificate don't provide strong security. They're susceptible to man-in-the-middle attacks. Don't rely on TLS with self-signed certificates in a production environment or on servers that are connected to the internet.

### Option 3: Change the encryption configuration

If the configuration that the previous sections describe is unintended, use one of the following options to resolve this problem:

- Configure the Database Engine to use a certificate from a trusted authority. This option is the most secure long-term fix because clients then validate the certificate without any extra configuration. For more information, see [Enable encrypted connections to the Database Engine](/sql/database-engine/configure-windows/configure-sql-server-encryption) and [Certificate requirements for SQL Server](/sql/database-engine/configure-windows/certificate-requirements).

- If encryption isn't required:

  - Turn off encryption in your client application. Set `Encrypt=Optional` for an OLE DB provider string, `Use Encryption for Data=Optional` for OLE DB ADO or `IDataInitialize`, `Encrypt=no` for ODBC, and `Encrypt=False` for `Microsoft.Data.SqlClient` or the Microsoft JDBC Driver. In SSMS 20 and later versions, set **Encryption** to **Optional** on the **Login** page of the **Connect to Server** dialog box.

  - Turn off server-side encryption by using SQL Server Configuration Manager. Expand **SQL Server Network Configuration**, right-click **Protocols for \<instance name>**, select **Properties**, select the **Flags** tab, set **Force Encryption** to **No**, and then restart the SQL Server service. For more information, see [Protocols for MSSQLSERVER Properties (Flags tab)](/sql/tools/configuration-manager/protocols-for-mssqlserver-properties-flags-tab).

    > [!WARNING]
    > If you turn off encryption, credentials and data travel over the network unprotected. Turn off encryption only on trusted, isolated networks.

## Related content

- [Certificate validation failure](certificate-validation-failure.md)
- [Troubleshoot Secure Sockets Layer (SSL) errors that occur during the login process](troubleshoot-ssl-errors-login-process.md)
- [Overview of certificate management for SQL Server](/sql/database-engine/configure-windows/certificate-overview)
- [Special cases for encrypting connections to SQL Server](/sql/database-engine/configure-windows/special-cases-for-encrypting-connections-sql-server)
- [Encrypt connections to SQL Server on Linux](/sql/linux/security/encrypted-connections)
