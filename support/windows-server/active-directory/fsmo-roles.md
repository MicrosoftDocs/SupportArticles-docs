---
title: Active Directory Flexible Single Master Operation (FSMO) roles in Windows
description: This article talks about the Active Directory FSMO roles in Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-fsmo, csstroubleshoot
---
# Active Directory FSMO roles in Windows

This article mainly helps you to learn about the Flexible Single Master Operation (FSMO) roles in Active Directory.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2016, Windows Server 2019, Windows Server 2022  
_Original KB number:_ &nbsp; 197132

## Summary

Active Directory is the central repository in which all objects in an enterprise and their respective attributes are stored. It's a hierarchical, multi-master enabled database that can store millions of objects. Changes to the database can be processed at any given domain controller (DC) in the enterprise, regardless of whether the DC is connected or disconnected from the network.

## Multi-master model

A multi-master enabled database, such as the Active Directory, provides the flexibility of allowing changes to occur at any DC in the enterprise. But it also introduces the possibility of conflicts that can potentially lead to problems once the data is replicated to the rest of the enterprise. One way Windows deals with conflicting updates is by having a conflict resolution algorithm handle discrepancies in values. It's done by resolving to the DC to which changes were written last, which is the **last writer wins**. The changes in all other DCs are discarded. Although this method may be acceptable in some cases, there are times when conflicts are too difficult to resolve using the **last writer wins** approach. In such cases, it's best to prevent the conflict from occurring rather than to try to resolve it after the fact.

For certain types of changes, Windows incorporates methods to prevent conflicting Active Directory updates from occurring.

## Single-master model

To prevent conflicting updates in Windows, the Active Directory performs updates to certain objects in a single-master fashion. In a single-master model, only one DC in the entire directory is allowed to process updates. It's similar to the role given to a primary domain controller (PDC) in earlier versions of Windows, such as Microsoft Windows NT 3.51 and 4.0. In earlier versions of Windows, the PDC is responsible for processing all updates in a given domain.

Active Directory extends the single-master model found in earlier versions of Windows to include multiple roles, and the ability to transfer roles to any DC in the enterprise. Because an Active Directory role isn't bound to a single DC, it's referred to as an FSMO role. Currently in Windows there are five FSMO roles:

- Schema master
- Domain naming master
- RID master
- PDC emulator
- Infrastructure master

Typically, an FSMO role ownership is executed only when the domain controller has replicated the naming context (NC) where the ownership is stored since the Directory Service started. Make sure that an FSMO role seizure reaches the previous owner before the role is used.

### Schema master FSMO role

The schema master FSMO role holder is the DC responsible for performing updates to the directory schema, that is, the schema naming context or LDAP://cn=schema,cn=configuration,dc=\<domain>. This DC is the only one that can process updates to the directory schema. Once the Schema update is complete, it's replicated from the schema master to all other DCs in the directory. There's only one schema master per forest.

#### Initial replication and connectivity requirements

- This FSMO role holder is only active when the role owner has inbound replicated the schema NC successfully since the Directory Service started.
- DCs and members of the forest only contact the FSMO role when they update the schema.

### Domain naming master FSMO role

The domain naming master FSMO role holder is the DC responsible for making changes to the forest-wide domain name space of the directory, that is, the Partitions\Configuration naming context or LDAP://CN=Partitions, CN=Configuration, DC=\<domain>. This DC is the only one that can add or remove a domain from the directory. It can also add or remove cross references to domains in external directories.

#### Initial replication and connectivity requirements

- This FSMO role holder is only active when the role owner has inbound replicated the configuration NC successfully since the Directory Service started.
- Domain members of the forest only contact the FSMO role holder when they update the cross-references. DCs contact the FSMO role holder when:

  - Domains are added or removed in the forest.
  - New instances of application directory partitions on DCs are added. For example, a DNS server has been enlisted for the default DNS application directory partitions.

### RID master FSMO role

The RID master FSMO role holder is the single DC responsible for processing RID Pool requests from all DCs within a given domain. It's also responsible for removing an object from its domain and putting it in another domain during an object move.

When a DC creates a security principal object, such as a user or group, it attaches a unique Security ID (SID) to the object. This SID consists of:

- A domain SID that's the same for all SIDs created in a domain.
- A relative ID (RID) that's unique for each security principal SID created in a domain.

Each Windows DC in a domain is allocated a pool of RIDs that it's allowed to assign to the security principals it creates. When a DC's allocated RID pool falls below a threshold, that DC issues a request for additional RIDs to the domain's RID master. The domain RID master responds to the request by retrieving RIDs from the domain's unallocated RID pool, and assigns them to the pool of the requesting DC. There's one RID master per domain in a directory.

#### Initial replication and connectivity requirements

