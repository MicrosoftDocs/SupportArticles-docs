---
title: Flexible Single-Master Operation (FSMO) placement and optimization on AD DCs
description: Certain operations are optimally done on a single domain controller. Describes how Active Directory FSMO roles are positioned in both the forest and the domain for these operations.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc, larryli
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# FSMO placement and optimization on Active Directory domain controllers

Certain operations are best done on a single domain controller. This article describes the placement of Active Directory Flexible Single-Master Operation (FSMO) roles in the domain and forest for these operations.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 223346

## More information

Certain domain and enterprise-wide operations aren't well suited to multi-master updates. In these situations, the operations must be done on a single domain controller in the domain or in the forest. Having a single-master owner defines a well-known target for critical operations, and prevents possible conflicts or latency created by multi-master updates. It means that the relevant FSMO role owner must be online, discoverable, and available on the network by computers that must perform FSMO-dependent operations.

When the Active Directory Installation Wizard (Dcpromo.exe) creates the first domain in a new forest, the wizard adds five FSMO roles. A forest with one domain has five roles. The Active Directory Installation Wizard adds three domain-wide roles on the first domain controller in each additional domain in the forest. Additionally, infrastructure master roles exist for each application partition. It includes the default domain and the forest-wide DNS application partitions that are created on Windows Server 2003 and later domain controllers. The operations masters and their scope are shown in the following table.

