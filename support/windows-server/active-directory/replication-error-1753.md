---
title: Active Directory Replication fails with Win32 error 1753
description: Describes an issue where AD operations fail with Win32 error 1753 (There are no more endpoints available from the endpoint mapper).
ms.date: 06/17/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# Active Directory Replication Error 1753: There are no more endpoints available from the endpoint mapper

This article describes an issue where Active Directory Replications fail with Win32 error 1753: "There are no more endpoints available from the endpoint mapper."

_Original KB number:_ &nbsp; 2089874  
_Applies to:_ &nbsp; All supported versions of Windows Server

**Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, [ask the Microsoft Community](https://answers.microsoft.com).

## Symptoms

This article describes symptoms, cause, and resolution steps for AD operations that fail with Win32 error 1753: "There are no more endpoints available from the endpoint mapper."

1. DCDIAG reports that the Connectivity test, Active Directory Replications test, or KnowsOfRoleHolders test has failed with error 1753: "There are no more endpoints available from the endpoint mapper."

    > Testing server: \<site\>\<DC Name\>  
          Starting test: Connectivity  
             *Active Directory LDAP Services Check
             * Active Directory RPC Services Check  
             [\<DC Name\>] DsBindWithSpnEx() failed with error 1753,  
             There are no more endpoints available from the endpoint mapper..  
             Printing RPC Extended Error Info:  
             Error Record 1, ProcessID is \<process ID\> (DcDiag)  
                System Time is: \<date> \<time>  
                Generating component is 2 (RPC runtime)
                Status is 1753: There are no more endpoints available from the endpoint mapper. Detection location is 500
                NumberOfParameters is 4  
                Unicode string: ncacn_ip_tcp  
                Unicode string: \<source DC object GUID>._msdcs.contoso.com  
                Long val: -481213899  
                Long val: 65537  
             Error Record 2, ProcessID is 700 (DcDiag)  
                System Time is: \<date> \<time>  
                Generating component is 2 (RPC runtime)  
                Status is 1753: There are no more endpoints available from the endpoint mapper.  
                NumberOfParameters is 1  
                Unicode string: 1025

    > [Replications Check,\<DC Name\>] A recent replication attempt failed:  
                From \<source DC\> to \<destination DC>  
                Naming Context: \<DN path of directory partition>  
                The replication generated an error (1753):  
                There are no more endpoints available from the endpoint mapper.  
                The failure occurred at \<date> \<time>.  
                The last success occurred at \<date> \<time>.  
                3 failures have occurred since the last success.  
                The directory on \<DC name> is in the process.  
                of starting up or shutting down, and is not available.  
                Verify machine is not hung during boot.

2. REPADMIN.EXE reports that replication attempt has failed with status 1753.

    REPADMIN commands that commonly cite the 1753 status include but aren't limited to:

    - REPADMIN /REPLSUM
    - REPADMIN /SHOWREPL
    - REPADMIN /SHOWREPS
    - REPADMIN /SYNCALL

    The following sample output from `REPADMIN /SHOWREPS` shows that inbound replication from CONTOSO-DC2 to CONTOSO-DC1 fails with the "replication access was denied" error:

    > Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID:  
    DSA invocationID:  
    >
    > DC=contoso,DC=com  
        Default-First-Site-Name\CONTOSO-DC2 via RPC  
            DSA object GUID:  
            Last attempt @ \<date\> \<time\> failed, result 1753 (0x6d9):  
                There are no more endpoints available from the endpoint mapper.  
            <#> consecutive failure(s).  
            Last success @ \<date\> \<time\>.

3. The "Check Replication Topology" command in Active Directory Sites and Services returns "there are no more endpoints available from the endpoint mapper."

    Right-clicking on the connection object from a source DC and choosing "Check Replication Topology" fails with "There are no more endpoints available from the endpoint mapper. The on-screen error message is shown below:

    > Dialog Title Text: Check Replication Topology  
    Dialog Message text:  
    >
    > The following error occurred during the attempt to contact the domain controller: There are no more endpoints available from the endpoint mapper.
    >
    > OK

4. The "replicate now" command in Active Directory Sites and Services returns "there are no more endpoints available from the endpoint mapper."

    Right-clicking on the connection object from a source DC and choosing "replicate now" fails with "There are no more endpoints available from the endpoint mapper. The on-screen error message is shown below:  

    > Dialog title text: Replicate Now
    >
    > Dialog message text: The following error occurred during the attempt to synchronize naming context \<directory partition name> from Domain Controller \<Source DC> to Domain Controller \<Destination DC>:
    There are no more endpoints available from the endpoint mapper
    >
    > The operation will not continue
    >
    > Buttons in Dialog: OK

5. NTDS Knowledge Consistency Checker (KCC), NTDS General, or Microsoft-Windows-ActiveDirectory_DomainService events with the 1753 status are logged in the directory service event log.

    Active Directory events that commonly cite the 1753 status include but aren't limited to:

    |Event Source|Event ID|Event String<br/>|
    |---|---|---|
    |NTDS General|1655|Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.<br/><br/>|
    |NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed.<br/><br/>|
    | NTDS KCC|1265|An attempt by the Knowledge Consistency Checker (KCC) to add a replication agreement for the following directory partition and source domain controller failed. <br/> |

## Cause

The diagram below shows the Remote Procedure Call (RPC)  workflow. The workflow starts with the registration of the server application with the RPC Endpoint Mapper (EPM) in step 1. It ends with the passing of data from the RPC client to the client application in step 7.

:::image type="content" source="media/replication-error-1753/rpc-workflow-diagram.png" alt-text="Screenshot of the RPC workflow diagram, which shows the details from step 1 to step 7.":::

Steps 1 through 7 map to the following operations:

1. Server app registers its endpoints with the RPC Endpoint Mapper (EPM).
2. Client makes an RPC call on behalf of a user, OS, or application-initiated operation.
3. Client-side RPC contacts the target computers EPM and asks for the endpoint to complete the client call.
4. Server Machine's EPM responds with an endpoint.
5. Client-side RPC contacts the server app.
6. Server app executes the call, returns the result to the client RPC.
7. Client-side RPC passes the result back to the client app.

Failure 1753 is generated by a failure between steps 3 and 4. Specifically, error 1753 means that the RPC client (destination DC) could contact the RPC Server (source DC) over port 135, but the EPM on the RPC Server (source DC) couldn't locate the RPC application of interest and returned server-side error 1753. The error indicates that the RPC client (destination DC) received the server-side error response from the RPC Server (AD replication source DC) over the network.

Specific root causes for the 1753 error include:  

1. The server app never started. That is, step 1 in the "more information" diagram was never attempted.  
2. The server app started, but there was some failure during initialization. The failure prevented it from registering with the RPC Endpoint Mapper. That is, step 1 in the "more information" diagram was attempted but failed.  
3. The server app started, but later died. That is, step 1 in the "more information" diagram was completed successfully. It was undone later because the server died.  
4. The server app manually unregistered its endpoints (similar to 3 but intentional.  Not likely but included for completeness.)  
5. The RPC client (destination DC) contacted a different RPC server than the intended one. It's because of a Name to IP-mapping error in DNS, WINS, or host / lmhosts file.  

Error 1753 is NOT caused by:

- a lack of network connectivity between the RPC client (destination DC) and RPC Server (source DC) over port 135.
- a lack of network connectivity between the RPC server (source DC) using port 135 and the RPC client (destination DC) over the ephemeral port.
- a password mismatch or the inability by the source DC to decrypt a Kerberos encrypted packet.

## Resolution

### Verify that the service registering its service with the endpoint mapper has started

- For Windows 2000 and Windows Server 2003 DCs: ensure that the source DC is booted into normal mode.
- For Windows Server 2008 or Windows Server 2008 R2: from the console of the source DC, start Services Manager (services.msc). Verify that the Active Directory service is running. Active Directory appears as "Active Directory Domain Services"

### Verify that RPC client (destination DC) connected to the intended RPC Server (source DC)

All DCs in a common Active Directory forest register a GUIDED DC CNAME record in the _msdcs.\<forest root domain> DNS zone, regardless of what domain they reside in within the forest. The guided DC CNAME record is derived from the objectGUID of each DCs NTDS Settings object.

When doing replication-based operations, a destination DC queries DNS for the source DCs GUIDED CNAME record. The CNAME record contains the source DC's fully qualified computer name. This name is used to derive the source DCs IP address via:

- DNS client cache lookup
- Host / LMHost file lookup
- host A / AAAA record in DNS or WINS

Stale NTDS Settings objects and bad name to IP mappings in DNS, WINS, Host, and LMHOST files may cause the RPC client (destination DC) to connect to the wrong RPC Server (Source DC). Furthermore, the bad name to IP mapping may cause the RPC client (destination DC) to connect to a computer that doesn't even have the RPC Server Application of interest (the Active Directory role in this case) installed. For example, a stale host record for DC2 contains the IP address of DC3 or a member computer.

Verify that the following GUIDs match:

- the object GUID for the source DC that exists in the destination DCs' copy of Active Directory
- the source DC object GUID stored in the source DCs' copy of Active Directory.

If there's a discrepancy, use `repadmin /showobjmeta` on the NTDS settings object to see which one corresponds to last promotion of the source DC. Compare the following date stamps:

- The NTDS Settings object create date from `/showobjmeta`.
- The last promotion date in the source DCs dcpromo.log file.

You may have to use the last modify / create date of the DCPROMO.LOG file itself. If the object GUIDs aren't identical, the destination DC may have a stale NTDS Settings object for the source DC whose CNAME record refers to a host record with a bad name to IP mapping.

On the destination DC, run `IPCONFIG /ALL` to determine which DNS Servers the destination DC is using for name resolution:

```console
c:\>ipconfig /all  
```

On the destination DC, run `NSLOOKUP` against the source DCs fully qualified DC CNAME record:

```console
c:\>nslookup -type=cname \<fully qualified cname of source DC> <destination DCs primary DNS Server IP >
c:\>nslookup -type=cname \<fully qualified cname of source DC> <destination DCs secondary DNS Server IP>
```

Verify that the IP address returned by `NSLOOKUP` "owns" the host name / security identity of the source DC.

a) `C:\\>NBTSTAT -A \\<IP address _returned_ by NSLOOKUP in the step above>`

