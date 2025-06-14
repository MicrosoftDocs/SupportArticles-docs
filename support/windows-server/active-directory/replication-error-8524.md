---
title: Active Directory Replication fails with Win32 error 8524
description: Describes an issue that Active Directory Replications fail with Win32 error 8524 (The DSA operation is unable to proceed because of a DNS lookup failure).
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# Active Directory Replication Error 8524: The DSA operation is unable to proceed because of a DNS lookup failure

This article describes symptoms, cause, and resolution steps for AD operations that fail with Win32 error 8524:

> The DSA operation is unable to proceed because of a DNS lookup failure.
> 
> Applies to:   All supported versions of Windows Server

_Original KB number:_ &nbsp; 2021446

**Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).

## Symptoms

1. DCDIAG reports that Active Directory Replications test has failed with status 8524:

    > Testing server: \<sitename>\<destination DC>  
    Starting test: Replications  
    [Replications Check,\<destination DC>] A recent replication attempt failed:
    From \<source DC> to \<destination DC>  
    Naming Context:  
    CN=\<DN path for failing directory partition>,DC=Contoso,DC=Com  
    The replication generated an error (8524):  
    The DSA operation is unable to proceed because of a DNS lookup failure.

2. REPADMIN reports that a replication attempt has failed with status 8524.

    REPADMIN commands that commonly cite the 8524 status include, but aren't limited to:

    - `REPADMIN /REPLSUM`
    - `REPADMIN /SHOWREPS`
    - `REPADMIN /SHOWREPL`

    A sample of 8524 failures from REPADMIN /SHOWREPL is shown below:

    > Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID:
    DSA invocationID:  
    DC=contoso,DC=com  
        Default-First-Site-Name\CONTOSO-DC2 via RPC  
            DSA object GUID:  
            Last attempt @ YYYY-MM-DD HH:MM:SS failed, result 8524 (0x214c):  
                The DSA operation is unable to proceed because of a DNS lookup failure.  
            1 consecutive failure(s).  
            Last success @ YYYY-MM-DD HH:MM:SS.

    Rest of /showrepl output truncated

3. One of the following events with the 8524 status are logged in the directory service event log:

   - NTDS Knowledge Consistency Checker (KCC)
   - NTDS General
   - Microsoft-Windows-ActiveDirectory_DomainService

    Active Directory events that commonly cite the 8524 status include but aren't limited to:

    |Event|Source|Event String|
    |---|---|---|
    |Microsoft-Windows-ActiveDirectory_DomainService|2023|This directory server was unable to replicate changes to the following remote directory server for the following directory partition<br/><br/>|
    |NTDS General|1655|Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.<br/><br/>|
    |NTDS KCC|1308|The KCC has detected that successive attempts to replicate with the following directory service has consistently failed.<br/><br/> |
    |NTDS KCC|1865|The KCC was unable to form a complete spanning tree network topology. As a result, the following list of sites can't be reached from the local site <br/><br/>|
    |NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed. <br/><br/>|
    |NTDS KCC|1926|The attempt to establish a replication link to a read-only directory partition with the following parameters failed<br/><br/>|

4. Domain controllers log NTDS Replication event 2087 and NTDS Replication event 2088 in their Directory Service event log:

    > Log Name: Directory Service  
    Source: Microsoft-Windows-ActiveDirectory_DomainService  
    Date: \<date> \<time>  
    Event ID: 2087  
    Task Category: DS RPC Client  
    Level: Error  
    Keywords: Classic  
    User: ANONYMOUS LOGON  
    Computer: \<dc name>.\<domain name>  
    Description:  
    >  
    > Active Directory Domain Services couldn't resolve the following DNS host name of the source domain controller to an IP address. This error prevents additions, deletions, and changes in Active Directory Domain Services from replicating between one or more domain controllers in the forest. Security groups, group policy, users, and computers and their passwords will be inconsistent between domain controllers until this error is resolved. It potentially affects logon authentication and access to network resources.

    > Log Name:      Directory Service  
    Source:        Microsoft-Windows-ActiveDirectory_DomainService  
    Date:          \<date> \<time>  
    Event ID:      2088  
    Task Category: DS RPC Client  
    Level:         Warning  
    Keywords:      Classic  
    User:          ANONYMOUS LOGON  
    Computer:      \<dc name>.\<domain name>  
    Description:  
    Active Directory Domain Services couldn't use DNS to resolve the IP address of the source domain controller listed below. To maintain the consistency of Security groups, group policy, users, and computers and their passwords, Active Directory Domain Services successfully replicated using the NetBIOS or fully qualified computer name of the source domain controller.  
    >  
    > Invalid DNS configuration may be affecting other essential operations on member computers, domain controllers, or application servers in this Active Directory Domain Services forest, including logon authentication or access to network resources.  
    >  
    > You should immediately resolve this DNS configuration error so that this domain controller can resolve the IP address of the source domain controller using DNS.

