---
title: Non-yielding error if the lock pages in memory option is disabled
description: Provides resolutions for the non-yielding scheduler error that occurs in large memory server if the lock pages in memory option is disabled.
ms.date: 06/01/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: ramakoni, pahaefel
---

# Non-yielding scheduler error in large memory server if the lock pages in memory option is disabled

_Applies to:_ &nbsp; SQL Server 2016 and later versions on Windows

## Symptoms

On a server hosting a SQL Server instance with a large amount of memory, SQL Server frequently allocates and frees memory. In this scenario, if you don't enable the [Lock Pages in Memory](/sql/database-engine/configure-windows/server-memory-server-configuration-options#lock-pages-in-memory-lpim) option for the SQL Server service account, SQL Server might encounter a non-yielding scheduler condition and generate a memory dump file. The SQL Server error log displays this entry:

```output
Process 0:0:0 (<ProcessID>) Worker <WorkerID> appears to be non-yielding on Scheduler 1. 
Thread creation time: 13246605454359. 
Approx Thread CPU Used: kernel 70203 ms, user 0 ms. Process Utilization 69%. System Idle 76%. Interval: 70213 ms.
```

Here is the top of stack:

```output
sqldk!SOS_MemoryBlockAllocator::CommitBlockAndCheckNumaLocality
sqldk!SOS_MemoryBlockAllocator::AllocateBlock
sqldk!SOS_MemoryWorkSpace::AllocatePage
sqldk!MemoryNode::AllocateReservedPages
sqldk!MemoryClerkInternal::AllocateReservedPages
```

## Cause

This problem occurs if large size or a large number of memory allocations or deallocations cause a long wait for those allocations and deallocations in the OS to complete.

> [!NOTE]
> In the entry, the kernel time is almost the same as the interval time, which indicates a high amount of privileged CPU time.

## Resolution

To fix this issue, [enable the Lock Pages in Memory option](/sql/database-engine/configure-windows/enable-the-lock-pages-in-memory-option-windows) for the SQL Server service account to keep data in physical memory. After this operation, the system uses the [Address Windowing Extensions](/windows/win32/memory/address-windowing-extensions) (AWE) API instead of the Virtual Memory Manager (VMM).

To enable the lock pages in memory option, follow these steps:

1. Press Win+R, in the **Open** box, type *gpedit.msc*.
1. On the Local Group Policy Editor console, expand **Computer Configuration** > **Windows Settings**.
1. Expand **Security Settings** > **Local Policies**.
1. Select the **User Rights Assignment** folder.

    The policies appear in the details pane.
1. In the pane, double-click **Lock pages in memory**.
1. In the **Local Security Setting** - **Lock pages in memory Properties** dialog box, select **Add User or Group**.
1. In the **Select Users, Service Accounts, or Groups** dialog box, select the SQL Server Service account.
1. Restart the SQL Server Service for this setting to take effect.

The following screenshot shows the Local Group Policy Editor console.

:::image type="content" source="./media/non-yielding-error-lock-pages-disable/lock-page-in-memeory.png" alt-text="Screenshot of Local Group Policy Editor console where the lock pages in memory option in the User Rights Assignment folder is selected." border="false":::