OR

b) Sign in to the console of the source DC, run `IPCONFIG` from the CMD prompt and verify that the source DC owns the IP address returned by the NSLOOKUP command above.

Check for stale / duplicate host to IP mappings in DNS.

```console
NSLOOKUP -type=hostname \<single label hostname of source DC> \<primary DNS Server IP on destination DC>
NSLOOKUP -type=hostname \<single label hostname of source DC> \<secondary DNS Server IP on destination DC>

NSLOOKUP -type=hostname \<fully qualified computer name of source DC> \<primary DNS Server IP on destination DC>
NSLOOKUP -type=hostname \<fully qualified computer name of source DC> \<secondary DNS Server IP on dest. DC>
```

If invalid IP addresses exist in host records, investigate whether DNS scavenging is enabled and properly configured.

If the tests above or a network trace doesn't show a name query returning an invalid IP address, consider stale entries in HOST files, LMHOSTS files, and WINS Servers. DNS Servers can also be configured to perform WINS fallback name resolution.

### Verify that the server application (Active Directory, and so on) has registered with the endpoint mapper on the RPC server (source DC)

Active Directory uses a mix of well-known and dynamically registered ports. Well-known ports and protocols used by Active Directory domain controllers include:

| RPC Server Application| Port| TCP| UDP| Comments |
|---|---|---|---|---|
| DNS Server| 53| √| √| |
| Kerberos| 88| √| √| |
| LDAP Server| 389| √| √| |
| Microsoft-DS| 445| √| √||
| LDAP SSL| 636| √| √| |
| Global Catalog Server| 3268| √|| |
| Global Catalog Server| 3269| √|| |

