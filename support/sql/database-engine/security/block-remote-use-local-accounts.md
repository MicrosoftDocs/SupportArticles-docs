---
title: Block remote use of local accounts in Windows
description: This article describes how to block remote use of local accounts in Windows.
ms.date: 10/30/2020
ms.custom: sap:Security Issues
ms.reviewer: chrissk, delhan
ms.topic: how-to
---
# Block the remote use of local accounts in Windows

This article describes how to block remote use of local accounts in Windows.

_Original product version:_ &nbsp; SQL Server 2016 Developer, SQL Server 2016 Enterprise, SQL Server 2016 Enterprise Core  
_Original KB number:_ &nbsp; 4488256

## Summary

When you use local accounts for remote access in Active Directory environments, you may experience any of several different problems. The most significant problem occurs if an administrative local account has the same user name and password on multiple devices. An attacker who has administrative rights on one device in that group can use the accounts password hash from the local Security Accounts Manager (SAM) database to gain administrative rights over other devices in the group that use "pass the hash" techniques.

## More information

Our latest security guidance responds to these problems by taking advantage of new Windows features to block remote logons by local accounts. Windows 8.1 and Windows Server 2012 R2 introduced the following security identifiers (SIDs):

- **S-1-5-113: NT AUTHORITY\Local account**  

- **S-1-5-114: NT AUTHORITY\Local account and member of Administrators group**

