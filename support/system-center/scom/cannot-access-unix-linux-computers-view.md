---
title: Cannot access the UNIX/Linux computers view
description: Fixes an issue in which you can't access the Unix/Linux Computers view in System Center 2012 R2 Operations Manager when the resource pool is deleted.
ms.date: 06/30/2020
ms.custom: linux-related-content
---
# You can't access the UNIX/Linux computers view in System Center 2012 R2 Operations Manager

This article helps you fix an issue in which you can't access the UNIX/Linux computers view in Microsoft System Center 2012 R2 Operations Manager.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 4075004

## Symptoms

You can't access the UNIX/Linux computers view in the **Administration** pane in System Center 2012 R2 Operations Manager. When this issue occurs, you receive the following error message:

> Date: <*DateTime*>  
> Application: Operations Manager  
> Application Version: <*VersionNumber*>  
> Severity: Error  
> Message:  
> System.NullReferenceException: Object reference not set to an instance of an object.  
   at Microsoft.SystemCenter.CrossPlatform.UI.OM.Integration.UnixComputerOperatingSystemHelper.JoinCollections(IEnumerable\`1 managementServers, IEnumerable\`1 resourcePools, IEnumerable\`1 unixcomputers, IEnumerable\`1 operatingSystems)  
   at Microsoft.SystemCenter.CrossPlatform.UI.OM.Integration.UnixComputerOperatingSystemHelper.GetUnixComputerOperatingSystemInstances(String criteria)  
   at Microsoft.SystemCenter.CrossPlatform.UI.OM.Integration.Administration.UnixAgentQuery.DoQuery(String criteria)  
   at Microsoft.EnterpriseManagement.Mom.Internal.UI.Cache.Query\`1.DoQuery(String criteria, Nullable\`1 lastModified)  
   at Microsoft.EnterpriseManagement.Mom.Internal.UI.Cache.Query\`1.FullUpdateQuery(CacheSession session, IndexTable& indexTable, Boolean forceUpdate, DateTime queryTime)  
   at Microsoft.EnterpriseManagement.Mom.Internal.UI.Cache.Query\`1.InternalSyncQuery(CacheSession session, IndexTable indexTable, UpdateReason reason, UpdateType updateType)  
   at Microsoft.EnterpriseManagement.Mom.Internal.UI.Cache.Query\`1.InternalQuery(CacheSession session, UpdateReason reason)  
   at Microsoft.EnterpriseManagement.Mom.Internal.UI.Cache.Query\`1.TryDoQuery(UpdateReason reason, CacheSession session)  
   at Microsoft.EnterpriseManagement.Mom.Internal.UI.Console.ConsoleJobExceptionHandler.ExecuteJob(IComponent component, EventHandler\`1 job, Object sender, ConsoleJobEventArgs args)

## Cause

The issue occurs if the UNIX/Linux monitoring resource pool is deleted.

## Resolution

To resolve the issue, follow these steps:

1. Create a resource pool for UNIX/Linux monitoring. Give the new pool a different name than the name of the deleted resource pool.
2. Add the management servers that perform UNIX/Linux monitoring to the new resource pool.
3. Configure the UNIX/Linux Run As accounts to be distributed by the new resource pool. To do this, follow these steps:

   1. In the Operations console, go to **Administration** > **Run As Configuration** > **UNIX/Linux Accounts**.
   2. For each account, follow these steps:

      1. Right-click the account, and then select **Properties**.
      2. On the **Distribution Security** page of the **UNIX/Linux Run As Accounts Wizard**, select **More Secure**.
      3. In **Selected computers and resource pools**, select **Add**.
      4. Select **Search by resource pool name**, and then select **Search**.
      5. Select the new resource pool that is created in step 1, select **Add**, and then select **OK**.

4. Run the following PowerShell cmdlet to retrieve the managed UNIX and Linux computers:

    ```powershell
    Get-SCXAgent
    ```

5. Verify that the agents that are associated with the deleted resource pool still exist and that the relationship remains.
6. Run the following command to change the managing resource pool to the one that is created in step 1:

    ```powershell
    $SCXPool = Get-SCOMResourcePool -DisplayName "<New Resource Pool Name>"
    Get-SCXAgent | Set-SCXResourcePool -ResourcePool $SCXPool
    ```

## References

- [How to Create a Resource Pool](/previous-versions/system-center/system-center-2012-R2/hh230706(v=sc.12))
- [How to Configure Run As Accounts and Profiles for UNIX and Linux Access](/previous-versions/system-center/system-center-2012-R2/hh212926(v=sc.12))
