---
title: Troubleshoot Cluster service account
description: Describes how to troubleshoot the Cluster service when it creates or modifies a computer object in Active Directory for a server cluster (virtual server).
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, stevemat, ELDENC
ms.custom: sap:cluster-service-fails-to-start, csstroubleshoot
---
# How to troubleshoot the Cluster service account when it modifies computer objects

This article describes how to troubleshoot the Cluster service when it creates or modifies a computer object in Active Directory for a server cluster (virtual server).

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 307532

## Active Directory access rights for creating a computer object

By default, members of the Domain Users group are granted the user right to add workstations to a domain. By default, this user right is set to a maximum quota of 10 computer objects in Active Directory. If you exceed this quota, the following event ID message is logged:

> If several clusters are using the same domain account as their Cluster service account, you may receive this error message before you create ten computer objects in a given cluster. One way to resolve this issue is to grant the Cluster service account the Create Computer Objects permission on the Computers container. This permission overrides the Add Workstations to a Domain user right, which has a default quota of ten.

To verify that the Cluster service account has the Add Workstations to a Domain user right:

1. Sign in to the domain controller on which the Cluster service account is stored.
2. Start the Domain Controller Security Policy program from Administrative Tools.
3. Click to expand Local Policies, and then click to expand **User Rights Assignments**.
4. Double-click **Add Workstations to a Domain** and note the accounts that are listed.
5. The Authenticated Users group (the default group) should be listed. If it isn't listed, you must grant this user right to either the Cluster service account or a group that contains the Cluster service account on the domain controllers.

    > [!NOTE]
    > You must grant this user right to the domain controllers because computer objects are created on the domain controllers.
6. If you explicitly add the Cluster service account to this user right, run `gpupdate` on the domain controller (or run `secedit` for Windows 2000) so that the new user right is replicated to all domain controllers.
7. Verify that the policy won't be overwritten by another policy.

## Cluster Service account doesn't have proper user rights on local node

Verify that the Cluster Service account has the appropriate user rights on each node of the cluster. The Cluster Service account must be in the local administrators group and should have the rights listed below. These rights are given to the Cluster Service account during the configuration of the Cluster node. It's possible that a higher-level policy is over-writing the local policy or that an upgrade from a previous operating system doesn't add all of the required rights. To verify that these rights are given on the local node, follow these procedures:

1. Start the Local Security Settings console from the **Administrative Tools** group.
2. Navigate to **User Rights Assignments** under **Local Policies**.
3. Verify that the Cluster Service account has explicitly been given the following rights:
    - Sign in as a service
    - Act as part of the operating system
    - Back up files and directories
    - Adjust memory quotas for a process
    - Increase scheduling priority
    - Restore files and directories

    > [!NOTE]
    > If the Cluster Service account has been removed from the local Administrators Group, manually re-create the Cluster service account and give the Cluster Service the required rights.

    If any of the rights are missing, give the Cluster Service account explicit rights for it, then stop and restart the Cluster Service. The added rights don't take effect until you restart the Cluster Service. If the Cluster Service account still can't create a Computer Object, verify that a Group Policy isn't over-writing the Local Policy. To do it, you can either type gpresult at the Command Prompt if you are in a Windows 2000 Domain or Resultant Set of Policy (RSOP) from an MMC Snap-in if you are on a Windows Server 2003 domain.

    If you are in a Windows Server 2003 domain, search in Help and Support on "RSOP" for instructions on using Resultant Set of Policy.

    If the Cluster Service account doesn't have the "Act as part of the operating system" right, the Network Name resource will fail and the Cluster.log will register the following message:

      > Use the above steps to verify that the Cluster Service account has all the required rights. If the local security policies are being over-written by a Domain or Organizational Unit (OU) Group policy, then there are several options. You can place the Cluster nodes into their own OU that has the "Allow inheritable permissions from parent to propagate to this object" de-deselected.

## Required access rights when using a pre-created computer object

If members of the Authenticated Users group or the Cluster service account are blocked from creating a computer object, if you're the domain administrator, you must pre-create the virtual server computer object. You must grant certain access rights to the Cluster service account on the pre-created computer object. The Cluster service tries to update the computer object that matches the NetBIOS name of the virtual server.

To verify that the Cluster service account has the proper permissions on the computer object:

1. Start the Active Directory Users and Computers snap-in from Administrative Tools.
2. On the **View** menu, select **Advanced Features**.
3. Locate the computer object that you want the Cluster service account to use.
4. Right-click the computer object, and then select **Properties**.
5. Select the **Security** tab, and then select **Add**.
6. Add the Cluster service account or a group that the Cluster Service account is a member of.
7. Grant the user or the group the following permissions:

    - Reset Password
    - Validated Write to DNS Host Name
    - Validated Write to Service Principal Name
8. Select **OK**. If there are multiple domain controllers, you may need to wait for the permission change to be replicated to the other domain controllers (by default, a replication cycle occurs every 15 minutes).

## Network name resource doesn't come online when kerberos is disabled

A Network Name resource doesn't come online if a computer object exists but you don't select the **Enable Kerberos Authentication** option. To resolve the issue, use either of the following procedures:

- Delete the corresponding computer object in Active Directory.
- Select **Enable Kerberos Authentication** on the Network Name resource.