These SIDs are also defined on Windows 7, Windows 8, Windows Server 2008 R2, and Windows Server 2012 after you install update [Microsoft Security Advisory: Update to improve credentials protection and management: May 13, 2014](https://support.microsoft.com/help/2871997).

The first SID is added to the users access token at the time of logon if the user account that's being authenticated is a local account. The second SID is also added to the token if the local account is a member of the built-in Administrators group.

These SIDs can grant access or deny access to all local accounts or all administrative local accounts. For example, you can use these SIDs in User Rights Assignments in Group Policy to "Deny access to this computer from the network" and "Deny log on through Remote Desktop Services." This is the recommended practice in our latest security guidance. To achieve the same effect before these new SIDs were defined, you had to explicitly name each local account that you wanted to restrict.

In the initial release of the Windows 8.1 and Windows Server 2012 R2 guidance, we denied network and remote desktop logon to Local account (S-1-5-113) for all Windows client and server configurations. This blocks all remote access for all local accounts.

We have again discovered that failover clustering relies on a nonadministrative local account (CLIUSR) for cluster node management, and that blocking its network logon access causes cluster services to fail. Because the CLIUSR account isn't a member of the Administrators group, replacing S-1-5-113 with S-1-5-114 in the "Deny access to this computer from the network" setting enables cluster services to work correctly. It does this while still providing protection against "pass the hash" kinds of attacks by denying network logon to administrative local accounts.

Although we could keep the guidance unchanged and add a "special case" footnote for failover cluster scenarios, we instead opted to simplify deployments and change the Windows Server 2012 R2 Member Server baseline, as stated in the following table.

| **Policy Path**| `Computer Configuration\Windows Settings\Local Policies\User Rights Assignment` |
|---|---|
| **Policy Name**| Deny access to this computer from the network |
| **Original Value**| Guests, Local account* |
| **New Value**| Guests, Local account, and members of Administrators group* |
  
- This guidance also recommends that you add Domain Administrators (DA) and Enterprise Administrators (EA) to these restrictions. The exception is on domain controllers and dedicated administration workstations. DA and EA are domain-specific and can't be specified in generic Group Policy Object (GPO) baselines.

> [!NOTE]
>
> - This change applies only to the Member Server baseline. The restriction on remote desktop logon isn't being changed. Organizations can still decide to deny network access to Local account for nonclustered servers.
>
> - The restrictions on local accounts are intended for Active Directory domain-joined systems. Non-joined, workgroup Windows devices cannot authenticate domain accounts. Therefore, if you apply restrictions against the remote use of local accounts on these devices, you will be able to log on only at the console.

## More about the CLIUSR account

The CLIUSR account is a local user account that's created by the Failover Clustering feature if the feature is installed on Windows Server 2012 or later versions.

In the Windows Server 2003 and earlier versions of the Cluster Service, a domain user account was used to start the service. This Cluster Service Account (CSA) was used to form the cluster, join a node, do registry replication, and so on. Basically, any kind of authentication that was done between nodes used this user account as a common identity.

Several support issues were encountered because domain administrators were setting Group Policy policies that stripped permissions from domain user accounts. The administrators were not considering that some of those user accounts were used to run services.

For example, this issue was encountered in using the Logon as a Service right. If the Cluster Service account did not have this permission, it was not going to be able to start the Cluster Service. If you were using the same account for multiple clusters, you could experience production downtime across several important systems. You also had to deal with password changes in Active Directory. If you changed the user accounts password in Active Directory, you also had to change passwords across all clusters and nodes that use the account.

In Windows Server 2008, we redesigned everything about the way that we start the service to make the service more resilient, less error-prone, and easier to manage. We started using the built-in Network Service to start the Cluster Service. Remember that this isn't the full account, only a reduced privileged set. By reduced the scope of this account, we found a solution for the Group Policy issues.

For authentication, the account was switched over to use the computer object that's associated with the Cluster Name that's known as the Cluster Name Object (CNO) for a common identity. Because this CNO is a machine account in the domain, it automatically rotates the password, as defined by the domain policy for you. (By default, this is every 30 days.)

Starting in Windows Server 2008 R2, administrators started virtualizing everything in their datacenters. This includes domain controllers. The Cluster Shared Volumes (CSV) feature was also introduced and became the standard for private cloud storage. Some administrators embraced virtualization and virtualized every server in their datacenter. This includes adding domain controllers as a virtual machine to a cluster and using the CSV drive to hold the VHD/VHDX of the VM.

This created a "Catch 22" scenario for many companies. To mount the CSV drive to access the VMs, you had to contact a domain controller to retrieve the CNO. However, you couldn't start the domain controller because it was running on the CSV.

Having a slow or unreliable connection to domain controllers also affects I/O to CSV drives. CSV does intra-cluster communication through SMB, similar to connecting to file shares. To connect to SMB, the connection has to authenticate. In Windows Server 2008 R2, that involved authenticating the CNO by using a remote domain controller.

For Windows Server 2012, we had to think about how we could take the best of both worlds and avoid some issues that we were seeing. We're still using the reduced Network Service user right to start the Cluster Service. However, to remove all external dependencies, we now use a local (non-domain) user account for authentication between the nodes.

This local "user" account isn't an administrative account or domain account. This account is automatically created for you on each node when you create a cluster, or on a new node that's being added to the existing cluster. This account is self-managed by the Cluster Service. It automatically rotates the password for the account and synchronizes all the nodes for you. The CLIUSR password is rotated at the same frequency as the CNO, as defined by your domain policy. (By default, this is every 30 days.) Because the account is local, it can authenticate and mount CSV so that the virtualized domain controllers can start successfully. You can now virtualize all domain controllers without fear. Therefore, we're increasing the resiliency and availability of the cluster by reducing external dependencies.

This account is the CLIUSR account. It is identified by its description in the Computer Management snap-in.

:::image type="content" source="media/block-remote-use-local-accounts/cliusr-properties.png" alt-text="Screenshot of CLIUSR Properties in Computer Management.":::

A frequent question is whether the CLIUSR account can be deleted. From a security standpoint, additional local accounts (not default) may be flagged during audits. If the network administrator isn't sure what this account is for (that is, they don't read the description of "Failover Cluster Local Identity"), they may delete it without understanding the ramifications. For Failover Clustering to function correctly, this account is necessary for authentication.

:::image type="content" source="media/block-remote-use-local-accounts/passing-cliusr-credentials.png" alt-text="Screenshot shows CLIUSR credentials passing between Running Cluster and Joining Node.":::

1. Joining node starts the Cluster Service, and passes the CLIUSR credentials across.

1. To achieve the same effect, all credentials are passed so that the node can join.

We provided one more safeguard to make sure of continued success. If you accidentally delete the CLIUSR account, it will be re-created automatically when a node tries to join the cluster.

To summarize: The CLIUSR account is an internal component of the Cluster Service. It's self-managing so that you're not required to configure or manage it.

In Windows Server 2016, we went one step further by taking advantage of certificates to enable clusters to operate without any kind of external dependencies. This lets you create clusters by using servers that are located in different domains or outside all domains.
