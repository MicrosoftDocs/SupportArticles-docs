---
title: Phantoms, tombstones, and the infrastructure master
description: Describes the behavior of non-GCs when object links are managed across domains in a forest.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Phantoms, tombstones, and the infrastructure master

This article describes how phantoms are used in Windows Server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 248047

## More information

Phantom objects are low-level database objects that Active Directory uses for internal management operations. Two common instances of phantom objects are as follows:

- An object that has been deleted.

    The tombstone lifetime has passed, but references to the object are still present in the directory database.
- A domain local group has a member user from another domain in the Active Directory forest. Phantom objects are special kinds of internal database tracking objects and can't be viewed through any LDAP or Active Directory Service Interfaces (ADSI).

### Object deletion

When an object is deleted from the active directory, the object follows the following process.

#### Stage 1: Normal objects

The object first exists as a typical Active Directory object. You can view the object by using the appropriate Active Directory and through the LDAP interface.

The object moves to Stage 2 when the object is deleted by an administrator or through another means.

#### Stage 2: Deleted objects before the tombstone lifetime expires

The object now exists as a Tombstone object for the length of the tombstone lifetime interval. While the object maintains some of its original form:

- Object is still a typical (non-phantom) object.
- The objectGUID attribute has not changed.

The object has also been significantly modified from its original form:

- The object moves to the DeletedObjects container (unless the object is flagged as a special system object)
- The object's DN attribute contains (esc)DEL:GUID
- Most of the object's other attributes have been removed completely.

The schema of the object determines the attributes that are removed, and the attributes that are kept after deletion. The designation of each attribute for an object class can be changed.

The objects can't be seen from normal Active Directory management tools. You may configure a low-level LDAP interface like LDP to view these objects.

The object moves to one of two possible states (Stage 3 or 4) when the tombstone lifetime has expired. The default tombstone lifetime is 60 days.

#### Stage 3: (Normal) object is removed from the active directory database Completely

If there no references to this object remain in the Active Directory, the row in the database is completely removed and there are no traces of the object left.

#### Stage 4: (External references still exist) phantom object

If there are any references to this object remain in the Active Directory, the object itself is deleted and a phantom object is created in its place until those references are removed. This phantom object is deleted when all references to the object are removed.

You can't view these phantom objects through any LDAP or ADSI interface.

> [!NOTE]
> During the removal of the global catalog from a domain controller, the read-only objects that are removed from the global catalog do not go through the deletion process. They are immediately removed from the database and any references to them are unaffected.

### Cross-domain references and the infrastructure master role

Certain types of groups in an active directory domain can contain accounts from trusted domains. To make sure that the names in the group's membership are accurate, the user object's GUID is referenced in the membership of the group. When Active Directory Tools displays these groups that have users from foreign domains, they must be able to display the accurate and current name of the foreign user without relying on immediate contact with a domain controller for the foreign domain or a global catalog.

Active Directory uses a phantom object for cross-domain group-to-user references on Domain Controllers that aren't Global Catalogs. This phantom object is a special kind of object that can't be viewed through any LDAP interface.

Phantom records contain a minimal amount of information to let a domain controller refer to the location in which the original object exists. The index of phantom objects contains the following information about the cross-referenced object:

- Distinguished name of the object
- Object GUID
- Object SID

During the addition of a member from a different domain to a local user group, the local domain controller that is performing the addition to the group creates the phantom object for the remote user.

If you change the foreign user's name or delete the foreign user, the phantoms must be updated or removed in the group's domain from every domain controller in the domain. The domain controller holding the infrastructure master (IM) role for the group's domain handles any updates to the phantom objects.

You can't view these phantom objects through any LDAP or ADSI interface.

#### Phantom update and cleanup processes

If the object to which a phantom object refers has been deleted, the phantom object must be removed from the local domain (cleaned up). A phantom object must also be updated if the name of the original object changes so that the group membership list for the group has an accurate listing. The domain controller holding the IM role in a domain handles both operations for its domain.

The IM compares the information about the phantom objects against the latest versions on a global catalog server and makes changes to the phantoms as needed. The interval can be customized by adding the Days per database phantom scan registry entry to the following registry subkey:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters`

To make this change, note the following:

- Registry entry: Days per database phantom scan
- Type: DWORD

- Default value: 2

- Function: Specifies the interval in days that the IM compares the phantom objects against the latest versions on a global catalog server.

> [!NOTE]
> The minimum DWORD value is 1 day.

After the IM determines that the original object that the phantom object refers to has changed or been deleted:

- The IM creates an infrastructureUpdate object in the CN=Infrastructure,DC=DomainName,DC=... container and immediately deletes it.
- This (tombstone) object is replicated by special proxy to the other domain controllers in the domain that aren't global catalog servers.

    If the original object is renamed, the value in the DNReferenceUpdate attribute of the infrastructureUpdate contains the new name. If the original object was deleted, the deleted objects DN is changed so that (esc)DEL:GUID is appended to the original DN.

- The domain controllers then take the information in the infrastructureUpdate objects and apply the changes to the local copies of their phantom objects accordingly.

If the original object has been deleted, the receiving domain controllers delete the local phantom object and remove the corresponding attribute that references it (such as the member attribute on a group).

> [!NOTE]
> Global catalog servers in the group's domain receive the special proxy replication for the objects in the CN=Infrastructure,DC=DomainName,DC=... container. However, they ignore them because a read-only copy of the object itself is already instantiated in the local database. So they do not need the phantom to track the group membership and will learn about the removal of the object with regular AD replication.

### Global catalog and infrastructure master role conflict

If the IM Flexible Single Master Operation (FSMO) role holder is also a global catalog server, the phantom indexes are never created or updated on that domain controller. (The FSMO is also known as the operations master.) This behavior occurs because a global catalog server contains a partial replica of every object in Active Directory. The IM does not store phantom versions of the foreign objects because it already has a partial replica of the object in the local global catalog.

For this process to work correctly in a multidomain environment, the infrastructure FSMO role holder can't be a global catalog server. Be aware that the first domain in the forest holds all five FSMO roles and is also a global catalog. Therefore, you must transfer either role to another computer as soon as another domain controller is installed in the domain if you plan to have multiple domains.

If the infrastructure FSMO role and global catalog role reside on the same domain controller, you continually receive event ID 1419 in the directory services event log.

There are two conditions where placing the Infrastructure Master role on a Global Catalog is OK:

1. All Domain Controllers in the Domain are Global Catalog. In this situation, there can't be any phantoms to clean up.
2. The Forest Mode is "Windows Server 2008 R2" and the Recycle Bin feature is activated. In this mode, removed object links aren't phantomized but set to a different state, and still present in the database.

For information on the AD Recycle Bin, see: [Scenario Overview for Restoring Deleted Active Directory Objects](https://technet.microsoft.com/library/dd379542%28ws.10%29.aspx)

For more information about FSMO role placement in the domain and how to transfer an FSMO role to another domain controller, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[223346](https://support.microsoft.com/help/223346) FSMO placement and optimization on Active Directory domain controllers  

[223787](https://support.microsoft.com/help/223787) Flexible Single Master Operation transfer and seizure process
