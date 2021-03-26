---
title: DCPROMO answer file syntax for unattended promotion and demotion of domain controllers
description: Describes the parameters and options that are used in the answer file to install and remove AD DS on domain controllers.
ms.date: 02/09/2021
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: justinha, kaushika
ms.prod-support-area-path: DCPromo and the installation of domain controllers
ms.technology: windows-server-active-directory
---

# DCPROMO answer file syntax for unattended promotion and demotion of domain controllers

This article describes the parameters and options that are used in the DCPROMO answer file to install and remove Active Directory Domain Services (AD DS) on domain controllers.

_Original product version:_ &nbsp;Windows Server 2012 R2  
_Original KB number:_ &nbsp;947034

## Summary

This article describes the syntax that you use to build answer files to perform unattended installations of AD DS on domain controllers. You can also use the answer files to remove AD DS in unattended mode.

## Introduction

The Dcpromo.exe program (DCPROMO) was introduced in Microsoft Windows 2000 Server to provide a GUI method of promoting and demoting Active Directory domain controllers. Administrators can use DCPROMO answer files to do the following unattended tasks:

- Promote workgroup and member servers to Active Directory domain controllers.
- Upgrade Microsoft Windows NT 4.0 domain controllers to Active Directory domain controllers.
- Demote domain controllers.

Windows Server 2003 updated the syntax for DCPROMO answer files.

Windows Server 2012 replaced DCPROMO with PowerShell cmdlets. However, the Windows Server 2003 version of the DCPROMO answer file syntax remains fully supported on the following Windows versions:

- Windows Server 2019
- Windows Server 2016
- Windows Server 2012 R2
- Windows Server 2012
- Windows Server 2008 R2
- Windows Server 2008

## More information

The DCPROMO answer file is an ASCII text file that provides automated user input for each page of the DCPROMO wizard.

Subtle differences exist between the DCPROMO answer file syntax in Windows 2000 Server and in Windows Server 2003. Despite these differences, Windows Server 2003 can read the Windows 2000 Server answer file syntax and interpret equivalent settings. However, the Windows Server 2003 answer file syntax may not work correctly on a Windows 2000 Server domain controller. For example, Windows 2000 Server cannot use the `RemoveApplicationPartitions` and `ConfirmGc` options.

If you have to use the same answer files on both Windows 2000 Server and Windows Server 2003 domain controllers, use the answer file syntax that is described in this article.

To start DCPROMO in unattended mode, open an administrative Command Prompt window, and run the following command:

```console
dcpromo /answer:<answer.txt>
```

> [!NOTE]  
> In this command, \<*answer.txt*> is the path and file name of the answer file that will be used for demotion or promotion. You can use this command whether you use the **Start** > **Run** command or an unattended Setup file.

