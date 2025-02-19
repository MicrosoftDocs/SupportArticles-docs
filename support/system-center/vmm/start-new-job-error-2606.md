---
title: Starting a new VMM job fails with error 2606
description: Fixes an issue in which you can't start a new job in System Center Virtual Machine Manager (VMM) and receive error 2606.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Starting a new job in System Center Virtual Machine Manager fails with error 2606

This article fixes an issue in which you can't start a new job in System Center Virtual Machine Manager (VMM) and receive error 2606.

_Original product version:_ &nbsp; System Center Virtual Machine Manager  
_Original KB number:_ &nbsp; 2795040

## Symptoms

When starting a new job in System Center Virtual Machine Manager, the following error may be generated:

> Error (2606)  
> Unable to perform the job because one or more of the selected objects are locked by another job.
>
> Recommended Action  
> To find out which job is locking the object, in the Jobs view, group by Status, and find the running or canceling job for the object. When the job is complete, try again.

A VMM trace will show lines similar to the following:

> 48412,04:24:10.457 02-10-2014,0x097C,0x05BC,4,CarmineObjectLock.cs,822,0x00000000,CarmineObjectLock; Task \<Task ID 1> Failed Acquiring Delete lock on VM object with ID \<Object ID> because Task \<Task ID 2> has Write lock,{00000000-0000-0000-0000-000000000000},1,

## Cause

This error is caused by locked records in the VMM database due to another job placing a lock on the objects that this job is attempting to access. This is by design.

## Resolution

To see what object locks currently exist, use the following VMM database query:

```sql
SELECT * FROM [VirtualManagerDB].[dbo].[tbl_VMM_Lock] where TaskID='Task_GUID'
```

If any records are present, make a backup of the database and run the command:

```sql
DELETE FROM [VirtualManagerDB].[dbo].[tbl_VMM_Lock] where TaskID='Task_GUID'
```

For example (from the error above):

```sql
DELETE FROM [VirtualManagerDB].[dbo].[tbl_VMM_Lock] where TaskID='<Task ID 2>'
```