|FSMO Role|Scope|Function and availability requirements|
|---|---|---|
|Schema Master|Enterprise|- Used to introduce manual and programmatic schema updates. It includes those updates that are added by Windows `ADPREP /FORESTPREP`, by Microsoft Exchange, and by other applications that use Active Directory Domain Services (AD DS).<br/>- Must be online when schema updates are performed.<br/>|
|Domain Naming Master|Enterprise|- Used to add and to remove domains and application partitions to and from the forest.<br/>- Must be online when domains and application partitions in a forest are added or removed.|
|Primary Domain Controller|Domain|- Receives password updates when passwords are changed for the computer and for user accounts that are on replica domain controllers.<br/>- Consulted by replica domain controllers that service authentication requests that have mismatched passwords.<br/>- Default target domain controller for Group Policy updates.<br/>- Target domain controller for legacy applications that perform writable operations and for some admin tools.<br/>- Must be online and accessible 24 hours a day, seven days a week.|
|RID|Domain|- Allocates active and standby RID pools to replica domain controllers in the same domain.<br/>- Must be online in the following situations: <ul><li>when newly promoted domain controllers must obtain a local RID pool that's required to advertise</li><li>when existing domain controllers must update their current or standby RID pool allocation.</li></ul>|
|Infrastructure Master|Domain<br/><br/>Application partition|- Updates cross-domain references and phantoms from the global catalog. For more information, see [Phantoms, tombstones, and the infrastructure master](https://support.microsoft.com/help/248047)<br/>- A separate infrastructure master is created for each application partition, including the default forest-wide and domain-wide application partitions created by Windows Server 2003 and later domain controllers.<br/><br/>The Windows Server 2008 R2 `ADPREP /RODCPREP` command targets the infrastructure master role for default DNS application in the forest root domain. The DN path for this role holder is: <ul><li>CN=Infrastructure,DC=DomainDnsZones,DC=\<forest root domain>,DC=\<top level domain></li><li>CN=Infrastructure,DC=ForestDnsZones,DC=\<forest root domain>,DC=\<top level domain></li></ul>|
  
## FSMO availability and placement

The Active Directory Installation Wizard does the initial placement of roles on domain controllers. This placement is frequently correct for directories that have just a few domain controllers. In a directory that has many domain controllers, the default placement may not be the best match for your network.

Consider the following factors in your selection criteria:

- It's easier to keep track of FSMO roles if you host them on fewer computers.
- Place roles on domain controllers that can be accessed by the computers, which need access to a given role, especially on networks that aren't fully routed. For example, to obtain a current or standby RID pool, or perform pass-through authentication, all DCs need network access to the RID and PDC role holders in their respective domains.
- You should transfer (not seize) the role to the new domain controller under the following conditions:

  - a role must be moved to a different domain controller
  - the current role holder is online and available

  FSMO roles should only be seized if the current role holder isn't available. For more information, see [Managing Operations Master Roles](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc816945(v=ws.10)).
- FSMO roles assigned to domain controllers that are offline or in an error state only have to be transferred or seized if role-dependent operations are being done. If the role holder can be made operational before the role is needed, you may delay seizing the role. If role availability is critical, transfer or seize the role as required. The PDC role in each domain should always be online.
- Select a direct intrasite replication partner for existing role holders to act as a standby role holder. If the primary owner goes offline or fails, transfer or seize the role to the designated standby FSMO domain controller as required.

## General recommendations for FSMO placement

- Place the schema master on the PDC of the forest root domain.
- Place the domain naming master on the forest root PDC.

  The addition or removal of domains should be a tightly controlled operation. Place this role on the forest root PDC. Certain operations that use the domain naming master fail if the domain naming master isn't available. These operations include creating or removing domains and application partitions. On a domain controller that runs Microsoft Windows 2000, the domain naming master must also be hosted on a global catalog server. On domain controllers that run Windows Server 2003 or later versions, the domain naming master doesn't have to be a global catalog server.

- Place the PDC on your best hardware in a reliable hub site that contains replica domain controllers in the same Active Directory site and domain.

  In large or busy environments, the PDC frequently has the highest CPU usage, because it handles pass-through authentication and password updates. If high CPU usage becomes a problem, identify the source. The source includes applications or computers that may be performing too many operations (transitively) targeting the PDC. Techniques to reduce CPU include:

  - Adding more or faster CPUs
  - Adding more replicas
  - Adding more memory to cache Active Directory objects
  - Removing the global catalog to avoid global catalog lookups
  - Reducing the number of incoming and outgoing replication partners
  - Increasing the replication schedule
  - Reducing authentication visibility by using LDAPSRVWEIGHT and LDAPPRIORITY, and by using the Randomize1CList feature.
  
  All domain controllers in a particular domain, and computers that run applications and admin tools that target the PDC, must have network connectivity to the domain PDC.

- Place the RID master on the domain PDC in the same domain.

  RID master overhead is light, especially in mature domains that have already created the bulk of their users, computers, and groups. The domain PDC typically receives the most attention from administrators. Co-locating this role on the PDC helps ensure reliable availability. Make sure that existing domain controllers and newly promoted domain controllers have network connectivity to obtain active and standby RID pools from the RID master, especially the domain controllers promoted in remote or staging sites.

- Legacy guidance suggests placing the infrastructure master on a non-global catalog server. There are two rules to consider:
  - Single domain forest:

    In a forest that contains a single Active Directory domain, there are no phantoms. So, the infrastructure master has no work to do. The infrastructure master may be placed on any domain controller in the domain, whether that domain controller hosts the global catalog or not.

  - Multidomain forest:

    If every domain controller in a domain that's part of a multi-domain forest also hosts the global catalog, there are no phantoms or work for the infrastructure master to do. The infrastructure master may be put on any domain controller in that domain. Practically, most administrators host the global catalog on every domain controller in the forest.

  - If every domain controller in a given domain that's located in a multi-domain forest doesn't host the global catalog, the infrastructure master must be placed on a domain controller that doesn't host the global catalog.

## References

For more information, see [How to use Windows Server cluster nodes as domain controllers](https://support.microsoft.com/help/281662).

Articles about Operations Master roles:

- [Phantoms, tombstones, and the infrastructure master](phantoms-tombstones-infrastructure-master.md)
- [Error when you run the `Adprep /rodcprep` command in Windows Server 2008](error-run-adprep-rodcprep-command.md)

The NTDS Replication event 1586 occurs in one of the following situations:

- the PDC FSMO role for a particular domain has been seized.
- the PDC FSMO role for a particular domain has been transferred to a new domain controller that wasn't a direct replication partner of the previous role holder.
