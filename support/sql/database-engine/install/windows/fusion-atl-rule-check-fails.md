---
title: Fusion ATL rule check fails
description: This article provides a workaround for the problem that occurs when you try to uninstall a SQL Server instance or when you try to remove a SQL Server node from a failover cluster.
ms.date: 09/25/2020
ms.custom: sap:Installation, Patching and Upgrade
---
# The Fusion ATL rule check fails when you try to uninstall a SQL Server 2008 instance or when you try to remove a SQL Server 2008 node from a failover cluster

This article helps you resolve the problem that occurs when you try to uninstall a SQL Server instance or when you try to remove a SQL Server node from a failover cluster.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 955792

## Symptoms

When you try to uninstall a Microsoft SQL Server instance, or when you try to remove a SQL Server node from a failover cluster, the Fusion ATL rule check fails. When this occurs, the Setup program fails, and you receive the following error message: A computer restart is required because of broken fusion ATL. You must restart your computer before you continue.

## Cause

This problem occurs when the following conditions are true:

- The SQL Server Setup Support Files component was removed by the current uninstallation attempt or by the node removal action.

- The Fusion ATL assembly was not installed in the global assembly cache (GAC). Because an uninstallation or a node removal action does not install the missing SQL Server Setup Support Files setup component, the Fusion ATL rule fails.

## Workaround

To work around this problem, manually install the SQL Server Setup support files from the installation media before you run the uninstallation or the remove node action from the SQL Server Setup file. To do this, follow these steps:

1. Insert the original SQL Server installation media.
2. In Windows Explorer, locate the Sqlsupport.msi file in the following folder: `Drive:\Platform\setup`.

   > [!NOTE]
   > The Drive placeholder represents the drive letter of the installation media. The Platform placeholder represents the processor architecture of your installation. For example, the processor architecture may be designated x86, x64, or IA-64.

3. Double-click the *Sqlsupport.msi* file.
4. Follow the instructions to complete the installation of the SQL Server Setup support files.
