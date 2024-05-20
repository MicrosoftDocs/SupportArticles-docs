---
title: Errors when you run DCDIAG commands
description: Fixes errors that occur when you run DCDIAG.EXE /E or /A or /C commands.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\DCPromo and the installation or removal of domain controllers, csstroubleshoot
---
# DCDIAG.EXE /E or /A or /C expected errors

This article helps fix errors that occur when you run DCDIAG.EXE `/E` or `/A` or `/C` commands.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2512643

## Symptoms

Consider the following scenario:

You administer an AD environment. There may be a mixture of Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and Windows Server 2008 R2 DCs.

When running `DCDIAG.EXE /E` (or `/A` or `/C`) on Windows Server 2008 or Windows Server 2008 R2 (included with the operating systems), you see the following errors against all Windows Server 2003 DCs:

> Starting test: Services  
            Invalid service type: RpcSs on DCDIAG-2003, current value  
            WIN32_OWN_PROCESS, expected value WIN32_SHARE_PROCESS  
         ......................... DCDIAG-2003 failed test Services

When running `DCDIAG.EXE /E` (or `/A` or `/C`) on Windows Server 2008 or Windows Server 2008 R2 (included with the operating systems), you see the following errors against all Win2008 and Win2008 R2 DCs:

> Starting test: FrsEvent  
         The event log File Replication Service on server  
         dcdiag-2008.margiestravel.com could not be queried, error 0x6ba  
         "The RPC server is unavailable."  
         ......................... dcdiag-2008 failed test FrsEvent

> Starting test: DFSREvent  
         The event log DFS Replication on server  
         dcdiag-2008r2.margiestravel.com could not be queried, error 0x6ba  
         "The RPC server is unavailable."  
         ......................... dcdiag-2008r2 failed test DFSREvent

> Starting test: KccEvent  
         The event log Directory Service on server  
         dcdiag-2008.margiestravel.com could not be queried, error 0x6ba  
         "The RPC server is unavailable."  
         ......................... dcdiag-2008 failed test KccEvent

> Starting test: SystemLog  
         The event log System on server  
         dcdiag-2008.margiestravel.com could not be queried, error 0x6ba  
         "The RPC server is unavailable."  
         ......................... dcdiag-2008 failed test SystemLog  

When running `DCDIAG.EXE /E`  (or /A or /C) on Windows Server 2003 (included with the Support Tools out-of-band install):

- No errors are logged for any of the DCs, regardless of OS.  

When running `DCDIAG.EXE /C` (which includes `/test:verifyenterprisereferences`) on Windows Server 2008 or Windows Server 2008 R2, and the Domain Functional Mode is Windows Server 2008 or higher, and FRS is still being used to replicate SYSVOL, you see the following errors:

> Starting test: VerifyEnterpriseReferences  
    The following problems were found while verifying various important DN references.  Note, that  these problems  
    can be reported because of latency in replication.  So follow up to resolve the following problems, only if  
    the same problem is reported on all DCs for a given domain or if  the problem persists after replication has  
    had reasonable time to replicate changes.  
       [1] Problem: Missing Expected Value  
        Base Object: CN=SRV-01,OU=Domain Controllers,DC=margiestravel,DC=com  
        Base Object Description: "DC Account Object"  
        Value Object Attribute Name: msDFSR-ComputerReferenceBL  
        Value Object Description: "SYSVOL FRS Member Object"  
        Recommended Action: See Knowledge Base Article: Q312862  
       [2] Problem: Missing Expected Value  
        Base Object: CN=SRV-02,OU=Domain Controllers,DC=margiestravel,DC=com  
        Base Object Description: "DC Account Object"  
        Value Object Attribute Name: msDFSR-ComputerReferenceBL  
        Value Object Description: "SYSVOL FRS Member Object"  
        Recommended Action: See Knowledge Base Article: Q312862  
       LDAP Error 0x20 (32) - No Such Object.  
    ......................... SRV-01 failed test VerifyEnterpriseReferences  

When running `DCDIAG.EXE /C` (which includes `/test:outboundsecurechannels`) and you specify `/testdomain:<your trusted domain>` on Windows Server 2008, or on Windows Server 2008 R2 you see the following errors:

> Testing server: Default-First-Site-Name\SRV-01  
 Starting test: OutboundSecureChannels  
 [SRV-01] Does not have downlevel trust object for [contoso.com]  
 [SRV-01] Does not have uplevel trust object for [contoso.com]  
 [SRV-02] Does not have downlevel trust object for [contoso.com]  
 [SRV-02] Does not have uplevel trust object for [contoso.com]  
 ......................... SRV-01 failed test OutboundSecureChannels

