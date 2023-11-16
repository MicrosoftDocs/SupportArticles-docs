---
title: Always Encrypted-enabled databases fail
description: This article provides resolutions for the problem that causes the .NET Framework 4.6.2 client application to fail when accessing data from an Always Encrypted-enabled database.
ms.date: 02/17/2020
ms.custom: sap:Security Issues
---
# The .NET Framework 4.6.2 client driver for Always Encrypted intermittently fails during row decryption

This article provides resolution for the problem that causes the .NET Framework 4.6.2 client application to fail when accessing data from an Always Encrypted-enabled database.

_Original product version:_ &nbsp; SQL Server 2016, SQL Server 2017  
_Original KB number:_ &nbsp; 3204545

## Symptoms

You have a client application that uses the .NET Framework Data Provider for Microsoft SQL Server (Sqlclient) that's included in the Microsoft .NET Framework 4.6.2. You use this application to connect to an **Always Encrypted**-enabled database that's running on Microsoft SQL Server 2016, SQL Server 2017 on Windows or Microsoft Azure SQL Database.

When you try to decrypt the records from the **Always Encrypted**-enabled database, you receive intermittent error messages that resemble the following error:

> Decryption failed. The last 10 bytes of the encrypted column encryption key are: 7E-0B-E6-D3-39-CE-35-86-2F-AA.The first 10 bytes of ciphertext are: 01-C3-D7-39-33-2F-E6-44-C3-B1.Specified ciphertext has an invalid authentication tag.

When this problem occurs, queries against columns that are protected by the **Always Encrypted** setting may display incorrect results, for example, too few records are returned. This, in turn, may trigger incorrect behavior. For example, the client application tries to insert missing values or run other update processes that either create additional errors or cause inconsistent data in the database.

## Resolution

To fix this issue, install the security update from [Microsoft Security Bulletin MS16-155](/security-updates/SecurityBulletins/2016/ms16-155).

## Workaround

> [!IMPORTANT]
> If your client application is hosted through Web Apps on Microsoft Azure App Service, the client automatically uses the .NET Framework 4.6.2. Therefore, you may encounter the problem that is mentioned in the **Symptoms** section. In this scenario, you can use only the Method 2 workaround ("Turn off column encryption") in this section until a fix for this problem is released.

To work around this problem, follow these guidelines, as appropriate:

- The .NET client isn't yet upgraded to version 4.6.2

   In the environments that are mentioned in the **Symptoms** section, we recommend that you don't upgrade to the .NET Framework 4.6.2 until this problem is fixed. This problem doesn't affect earlier versions of the driver.

- The .NET client is already upgraded to 4.6.2

  Use one of the following methods:

  - Method 1: Roll back the .NET Framework version

    Uninstall the .NET Framework 4.6.2 from the system's hosting client applications. This forces the applications to use an older version of the NET Framework Data Provider for SQL Server that doesn't experience this problem. To do this, follow these steps:

    1. In **Control Panel**, open the **Programs** item, and then select **Programs and Features**.
    2. Select **View installed updates**, and then uninstall **Update for Microsoft Windows KB3120737**.

    > [!NOTE]
    > We recommend that after you uninstall any version of the .NET Framework, you test .NET Framework-dependent applications. These applications may not function correctly if you uninstall the version of the .NET Framework that they are dependent on.

  - Method 2: Turn off column encryption key caching

    If you can't roll back the .NET Framework installation, turn off column encryption key (CEK) caching. To do this, set the [SqlConnection.ColumnEncryptionKeyCacheTtl Property](/dotnet/api/system.data.sqlclient.sqlconnection.columnencryptionkeycachettl) in the client application to 0. For example, run the following code to disable column encryption in C# applications:

    ```csharp
    System.Data.SqlClient.SqlConnection.ColumnEncryptionKeyCacheTtl = TimeSpan.Zero
    ```

After you use either method, verify that the error doesn't reappear during a table scan (such as SELECT * FROM <
**table with Always Encrypted**>) that's run from a query window in SSMS over a database connection that has **Column Encryption Setting=Enabled** in the connection string. Running this kind of scan validates the correct encryption.

> [!IMPORTANT]
> Users who experience the problem that is described in the **Symptoms** section during the validation scan should contact
sqlalwaysencrypted@microsoft.com. The Support team can help recover all previously encrypted rows that are affected by this bug. This bug doesn't cause permanent data loss.

## References

[.NET Framework 4.6.2 client driver for Always Encrypted resulting in intermittent failures to decrypt individual rows](/archive/blogs/sqlreleaseservices/net-4-6-2-framework-client-driver-for-always-encrypted-resulting-in-intermittent-failures-to-decrypt-individual-rows)
