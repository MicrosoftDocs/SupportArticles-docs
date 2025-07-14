---
title: Access is denied error and SQL Server doesn't start
description: Provides resolutions for the problem where SQL Server fails to start  with Access is denied error.
ms.date: 01/17/2025
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: ramakoni, jopilov
ms.custom: sap:Startup, shutdown, restart issues (instance or database)
---
# "Access is denied" error and SQL Server doesn't start

_Applies to:_ &nbsp; SQL Server

## Symptoms

When you configure the Microsoft SQL Server service to run under an account that does not have sufficient privileges on the SQL Server installation folder, SQL Server does not start, and it returns an error message that resembles the following, depending on how you try to start the service:

- By using the Services applet:
  
    > Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.  
      Error 5: Access is denied.

- By using a command prompt:

    > C:\Users\username>NET START MSSQLSERVER  
    System error 5 has occurred.  
    Access is denied.

## Resolution

1. Open the System log, and verify that you see an error message entry that resembles the following:

    ```output
    Log Name:      System  
    Source:        Service Control Manager  
    Date:          <Datetime>  
    Event ID:      7000  
    Task Category: None  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:      <Server name>  
    Description:
    The SQL Server (MSSQLSERVER) service failed to start due to the following error:  
    Access is denied.
    ```

2. Using either Microsoft SQL Server Configuration Manager or Service Control Manager, note the service account for SQL Server service.
3. Go to the SQL Server installation folder (for example `C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Binn`) and do the following to check effective access of the SQL Service account:
    1. Right-click the file or folder, select **Properties**, and then select the **Security** tab.
    1. Select **Advanced**, select the **Effective Access** tab, and then select **Select a User** to either type in the SQL Service account or select from the list.
    1. Select **View Effective** access to understand and resolve the permissions issue. For example, if the Deny permission is added to the user or the group that the SQL Server service account is member of, remove the Deny permission and restart the SQL Server service.

    > [!NOTE]
    > You can also use [Process Monitor](/sysinternals/downloads/procmon) tool to identify and isolate the permission issues. The following screenshot of an example output from Process Monitor shows the \<DomainName>\sqlsrvlogin SQL Server service account generating an Access Denied error.

    :::image type="content" source="media/event-id-7000-access-denied/process-monitor.png" alt-text="Screenshot of an example output from Process Monitor." lightbox="media/event-id-7000-access-denied/process-monitor.png":::

## Reference

[Service Permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions#Serv_Perm)