Well-known ports are NOT registered with the endpoint mapper.

Active Directory and other applications also register services that receive dynamically assigned ports in the RPC ephemeral port range. Such RPC server applications are dynamically assigned TCP ports between 1024 and 5000 on Windows 2000 and Windows Server 2003 computers. They are dynamically assigned TCP ports between 49152 and 65535 range on Windows Server 2008 and Windows Server 2008 R2 computers. The RPC port used by replication can be hard-coded in the registry using the steps documented in MSKB [224196](https://support.microsoft.com/kb/224196/). Active Directory continues to register with the EPM when configured to use a hard-coded port.

Verify that the RPC Server application of interest has registered itself with the RPC endpoint mapper on the RPC Server (the source DC in the case of AD replication).

There are many ways to accomplish this task. One is to install and run [PORTQRY](https://www.microsoft.com/download/details.aspx?id=17148) from an admin privileged command prompt on the console of the source DC:

```console
c:\>portquery -n \<source DC> -e 135 >file.txt
```

In the `portqry` output, note the port numbers dynamically registered by the "MS NT Directory DRS Interface" (UUID = 351...) for the **ncacn_ip_tcp protocol**. The snippet below shows a sample output from a Windows Server 2008 R2 DC and the UUID / protocol pair used by Active Directory highlighted in **bold:**  

> UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface
ncacn_np:CONTOSO-DC01[\\pipe\\lsass]  
UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface  
ncacn_np:CONTOSO-DC01[\\PIPE\\protected_storage]  
UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface  
ncacn_ip_tcp:CONTOSO-DC01[49156]  
UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface  
ncacn_http:CONTOSO-DC01[49157]  
UUID: e3514235-4b06-11d1-ab04-00c04fc2dcd2 MS NT Directory DRS Interface  
ncacn_http:CONTOSO-DC01[6004]

### Other causes

1. Verify that the source DC is booted in normal mode. And verify that the OS and DC role on the source DC have fully started.

1. Verify that the Active Directory Domain Service is running. If the service is currently stopped or wasn't configured with default startup values, reset the default startup values. Reboot the modified DC, and then retry the operation.

1. Verify that the startup value and service status for RPC service and RPC Locator is correct for OS version of the RPC Client (destination DC) and RPC Server (source DC). If the service is currently stopped or wasn't configured with default startup values, reset the default startup values. Reboot the modified DC, and then retry the operation.

    Also ensure that the service context matches default settings.

    |**Windows 2000**| **Startup Value**| **Service Status** |
    |---|---|---|
    | Remote Procedure Call (RPC)| Automatic|Started|
    | Remote Procedure Call (RPC) Locator| Automatic|Started|
    |
    | **Windows Server 2003, Server 2008, Server 2008 R2**|**Startup Value**| **Service Status**
    | Remote Procedure Call (RPC)|Automatic|Started|
    | Remote Procedure Call (RPC) Locator|Manual|Null or Stopped|

1. Verify that the size of the dynamic port range hasn't been constrained. The Windows Server 2008 and Windows Server 2008 R2 NETSH syntax to enumerate the RPC port range is shown below:

    ```console
    >netsh int ipv4 show dynamicport tcp
    >netsh int ipv4 show dynamicport udp
    >netsh int ipv6 show dynamicport tcp
    >netsh int ipv6 show dynamicport udp
    ```

1. Review [KB 224196](https://support.microsoft.com/help/224196). Ensure that the hard-coded port falls within the ephemeral port range for the source DC's OS version.

1. Verify that the ClientProtocols key exists under `HKLM\Software\Microsoft\Rpc` and contains the following five default values:

    ```console
    ncacn_http REG_SZ rpcrt4.dll
    ncacn_ip_tcp REG_SZ rpcrt4.dll
    ncacn_nb_tcp REG_SZ rpcrt4.dll
    ncacn_np REG_SZ rpcrt4.dll
    ncacn_ip_udp REG_SZ rpcrt4.dll
    ```

## More information

### Example of a bad name to IP mapping causing RPC error 1753 vs. -2146893022: the target principal name is incorrect

The `contoso.com` domain consists of \\\DC1 and \\\DC2 with IP addresses x.x.1.1 and x.x.1.2. The host "A" / "AAAA" records for \\\DC2 are correctly registered on all of the DNS Servers configured for \\\DC1. In addition, the HOSTS file on \\\DC1 contains an entry-mapping DC2's fully qualified hostname to IP address x.x.1.2. Later, DC2's IP address changes from X.X.1.2 to X.X.1.3 and a new member computer is joined to the domain with IP address x.x.1.2. AD Replication attempts triggered by the "replicate now" command in Active Directory Sites and Services snap-in fails with error 1753. The trace is shown below:

> F# SRC       DEST      Operation  
 1  x.x.1.1   x.x.1.2   ARP:Request, x.x.1.1 asks for x.x.1.2  
 2  x.x.1.2   x.x.1.1   ARP:Response, x.x.1.2 at 00-13-72-28-C8-5E  
 3  x.x.1.1   x.x.1.2   TCP:Flags=......S., SrcPort=50206, DstPort=DCE endpoint resolution(135)  
 4  x.x.1.2   x.x.1.1   ARP:Request, x.x.1.2 asks for x.x.1.1  
 5  x.x.1.1   x.x.1.2   ARP:Response, x.x.1.1 at 00-15-5D-42-2E-00  
 6  x.x.1.2   x.x.1.1   TCP:Flags=...A..S., SrcPort=DCE endpoint resolution(135)  
 7  x.x.1.1   x.x.1.2   TCP:Flags=...A...., SrcPort=50206, DstPort=DCE endpoint resolution(135)  
 8  x.x.1.1   x.x.1.2   MSRPC:c/o Bind:  UUID{E1AF8308-5D1F-11C9-91A4-08002B14A0FA} EPT(EPMP)  
 9  x.x.1.2   x.x.1.1   MSRPC:c/o Bind Ack:  Call=0x2  Assoc Grp=0x5E68  Xmit=0x16D0  Recv=0x16D0  
10  x.x.1.1   x.x.1.2   EPM:Request: ept_map: NDR, DRSR(DRSR) {E3514235-4B06-11D1-AB04-00C04FC2DCD2}  [DCE endpoint resolution(135)]  
11  x.x.1.2   x.x.1.1   EPM:Response: ept_map: 0x16C9A0D6 - EP_S_NOT_REGISTERED

At frame **10**, the destination DC queries the source DCs' end-point mapper over port 135 for the Active Directory replication service class UUID {E351...}

In frame **11**, the source DC, in this case a member computer, doesn't yet host the DC role. So it hasn't registered the {E351...} UUID for the Replication service with its local EPM. The source DC responds with symbolic error EP_S_NOT_REGISTERED. This error maps to decimal error 1753, hex error 0x6d9, and friendly error "there are no more endpoints available from the endpoint mapper".

Later, the member computer with IP address x.x.1.2 gets promoted as a replica "MayberryDC" in the `contoso.com` domain. Again, the "replicate now" command is used to trigger replication, but this time fails with the on-screen error "the target principal name is incorrect". The computer whose NIC owns the IP address x.x.1.2 is a domain controller. It's currently booted into normal mode, and has registered the {E351...} replication service UUID with its local EPM. But it doesn't own the name / security identity of DC2, and can't decrypt the Kerberos request from DC1. So the request fails with error "The target principal name is incorrect.". This error maps to decimal error -2146893022, hex error 0x80090322.

Such invalid host-to IP mappings could be caused by stale entries in host / lmhost files, host A / AAAA registrations in DNS or WINS.

Summary:

- Example 1 failed because of an invalid host to IP mapping (in the HOST file in this case). It caused the destination DC to resolve to a "source" DC that didn't have the AD service running (or even installed for that matter). So the replication SPN wasn't yet registered, and the source DC returned error 1753.
- In the second case, an invalid host to IP mapping (again in the HOST file) caused the destination DC to connect to a DC that had registered the {E351...} replication SPN. But that source had a different hostname and security identity than the intended source DC, so the attempts failed with error **-2146893022: The target principal name is incorrect**.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

### Related Content

- [Service overview and network port requirements for the Windows Server system](https://support.microsoft.com/kb/832017/)
- [Restricting Active Directory replication traffic and client RPC traffic to a specific port](https://support.microsoft.com/kb/224196/)
- [How to configure RPC dynamic port allocation to work with firewall](https://support.microsoft.com/kb/154596/)
- [How RPC works](https://msdn.microsoft.com/library/aa373935%28v=VS.85%29.aspx)
- [How to server prepares for a connection](https://msdn.microsoft.com/library/aa373938%28v=VS.85%29.aspx)
- [How the client establishes a connection](https://msdn.microsoft.com/library/aa373937%28v=VS.85%29.aspx)
- [Registering the interface](https://msdn.microsoft.com/library/aa375357%28v=VS.85%29.aspx)
- [Making the Server available on the network](https://msdn.microsoft.com/library/aa373974%28v=VS.85%29.aspx)
- [Registering endpoints](https://msdn.microsoft.com/library/aa375255%28v=VS.85%29.aspx)
- [Listening for client calls](https://msdn.microsoft.com/library/aa373966%28v=VS.85%29.aspx)
- [How the client establishes a connection](https://msdn.microsoft.com/library/aa373937%28v=VS.85%29.aspx)
- [224196](https://support.microsoft.com/help/224196)  Restricting Active Directory replication traffic and client RPC traffic to a specific port
- [SPN for a target DC in AD DS](https://msdn.microsoft.com/library/dd207688%28PROT.13%29.aspx)
