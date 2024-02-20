---
title: Active Directory replication error 8452
description: Active Directory Replications test has failed with error status code (8452). Provides a resolution.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# The naming context is in the process of being removed or is not replicated from the specified server

This article provides a resolution to solve the Active Directory replication error (8452). This article is only intended for technical support agents and IT professionals. If you're a home user and looking for help with a problem, visit [ask the Microsoft Community](https://answers.microsoft.com).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2023704

## Symptoms

1. DCDIAG reports that Active Directory Replications test has failed with error status code (8452): **The naming context is in the process of being removed or is not replicated from the specified server**.

    > Testing server: \<site name>\<destination dc name>  
    > Starting test: Replications  
    > Replications Check  
    > [Replications Check,\<destination DC name>] A recent replication attempt failed:  
    > From \<source DC> to \<destination DC>  
    > Naming Context: \<directory partition DN path>  
    > The replication generated an error (8452):  
    > The naming context is in the process of being removed or is not replicated from the specified server.  
    > The failure occurred at \<date> \<time>.  
    > The last success occurred at \<date> \<time>.  
    > 3 failures have occurred since the last success.

2. REPADMIN.EXE reports that the last replication attempt has failed with status 8452.

    `REPADMIN` commands that commonly cite the five statuses include but aren't limited to:

    - `REPADMIN /SHOWREPS`
    - `REPADMIN /REPLSUM`
    - `REPADMIN /SYNCALL`

    Sample output from `REPADMIN /SHOWREPS` depicting inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the **replication access was denied** error is shown below:

   ```console
    Default-First-Site-Name\CONTOSO-DC1  
     DSA Options: IS_GC  
     Site Options: (none)  
     DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01  
     DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01

    ==== INBOUND NEIGHBORS ======================================

    DC=contoso,DC=com  
    Default-First-Site-Name\CONTOSO-DC2 via RPC  
    DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2  
    Last attempt @ <date> <time> failed, result 8452 (0x2104):  
    The naming context is in the process of being removed or is not replicated from the specified server.  
    <#> consecutive failure(s).  
    Last success @ <date> <time>.
   ```

3. The **replicate now** command in Active Directory Sites and Services returns the following error:

   > The naming context is in the process of being removed or is not replicated from the specified server.

    Right-clicking on the connection object from a source DC and choosing **replicate now** fails with the above error. The on-screen error message text is shown below:  

    > Dialog title text: Replicate Now
    Dialog message text: The following error occurred during the attempt to synchronize naming context <%directory partition name%> from Domain Controller \<Source DC> to Domain Controller \<Destination DC>:
    The naming context is in the process of being removed or is not replicated from the specified server.
    >
    > The operation will not continue  
    Buttons in Dialog: OK

4. NTDS KCC, NTDS General, or Microsoft-Windows-ActiveDirectory_DomainService events with the five statuses are logged in the directory service event log.

    Active Directory events that commonly cite the 8524 status include but aren't limited to:

    |Event|Source|Event String|
    |---|---|---|
    |NTDS General|1586|The checkpoint with the PDC was unsuccessful. The checkpointing process will be retried again in four hours. A full synchronization of the security database to downlevel domain controllers may take place if this machine is promoted to be the PDC before the next successful checkpoint. The error returned was: The naming context is in the process of being removed or is not replicated from the specified server.|

## Cause

This error most commonly occurs when the following replication topologies are different:

- The replication topology in a DC that's starting replication.
- The replication topology that's defined in the destination DC's copy of Active Directory.

The error naturally occurs when the replication topology in an Active Directory forest is being modified by:

- New partitions being added or removed from the forest. For example, the promotion or demotion of the first/last DC in a domain. Or the addition/removal of an application partition including default DNS application partitions.
- The addition or removal of directory partitions on existing DCs (that is, the promotion/demotion of global catalog or addition/removal of an application partition).
- Changes in replication topology or settings:

  - The promotion of new DCs
  - The demotion of existing DCs
  - Changes to preferred/nominated bridgeheads
  - The building of alternate replication paths in response to replication failures or offline DCs
  - Site and site link changes.

The error can be transient in a forest undergoing the above changes. It remains transient until the set of source DCs and partitions which each destination DC replicates from has inbound replicated by triggering replication operations.

The error can be persistent when replication failures prevent the end-to-end replication of topology changes in the forest.