Each DCPROMO operation requires answers to specific fields in the [DCInstall] section of the answer file. The following list provides the required fields for each operation. The default values are used if the option is not specified. The default values for these fields are described in [Field Definitions](#field-definitions).

- For new forest installations, the following options apply:

    [DCINSTALL]

    InstallDNS=yes  
    NewDomain=forest  
    NewDomainDNSName=\<The fully qualified Domain Name System (DNS) name>  
    DomainNetBiosName=\<By default, the first label of the fully qualified DNS name>  
    SiteName=\<Default-First-Site-Name>  
    ReplicaOrNewDomain=domain  
    ForestLevel=\<The forest functional level number>  
    DomainLevel=\<The domain functional level number>  
    DatabasePath="\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    RebootOnCompletion=yes  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    SafeModeAdminPassword=\<The password for an offline administrator account>  

- For child domain installations, the following options apply:

    [DCINSTALL]  
    ParentDomainDNSName=\<Fully qualified DNS name of parent domain>  
    UserName=\<The administrative account in the parent domain>  
    UserDomain=\<The name of the domain of the user account>  
    Password=\<The password for the user account> Specify * to prompt the user for credentials during the installation.  
    NewDomain=child  

    ChildName=\<The single-label DNS name of the new domain>  
    SiteName=\<The name of the AD DS site in which this domain controller will reside> This site must be created in advance in the Dssites.msc snap-in.  
    DomainNetBiosName=\<The first label of the fully qualified DNS name>  
    ReplicaOrNewDomain=domain  
    DomainLevel=\<The domain functional level number> This value can't be less than the current value of the forest functional level.  

    DatabasePath="\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    InstallDNS=yes  

    CreateDNSDelegation=yes  
    DNSDelegationUserName= \<The account that has permissions to create a DNS delegation> The account that is being used to install AD DS may differ from the account in the parent domain that has the permissions that are required to create a DNS delegation. In this case, specify the account that can create the DNS delegation for this parameter. Specify \* to prompt the user for credentials during the installation.  
    DNSDelegationPassword= \<The password for the account that is specified for DNSDelegationUserName> Specify * to prompt the user for a password during the installation.  
    SafeModeAdminPassword=\<The password for an offline administrator account>  
    RebootOnCompletion=yes  

- For a new tree in existing forest installations, the following options apply:

    [DCINSTALL]  
    UserName=\<An administrative account in the parent domain>  
    UserDomain=\<The name of the domain of the user account>  
    Password=\<The password for the adminstrative account> Specify \* to prompt the user for credentials during the installation.  
    NewDomain=tree  
    NewDomainDNSName=\<The fully qualified DNS name of the new domain>  
    SiteName=\<The name of the AD DS site in which this domain controller will reside> This site must be created in advance in the Dssites.msc snap-in.  
    DomainNetBiosName=\<The first label of the fully qualified DNS name>  
    ReplicaOrNewDomain=domain  
    DomainLevel=\<The domain functional level number>  
    DatabasePath="\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    InstallDNS=yes  
    CreateDNSDelegation=yes  
    DNSDelegationUserName= \<The account that has permissions to create a DNS delegation> The account that is being used to install AD DS may differ from the account in the parent domain that has the permissions that are required to create a DNS delegation. In this case, specify the account that can create the DNS delegation for this parameter. Specify \* to prompt the user for credentials during the installation.  
    DNSDelegationPassword=\<The password for the account that is specified for DNSDelegationUserName> Specify * to prompt the user for a password during the installation.  
    SafeModeAdminPassword=\<The password for an offline administrator account>  
    RebootOnCompletion=yes  

- For additional domain controller installations, the following options apply:

    [DCINSTALL]  
    UserName=\<The administrative account in the domain of the new domain controller>  

    UserDomain=\<The name of the domain of the new domain controller>  

    Password=\<The password for the UserName account>  

    SiteName=\<The name of the AD DS site in which this domain controller will reside> This site must be created in advance in the Dssites.msc snap-in.  

    ReplicaOrNewDomain=replica  

    ReplicaDomainDNSName=\<The fully qualified domain name (FQDN) of the domain in which you want to add an additional domain controller>  

    DatabasePath="\<The path of a folder on a local volume>"  

    LogPath="\<The path of a folder on a local volume>"  

    SYSVOLPath="\<The path of a folder on a local volume>"  

    InstallDNS=yes  

    ConfirmGC=yes  

    SafeModeAdminPassword=\<The password for an offline administrator account>  

    RebootOnCompletion=yes  

- For additional domain controller installations that use the Install From Media (IFM) method, the following options apply:

    [DCINSTALL]  
    UserName=\<The administrative account in the domain of the new domain controller>  
    Password=\<The password for the UserName account>  
    UserDomain=\<The name of the domain of the UserName account>  
    DatabasePath="\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    SafeModeAdminPassword=\<The password of an offline administrator account>  

    CriticalReplicationOnly=no  
    SiteName=\<The name of the AD DS site in which this domain controller will reside>  
    This site must be created in advance in the Dssites.msc snap-in.  

    ReplicaOrNewDomain=replica  
    ReplicaDomainDNSName=\<The fully qualified domain name (FQDN) of the domain in which you want to add an additional domain controller>  
    ReplicationSourceDC=\<An existing domain controller in the domain>  

    ReplicationSourcePath=\<The local drive and the path of the backup>  

    RebootOnCompletion=yes  

- For read-only domain controller (RODC) installations, the following options apply:

    [DCINSTALL]  
    UserName=\<The administrative account in the domain of the new domain controller>  
    UserDomain=\<The name of the domain of the user account>  
    PasswordReplicationDenied=\<The names of the user, group, and computer accounts whose passwords are not to be replicated to this RODC>  
    PasswordReplicationAllowed =\<The names of the user, group, and computer accounts whose passwords can be replicated to this RODC>  
    DelegatedAdmin=\<The user or group account name that will install and administer the RODC>  
    SiteName=Default-First-Site-Name  
    CreateDNSDelegation=no  
    CriticalReplicationOnly=yes  

    Password=\<The password for the UserName account>  
    ReplicaOrNewDomain=ReadOnlyReplica  
    ReplicaDomainDNSName=\<The FQDN of the domain in which you want to add an additional domain controller>  
    DatabasePath= "\<The path of a folder on a local volume>"  
    LogPath="\<The path of a folder on a local volume>"  
    SYSVOLPath="\<The path of a folder on a local volume>"  
    InstallDNS=yes  
    ConfirmGC=yes  
    SafeModeAdminPassword=\<The password for an offline administrator account>  
    RebootOnCompletion=yes  

- For removal of AD DS, the following options apply:

    [DCINSTALL]  
    UserName=\<An administrative account in the domain>  
    UserDomain=\<The domain name of the administrative account>  
    Password=\<The password for the UserName account>  
    AdministratorPassword=\<The local administrator password for the server>  
    RemoveApplicationPartitions=yes  
    RemoveDNSDelegation=yes  
    DNSDelegationUserName=\<The DNS server administrative account for the DNS zone that contains the DNS delegation>  
    DNSDelegationPassword=\<The password for the DNSDelegationUserName account>  
    RebootOnCompletion=yes  

- For removal of AD DS from the last domain controller in a domain, the following options apply:

    [DCINSTALL]  
    UserName=\<An administrative account in the parent domain>  
    UserDomain=\<The domain name of the UserName account>  
    Password=\<The password for the UserName account> Specify * to prompt the user for credentials during the installation.  
    IsLastDCInDomain=yes  
    AdministratorPassword=\<The local administrator password for the server>  
    RemoveApplicationPartitions=If you want to remove the partitions, specify "yes" (no quotation marks) for this entry. If you want to keep the partitions, this entry is optional.  
    RemoveDNSDelegation=yes  
    DNSDelegationUserName=\<The DNS server administrative account for the DNS zone that contains the DNS delegation>  
    DNSDelegationPassword=\<The password for the DNS server administrative account>  
    RebootOnCompletion=yes  

- For removal of the last domain controller in a forest, the following options apply:

    [DCINSTALL]  
    UserName=\<An administrative account in the parent domain>  
    UserDomain=\<The domain name of the UserName account>  
    Password=\<The password for the UserName account> Specify * to prompt the user for credentials during the installation.  
    IsLastDCInDomain=yes  
    AdministratorPassword=\<The local administrator password for the server>  
    RemoveApplicationPartitions=If you want to remove the partitions, specify "yes" (no quotation marks) for this entry. If you want to keep the partitions, this entry is optional.  
    RemoveDNSDelegation=yes  
    DNSDelegationUserName=\<The DNS server administrative account for the DNS zone that contains the DNS delegation>  
    DNSDelegationPassword=\<The password for the DNS server administrative account>  
    RebootOnCompletion=yes  

### Field definitions

This section describes the fields and the entries that you can use in the answer file. The default value for each entry appears in bold text.

#### Installation operation parameters

##### AllowDomainReinstall

- Yes | No
- This entry specifies whether an existing domain is re-created.

##### AllowDomainControllerReinstall

- Yes | No
- This entry specifies whether to continue to install this domain controller even though an active domain controller account that uses the same name is detected. Specify "Yes" (no quotation marks) only if you're sure that the account is no longer being used.

##### ApplicationPartitionsToReplicate

- No default
- This entry specifies the application partitions that have to be replicated in the format ""partition1" "partition2"". If * is specified, all application partitions will be replicated. Use space-separated or comma-and-space-separated distinguished names. Enclose the whole string in quotation marks.

##### ChildName

- No default
- This is the name of the subordinate domain that is appended to the ParentDomainDNSName entry. If the parent domain is "A.COM," and the subordinate domain is "B," enter "B.A.COM and B" (no quotation marks) for ChildName.

##### ConfirmGc

- Yes | No
- This entry specifies whether the replica is also a global catalog. "Yes" makes the replica a global catalog if the backup was a global catalog. "No" doesn't make the replica a global catalog. (These entries don't require quotation marks.)

