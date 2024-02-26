---
title: Troubleshoot AD replication error -2146893022
description: This article describes how to troubleshoot a problem in which Active Directory replication fails and generates an error (-2146893022).
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# Active Directory replication error -2146893022: The target principal name is incorrect

This article describes how to troubleshoot a problem in which Active Directory replication fails and generates an error (-2146893022: The target principal name is incorrect).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2090913

> [!NOTE]
> **Home users:** This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, please [ask the Microsoft Community](https://answers.microsoft.com).

## Summary

This error occurs when the source domain controller doesn't decrypt the service ticket provided by the destination (target) domain controller.

### Top cause

The destination domain controller receives a service ticket from a Kerberos Key Distribution Center (KDC). And the KDC has an old version of the password for the source domain controller.

### Top resolution

1. Stop the KDC service on the destination domain controller. To do it, run the following command at a command prompt:

    ```console
    net stop KDC
    ```  

2. Start replication on the destination domain controller from the source domain controller. Use AD Sites and Services or `Repadmin`.

    Using `repadmin`:

    ```console
    Repadmin /replicate destinationDC sourceDC DN_of_Domain_NC
    ```

    For example, if replication is failing on `ContosoDC2.contoso.com`, run the following command on `ContosoDC1.contoso.com`:

    ```console
    Repadmin /replicate ContosoDC2.contoso.com ContosoDC1.contoso.com "DC=contoso,DC=com"
    ```

3. Start the Kerberos KDC service on the destination domain controller by running the following command:

    ```console
    net start KDC
    ```

If it doesn't resolve the issue, see the [Resolution](#resolution) section for an alternative solution in which you use the `netdom resetpwd` command to reset the computer account password of the source domain controller. If these steps don't resolve the problem, review the rest of this article.

## Symptoms

When this problem occurs, you experience one or more of the following symptoms:

- DCDIAG reports that the Active Directory replications test has failed and returned error -2146893022: The target principal name is incorrect.

    > [Replications Check,\<DC Name>] A recent replication attempt failed:  
    > From \<source DC> to \<destination DC>  
    > Naming Context: \<DN path of directory partition>  
    > The replication generated an error (-2146893022):  
    > The target principal name is incorrect.  
    > The failure occurred at \<date> \<time>.  
    > The last success occurred at \<date> \<time>.  
    > \<X> failures have occurred since the last success.

- Repadmin.exe reports that a replication attempt failed, and reports a status of **-2146893022 (0x80090322)**.

    `Repadmin` commands that commonly indicate the **-2146893022 (0x80090322)** status include but aren't limited to the following ones:

  - `REPADMIN /REPLSUM`
  - `REPADMIN /SHOWREPL`
  - `REPADMIN /SHOWREPS`
  - `REPADMIN /SYNCALL`

    Sample output from `REPADMIN /SHOWREPS` and `REPADMIN /SYNCALL` that indicate the **target principal name is incorrect** error is as follows:

    ```console
    c:\> repadmin /showreps  
    <site name>\<destination DC>
    DC Options: IS_GC
    Site Options: (none)
    DC object GUID: <NTDS settings object object GUID>
    DChttp://bemis/13/Pages/2090913_en-US.aspx invocationID: <invocation ID string>

    ==== INBOUND NEIGHBORS ======================================

    DC=<DN path for directory partition>
         <site name>\<source DC via RPC
             DC object GUID: <source DCs ntds settings object object guid>
             Last attempt @ <date> <time> failed, result -2146893022 (0x80090322):
     The target principal name is incorrect.
             <X #> consecutive failure(s).
             Last success @ <date> <time>.

    c:\> repadmin /syncall /Ade
    Syncing all NC's held on localhost.
    Syncing partition: DC=<Directory DN path>
    CALLBACK MESSAGE: Error contacting server CN=NTDS Settings,CN=<server name>,CN=Servers,CN=<site name>,CN=Sites,CN=Configuration,DC=<forest root domain> (network error): -2146893022 (0x80090322):
    ```

- The **replicate now** command in Active Directory Sites and Services returns the following error message:  
**The target principal name is incorrect**

    Right-clicking on the connection object from a source DC and then selecting **replicate now** fails. The on-screen error message is as follows:

    > Dialog title text: Replicate Now  
    > Dialog message text: The following error occurred during the attempt to contact the domain controller \<source DC name>:  
    > The target principal name is incorrect  
    > Buttons in Dialog: OK

- NTDS Knowledge Consistency Checker (KCC), NTDS General, or **Microsoft-Windows-ActiveDirectory_DomainService** events that have the **-2146893022** status are logged in the directory service event log.

    Active Directory events that commonly cite the **-2146893022** status include but aren't limited to the following ones:

    |**Event Source**| **Event ID**| **Event String** |
    |---|---|---|
    |NTDS Replication|1586|The Windows NT 4.0 or earlier replication checkpoint with the PDC emulator master was unsuccessful.<br/><br/>A full synchronization of the security accounts manager (SAM) database to domain controllers running Windows NT 4.0 and earlier might take place if the PDC emulator master role is transferred to the local domain controller before the next successful checkpoint.<br/> |
    |NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed.<br/> |
    |NTDS KCC|1308|The Knowledge Consistency Checker (KCC) has detected that successive attempts to replicate with the following domain controller has consistently failed.|
    |Microsoft-Windows-ActiveDirectory_DomainService|1926|The attempt to establish a replication link to a read-only directory partition with the following parameters failed<br/> |
    |NTDS Inter-site Messaging|1373|The Intersite Messaging service could not receive any messages for the following service through the following transport. The query for messages failed. |

## Cause

The **-2146893022**\\**0x80090322**\\**SEC_E_WRONG_PRINCIPAL** error code isn't an Active Directory error. It may be returned by the following lower layer components for different root causes:

- RPC
- Kerberos
- SSL
- LSA
- NTLM

Kerberos errors that are mapped by Windows code to **-2146893022**\\**0x80090322**\\**SEC_E_WRONG_PRINCIPAL** include:

- **KRB_AP_ERR_MODIFIED** (**0x29**/**41 decimal**/**KRB_APP_ERR_MODIFIED**)
- **KRB_AP_ERR_BADMATCH** (**0x24h**/**36 decimal**/**"Ticket and authenticator don't match"**)
- **KRB_AP_ERR_NOT_US** (**0x23h**/**35 decimal**/**"The ticket isn't for us"**)

Some specific root causes for **-2146893022**\\**0x80090322**\\**SEC_E_WRONG_PRINCIPAL** include:

- A bad name-to-IP mapping in DNS, WINS, HOST, or LMHOST file. It caused the destination domain controller to connect to the wrong source domain controller in a different Kerberos realm.

- The KDC and source domain controller have different versions of the source domain controller's computer account password. So the Kerberos target computer (source domain controller) couldn't decrypt Kerberos authentication data sent by the Kerberos client (destination domain controller).

- The KDC couldn't find a domain to look for the source domain controller's SPN.

- Authentication data in Kerberos encrypted frames were modified by hardware (including network devices), software, or an attacker.

## Resolution

- Run `dcdiag /test:checksecurityerror` on the source DC

    SPNs may be missing, invalid, or duplicated due to simple replication latency, especially following promotion, or replication failures.

    Duplicate SPNs may cause bad SPN to name mappings.

    `DCDIAG /TEST:CheckSecurityError` can check for missing or duplicate SPNs and other errors.

    Run this command on the console of all source domain controllers that fail outbound replication with the **SEC_E_WRONG_PRINCIPAL** error.

    You can check SPN registration against a specific location by using the following syntax:

    ```console
    dcdiag /test:checksecurityerror replsource:<remote dc>
    ```

- Verify that Kerberos encrypted network traffic reached the intended Kerberos target (name-to-IP mapping)

    Consider the following scenario:

  - Inbound replicating Active Directory destination domain controllers search their local copy of the directory for the **objectGUID** of the source domain controllers **NTDS Settings** objects.

  - The domain controllers query the active DNS server for a matching DC GUIDED CNAME record. Then it's mapped to a host A/AAAA record that contains the source domain controller's IP address.

    In this scenario, Active Directory runs a name resolution fallback. It includes queries for fully qualified computer names in DNS or single-label host names in WINS.

    > [!NOTE]
    > DNS Servers can also perform WINS lookups in fallback scenarios.

The following situations can all cause a destination domain controller to submit Kerberos-encrypted traffic to the wrong Kerberos target:

- Stale NTDS Settings objects
- Bad name-to-IP mappings in DNS and WINS host records
- Stale entries in HOST files

To check for this condition, either take a network trace or manually verify that name DNS/NetBIOS name queries resolve to the intended target computer.

### Method 1: Network trace method (as parsed by Network Monitor 3.3.1641 by having full default parsers enabled)

The following table shows a synopsis of network traffic that occurs when destination DC1 inbound replicates the Active Directory directory from source DC2.

| F#| SRC| DEST| Protocol| Frame| Comment |
|---|---|---|---|---|---|
|1|DC1|DC2|MSRPC|MSRPC:c/o Request: unknown Call=0x5 Opnum=0x3 Context=0x1 Hint=0x90|Dest DC RPC call to EPM on source DC over 135|
|2|DC2|DC1|MSRPC|MSRPC:c/o Response: unknown Call=0x5 Context=0x1 Hint=0xF4 Cancels=0x0|EPM response to RPC caller|
|3|DC1|DC2|MSRPC|MSRPC:c/o Bind: UUID{E3514235-4B06-11D1-AB04-00C04FC2DCD2} DRSR(DRSR) Call=0x2 Assoc Grp=0x0 Xmit=0x16D0 Recv=0x16D0|RPC bind request to E351... service UUID|
|4|DC2|DC1|MSRPC|MSRPC:c/o Bind Ack: Call=0x2 Assoc Grp=0x9E62 Xmit=0x16D0 Recv=0x16D0|RPC Bind response|
|5|DC1|KDC|KerberosV5|KerberosV5:TGS Request Realm: `CONTOSO.COM` `Sname`: E3514235-4B06-11D1-AB04-00C04FC2DCD2/6f3f96d3-dfbf-4daf-9236-4d6da6909dd2/contoso.com|TGS request for replication SPN of source DC. This operation will not appear on the wire of destination DC uses self as KDC.|
|6|KDC|DC1|KerberosV5|KerberosV5:TGS Response Cname: CONTOSO-DC1$|TGS response to destination DC contoso-dc1. This operation will not appear on the wire of destination DC uses self as KDC.|
| **7**|DC1|DC2|MSRPC|`MSRPC:c/o Alter Cont: UUID{E3514235-4B06-11D1-AB04-00C04FC2DCD2} DRSR(DRSR) Call=0x2`|AP request|
| **8**|DC2|DC1|MSRPC|`MSRPC:c/o Alter Cont Resp: Call=0x2 Assoc Grp=0x9E62 Xmit=0x16D0 Recv=0x16D0`|AP response.|

|Drilldown on Frame **7**|Drilldown on Frame **8**|Comments|
|---|---|---|
|`MSRPC MSRPC:c/o Alter Cont: UUID{E3514235-4B06-11D1-AB04-00C04FC2DCD2} DRSR(DRSR) Call=0x2`|`MSRPC:c/o Alter Cont Resp: Call=0x2 Assoc Grp=0xC3EA43 Xmit=0x16D0 Recv=0x16D0`|DC1 connects to AD Replication Service on DC2 over the port returned by the EPM on DC2.|
|Ipv4: Src = x.x.x.245, Dest = x.x.x.35, Next Protocol = TCP, Packet ID =, Total IP Length = 0|Ipv4: Src = x.x.x.35, Dest = x.x.x.245, Next Protocol = TCP, Packet ID = 31546, Total IP Length = 278|Verify that AD replication source DC (referred to as the *`Dest`* computer in the first column and _Src_ computer in column 2 **owns** the IP address cited in the trace. It's `x.x.x.35` in this example. |
|Ticket: Realm: `CONTOSO.COM`, `Sname`: E3514235-4B06-11D1-AB04-00C04FC2DCD2/6f3f96d3-dfbf-4daf-9236-4d6da6909dd2/contoso.com|ErrorCode: KRB_AP_ERR_MODIFIED (41) <br/><br/>Realm: \<verify that realm returned by the source DC matches the Kerberos realm intended by the destination DC>.<br/><br/> **`Sname`:** \<verify that the `sName` in the AP response matches contains the hostname of the intended source DC and NOT another DC that the destination incorrectly resolved to due to a bad name-to-ip mapping problem>.|In column 1, note the realm of the target Kerberos realm as `contoso.com` followed by the source domain controllers Replication SPN (`Sname`) which consists of the Active Directory replication service UUID (E351...) concatenated with object GUID of the source domain controllers NTDS Settings object.<br/><br/>The GUIDED value 6f3f96d3-dfbf-4daf-9236-4d6da6909dd2 to the right of the E351... replication service UUID is the Object GUID for the source domain controllers NTDS settings object. It's currently defined in the destination domain controllers copy of Active Directory. Verify that this object GUID matches the value in the **DSA Object GUID** field when `repadmin /showreps` is run from the console of the source DC.<br/><br/>A `ping` or `nslookup` of the source domain controllers fully qualified CNAME concatenated with_msdcs.\<forest root DNS name> from the console of the destination DC must return the source domain controllers current IP address: <br/><br/>`ping 6f3f96d3-dfbf-4daf-9236-4d6da6909dd2._msdcs.contoso.com`<br/><br/>`nslookup -type=cname 6f3f96d3-dfbf-4daf-9236-4d6da6909dd2._msdcs.<forest root domain> <DNS Server IP>`<br/><br/>In the reply shown in column 2, focus on the `Sname` field and verify that it contains the hostname of the AD replication source DC.<br/><br/>Bad name-to-IP mappings could cause the destination DC to connect to a DC in an invalid target realm causing the Realm value to be invalid as shown in this case. Bad host-to-IP mappings could cause DC1 to connect to DC3 in the same domain. It would still generate **KRB_AP_ERR_MODIFIED**, but the realm name in frame 8 would match the realm in frame 7.|
  
### Method 2: Name-to-IP mapping verification (without using a network trace)
  
From the console of the Source domain controller:

|Command|Comment|
|---|---|
|`IPCONFIG /ALL |MORE`|Note IP address of NIC used by destination domain controllers |
|`REPADMIN /SHOWREPS |MORE`|Note value of DSA Object GUID. It denotes the object GUID for the source domain controllers NTDS Settings Object in the source domain controllers copy of active Directory. |
  
From the Console of the destination DC:

|Command|Comment|
|---|---|
|`IPCONFIG /ALL |MORE`|Note the primary, secondary and any tertiary DNS Servers configured that the destination DC could query during DNS lookups.|
|`REPADMIN /SHOWREPS |MORE`|In the Inbound Neighbors section of the `repadmin` output, locate the replication status where the destination DC replicates a common partition from the source DC in question.<br/><br/>The DSA object GUID listed for the source DC in the replication status section of the report should match the object GUID listed in the `/showreps` header when run on the console of the source DC. |
|`IPCONFIG /FLUSHDNS`|Clear the DNS Client cache|
|**Start** > **Run** > **Notepad** <br/>`%systemroot%\system32\drivers\etc\hosts`|Check for host-to-IP mappings referencing the source domain controllers single label or fully qualified DNS name. Remove if present. Save changes to HOST file.<br/><br/> Run `Nbtstat -R` (upper case R) to refresh the NetBIOS name cache.|
|`NSLOOKUP -type=CNAME <object guid of source DCs NTDS Settings object>._msdcs.<forest root DNS name> <primary DNS Server IP>`<br/><br/>Repeat for each additional DNS Server IP configured on the destination DC. <br/><br/> example: `c:\>nslookup -type=cname 8a7baee5-cd81-4c8c-9c0f-b10030574016._msdcs.contoso.com 152.45.42.103`|Verify that IP returned matches the IP address of target DC listed above recorded from the console of the source DC.<br/><br/>Repeat for all DNS Servers IPs configured on destination DC.|
|`nslookup -type=A+AAAA <FQDN of source DC> <DNS Server IP>`|Check for duplicate host A records on all DNS Server IPs configured on the destination DC.|
|`nbtstat -A <IP address of DNS Server IP returned by nslookup>`|Should return name of the source DC.|
  
> [!NOTE]
> A replication request that's directed to a non-domain controller (because of a bad name-to-IP mapping) or a domain controller  that doesn't currently have the E351... service UUID registered with the endpoint mapper returns error 1753: There are no more endpoints available with the endpoint mapper.

The Kerberos target can't decrypt Kerberos authenticated data because of a password mismatch.

This issue can occur if the password for the source domain controller differs between the KDC and source domain controller's copy of the Active Directory directory. The destination domain controller's copy of the source domain controller computer account password may be stale if it's not using itself as the KDC.

Replication failures can prevent domain controllers from having a current password value for domain controllers in a given domain.

Every domain controller runs the KDC service for their domain realm. For same realm transactions, a destination domain controller favors getting Kerberos tickets from itself. However, it may get a ticket from a remote domain controller. Referrals are used to get Kerberos tickets from other realms.

The `NLTEST /DSGETDC:<DNS domain of target domain> /kdc` command that's run at an elevated command prompt in close time proximity to a **SEC_E_WRONG_PRINCIPAL** error can be used to quickly identify which KDC a Kerberos client is targeting.

The definitive way to determine which domain controller a Kerberos client got a ticket from is to take a network trace. The lack of Kerberos traffic in a network trace may indicate:

- The Kerberos client has already acquired tickets.
- It's getting tickets off-the-wire from itself.
- Your network trace application isn't correctly parsing Kerberos traffic.

Kerberos tickets for the logged-on user account can be purged at an elevated command prompt by using the `KLIST purge` command.

Kerberos tickets for the system account that are used by Active Directory replication can be purged without a restart by using `KLIST -li 0x3e7 purge`.

Domain controllers can be made to use other domain controllers by stopping the KDC service on a local or remote domain controller.

Use `REPADMIN /SHOWOBJMETA` to check for obvious version number differences in password-related attributes (dBCSPwd, UnicodePWD, NtPwdHistory, PwdLastSet, lmPwdHistory) for the source domain controller in the source domain controller's  and destination domain controller's copy of the Active Directory directory.

```console
C:\>repadmin /showobjmeta <source DC> <DN path of source DC computer account>
```

```console
C:\>repadmin /showobjmeta <KDC selected by destination DC> <DN path of source DC computer account>
```

The netdom `resetpwd /server:<DC to direct password change to> /userd:<user name> /passwordd:<password>` command that's run at an elevated command prompt on the console of the domain controller that requires a password reset can be used to reset domain controller machine account passwords.

## Troubleshoot specific scenarios

- Repro steps for bad host-to-IP mapping that causes the destination domain controller to pull from wrong source.

    1. Promote **\\\\dc1 + \\\\DC2 + \\\\DC3** in the `contoso.com` domain. End-to-end replication occurs without errors.

    1. Stop the KDC on \\\\DC1 and \\\\DC2 to force off-box Kerberos traffic that can be observed in a network trace. End-to-end replication occurs without errors.

    1. Create a Host file entry for \\\\DC2 that points to the IP address of a DC in a remote forest. It's to simulate a bad host-to-IP mapping in a host A/AAAA record, or perhaps a stale NTDS Settings object in the destination domain controller's copy of the Active Directory directory.

    1. Start Active Directory Sites and Services on the console of \\\\DC1. Right-click **\\\\DC1's inbound connection object** from \\\\DC2 and note the **target account name is incorrect** replication error.

- Repro steps for a source domain controller password mismatch between KDC and the source domain controller.

    1. Promote **\\\\dc1 + \\\\DC2 + \\\\DC3** in the `contoso.com` domain. End-to-end replication occurs without error.

    2. Stop the KDC on \\\\DC1 and \\\\DC2 to force off-box Kerberos traffic that can be observed in network trace. End-to-end replication occurs without error.

    3. Disabling inbound replication on KDC \\\\DC3 to simulate a replication failure on the KDC.

    4. Reset the computer account password on \\\\DC2 three or more times so that \\\\DC1 and \\\\DC2 both have the current password for \\\\DC2.

    5. Start Active Directory Sites and Services on the console of \\\\DC1. Right-click on \\\\DC1's inbound connection object from \\\\DC2 and note the **target account name is incorrect** replication error.

- DS RPC client logging

    Set **NTDS\Diagnostics Loggings\DS RPC Client = 3**. Trigger replication. Look for Task Category Event 1962 + 1963. Note the fully qualified `cname` that's listed in the **directory service** field. The destination domain controller should be able to ping this record and have the returned address map to the current IP address of the source DC.

- Kerberos workflow

    The Kerberos workflow includes the following actions:

  - Client Computer calls [IntializeSecurityContext function](/windows/win32/api/sspi/nf-sspi-initializesecuritycontexta) and specifies the Negotiate security support provider (SSP).

  - The client contacts the KDC with its TGT and requests a TGS Ticket for the target domain controller.

  - The KDC searches the Global Catalog for a source (either e351 or hostname) in the destination domain controller's realm.

  - If the target domain controller is in the destination domain controller's realm, the KDC provides the client a service ticket.

  - If the target domain controller is in a different realm, the KDC provides the client a referral ticket.

  - The client contacts a KDC in the target domain controller's domain and requests a service ticket.

  - If the source domain controller's SPN doesn't exist in the realm, you receive a **KDC_ERR_S_PRINCIPAL_UNKNOWN** error.

  - The destination domain controller contacts the target and presents its ticket.

  - If the target domain controller owns the name in the ticket and can decrypt it, the authentication works.

  - If the target domain controller hosts the RPC server service UUID, the on-wire Kerberos **KRB_AP_ERR_NOT_US** or **KRB_AP_ERR_MODIFIED** error is remapped to the following one:

    > -2146893022 decimal / 0x80090322 / SEC_E_WRONG_PRINCIPAL / "The target principal name is incorrect"

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
