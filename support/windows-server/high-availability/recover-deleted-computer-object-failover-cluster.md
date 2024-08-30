---
title: Recover deleted computer object in failover cluster
description: Describes how to recover a deleted computer object that supports a Network Name resource in a Windows Server failover cluster.
ms.date: 08/01/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ctimon, v-vincli, jeffhugh
ms.custom: sap:Clustering and High Availability\Cannot bring a resource online, csstroubleshoot
---
# How to recover a deleted computer object that supports a Network Name resource in a failover cluster

This article describes how to recover a deleted computer object that supports a Network Name resource in a failover cluster.

_Original KB number:_ &nbsp; 950805

## Summary

The security model in Windows Server Failover Clustering includes Kerberos authentication. To implement this security model, every Client Access Point (CAP) that is created in a failover cluster contains a Network Name resource. The Network Name resource has a corresponding computer account that is created in the Active Directory directory service when the resource is online for the first time.

By default, the computer account is created in the Computers container. However, the computer account can be relocated to another organizational unit (OU). The computer account can also be pre-staged in an OU before the CAP is created. If these computer accounts are deleted from Active Directory, availability of the Network Name resource will be reduced.

The computer accounts that are created in Active Directory represent the Network Name resources in a failover cluster. These accounts have the following distinct types:

- The computer account that represents the name of the cluster is called the Cluster Name Object (CNO). This account is the primary security context for a cluster.
- Other computer accounts that belong to Network Name resources in the same cluster are called Virtual Computer Objects (VCOs). These accounts are created by the CNO. If either of these accounts is deleted from Active Directory, the next time that the Network Name tries to go online, the Network Name fails, and Event ID 1207 is logged in the System log: 

  ```output
  Event Level: Error
  Event Source: FailoverClustering
  Event ID: 1207
  Description: Cluster network name resource <ResourceName> cannot be brought online. The computer object associated with the resource could not be updated in domain <DomainName> for the following reason:
  The text for the associated error code is: There is no such object on the server.
  The cluster identity <CNO$Name> may lack permissions required to update the object. Work with your domain administrator to ensure the cluster identity can update computer objects in the domain.
  ```


  And the following messages are logged in the cluster log:
  
  ```output
  WARN [RES] Network Name <FSCAP01>: Trying to remove credentials for LocalSystem returned status C0000225, STATUS_NOT_FOUND is a non-critical failure for a remove operation
  INFO [RES] Network Name <FSCAP01>: Initiating the Network Name operation: 'Verifying computer object associated with network name resource FSCAP01'
  INFO [RES] Network Name <FSCAP01>: Trying to find computer account FSCAP01 object GUID(d66e09dd8857e84da1f3a26fb1903e38) on any available domain controller.
  WARN [RES] Network Name <FSCAP01>: Search for existing computer account failed. status 80072030
  WARN [RES] Network Name <FSCAP01>: Search for existing computer account failed. status 80072030
  INFO [RES] Network Name <FSCAP01>: Trying to find object d66e09dd8857e84da1f3a26fb1903e38 on a PDC.
  WARN [RES] Network Name <FSCAP01>: Search for existing computer account failed. status 80072030
  INFO [RES] Network Name <FSCAP01>: Unable to find object d66e09dd8857e84da1f3a26fb1903e38 on a PDC.
  INFO [RES] Network Name <FSCAP01>: GetComputerObjectViaGUIDEx() failed, Status 80072030.
  WARN [RES] Network Name <FSCAP01>: Trying to remove credentials for LocalSystem returned status C0000225, STATUS_NOT_FOUND is a non-critical failure for a remove operation
  WARN [RHS] Resource FSCAP01 has indicated that it cannot come online on this node.
  WARN [RCM] HandleMonitorReply: ONLINERESOURCE for 'FSCAP01', gen(8) result 5015.
  ```
    
  > [!NOTE]
  > Status 80072030 = There is no such object on the server.

However, problems will occur even before the Network Name resource is cycled offline and online. For example, a user or a highly available application may be unable to access resources when a security token that represents the cluster computer object in Active Directory can't be obtained.

To recover from the deletion of a computer object that is associated with a cluster Network Name resource is different for a CNO than recovering from the deletion of a computer object for a VCO.

To recover a deleted computer object that corresponds to the CNO, follow these steps:

1. Coordinate with a domain administrator to first recover the deleted computer object from the Active Directory Recycle Bin, if it's enabled.

    > [!NOTE]
    > If the Active Directory Recycle Bin isn't enabled, the only supported method to recover a deleted CNO is to delete and re-create the cluster.

2. Verify that the computer object has been restored to the correct location, and then enable the account.
3. Force domain replication to occur, or wait for the configured replication interval.
4. In the Failover Cluster Management Microsoft Management Console (MMC) snap-in, right-click the failed network name that corresponds to the cluster name, point to **More actions**, and then select **Repair Active Directory Object**.

> [!NOTE]
> The user who follows these steps in the Failover Cluster Management MMC snap-in must also have the "Reset Passwords" permission in the domain.

To recover a deleted computer object that corresponds to a VCO, follow these steps:

1. Coordinate with a domain administrator to first recover the deleted computer object from the Active Directory Recycle Bin, if it's enabled.
2. Verify that the computer object has been restored to the correct location, and then enable the account.
3. View the security settings for the computer object, and then verify that the CNO still has permissions to the object.
4. Force domain replication, or wait for the configured replication interval.
5. In the Failover Cluster Management MMC snap-in, right-click the failed Network Name resource, and then select **Bring this resource online**. If a deleted computer object no longer exists in the Active Directory Recycle Bin, then the object never existed or it was deleted and garbage collected after meeting or exceeding tombstone lifetime. Never restore AD from a backup that is older than the tombstone lifetime. This can induce lingering objects into the environment.

## References

- [Recovering a Deleted Cluster Name Object (CNO) in a Windows Server 2008 Failover Cluster](/archive/blogs/askcore/recovering-a-deleted-cluster-name-object-cno-in-a-windows-server-2008-failover-cluster)
- [Event ID 1207 - Active Directory permissions for cluster accounts](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc773451(v=ws.10)?redirectedfrom=MSDN)
- [Active Directory backup and restore](https://technet.microsoft.com/library/bb727048.aspx)