- This FSMO role holder is active only when the role owner has inbound replicated the domain NC successfully since the Directory Service started.
- DCs contact the FSMO role holder when they retrieve a new RID pool. The new RID pool is delivered to DCs through AD replication.

### PDC emulator FSMO role

The PDC emulator is necessary to synchronize time in an enterprise. Windows includes the W32Time (Windows Time) time service that is required by the Kerberos authentication protocol. All Windows-based computers within an enterprise use a common time. The purpose of the time service is to ensure that the Windows Time service uses a hierarchical relationship that controls authority. It doesn't permit loops to ensure appropriate common time usage.

The PDC emulator of a domain is authoritative for the domain. The PDC emulator at the root of the forest becomes authoritative for the enterprise, and should be configured to gather the time from an external source. All PDC FSMO role holders follow the hierarchy of domains in the selection of their in-bound time partner.

In a Windows domain, the PDC emulator role holder retains the following functions:

- Password changes done by other DCs in the domain are replicated preferentially to the PDC emulator.
- When authentication failures occur at a given DC because of an incorrect password, the failures are forwarded to the PDC emulator before a bad password failure message is reported to the user.
- Account lockout is processed on the PDC emulator.
- The PDC emulator performs all of the functionality that a Windows NT 4.0 Server-based PDC or earlier PDC performs for Windows NT 4.0-based or earlier clients.

This part of the PDC emulator role becomes unnecessary under the following situation:  
All workstations, member servers, and domain controllers (DCs) that are running Windows NT 4.0 or earlier are all upgraded to Windows 2000.

The PDC emulator still does the other functions as described in a Windows 2000 environment.

The following information describes the changes that occur during the upgrade process:

- Windows clients (workstations and member servers) and down-level clients that have installed the distributed services client package don't perform directory writes (such as password changes) preferentially at the DC that has advertised itself as the PDC. They use any DC for the domain.
- Once backup domain controllers (BDCs) in down-level domains are upgraded to Windows 2000, the PDC emulator receives no down-level replica requests.
- Windows clients (workstations and member servers) and down-level clients that have installed the distributed services client package use the Active Directory to locate network resources. They don't require the Windows NT Browser service.

#### Initial replication and connectivity requirements

- This FSMO role holder is always active when the PDC emulator finds the fSMORoleOwner attribute of the domain NC head points to itself. There is no inbound replication requirement.
- DCs contact the FSMO role holder when they have a new password, or the local password verification fails. No error occurs when the PDC emulator can't be reached or the `AvoidPdcOnWan` registry value is set to **1**.
- You can use the following cmdlet to run the prerequisites for demoting a DC.

    ```powershell
    PS C:\Users\Capecodadmin> Test-ADDSDomainControllerUninstallation -DemoteOperationMasterRole |fl
    ```

    Here is an output example when the PDC emulator can't be reached.
    > Message        : Verification of prerequisites for Domain Controller promotion failed. You indicated that this Active Directory domain controller is not the last domain controller for the domain "contoso.com". However, no other domain controller for that domain can be contacted.  Proceeding will cause any Active Directory Domain Services changes that have been made on this domain controller to be lost. To proceed anyway, specify the 'IgnoreLastDCInDomainMismatch' option.  
    > Context        : Test.VerifyDcPromoCore.DCPromo.General.50  
    > RebootRequired : False  
    > Status         : Error  

### Infrastructure master FSMO role

When an object in one domain is referenced by another object in another domain, it represents the reference by:

- The GUID
- The SID (for references to security principals)
- The DN of the object being referenced

The infrastructure FSMO role holder is the DC responsible for updating an object's SID and distinguished name in a cross-domain object reference.

> [!NOTE]
> The Infrastructure Master (IM) role should be held by a DC that is not a Global Catalog server(GC). If the Infrastructure Master runs on a Global Catalog server it will stop updating object information because it does not contain any references to objects that it does not hold. This is because a Global Catalog server holds a partial replica of every object in the forest. As a result, cross-domain object references in that domain will not be updated and a warning to that effect will be logged on that DC's event log.

If all the DCs in a domain also host the global catalog, all the DCs have the current data. It isn't important which DC holds the infrastructure master role.

When the Recycle Bin optional feature is enabled, every DC is responsible to update its cross-domain object references when the referenced object is moved, renamed, or deleted. In this case, there are no tasks associated with the Infrastructure FSMO role. And it isn't important which domain controller owns the Infrastructure Master role. For more information, see [6.1.5.5 Infrastructure FSMO Role](/openspecs/windows_protocols/ms-adts/f2d2513a-dbce-43f7-be7a-0be5d25877af).

#### Initial replication and connectivity requirements

- This FSMO role holder is active only when the role owner has inbound replicated the domain NC successfully since the Directory Service started.
- There is no connectivity requirement for this FSMO role holder. It is a forest internal cleanup functionality.
