---
title: Installation of SQL Server on a CSV Disk Fails
description: Provides a workaround for the folder permissions error that occurs when you install SQL Server on a Cluster Shared Volume (CSV) disk.
ms.date: 11/20/2026
ms.custom: sap:Always On Failover Cluster Instance (FCI)
ms.reviewer: jopilov
ai-usage: ai-assisted
---
# Error when you install SQL Server on a Cluster Shared Volume disk

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4082888

## Summary

This article helps you work around the folder permissions error that occurs when you install a Microsoft SQL Server instance on a Cluster Shared Volume (CSV) disk. The error occurs when the folder that you choose for the database files has inheritable permissions enabled. To work around the error, disable permission inheritance on the folder and convert the inherited permissions into explicit permissions. Then, retry the installation.

## Symptoms

When you install an instance of SQL Server on a CSV disk, SQL Server Setup might display an error message that resembles the following message:

> TITLE: Microsoft SQL Server Setup
>
> The following error has occurred:  
>
> Updating permission setting for folder 'C:\ClusterStorage\volume1\Data1\' failed. The folder permission setting were supposed to be set to 'D:P(A;OICI;FA;;;BA)(A;OICI;FA;;;SY)(A;OICI;FA;;;CO)(A;OICI;FA;;)'.
>
> Click 'Retry' to retry the failed action, or click 'Cancel' to cancel this action and continue setup.

## Cause

The folder that you choose for the database locations has inheritable permissions enabled. In the folder's advanced security settings, the **Disable inheritance** button is available.

## Workaround: Convert inherited permissions to explicit permissions

To work around this issue, disable permission inheritance on the folder that you want to use for the database files. The following steps use `C:\ClusterStorage\Volume1\Data1\` as an example folder.

1. Go to `C:\ClusterStorage\Volume1\`.
2. Right-click the **Data1** folder, and then select **Properties**.
3. Select the **Security** tab, and then select **Advanced**.
4. Select **Disable inheritance**, and then select **Convert inherited permissions into explicit permissions on this object**.
5. Retry the installation.

## Related content

- [Cluster Shared Volumes overview](/windows-server/failover-clustering/failover-cluster-csvs)
- [Manage Cluster Shared Volumes](/windows-server/failover-clustering/failover-cluster-manage-cluster-shared-volumes)
- [Create a new Always On failover cluster instance (Setup)](/sql/sql-server/failover-clusters/install/create-a-new-sql-server-failover-cluster-setup)
- [Always On failover cluster instances (SQL Server)](/sql/sql-server/failover-clusters/windows/always-on-failover-cluster-instances-sql-server)
