---
title: Self-service users can't open a console session to VMs
description: Fixes an issue in which Virtual Machine Manager 2012 self-service users can't connect to a console session of a virtual machine in Windows Server 2012.
ms.date: 04/09/2024
ms.reviewer: wenca, ctimon
---
# Self-service users can't open a console session to a virtual machine

This article helps you fix an issue in which Virtual Machine Manager (VMM) self-service users can't connect to a console session of a virtual machine running Windows Server 2012.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2986796

## Symptoms

When you try to connect to the console session of a virtual machine (VM) that's running in Windows Server 2012 by using Microsoft System Center 2012 R2 Virtual Machine Manager or Microsoft System Center 2012 Virtual Machine Manager Service Pack 1 (SP1), the connection fails, and you receive the following error message:

> Virtual Machine Manager lost the connection to the virtual machine for one of the following reasons.
>
> Another connection was established to the console of this machine  
> The virtual machine has been shut down or put into the saved state  
> The user credentials provided do not have the necessary privilege to connect
>
> (0x0003, 0x0000)

## Cause

This problem occurs because connection access to Windows Server 2012 hosts is controlled through a new method that uses the `Grant-VMConnectAccess` command. In some cases, invalid user accounts in the member list for the Virtual Machine Manager user role can prevent the list from being populated.

If the failure persists after you verify the potential reasons that are stated in the error message, the failure might, instead, occur because members of the Administrator or Self-Service user roles have unresolvable domain accounts, as represented by security identifiers (SIDs).

## Resolution

To resolve this problem, follow these steps:

1. Open the VMM console.
2. In the **Settings** workspace, select **Security**, and then select **User Roles**.
3. Select the **Administrator** user role.
4. On the ribbon bar, select **Properties** on the **Home** tab.
5. In the **Administrator Properties** dialog box, select **Members**.
6. Browse through the list of users. Remove any users that don't resolve to a domain account and that show only a SID.
7. Repeat steps 3 through 6 for any additional user roles.
8. After the SIDs are removed from each user role, an update to the `VMConnectAccess` permissions has to be pushed out by VMM. To trigger this event, change the access for a virtual machine. To do it, follow these steps:
   1. Select a virtual machine, and then select **Properties**.
   2. In the **Properties** dialog box, select the **Access** tab.
   3. In the **Self-Service Owner** field, enter a different user account, and then select **OK**.
   4. Verify that the job completed successfully.
   5. Revert access to the original user account.
9. Verify that the self-service user can now open a console session to their virtual machine.
