---
title: Failed state and doesn't come online
description: This article provides a resolution for the problem that occurs if resource-specific registry keys are missing.
ms.date: 10/30/2020
ms.custom: sap:Failover Clusters
---

# A SQL Server cluster resource goes to a "failed" state when you try to bring the resource online in SQL Server

This article helps you resolve the problem that occurs if resource-specific registry keys are missing.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 883732

## Symptoms

When you try to bring a SQL Server cluster resource online for a virtual instance of Microsoft SQL Server, you may notice the following behavior:

- The SQL Server cluster resource goes to a "failed" state and doesn't come online.
- You receive a combination of the following error messages on the computer that owns the SQL Server cluster resource.

  - Error message 1

    An event that is similar to the following one is in the system event log:  

    > Date: 08/05/2004  
    Time: 1:11:19 AM  
    Source: ClusSvc  
    Category: Failover Mgr  
    Type: Error  
    Event ID: 1069  
    User: N/A  
    Computer: \<Computer Name>
    Description:  
    Cluster resource 'SQL Server (\<SQL Server instance name>)' in Resource Group '\<Cluster group name>' failed.

  - Error message 2

    An error message that is similar to the following one is in the Cluster log file:

    > 00000644.00000944::2003/11/30-18:11:30.360 SQL Server \<SQLServer>: [sqsrvres] Unable to read the 'VirtualServerName' property. Error: d.  
    00000644.00000944::2003/11/30-18:11:30.360 SQL Server \<SQLServer>: [sqsrvres] OnlineThread: Error d bringing resource online.

  - Error message 3

    Error messages that are similar to the following are in the SQL Server error log file:

    > 2003-11-30 17:00:37.27 server Error: 17826, Severity: 18, State: 1  
    2003-11-30 17:00:37.27 server Could not set up Net-Library 'SSNETLIB'..  
    2003-11-30 17:00:37.27 spid13 Starting up database 'SPB'.  
    2003-11-30 17:00:37.27 spid12 Starting up database 'BD_MTA'.  
    2003-11-30 17:00:37.27 spid14 Starting up database 'BD_SPF'.  
    2003-11-30 17:00:37.27 server Error: 17059, Severity: 18, State: 0  
    2003-11-30 17:00:37.27 server Operating system error -1073723998: ..  
    2003-11-30 17:00:37.27 server Unable to load any netlibs.  
    2003-11-30 17:00:37.27 server SQL Server could not spawn FRunCM thread.

## Cause

The resource-specific registry keys that correspond to the SQL Server cluster resource that you're trying to bring online are missing. This problem also occurs if the values that correspond to the resource-specific registry keys aren't correct.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).  

To resolve this problem, you must manually re-create the resource-specific registry keys that correspond to the SQL Server cluster resource. To do this, follow these steps:

1. Select **Start** > **Run**, type *Regedit*, and then select **OK**.
2. In Registry Editor, locate and select the registry key: `HKEY_LOCAL_MACHINE\Cluster\Resources\<GUID>\Parameters`.

3. Create the following registry values in the **Parameters** registry key:

    For a default instance of SQL Server:

    - InstanceName

        Value Name: InstanceName  
        Value Type: REG_SZ  
        Value Data: MSSQLSERVER  

    - VirtualServerName

        Value Name: VirtualServerName  
        Value Type: REG_SZ  
        Value Data: \<Name of the virtual SQL server>

    For a named instance of SQL Server:

    - InstanceName

        Value Name: InstanceName  
        Value Type: REG_SZ  
        Value Data: \<SQL Server instance name corresponding to the virtual server>

    - VirtualServerName

        Value Name: VirtualServerName  
        Value Type: REG_SZ  
        Value Data: \<Name of the virtual SQL server>

4. Quit Registry Editor. After you create the resource-specific registry keys, you can bring the SQL Server cluster resource online successfully.

   If you notice that a SQL Server Agent cluster resource can't be brought online, you must create the same set of resource-specific keys that correspond to the SQL Server Agent cluster resource.

## More information

[How to manually re-create the resource-specific registry keys for SQL Server cluster resources](manually-re-create-resource-specific-registry-keys.md)
