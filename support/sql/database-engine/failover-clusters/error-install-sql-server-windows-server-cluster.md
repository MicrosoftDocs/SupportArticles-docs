---
title: Install SQL Server on Windows Server cluster
description: Provides a workaround for the problem that occurs when you install SQL Server on Windows Server cluster.
ms.date: 11/19/2020
ms.custom: sap:Failover Clusters
---

# Error message when you install SQL Server on a Windows Server cluster

This article helps you resolve the problem that occurs when you install SQL Server on a Windows Server cluster.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 953748

## Symptoms

When you install Microsoft SQL Server on a Windows Server cluster, the cluster validation rule of the setup process may fail. Additionally, you may receive the following error message:

> Error : "Microsoft Cluster Service (MSCS) cluster verification errors" failed. The cluster either has not been verified or there are errors or failures in the verification report. Refer to KB953748 or SQL server books online for more information"

The setup log file may contain a message that resembles the following:

> 2008-05-20 05:27:18 Slp: Evaluating rule : Cluster_VerifyForErrors  
2008-05-20 05:27:18 Slp: Rule running on machine: \<SQLNode_Name\>  
2008-05-20 05:27:18 Slp: Rule evaluation done : Failed  
2008-05-20 05:27:18 Slp: Rule evaluation message: The cluster either has not been verified or there are errors or failures in the verification report.

For example, the setup log file (*Detail.txt*) may be in the folder: `%ProgramFiles%\Microsoft SQL Server\100\Setup Bootstrap\Log\20090316_112604`.

For a successful validation, the rule will have an entry that resembles the following:

> Computer_name: Cluster_VerifyForErrors: Passed

## Cause

The validation process may fail under various conditions. When this issue occurs, you must perform a manual validation to make sure that the hardware configuration is correct before you try any workaround that's mentioned in this article. You can use the references that are mentioned in the [References](#references) section for more information about how to validate clusters in Windows Server environments. This helps prevent additional problems that you may experience in the future, if you use the workaround when underlying problems exist.

## Workaround

To work around this issue, you must fix the problem that caused validation to fail. If you can determine that the problem that caused validation to fail can be fixed later, you might want to use the command-line installation option in this article to ignore the error message, and to try to install the SQL Server failover cluster instance. If you do this, before using the system again you must still fix the underlying problem that caused validation to fail.

> [!NOTE]
> If you try this command line installation option and SQL Server Setup fails, make sure that the cluster hardware configuration is valid, and then contact Microsoft Customer Support Services (CSS) for more help.

At a command prompt, change to the hard disk drive and to the folder that contains SQL Server Setup (*Setup.exe*). Then, type one of the following commands to skip the validation rule:

- For an integrated failover Add-Note setup, run the command on each node that's being added:

  `Setup /SkipRules=Cluster_VerifyForErrors /Action=InstallFailoverCluster`

- For an advanced or enterprise installation, run the command:
  
  `Setup /SkipRules=Cluster_VerifyForErrors /Action=CompleteFailoverCluster`

- If you receive a validation failure when you add a node to an existing failover installation, run the command on each node that is being added:
  
  `Setup /SkipRules=Cluster_VerifyForErrors /Action=AddNode`

> [!NOTE]
> Setting up a SQL Server failover cluster instance on a Windows Server failover cluster that contains errors in the Windows Server Cluster Validation Report is unsupported. For a SQL Server failover cluster instance to be in a supported scenario, the Windows Server Cluster Validation Report can't contain errors. Confirm with CSS that the cluster configuration is in a supported state.

The `SkipRules` parameter for setup isn't a documented feature. You shouldn't use this parameter to skip any other rules except the `Cluster_VerifyForErrors` rule unless CSS directs you to do this.

## SQL Server failover cluster validation testing

By using the cluster validation wizard, you can run a set of focused tests on a collection of servers that you intend to use as nodes in a cluster. This cluster validation process tests the underlying hardware and software directly and individually, to obtain an accurate assessment of how well SQL Server failover clustering can be supported in a given configuration.

## What to do if validation tests fail

In most cases, if any tests in the cluster validation rule fail, Microsoft doesn't consider the solution to be supported. There are exceptions to this rule, such as the case with multiple-site (geographically dispersed) clusters where there is no shared storage. In this scenario, the expected result of the cluster validation wizard is that the storage tests will fail. This is still a supported solution if the rest of the tests finish successfully.

The kind of test that fails is a guideline to the corrective action to take. For example, if the **List all disks** storage test fails and if later storage tests don't run because they would also fail, contact the storage vendor to troubleshoot. Similarly, if a network test that's related to IP addresses fails, contact the network infrastructure team.

## References

- [Validate Hardware for a Failover Cluster](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134244(v=ws.11))

- [Always On Failover Cluster Instances (SQL Server)](/sql/sql-server/failover-clusters/windows/always-on-failover-cluster-instances-sql-server)

- [Install SQL Server from the Command Prompt](/sql/database-engine/install-windows/install-sql-server-from-the-command-prompt)

- [When you run the Validate a Configuration Wizard on a Windows Server 2008-based computer or on a Windows Vista-based computer, the validation does not pass](https://support.microsoft.com/help/950179)