## Cause

All of these behaviors are expected.

- The Windows Server 2008/200R2 versions of DCDIAG are designed to test RPCSS for the Windows Server 2008 shared process setting -not the previous isolated process setting used in Windows Server 2003 and older operating systems. The tool doesn't distinguish between OSs for this service.

- The Windows Server 2008/200R2 versions of DCDIAG assume that a Windows Server 2008 domain functional level means the DCs are replicating SYSVOL with DFSR.

- The Windows Server 2008/200R2 versions of DCDIAG don't correctly test trust health

- Windows Server 2008/2008 R2 doesn't allow remote connectivity to the event log based on default firewall rules.

- The Windows Server 2003 version of DCDIAG doesn't report back an error if it can't connect to the event log; it only reports if it connects and finds errors.

- The Windows Server 2003 version of DCDIAG doesn't test the RPCSS service configuration.

## Resolution

There are multiple workarounds to these issues:

- Ignore all these errors when running DCDIAG.

- To stop the event log-related errors, enable the built-in incoming firewall rules on DCs so that the event logs can be accessed remotely:

   >**Remote Event Log Management (NP-In)  
    Remote Event Log Management (RPC)  
    Remote Event Log Management (RPC-EPMAP)**  
   >
   > This can be done through the "Windows Firewall with Advanced Security" snap-in (**WF.MSC**), using the firewall group policy (**Computer Configuration\ Policies\ Windows Settings\ Security Settings\ Windows Firewall with Advanced Security**), or by using `NETSH.EXE ADVFIREWALL`.
- To stop the RPCSS service error, you can opt out of the test with `/SKIP:SERVICES`. There are caveats to this, see More Information. It's better to ignore this specific error altogether when it's returned from Win2003 DCs.

    It's expected and normal for this service's behavior type to be 0x10 (isolated) on Windows Server 2003 and 0x20 (shared) on Windows Server 2008 and later. Don't change it based on what DCDIAG says unless you're running the version of DCDIAG that goes with that OS. Between Windows Server 2003 and Windows Server 2008, the behavior changed for the RPC service, but there was nothing yet to share in that svchost.exe process. In Windows Server 2008 R2, the new RPCEptMapper service was added to that shared svchost process. You can see who would launch in that same process by looking for this value in the service registry keys:  
    `%systemroot%\system32\svchost.exe -k RPCSS.`  
    Do not change the service type on Windows Server 2003 to stop the error. There may be unexpected issues long-term as this isn't a tested  configuration. These issues would be difficult to identify or trace back to this root cause.
    Long-term solution to the RPCSS service issue: replace the remaining Windows Server 2003 servers with a later operating system.

- To stop the OutboundSecureChannels errors, use `/skip:outboundsecurechannels`. The tests aren't valid and can be instead tested with `NETDOM.EXE` and `NLTEST.EXE`.

- To stop the VerifyEnterpriseReferences errors, migrate your SYSVOL from FRS to DFSR. Since you are using a native Windows Server 2008 or later domain, FRS is no longer recommended for SYSVOL replication and nothing is preventing you from replacing the deprecated FRS system. See [https://technet.microsoft.com/library/dd640019.aspx](https://technet.microsoft.com/library/dd640019.aspx).

## More information

The Windows Server 2008/2008 R2 DCDIAG **Services** test checks for the following services to be running, configured with default start options, and configured with default process types:
> [!Note]
> These are the true service names in the registry under HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services

> RPCSS - Start Automatically - Shared Process  
EVENTSYSTEM - Start Automatically - Shared Process  
DNSCACHE - Start Automatically - Shared Process  
NTFRS - Start Automatically - Own Process  
ISMSERV - Start Automatically - Shared Process  
KDC - Start Automatically - Shared Process  
SAMSS - Start Automatically - Shared Process  
SERVER - Start Automatically - Shared Process  
WORKSTATION - Start Automatically - Shared Process  
W32TIME - Start Manually or Automatically - Shared Process  
NETLOGON - Start Automatically - Shared Process  
(If domain functional level is Windows Server 2008 or later)  
DFSR - Start Automatically - Own Process  
(If target is Windows Server 2008 or later)  
NTDS - Start Automatically - Shared Process  
(If using SMTP-based AD replication)  
IISADMIN - Start Automatically - Shared Process  
SMTPSVC - Start Automatically - Shared Process
