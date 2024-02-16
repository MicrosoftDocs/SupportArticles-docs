---
title: Transfer and seize FSMO roles
description: Describes how to transfer and seize Flexible Single Master Operations (FSMO) roles.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-fsmo, csstroubleshoot
---
# Flexible Single Master Operation transfer and seizure process  

This article describes how Flexible Single Master Operations (FSMO) roles are transferred from one domain controller to another and how this role can be forcefully appointed in the event that the domain controller that previously held the role is no longer available.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 223787

## Transferring the Flexible Single Master Operation role

The transfer of an FSMO role is the suggested form of moving a FSMO role between domain controllers and can be initiated by the administrator or by demoting a domain controller, but is not initiated automatically by the operating system. This includes a server in a shut-down state. FSMO roles aren't automatically relocated during the shutdown process—this must be considered when shutting down a domain controller that has an FSMO role for maintenance, for example.

In a graceful transfer of an FSMO role between two domain controllers, a synchronization of the data that is maintained by the FSMO role owner to the server receiving the FSMO role is performed prior to transferring the role to ensure that any changes have been recorded before the role change.

Operational attributes are attributes that translate into an action on the server. This type of attribute isn't defined in the schema, but is instead maintained by the server and intercepted when a client attempts to read or write to it. When the attribute is read, generally the result is a calculated result from the server. When the attribute is written, a pre-defined action occurs on the domain controller.

The following operational attributes are used to transfer FSMO roles and are located on the RootDSE (or Root DSA Specific Entry--the root of the Active Directory tree for a given domain controller where specific information about the domain controller is kept). In the operation of writing to the appropriate operational attribute on the domain controller to receive the FSMO role, the old domain controller is demoted and the new domain controller is promoted automatically. No manual intervention is required. The operational attributes that represent the FSMO roles are:

- becomeRidMaster
- becomeSchemaMaster
- becomeDomainMaster
- becomePDC
- becomeInfrastructureMaster

If the administrator specifies the server to receive the FSMO role using a tool such as Ntdsutil, the exchange of the FSMO role is defined between the current owner and the domain controller specified by the administrator.

When a domain controller is demoted, the operational attribute "GiveAwayAllFsmoRoles" is written, which triggers the domain controller to locate other domain controllers to offload any roles it currently owns. Windows 2000 determines which roles the domain controller being demoted currently owns and locates a suitable domain controller by following these rules:

1. Locate a server in the same site.
2. Locate a server to which there is RPC connectivity.
3. Use a server over an asynchronous transport (such as SMTP).

In all transfers, if the role is a domain-specific role, the role can be moved only to another domain controller in the same domain. Otherwise, any domain controller in the enterprise is a candidate.

## Seizing the Flexible Single Master Operation role

Administrators should use extreme caution in seizing FSMO roles. This operation, in most cases, should be performed only if the original FSMO role owner will not be brought back into the environment.

When the administrator seizes an FSMO role from an existing computer, the "fsmoRoleOwner" attribute is modified on the object that represents the root of the data directly bypassing synchronization of the data and graceful transfer of the role. The "fsmoRoleOwner" attribute of each of the following objects is written with the Distinguished Name (DN) of the NTDS Settings object (the data in the Active Directory that defines a computer as a domain controller) of the domain controller that is taking ownership of that role. As replication of this change starts to spread, other domain controllers learn of the FSMO role change.

Primary Domain Controller (PDC) FSMO:
LDAP://DC=MICROSOFT,DC=COM
RID Master FSMO:
LDAP://CN=Rid Manager$,CN=System,DC=MICROSOFT,DC=COM
Schema Master FSMO:
LDAP://CN=Schema,CN=Configuration,DC=Microsoft,DC=Com
Infrastructure Master FSMO:
LDAP://CN=Infrastructure,DC=Microsoft,DC=Com
Domain Naming Master FSMO:
LDAP://CN=Partitions,CN=Configuration,DC=Microsoft,DC=Com
For example, if Server1 is the PDC in the Microsoft.com domain and is retired and the administrator is unable to demote the computer properly, Server2 needs to be assigned the FSMO role of the PDC. After the seizure of the role takes place, the value
CN=NTDS Settings,CN=SERVER2,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=Microsoft,DC=Com
is present on the following object:
LDAP://DC=MICROSOFT,DC=COM

## References

For more information about FSMO roles in general, see the following article in the Microsoft Knowledge Base:  
[197132](https://support.microsoft.com/help/197132) Windows 2000 Active Directory FSMO Roles

For more information about the correct placement of FSMO roles, see the following article in the Microsoft Knowledge Base:  
[223346](https://support.microsoft.com/help/223346) FSMO Placement and Optimization on Windows 2000 Domains
