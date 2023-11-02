---
title: Use PFX-formatted certificates
description: This article describes the Microsoft PVKConverter for SQL Server tool. This tool supports the conversion of a certificate that uses the PFX format into PVK/DER format.
ms.date: 09/25/2020
ms.custom: sap:Security Issues
ms.reviewer: vencher
---
# Use PFX-formatted certificates in SQL Server

This article introduces the Microsoft PVKConverter for SQL Server tool. This tool supports the conversion of a certificate that uses the PFX format into PVK/DER format.

_Original product version:_ &nbsp; SQL Server 2014, SQL Server 2012, SQL Server 2008, SQL Server 2005  
_Original KB number:_ &nbsp; 2914662

## Summary

To use certificates that are in the PFX format in Microsoft SQL Server, use Microsoft PVKConverter for SQL Server to convert the PFX certificate files into PVK/DER format. To do this, follow these steps:

1. Download and install the following tool:

    [Microsoft PVKConverter for SQL Server](https://www.microsoft.com/download/details.aspx?id=40812)

2. Run the following command at a command prompt:

    ```console
    PVKConverter.exe -i <PFX format file> -o <PVK/DER format file> -d <Decryption password> -e <Encryption password>
    ```  

    This step processes a PFX certificate file in order to generate the following PVK/DER certificate pairs:

      - <**PVK/DER format file**>_1.cer
      - <**PVK/DER format file**>_2.cer and <**PVK/DER format file**>_2.pvk

    > [!NOTE]
    > The number of PVK/DER files that are generated depends on the number of public/private key pairs that are contained in the PFX file. One PVK/DER file pair is generated for each public/private key pair.

3. Use SQL Query Analyzer to run the following Transact-SQL script:

    ```sql
    CREATE CERTIFICATE >Certificate name>
     FROM FILE = '<PVK/DER format file>.cer'
     WITH PRIVATE KEY (FILE = '<PVK/DER format file>.pvk',
     DECRYPTION BY PASSWORD = '<Encryption password>');
    ```

    > [!NOTE]
    > The `Encryption password` placeholder represents the password that is provided through the -e option of PVKConverter.exe.

## More information

SQL Server supports the importing of existing security certificates that are specified as a pair of files that are encoded in PVK/DER format. The PVK file contains information about the certificate's private key, and the DER file contains the remaining information.

Windows Certificate Manager supports the export to PFX format only of existing certificates that contain private key information in Windows 2008. Windows 2008 has discontinued support for exporting to PVK/DER format. On the other hand, SQL Server does not support the importing of PFX encoded certificates. Therefore, there is currently an interoperability issue between Windows Certificate Manager and SQL Server.

> [!NOTE]
> If the serial number of your certificate is greater than 16 bytes, see the following article for your version of SQL Server.

- For Microsoft SQL Server 2014 Service Pack 1, see [3082513 FIX: TDE certificate creation fails in SQL Server 2014 SP1 if the serial number is greater than 16 bytes](https://support.microsoft.com/help/3082513).

- For other versions of SQL Server, see [Not able to use PFX format certificate in SQL Server?](https://techcommunity.microsoft.com/t5/sql-server-support/not-able-to-use-pfx-format-certificate-in-sql-server/ba-p/318593).

## Applies to

- SQL Server 2014 Developer
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise
- SQL Server 2014 Web
- SQL Server 2014 Web
- SQL Server 2014 Standard
- SQL Server 2014 Standard
- SQL Server 2014 Express
- SQL Server 2014 Express
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Web
- SQL Server 2012 Standard
- SQL Server 2012 Express
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Express
- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Workgroup
- SQL Server 2008 Web
- SQL Server 2008 Express
- Microsoft SQL Server 2005 Enterprise Edition
- Microsoft SQL Server 2005 Workgroup Edition
- Microsoft SQL Server 2005 Standard Edition
- Microsoft SQL Server 2005 Express Edition  