##### CreateDNSDelegation

- Yes | No
- No default
- This entry indicates whether to create a DNS delegation that references this new DNS server. This entry is valid for AD DS-integrated DNS only.

##### CriticalReplicationOnly

- Yes | No
- This entry specifies whether the installation operation performs only important replication before a restart and then skips the noncritical and potentially lengthy part of replication. The noncritical replication occurs after the role installation is complete, and the computer restarts.

##### DatabasePath

- %systemroot%\\NTDS
- This entry is the path of the fully qualified, non-Universal Naming Convention (UNC) directory on a hard disk of the local computer. This directory will host the AD DS database (NTDS.DIT). If the directory exists, it must be empty. If it doesn't exist, it will be created. Free disk space on the logical drive that is selected must be 200 megabytes (MB). To accommodate rounding errors or all objects in the domain, free disk space may have to be larger. For best performance, locate the directory on a dedicated hard disk.

##### DelegatedAdmin

- No default
- This entry specifies the name of the user or the group who will install and administer the RODC. If no value is specified, only members of the Domain Admins group or the Enterprise Admins group can install and administer the RODC.

##### DNSDelegationPassword

- \<Password> | *

- No default
- This entry specifies the password for the user account that is used to create or remove the DNS delegation. Specify * to prompt the user to enter credentials.