## Cause

Error Status 8524 maps to the following error string:

> The DSA operation is unable to proceed because of a DNS lookup failure.

It's a catch-all error for all possible DNS failures affecting Active Directory on post Windows Server 2003 SP1 domain controllers.

`Microsoft-Windows-ActiveDirectory_DomainService` event 2087 is a partner event to other Active Directory events that cite the 8524 status if an Active Directory domain controller is unable to resolve a remote DC by its fully qualified CNAME record (\<object guid for source DCs NTDS Settings object>._msdcs.\<forest root domain>) using DNS.

`Microsoft-Windows-ActiveDirectory_DomainService` event 2088 is logged when a source domain controller is successfully resolved by its NetBIOS name but such name resolution fallback only occurs when DNS name resolution fails.

The presence of the 8524 status and the Microsoft-Windows-ActiveDirectory_DomainService event 2088 or 2087 events all indicate that DNS name resolution is failing Active Directory.

In summary, the 8524 replication status is logged when a destination DC can't resolve the source DC by its CNAME and Host "A" or Host "AAAA" records using DNS. Specific root causes include:

1. The source DC is offline, or no longer exists, but its NTDS Settings object still exist in the destination DCs' copy of Active Directory.
2. The source DC failed to register the CNAME or host records on one or more DNS Servers because of the following reasons:

    - The registration attempts failed.
    - DNS client settings on the source don't point to DNS Servers that either host, forwarded or delegate its _msdcs.\<forest root domain zone and (or) primary DNS suffix domain zones>.
4. DNS client settings on the destination DC don't point to DNS Servers that either host, forward or delegate the DNS zones containing the CNAME or host records for the source DC
5. CNAME and host records registered by the source DC don't exist on DNS servers queried by the destination DC because of the following reasons:

    - Simple replication latency
    - A replication failure
    - A zone transfer failure
6. Invalid forwarders or delegations. They prevent the destination DC from resolving CNAME or Host records for DCs in other domains in the forest.
7. DNS Servers used by destination DC, source DC, or intermediate DNS Servers aren't functioning properly.

## Resolution

### Verify whether the 8524 is caused by an offline DC or stale DC metadata

If the 8524 error/event refers to a DC that's currently offline but still valid in the forest, make it operational.

If the 8524 error/event refers to an inactive DC, remove the stale metadata for that DC from the destination DCs' copy of Active Directory. An inactive DC is a DC install that no longer exists on the network, but its NTDS Settings object still exists in the destination DCs' copy of Active Directory -

Microsoft support regularly finds stale metadata for nonexistent DCs, or stale metadata from previous promotions of a DC with the same computer name that hasn't been removed from Active Directory.  

### Remove stale DC metadata if present

#### GUI Metadata Cleanup using Active Directory Sites and Services (DSSITE.MSC)

1. Start the Windows Server 2008 or Windows Server 2008 R2 Active Directory Sites and Services snap-in (DSSITE.MSC).

    It can also be done by starting the Active Directory Sites and Services on a Windows Vista or Windows 7 computer that has been installed as part of the Remote Server Administration Tools (RSAT) package.

2. Focus the DSSITE.MSC snap-in on the destination DCs' copy of Active Directory.

    After starting DSSITE.MSC, right-click the "Active Directory Sites and Services [\<DC Name>]

    Select the destination DC that's logging the 8524 error/event from the list of DCs visible in the "Change Domain Controller..." list

