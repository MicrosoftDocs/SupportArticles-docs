---
title: SQL Server 2008 setup issues
description: This article describes the SQL Server 2008 R2 and SQL Server 2008 setup issues.
ms.date: 09/17/2020
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni
---

# Known SQL Server 2008 R2 and SQL Server 2008 setup issues

This article discusses setup and migration issues that are specific to SQL Server 2008 R2 and SQL Server 2008 on a computer that is running Windows Server 2012 R2, Windows Server 2012, Windows 8.1, or Windows 8.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2681562

## Issue 1: You can't uninstall SQL Server 2008 Express Edition or SQL Server 2008 R2 Express Edition

### Symptoms

You may receive an error message that resembles the following when you try to uninstall SQL Server 2008 R2 or SQL Server 2008 Express Edition:

> The following feature couldn't be installed:  
.NET Framework 3.5 (includes .NET 2.0 and 3.0)

:::image type="content" source="media/sql-server-2008-setup-issues/feature-could-not-be-installed.png" alt-text="Screenshot of the error message: the following feature couldn't be installed." border="false":::

### Resolution

For information about how to resolve this issue, see [Cannot uninstall, repair, add new features to, or add a new instance to SQL Server 2008 or SQL Server 2008 R2 in Windows 8](https://support.microsoft.com/help/2861939).

### Workaround

To work around this issue, do one of the following:

- Enable the .NET Framework 3.5 before you uninstall SQL Server 2008 Express Edition.
- Copy the *MediaInfo.xml* file from the SQL Server 2008 R2 installation media or the SQL Server 2008 Express Edition installation media to the following folder before you try to uninstall SQL Server 2008 R2 or SQL Server 2008 Express Edition:

   *\Program Files (x86)\Microsoft SQL Server\100\Setup Bootstrap\SQLServer2008R2*

## Issue 2: The "Cluster Service verification" rule fails when you try to install a SQL Server 2008 R2 failover cluster instance

### Symptoms

When you try to install a SQL Server 2008 R2 failover cluster instance, the installation fails at the **Cluster Service verification** rule. When you view the details, you receive an error message that resembles the following:

:::image type="content" source="media/sql-server-2008-setup-issues/cluster-service-verification-rule-failed.png" alt-text="Screenshot of the Rule Check Result window, which shows Rule Cluster Service verification failed." border="false":::

### Cause

This issue occurs if the COM-based MSClus.dll library isn't enabled.

> [!NOTE]
> The SQL Server 2008 and SQL Server 2008 R2 cluster Setup programs depend on the COM-based MSClus.dll library. If this library isn't enabled on the cluster node, the Setup fails.

### Resolution

To resolve this issue, do one of the following:

- Enable the Failover Cluster Automation Server feature on each node by using Server Manager. In Server Manager, expand **Remote Server Administration Tools**, expand **Feature Administration Tools**, expand **Failover Clustering Tools**, and then select **Failover Cluster Automation Server**.

- Run the following Windows PowerShell cmdlet on each node to enable the Failover Cluster Automation Server feature:

    ```powershell
    add-windowsfeature RSAT-Clustering-AutomationServer
    ```

    > [!NOTE]
    > You must run this cmdlet at an elevated command prompt.