##### DNSDelegationUserName

- No default
- This entry specifies the user name to be used when the DNS delegation is created or removed. If you don't specify a value, the account credentials that you specify for the installation or removal of AD DS are used for the DNS delegation.

##### DNSOnNetwork

- Yes | No
- This entry specifies whether the DNS service is available on the network. This entry is used only when the network adapter for this computer isn't configured to use the name of a DNS server for name resolution. Specify "No" (no quotation marks) to indicate that DNS will be installed on this computer for name resolution. Otherwise, the network adapter must be configured to use a DNS server name first.

##### DomainLevel

- 0 | 2 | 3
- No default
- This entry specifies the domain functional level. This entry is based on the levels that exist in the forest when a new domain is created in an existing forest. Value descriptions are as follows:
  - 0 = Windows 2000 Server native mode
  - 2 = Windows Server 2003
  - 3 = Windows Server 2008

##### DomainNetbiosName

- No default
- This entry is the NetBIOS name that is used by pre-AD DS clients to access the domain. The DomainNetbiosName must be unique on the network.

##### ForestLevel

- 0 | 2 | 3

- This entry specifies the forest functional level when a new domain is created in a new forest as follows:

- 0 = Windows 2000 Server
  - 2 = Windows Server 2003
  - 3 = Windows Server 2008
You must not use this entry when you install a new domain controller in an existing forest. The ForestLevel entry replaces the SetForestVersion entry that is available in Windows Server 2003.

##### InstallDNS

- Yes | No
- The default value changes depending on the operation. For a new forest, the DNS server role is installed by default. For a new tree, a new child domain, or a replica, a DNS server is installed by default if an existing DNS infrastructure is detected by the Active Directory Domain Services Installation Wizard. If no existing DNS infrastructure is detected by the wizard, a DNS server isn't installed by default.
- This entry specifies whether DNS is configured for a new domain if the Active Directory Domain Services Installation Wizard detects that the DNS dynamic update protocol isn't available. This entry also applies if the wizard detects an insufficient number of DNS servers for an existing domain.

##### LogPath