3. Delete the source DCs NTDS Settings object referenced in the 8524 errors and events. Active Directory Users and Computers (DSA.MSC) snap-in and delete either the source DCs NTDS Settings object.

    A DCs NTDS Settings object appears

    - Below the Sites, Site Name, Servers container, and %server name% container
    - Above the inbound connection object displayed in the right pane of Active Directory Sites and Services.

    The red highlight in the screenshot below shows the NTDS Settings object for CONTOSO-DC2 located below the Default-First-Site-Name site.

    :::image type="content" source="media/replication-error-8524/ntds-settings-default-first-site-name.png" alt-text="Screenshot of the Active Directory Sites and Services windows with the NTDS Settings selected.":::

    Right-click the stale NTDS Settings object you want to remove, then select "Delete."

    Metadata cleanup can also be done from the W2K8 / W2K8 R2 Active Directory Users and Computers snap-in as documented in [TECHNET](https://technet.microsoft.com/library/cc816907%28WS.10%29.aspx).

#### Command-line Metadata Cleanup using NTDSUTIL

The legacy or command-line method of deleting stale NTDS Settings objects using the NTDSUTIL metadata cleanup command is documented in [Clean up Active Directory Domain Controller server metadata](/windows-server/identity/ad-ds/deploy/ad-ds-metadata-cleanup).

### Run `DCDIAG /TEST:DNS` on the source DC + destination DC
  
`DCDIAG /TEST:DNS` does seven different tests to quickly vet the DNS health of a domain controller. This test isn't run as part of the default execution of DCDIAG.

1. Sign in with Enterprise Admin credentials to the console of the destination domain controllers that log the 8524 events.
2. Open an administrative privileged CMD prompt, and then run `DCDIAG /TEST:DNS /F` on the DC logging the 8424 status and the source DC that the destination DC is replicating from.

    To run DCDIAG against all DCs in a forest, type `DCDIAG /TEST:DNS /V /E /F:<File name.txt>`.

    To run DCDIAG TEST:DNS against a specific DC, type `DCDIAG /TEST:DNS /V /S:<DC NAME> /F:<File name.txt>`.
3. Locate the summary table at the end of the `DCDIAG /TEST:DNS` output. Identify and reconcile warning or failure conditions on the relevant DCs of the report.
4. If DCDIAG doesn't identify the root cause, take "the long way around" using the steps below.

### Check Active Directory Name Resolution using PING

Destination DCs resolve source DCs in DNS by their fully qualified CNAME records that are derived from the object GUID of the remote DCs NTDS Settings object (the parent object to connection objects visible in the Active Directory Sites and Services snap-in). You can test a given DCs' ability to resolve a source DC fully qualified CNAME record using the PING command.

1. Locate the objectGUID of the source DCs NTDS Settings object in the source DCs' copy of Active Directory.

     From the console of the source DC logging the 8524 error/event, type:

     `repadmin /showrepl <fully qualified hostname of source DC cited in the 8524 error (event)>`

     For example, if the DC referenced in the 8524 error/event is contoso-DC2 in the `contoso.com` domain, type:

     `repadmin /showrepl contoso-dc2.contoso.com`

     The "DSA Object GUID" field in the header of the `repadmin /SHOWREPl` command contains the objectGUID of the source DCs _current_ NTDS settings object. Use the source DCs' view of its NTDS Settings Object in case replication is slow or failing. The header of the `repadmin` output will look something like:

    > Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID: 8a7baee5-cd81-4c8c-9c0f-b10030574016   <- right click + copy this string to the Windows  
    <- clipboard & paste into it the PING command in  
    <- step 4  

2. Locate the ObjectGUID of the source DC in the _destination_ DCs' copy of Active Directory.

     From the console of the destination DC logging the 8524 error/event, type:

    `repadmin /showrepl <fully qualified hostname of destination DC>`

     For example, if the DC logging 8524 error/event is contoso-DC1 in the `contoso.com` domain, type:

     `repadmin /showrepl contoso-dc1.contoso.com`

     `REPADMIN /SHOWREPL` output is shown below. The "DSA Object GUID" field is listed for each source DC the destination DC inbound replicates from.

   ```console
    c:\>repadmin /showreps `contoso-dc1.contoso.com`  
    Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID:  
    DSA invocationID:  
     DC=contoso,DC=com  
        Default-First-Site-Name\CONTOSO-DC2 via RPC  
            DSA object GUID: 8a7baee5-cd81-4c8c-9c0f-b10030574016      <- Object GUID for source DC derived from  
            Last attempt @ 2010-03-24 15:45:15 failed, result 8524 (0x214c):        \ destination DCs copy of Active Directory  
                The DSA operation is unable to proceed because of a DNS lookup failure.
            23 consecutive failure(s).  
            Last success @ YYYY-MM-DD HH:MM:SS.
   ```

3. Compare the object GUID from #2 and #3.

    If the object GUIDS are the same, then the source DC and destination DC know about the same instantiation (the same promotion) of the source DC. If they're different, then figure which one was created later. The NTDS setting object with the earlier create date is likely stale and should be removed.

4. PING the source DC by its fully qualified CNAME.  

    From the console of the destination DC, test Active Directory's name resolution with a PING of the source DCs fully qualified CNAME record:

     `c:\>ping <ObjectGUID> from source DCs NTDS Settings object._msdcs.<DNS name for Active Directory forest root domain>`

     Using our example of the **8a7baee5...** objectGUID from the `repadmin /showreps` output above from the contoso-dc1 DC in the `contoso.com` domain, the PING syntax would be:

     `c:\>ping 8a7baee5-cd81-4c8c-9c0f-b10030574016. _msdcs.contoso.com`

     If ping works, retry the failing operation in Active Directory. If PING fails, proceed to the "Resolve the 8524 DNS lookup failure" but retrying the PING test after each step until it resolves.  

### Resolve the 8524 DNS lookup failure: The long way around

If the 8524 error/events aren't caused by stale DC metadata, and the CNAME PING test fails, vet the DNS health of:

- The source DC
- The destination DC
- The DNS Servers used by the source and destination DCs

In summary, verify that:

- The source DC has registered the CNAME and host records with a valid DNS.
- The destination DC points to valid DNS Servers.
- The records of interest registered by source DCs are resolvable by destination DCs.

The error message text in DS RPC Client event 2087 documents a user action for resolving the 8524 error. A more detailed action plan follows:

1. **Verify that the source DC points to valid DNS Servers**  

    On the source DC, verify that DNS Client settings point exclusively to operational DNS Severs that either host, forward or delegate the_msdcs.\<forest root domain> zone (that is, All DCs in the contoso.com forest register CNAME records in the_msdcs.contoso.com zone)

    AND

    The DNS zone for the Active Directory domain (that is, a computer in the contoso.com domain would register host records in contoso.com zone).

    AND

    The computers primary DNS suffix domain if different from the Active Directory domain name (see Technet article [Disjoint Namespace](https://technet.microsoft.com/library/cc731125%28WS.10%29.aspx)).

    Options to validate that a DNS Server hosts, forwards, or delegates (that is, "can resolve") such zones include.

    - Start the DNS management tool for your DNS and verify the DNS Servers to which the source DC points for name resolution host the zones in question.
    - Use NSLOOKUP to verify that all of the DNS Servers that the source DC points to can resolve queries for the DNS zones in question.

        Run IPCONFIG /ALL on the console of the source DC

        ```console
        c:\>ipconfig /all
        …
        DNS Servers . . . . . . . . . . . : 10.45.42.99 <- Primary DNS Server IP>
                                                   10.45.42.101<- Secondary DNS Server IP>
        ```

        Run the following NSLOOKUP queries:

        ```console
        c:\>nslookup -type=soa  <Source DC DNS domain name> <source DCs primary DNS Server IP >
        c:\>nslookup -type=soa  < Source DC DNS domain name > <source DCs secondary DNS Server IP >
        c:\>nslookup -type=soa  <_msdcs.<forest root DNS domain> <source DCs primary DNS Server IP >
        c:\>nslookup -type=soa  <_msdcs.<forest root DNS domain> <source DCs secondary DNS Server IP >
        ```

        For example, if a DC in the `CHILD.CONTOSO.COM` domain of the `contoso.com` forest is configured with the primary and secondary DNS Server IPs "10.45.42.99" and "10.45.42.101", the NSLOOKUP syntax would be:

        ```console
        c:\>nslookup -type=soa  child.contoso.com 10.45.42.99
        c:\>nslookup -type=soa  child.contoso.com 10.45.42.101
        c:\>nslookup -type=soa  _msdcs.contoso.com 10.45.42.99
        c:\>nslookup -type=soa  _msdcs.contoso.com 10.45.42.101
        ```

    Notes:

    - The SOA query for the _mscs.contoso.com zone will resolve correctly if the targeted DNS has a good forwarder or delegation or for the_msdcs.\<forest root zone>. It won't resolve correctly if the _msdcs.\<forest root zone> on the DNS Server being queried is a non-delegated subdomain of \<forest root zone> that is the zone relationship created by Windows 2000 domains.
    - CNAME records are always registered in the _msdcs.\<forest root zone>, even for DC in non-root domains.
    - Configuring the DNS client of a DC or member computer to point to an ISP DNS Server for name resolution is invalid. The only exception is that ISP has been contracted (that is, paid), and is currently hosting, forwarding, or delegating DNS queries for your Active Directory forest.
    - ISP DNS Servers typically don't accept dynamic DNS updates so CNAME, Host, and SRV records may have to be manually registered.

2. **Verify that the source DC has registered its CNAME record**  

    Use step 1 from "Check Active Directory Name Resolution using PING" to locate the current CNAME of the source DC.

    Run `ipconfig /all` on the console of the source DC to determine to which DNS Servers the source DC points for name resolution.

    ```console
    c:\>ipconfig /all
    …
    DNS Servers . . . . . . . . . . . : 10.45.42.99                        <primary DNS Server IP
                                               10.45.41.101                      <secondary DNS Server IP
    ```

    Use NSLOOKUP to query the current DNS Servers for the source DCs' CNAME record (found via the procedure in "Check Active Directory Name Resolution using PING").

    ```console
    c:\>nslookup -type=cname <fully qualified cname of source DC> <source DCs primary DNS Server IP >
    c:\>nslookup -type=cname <fully qualified cname of source DC> <source DCs secondary DNS Server IP>
    ```

    In the example, the NTDS Settings objectGUID for contoso-dc2 in the contoso.com domain is 8a7baee5-cd81-4c8c-9c0f-b10030574016. It points to "10.45.42.99" as primary for DNS name resolution. The NSLOOKUP syntax would be:

    ```console
    c:\>nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 10.45.42.99
    c:\>nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 10.45.42.101
    ```

    If the source DC hasn't registered its CNAME record on the DNS Servers it points to for name resolution, run the following command from the source DC. Then recheck the registration of the CNAME record:

    ```console
    c:\>net stop netlogon & net start netlogon
    ```

    Notes:

    - CNAME records are always registered in the _msdcs.\<forest root zone>, even for DC in non-root domains.
    - CNAME records are registered by the NETLOGON Service during OS startup, NETLOGON service startup, and recurring intervals later.
    - Each promotion of a DC with the same name may create a new NTDS Settings object with a different objectGUID that therefore registers a different CNAME record. Verify registration of the CNAME record based the last promotion of the source DC vs. the objectGUID for the NTDS Settings object on the destination DC if the source has been promoted more than 1x.
    - Timing issues during OS startup can delay successful Dynamic DNS registration.
    - If a DC's CNAME record was successfully registered, but later disappears, check [KB953317](https://support.microsoft.com/help/953317). Duplicate DNS zones in different replication scopes or overly aggressive DNS scavenging by the DNS Server.
    - If the CNAME record registration is failing on the DNS servers to which the source DC points for name resolution, review NETLOGN events in the SYSTEM event log for DNS registration failures.

3. **Verify that the source DC has registered its host records**

    From the console of the source DC, run `ipconfig /all` to determine to which DNS Servers the source DC points for name resolution.

    ```console
    c:\>ipconfig /all
    …
    DNS Servers . . . . . . . . . . . : 10.45.42.99 <- Primary DNS Server IP>
                                               10.45.42.101<- Secondary DNS Server IP>
    ```

    Use NSLOOKUP to query the current DNS Servers for the host record.

    ```console
    c:\>nslookup -type=A+AAAA  <fully qualified hostname of source DC> <source DCs primary DNS Server IP >
    c:\>nslookup -type=A+AAAA <fully qualified hostname of source DC> <source DCs secondary DNS Server IP>
    ```

    Continuing the example for the hostname for contoso-dc2 in the contoso.com domain is 8a7baee5-cd81-4c8c-9c0f-b10030574016 and points to self (127.0.0.1) as primary for DNS name resolution, the NSLOOKUP syntax would be:

    ```console
    c:\>nslookup -type=A+AAAA contoso-dc1.contoso.com 10.45.42.99
    c:\>nslookup -type=A+AAAA contoso-dc1.contoso.com 10.45.42.101
    ```

    Repeat the NSLOOKUP command against the source DCs secondary DNS Server IP address.

    To dynamically register host "A" records, type the following command from the console of the computer:

    ```console
    c:\>ipconfig /registerdns
    ```

    Notes:

    - Windows 2000 through Windows Server 2008 R2 computers all register IPv4 host "A" records.
    - Windows Server 2008 and Windows Server 2008 R2 computers all register IPv6 host "AAAA" records.
    - Host "A" and "AAAA" records are registered in the computers primary DNS suffix zone.
    - Disable NICs that don't have network cables attached.
    - Disable host record registration on NICs that aren't accessible to DCs and member computers on the network.
    - It isn't supported to disable the IPv6 protocol by unchecking the IPv6 checkbox in the network card properties.

4. **Verify that the destination DC points to valid DNS Servers**  

    On the destination DC, verify that DNS Client settings point exclusively to currently online DNS Severs that either host, forward and delegate the _msdcs.\<forest root domain> zone  (that is, all DCs in the contoso.com forest register CNAME records in the_msdcs.contoso.com zone).

    AND

    The DNS zone for the Active Directory domain (that is, a computer in the contoso.com domain would register host records in contoso.com zone).

    AND

    The computers primary DNS suffix domain if different from the Active Directory domain name (see Technet article [Disjoint Namespace](https://technet.microsoft.com/library/cc731125%28WS.10%29.aspx)).

    Options to validate that a DNS Server hosts, forwards, or delegates (that is, "can resolve") such zones include:

    - Start the DNS management tool for your DNS and verify the DNS Servers to which the source DC points for name resolution host the zones in question.

        OR

    - Use NSLOOKUP to verify that all of the DNS Servers that the source DC points to can resolve queries for the DNS zones in question.

        Run IPCONFIG /ALL on the console of the destination DC:

        ```console
        c:\>ipconfig /all
        …
        DNS Servers . . . . . . . . . . . : 10.45.42.102 <- Primary DNS Server IP>
                                                              10.45.42.103<- Secondary DNS Server IP>
        ```

        Run the following NSLOOKUP queries from the console of the destination DC:  

        ```console
        c:\>nslookup -type=soa  <Source DC DNS domain name> <destinatin DCs primary DNS Server IP >
        c:\>nslookup -type=soa  < Source DC DNS domain name > <destination DCs secondary DNS Server IP >
        c:\>nslookup -type=soa  _msdcs.<forest root DNS domain> <destination DCs primary DNS Server IP >
        c:\>nslookup -type=soa  _msdcs.<forest root DNS name> <destination DCs secondary DNS Server IP>
        ```

    For example, if a DC in the CHILD.CONTOSO.COM domain of the contoso.com forest is configured with the primary and secondary DNS Server IPs "10.45.42.102" and "10.45.42.103", the NSLOOKUP syntax would be  

    ```console
    c:\>nslookup -type=soa  child.contoso.com 10.45.42.102
    c:\>nslookup -type=soa  child.contoso.com 10.45.42.103
    c:\>nslookup -type=soa  _msdcs.contoso.com 10.45.42.102
    c:\>nslookup -type=soa  _msdcs.contoso.com 10.45.42.103
    ```
  
    Notes:

    - The SOA query for the _mscs.contoso.com zone will resolve correctly if the targeted DNS has a good forwarder or delegation or for the_msdcs.\<forest root zone>. It won't resolve correctly if the_msdcs.\<forest root zone> on the DNS Server being queried is a non-delegated subdomain of \<forest root zone> that is the zone relationship created by Windows 2000 domains.
    - CNAME records are always registered in the _msdcs.\<forest root zone>, even for DC in non-root domains.
    - Configuring the DNS client of a DC or member computer to point to an ISP DNS Server for name resolution is invalid. The only exception is that ISP has been contracted (that is, paid) and is currently hosting, forwarding, or delegating DNS queries for your Active Directory forest.
    - ISP DNS Servers typically don't accept dynamic DNS updates, so CNAME, Host, and SRV records may have to be manually registered.
    - The DNS resolver on the Windows computers is by-design "sticky". It uses DNS servers that are responsive to queries, regardless of whether such DNS Servers host, forward, or delegate the required zones. Restated, the DNS resolver won't fail over and query another DNS server as long as the active DNS is responsive, even if the response from the DNS Server is "I either don't host the record you're looking for or even host a copy of the zone for that record".

5. **Verify that the DNS Server used by the destination DC can resolve the source DCs CNAME and HOST records**  

    From the console of the destination DC, run `ipconfig /all` to determine the DNS Servers to which destination DC points for name resolution:

    ```console
    DNS Servers that destination DC points to for name resolution:

    c:\>ipconfig /all
    …
      DNS Servers . . . . . . . . . . . : 10.45.42.102 <- Primary DNS Server IP>
                                                 10.45.42.103<- Secondary DNS Server IP>
    ```

    From the console of the destination DC, use `NSLOOKUP` to query the DNS Servers configured on the destination DC for the source DCs CNAME and host records:

    ```console  
    c:\>nslookup -type=cname <fully qualified CNAME of source DC> <destination DCs primary DNS Server IP >
    c:\>nslookup -type=cname <fully qualified CNAME of source DC> <destination DCs secondary DNS Server IP>
    c:\>nslookup -type=host <fully qualified hostname of source DC> <destination DCs primary DNS Server IP >
    c:\>nslookup -type=host <fully qualified hostname of source DC> <destination DCs secondary DNS Server IP>
    ```

    In the example, contoso-dc2 in the contoso.com domain with GUID 8a7baee5-cd81-4c8c-9c0f-b10030574016 in the `Contoso.com` forest root domain points to DNS Servers "10.45.42.102" and "10.45.42.103". The NSLOOKUP syntax would be:  

    ```console
    c:\>nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 10.45.42.102
    c:\>nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 10.45.42.103
    c:\>nslookup -type=A+AAAA contoso-dc1.contoso.com 10.45.42.102
    c:\>nslookup -type=A+AAAA contoso-dc1.contoso.com 10.45.42.102  
    ```

6. **Review the relationship between the DNS Servers used by the source and destination DCs**  

    If the DNS Servers used by the source and destination host AD-integrated copies of the _msdcs.\<forest root> and \<primary DNS suffix> zones, check for:

    - Replication latency between the DNS where the record was registered and the DNS where the record is being queried.
    - A replication failure between the DNS where the record is registered and the DNS being queried.
    - The DNS zone hosting the record of interest stays in different replication scopes and therefore different contents, or is CNF / conflict-mangled on one or more DCs.

    If the DNS zones used by the source and destination DC are stored in primary and secondary copies of DNS zones, check for:

    - The "allow zone transfers" checkbox isn't enabled on the DNS that hosts the primary copy of the zone.
    - The "Only the following servers" checkbox is enabled, but the IP address of the secondary DNS hasn't been added to the allowlist on the primary DNS.
    - The DNS zone on the Windows Server 2008 DNS hosting the secondary copy of the zone is empty because of [KB953317](https://support.microsoft.com/help/953317).

    If the DNS servers used by the source and destination DC have parent / child relationships, check for:

    - Invalid delegations on the DNS that owns the parent zone that is delegating to the subordinate zone.
    - Invalid forwarder IP addresses on the DNS server trying to resolve the superior DNS zone (example: a DC in child.contoso.com trying to resolve host records in conto.com zone staying on DNS Servers in the root domain).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
