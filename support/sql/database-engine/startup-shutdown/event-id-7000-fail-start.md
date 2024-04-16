---
title: Event ID 7000 and SQL Server doesn't start
description: This article provides resolutions for the problem where SQL Server fails to start and Event ID 7000 is logged in the System log.
ms.date: 01/28/2020
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: ramakoni
---
# Event ID 7000 and SQL Server doesn't start

_Applies to:_ &nbsp; SQL Server

## Symptoms

When the Microsoft SQL Server binary file (Sqlservr.exe) is renamed on the system that's hosting the SQL Server service, the service doesn't start, and you receive the following error message, depending on how you try to start the service:

- By using the Services applet:
  
    > Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.  
      Error 2: The system cannot find the file specified.

- By using a command prompt:

    > System error 2 has occurred.  
      The system cannot find the file specified.

## Resolution

1. Check the Windows System log, and verify that you see an error message entry that resembles the following:

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
    The system cannot find the file specified. 
    ```

1. Go to the SQL Server [installation folder](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server) and verify that it doesn't contain the Sqlservr.exe file.

1. Resolve the issue by repairing the SQL Server installation per the procedure that's documented in [Repair a Failed SQL Server Installation](/sql/database-engine/install-windows/repair-a-failed-sql-server-installation).