- %systemroot%\\NTDS
- This is the path of the fully qualified, non-UNC directory on a hard disk on the local computer that will host the AD DS log files. If the directory exists, it must be empty. If it doesn't exist, it will be created.

##### NewDomain

- Tree | Child | Forest
- "Tree" means the new domain is the root of a new tree in an existing forest. "Child" means the new domain is a child of an existing domain. "Forest" means the new domain is the first domain in a new forest of domain trees.

##### NewDomainDNSName

- No default
- This entry is used in "new tree in existing forest" or "new forest" installations. The value is a DNS domain name that is currently not being used.

##### ParentDomainDNSName

- No default
- This entry specifies the name of an existing parent DNS domain for a child domain installation.

##### Password

- \<Password> | *
- No default
- This entry specifies the password that corresponds to the user account that is used to configure the domain controller. Specify * to prompt the user to enter credentials. For protection, passwords are removed from the answer file following an installation. Passwords must be redefined every time that an answer file is used.

##### PasswordReplicationAllowed

- \<Security_Principal> | NONE

- No default
- This entry specifies the names of computer accounts and user accounts whose passwords can be replicated to this RODC. Specify "NONE" (no quotation marks) if you want to keep the value empty. By default, no user credentials will be cached on this RODC. To specify more than one security principal, add the entry multiple times.

##### PasswordReplicationDenied

- \<Security_Principal> | NONE

- This entry specifies the names of the user, group, and computer accounts whose passwords aren't to be replicated to the RODC. Specify "NONE" (no quotation marks) if you don't want to deny the replication of credentials for any users or computers. To specify more than one security principal, add the entry multiple times.

##### RebootOnCompletion

- Yes | No
- This entry specifies whether to restart the computer after you install or remove AD DS regardless of whether the operation was successful.

##### RebootOnSuccess

- Yes | No | NoAndNoPromptEither

- This entry specifies whether the computer must be restarted after AD DS has been installed or removed successfully. A restart is always required to complete a change in an AD DS role.

##### ReplicaDomainDNSName

- No default
- This entry specifies the FQDN of the domain in which you want to configure an additional domain controller.

##### ReplicaOrNewDomain

- Replica | ReadOnlyReplica | Domain

- This entry is used only for new installations. "Domain" (no quotation marks) converts the server into the first domain controller of a new domain. "ReadOnlyReplica" (no quotation marks) converts the server into a RODC. "Replica" (no quotation marks) converts the server into an additional domain controller.

##### ReplicationSourceDC

- No default
- This entry specifies the FQDN of the partner domain controller from which AD DS data is replicated to create the new domain controller.

##### ReplicationSourcePath

- No default
- This entry specifies the location of the installation files that are used to create a new domain controller.

##### SafeModeAdminPassword

- \<Password> | NONE
- No default
- This entry is used to supply the password for the offline administrator account that is used in Directory Service Restore Mode. You can't specify an empty password.

##### SiteName

- Default-First-Site-Name
- This entry specifies the site name when you install a new forest. For a new forest, the default is Default-First-Site-Name. For all other scenarios, a site will be selected by using the current site and the subnet configuration of the forest.

##### SkipAutoConfigDNS

- No default
- This entry is for expert users who want to skip automatic configuration of client settings, forwarders, and root hints. The entry is only in effect if the DNS Server service is already installed on the server. In this case, you'll receive an informational message that confirms that the automatic configuration of DNS was skipped. Otherwise, this entry is ignored. If you specify this switch, make sure that zones are created and configured correctly before you install AD DS, or the domain controller won't operate correctly. This entry doesn't skip automatic creation of the DNS delegation in the parent DNS zone. To control DNS delegation creation, use the DNSDelegation entry.

##### Syskey

- \<system_key> | NONE
- This entry specifies the system key for the media from which you replicate the data.

##### SYSVOLPath

- %systemroot%\\SYSVOL
- This entry specifies a fully qualified, non-UNC directory on the hard disk of the local computer. This directory will host the AD DS log files. If the directory already exists, it must be empty. If it doesn't exist it will be created. The directory must be located on a partition that was formatted by using the NTFS 5.0 file system. Locate the directory on a different physical hard disk than the operating system for best performance.

