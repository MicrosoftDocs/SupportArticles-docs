---
title: Event ID 7000 and SQL Server doesn't start
description: This article provides resolutions for the problem where SQL Server fails to start and Event ID 7000 is logged in the System log.
ms.date: 1/28/2020
author: cobibi
ms.author: v-yunhya
ms.reviewer: ramakoni
---
# Event ID 7000 and SQL Server doesn't start

_Applies to:_ &nbsp; SQL Server

## Symptoms

When the Microsoft SQL Server binary file (Sqlservr.exe) is renamed on the system that’s hosting the SQL Server service, the service doesn't start, and you receive the following error message, depending on how you try to start the service:

- By using the Services applet:
  
    > Windows could not start the SQL Server (MSSQLSERVER) service on Local Computer.  
      Error 2: The system cannot find the file specified.

- By using a command prompt:

    > System error 2 has occurred.  
      The system cannot find the file specified.

## Resolution

1. Check the Windows System log, and verify that you see an error message entry that resembles the following:

    > Log Name:      System  
    Source:        Service Control Manager  
    Date:          \<Datetime>  
    Event ID:      7000  
    Task Category: None  
    Level:         Error  
    Keywords:      Classic  
    User:          N/A  
    Computer:      \<Servername>
    Description:
    The SQL Server (MSSQLSERVER) service failed to start due to the following error:  
    The system cannot find the file specified.  
    Event Xml: \<*following xml*>

    ```xml
    <Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">  
      <System>  
        <Provider Name="Service Control Manager" Guid="{555908d1-a6d7-4695-8e1e-26931d2012f4}" EventSourceName="Service Control Manager" />  
        <EventID Qualifiers="49152">7000</EventID>  
        <Version>0</Version>  
        <Level>2</Level>  
        <Task>0</Task>  
        <Opcode>0</Opcode>  
        <Keywords>0x8080000000000000</Keywords>  
        <TimeCreated SystemTime="2020-12-30T07:54:53.805346700Z" />  
        <EventRecordID>6116</EventRecordID>  
        <Correlation />  
        <Execution ProcessID="944" ThreadID="2076" />  
        <Channel>System</Channel>  
        <Computer>Servername</Computer>  
        <Security />  
      </System>  
      <EventData>  
        <Data Name="param1">SQL Server (MSSQLSERVER)</Data>  
        <Data Name="param2">%%2</Data>  
        <Binary>4D005300530051004C005300450052005600450052000000</Binary>  
      </EventData>  
    </Event>
    ```

1. Go to the SQL Server [installation folder](/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server) and verify that it doesn't contain the Sqlservr.exe file.

1. Resolve the issue by repairing the SQL Server installation per the procedure that's documented in [Repair a Failed SQL Server Installation](/sql/database-engine/install-windows/repair-a-failed-sql-server-installation).
