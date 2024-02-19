---
title: Troubleshoot missing SYSVOL and NETLOGON shares on Windows domain controllers
description: Describes troubleshooting steps to use on Windows 2000 domain controllers that are missing netlogon and sysvol shares.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, arrenc
ms.custom: sap:sysvol-access-or-replication-issues, csstroubleshoot
---
# Troubleshoot missing SYSVOL and NETLOGON shares on Windows domain controllers

This article describes troubleshooting steps to use on Windows 2000 domain controllers that are missing netlogon and sysvol shares.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 257338

> [!NOTE]
> This article applies to Windows 2000. Support for Windows 2000 ends on July 13, 2010. The Windows 2000 End-of-Support Solution Center is a starting point for planning your migration strategy from Windows 2000. For more information, see the [Microsoft Support Lifecycle Policy](/lifecycle/).

## Summary

The File Replication Service (FRS) is a multi-threaded, multi-master replication engine that replaces the LMREPL service in Windows NT 3.x and 4.0. Windows 2000 domain controllers and servers use FRS to replicate system policy and login scripts for Windows 2000 and down-level clients.

FRS can also replicate content between Windows 2000 servers hosting the same fault-tolerant DFS roots or child node replicas.

## More information

Missing netlogon and sysvol shares typically occur on replica domain controllers in an existing domain, but may also occur on the first domain controller in a new domain. The following steps are directed more at the replica domain controller scenario, but can be applied to the first domain controller in the domain by ignoring the replication-specific steps.

1. NTDS Connection objects exist in the DS of each replication partner.

    NTDS Connections are one-way connections that are used by the Directory Service to replicate the Active Directory, and the File Replication Service (FRS) to replicate the file system portion of system policy in the SYSVOL folder. The Knowledge Consistency Checker (KCC) is responsible for building NTDS connection objects to form a well-connected topology between domain controllers in the domain and forest. In lieu of automatic connections, administrators may also create manual connection objects.

    Use the "Sites and Services" (Dssite.msc) snap-in to examine the connection objects that exist between the problem computer and existing domain controllers. For replication to occur between computer \\\\M1 and \\\\M2, \\\\M1 should have an inbound connection object from \\\\M2, and \\\\M2 an inbound connection object from \\\\M1. Use the "Connect to Domain Controller..." command in Dssite.msc to view and compare each domain controllers perspective of the intra-domain connection objects.

    If no connection objects exist for the new replica member, use the **Check Replication Topology** command in Dssite.msc to force KCC to build the necessary automatic connection objects (press F5 to refresh the view afterwards).

    If KCC is unable to build automatic connections, administrators should intervene by building manual connection objects for domain controllers that have no inbound or outbound connections to or from other domain controllers in the domain. Often, building a single working manual connection object permits KCC to build the desired automatic connection objects. Duplicate manual and/or automatic connections from the same domain controller in the domain should be deleted to avoid a replication-blocking configuration.

2. Active Directory replication is taking place between the new and existing domain controllers in the domain.

    Use Repadmin.exe to confirm Active Directory replication is taking place between the source and destination domain controllers in the same domain in the scheduled replication interval. Default replication intervals are five minutes between domain controllers in the same site, and once every three hours between domain controllers in different sites (minimum 15 minutes).

    ```console
    REPADMIN /SHOWREPS %UPSTREAMCOMPUTER%
    REPADMIN /SHOWREPS %DOWNSTREAMCOMPUTER%
    ```

    FRS replication is dependent on the Active Directory to replicate the necessary configuration information between domain controllers in the domain. If replication is suspect, examine replication events in Event Viewer after setting the "replication events" entry in `HKEY_LOCAL_MACHINE\system\ccs\services\ntds\diagnostics\` to 5 on potential source computers (\\\\M1) and the destination computer (\\\\M2), then forcing replication from \\\\M1 to \\\\M2 and \\\\M2 to \\\\M1 using the "replicate now" command in Dssite.msc or its equivalent in REPLMON.

3. The server used to source the Active Directory and SYSVOL folder should have created NETLOGON and SYSVOL shares itself.

    After the Dcpromo.exe program has restarted the computer, FRS first attempts to source the SYSVOL from the computer identified in the "Replica Set Parent" registry key under:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTFRS\Parameters\SysVol\DomainName`

    > [!NOTE]
    > This key is temporary and is deleted once SYSVOL is sourced, or the information under SYSVOL has been successfully replicated.

    The 2195 release of Ntfrs.exe prevents replication from this initial source server, delaying SYSVOL replication until FRS can attempt replication from an inbound replication partner in the domain over an automatic or manual NTDS connection object.

    All potential source domain controllers in the domain should themselves have shared the NETLOGON and SYSVOL shares and applied default domain and domain controllers policy.

    SYSVOL directory structure:

    - domain
      - DO_NOT_REMOVE_NtFrs_PreInstall_Directory
      - Policies
        - {GUID}
          - Adm
          - MACHINE
          - USER
        - {GUID}
          - Adm
          - MACHINE
          - USER
        - {etc.,}
      - scripts
    - staging
    - staging areas
      - `MyDomainName.com`
    - scripts
    - sysvol(sysvol share)
      - `MyDomainName.com`
        - DO_NOT_REMOVE_NtFrs_PreInstall_Directory
        - Policies
          - {GUID}
            - Adm
            - MACHINE
            - USER
          - {GUID}
            - Adm
            - MACHINE
            - USER
          - {etc.,}
        - scripts(NETLOGON share)

