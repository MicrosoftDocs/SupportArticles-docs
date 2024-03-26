---
title: Data Mart integration setup fails with nondefault SQL port
description: Can't configure a Microsoft Dynamics GP Data Mart integration by using a nondefault SQL Server port. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Management Reporter
---
# Configuring a Microsoft Dynamics GP Data Mart integration fails when you specify a nondefault SQL Server port

This article provides a resolution for the configuration fails issue that occurs when specifying a nondefault SQL Server port for a Microsoft Dynamics GP Data Mart integration.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2932875

## Symptom

When you try to configure a Microsoft Dynamics GP Data Mart integration by using Microsoft Dynamics GP 2013 SP2 and Microsoft Management Reporter 2012 and then specify a port number other than 1433 in name field for the instance of Microsoft SQL Server, the configuration fails. Additionally, you may receive the following error message:

> Couldn't retrieve the list of available databases: The connection attempt failed.

## Cause

Dexterity Shared Components SP2 (12.0.270.0) made a change to the Microsoft Dynamics GP logon function that is used by Management Reporter that removes the port number in the connection details and tries to make the connection to the instance of SQL Server over the default port of 1433.

## Resolution

To effectively circumvent the issue, use one of the following methods, depending on whether the instance of SQL Server on which the Microsoft Dynamics GP databases reside is using a named instance:

- If the instance of SQL Server on which the GP databases reside is using a named instance, follow these steps:

  1. In SQL Server Configuration Manager, start the SQL Server browser service.
  2. Open port 1434 (UDP) in the firewall for the instance of SQL Server.
- If the Microsoft Dynamics GP instance of SQL Server is using a default instance together with a nondefault port, create a SQL Server alias on the server on which Management Reporter 2012 is installed. To do this, follow these steps:
  1. Select **Start**, select **Run**, type *cliconfg.exe*, and then press Enter.

      > [!NOTE]
      > If MR is installed on a 64-bit server, you must create a 32-bit and 64-bit alias.
      >
      > - For 32-bit, go to C:\Windows\System32\cliconfg.exe
      > - For 64-bit, go to C:\Windows\SysWOW64\cliconfg.exe

  2. In Client Network Utility, select the **Alias** tab, and then select **Add**.
  3. On the **Add Network Library Configuration** page, select the TCP/IP radio dial, and then enter a name for the SQL Server alias. For example, type *MRConnect*.
  4. Enter the SQL Server name.
  5. Clear the **Dynamically determine port** check box, enter the port number for the instance of SQL Server, and then select **OK**.
  6. Enter the Microsoft Dynamics GP Data Mart integration information in the configuration console for Management Reporter 2012 by using the alias that you created for the Microsoft Dynamics GP SQL Server field.

## More information

Dexterity Shared Components SP1 (12.0.232.0) does not cause this issue if a nondefault port is being used to connect to the instance of SQL Server.
