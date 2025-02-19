---
title: A network-related or instance-specific error occurred
description: Provides troubleshooting steps for network-related or instance-specific errors if you can't connect to an instance of the SQL Server Database Engine on a single server.
ms.date: 01/10/2025
ms.custom: sap:Database Connectivity and Authentication
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: jopilov
---
# A network-related or instance-specific error occurred while establishing a connection to SQL Server

_Applies to:_ &nbsp; SQL Server

When connecting to a SQL Server instance, you may encounter one or more of the following [error messages](#error-messages). This article provides some steps to help you troubleshoot these errors, which are provided in order of the issues from simple to complex.

## Error messages

The complete error messages vary depending on the client library that's used in the application and the server environment. You can check the following details to see if you're encountering one of the following error messages:

### "A network-related or instance-specific error occurred while establishing a connection to SQL Server. Verify that the instance name is correct and that SQL Server is configured to allow remote connections"

<details>
<summary>provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server (Microsoft SQL Server, Error: 53)</summary>
  
A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.<br/>
provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server (Microsoft SQL Server, Error: 53)<br/>
provider: TCP Provider, error: 0 - No such host is known. (Microsoft SQL Server, Error: 11001)
<br/><br/>
</details>

<details>
<summary>provider: SQL Network Interfaces, error: 26 - Error Locating Server/Instance Specified</summary>
  
A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.<br/>
provider: SQL Network Interfaces, error: 26 - Error Locating Server/Instance Specified
<br/><br/>
</details>

<details>
<summary>Login timeout expired</summary>
  
SQL Server Native Client Data Link Error<br/>
[Microsoft SQL Server Native Client 10.0]: Login timeout expired<br/>
[Microsoft SQL Server Native Client 10.0]: A network-related or instance-specific error has occurred while establishing a connection to SQL Server. Server is not found or not accessible. Check if instance name is correct and if SQL Server is configured to allow remote connections. For more information see SQL Server Books Online.<br/>
[Microsoft SQL Server Native Client 10.0]: SQL Server Network Interfaces: Error Locating Server/Instance Specified [xFFFFFFFF].
<br/><br/>
</details>
<details>
<summary>A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond</summary>
  
A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.<br/>
provider: TCP Provider, error: 0<br/>
A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.<br/>
Microsoft SQL Server, Error: 10060
<br/><br/>
</details>

<details>
<summary>provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server</summary>
  
A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.<br/>
provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server<br/>
Microsoft SQL Server, Error: 53<br/>
The network path was not found
<br/><br/>
</details>

<details>
<summary>[Microsoft][SQL Server Native Client 11.0]TCP Provider: No connection could be made because the target machine actively refused it</summary>
  
SQL Server Native Client Data Link Error<br/>
[Microsoft][SQL Server Native Client 11.0]TCP Provider: No connection could be made because the target machine actively refused it.<br/>
[Microsoft][SQL Server Native Client 11.0]Login timeout expired.<br/>
[Microsoft][SQL Server Native Client 11.0]A network-related or instance-specific error has occurred while establishing a connection to SQL Server. Server is not found or not accessible. Check if instance name is correct and if SQL Server is configured to allow remote connections. For more information see SQL Server Books Online.
<br/><br/>
</details>

### "SQL Server does not exist or access denied"
  
This error usually means that the client can't find the SQL Server instance. This issue occurs when at least one of the following problems exists:

- The name of the computer hosting SQL Server is incorrect.
- The instance doesn't resolve the correct IP.
- The TCP port number isn't specified correctly.

> [!NOTE]
> For troubleshooting connectivity issues in high availability scenarios, see the following articles:
>
> - [Connect to an Always On availability group listener](/sql/database-engine/availability-groups/windows/listeners-client-connectivity-application-failover)
> - [Always On Failover Cluster Instances (SQL Server)](/sql/sql-server/failover-clusters/windows/always-on-failover-cluster-instances-sql-server)

### Windows error 233: No process is on the other end of the pipe

The complete message is:

> A connection was successfully established with the server, but then an error occurred during the login process. (provider: Shared Memory Provider, error: 0 - No process is on the other end of the pipe.) (Microsoft SQL Server, Error: 233)

This message means that SQL Server isn't listening on the Shared Memory or Named Pipes protocol.

## Gather information for troubleshooting the error

We recommend that you gather the information listed in this section using one of the following options before proceeding with the actual steps to troubleshoot the error.

### Option 1: Use the SQL Check tool to gather the required information

If you can sign in locally to the SQL Server computer and have administrator access, use [SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK). This tool provides most of the information required for troubleshooting in one file. Review the tool's home page for more information on using the tool and the information it gathers.  You can also check the recommended [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and checklist page.

### Option 2: Collect the data individually using the following procedures

#### Get the instance name from Configuration Manager

On the server that hosts the SQL Server instance, use [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager) to verify the instance name:

> [!NOTE]
> Configuration Manager is automatically installed on the computer when SQL Server is installed. Instructions on starting Configuration Manager vary slightly by versions of SQL Server and Windows. For version-specific details, see [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager).

1. Sign in to the computer hosting the instance of SQL Server.
1. Start SQL Server Configuration Manager.
1. In the left pane, select **SQL Server Services**.
1. In the right pane, verify the name of the instance of the database engine.

    - **SQL SERVER (MSSQLSERVER)** indicates a default instance of SQL Server. The name of the default instance is \<computer name>.
    - **SQL SERVER (\<instance name>)** indicates a named instance of SQL Server. The name of the named instance is \<computer name>\\\<instance name>.

#### Get the IP address of the server

You can use the following steps to get the IP address of the computer hosting the instance of SQL Server.

1. On the **Start** menu, select **Run**. In the **Run** window, type *cmd*, and then select **OK**.
1. In the **Command Prompt** window, type *ipconfig/all* and then press **Enter**. Note down the IPv4 address and the IPv6 address.

    > [!NOTE]
    > SQL Server can connect by using either IP version 4 protocol or IP version 6 protocol. Your network could allow either or both.

#### Get the TCP port of the instance

In most cases, you connect to the Database Engine on another computer by using the TCP protocol. To get the TCP port of the instance, follow these steps:

1. Use SQL Server Management Studio on the computer running SQL Server and connect to the instance of SQL Server. In **Object Explorer**, expand **Management**, expand **SQL Server Logs**, and then double-click the current log.
1. In the **Log File Viewer**, select **Filter** on the toolbar. In the **Message contains text** box, type *server is listening on*, select **Apply filter**, and then select **OK**.
1. A message like "Server is listening on [ 'any' \<ipv4> 1433]" should be listed.

   This message indicates that the instance of SQL Server is listening on all IP addresses on this computer (for IP version 4) and TCP port 1433. (TCP port 1433 is usually the port that's used by the Database Engine or the default instance of SQL Server. Only one instance of SQL Server can use this port. If more than one instance of SQL Server is installed, some instances must use other port numbers.) Note down the port number used by the SQL Server instance that you're trying to connect to.

    > [!NOTE]
    > - IP address 127.0.0.1 is probably listed. It's called the loopback adapter address. Only processes on the same computer can use the IP address to connect.
    > - You can also view the SQL Server error log by using a text editor. By default, the error log is located at *Program Files\Microsoft SQL Server\MSSQL.n\MSSQL\LOG\ERRORLOG* and *ERRORLOG.n* files. For more information, see [Viewing the SQL Server error log](/sql/tools/configuration-manager/viewing-the-sql-server-error-log).

## Step 1：Verify that the instance is running

### Option 1: Use the SQLCHECK output file

1. Search the SQLCHECK output file for "SQL Server Information".
1. In the section titled "Services of Interest", find your SQL Server instance under **Name** and **Instance** (for named instances) columns and check its status by using **Started** column. If the value is **True**, the services are started. Otherwise the service is currently not running.  
1. If the service isn't running, [start the service](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services) by using either SQL Server management studio, SQL Server Configuration manager, [PowerShell](/powershell/module/sqlserver/start-sqlinstance), or Services applet.

### Option 2: Use SQL Server Configuration Manager

To verify that the instance is running, select **SQL Server Services** in **SQL Server Configuration Manager** and check the symbol by the SQL Server instance.

- A green arrow indicates that an instance is running.
- A red square indicates that an instance is stopped.

If the instance is stopped, right-click the instance and select **Start**. Then, the server instance starts, and the indicator becomes a green arrow.

### Option 3: Use PowerShell commands

You can use the following command in PowerShell to check the status of SQL Server services on the system:

```powershell
Get-Service | Where {$_.status -eq 'running' -and $_.DisplayName -like "sql server*"}
```

You can use the following command to search the error log file for the specific string "SQL Server is now ready for client connections. This is an informational message; no user action is required.":

```powershell
Get-ChildItem -Path "c:\program files\microsoft sql server\mssql*" -Recurse -Include Errorlog | Select-String "SQL Server is now ready for client connections."
```

## Step 2: Verify that the SQL Server Browser service is running

> [!NOTE]
> This step is required only for troubleshooting connectivity issues with named instances.

### Option 1: Use the SQLCHECK output file

1. Search the SQLCHECK output file for "SQL Server Information".
1. In the section titled "Services of Interest", search for SQLBrowser in the **Name** column and check its status using the **Started** column. If the value is True, the service is started. Otherwise, the service is currently not running, and you need to start it. For more information, see [Start, stop, pause, resume, restart SQL Server services](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services).

### Option 2: Use SQL Server Configuration Manager

To connect to a named instance, the SQL Server Browser service must be running. In **SQL Server Configuration Manager**, locate the **SQL Server Browser** service and verify that it's running. If it's not running, start the service. The SQL Server Browser service isn't required for default instances.

For more information on using SQL Server Browser service in your environment, see [SQL Server Browser service](/sql/tools/configuration-manager/sql-server-browser-service).

For more information on stopping and starting SQL Services, see [Start, stop, pause, resume, restart SQL Server services](/sql/database-engine/configure-windows/start-stop-pause-resume-restart-sql-server-services).

> [!NOTE]
> If you can't have the SQL Server Browser service running in your environment, see [Connecting to SQL server named instance without SQL Server browser service](https://social.msdn.microsoft.com/Forums/en-US/edeab7bc-300d-4e19-8767-1c299970d841/connecting-to-sql-server-intance-without-browser-running).

## Step 3: Verify the server name in the connection string

You often encounter errors when an incorrect server name is specified in the connection string. Make sure that the server name matches the one that you retrieved in the previous steps.

> [!NOTE]
> If you are using the SQLCHECK tool, review the **NetBios Name/FQDN** values in the **Computer Information** section of the output file.

- For examples on connection strings, see [SQL Server Connection Strings](https://www.connectionstrings.com/sql-server/).
- For more detailed examples, see [Proof of concept connecting to SQL using ADO.NET](/sql/connect/ado-net/step-3-connect-sql-ado-net) under [Homepage for SQL client programming](/sql/connect/homepage-sql-connection-programming).

## Step 4: Verify the aliases on the client machines

Aliases are often used in client environments when you connect to SQL Server with an alternate name or when there are name resolution issues in the network. They're created by using [SQL Server Configuration Manager](/sql/tools/configuration-manager/new-alias-alias-tab) or [client network utility](/previous-versions/windows/desktop/odbc/dn170543(v=vs.85)). An incorrect alias can cause the connections from your applications to connect to the wrong server, resulting in failure. Use the following methods to check for incorrect aliases. You can also use a tool (such as [SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK)) on the client machine to check for aliases and various other connectivity-related settings on a client machine.

> [!NOTE]
> The following options only apply to the applications that use [SQL Server Native Client](/sql/relational-databases/native-client/SQL-server-native-client) to connect to SQL Server.

### Option 1: Use the SQLCHECK output file

1. In the SQLCHECK output file, search for the string SQL Aliases. (This string will be inside the **Client Security and Driver Information** section of the file)
1. Review the entries in the table. If there's none present, there are no aliases on the computer. If there's an entry, review the information to ensure the server name and port number are set to the correct values.

Example output:  
SQL Aliases:

```output
Alias Name   Protocol   Server Name     Port   32-bit 

----------   --------   ------------    ----   ------ 

prodsql      TCP        prod_sqlserver  1430      
```

The output indicates that `prodsql` is an alias for a SQL Server called `prod_sqlserver` that's running on port 1430.

### Option 2: Check aliases in SQL Server Configuration Manager

1. In [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager), expand **SQL Server Native Client Configuration**, and select **Aliases**.
1. Check whether any aliases are defined for the server that you're trying to connect to.

   If the aliases exist, follow these steps:

   1. Open the **Properties** pane of the alias.
   1. Rename the value in the **Alias Name** field (for example, if your server name is *MySQL*, rename it as *MySQL_test*) and retry the connection. If the connection works, your alias is incorrect and may come from an old configuration that is no longer needed. If the connection doesn't work, rename the alias back to its original name and go to the next step.
   1. Check the connection parameters for the alias and make sure that they're correct. The following common scenarios can cause connectivity problems:
      - Incorrect IP address for the **Server** field. Make sure that the IP address matches the entry in the SQL Server error log file.
      - Incorrect server name in the **Server** field. For example, your server alias points to the correct server name. However, the connections will fail if the value of the server name parameter is incorrect.
      - Incorrect pipe name format (assuming that you use a named pipes alias).
        - When connecting to a default instance named *Mydefaultinstance*, the pipe name should be *\\\\Mydefaultinstance\pipe\sql\query*.
        - When connecting to a named instance *MySQL\Named*, the pipe name should be *\\\\MySQL\pipe\MSSQL$Named\sql\query*.

### Option 3: Check aliases in SQL Server Client Network Utility

1. Open [SQL Server Client Network Utility](/previous-versions/windows/desktop/odbc/dn170535(v%3dvs.85)) by typing *cliconfg.exe* in your Run command.
1. Follow step 2 in [Option 2: Check aliases in SQL Server Configuration Manager](#option-2-check-aliases-in-sql-server-configuration-manager).

## Step 5: Verify the firewall configuration

You can verify the firewall configuration depending on the default instance or named instance.

> [!NOTE]
> If you are using third party firewalls in your network, the concepts still apply. However, you may have to work with your network administrator or consult the firewall product's documentation for more information on configuring the firewall to allow necessary ports for communication with SQL Server.

### Default instance of SQL Server

A default instance typically runs on port 1433. Some installations also use a non-standard port (other than 1433) to run SQL instances. The firewall may block either port. To check the port number further, follow these steps:

1. Determine the port your SQL instance is running on, see [Get the TCP port of the instance](#get-the-tcp-port-of-the-instance).
1. 
    - If your SQL Server is configured to listen on port 1433, make sure that firewalls on the network between the client and the server allow traffic on that port. Review [Configure a Windows Firewall for Database Engine Access](/sql/database-engine/configure-windows/configure-a-windows-firewall-for-database-engine-access) and work with your network administrator to implement necessary solutions.
    - If your SQL Server default instance isn't using 1433, try to append the port number of SQL Server to the server name by using the format `<servername>,<portnumber>` and see whether it works. For example, your SQL instance name is *MySQLDefaultinstance* and it's running on port 2000. Specify the server name as *MySQLServer, 2000* and see whether it works.
        - If it doesn't work, it indicates the firewall is blocking the port. You can follow the instructions at [Configure a Windows Firewall for Database Engine Access](/sql/database-engine/configure-windows/configure-a-windows-firewall-for-database-engine-access) or work with your network administrator to add the port to the firewall exclusion list.
        - If it does work, it indicates that the firewall is allowing communication through that port. You need to change your connection string in order to use the port number and your server name in the connection string of your application.

### Named instance of SQL Server

If your SQL instance is a named instance, it may be configured to use either dynamic ports or a static port. In either case, the underlying network libraries query the SQL Server Browser service running on your SQL Server machine through UDP port 1434 to enumerate the port number for the named instance. If a firewall between the client and the server blocks this UDP port, the client library can't determine the port (a requirement for connection) and the connection fails. To check the connection, you can use one of the following methods:

- Method 1: Check connection by specifying the port number in your connection string.
    1. Determine the port your SQL instance is running on, see [Get the TCP port of the instance](#get-the-tcp-port-of-the-instance).
    1. Try to connect to the named instance by using the port number appended to the server name in the format `<servername\instancename>,<portnumber>` and see if that works. For example, if your SQL instance name is *MySQL\Namedinstance* and it's running on port 3000, specify the server name as *MySQL\Namedinstance,3000*.
        - If it does work, it indicates the firewall is blocking the UDP port 1434 or the instance is [hidden](/sql/database-engine/configure-windows/hide-an-instance-of-sql-server-database-engine) from SQL Server Browser.
        - If it doesn't work, it indicates one of the following situations:
          - Either UDP port 1434 is blocked or the static port is blocked, or both. To confirm whether it's the UDP port or the static port, use [Portqry](../../../windows-server/networking/portqry-command-line-port-scanner-v2.md).
          - The instance is [hidden](/sql/database-engine/configure-windows/hide-an-instance-of-sql-server-database-engine) from the SQL Server Browser service.
- Method 2: Check the connection by using the PortQryUI tool.

  Use the PortQryUI tool with your named instance and observe the resulting output. You may see a message that the UDP port 1434 is filtered. This message indicates that the port is blocked on the network. For instructions on how to use the tool, see [Using the PortQryUI Tool with SQL Server](../connect/using-portqrytool-sqlserver.md).

    Determine whether the SQL Server instance is listening on dynamic or static ports. Then use the following method that is relevant to your scenario. If you aren't sure, see [How to check if SQL Server is listening on a dynamic port or static port](../connect/static-or-dynamic-port-config.md).

  - Scenario 1: Dynamic ports. In this case, ensure that the SQL Server Browser service is started and UDP port 1434 isn't blocked on the firewall between the client and the server. If you can't do either of these things, you should switch your SQL Server instance to a static port and use the procedure documented in [Configure a Server to Listen on a Specific TCP Port](/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port).
  - Scenario 2: Static port configuration. Either SQL Server Browser isn't running or UDP 1434 can't be opened on the firewall. In this case, make sure to specify the static port in your connection string and that the firewall doesn't block the port. For more information, review [Configure a Windows Firewall for Database Engine Access](/sql/database-engine/configure-windows/configure-a-windows-firewall-for-database-engine-access).

## Step 6: Verify the enabled protocols on SQL Server

In some installations of SQL Server, connections to the Database Engine from another computer aren't enabled unless an administrator manually enables them. You can use one of the following options to check and enable the necessary protocols to allow remote connections to SQL Server Database Engine.

### Option 1: Use the SQLCHECK output file

1. Search the SQLCHECK output file for "Details for SQL Server instance" section and locate the information section for your SQL Server instance.
1. In the section, find the values listed in the following table to determine if the SQL Server protocols are enabled:

    |Value name |Implication|More information|
    |-|-|-|
    |Shared Memory Enabled |Can either be true of false - only affects local connections. |[Creating a Valid Connection String Using Shared Memory Protocol](/sql/tools/configuration-manager/creating-a-valid-connection-string-using-shared-memory-protocol)|
    |Named Pipes Enabled |If false, both local and remote connections using Named pipes will fail |[Choosing a Network Protocol](/previous-versions/sql/sql-server-2016/ms187892(v=sql.130))|
    |TCP Enabled |If false, both local and remote connections using TCP/IP will fail. <br/>**Note** The majority of the SQL Server installations use TCP/IP as the communication protocol between server and the client.|[Choosing a Network Protocol](/previous-versions/sql/sql-server-2016/ms187892(v=sql.130))|

1. Enable required protocols by using SQL Server Configuration Manager or SQL Server PowerShell. For more information, see [Enable or Disable a Server Network Protocol](/sql/database-engine/configure-windows/enable-or-disable-a-server-network-protocol).

    > [!NOTE]
    > After enabling a protocol, the Database Engine must be stopped and restarted for the change to take effect.

### Option 2: Use SQL Server Configuration Manager

To enable connections from another computer by using the SQL Server Configuration Manager, follow these steps:

1. Open the SQL Server Configuration Manager.
1. In the left pane, expand **SQL Server Network Configuration**, and then select the instance of SQL Server that you want to connect to. The right pane lists the connection protocols available. **Shared Memory** is normally enabled. It can only be used from the same computer, so most installations leave **Shared Memory** enabled. To connect to SQL Server from another computer, use **TCP/IP**. If **TCP/IP** isn't enabled, right-click **TCP/IP**, and then select **Enable**.
1. If you change the enabled setting for any protocol, restart the Database Engine. In the left pane, select **SQL Server Services**. In the right-pane, right-click the instance of the Database Engine, and then select **Restart**.

## Step 7: Test TCP/IP connectivity

Connecting to SQL Server by using TCP/IP requires that Windows establish the connection. You can use the following steps to test TCP connectivity by using the ping tool.

1. On the **Start** menu, select **Run**. In the **Run** window, type *cmd* and select **OK**.
1. In the **Command Prompt** window, type `ping` and the IP address of the computer that's running SQL Server. For example:
    - IPv4: `ping 192.168.1.101`
    - IPv6: `ping fe80::d51d:5ab5:6f09:8f48%11`
1. If your network is configured properly, `ping` returns `Reply from <IP address>` followed by some additional information. If `ping` returns `Destination host unreachable` or `Request timed out`, TCP/IP isn't correctly configured. Errors at this point indicate a problem with the client computer, the server computer, or something about the network such as a router. To troubleshoot network problems, see [Advanced troubleshooting for TCP/IP issues](/windows/client-management/troubleshoot-tcpip).
1. If the `ping` test succeeds by using the IP address, test whether the computer name can be resolved to the TCP/IP address. On the client computer, in the **Command Prompt** window, type *ping* and the name of the computer that's running SQL Server. For example, `ping newofficepc`.
1. If ping to the IP address succeeds, but ping to the computer name returns `Destination host unreachable` or `Request timed out`, you might have old (stale) name resolution information cached on the client computer. Type `ipconfig /flushdns` to clear the DNS (Dynamic Name Resolution) cache. Then ping the computer by name again. When the DNS cache is empty, the client computer checks the latest information about the IP address for the server computer.
1. If your network is configured properly, `ping` returns `Reply from <IP address>` followed by some additional information. If you can successfully ping the server computer by IP address but receive an error such as `Destination host unreachable` or `Request timed out` when pinging by computer name, then name resolution isn't correctly configured. For more information, see how to [Troubleshoot Basic TCP/IP Problems](/previous-versions/tn-archive/bb727023(v=technet.10)). Successful name resolution isn't required to connect to SQL Server. However, if the computer name can't be resolved to an IP address, connections must be made to specify the IP address. Name resolution can be fixed later.

> [!NOTE]
> You can also use either [Test-NetConnection](/previous-versions/windows/powershell-scripting/dn372891(v=wps.630)) or [Test-Connection](/powershell/module/microsoft.powershell.management/test-connection) cmdlet to test TCP connectivity according to the PowerShell version that's installed on the computer. For more information on PowerShell cmdlet, see [Cmdlet Overview](/powershell/scripting/developer/cmdlet/cmdlet-overview).

## Step 8: Test local connection

Before troubleshooting a connection problem from another computer, test your ability to connect from a client application installed locally on the computer that is running SQL Server. Local connection avoids issues with networks and firewalls.

This procedure requires SQL Server Management Studio. If you don't have Management Studio installed, see [Download SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms).

If you can't install Management Studio, you can test the connection by using the *sqlcmd.exe* utility. *sqlcmd.exe* is installed with the Database Engine. For information about *sqlcmd.exe*, see [sqlcmd Utility](/sql/tools/sqlcmd-utility).

1. Sign in to the computer where SQL Server is installed by using a login that can access SQL Server. During installation, SQL Server requires at least one login to be specified as a SQL Server administrator. If you don't know an administrator, see [Connect to SQL Server When System Administrators Are Locked Out](/sql/database-engine/configure-windows/connect-to-sql-server-when-system-administrators-are-locked-out).
1. On the **Start** page, type *SQL Server Management Studio*, or on the **Start** menu of the older versions of Windows, select **All Programs**, select **Microsoft SQL Server**, and then select **SQL Server Management Studio**.
1. On the **Connect** drop-down menu, select **Database Engine**. In the **Authentication** box, select **Windows Authentication**. In the **Server name** box, type one of the following connection types:

    |Connecting to|Type|Example|
    |:-----------------|:---------------|:-----------------|
    |Default instance|`<computer name>`|`ACCNT27`|
    |Named Instance|`<computer name\instance name>`|`ACCNT27\PAYROLL`|

    > [!NOTE]
    > When connecting to SQL Server from a client application on the same computer, the shared memory protocol is used. Shared memory is a type of local named pipe, so you sometimes encounter errors related to pipes.
1. If you receive an error at this point, you must resolve it before proceeding. Your login might not be authorized to connect. Your default database might be missing.

    > [!NOTE]
    > You can't troubleshoot the problem without enough information because some error messages are passed to the client intentionally. This is a security feature to avoid providing an attacker with information about SQL Server. To view the details about the error, see the SQL Server error log.
1. If you receive **error 18456 Login failed for user**, Books Online article [MSSQLSERVER_18456](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error) contains additional information about error codes. Aaron Bertrand's blog also has an extensive list of error codes at [Troubleshooting Error 18456](https://sqlblog.org/2020/07/28/troubleshooting-error-18456) (external link). You can view the error log by using SSMS (if you can connect), in the **Management** section of the **Object Explorer**. Otherwise, you can view the error log with the Windows Notepad program. The default location varies with your version and can be changed during setup. The default location for SQL Server 2019 (15.x) is *C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log\ERRORLOG*.
1. If you can connect by using shared memory, test connecting by using TCP. You can force a TCP connection by specifying `tcp:` before the name. Here are the examples:

   |Connecting to:|Type:|Example:|
   |-----------------|---------------|-----------------|
   |Default instance|`tcp:<computer name>`|`tcp:ACCNT27`|
   |Named Instance|`tcp:<computer name/instance name>`|`tcp:ACCNT27\PAYROLL`|

1. If you can connect by using shared memory but not TCP, you must fix the TCP problem. The most likely issue is that TCP isn't enabled. To enable TCP, see [Step 6: Verify the enabled protocols on SQL Server](#step-6-verify-the-enabled-protocols-on-sql-server).
1. If your goal is to connect by using an account other than an administrator account, you can begin by connecting as an administrator. Then, try to connect again with the Windows Authentication login or the SQL Server Authentication login that the client application uses.

## Step 9: Test remote connection

Once you can connect by using TCP on the same computer, it's time to try to connect from the client computer. You could use any client application, but to avoid complexity, install the SQL Server Management tools on the client. After installation, try to use SQL Server Management Studio.

1. Use SQL Server Management Studio on the client computer and try to connect by using the IP address and the TCP port number in the format IP address comma port number. For example, `192.168.1.101,1433`. If this connection fails, you probably have one of the following problems:
    - `ping` of the IP address doesn't work. This indicates a general TCP configuration problem. Go back to the section [Step 7: Test TCP/IP connectivity](#step-7-test-tcpip-connectivity).
    - SQL Server isn't listening on the TCP protocol. Go back to the section [Step 6: Verify the enabled protocols on SQL Server](#step-6-verify-the-enabled-protocols-on-sql-server).
    - SQL Server is listening on a port other than the port that you specified. Go back to the section [Get the TCP port](#get-the-tcp-port-of-the-instance).
    - The SQL Server TCP port is being blocked by the firewall. Go back to the section [step 5: Verify the firewall configuration](#step-5-verify-the-firewall-configuration).
1. Once you can connect by using the IP address and port number, review the following scenarios:
    - If you connect to a default instance that is listening on any port other than 1433, you must use either the port number in the connection string or create an alias on the client machine to connect to the default instance. The SQL Server Browser service can't enumerate ports of the default instance.
    - If you connect to a named instance, try to connect to the instance in the format IP address backslash instance name. (For example, `192.168.1.101\<instance name>`.) If this action doesn't work, it means that the port number isn't being returned to the client. The problem is related to the SQL Server Browser service, which provides the port number of a named instance to the client. Here are the solutions:
        - Start the SQL Server Browser service. See the instructions to [start browser in SQL Server Configuration Manager](#step-2-verify-that-the-sql-server-browser-service-is-running).
        - The SQL Server Browser service is being blocked by the firewall. Open UDP port 1434 in the firewall. Go back to the section [Step 5: Verify the firewall configuration](#step-5-verify-the-firewall-configuration). Make sure that you're opening a UDP port, not a TCP port.
        - The UDP port 1434 information is being blocked by a router. UDP communication (user datagram protocol) isn't designed to pass through routers and keeps the network from getting filled with low-priority traffic. You can configure your router to forward UDP traffic, or you can provide the port number every time you connect.
        - If the client computer is using Windows 7, Windows Server 2008, or a more recent operating system, the client operating system might drop the UDP traffic because the response from the server is returned from a different IP address that was queried. This action is a security feature blocking "loose source mapping." For more information, see the **Multiple Server IP Addresses** section of the Books Online article [Troubleshooting: Timeout Expired](/previous-versions/sql/sql-server-2008-r2/ms190181(v=sql.105)#multiple-server-ip-addresses). (This article is from SQL Server 2008 R2, but the principals still apply. You can configure the client to use the correct IP address or provide the port number every time you connect.)
1. Once you can connect by using the IP address (or IP address and instance name for a named instance), try to connect by using the computer name (or computer name and instance name for a named instance). Put `tcp:` in front of the computer name to force a TCP/IP connection. For example, for the default instance on a computer named *ACCNT27*, use `tcp:ACCNT27`. For a named instance called *PAYROLL*, on that computer use `tcp:ACCNT27\PAYROLL`. If you can connect by using the IP address but not by using the computer name, you have a name resolution problem. Go back to the section [Step 7: Test TCP/IP connectivity](#step-7-test-tcpip-connectivity).
1. Once you can connect by using the computer name forcing TCP, try to connect by using the computer name without forcing TCP. For example, for a default instance, and just use a computer name such as *CCNT27*. For a named instance, use the computer name and instance name like *ACCNT27\PAYROLL*. If you can connect while forcing TCP, but not without forcing TCP, the client is probably using another protocol such as *named pipes*. To fix this issue, follow the steps:
    1. On the client computer, use SQL Server Configuration Manager. In the left-pane, expand **SQL Native Client \<version> Configuration**, and then select **Client Protocols**.
    1. On the right-pane, make sure that **TCP/IP** is enabled. If **TCP/IP** is disabled, right-click **TCP/IP** and select **Enable**.
    1. Make sure that the protocol order for TCP/IP is a smaller number than the named pipes (or VIA on older versions) protocols. Generally, you should leave shared memory as order 1 and TCP/IP as order 2. Shared memory is only used when the client and SQL Server are running on the same computer. All enabled protocols are tried in order until one succeeds, but shared memory is skipped when the connection isn't on the same computer.

## Step 10: Check user permissions

If you are using Named Pipes to connect, check if a user has permissions to log into Windows. For more information, see [Troubleshooting the Named Pipes connections issue](named-pipes-connection-fail-no-windows-permission.md).

## See also

- [Network Protocols and Network Libraries](/sql/sql-server/install/network-protocols-and-network-libraries)
- [Client Network Configuration](/sql/database-engine/configure-windows/client-network-configuration)
- [Configure Client Protocols](/sql/database-engine/configure-windows/configure-client-protocols)
- [Troubleshoot connectivity issues in SQL Server](../connect/resolve-connectivity-errors-overview.md)
- [0200 Consistent Network Issue](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0200-Consistent-Network-Issue)
- [Connect to an Always On availability group listener](/sql/database-engine/availability-groups/windows/listeners-client-connectivity-application-failover)
- [Always On Failover Cluster Instances (SQL Server)](/sql/sql-server/failover-clusters/windows/always-on-failover-cluster-instances-sql-server)
- [Troubleshooting connectivity issues and other errors with Azure SQL Database and Azure SQL Managed Instance](/azure/azure-sql/database/troubleshoot-common-errors-issues)
