---
title: Troubleshoot replication error 1722
description: Fixes error 1722 of Active Directory replication in Windows Server.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, itaysarig
ms.custom:
- sap:active directory\active directory replication and topology
- pcy:WinComm Directory Services
---
# Active Directory replication error 1722: The RPC server is unavailable

This article helps fix the error 1722 of Active Directory replication.

_Applies to:_ &nbsp; All supported versions of Windows Server  
_Original KB number:_ &nbsp; 2102154

## Symptoms

This article describes the symptoms, cause, and resolution for resolving Active Directory replication failing with Win32 error 1722: "The RPC server is unavailable."

1. DCPROMO Promotion of a replica domain controller (DC) fails to create an NTDS Settings object on the helper DC with error 1722.

    Dialog title text: Active Directory Domain Services Installation Wizard

    Dialog message text:

    ```output
    The operation failed because: Active Directory Domain Services could not create the NTDS Settings object for this Active Directory Domain Controller CN=NTDS Settings,CN=<Name of DC being promoted),CN=Servers,CN=<site name>,CN=Sites,CN=Configuration,DC=<forest root domain> on the remote AD DC <helper DC>.<domain name>.<top level domain>. Ensure the provided network credentials have sufficient permissions. "The RPC server is unavailable."
    ```

1. DCDIAG reports that the Active Directory Replications test has failed with error 1722: "The RPC Server is unavailable."

    ```output
    [Replications Check,<DC Name>] A recent replication attempt failed:
    From <source DC> to <destination DC>  
    Naming Context: <DN path of directory partition>  
    The replication generated an error (1722):  
    The RPC server is unavailable.  
    The failure occurred at <date> <time>.  
    The last success occurred at <date> <time>.  
    <X> failures have occurred since the last success.  
    [<DC name>] DsBindWithSpnEx() failed with error 1722,  
    The RPC server is unavailable..  
    Printing RPC Extended Error Info:  
    <snip>
    ```

1. REPADMIN.EXE reports that the replication attempt has failed with status 1722 (0x6ba).

    REPADMIN commands that commonly cite the -1722 (0x6ba) status include but are not limited to:  

    - `REPADMIN /REPLSUM`
    - `REPADMIN /SHOWREPL`
    - `REPADMIN /SHOWREPS`
    - `REPADMIN /SYNCALL`

    Sample output from `REPADMIN /SHOWREPS` and `REPADMIN /SYNCALL` depicting the error "The RPC server is unavailable" is shown as follows:

    ```console
    c:\> repadmin /showreps  
    <site name><destination DC>  
    DC Options: <list of flags>  
    Site Options: (none)  
    DC object GUID: <NTDS settings object object GUID>  
    DC invocationID: <invocation ID string>  
    ==== INBOUND NEIGHBORS ======================================  
    DC=<DN path for directory partition>  
        <site name><source DC via RPC  
            DC object GUID: <source DCs ntds settings object object guid>  
            Last attempt @ <date> <time> failed, result **1722 (0x6ba):  
    The RPC server is unavailable.  
            <X #> consecutive failure(s).  
            Last success @ <date> <time>
   ```

    Sample output of `REPADMIN /SYNCALL` depicting the error "The RPC server is unavailable" is shown as follows:

   ```console
    C:\>repadmin /syncall  
    CALLBACK MESSAGE: Error contacting server \<object guid of NTDS Settings object>._msdcs.\<forest root domain>.\<top level domain> (network error): 1722 (0x6ba):  
    The RPC server is unavailable.
   ```

