---
title: Certificate Chain Not Trusted After Driver Upgrade
description: Troubleshoot and fix "The certificate chain was issued by an authority that is not trusted" errors after upgrading to OLE DB or ODBC drivers for SQL Server.
ms.date: 01/10/2025
ms.reviewer: v-jayaramanp, jopilov, v-shaywood
ms.custom: sap:Database Connectivity and Authentication
---

# "The certificate chain was issued by an authority that is not trusted" error after upgrading SNAC applications

## Summary

This article helps you troubleshoot certificate chain trust errors that occur when you upgrade database applications from SQL Server Native Client 11.0 (SNAC) to Microsoft OLE DB Driver 19 or Microsoft ODBC Driver 18 for SQL Server.

When you upgrade from SNAC 11.0 to newer drivers, your applications might fail to connect to SQL Server with certificate chain trust errors. This problem happens because the newer drivers enable [encryption](/sql/relational-databases/security/securing-sql-server#encryption-and-certificates) by default and require certificate validation, while SNAC disabled it by default. This article explains why these errors occur and provides solutions to resolve them.

## [Upgraded to Microsoft OLE DB Driver 19 for SQL Server](#tab/ole-db-driver-19)

After you upgrade from SQL Server Native Client 11.0 (Provider=SQLNCLI11) to Microsoft OLE DB Driver 19 for SQL Server, connection attempts might fail with the following error message:

> [Microsoft OLE DB Driver 19 for SQL Server]: Client unable to establish connection

> [Microsoft OLE DB Driver 19 for SQL Server]: SSL Provider: The certificate chain was issued by an authority that is not trusted.

### Cause of certificate chain trust error when upgrading to Microsoft OLE DB Driver 19

This error indicates that the client computer can't verify the authenticity of the SQL Server certificate because it was issued by a certificate authority (CA) that the client doesn't trust.

These errors occur if both of the following conditions are true:

- The **Force encryption** setting for the SQL Server instance is set to **No**.

- The client connection string doesn't explicitly specify a value for the encryption property, or the **Encryption** option wasn't explicitly set or updated in the DSN.

The error occurs because of a change in the default behavior of the client drivers. Older versions of client drivers assume that data encryption is **OFF** by default. The new drivers assume this setting is **ON** by default. Because data encryption is **ON**, the driver tries to validate the server's certificate and fails.

### Solutions for certificate chain trust error when upgrading to Microsoft OLE DB Driver 19

#### Use OLE DB Driver 18.x

Use Microsoft OLE DB Driver for SQL Server 18.x. You can download the driver from [Release notes for the Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server).

#### Disable mandatory encryption for OLE DB

Modify the encryption settings in your connection string:

- If the application connection string property already specifies a value of `Yes` or `Mandatory` for the `Encrypt/Use Encryption for Data` setting, change the value to `No` or `Optional`. For example, `Use Encryption for Data=Optional`.
- If the connection string doesn't specify any value for `Encrypt/Use Encryption for Data`, add `Use Encryption for Data=Optional` to the connection string.

For more information, see [Encryption and certificate validation](/sql/connect/oledb/features/encryption-and-certificate-validation).

#### Trust the server certificate without validation

Add `;TrustServerCertificate=true` to the SQL Server connection string. This setting tells the client to trust the certificate without validation.

> [!NOTE]
> Currently, MSOLEDBSQL19 prevents the creation of linked servers without encryption and a trusted certificate (a self-signed certificate is insufficient). If you need linked servers, use the existing supported version of MSOLEDBSQL.

## [Upgraded to Microsoft ODBC Driver 18.*x* for SQL Server](#tab/odbc-driver-18x)

After you upgrade from SQL Server Native Client 11.0 (Driver={SQL Server Native Client 11.0}) to Microsoft ODBC Driver 18 for SQL Server (Driver={ODBC Driver 18 for SQL Server}), connection attempts might fail with the following error message:

> \[Microsoft\]\[ODBC Driver 18 for SQL Server\]SSL Provider: The certificate chain was issued by an authority that is not trusted.

> \[Microsoft\]\[ODBC Driver 18 for SQL Server\]Client unable to establish connection

### Cause of certificate chain trust error when upgrading to Microsoft ODBC Driver 18

This error indicates that the client computer can't verify the authenticity of the SQL Server certificate because it was issued by a certificate authority (CA) that the client doesn't trust.

These errors occur if both of the following conditions are true:

- The **Force encryption** setting for the SQL Server instance is set to **No**.

- The client connection string doesn't explicitly specify a value for the encryption property, or the **Encryption** option wasn't explicitly set or updated in the DSN.

The error occurs because of a change in the default behavior of the client drivers. Older versions of client drivers assume that data encryption is **OFF** by default. The new drivers assume this setting is **ON** by default. Because data encryption is **ON**, the driver tries to validate the server's certificate and fails.

### Solutions for certificate chain trust error when upgrading to Microsoft ODBC Driver 18

#### Use ODBC Driver 17

Use the Microsoft ODBC Driver 17 for SQL Server. You can download the driver from [Download ODBC Driver for SQL Server](/sql/connect/odbc/download-odbc-driver-for-sql-server).

#### Disable mandatory encryption for ODBC

Modify the encryption settings in your connection string or DSN:

- If the application connection string property already specifies a value of `Yes` or `Mandatory` for `Encrypt`, change the value to `No` or `Optional`.
- If the value isn't already specified, add `Encrypt=Optional;` to the connection string.
- If you're using a DSN, change the encryption setting from `Mandatory` to `Optional`.

For more information, see [DSN and connection string keywords and attributes](/sql/connect/odbc/dsn-connection-string-attribute).

---

## Related content

- [Enable encrypted connections to the Database Engine](/sql/database-engine/configure-windows/enable-encrypted-connections-to-the-database-engine)
- [The certificate received from the remote server was issued by an untrusted certificate authority error when you connect to SQL Server](error-message-when-you-connect.md)
- [Certificate validation failure](certificate-validation-failure.md)
- [Support Policies for SQL Server Native Client](/sql/relational-databases/native-client/applications/support-policies-for-sql-server-native-client)
- [SNAC lifecycle explained](https://techcommunity.microsoft.com/t5/sql-server-blog/snac-lifecycle-explained/ba-p/385381)
