---
title: Event ID 33566 and SQL Server doesn't start 
description: This article provides resolutions for the problem where SQL Server fails to start and event ID 33566 is logged in the Application event log.
ms.date: 12/17/2021
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: ramakoni
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
---
# Event ID 33566 and SQL Server doesn't start after you enable encryption

_Applies to:_ &nbsp; SQL Server

## Symptoms

In Microsoft SQL Server Configuration Manager, you provision a server-side certificate and enable the encryption. However, the SQL Server service doesn't start, and you receive the following error message:

> Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.  
If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code 13.

## Resolution

1. Check the Application log and verify that you see two event entries that resemble the following:

    ```output
    Log Name:      Application  
    Source:        MSSQLSERVER  
    Date:          <Datetime>
    Event ID:      33556  
    Task Category: Server  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:      <Server name> 
    Description:  
    Invalid character in the thumbprint [Cert Hash(sha1) " \<Cert Hash number"].
    Please provide a certificate with a valid thumbprint.
    ```

    > [!NOTE]
    > This error typically indicates that the certificate isn't provisioned through Configuration Manager. It's provisioned by manually copying the thumbprint value into the following registry key:
    >
    > `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQLServer\SuperSocketNetLib\Certificate`
    >
    > This error occurs if invalid characters are copied into the registry value.

2. To resolve this issue, use one of the following methods.

   **Method 1: Provision the certificate by using SQL Server Configuration Manager**

   1. Remove the thumb print value manually from the following registry subkey:

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQLServer\SuperSocketNetLib\Certificate`

   1. Use Configuration Manager to reprovision the certificate.
   1. Restart the SQL Server service.

   **Method 2: Fix invalid characters in Thumbprint value**

    1. Select **Start** > **Run**, enter *mmc*, and then open **Certificate Snap-in** in the MMC console.

    1. Right-click the certificate, and copy the **Thumbprint** value into a text file.
    Make sure that no spaces exist before and after the thumbprint value.
    1. Remove the **Thumbprint** value manually from the following registry subkey:

        `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQLServer\SuperSocketNetLib\Certificate`
    1. Manually paste the new value, or retype the value that you got from the text file.
    1. Restart the SQL Server service.
