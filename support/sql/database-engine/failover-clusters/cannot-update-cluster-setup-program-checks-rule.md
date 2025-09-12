---
title: Can't update cluster if Setup program checks rule
description: This article provides a resolution for the problem that occurs when the Setup program checks the Cluster_IsOnlineIfClustered rule.
ms.date: 05/06/2025
ms.custom: sap:Always On Failover Cluster Instance (FCI)
ms.reviewer: ramakoni, clivec
---

# You can't update a SQL Server cluster when the Setup program checks the Cluster_IsOnlineIfClustered rule

This article helps you resolve the problem that occurs when the Setup program checks the `Cluster_IsOnlineIfClustered` rule.

_Original product version:_ &nbsp; SQL Server 2012 and later versions
_Original KB number:_ &nbsp; 2817733

## Symptoms

Consider the following scenario:

- In a cluster environment, you install an instance of Microsoft SQL Server.

- You try to install SQL Server service packs or cumulative updates on the server that contains this instance.

In this situation, the installation operation fails early in the process. Specifically, the operation fails when the Setup program checks the `Cluster_IsOnlineIfClustered` rule. Additionally, a message that resembles the following one is logged in the *Detail.txt* file:

```console
<Time Stamp> Slp: Init rule target object: Microsoft.SqlServer.Configuration.Cluster.Rules.ClusterServiceFacet
<Time Stamp> Slp: The given key was not present in the dictionary.
<Time Stamp> Slp: at Microsoft.SqlServer.Chainer.Infrastructure.ServiceContainer.GetService(Type serviceType)

at Microsoft.SqlServer.Chainer.Infrastructure.ServiceContainer.GetService[T]()

at Microsoft.SqlServer.Chainer.Infrastructure.ServiceContainer.get_Cluster()

at Microsoft.SqlServer.Configuration.Cluster.Rules.ClusterServiceFacet.Microsoft.SqlServer.Configuration.RulesEngineExtension.IRuleInitialize.Init(String ruleId)

at Microsoft.SqlServer.Configuration.RulesEngineExtension.RulesEngine.Execute(Boolean stopOnFailure)

<Time Stamp> Slp: Rule initialization failed - hence the rule result is assigned as Failed
```

> [!NOTE]
> The *Detail.txt* file is located at `%ProgramFiles%\Microsoft SQL Server\110\Setup Bootstrap\Log\<YYYYMMDD_HHMM>`.

## Cause

This issue occurs because of an invalid MSCluster namespace in Windows Management Instrumentation (WMI).

## Resolution

To resolve this issue, follow these steps:

1. At an administrative command prompt, type `cd %systemroot%\system32\wbem`, and then press **Enter**.
2. Type the command `regsvr32 cluswmi.dll`, and press **Enter**.

3. Type the command `mofcomp.exe ClusWMI.mof`, and press **Enter**.

4. Rerun the setup of the service packs or cumulative updates on the server.

## More information

To identify that this issue is caused by the WMI namespace for the cluster, follow these steps:

1. Log on as the account that is administrator on the cluster and is running SQL Server Setup.
2. Run the command `wbemtest` at an administrative command prompt.
3. On the **Windows Management Instrumentation Tester** window, select **Connect...**.
4. Type *root\MSCluster* in **Namespace**, and then select the **Connect** button. In this situation, you may receive an error message that resembles the following one:

   > Number: 0x8004100e  
   Facility: WMI  
   Description: Invalid namespace

   > [!NOTE]
   > As an additional test, you can run the following query in Windows PowerShell:
   >
   > ```powershell
   >    SELECT name FROM <MSCluster_Cluster>
   >  ```
   >
   > If the issue isn't caused by an invalid MSCluster namespace, the expected result is that the cluster network name is returned.
