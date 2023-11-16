---
title: Troubleshoot connectivity issues on a dedicated SQL pool
description: Provides methods for troubleshooting initial and dropped connections on a dedicated SQL pool.
ms.date: 02/21/2023
author: scott-epperly
ms.author: goventur
ms.reviewer: scepperl
---

# Troubleshoot connectivity issues on a dedicated SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

Connectivity issues that occur on a dedicated SQL pool can have various causes. This article provides tools and methods to help you troubleshoot the most common connectivity issues.

## Initial connectivity checklist

The following list describes commonly overlooked reasons for connectivity issues on a dedicated SQL pool. Check the list to see how you can work around the issues.

| Task description | Workaround |
|---|---|
| Check for Azure service outages. | Check the [Microsoft Azure Service Dashboard](https://azure.microsoft.com/status/) to see whether there are any known issues. |
| Check for service availability. | In the Azure portal, go to the dedicated SQL pool that you're trying to connect to, and select **Diagnose and solve problems** in the left pane to [check service availability](/azure/sql-data-warehouse/sql-data-warehouse-troubleshoot-connectivity#check-service-availability). |
| Check for paused or scaling operation. | Check whether your service is currently paused or in the process of scaling. In the Azure portal, go to the dedicated SQL pool that you're trying to connect to. For more information, see [troubleshooting documentation](/azure/sql-data-warehouse/sql-data-warehouse-troubleshoot-connectivity#check-for-paused-or-scaling-operation). |
| Check the **Resource health** blade in the Azure portal for status updates. | An *Unavailable* status means that resource health has detected consistent sign-in failures because of a system error in your SQL database. The status of *Degraded* means that resource health has detected mostly successful sign-ins, but there are also some failures. These sign-in failures might be caused by transient errors. |
| Check your firewall settings. | Dedicated SQL pool communicates over port 1433. If you're trying to connect from within a corporate network, outbound traffic over port 1433 might not be allowed by your network's firewall. In that case, you can't connect to your Azure SQL Database server unless your IT department opens port 1433. For more information, see [Create and manage IP firewall rules](/azure/sql-database/sql-database-firewall-configure#create-and-manage-ip-firewall-rules). |
| Check your virtual network/service endpoint settings. | If you see [errors "40914" and "40615"](/azure/sql-data-warehouse/sql-data-warehouse-troubleshoot-connectivity#check-your-vnetservice-endpoint-settings), see the error description and resolution in the [Common error messages reference](#common-error-message-reference) section. |
| Check for the latest drivers. | Verify that you're using the [latest version of the tool and drivers](/sql/connect/jdbc/system-requirements-for-the-jdbc-driver) to connect to your dedicated SQL pool. For more information, see [Check for the latest drivers](/azure/sql-data-warehouse/sql-data-warehouse-troubleshoot-connectivity#check-for-the-latest-drivers). <br><br>Resources:<br>* [Connect and manage your dedicated SQL pool using the Azure portal](/azure/sql-data-warehouse/create-data-warehouse-portal)<br>* [Connect and manage your dedicated SQL pool by using PowerShell](/azure/sql-data-warehouse/create-data-warehouse-powershell). |
| Check your connection string. | Verify that your connection strings are set correctly. [Check your connection string](/azure/sql-data-warehouse/sql-data-warehouse-troubleshoot-connectivity#check-your-connection-string) to see some sample connection strings for ADO.NET, ODBC, PHP, and JDBC. See [additional information about connection strings](/azure/sql-data-warehouse/sql-data-warehouse-connect-overview#find-your-server-name). |

## Troubleshoot persistent connectivity errors

The [Azure SQL connectivity checker](https://github.com/Azure/SQL-Connectivity-Checker) is a PowerShell script that automates a series of checks for the most common configuration issues. Most issues detected by the script will be accompanied by recommendations for resolution.

The following PowerShell script downloads and runs the latest version of the Azure SQL connectivity checker. You can run it from any client computer on which persistent connectivity issues occur.

> [!NOTE]
> - To run the tests in Linux, from computers that have no Internet access, or from a containerized environment, see [SQL connectivity checker on GitHub](https://github.com/Azure/SQL-Connectivity-Checker).
> - For more PowerShell commands, see [Available PowerShell commands](/powershell/module/azurerm.sql#sql).

1. Open Windows PowerShell ISE (in **Administrator** mode if possible).
   > [!NOTE]
   > To collect a network trace together with the tests (`CollectNetworkTrace` parameter), you must run PowerShell as an administrator.
1. Open a **New Script** window.
1. Copy and paste the following text into the script window:

     ```vb
     $parameters = @{
     # Supports Single, Elastic Pools and Managed Instance (MI public endpoint is supported)
     # Supports Azure Synapse / Azure SQL Data Warehouse (*.sql.azuresynapse.net / *.database.windows.net)
     # Supports Public Cloud (*.database.windows.net), Azure China (*.database.chinacloudapi.cn), Azure Germany (*.database.cloudapi.de) and Azure Government (*.database.usgovcloudapi.net)
     Server = '.database.windows.net' # or any other supported FQDN
     Database = ''  # Set the name of the database you wish to test, 'master' will be used by default if nothing is set
     User = ''  # Set the login username you wish to use, 'AzSQLConnCheckerUser' will be used by default if nothing is set
     Password = ''  # Set the login password you wish to use, 'AzSQLConnCheckerPassword' will be used by default if nothing is set

     # Optional parameters (default values will be used if omitted)
     SendAnonymousUsageData = $true  # Set as $true (default) or $false
     RunAdvancedConnectivityPolicyTests = $true  # Set as $true (default) or $false, this will load the library from Microsoft's GitHub repository needed for running advanced connectivity tests
     ConnectionAttempts = 1 # Number of connection attempts while running advanced connectivity tests
     DelayBetweenConnections = 1 # Number of seconds to wait between connection attempts while running advanced connectivity tests
     CollectNetworkTrace = $true  # Set as $true (default) or $false
     #EncryptionProtocol = '' # Supported values: 'Tls 1.0', 'Tls 1.1', 'Tls 1.2'; Without this parameter operating system will choose the best protocol to use
      }

     $ProgressPreference = "SilentlyContinue";
     if ("AzureKudu" -eq $env:DOTNET_CLI_TELEMETRY_PROFILE) {
     $scriptFile = '/ReducedSQLConnectivityChecker.ps1'
     } else {
     $scriptFile = '/AzureSQLConnectivityChecker.ps1'
     }
     $scriptUrlBase = 'http://raw.githubusercontent.com/Azure/SQL-Connectivity-Checker/master'
     cls
     Write-Host 'Trying to download the script file from GitHub (https://github.com/Azure/SQL-Connectivity-Checker), please wait...'
     try {
     [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls
     Invoke-Command -ScriptBlock ([Scriptblock]::Create((Invoke-WebRequest ($scriptUrlBase + $scriptFile) -UseBasicParsing -TimeoutSec 60).Content)) -ArgumentList $parameters
     }
     catch {
     Write-Host 'ERROR: The script file could not be downloaded:' -ForegroundColor Red
     $_.Exception
     Write-Host 'Confirm this machine can access https://github.com/Azure/SQL-Connectivity-Checker/' -ForegroundColor Yellow
     Write-Host 'or use a machine with Internet access to see how to run this from machines without Internet. See how at https://github.com/Azure/SQL-Connectivity-Checker/' -ForegroundColor Yellow
     }
     #end
     ```

1. Set the parameters on the script.
    - Specify the server name and database name.
    - Specify the user and password information.
      > [!NOTE]
      > This step is optional but is a best practice.
1. Run the script.
   Results are displayed in the output window. If the user has permissions to create folders, a folder that includes the resulting log file is created, together with a .zip file (`AllFiles.zip`). In Windows, the folder opens automatically after the script finishes running.
1. Examine the output for any detected issues, and follow the recommended steps to resolve the issue.
   If the issue can't be resolved, send the `AllFiles.zip` file to Microsoft by using the **File upload** option in the **Details** step when you create your Support Request.

## Troubleshoot intermittent connectivity errors

Make sure that all production applications have robust [retry logic](/azure/azure-sql/database/troubleshoot-common-connectivity-issues?WT.mc_id=pid:13491:sid:32745426#retry-logic-for-transient-errors) to handle dropped connections and transient errors.

### Connection policy configuration for gateway issues

The Azure SQL Database gateway terminates sessions that are idle for more than 30 minutes. This scenario frequently affects pooled, idle connections. For *dedicated SQL pool (formerly SQL DW)*, you can switch the [connection policy](/azure/azure-sql/database/connectivity-architecture?WT.mc_id=pid:13491:sid:32745426#connection-policy) for your server from *proxy* to *redirect*. The redirect setting bypasses the gateway after it's connected. This eliminates the issue.

### TCP KeepAlive in Microsoft JDBC driver

The Microsoft JDBC driver and some third-party drivers don't enable TCP KeepAlive. This causes the TCP network layer to drop the connection after a certain idle period. Verify that you have the latest client drivers installed and that the driver enables [KeepAlive](/sql/connect/jdbc/connecting-to-an-azure-sql-database#connections-dropped).

### Time-out configuration

All applications that connect to Synapse SQL pools should use a sign-in time-out of at least 15 seconds. Shorter durations might encounter time-outs during a database reconfiguration.

### High-resource usage

- Check to see whether you're experiencing heavy loads on the server that has a large number of queued requests. You may have to scale up your data warehouse for [more resources](/azure/sql-data-warehouse/sql-data-warehouse-troubleshoot-connectivity#intermittent-connection-issues).
- Try adding [retry logic](/azure/sql-database/sql-database-connectivity-issues#retry-logic-for-transient-errors) in your client application to help mitigate these situations and make the errors transparent to users.
- Azure Synapse Analytics provides a rich monitoring experience within the Azure portal to surface insights regarding your data warehouse workload. You can review the CPU, memory, and local `tempdb` usage as it relates to your workload in [Azure Monitor](https://portal.azure.com/#view/Microsoft_Azure_Monitoring/AzureMonitoringBrowseBlade/~/metrics) of the Azure portal.
  - For dedicated SQL pools in a Synapse Workspace, see [Metrics emitted by dedicated SQL pools](/azure/synapse-analytics/monitoring/how-to-monitor-using-azure-monitor#dedicated-sql-pool-metrics).
  - For metrics that are emitted by dedicated SQL pools (formerly SQL Data Warehouse), see [Monitoring resource utilization and query activity](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-concept-resource-utilization-query-activity).

## Common error message reference

Use this table to find descriptions and mitigations for the most common error messages that you receive when you try to connect to a dedicated SQL pool.

| Error message | Description and Mitigation |
|-----|----|
| Error 18456: Login failed for user 'NT AUTHORITY\ANONYMOUS LOGON'. (Microsoft SQL Server, Error: 18456) |This error occurs when a Microsoft Entra user tries to connect to the master database but doesn't have a user in the master. To correct this issue, either specify the dedicated SQL pool that you want to connect to at connection time, or add the user to the master database. For more information, see [Security overview](/azure/azure-sql/database/security-overview) and [sign-in errors with state and description](/sql/relational-databases/errors-events/ of the SAS token. Consider switching to [Managed identity](/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=managed-identity#supported-storage-authorization-types) or [Microsoft Entra pass-through](/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=user-identity#supported-storage-authorization-types) authentication to access protected storage. For more information, see [Grant access to trusted Azure services](/azure/storage/common/storage-network-security?tabs=azure-portal#grant-access-to-trusted-azure-services) and [Control storage account access for serverless SQL pool](/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=user-identity). |
| Error 916: The server principal "MyUserName" is not able to access the database "master" under the current security context. Cannot open user default database. Login failed. Login failed for user 'MyUserName'. (Microsoft SQL Server, Error: 916) | This error occurs when a Microsoft Entra user tries to connect to the master database but doesn't have a user in the master. To correct this issue, either specify the dedicated SQL pool that you want to connect to at connection time or add the user to the master database. For more information, see [Security overview](/azure/azure-sql/database/security-overview) and [sign-in errors with state and description](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error).|
| Error 40613: Database X on server Y is not currently available| Error 40613 is a nonspecific, [transient error](/azure/azure-sql/database/troubleshoot-common-connectivity-issues) returned by Azure any time that your database is unavailable. You should expect occasional brief periods (for example, less than 60 seconds) during which you see error "40613." To accommodate this scenario, make sure that all production applications have robust [retry logic](/azure/azure-sql/database/troubleshoot-common-connectivity-issues#retry-logic-for-transient-errors).|
| Error 40615: Cannot open server '{0}' requested by the login. Client with IP address '{1}' is not allowed to access the server| The client is trying to connect from an IP address that isn't authorized to connect to the Azure SQL Database server. The server firewall has no IP address rule that allows a client to communicate from the given IP address to the SQL Database. Enter the client's IP address as a new IP rule in the **Firewall** settings of the resource in Azure portal. A list of several SQL Database error messages is documented [here](/azure/sql-database/sql-database-develop-error-messages). |
| Error 40914: Cannot open server \<server-name\> requested by the login. Client is not allowed to access the server | In this scenario, the client is in a subnet that has virtual network server endpoints. However, the Azure SQL Database server has no virtual network rule that grants the right to communicate with the SQL Database to the subnet. In the **Firewall** pane of the Azure portal, use the virtual network rules control to [add a virtual network rule](/azure/sql-database/sql-database-vnet-service-endpoint-rule-overview?toc=/azure/sql-data-warehouse/toc.json#anchor-how-to-by-using-firewall-portal-59j) for the subnet. |
| Error 9002: 'The transaction log for database \<database-name\> is full due to 'ACTIVE_TRANSACTION'. (Microsoft SQL Server, Error: 9002)' | This error usually indicates a long-running transaction that isn't yet committed, or that there's a non-responsive session. This makes a full transaction log. Check for hanging sessions that log `SELECT * FROM sys.dm_exec_sessions, and end them by using KILL <session_id>`. If there are no hanging sessions, you might have to cancel the long-running query or kill that session to mitigate this issue. |
|A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server wasn't found or wasn't accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections.|Logins for SQL Database or dedicated SQL pools (formerly SQL DW) in Azure Synapse can land on *any of the gateways in a region*. For consistent connectivity to SQL Database or dedicated SQL pools (formerly SQL DW) in Azure Synapse, allow network traffic to and from *all* gateway IP addresses and subnets for the region. See [Gateway IP addresses](/azure/azure-sql/database/connectivity-architecture#gateway-ip-addresses).|
|File cannot be opened because it does not exist or is used by another process|If your query fails and returns this error message, and you verify that the file exists and isn't used by another process, then the Serverless SQL pool can't access the file. If the storage is protected by a firewall, review the steps that are described in [querying firewall protected storage](/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=user-identity#querying-firewall-protected-storage).|
|Failed to execute the query. Error: External table <_tablename_> is not accessible because content of directory cannot be listed.|If the storage is protected by using a firewall, see [querying firewall protected storage](/azure/synapse-analytics/sql/develop-storage-files-storage-access-control?tabs=user-identity#querying-firewall-protected-storage). Use the preceding PowerShell script to verify that the storage account network rules are correctly configured.|

## Resources

- [Troubleshooting connectivity issues in dedicated SQL pool (formerly SQL DW)](/azure/sql-data-warehouse/sql-data-warehouse-troubleshoot-connectivity)
- [Troubleshoot dedicated SQL pool (formerly SQL DW) in Azure Synapse Analytics](/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-troubleshoot)
- [Troubleshoot transient connection errors in Azure SQL](/azure/azure-sql/database/troubleshoot-common-connectivity-issues?WT.mc_id=pid:13491:sid:32745426/)<br>
- [View and change maintenance schedule](/azure/sql-data-warehouse/viewing-maintenance-schedule)
- Video: Understanding Connectivity issues in SQL Database | Data Exposed<br>
  - The following video explains how to handle connection issues to SQL Database.

    > [!VIDEO https://learn-video.azurefd.net/vod/player?show=data-exposed&ep=understanding-connectivity-issues-in-sql-database-data-exposed]
