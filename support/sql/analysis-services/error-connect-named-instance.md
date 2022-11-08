---
title: Error when you connect to a named instance
description: This article provides a resolution for the connectivity problem that occurs when a server that hosts a named instance of SQL Server Analysis Services server is configured to use IPv6.
ms.date: 11/09/2020
ms.custom: sap:Analysis Services
ms.prod: sql
---
# Error when you connect to a named instance of SQL Server Analysis Services by using IPv6

This article helps you resolve a problem that can occur when you connect to a named instance of SQL Server Analysis Services server that is configured to use IPv6.

_Original product version:_ &nbsp; SQL Server Enterprise  
_Original KB number:_ &nbsp; 2658571

## Symptoms

In Microsoft SQL Server, you receive an error that resembles the following when you try to connect to a named instance of SQL Server Analysis Services (SSAS) by using IPv6:

> No connection could be made because the target machine actively refused it [:: n ]: nnnnn (System)

> [!NOTE]
> In this error, n is an integer.

## Cause

This issue can occur if the server that hosts the named instance of SSAS was configured to use IPv4 and IPv6 when SQL Server was installed. Then, the server was later reconfigured to use only IPv6.

## Resolution

To resolve this issue, follow these steps:

1. Stop the SQL Server Analysis Services service.
2. Open the *Msmdredir.ini* file in Notepad.

   > [!NOTE]
   > By default, the *Msmdredir.ini* file is located in the following folder: `%ProgramFiles%\Microsoft SQL Server\90\Shared\ASConfig`.

3. In the **Instances** section, verify that the values for the **Port** property and the **IPv6** property are different for the named instance.
4. Delete the **PortIPV6** property.
5. Save the *Msmdredir.ini* file, and then exit **Notepad**.
6. Start the SQL Server Analysis Services service.

## More information

When SSAS detects that the host server is configured to listen on both IPv4 and IPv6, SSAS creates two entries in the *MSmdredir.ini* file. However, if the server is configured to listen on one protocol, the \<Port> entry is used.

Consider the scenario in which the server that hosts the named instance of SSAS was configured to use IPv4 and IPv6 when SQL Server was installed, and the server was later reconfigured to use only IPv6. In this scenario, the *Msmdredir.ini* file may contain stale entries that do not point to ports on which the SSAS named instance is listening.

When the SQL Server Analysis Services service starts, the service detects the protocols that are being used and updates the *Msmdredir.ini* file. If the server was configured to use both IPv4 and IPv6, there are two entries in the Msmdredir.ini file. However, if the SQL Server Analysis Services service detects that one protocol is being used, only the Port property is updated. Therefore, the PortIPv6 property may contain stale information.

When the SQL Browser service reads the stale information, it may redirect requests to the named instance and cause connection failures. When the stale information that is contained in the PortIPv6 property is deleted, the information in the Port property is used.
