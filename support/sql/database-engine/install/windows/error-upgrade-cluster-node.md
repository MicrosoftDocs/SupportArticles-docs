---
title: Error when you upgrade the cluster node
description: This article provides a resolution for the problem that occurs when you try to upgrade a SQL Server 2008 or SQL Server 2008 R2 instance to SQL Server 2012 on a failover cluster.
ms.date: 10/23/2020
ms.custom: sap:Database Engine
ms.reviewer: ramakoni
---
# Error when you try to upgrade the cluster node to SQL Server 2012

This article provides a resolution for the problem that occurs when you try to upgrade a SQL Server 2008 or SQL Server 2008 R2 instance to SQL Server 2012 on a failover cluster.

_Original product version:_ &nbsp; SQL Server 2012  
_Original KB number:_ &nbsp; 2782511

## Symptoms

Consider the following scenario:

- You have a two-node Microsoft SQL Server failover cluster that is running on a Windows Server 2012 failover cluster. For example, the primary node is node A, and the passive node is node B.

    > [!NOTE]
    > The instance of SQL Server is either a SQL Server 2008 or SQL Server 2008 R2 instance.

- You try to upgrade the primary node (node A) to SQL Server 2012 by using the process that is documented in: [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance).

In this scenario, you receive an error message that resembles the following:

> The common properties for resource 'SQL Network Name (*SQL Name*)' could not be saved. Error: There was a failure to call cluster code from a provider. Exception message: One or more property values for this resource are in conflict with one or more property values associated with its dependent resource(s).

