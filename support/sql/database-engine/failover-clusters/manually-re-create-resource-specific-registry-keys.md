---
title: Manually re-create registry keys for cluster resources
description: This article describes how to manually re-create the resource-specific registry keys for SQL Server cluster resources when you delete a resource from Cluster Administrator.
ms.date: 07/22/2020
ms.custom: sap:High Availability and Disaster Recovery features
ms.topic: how-to
---
# Manually re-create the resource-specific registry keys for SQL Server cluster resources

This article shows how to manually re-create the resource-specific registry keys for SQL Server cluster resources when you delete a resource from Cluster Administrator.

_Original product version:_ &nbsp; Microsoft SQL Server  
_Original KB number:_ &nbsp; 810056

## Summary

The SQL Server-related cluster resources (SQL Server, SQL Server Agent, and full-text search) all contain resource-specific registry keys that must be present to bring the resource online. If you delete a resource from Cluster Administrator, you can manually re-create the resource. The steps can only be used to add resources that are dependent on SQL Server. They cannot be used for resources on which SQL Server depends. See the [More information](#more-information) section in this article to manually add the resource. These steps assume that you have previously used the SQL Server setup program to successfully install all the cluster files and components. This procedure does not describe all the files, modifications, or registry keys that the setup program makes in a new cluster installation.

## More information

Each resource that Cluster Administrator lists has a registry key that is located under `HKEY_LOCAL_MACHINE (HKLM)` at `HKLM\Cluster\Resources\GUID`. A GUID is created when you add the resource and differs between computers. Each key contains a Name value that contains the resource name that Cluster Administrator displays. Under each resource key, there is a Parameters subkey where the resource can store resource-specific parameter information.

SQL Server, SQL Server Agent, and full-text search store information in this Parameters subkey. If the information is missing, errors such as the following ones are logged in the Cluster log file when you try to bring the resource online:

> SQL Server: [sqsrvres] Unable to read the 'VirtualServerName' property. Error: d.  
Microsoft Search Service Instance full-text search: An error occurred during the online operation for instance full-text search: 80070002 - The system cannot find the file specified.

## Manually re-create a resource

To manually re-create a resource in Cluster Administrator, you must add the following registry values under the key that represents the resource:

### SQL Server

Name: InstanceName  
Type: REG_SZ  
Value: The name of the instance of SQL Server that the virtual server represents. Use MSSQLSERVER to use the default instance.

Name: VirtualServerName  
Type: REG_SZ  
Value: The virtual server name that you assigned to the server

### SQL Server Agent

Name: InstanceName  
Type: REG_SZ  
Value: The name of the instance of SQL Server that the virtual server represents. Use MSSQLSERVER to use the default instance.

Name: VirtualServerName  
Type: REG_SZ  
Value: The virtual server name assigned to the server

### Full-Text Search

Name: ApplicationName  
Type: REG_SZ  
Value: SQL Server$instance_name, where instance_name is the instance of SQL Server to use. To use a default instance, use *SQLServer*.

Name: ApplicationPath  
Type: REG_SZ  
Value: The full path to the folder that contains the Fulltext data files. Typically, this is in \MSSQL\FTDATA for a default instance and in MSSQL$instancename\FTDATA for a named instance.

### Add the registry keys by using the Cluster.exe utility

> [!IMPORTANT]
> You may use this method only in a critical situation. For example, you may use this method when you cannot start the instance of SQL Server. However, you can use the Setup program to re-create the virtual server.

You can use the Cluster.exe utility to add the registry keys. To do this, you must run a command that is similar to the following command at the command prompt:

```console
cluster res "ResourceName" /priv KeyName = KeyValue:STR
```

> [!NOTE]
> - You must replace **ResourceName** with the name of the appropriate SQL Server resource, the SQL Server Agent resource, or the Full-Text Search resource.
> - You must replace **KeyName** with the appropriate registry key names. For example, InstanceName and VirtualServerName are registry key names.
> - You must replace **KeyValue** with the appropriate value for the key. For the InstanceName registry key, you can assign the name of the instance of SQL Server that the virtual server represents for the key value. You may use MSSQLSERVER as the name of the instance for the default instance.
