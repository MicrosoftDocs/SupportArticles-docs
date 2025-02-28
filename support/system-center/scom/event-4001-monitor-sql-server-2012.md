---
title: Event 4001 is logged during SQL Server 2012 monitoring
description: Describes an issue that event 4001 occurs when you monitor a SQL Server 2012 computer that has the System Center 2012 Operations Manager agent installed.
ms.date: 04/15/2024
---
# Event 4001 in the Operations Manager log during SQL Server 2012 monitoring

This article helps you fix an issue where event 4001 is logged in the Operations Manager log when you monitor a Microsoft SQL Server 2012 computer that has the System Center 2012 Operations Manager agent installed.

_Original product version:_ &nbsp; System Center 2012 Operations Manager, System Center 2012 Operations Manager Service Pack 1  
_Original KB number:_ &nbsp; 2962161

## Symptoms

When you are monitoring a SQL Server 2012 computer that has the System Center 2012 Operations Manager agent installed, you notice that event 4001 is logged in the Operations Manager log:

> Log Name: Operations Manager  
Source: Health Service Script  
Date:  
Event ID: 4001  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A Computer: SQLServer01.contoso.com  
Description: GetSQL2012SPNState.vbs : The Query 'SELECT ProtocolName FROM ServerNetworkProtocol where Enabled = true and InstanceName = 'SQLSERVERINSTANCE'' did not return any valid instances. Please check to see if this is a valid WMI Query. Invalid class  

You may also find that invalid class error **0x80041010** is returned when you try to open SQL Server Configuration Manager, as in the following error message:

> Cannot connect to WMI provider. You do not have permission or the server is unreachable. Note that you can only manage SQL Server 2005 and later servers with SQL Server Configuration Manager. Invalid class [0x80041010]

## Cause

This issue may occur if there are SQL Server classes that are missing or are not registered in Windows Management Instrumentation (WMI) on the computer that's running SQL Server.

## Resolution

To resolve this issue, follow these steps:

1. Open a Command Prompt (Run As Administrator) window.
2. Run the following command:

    ```console
    mofcomp C:\Program Files (x86)\Microsoft SQL Server\110\Shared\sqlmgmproviderxpsp2up.mof
    ```

## More information

If you notice that the same 4001 event is in the Operations Manager log, and you are running a version of SQL Server other than SQL Server 2012, run the `mofcomp` command from the path that matches the SQL Server version that's being monitored as follows:

C:\Program Files (x86)\Microsoft SQL Server\\*SQLversion*\Shared.

Here are some possible versions:

- Microsoft SQL Server 2012 110
- Microsoft SQL Server 2008 R2 100
- Microsoft SQL Server 2008 100
- Microsoft SQL Server 2005 90
