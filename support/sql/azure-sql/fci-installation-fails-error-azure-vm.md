---
title: FCI installation fails with error on Azure VM
description: This article provides a resolution for the problem that occurs when you try to install a Microsoft SQL Server Failover Clustered Instance (FCI) in Windows Server 2019 on a Microsoft Azure virtual machine (VM).
ms.date: 01/15/2021
ms.prod-support-area-path: Azure SQL virtual machine
ms.reviewer: 
ms.topic: troubleshooting
ms.prod: sql 
---
# Error (The given key was not present in the dictionary) and SQL Server FCI installation fails on an Azure VM in Server 2019

This article helps you resolve the problem that occurs when you try to install a Microsoft SQL Server Failover Clustered Instance (FCI) in Windows Server 2019 on a Microsoft Azure virtual machine (VM).

_Applies to:_ &nbsp; SQL Server in VM - Windows, Windows Server 2019  
_Original KB number:_ &nbsp; 4525647

## Symptoms

When you try to install a Microsoft SQL Server Failover Clustered Instance (FCI) in Windows Server 2019 on a Microsoft Azure virtual machine (VM), the installation fails and you receive the following error message:

> The given key was not present in the dictionary.

In this situation, you can see the following additional information in the Details.txt log file in the SQL Server setup folder:

> Action Data:
  Feature = SQL_Engine_Core_Inst_sql_engine_core_inst_Cpu64
  Scenario = install
  Timing = ConfigNonRC
  ConfigObjectType = Microsoft.SqlServer.Configuration.ClusterConfiguration.FailoverClusterNamePrivateConfigObject
  FeatureName = SQL_Engine_Core_Inst
  FeatureCpuType = Cpu64
  FeaturePackageId = sql_engine_core_inst
  FeatureClusterState = CompleteFailoverCluster
Configuration action failed for feature SQL_Engine_Core_Inst during timing ConfigNonRC and scenario ConfigNonRC.
The given key was not present in the dictionary.
The configuration failure category of current exception is ConfigurationFailure
Configuration action failed for feature SQL_Engine_Core_Inst during timing ConfigNonRC and scenario ConfigNonRC.
System.Collections.Generic.KeyNotFoundException: The given key was not present in the dictionary.
   at System.ThrowHelper.ThrowKeyNotFoundException()
   at System.Collections.Generic.Dictionary`2.get_Item(TKey key)
   at Microsoft.SqlServer.Configuration.ClusterConfiguration.FailoverClusterNamePrivateConfigObject.CreateFailoverClusterNameResource(FailoverClusterNamePublicConfigObject pubConfig)
   at Microsoft.SqlServer.Configuration.ClusterConfiguration.FailoverClusterNamePrivateConfigObject.Install(ConfigActionTiming timing, Dictionary`2 actionData, PublicConfigurationBase spcb)
   at Microsoft.SqlServer.Configuration.SqlConfigBase.PrivateConfigurationBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, ConfigBaseAction action, Dictionary`2 actionData, PublicConfigurationBase spcbCurrent)
   at Microsoft.SqlServer.Configuration.SqlConfigBase.SqlFeatureConfigBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, ConfigBaseAction action, Dictionary`2 actionData, PublicConfigurationBase spcbCurrent)
   at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.ExecuteAction(String actionId)
   at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.Execute(String actionId, TextWriter errorStream)
The following is an exception stack listing the exceptions in outermost to innermost order
Inner exceptions are being indented
Exception type: System.Collections.Generic.KeyNotFoundException
    Message:
       The given key was not present in the dictionary.
    HResult : 0x80131577
    Data:
      SQL.Setup.FailureCategory = ConfigurationFailure
      WatsonConfigActionData = INSTALL@CONFIGNONRC@SQL_ENGINE_CORE_INST
      WatsonExceptionFeatureIdsActionData = System.String[]
    Stack:
        at System.ThrowHelper.ThrowKeyNotFoundException()
        at System.Collections.Generic.Dictionary`2.get_Item(TKey key)
        at Microsoft.SqlServer.Configuration.ClusterConfiguration.FailoverClusterNamePrivateConfigObject.CreateFailoverClusterNameResource(FailoverClusterNamePublicConfigObject pubConfig)
        at Microsoft.SqlServer.Configuration.ClusterConfiguration.FailoverClusterNamePrivateConfigObject.Install(ConfigActionTiming timing, Dictionary`2 actionData, PublicConfigurationBase spcb)
        at Microsoft.SqlServer.Configuration.SqlConfigBase.PrivateConfigurationBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, ConfigBaseAction action, Dictionary`2 actionData, PublicConfigurationBase spcbCurrent)
        at Microsoft.SqlServer.Configuration.SqlConfigBase.SqlFeatureConfigBase.Execute(ConfigActionScenario scenario, ConfigActionTiming timing, ConfigBaseAction action, Dictionary`2 actionData, PublicConfigurationBase spcbCurrent)
        at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.ExecuteAction(String actionId)
        at Microsoft.SqlServer.Configuration.SqlConfigBase.SlpConfigAction.Execute(String actionId, TextWriter errorStream)

## Cause

A new switch, **ManagementPointNetworkType**, that can be called by PowerShell cmdlets for [FailoverClusters](/powershell/module/failoverclusters/) is introduced in Windows Server 2019. You can use the following options for the new switch.

| **Switch parameter**| **Usage** |
|---|---|
| **Singleton**|Uses the traditional method of DHCP or static IP address.|
| **Distributed**|Use a Distributed Network Name by using Node IP addresses.|
| **Automatic**|Uses detection to determine the appropriate setting. If SQL Server is running in Azure, uses **Distributed**. If SQL Server is running on-premises, uses **Singleton** (default setting).|
|||

If you create the Windows cluster by using the Windows Cluster Manager Tool, the tool sets the switch parameter to **Automatic**. Because you are working on an Azure VM, the switch uses a Distributed Network Name instead.

You can verify this by running the following PowerShell command:

```powershell
C:\windows\system32> Get-clusterresource
```

The output that is returned by this command resembles the following:

```console
Name                 State          OwnerGroup                ResourceType
Cloud Witness                       Online Cluster Group      Cloud Witness
Cluster Name                        Online Cluster Group      Distributed Network Name
Cluster Pool 1                      Online 45d8f3c2-e8df-4a01-87b8-f3c383801f3f
                                                              Storage Pool
Cluster Virtual Disk
   (ClusterPerformanceHistory)      Online Cluster Group      Physical Disk
Health                              Online Cluster Group      Health Service
SDDC Management                     Online Cluster Group      SDDC Management
Storage QoS Resource                Online Cluster Group      Storage QoS Policy Manager
```

The `CreateFailoverClusterNameResource(FailoverClusterNamePublicConfigObject pubConfig)` function checks the resource name whose type isNetworkName. This is to verify that the Virtual Server Name that you entered already exists.

However, installing the SQL Server FCI on a Windows cluster that has only a Distributed Network Name is not supported. The error message that is mentioned in the [Symptoms](#symptoms) section indicates that there is no resource available in Windows Server 2019 whose type isNetworkName.

## Resolution

To fix this issue, you can delete the current cluster, and then create it again by using a PowerShell command that has the following parameter:

```powershell
managementpointnetworktype singleton
```
