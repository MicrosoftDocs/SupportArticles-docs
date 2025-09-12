---
title: The Operations Manager console doesn't open
description: Fixes an issue in which you receive the Failed to connect to server error when you open the Operations Manager console on the management server.
ms.date: 04/15/2024
---
# Operations Manager console doesn't open and gives SDK service error

This article helps you fix an issue in which you receive the **Failed to connect to server** error when you open the Operations Manager console on the management server.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2002620

## Symptoms

When you try to open the System Center Operations Manager console on the management server, it may fail to open with the following error:

> Date: \<date> \<time>  
> Application: System Center Operations Manager  
> Application Version: \<version number>  
> Severity: Error  
> Message: Failed to connect to server 'management server-FQDN'
>
> Microsoft.EnterpriseManagement.Common.SdkServiceNotInitializedException: Sdk Service has not yet initialized. Please retry  
   at Microsoft.EnterpriseManagement.DataAbstractionLayer.SdkDataAbstractionLayer.HandleIndigoExceptions(Exception ex)  
   at Microsoft.EnterpriseManagement.DataAbstractionLayer.SdkDataAbstractionLayer.CreateChannel(TieredManagementGroupConnectionSettings managementGroupTier)  
   at Microsoft.EnterpriseManagement.DataAbstractionLayer.SdkDataAbstractionLayer..ctor(DuplexChannelFactory`1 channelFactory, TieredManagementGroupConnectionSettings managementGroupTier, IClientDataAccess callback, CacheMode cacheMode)  
   at Microsoft.EnterpriseManagement.DataAbstractionLayer.SdkDataAbstractionLayer.CreateEndpoint(ManagementGroupConnectionSettings connectionSettings, IClientDataAccess clientCallback)  
   at Microsoft.EnterpriseManagement.DataAbstractionLayer.SdkDataAbstractionLayer.Connect(ManagementGroupConnectionSettings connectionSettings)  
   at Microsoft.EnterpriseManagement.ManagementGroup..ctor(String serverName)  
   at Microsoft.EnterpriseManagement.ManagementGroup.Connect(String serverName)  
   at Microsoft.EnterpriseManagement.Mom.Internal.UI.Common.ManagementGroupSessionManager.Connect(String server)  
   at Microsoft.EnterpriseManagement.Mom.Internal.UI.Console.ConsoleWindowBase.TryConnectToManagementGroupJob(Object sender, ConsoleJobEventArgs args)

You may also see the following in the Operations Manager event log on the management server:

> Event Type: Error  
> Event Source: OpsMgr SDK Service  
> Event Category: None  
> Event ID: 26322  
> Date:  \<date>  
> Time:  \<time>  
> User:  N/A  
> Computer: \<management server-name>  
> Description:  
> A database exception was thrown in the Operations Manager SDK service. Exception Message: A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: SQL Network Interfaces, error: 26 - Error Locating Server/Instance Specified)  
>
> For more information, see Help and Support Center at `http://go.microsoft.com/fwlink/events.asp`.

## Cause

This issue can happen if the management server is not able to contact the SQL Server where the Operations Manager database resides.

## Resolution

Check the registry key for the database server name on the management server:

`HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft Operations Manager\3.0\Setup`

Key name = `DatabaseServerName`

This key may contain the wrong servername\instancename. If it's incorrect, configure the correct servername\instancename in this key. If the Operations Manager database is installed in the default instance on the SQL Server, just the SQL Server name is enough in this key.

After the key value is corrected, restart **System Center Data Access Service**.
