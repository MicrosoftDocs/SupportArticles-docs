---
title: The certificate chain was issued by an authority that isn't trusted
description: This article provides resolutions for the error that occurs when you upgrade SNAC applications.
ms.date: 02/28/2023
ms.reviewer: v-jayaramanp
ms.custom: sap:Connection issues
---

# "The certificate chain was issued by an authority that is not trusted" error after upgrading SNAC applications

Support for the SQL Server Native Client 11.0 (SNAC) as a driver for database applications ended on July 12, 2022. Any applications that use the SNAC 11.0 must be updated to use newer versions of the drivers (see [Download ODBC Driver for SQL Server](/sql/connect/odbc/download-odbc-driver-for-sql-server) and [Download Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/download-oledb-driver-for-sql-server)). This article describes an issue that occurs when you upgrade your SNAC 11.0 application to use either Microsoft OLE DB Driver 19 for SQL Server or Microsoft ODBC Driver 18.*x* for SQL Server.

## [Upgraded to Microsoft OLE DB Driver 19 for SQL Server](#tab/ole-db-driver-19)

If you recently upgraded your SQL Server Native Client 11.0 (Provider=SQLNCLI11) application to use Microsoft OLE DB Driver 19 for SQL Server (Provider=MSOLEDBSQL19), you might receive error messages that resemble the following messages:

> [Microsoft OLE DB Driver 19 for SQL Server]: Client unable to establish connection

> [Microsoft OLE DB Driver 19 for SQL Server]: SSL Provider: The certificate chain was issued by an authority that is not trusted.

### Cause

These errors occur if both the following conditions are true:

- The **Force encryption** setting for the SQL Server instance is set to **No**.

- The client connection string doesn't explicitly specify a value for encryption property, or the **Encryption** option wasn't explicitly set or updated in the DSN.

The error occurs because of a change in the default behavior of the client drivers. Older versions of client drivers are designed to assume that data encryption is **OFF** by default. The new drivers assume this setting to be **ON** by default. Because data encryption is set to **ON**, the driver tries to validate the server's certificate and fails.

### Solutions

- **Solution 1:** Use Microsoft OLE DB Driver for SQL Server 18.x. You can download the driver from [Release notes for the Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server).

- **Solution 2:** If the application connection string property already specifies a value of **Yes** or **Mandatory** for the **Encrypt/Use Encryption for Data setting**, change the value to **No** or **Optional**. For example, **Use Encryption for Data=Optional**. If the connection string doesn't specify any value for **Encrypt/Use Encryption for Data**, add **Use Encryption for Data=Optional** to the connection string. For more information, see [Encryption and certificate validation](/sql/connect/oledb/features/encryption-and-certificate-validation).

- **Solution 3:** Add `;TrustServerCertificate=true` to the connection string. This will force the client to trust the certificate without validation.

- > [!NOTE]
    > Currently, MSOLEDBSQL19 prevents the creation of linked servers without encryption and a trusted certificate (a self-signed certificate is insufficient). If linked servers are required, use the existing supported version of MSOLEDBSQL.
        

## [Upgraded to Microsoft ODBC Driver 18.*x* for SQL Server](#tab/odbc-driver-18x)

If you recently upgraded your SQL Server Native Client 11.0 (Driver={SQL Server Native Client 11.0}) application to Microsoft ODBC Driver 18 for SQL Server (Driver={ODBC Driver 18 for SQL Server}), you might receive error messages that resemble the following messages:

> [Microsoft][ODBC Driver 18 for SQL Server]SSL Provider: The certificate chain was issued by an authority that is not trusted.

> [Microsoft][ODBC Driver 18 for SQL Server]Client unable to establish connection

### Cause

These errors occur if both the following conditions are true:

- The **Force encryption** setting for the SQL Server instance is set to **No**.

- The client connection string doesn't explicitly specify a value for encryption property, or the **Encryption** option wasn't explicitly set or updated in the DSN.

The error occurs because of a change in the default behavior of the client drivers. Older versions of client drivers are designed to assume that data encryption is **OFF** by default. The new drivers assume this setting to be **ON** by default. Because data encryption is set to **ON**, the driver tries to validate the server's certificate and fails.

### Solutions

- **Solution 1:** Use the Microsoft ODBC Driver 17 for SQL Server. You can download the driver from [Download ODBC Driver for SQL Server](/sql/connect/odbc/download-odbc-driver-for-sql-server).

- **Solution 2:** If the application connection string property already specifies a value of **Yes** or **Mandatory for Encrypt** setting, change the value to **No** or **Optional**. If the value isn't already specified, add `Encrypt = Optional;`. If you're using a DSN, change the encryption setting from **Mandatory** to **Optional**. For more information, see [DSN and connection string keywords and attributes](/sql/connect/odbc/dsn-connection-string-attribute).

---

## See also

- [Enable encrypted connections to the Database Engine](/sql/database-engine/configure-windows/enable-encrypted-connections-to-the-database-engine)

- [The certificate received from the remote server was issued by an untrusted certificate authority error when you connect to SQL Server](../connect/error-message-when-you-connect.md)

- [Support Policies for SQL Server Native Client](/sql/relational-databases/native-client/applications/support-policies-for-sql-server-native-client)

- [SNAC lifecycle explained](https://techcommunity.microsoft.com/t5/sql-server-blog/snac-lifecycle-explained/ba-p/385381)
