---
title: Windows updates add new NTLM pass-through authentication protections
description: Describes the new NTLM pass-through authentication protections for CVE-2022-21857 introduced in Windows updates.
ms.date: 03/31/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, ptomas, jsimmons, lindakup, arrenc, rizhang, clfish, herbertm, ruudv
ms.custom: sap:legacy-authentication-ntlm, csstroubleshoot
ms.technology: windows-server-security
---
# Windows updates add new NTLM pass-through authentication protections for CVE-2022-21857

_Original KB number:_ &nbsp; 5010576

After you install the January 11, 2022 Windows updates or later Windows updates containing protections for [CVE-2022-21857](https://msrc.microsoft.com/update-guide/en-US/vulnerability/CVE-2022-21857), domain controllers (DCs) will enforce new security checks for NTLM pass-through authentication requests sent by a trusting domain over a domain or forest trust, or sent by a read-only domain controller (RODC) over a secure channel trust. The new security checks require that the domain or client being authenticated be appropriate for the trust being used. Specifically, security checks appropriate for the trust type being used will reject NTLM pass-through authentication request if the following requirements aren't satisfied:

- The requests over a domain trust must use the same domain name as the trusting domain.
- The requests over a forest trust must use a domain name that is a member of the trusting forest, and doesn't have a name collision from other forests.
- The requests forwarded by an RODC must use a client name that the RODC has been previously authorized to cache secrets for.

To support the domain and forest trust validations, the Primary Domain Controller (PDC) of the root domain in each forest is updated to periodically issue Lightweight Directory Access Protocol (LDAP) queries. The queries are issued every eight hours for all domain names in each trusting forest, which is called "trust scanning". These domain names are stored in the `msDS-TrustForestTrustInfo` attribute of the corresponding trusted domain object (TDO).

## Prerequisites

As new trust scanning behaviors are added by the updates, anything that blocks LDAP activity traffic, authentication and authorization from a trusted forest's PDC to the trusting forest will cause a problem:

- If firewalls are used, TCP and UDP ports 389 need to be allowed between the trusted PDC and trusting domain DCs, as well as the communication to operate the trust (name resolution, RPC for NTLM and port 88 for Kerberos).  
- The PDC of the trusted forest also needs the **Access this computer from the network** user right to authenticate to the trusting domain DCs.  By default, "authenticated users" have the user right that includes the trusted domain PDC.  
- The PDC in the trusted domain must have sufficient read permissions to the trusting forest partitions container in the configuration NC and the children objects. By default, "authenticated users" have the access, which applies to the calling trusted domain PDC.
- When selective authentication is enabled, the PDC in the trusted forest must be granted the **Allowed to authenticate** permission to the trusting forest DC computer accounts to protect the trusting forests.

If a trusting forest doesn't allow the trusted forest to query trust information, the trusting forest may be at risk of NTLM relay attacks.  

For example, forest A trusts forest B, and forest C trusts forest B. If forest A refuses to allow authentication or LDAP activity from the root domain in forest B, then forest A is at risk of an NTLM relay attack from a malicious or compromised forest C.

## New events

The following events are added as parts of the protections for CVE-2022-21857, and are logged in the system event log.

### Netlogon service related events

By default, the Netlogon service throttles events for the warnings and error conditions, which means it doesn't log per-request warnings or failure events. Instead, summary events (Netlogon event ID 5832 and Netlogon event ID 5833) are logged once per day for NTLM pass-through authentications that are either blocked by the new security checks introduced in this update, or should have been blocked but were allowed due to the presence of an admin-configured exemption flag.
  
If either Netlogon event ID 5832 or Netlogon event ID 5833 is logged and you need more information, disable the event throttling by creating and setting the `ThrottleNTLMPassThroughAuthEvents` REG_DWORD value to zero in the following registry path：

`HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`

> [!NOTE]
> This setting takes effect immediately without a system or service restart, and it isn't under the control of a Group Policy Object (GPO).

|Netlogon event ID  |Event message text  |Notes  |
|---------|---------|---------|
|5832     |The Netlogon service allowed one or more unsecure pass-through NTLM authentication requests from trusted domains and/or forests during the most recent event throttling window. These unsecure requests would normally be blocked but were allowed to proceed due to the current trust configuration. <br>Warning: Allowing unsecure pass-through authentication requests will expose your Active Directory forest to attack. <br>For more information about this issue, please visit `https://go.microsoft.com/fwlink/?linkid=276811`.<br>Count of unsecure requests allowed due to administrative override: \<Count Number>|This warning event logs the number of unsecure pass-through authentications that were allowed due to the presence of an admin-configured exemption flag.         |
|5833     |The Netlogon service blocked one or more unsecure pass-through NTLM authentication requests from trusted clients, domains, and/or forests during the most recent event throttling window. For more information about this issue, including how to enable more verbose logging, please visit `https://go.microsoft.com/fwlink/?linkid=276811`.<br>Count of unsecure requests blocked: \<Count Number>|This warning event logs the number of unsecure pass-through authentications that were blocked.         |
|5834     |The Netlogon service allowed an unsecure pass-through NTLM authentication request from a trusted client, domain, or forest. This unsecure request would normally be blocked but was allowed to proceed due to the current trust configuration.<br>Warning: Allowing unsecure pass-through authentication requests will expose your Active Directory forest to attack. For more information about this issue, please visit `https://go.microsoft.com/fwlink/?linkid=276811`.<br>Account name: \<Account Name><br>Trust name: \<Trust Name><br>Trust type: \<Trust Type><br>Client IP Address: \<Client IP Address><br>Block reason: \<Block Reason><br>Resource server Netbios name: \<Resource Server Netbios Name><br>Resource server DNS name: \<Resource Server DNS Name><br>Resource domain Netbios name: \<Resource Domain Netbios Name><br>Resource domain DNS name: \<Resource Domain DNS Name>|This warning event is only logged when the Netlogon event throttling has been disabled. It logs a specific pass-through authentication request that was allowed due to an admin-configured exemption flag.         |
|5835     |The Netlogon service blocked an unsecure pass-through NTLM authentication request from a trusted client, domain, or forest. For more information, please visit `https://go.microsoft.com/fwlink/?linkid=276811`.<br>Account name: \<Account Name><br>Trust name: \<Trust Name><br>Trust type: \<Trust Type><br>Client IP Address: \<Client IP Address><br>Block reason: \<Block Reason><br>Resource server Netbios name: \<Resource Server Netbios Name><br>Resource server DNS name: \<Resource Server DNS Name><br>Resource domain Netbios name: \<Resource Domain Netbios Name><br>Resource domain DNS name: \<Resource Domain DNS Name>|This warning event is only logged when the Netlogon event throttling has been disabled. It logs a specific pass-through authentication request that was blocked.         |

### Local Security Authority (LSA) related events

> [!NOTE]
> These events are not throttled.

|LSA event ID  |Event message text  |Notes  |
|---------|---------|---------|
|6148     |The PDC completed an automatic trust scan operation for all trusts with no errors. More information can be found at `https://go.microsoft.com/fwlink/?linkid=2162089`.|This informational event is expected to show up periodically every eight hours.         |
|6149     |The PDC completed an automatic trust scan operation for all trusts and encountered at least one error. More information can be found at `https://go.microsoft.com/fwlink/?linkid=2162089`.|This warning event should be investigated, especially if it shows up every eight hours.         |
|6150     |The PDC completed an administrator-requested trust scan operation for the trust '\<Trust Name>' with no errors. More information can be found at `https://go.microsoft.com/fwlink/?linkid=2162089.`|This informational event is used to track when administrators manually invoke the PDC trust scanner by using the `netdom trust <Local Forest> /Domain:* /InvokeTrustScanner` cmdlet.         |
|6151     |The PDC was unable to find the specified trust '\<Trust Name>' to scan. The trust either does not exist or it is neither an inbound or bidirectional trust. More information can be found at `https://go.microsoft.com/fwlink/?linkid=2162089`.|This warning event tracks when administrators manually invoke the PDC trust scanner by using a bad forest name.         |
|6152     |The PDC completed an administrator-requested trust scan operation for the trust '\<Trust Name>' and encountered an error. More information can be found at `https://go.microsoft.com/fwlink/?linkid=2162089`.|This warning event tracks when administrators manually invoke the PDC trust scanner (for all trusts) by running the `netdom trust <Local Forest> /Domain:* /InvokeTrustScanner` cmdlet, and the operation fails.|
|6153     |The PDC encountered an error trying to scan the named trust. Trust: \<Trust Name>Error: \<Error Message>More information can be found at `https://go.microsoft.com/fwlink/?linkid=2162089`.|This warning event is a complement to the previous event and includes an error code. It is logged during scheduled trust scans that occur every eight hours.         |

When an error code is included in some of the failure related events, you need to enable tracing for further investigations.

## Improvements to Netlogon logging and LSA logging

Netlogon logging (*%windir%\\debug\\netlogon.log*) and LSA logging (*lsp.log*) are updated to support the improvements in the updates.

### Enable and disable Netlogon logging (netlogon.log)

- To enable Netlogon logging, run the following command:

    ```console
    nltest /dbflag:2080ffff
    ```

- To disable Netlogon logging after the investigations, run the following command:

    ```console
    nltest /dbflag:0
    ```

### Enable and disable LSA logging (lsp.log) by using PowerShell

- To enable LSA logging, run the following cmdlets:

    ```powershell
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LspDbgInfoLevel -Value 0x1820000 -Type dword -Force 
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LspDbgTraceOptions -Value 0x1 -Type dword -Force

    ```

- To disable LSA logging, run the following cmdlets:

    ```powershell
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LspDbgInfoLevel -Value 0x0 -Type dword -Force 
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name LspDbgTraceOptions -Value 0x0 -Type dword -Force

    ```

### Enable and disable LSA logging (lsp.log) by using reg.exe (for legacy operating system with no PowerShell)

- To enable LSA logging, run the following reg commands:

    ```console
    reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /V LspDbgTraceOptions /t REG_DWORD /d 1 /f 
    reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /V LspDbgInfoLevel /t REG_DWORD /d 0x1820000 /f
    ```

- To disable LSA logging, run the following reg commands:

    ```console
    reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /V LspDbgTraceOptions /t REG_DWORD /d 0 /f 
    reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa /V LspDbgInfoLevel /t REG_DWORD /d 0x0 /f
    ```

## Improvements to nltest.exe and netdom.exe tools

The *nltest.exe* and *netdom.exe* tools are updated to support the improvements in this update.

### Nltest.exe improvements

The *nltest.exe* tool can query and display all records in a `msDS-TrustForestTrustInfo` attribute of a trusted domain object by using the following command:

```console
nltest.exe /lsaqueryfti:<Trusting Forest Name>
```

Here's an example with the output:

```console
C:\Windows\System32>nltest.exe /lsaqueryfti:contoso.com 
TLN: contoso.com 
Dom: contoso.com 
Scan: contoso.com Sid:(null) Flags:0x0 
The command completed successfully
```

> [!NOTE]
> The term "Scan" in the output refers to a new "Scanner" record type which persists during the PDC trust scanner operations.

### Netdom.exe improvements

The netdom.exe tool can initiate the new PDC trust scanner operations, and set a security check exemption flag for a specific trusting domain or a specific child domain in a trusting forest.

- Initiate the PDC trust scanner operations.

  - For all trusting forests, run the following commands:

    ```console
    netdom trust <Local Forest> /Domain:* /InvokeTrustScanner
    ```

  - For a specific trusting forest, run the following commands:

    ```console
    netdom trust <Local Forest> /Domain:<Trusting Forest> /InvokeTrustScanner
    ```

     > [!NOTE]
     > This command must be run locally on the PDC of the local forest.

  This command can only initiate the operation. To find out the result, look in the system event log for the new LSA events, and enable LSA tracing if needed.

- Set security check exemption flag.

  - For a specific trusting domain (domain trust case), the flag is defined as follows:

    `#define TRUST_ATTRIBUTE_DISABLE_AUTH_TARGET_VALIDATION 0x00001000`

    This operation sets or clears a new trust attribute flag on the trusted domain object (TDO) for the trusting domain. For more information, see the [Issue mitigations](#issue-mitigations) section.
  - For a specific trusting child domain (forest trust case), the flag is defined as follows:

    `#define LSA_SCANNER_INFO_DISABLE_AUTH_TARGET_VALIDATION ( 0x00000001L )`

    The command is as follows:

    ```console
    netdom trust <localdomain> /Domain:<trustingforest> [[/AuthTargetValidation[:{yes | no}] /ChildDomain:<childdomain>
    ```

     > [!NOTE]
     > If `/AuthTargetValidation` isn't specified, the default value is 'yes'.

    This operation sets or clears a new LSA forest trust record flag on the Scanner record for the specific child domain from the specific trusting forest. The operation provides a way to constrain the scope of the exemption to just that domain name. For more information, see the [Issue mitigations](#issue-mitigations) section.

## Investigating failed NTLM pass-through authentications

> [!NOTE]
> Before you follow these steps, make sure your configuration meets the requirements as described in the [Prerequisites](#prerequisites) section.

Here are the basic steps:
  
1. Enable Netlogon and LSA logging on all involved DCs.
2. Reproduce the problem.
3. Disable Netlogon and LSA logging.
4. Search for the following terms in the *netlogon.log* file, and review any log entries that describe the failures:

    - "LsaIFilterInboundNamespace"
    - "NlpValidateNTLMTargetInfo"
    - "NlpVerifyTargetServerRODCCachability"
    - "ResourceDomainNameCollidesWithLocalForest"
  
5. Search for the term "LsaDbpFilterInboundNamespace" in the *lsp.log* file, and review any log entries that describe the failures.

> [!NOTE]
> For a failed authentication over a forest trust, use the new nltest.exe option to dump all the new records persisted by the PDC trust scanner.

## Investigating failed PDC trust scanner operations

> [!NOTE]
> Before you follow these steps, make sure your configuration meets the requirements as described in the [Prerequisites](#prerequisites) section.

Here are the basic steps:
  
1. Enable LSA logging on the PDC.

    For specific trust scanner operations, this tracing may be restricted to the TRACE_LEVEL_LSP_FOREST_SCANNER flag.
2. Reproduce the problem by using the new *netdom.exe* `/InvokeTrustScanner` functionality.
3. Disable LSA logging.
4. Search the *lsp.log* file for the term "fail" or "failed", and review the log entries.

The trust scanner may fail with the following reasons:

- Permissions are missing on the partitions container.
- The firewall ports needed between DCs and between members and DCs aren't open. Here are the firewall ports:

  - UDP+TCP/389
  - TCP/88
  - UDP+TCP/53

## Issue mitigations

If authentications fail due to domain name collisions, misconfiguration, or unforeseen circumstances, use the following options to mitigate the issue:

- Rename the colliding domain(s) to prevent collision.
- Temporarily set exemption flags on the corresponding TDOs, or on the Scanner records in the `msDS-TrustForestTrustInfo` attribute. It's a temporary method until the domain renaming prevents the issue.

If authentications over an RODC secure channel trust fail, contact Microsoft support for this issue because there are no mitigation methods.

If PDC trust scanner fails, the mitigation depends on specific context. For example, DCs in a trusted forest aren't granted LDAP query permissions to the Configuration naming context (NC) of the trusting forest. The mitigation is to grant the permissions.

## Frequently asked questions (FAQs)

- Q1: Is the frequency of the PDC trust scanner configurable?

    A1: No.
- Q2: Will the PDC trust scanner be automatically invoked upon creation of a new forest trust?

    A2: No. Administrators can invoke it manually if needed, otherwise the new forest will be scanned at the next regular interval.
- Q3: Can the new Scanner records be modified by domain administrators?

    A3: Yes, but it isn't recommended or supported except when the new exemption flag (LSA_SCANNER_INFO_DISABLE_AUTH_TARGET_VALIDATION) needs to be set by using the *netdom.exe* tool. If Scanner records are created, modified, or deleted unexpectedly, the PDC trust scanner will revert the changes the next time it runs.
- Q4: I'm sure that NTLM isn't used in my environment. How can I turn off this behavior?

    A4: In general, the new behaviors can't be turned off. The RODC specific security validations can't be disabled. You can set a security check exemption flag for a domain trust case or a forest trust case.
- Q5: Do I need to make any configuration changes before installing this update?

    A5: Maybe. Make sure your configuration meets the requirements as described in the [Prerequisites](#prerequisites) section.
- Q6: Do I need to patch my DCs in any specific order for this update to take effect?

    A6:  All variations of patching order are supported. The new PDC trust scanner operation takes effect only after the PDC is patched. All patched DCs will immediately start enforcing the RODC restrictions. Patched non-PDCs won't enforce NTLM pass-through restrictions until the PDC is patched and starts creating new scanner records in the msDS-TrustForestTrustInfo attributes. Non-patched DCs (non-PDC) will ignore the new scanner records once present.
- Q7: When will my forest be secure?

    A7: Your forest will be secure once all DCs in all domains have this update installed. Trusting forests will be secure once the PDC trust scanner has completed at least one successful operation, and replication has succeeded.
- Q8: I don't control my trusting domains or forests. How can I ensure my forest is secure?

    A8: See the previous question. The security of your forest doesn't depend on the patching status of any trusting domains or forests. We recommend all customers patch their DCs. In addition, change the configuration described in the [Prerequisites](#prerequisites) section.

## References

For more information about the specific technical details, see:

- [[MS-ADTS]: Active Directory Technical Specification](/openspecs/windows_protocols/ms-adts/d2435927-0999-4c62-8c6d-13ba31a52e1a)
- [[MS-LSAD]: Local Security Authority (Domain Policy) Remote Protocol](/openspecs/windows_protocols/ms-lsad/1b5471ef-4c33-4a91-b079-dfcbb82f05cc)
- [[MS-NRPC]: Netlogon Remote Protocol](/openspecs/windows_protocols/ms-nrpc/ff8f970f-3e37-40f7-bd4b-af7336e4792f)
