---
title: Certificate Chain Not Trusted After Driver Upgrade
description: Troubleshoot and fix "The certificate chain was issued by an authority that is not trusted" errors after upgrading to OLE DB or ODBC drivers for SQL Server.
ms.date: 08/26/2026
ms.reviewer: v-jayaramanp, jopilov, v-shaywood
ms.custom: sap:Database Connectivity and Authentication
---

# "The certificate chain was issued by an authority that is not trusted" error after upgrading SNAC applications

## Summary

This article helps you troubleshoot certificate chain trust errors that occur when you upgrade database applications from SQL Server Native Client 11.0 (SNAC) to Microsoft OLE DB Driver 19 or Microsoft ODBC Driver 18 for SQL Server.

When you upgrade from SNAC 11.0 to newer drivers, your applications might fail to connect to SQL Server with certificate chain trust errors. This problem happens because the newer drivers enable [encryption](/sql/relational-databases/security/securing-sql-server#encryption-and-certificates) by default and require certificate validation, while SNAC disabled it by default. To fix the error, provision a certificate that the client trusts, or adjust the `Encrypt`, `Use Encryption for Data`, or `TrustServerCertificate` connection settings as described in this article.

## Which encryption keyword applies to your driver and client

The keyword that controls encryption depends on the driver and on how your application builds its connection string. If you use a keyword that the driver doesn't recognize, the connection fails with a "keyword not supported" error instead of the certificate error.

| Driver and connection method | Encryption keyword | Certificate trust keyword |
|---|---|---|
| OLE DB Driver 19, provider string (`IDBInitialize::Initialize`) | `Encrypt` | `TrustServerCertificate=yes` or `no` |
| OLE DB Driver 19, ADO or initialization string (`IDataInitialize`) | `Use Encryption for Data` | `Trust Server Certificate=true` or `false` |
| ODBC Driver 18, connection string or DSN | `Encrypt` | `TrustServerCertificate=yes` or `no` |

- **OLE DB Driver 19:** Accepts `Optional`, `Mandatory` (default), and `Strict`. For backward compatibility, it also accepts the version 18 values, where `no` and `false` map to `Optional`, and `yes` and `true` map to `Mandatory`.
- **ODBC Driver 18:** Accepts `yes`/`mandatory` (the default), `no`/`optional`, and `strict`.
- **Provider strings:** Use `TrustServerCertificate=yes` or `TrustServerCertificate=no`.
- **ADO and initialization strings:** Use `Trust Server Certificate=true` or `Trust Server Certificate=false`.
- **Strict mode:** Always validates the server certificate and ignores the certificate trust setting.

Using `TrustServerCertificate=true` in a provider string can return an invalid value error.

For the complete keyword lists, see [Using connection string keywords with OLE DB Driver for SQL Server](/sql/connect/oledb/applications/using-connection-string-keywords-with-oledb-driver-for-sql-server), [Major version differences in MSOLEDBSQL](/sql/connect/oledb/major-version-differences), and [DSN and connection string keywords and attributes](/sql/connect/odbc/dsn-connection-string-attribute).

## Certificate chain error, cause, and solutions for OLE DB Driver 19 and ODBC Driver 18

Select the tab for the driver you upgraded to. Each tab shows the error message you see, why it occurs, and the solutions in recommended order.

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

#### Install a certificate that the client trusts (recommended)

Provision a TLS certificate on the SQL Server instance from a certificate authority that the client trusts. Make sure the server supplies any required intermediate certificates so that the client can build the chain to a trusted root CA. This approach resolves the error while keeping encryption and certificate validation enabled. For more information, see [Configure SQL Server Database Engine for encrypting connections](/sql/database-engine/configure-windows/configure-sql-server-encryption).

#### Trust the server certificate without validation

If you can't provision a verifiable certificate right away, tell the driver to skip certificate validation. The keyword you use depends on how your application builds the connection string:

- In a provider string, add `TrustServerCertificate=yes`.
- In an ADO or initialization string, add `Trust Server Certificate=true`.

This setting doesn't turn on encryption by itself. It tells the driver to skip certificate validation when the connection is encrypted, which leaves the connection vulnerable to adversary-in-the-middle attacks. Use it only as a temporary measure. In `Strict` encryption mode, the driver ignores this setting and always validates the certificate.

> [!NOTE]
> Currently, MSOLEDBSQL19 prevents the creation of linked servers without encryption and a trusted certificate (a self-signed certificate is insufficient). If you need linked servers, use the existing supported version of MSOLEDBSQL.

#### Set the encryption keyword to Optional

Change the encryption setting so that the driver doesn't require a validated certificate. The keyword you use depends on how your application builds the connection string:

- In a provider string, set `Encrypt=Optional`.
- In an ADO or initialization string, set `Use Encryption for Data=Optional`.

The default value in OLE DB Driver 19 is `Mandatory`. If the connection string already specifies `Mandatory`, `yes`, or `true`, change the value to `Optional`. If the connection string doesn't specify a value, add the keyword. This change restores the version 18 encryption behavior and reduces the security of the connection.

For more information, see [Encryption and certificate validation in OLE DB](/sql/connect/oledb/features/encryption-and-certificate-validation).

#### Use OLE DB Driver 18.x as a temporary measure

Microsoft OLE DB Driver for SQL Server 18.x doesn't enable encryption by default, so it isn't affected by this change. Treat this option as temporary and plan your move to OLE DB Driver 19. You can download the driver from [Release notes for the Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server).

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

#### Install a certificate that the ODBC client trusts (recommended)

Provision a TLS certificate on the SQL Server instance from a certificate authority that the client trusts. Make sure the server supplies any required intermediate certificates so that the client can build the chain to a trusted root CA. This approach resolves the error while keeping encryption and certificate validation enabled. For more information, see [Configure SQL Server Database Engine for encrypting connections](/sql/database-engine/configure-windows/configure-sql-server-encryption).

#### Trust the server certificate without validation in ODBC

If you can't provision a verifiable certificate right away, bypass validation in one of the following ways:

- In a connection string, add `TrustServerCertificate=yes`.
- In a DSN, select the **Trust server certificate** option.

This setting doesn't turn on encryption by itself. It tells the driver to skip certificate validation when the connection is encrypted, which leaves the connection vulnerable to adversary-in-the-middle attacks. Use it only as a temporary measure. The **Trust server certificate** option applies only when **Connection Encryption** is set to **Optional** or **Mandatory**. The driver ignores it and always validates the certificate when you use **Strict**.

#### Set Encrypt to Optional in the connection string or DSN

Modify the encryption settings in your connection string or DSN:

- If the connection string specifies `Encrypt=yes` or `Encrypt=mandatory`, change the value to `Encrypt=no` or `Encrypt=optional`.
- If the connection string doesn't specify a value, add `Encrypt=optional;`. The default value is `yes` in ODBC Driver 18 and later versions, and `no` in earlier versions.
- If you use a DSN, open **ODBC Data Source Administrator**, select your data source, and then select **Configure**. Continue through the wizard to the screen that contains **Connection Encryption**, set it to **Optional**, and then select **Finish** to save the DSN.

For more information, see [DSN and connection string keywords and attributes](/sql/connect/odbc/dsn-connection-string-attribute) and [ODBC Data Source Administrator DSN options](/sql/connect/odbc/windows/odbc-administrator-dsn-creation).

#### Use ODBC Driver 17 as a temporary measure

Microsoft ODBC Driver 17 for SQL Server doesn't enable encryption by default, so it isn't affected by this change. Treat this option as temporary and plan your move to ODBC Driver 18. You can download the driver from [Download ODBC Driver for SQL Server](/sql/connect/odbc/download-odbc-driver-for-sql-server).

---

## Related content

- [Enable encrypted connections to the Database Engine](/sql/database-engine/configure-windows/enable-encrypted-connections-to-the-database-engine)
- [The certificate received from the remote server was issued by an untrusted certificate authority error when you connect to SQL Server](error-message-when-you-connect.md)
- [Certificate validation failure](certificate-validation-failure.md)
- [Support Policies for SQL Server Native Client](/sql/relational-databases/native-client/applications/support-policies-for-sql-server-native-client)
- [SNAC lifecycle explained](https://techcommunity.microsoft.com/t5/sql-server-blog/snac-lifecycle-explained/ba-p/385381)
