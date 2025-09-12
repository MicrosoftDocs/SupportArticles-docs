---
title: Error 2409 selecting a storage location
description: Fixes an issue in which you can't specify the storage location in System Center 2012 Virtual Machine Manager and receive error 2409.
ms.date: 04/09/2024
ms.reviewer: wenca, markstan
---
# Error 2409 in SCVMM 2012 when selecting a storage location on a cluster

This article fixes an issue in which you can't specify the storage location in System Center 2012 Virtual Machine Manager and receive error 2409.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2695838

## Symptoms

When attempting to specify the storage location in the **Select Path** dialog of the System Center 2012 Virtual Machine Manager (VMM) Create Virtual Machine wizard, you may receive an error similar to the following:

> Virtual Machine Manager  
> The specified path is not a valid folder path on *CLUSTERHOSTNAME.contoso.local*.  
> Specify a valid folder path on *CLUSTERHOSTNAME.contoso.local* which the virtual machine will be saved on.  
> ID: 2409

ETL logging will reveal a similar message:  

> 567 01:51:46.950 02-16-2012 ErrorDialog.cs(306) "Error Dialog.Show: Code: 2409; DetailedErrorCode: ; DetailedErrorSource: NoneProblem: The specified path is not a valid folder path on *CLUSTERHOSTNAME.contoso.local*.Action: Specify a valid folder path on *CLUSTERHOSTNAME.contoso.local* which the virtual machine will be saved on." {00000000-0000-0000-0000-000000000000}

## Cause

This error may occur if you select a local hard drive location on a cluster node rather than clustered storage (for example, you specify a local, non-clustered path such as *E:\\* or *E:\VMS*). Because this would result in creating a non-highly available (non-HA) virtual machine, this action is blocked on clustered hosts.

## Resolution

To resolve this error, click **OK** to dismiss the dialog and specify a clustered storage location such as a CSV or SAN volume.