> [!NOTE]
>
> - SQL Name is a placeholder for the SQL Server network name.
> - Even though this issue causes an upgrade failure on node A, the SQL Server resource group fails over successfully to the upgraded node B. Additionally, because the failover operation takes less than one minute, all resources are online without noticeably disrupting client connectivity. However, to complete the upgrade process on node A, you have to follow additional steps that are mentioned in the [Resolution](#resolution) section.

## Cause

This issue occurs because of changes in Windows Server 2012 Failover Clustering.

## Resolution

This section covers the following actions:

- Complete the upgrade on node A.
- Prevent the issue from affecting new upgrades.

## Complete the upgrade on node A

Before you begin this process, be aware of the following:

- You can't remove node A by using the **Remove Node** operation. This operation will delete the SQL Server failover cluster instance. Therefore, you can't repair it.

- You can't uninstall the SQL Server failover cluster instance by using **Uninstall a program**. This operation doesn't work.

- You can't use an incorrect edition of the Setup media (for example, SQL Server 2008 or SQL Server 2008 R2) to run the **Remove Node** operation. This operation will corrupt the state of the computer.

To complete the upgrade for node A, there are two phases:

- Phase 1: Clean up after the failed upgrade attempt on node A to restore the pre-upgrade state.

  1. Close the Setup program and the error dialog if they aren't already closed, and let the upgrade program finish and report that the upgrade operation failed.

  1. Remove node A from the possible owners list in order to prevent accidentally failing over back to it. To change the possible owners list, do the following:

        1. Start the Failover Cluster Manager snap-in on any failover node.
        1. Under **Roles**, select the SQL Server failover cluster instance in the top pane.
        1. Click **Resources** in the bottom pane, right-click the **Server Name** resource, and then select **Properties**.
        1. Click **Advanced Policies** in the **Properties** dialog box.
        1. Select or clear the necessary check boxes for each node to add or remove the nodes.

  1. Open the *summary.txt* file in the following location *%Program Files%\Microsoft SQL Server\110\Setup Bootstrap\Log*.

     Find the following troubleshooting command in the *summary.txt* file: `setup /q /action=uninstall /instanceid=FOOINST /features=AS`

  1. Open a command prompt as an administrator and use the troubleshooting command together with the path of the SQL Server 2012 Setup file (*setup.exe*). For example, you use a command that resembles the following:

     `<SQL Server 2012 media path>\setup.exe /q /action=uninstall /instanceid=FOOINST /features=AS`

     > [!NOTE]
     >
     > - **SQL Server 2012 media path** is a placeholder for the path of the SQL Server 2012 media.
     > - This command runs silently, and is typically complete within five minutes.
     > - You can copy and paste the command-line arguments from the *summary.txt* file to prevent inputting mistakes. However, the `AS` feature has to be passed as a parameter that is exactly as suggested in the *summary.txt* file. Incorrect input of this command (especially the `instanceid` parameter) will cause the cleanup operation to fail, and potentially leave the computer in a corrupted state.
     > - Check the *summary.txt* file to confirm that the cleanup operation completed successfully.

- Phase 2: Upgrade node A to SQL Server 2012

  1. Start the SQL Server 2012 Setup media in UI mode.
  1. Select the **Upgrade** option under the **Installation** menu from the landing page, and then go to the **Instance Configuration** dialog box.
  1. Select the correct instance name, and then input the correct value in the **Instance ID** field.

     > [!NOTE]
     >
     > - Continuing the example in phase 1, the instance ID value is **FOOINST**.
     > - The Setup program doesn't automatically determine the instance ID. Therefore, you can't use the default prepopulated instance ID in the **Instance ID** field.
     > - You can review the *summary.txt* file to find the correct instance ID.

  1. Complete the upgrade process.
  1. After node A is successfully upgraded, add it back to the possible owners list on the **Server Name** resource of the SQL Server failover cluster instance.

## Prevent the issue from affecting new upgrades

To prevent this issue, use one of the following options:

- Option 1

   1. Upgrade no more than half of the passive nodes first, to avoid crossing the majority threshold.

     > [!NOTE]
     >
     > - If you have an even number of cluster nodes, upgrade no more than half of the passive nodes.
     > - If you have an odd number of cluster nodes, make sure that you upgrade less than half of the nodes in the cluster. If the majority of nodes in the cluster are upgraded, this issue will occur when the cluster resource group fails over.

   1. Manually add the upgraded passive nodes back to the possible owners list for the Server Name resource.
   1. Remove the non-upgraded nodes from the possible owners list.
   1. Manually fail over the SQL Server cluster group to one of the upgraded nodes.
   1. Upgrade the remaining non-upgraded nodes.
   1. When all the non-upgraded nodes are upgraded, manually add them back to the possible owners list on the Server Name resource.

- Option 2

  This issue is fixed in SQL Server 2012 Service Pack 1 (SP1). You can make the upgrade process on each cluster node by using Setup program binaries from the service pack. To do this, there are two methods.

  - Method A

    1. Download SQL Server 2012 SP1 to a local hard disk (for example to `c:\sp1`) or to a network share (for example, `\\share name\sp1`) that can be accessed by all the nodes.
    1. Start a command prompt as an administrator and run one of the following commands:

       - `<Download path>\setup.exe /action=upgrade /updatesource=c:\sp1`
       - `<Download path>\setup.exe /action=upgrade /updatesource=\\share name\sp1`

    1. Complete all the steps in the Setup program.

       > [!NOTE]
       > You can confirm whether the upgrade is using SQL Server 2012 SP1 Setup binaries by checking the *detail.log* file in the following location: `%Program Files%\Microsoft SQL Server\110\Setup Bootstrap\Log\<Time stamped folder>`

       Confirm that the version information that is located near the beginning of the log file shows that the SQL Server 2012 version is later than 11.0.2100.60. For example, the log file may contain the following:

  - Method B

    1. Download SQL Server 2012 SP1 to a local hard disk (for example to `c:\sp1`) or to a network share (for example, `\\share name\sp1`) that can be accessed by all the nodes.

    1. Start a command prompt as an administrator and run the following command:

       ```console
       Download path\SQL Server 2012 Service Pack 1 Package Name.exe/Q
       ```

       This command will pre-patch the node with SQL Server 2012 SP1 setup binaries.

        > [!NOTE]
        > You can't install the *SqlSupport.msi* file by itself, because it will cause the SQL Server 2012 Setup operation to fail, and an error about not having the *MSVCR100.dll* will be displayed. Use the`/Q` parameter to avoid this error. This parameter installs both the *Sqlsupport.msi* file and the Visual C++ runtime components.

    1. Complete all the steps in the Setup program.

## More information

[Download Service Pack 1 for SQL Server 2012](https://www.microsoft.com/download/details.aspx?id=35575)

## Applies to

- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Express
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
