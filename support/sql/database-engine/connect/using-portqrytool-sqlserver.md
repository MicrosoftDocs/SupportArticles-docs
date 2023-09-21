---
title: Using the PortQryUI tool with SQL Server
description: PortQryUI is a UI tool for SQL Server that helps you view the open ports on a computer that uses the command-line version, Portqry.exe.
ms.date: 03/09/2022
ms.reviewer: ramakoni, v-jayaramanp
ms.custom: sap:Connection Issues
---

# Using the PortQryUI tool with SQL Server

PortQry is a command-line tool that you can use to help troubleshoot TCP/IP connectivity issues. The tool reports the status of target TCP and User Datagram Protocol (UDP) ports on a local or remote computer. *PortQryUI.exe* enables you to use the UI instead of the command line for PortQry.

This article discusses how to use the PortQryUI tool when you troubleshoot connectivity issues that affect Microsoft SQL Server. For more information about the PortQry command-line tool, see [Using the PortQry command-line tool](../../../windows-server/networking/portqry-command-line-port-scanner-v2.md).

> [!NOTE]
> Since PortQryUI is intended to be used as a troubleshooting tool, you should have sufficient knowledge of your computing environment to be able to use the tool effectively.

## About the PortQryUI tool

The PortQryUI tool helps you to perform the following tasks:

- Resolve TCP/IP connectivity issues.
- Show the status of the TCP and UDP ports on a local or remote computer.
- Troubleshoot various connectivity issues that affect SQL Server.

You can download the PortQryUI tool from the Microsoft Download Center:

[PortQryUI - User Interface for the PortQry Command Line Port Scanner](https://www.microsoft.com/download/details.aspx?id=24009)

## Working with the PortQryUI tool

To resolve connectivity issues on your computer or a remote computer, follow these steps:

1. Start **PortQryUI** on your client computer (that is experiencing connectivity issues).
1. In the **Enter destination IP or FQDN to query box**, specify the IP address or FQDN name of the computer for which you want to know the status of the ports.
1. Select **Query predefined service**, and then select **SQL Service**.
   The ports on the computer are grouped by the type of service that they're used for. You can query by the service type. The predefined services are as follows:

   - Domains and Trusts
   - DNS Queries
   - NetBIOS communication
   - IPSEC
   - SQL Service
   - WEB Service
   - Exchange Server
   - Netmeeting and other services

1. After you specify the information, select **Query**, and then check the output. For more information about how to decode the output that's shown by the PortQryUI tool, see the [Possible causes of SQL Server connection issues and suggested workarounds](#possible-causes-of-sql-server-connection-issues-and-suggested-workarounds) section.

> [!NOTE]
> If you have administrator access to your SQL Server-based computer, you can download and run the SQL Connectivity Settings Check tool on that computer, and review the output in conjunction with the next section.

## Possible causes of SQL Server connection issues and suggested workarounds

**Type of instance**: Default instance

**Output from PortQry**: `TCP port 1433 (ms-sql-s service): NOT LISTENING`

**Possible causes**: This issue could have any of the following causes:

- SQL Server hasn't started.
- TCP/IP isn't enabled on the SQL Server protocol list.
- SQL Server is listening on a non-default port (check errorlog).
- A firewall between the client and the server is blocking the port.

**Suggested workarounds**: Try the following workarounds:

- Make sure that SQL Server has started.
- Make sure that TCP/IP is enabled for your server instance in the SQL Server network configuration.
- Check the SQL Server error log for the port number. Use that in your connection strings in the *servername\portnumber* format.
- Contact your network or Windows administrator to make sure that TCP port 1433 (or the currently configured SQL Server port) isn't blocked by a firewall on the network or by the Windows firewall on the SQL Server system. To configure Windows firewall to work together with the SQL Server instance, review [Configure Windows Firewall](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access?view=sql-server-ver15&preserve-view=true).
  
**Type of instance**: Default instance

**Output from PortQry**: `TCP port 1433 (ms-sql-s service): LISTENING`

**Possible cause**: This issue indicates that the client library can connect to the SQL Server-based computer, but something else in the application layer could be causing the problem.

**Suggested workarounds**: Try the following workarounds:

- Check whether the server name is specified correctly in the connection string. If the connection string is using the port number, make sure that it's specified correctly.
- If the connection string is using the port number, make sure that it's set to the correct value. Make sure that no old aliases are defined on the client computers.
- Check for the presence of an alias to your SQL Server instance either in [SQL Server Configuration Manager](/sql/database-engine/configure-windows/create-or-delete-a-server-alias-for-use-by-a-client) or on the **Alias** tab in the SQL Server Client Network Utility (Cliconfg.exe) on your client system.

**Type of instance**: Named instance

**Output from PortQry**: `UDP port 1434 (ms-sql-m service): FILTERED`

**Possible causes**: This issue could have any of the following causes:

- The SQL Server named instance hasn't started.
- The SQL Server browser hasn't started on the system that's hosting your SQL Server instance.
- UDP port 1434 is blocked by a firewall on the SQL Server-based computer or in the network between the client and the server.
- The service is started.

**Suggested workarounds**: Try the following workarounds:

- Start your SQL Server named instance.
- Try to start the SQL Server browser service.
- Work with your network or Windows administrator to make sure that UDP port 1434 isn't blocked by a firewall on the network or by the Windows firewall on the SQL Server system. To configure Windows firewall to work together with SQL Server, see [Configure Windows Firewall](/sql/sql-server/install/configure-the-windows-firewall-to-allow-sql-server-access?view=sql-server-ver15&preserve-view=true).
- If UDP 1434 can't be opened on your firewalls, you should configure your SQL Server named instance to listen on a static port, and use *servername\portnumber* in your connection strings.

**Type of instance**: Named instance

**Output from PortQry**: `UDP port 1434 is LISTENING`

**Possible causes**: This issue indicates that the client library can connect to the SQL Server-based computer. However, something else in the application layer could be causing the problem.

**Suggested workarounds**: Try the following workarounds:

- Make sure that the server name and port number are specified correctly in the connection string.
- Make sure that there aren't any old aliases defined on the client computers. Do check for the presence of an alias to your SQL Server instance either in SQL Server Configuration Manager or the **Alias** tab in the SQL Server Client Network Utility (*Cliconfg.exe*) on your client system.

There could be different scenarios in connectivity issues when you use the PortQryUI tool. Each of the following screenshots displays the output based on the type of instance and whether the connection was successful. If the connection occurs correctly, a value of "Listening" is shown. If the connection doesn't occur, a value of "Filtered" is shown.

The following output is from a default instance on a default port where the connection was successful.

:::image type="content" source="media/using-port-qry-ui-sql-server/default-instance-working-scenario.png" alt-text="Screenshot showing the default instance on a default port where the connection was successful.":::

If the connection is unsuccessful for a default instance on a default port, the output is displayed as shown in the following screenshot.

:::image type="content" source="media/using-port-qry-ui-sql-server/default-instance-non-working-scenario.png" alt-text="Screenshot showing an unsuccessful connection for the default instance on a default port.":::

If the connection is successful for a named instance (for example, the instance name is "SQL 2014" and the host name is "SQLCONNVM"), the output is displayed as shown in the following screenshot.

:::image type="content" source="media/using-port-qry-ui-sql-server/named-instance-working-scenario.png" alt-text="Screenshot of a successful connection for a named instance.":::

If the connection is unsuccessful for a named instance, the output is displayed as shown in the following screenshot.

:::image type="content" source="media/using-port-qry-ui-sql-server/named-instance-non-working-scenario.png" alt-text="Screenshot showing an unsuccessful connection for a named instance.":::