##### TransferIMRoleIfNeeded

- Yes | No
- This entry specifies whether to transfer the infrastructure master role to this domain controller. This entry is useful if the domain controller is currently hosted on a global catalog server, and you don't plan to make the domain controller a global catalog server. Specify "Yes" (no quotation marks) to transfer the infrastructure master role to this domain controller. If you specify "Yes," make sure that you specify the ConfirmGC=No entry.

##### UserDomain

- No default
- This entry specifies the domain name for the user account that is used for install AD DS on a server.

##### UserName

- No default
- This entry specifies the user account name that is used for installing AD DS on a server. We recommend that you specify the account credentials in the \<domain>\\<user_name> format.

#### Removal operation parameters

##### AdministratorPassword

- No default
- This entry is used to specify the local administrator password when you remove AD DS from a domain controller.

##### DemoteFSMO

- Yes | No
- This entry indicates whether a forced removal happens even if an operations master role is held by the domain controller.

##### DNSDelegationPassword

- \<Password> | *

- No default
- This entry specifies the password for the user account that is used to create or to remove the DNS delegation. Specify * to prompt the user to enter credentials.

##### DNSDelegationUserName

- No default
- This entry specifies the user name to be used when the DNS delegation is created or removed. If you don't specify a value, the account credentials that you specify for the AD DS installation or for the AD DS removal are used for the DNS delegation.

##### IgnoreIsLastDcInDomainMismatch

- Yes | No
- This entry specifies whether to continue the removal of AD DS from the domain controller when either the IsLastDCInDomain=Yes entry is specified or the Active Directory Domain Services Installation Wizard detects that there's actually another active domain controller in the domain. This entry also applies to a scenario in which the IsLastDCInDomain=No entry is specified, and the wizard can't contact any other domain controller in the domain.

##### IgnoreIsLastDNSServerForZone

- Yes | No
- This entry specifies whether to continue removing AD DS even though the domain controller is the last DNS server for one or more AD DS-integrated DNS zones that the domain controller hosts.

##### IsLastDCInDomain

- Yes | No
- This entry specifies whether the domain controller from which you remove AD DS is the last domain controller in the domain.

##### Password

- \<Password> | *
- No default
- This entry specifies the password that corresponds to the user account that is used to configure the domain controller. Specify * to prompt the user to enter credentials. For protection, passwords are removed from the answer file after you install AD DS. Passwords must be redefined every time that an answer file is used.

##### RebootOnCompletion

- Yes | No
- This entry specifies whether to restart the computer after you install or remove AD DS regardless of whether the operation was successful.

##### RebootOnSuccess

- Yes | No | NoAndNoPromptEither

- Determines whether the computer must be restarted after AD DS has been successfully installed or removed. A restart is always required to complete a change in an AD DS role.

##### RemoveApplicationPartitions

- Yes | No
- This entry specifies whether to remove application partitions when you remove AD DS from a domain controller. "Yes" (no quotation marks) removes application partitions on the domain controller. "No" (no quotation marks) doesn't remove application partitions on the domain controller. If the domain controller hosts the last replica of any application directory partition, you must manually confirm that you must remove these partitions.

##### RemoveDNSDelegation

- Yes | No

- This entry specifies whether to remove DNS delegations that point to this DNS server from the parent DNS zone.

##### RetainDCMetadata

- Yes | No
- This entry specifies whether domain controller metadata is retained in the domain after AD DS removal so that a delegated administrator can remove AD DS from an RODC.

##### UserDomain

- No default
- This entry specifies the domain name for the user account that is used to install AD DS.

##### UserName

- No default
- This entry specifies the user account name that is used to install AD DS on a server. We recommend that you specify the account credentials in the \<domain>\\<user_name> format.

### Unattended installation return codes

The Active Directory Domain Services Installation Wizard returns a success code or a failure code after you complete the unattended installation of a Windows Server 2008-based domain controller. For more information about the unattended installation return codes, visit the following Microsoft Web site:

[Unattended Installation Return Codes](https://technet.microsoft.com/library/cc754937%28ws.10%29.aspx)