4. The "Enterprise Domain Controllers" group should be granted the "access this computer from network" right in the default domain controllers policy on the domain controllers OU.

    Replication of the Active Directory during the use of the Dcpromo.exe program uses the credentials that are specified in the Active Directory Installation Wizard. Upon restart, replication occurs in the context of the domain controller's computer account. All source domain controllers in the domain must successfully replicate and apply the policy granting the "Enterprise Domain Controllers" group "Access this computer from network" right. For quick verification, look for event `1704s` in the application log of potential source domain controllers. For detailed verification, run security configuration analysis against the Basicdc.inf template (requires defining environment variables for SYSVOL, DSLOG, and DSIT, and examine the resulting log output.

    The "access this computer from network" right is often missing on Windows NT 4.0 domains that are upgraded to Windows 2000. This issue causes active directory and FRS replication to be unsuccessful with "access denied" error messages.

5. Each domain controller must be able to resolve (ping) the fully qualified computer names (%computer name%.\<domain name>) of computers participating in the replica set.

    For SYSVOL, this step means pinging the FQ computer name of all domain controllers in the domain. Confirm the address returned by the ping command matches the IP address returned by IPCONFIG at the console of each replica set partner.

6. The FRS service must have created an NTFRS jet database.

    Run `DIR \\<computername>\admin$\ntfrs\jet` against each domain controller in the domain to confirm the presence of the NTfrs.jdb file. The date and size of the jet database may be incorrect while the NTFRS service is running (by design).

7. Each domain controller must be a member of the SYSVOL replica set.

    Run `NTFRSUTL DS [COMPUTERNAME]` on all replica set members. Confirm that all domain controllers in the domain show up under the "SET: DOMAIN SYSTEMVOLUME (SYSVOL SHARE)" portion of the NTFRSUTL output. The SYSVOL Replica set and its members can also be displayed under cn="domain system volume",cn=file replication service,cn=system,dc=\<FQDN> in the User and Computers (Dsa.msc) snap-in when "Advanced Features" is enabled under the **View** menu.

8. Each domain controller must be a subscriber of the replica set.

    Run `NTFRSUTL DS [COMPUTERNAME]` on all replica set members. Subscriber object appears in cn=domain system volume (SYSVOL share),cn=NTFRS Subscriptions,CN=%DCNAME%,OU=Domain Controllers,DC=\<FQDN>. Running this command requires that the machine object exists and has replicated in. NTFRSUTL reports the following when the subscriber object is missing:

    ```output
    SUBSCRIPTION: NTFRS SUBSCRIPTIONS DN: cn=ntfrs  
    subscriptions,cn=W2KPDC,ou=domain controllers,dc=d... Guid:  
    5c44b60b-8f01-48c6-8604c630a695dcdd  
    Working: f:\winnt\ntfrs  
    Actual Working: f:\winnt\ntfrs  
    WIN2K-PDC IS NOT A MEMBER OF A REPLICA SET!
    ```

9. The Replication Schedule must be enabled.

10. The logical drive hosting the SYSVOL share and staging folder has plenty of available disk space on upstream and downstream partners. For example, 50 percent of the amount of content you're trying to replicate and three times the largest file size being replicated.

11. Check the destination folder and the staging folder (displayed in "NTFRSUTL DS") of the new replica to see if files are replicating. Files in the staging folder should be in the process of being moved to the final location. That the number of files in the staging or destination folder is constantly changing is a good sign as either files are being replicated in, or transitioned to the destination folder.

> [!NOTE]
> Ntfrsutl.exe is a utility included in the Windows 2000 Resource Kit.
