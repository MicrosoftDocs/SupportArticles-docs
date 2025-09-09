---
title: Event ID 33565 and SQL Server doesn't start
description: This article provides resolutions for the problem where SQL Server fails to start and event ID 33565 is logged in the Application event log.
ms.date: 05/08/2025
author: aartig13
ms.author: aartigoyle
ms.reviewer: ramakoni, jopilov
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
---
# Event ID 33565 and SQL Server doesn't start after you enable encryption

_Applies to:_ &nbsp; SQL Server

## Symptoms

In Microsoft SQL Server Configuration Manager, you provision a server-side certificate and enable the encryption. When you use Service Control Manager to start the SQL Server service, the service doesn't start, and you receive the following error message:

> Windows could not start the SQL Server (MSSQLSERVER) on Local Computer. For more information, review the System Event Log.  
> If this is a non-Microsoft service, contact the service vendor, and refer to service-specific error code -2146885628.

## Resolution

1. Check the Application event log and verify that you see two event entries that resemble the following:

    ```output
    Log Name:      Application  
    Source:        MSSQLSERVER  
    Date:          <Datetime>  
    Event ID:      26010  
    Task Category: Server  
    Level:         Information  
    Keywords:      Classic  
    User:          N/A  
    Computer:      <Server name>  
    Description:  
    The server could not load the certificate it needs to initiate an SSL connection.
    It returned the following error: 0x8009030d. Check certificates to make sure they are valid.

    Log Name:      Application  
    Source:        MSSQLSERVER  
    Date:          <Datetime>  
    Event ID:      33565  
    Task Category: Server  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:      <Server name>  
    Description:  
    Found the certificate [Cert Hash(sha1) "<Cert Hash number>"] in the local computer store but the SQL Server service account does not have access to it.
    ```

2. If you see both Events 26010 and 33565, follow these steps:

   > [!NOTE]
   > - The two events indicate that the SQL Server service account doesn't have permissions to the certificate that's provisioned in Configuration Manager. You must assign the required permissions to the service account to fix this issue.
   > - If you don't see both Event 26010 and 33565, you might be experiencing a different issue that's not addressed in this article.

    1. Select **Start** > **Run**, enter *mmc*, and then open **Certificate Snap-in** in the MMC console.
    1. On the **Console** menu, select **Add/Remove Snap-in**.
    1. Select **Add** > **Certificates**, and then select **Add** again.

        > [!NOTE]
        > You're prompted to open the snap-in for the current user, service, or computer account.

    1. Select the computer account.
    1. Select **Local computer**, and then select **Finish**.
    1. In the **Add Standalone Snap-in** dialog box, select **Close**.
    1. In the **Add/Remove Snap-in** dialog box, select **OK**.

        > [!NOTE]
        > Your installed certificates are in the Certificates folder in the Personal container.

    1. Right-click the certificate, select **All Tasks** > **Manage Private Keys**, and then grant full permissions to the SQL Server service account.

## Reference

[Enable encrypted connections to the Database Engine](/sql/database-engine/configure-windows/enable-encrypted-connections-to-the-database-engine)