The error is most commonly seen in replication scenarios triggered by REPADMIN.EXE remotely (especially `/SYNCALL`) or the replicate now command in DSSITE.MSC where the copy of Active Directory on the DC triggering replication has a different list of source DCs that a destination DC replicates from partitions than what the destination DC has defined in its copy of Active Directory.

Windows 2000 domain controllers are particularly prone to this error during GC demotion as they're slow to remove objects from read-only partitions. Object removal during GC demotion improved dramatically on Windows Server 2003 and later OS versions.

The NTDS Replication event 1586 occurs in the following situation:

&nbsp;&nbsp;&nbsp;The primary domain controller (PDC) Flexible Single Master Operation (FSMO) role for the domain has been seized or transferred to a domain controller that wasn't a direct replication partner of the previous role holder.

In rare conditions, the error can be caused by corruption in attributes like `hasMasterNCs` or `msds-hasMasterNCs`.

The [More information](#more-information) section of this article contains explanations as to why the diagnostic and administrative tools listed in the [Symptoms](#symptoms) section of this article generate the 8452 error.

In summary, Error 8452 happens if any of the following conditions is true:

1. When DC1 <- DC2 replication is started for a Naming Context (NC), on DC1 there's no replica link for the NC from DC2.
2. When DC1 <- DC2 replication in started for an NC, the NC is in the process of being removed on DC2.
3. In mixed domain environment, the PDC FSMO role is transferred from DC2 to DC1, but on DC1 there's no replica link from DC2.

## Resolution

1. Wait. As mentioned, this condition is transient and doesn't normally warrant troubleshooting.

    Assume that replication topology changes of the type listed in the [Cause](#cause) section are taking place in your Active Directory forest. In this situation, wait for the error condition to correct itself with time.  

2. Avoid the use of the `repadmin /syncall` command and equivalents until domain controllers starting replication and the destination DCs being replicated to agree source DCs and directory partitions being replicated.

3. Make originating changes in the right places.
4. Push and Pull changes connection object and partition changes around as required.
5. Go Direct.

    If the **replicate now** command from \\DC3 to \\DC2 when the DSSITE.MSC snap-in is run from the console of \\DC1 but focused on \\DC4, cut out the middle men.

    If the error is caused by root cause no. 3, then after the user gives the correct input, the error won't happen. For example, in case no. 1 of scenario no. 3, if the user input a correct \<src DC> such that on \<dest DC> there's a replica link from \<src DC> for \<the NC>, the `repadmin /replicate` command will be executed successfully.

6. Resolve replication failures blocking end-to-end replication.
7. REPADMIN /REPLICATE.
8. NTDS Replication event 1586.

    For NTDS Replication event 1586, transfer the DPC role to an Active Directory domain controller that currently a direct replication partner of the previous domain PDC.

## More information

### `repadmin /syncall`

The `repadmin /syncall` operation will cause a DC to start replication from all of its source replication partners and make the source replication partners start replication from all of their source replication partners, and so on.

For example, suppose we have a replication topology DC1 <- DC2 <- DC3. `repadmin /syncall` on DC1 will start the following replication: DC2 <- DC3, and DC1 <- DC2.

There are two cases where error 8452 might be observed in this scenario:

Case 1: Change the replication topology to make DC2 inbound replicate from DC4 so that the current topology becomes DC1 <- DC2 <- DC4.

If we call `repadmin /syncall` on DC1 before knowledge of the DC2 <- DC4 topology change inbound replicates to DC1, the `syncall` operation will start DC2 <- DC3 replications because DC1 still has the old replication topology stored locally. On DC2 at this moment, KCC has created a replica link from DC4 and has deleted the replica link from DC3. So the replication from DC2 <- DC3 can't be executed and the operation logs error 8452.

Case 2: Suppose an NC on DC3 is being removing while we call `repadmin /syncall <the NC>` on DC1. DC2 <- DC3 replication will be started as before. Because the NC on DC3 is in the process of being removed, it isn't a valid replication source, the error 8452 will be observed.

### Active Directory sites and services (DSSITE.MSC) -> replicate now

The Active Directory Sites and Services snap-in, DSSITE.MSC uses the topology information stored in its local copy of AD.

Given the replication topology DC1 <- DC2 <- DC3, a connection object exists under DC2's NTDS Settings object. This connection object represents the route for DC2 to inbound replicate an NC (or multiple NCs) from DC3. If we right-click on this connection object and select **replicate now**, we will start a DC2 <- DC3 replication on DC2.

As in the `REPAMIN /SYNCALL` example, there are also two cases where we might observe error 8452.

Case 1: Suppose we change the replication topology on DC2 to make it inbound replicate from DC4. The new replication topology is DC1 <- DC2 <- DC4. Until knowledge of this topology change outbound replicates to DC1, the topology on DC1 is still the old topology of DC1 <- DC2 <- DC3.

Starting the Active Directory Sites and Services UI focused on DC1s copy of Active Directory still shows that DC2 has an inbound connection object from source DC3. Right-clicking on DCs inbound connection object from DC2 and choosing **replicate now** will start a DC2 <- DC3 replication on DC2. However, the KCC on DC2 already removed the replica link inbound replicating to DC2 from DC3 and created a replica link to DC2. Because the replication attempt DC2 <-> DC2 can't be executed, the request fails error 8452.

Case 2: Suppose we're removing an NC on DC3 when we right-click the connection object, and select **replicate now** on DC1 to start DC2 <- DC3 replication for this NC. Because the NC on DC3 is in the process of being removed, DC3 isn't a valid replication source. So we'll see error 8452.

### `repadmin /replicate` or `repadmin /sync`

The `replicate` (or `sync`) command of `repadmin` triggers immediate replication of a naming context (directory partition) to a destination DC from a source DC. Its (simplified) syntax is: `repadmin /replicate <dest DC> <src DC> <replicated NC>`.

There are two cases that we'll trigger error 8452 when the `repadmin /replicate` (or `sync`) command is used to start a replication:

Case 1: the \<src DC> parameter isn't a replication partner of \<dest DC> for \<replicated NC>. For example, we have to replication topology DC1 <- DC2 <- DC3 in which DC2 syncs an NC from DC3. If we call `repadmin /replicate` DC2 DC1 the NC, a replication DC2 <- DC1 will be started. Because on DC2 we don't have a replica link from DC1 for the NC, this replication can't be executed, and we'll get error 8452.

Case 2: the NC is being removed on src DC when we call `repadmin /replicate <dest DC> <src DC> <the NC>`, so \<src DC> isn't a valid replication source. So we'll see error 8452.

### DCDIAG

The `showrepl` (or `showreps`) command of `repadmin` reports the replication status for each source DC from which the destination DC has an inbound connection object. The replications test of dcdiag checks for timely replication between DCs. If error 8452 is in `repadmin /showrepl` or `dcdiag /test:replications` report, the reason is that the replicated NC is being removed on the source DC when the last replication happened.

### NTDS replication event 1586

NTDS replication event 1586 is generated in a mixed domain environment that contains both Windows NT 4.0 and Active Directory DCs. In this mixed domain environment, Active Directory domain controllers replicate among themselves using the DS replication protocol, while the Active Directory PDC replicates to NT4 BDCs using the legacy `netlogon` replication protocol. In this case, the Active Directory PDC FSMO role holder is the single point for replication to NT4 BDCs in a common domain. The PDC maintains a checkpoint for each BDC representing the most recent replicated change. If the PDC FSMO role is transferred to another Active Directory DC in the domain, the information about each individual BDC's checkpoint must be replicated to the new PDC FSMO role. So, the new PDC FSMO role holder must have a direct replication relationship with the old PDC FSMO role holder. If the new PDC doesn't replicate directly with the old PDC (that is, on the new PDC there's no replica link from old PDC), then we'll see error 8452 in event 1586.

### Demotion

There's another scenario that **DRAERR_NoReplica** error will be returned. When we demote a DC, it will use DC locator to find a DC to replicate local changes to. If the found DC doesn't replicate directly with the being-deleted DC, **DRAERR_NoReplica** will be returned and DC locator will be called to find a destination DC. In this scenario, the error isn't logged so it isn't observed.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## Related Links

- [How the Active Directory Replication Model Works](/previous-versions/windows/it-pro/windows-server-2003/cc772726(v=ws.10))
- [RepsFrom](/openspecs/windows_protocols/ms-drsr/3ef27d3c-b9c9-4404-8e53-ebf3a64a9a10)