1. The **replicate now** command in Active Directory Sites and Services returns "The RPC server is unavailable."

    Right-clicking the connection object from a source DC and choosing **replicate now** fails with "The RPC server is unavailable." The on-screen error message is shown as follows:

    Dialog title text: Replicate Now

    Dialog message text:

    > The following error occurred during the attempt to synchronize naming context \<DNS name of directory partition> from domain controller \<source DC host name> to domain controller \<destination DC hostname>:The RPC server is unavailable. This operation will not continue. This condition may be caused by a DNS lookup problem. For information about troubleshooting common DNS lookup problems, see the following Microsoft Web site: [DNS Lookup Problem](https://go.microsoft.com/fwlink/?LinkId=5171)

1. NTDS Knowledge Consistency Checker (KCC), NTDS General, or Microsoft-Windows-ActiveDirectory_DomainService events with the 1722 status are logged in the directory service event log.

    Active Directory events that commonly cite the 1722 status include but are not limited to:

    |Event source|Event ID|Event string|
    |---|---|---|
    |Microsoft-Windows-ActiveDirectory_DomainService|1125|The Active Directory Domain Services Installation Wizard (Dcpromo) was unable to establish connection with the following domain controller.|
    |NTDS KCC|1311|The Knowledge Consistency Checker (KCC) has detected problems with the following directory partition.|
    |NTDS KCC|1865|The Knowledge Consistency Checker (KCC) was unable to form a complete spanning tree network topology. As a result, the following list of sites cannot be reached from the local site.|
    |NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed.|
    |NTDS Replication|1960|Internal event: The following domain controller received an exception from a remote procedure call (RPC) connection. The operation may have failed.|

## Cause

RPC is an intermediate layer between the network transport and the application protocol. RPC itself has no special insight into failures but attempts to map lower-layer protocol failures into an error at the RPC layer.

RPC error 1722/0x6ba/RPC_S_SERVER_UNAVAILABLE is logged when a lower-layer protocol reports a connectivity failure. The common case is that the abstract TCP CONNECT operation failed. In the context of AD replication, the RPC client on the destination DC was not able to successfully connect to the RPC server on the source DC. Common causes of this are:

- Link local failure
- DHCP failure
- DNS failure
- WINS failure
- Routing failure (including blocked ports on firewalls)
- IPSec/Network authentication failures
- Resource limitations
- Higher-layer protocol not running
- Higher-layer protocol returning this error

## Resolution

Basic troubleshooting steps to identify the problem.

### Verify the ClientProtocols key exists under HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc and that it contains the correct default protocols

|Protocol name|Type|Data value|
|---|---|---|
| ncacn_http| REG_SZ| rpcrt4.dll|
| ncacn_ip_tcp| REG_SZ| rpcrt4.dll|
| ncacn_np| REG_SZ| rpcrt4.dll|
| ncacn_ip_udp| REG_SZ| rpcrt4.dll|
  
If the **ClientProtocols** key or any of the four default values are missing, import the key from a known good server.

### Verify DNS is working

Domain Name System (DNS) lookup failures are the cause of a large number of 1722 RPC errors when it comes to replication.

There are a few tools to use to help identify DNS errors:

- `DCDIAG /TEST:DNS /V /E /F:<filename.log>`  

    The `DCDIAG /TEST:DNS` command can validate DNS health of Windows 2000 Server (SP3 or later), Windows Server 2003, and Windows Server 2008 family domain controllers. This test was first introduced with Windows Server 2003 Service Pack 1.

    There are seven test groups for this command.

  - Authentication (Auth)
  - Basic (`Basc`)
  - Records registration (RReg)
  - Dynamic update (`Dyn`)
  - Delegations (Del)
  - Forwarders/Root hints (Forw)

    Sample output:

    ```output
    TEST: Authentication (Auth)  
    Authentication test: Successfully completed

    TEST: Basic (Basc)  
    Microsoft(R) Windows(R) Server 2003, Enterprise Edition (Service Pack level: 2.0) is supported  
    NETLOGON service is running  
    kdc service is running  
    DNSCACHE service is running  
    DNS service is running  
    DC is a DNS server  
    Network adapters information:  
    Adapter [00000009] Microsoft Virtual Machine Bus Network Adapter:  
    MAC address is 00:15:5D:40:CF:92  
    IP address is static  
    IP address: <IP Address>  
    DNS servers:  
    <DNS IP Address> (DC.domain.com.) [Valid]  
    The A record for this DC was found  
    The SOA record for the Active Directory zone was found  
    The Active Directory zone on this DC/DNS server was found (primary)  
    Root zone on this DC/DNS server was not found  
    <omitted other tests for readability>
    ```

    Summary of DNS test results:

    ```output
    Auth Basc Forw Del  Dyn  RReg Ext

    Domain: fragale.contoso.com
    DC1 PASS PASS FAIL PASS PASS PASS n/a  
    Domain: child.fragale.contoso.com  
    DC2 PASS PASS n/a  n/a  n/a  PASS n/a  
    
    Enterprise DNS infrastructure test results:  
    For parent domain domain.com and subordinate domain child:  
    Forwarders or root hints are not misconfigured from parent domain to subordinate domain  
    Error: Forwarders are configured from subordinate to parent domain but some of them failed DNS server tests  
    
    (See DNS servers section for error details)  
    Delegation is configured properly from parent to subordinate domain  
    ......................... domain.com failed test DNS
    ```

    The summary provides remediation steps for the more common failures from this test.

    Explanation and additional options for this test can be found at [Domain Controller Diagnostics Tool (dcdiag.exe)](/previous-versions/windows/it-pro/windows-server-2003/cc776854(v=ws.10)).

- `NLTEST /DSGETDC:<netbios or DNS domain name>`

    `Nltest /dsgetdc` is used to exercise the DC locator process. Thus `/dsgetdc:<domain name>` tries to find the domain controller for the domain. Using the force flag forces domain controller location rather than using the cache. You can also specify options such as **/gc** or **/pdc** to locate a Global Catalog or a primary domain controller emulator. To find the Global Catalog, you must specify a _tree name_, which is the DNS domain name of the root domain.

    Sample output:

    ```output
    DC: [\DC.fabrikam.com]  
    Address: \\<IP Address>  
    Dom Guid: 5499c0e6-2d33-429d-aab3-f45f6a06922b  
    Dom Name: fabrikam.com  
    Forest Name: fabrikam.com  
    Dc Site Name: Default-First-Site-Name  
    Our Site Name: Default-First-Site-Name  
    Flags: PDC GC DS LDAP KDC TIMESERV WRITABLE DNS_DC DNS_DOMAIN DNS_FOREST CLOSE_SITE  
    The command completed successfully
    ```

- `Netdiag -v`

    It can be used with Windows 2003 and earlier versions to gather specific information for networking configuration and error. This tool takes some time to run when executing the `-v` switch.

    Sample output for the DNS test:

    ```output
    DNS test . . . . . . . . . . . . . : Passed  
    Interface {34FDC272-55DC-4103-B4B7-89234BC30C4A}  
    DNS Domain:  
    DNS Servers: <DNS Server IP address>  
    IP Address:         Expected registration with PDN (primary DNS domain name):  
    Hostname: DC.fabrikam.com.  
    Authoritative zone: fabrikam.com.  
    Primary DNS server: DC.fabrikam.com <IP Address>  
    Authoritative NS:<IP Address>  
    Check the DNS registration for DCs entries on DNS server <DNS Server IP address>  
    The Record is correct on DNS server '<DNS Server IP address>'.  
    (You will see this line repeated several times for every entry for this DC.  Including srv records.)  
    The Record is correct on DNS server '<DNS Server IP address>'.  
    PASS - All the DNS entries for DC are registered on DNS server '<DNS Server IP address>'.
    ```

- `ping -a <IP_of_problem_server>`

    It's a simple, quick test to validate the host record for a domain controller is resolving to the correct machine.  

- `dnslint /s IP /ad IP`

    DNSLint is a Windows utility that helps you to diagnose common DNS name resolution issues. The output is an HTM file with much information, including:

    **DNS server: localhost**

    ```output
    IP Address: 127.0.0.1  
    UDP port 53 responding to queries: YES  
    TCP port 53 responding to queries: Not tested  
    Answering authoritatively for domain: NO
    ```

    **SOA record data from the server:**

    ```output
    Authoritative name server: DC.domain.com  
    Hostmaster: hostmaster  
    Zone serial number: 14  
    Zone expires in: 1.00 day(s)  
    Refresh period: 900 seconds  
    Retry delay: 600 seconds  
    Default (minimum) TTL: 3600 seconds
    ```

- Additional authoritative (NS) records from the server: `DC2.fabrikam.com <IP Address>`

    **Alias (CNAME) and glue (A) records for forest GUIDs from the server:**

  - CNAME: 98d4aa0c-d8e2-499a-8f90-9730b0440d9b._msdcs.fabrikam.com
    - Alias: `DC.fabrikam.com`
    - Glue: \<IP Address>

  - CNAME: a2c5007f-7082-4adb-ba7d-a9c47db1efc3._msdcs.fabrikam.com
    - Alias: `dc2.child.fabrikam.com`
    - Glue: \<IP Address>

    For more information, see the [Description of the DNSLint utility](https://support.microsoft.com/kb/321045).

### Verify network ports are not blocked by a firewall or third-party application listening on the required ports

The endpoint mapper (listening on port 135) tells the client which randomly assigned port a service (FRS, AD replication, MAPI, and so on) is listening on.

Refer to the list of required ports in [How to configure a firewall for Active Directory domains and trusts](config-firewall-for-ad-domains-and-trusts.md).

Portqry can be used to identify if a port is blocked from a DC when targeting another DC. It can be downloaded at [PortQry Command Line Port Scanner Version 2.0](https://www.microsoft.com/download/details.aspx?id=17148).

Example syntax:

- `portqry -n <problem_server> -e 135`
- `portqry -n <problem_server> -r 1024-5000`

A graphical version of portqry, called Portqryui, can be found at [PortQryUI - User Interface for the PortQry Command Line Port Scanner](https://www.microsoft.com/download/details.aspx?id=24009).

If the Dynamic Port range has ports being blocked, use the following links to configure a port range that is manageable for the customer.

Additional important links for configuration and working with firewalls and domain controllers:

- [How to configure RPC dynamic port allocation to work with firewalls](https://support.microsoft.com/help/154596)
- [Restricting Active Directory RPC traffic to a specific port](https://support.microsoft.com/help/224196)
- [How to configure a firewall for Active Directory domains and trusts](https://support.microsoft.com/help/179442)
- [A list of the Windows Server domain controller default ports](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd772723(v=ws.10))
- [Port requirements for the Microsoft Windows Server system](https://support.microsoft.com/help/832017)

### Bad NIC drivers

See network card vendors or OEMs for the latest drivers.

### UDP fragmentation can cause replication errors that appear to have a source of RPC server is unavailable

Event ID 40960 and 40961 errors with a source of LSASRV are common for this particular cause.

For more information, see [How to force Kerberos to use TCP instead of UDP in Windows](https://support.microsoft.com/help/244474).

### SMB signing mismatches between DCs

Using the **Default Domain Controllers Policy** to configure consistent settings for SMB Signing under the following section will help address this cause:

`Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options`

- `Microsoft network client: Digitally sign communications (always) Disabled`.
- `Microsoft network client: Digitally sign communications (if server agrees) Enabled`.
- `Microsoft network server: Digitally sign communications (always) Disabled`.
- `Microsoft network server: Digitally sign communications (if client agrees) Enabled`.

The settings can be found under the following registry keys:

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManWorkstation\Parameters` and `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters`

  - RequireSecuritySignature = always (0 = disable, 1 = enable).
  - EnableSecuritySignature = if server agrees (0 = disable, 1 = enable).

Additional troubleshooting:

If the preceding methods don't provide a solution to the 1722 error, use the following diagnostic logging to gather more information:

```output
Windows Server 2003 SP2 computers logs extended RPC Server info in NTDS Replication events 1960, 1961, 1962 and 1963.  
Crank up NTDS Diagnostic logging

1 = basic, 2 and 3 add continually verbose info and 5 logs extended info.
```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).

## References

- [RPC Return Values](/windows/win32/rpc/rpc-return-values)
- [Understanding Extended Error Information](/windows/win32/rpc/understanding-extended-error-information)
- [Extended error information detection locations](/windows/win32/rpc/extended-error-information-detection-locations)
- [Enabling extended error information](/windows/win32/rpc/enabling-extended-error-information)
- [Network Connectivity](/previous-versions/windows/it-pro/windows-2000-server/cc961803(v=technet.10))
