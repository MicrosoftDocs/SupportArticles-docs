---
title: Error 2931 deploying virtual machines
description: Describes an issue in which you receive error 2931 when you deploy virtual machines to a new Hyper-V cluster.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Error 2931 when you deploy virtual machines in System Center Virtual Machine Manager

This article fixes an issue in which you receive error 2931 when you deploy virtual machines to a new Hyper-V cluster.

_Original product version:_ &nbsp; System Center 2016 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2982790

## Symptom

In System Center 2012 R2 Virtual Machine Manager (VMM) and later versions of the program, when you deploy virtual machines (VM) from a VM template to a new Hyper-V cluster, you receive the following error message:

> Error (2931)  
> VMM is unable to complete the request. The connection to the VMM agent on the virtualization server (Node12.contoso.com) was lost.  
> Unknown error (0x80338029)  
> Recommended Action  
> Ensure that the Windows Remote Management (WS-Management) service and the VMM agent are installed and running and that a firewall is not blocking HTTPS traffic.  
> This can also happen due to DNS issues. Try and see if the server (Node12.contoso.com) is reachable over the network and can be looked up in DNS. You can ping the virtualization server from VMM management server and make sure that the IP address returned matches the IP address locally obtained from the virtualization server.  
> If the error still persists, restart the virtualization server, and then try the operation again.

In VMM trace, you receive messages that are similar to the following:

> 1492,*Date/Time*, 0x06CC,0x1304,4,CarmineObjectLock.cs,1122,0x00000000,LockableObject.LogIfNotDeletable: Object is not deletable: (FloppyDrive#1d3ac4) { objLock = (CarmineObjectLock#119e1a) { lockType = Write; objectID =*objectID*; objectType = VirtualFloppyDrive; taskID =*taskID* }; data = (FloppyDriveData#b367b6) { id =*id*; LastUpdatedTimestamp =*Date/Time*; objectType = VirtualFloppyDrive; name = "node12"; Enabled = True; Accessibility = Public; CreationTime =*Date/Time*; modifiedTime =*Date/Time*; ownerName = "" }; pendingChildAdditions = ∅; isNewObject = (bool) True },{00000000-0000-0000-0000-000000000000},1,

## Cause

The issue occurs because objects are locked in the VMM database.

## Resolution

To resolve the issue, follow these steps:

1. Restart the VMM service, and then deploy the VM again. If the issue persists, go to step 2.
2. Stop the VMM service, and then back up the VMM database.
3. Use the following query to check existing locks:

   ```sql
   SELECT * FROM [VirtualManagerDB].[dbo].[tbl_VMM_Lock]
   ```

4. If locks are listed in the tbl_VMM_Lock table, run the following command against the VMM database to clear the locks:

   ```sql
   exec prc_vmm_releasealllocks
   ```

5. Restart the VMM service.

## References

- [How to troubleshoot the "Needs Attention" and "Not Responding", and "Access Denied" host status in System Center Virtual Machine Manager](https://support.microsoft.com/help/2742246)
- [Error 2927 when you add a Hyper-V server or a Hyper-V cluster node in System Center VMM](https://support.microsoft.com/help/2875120)
