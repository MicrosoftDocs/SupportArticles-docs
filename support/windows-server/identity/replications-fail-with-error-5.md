---
title: troubleshoot AD replication error 5 Access is denied
description: Discusses the Access is denied error 5 when Active Directory replications fail. This issue can occur in Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, Windows Server 2003 R2, Windows Server 2003, or Microsoft Windows 2000 Server.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
---
# How to troubleshoot Active Directory replication error 5 in Windows Server: Access is denied

This article describes the symptoms, cause, and resolution of situations in which Active Directory replication fails with error 5: Access is denied.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3073945

## Symptoms

You may encounter one or more of the following symptoms when Active Directory replications fail with error 5.

### Symptom 1

The Dcdiag.exe command-line tool reports that the Active Directory replication test fails with error status code (5). The report resembles the following:

> Testing server: **Site_Name**\\**Destination_DC_Name**  
Starting test: Replications  
*Replications Check  
[Replications Check,**Destination_DC_Name**] A recent replication attempt failed:  
From **Source_DC** to **Destination_DC**  
Naming Context: **Directory_Partition_DN_Path**  
The replication generated an error (5):  
Access is denied.  
The failure occurred at **Date** **Time**.  
The last success occurred at **Date** **Time**.  
 **Number** failures have occurred since the last success.  

### Symptom 2

The Dcdiag.exe command-line tool reports that the DsBindWithSpnEx  function fails with error 5 by running the `DCDIAG /test:CHECKSECURITYERROR` command.

### Symptom 3

The REPADMIN.exe command-line tool reports that the last replication attempt failed with status 5.

The REPADMIN commands that frequently cite the five status include but aren't limited to the following:

- REPADMIN /KCC
- REPADMIN /REPLICATE
- REPADMIN /REPLSUM
- REPADMIN /SHOWREPL
- REPADMIN /SHOWREPS
- REPADMIN /SYNCALL

Sample output from the `REPADMIN /SHOWREPL`  command follows. This output shows incoming replication from **DC_2_Name** to **DC_1_Name**  failing with the "Access is denied" error.

> **Site_Name**\\**DC_1_Name**  
DSA Options: IS_GC  
Site Options: (none)  
DSA object GUID: **GUID**  
DSA invocationID: **invocationID**  
>
> ==== INBOUND NEIGHBORS======================================  
DC= **DomainName**,DC=com  
 **Site_Name**\\**DC_2_Name** via RPC  
DSA object GUID: **GUID**  
Last attempt @ **Date** **Time** failed, result 5(0x5):  
Access is denied.  
<#> consecutive failure(s).  
Last success @ **Date** **Time**.  

### Symptom 4

NTDS KCC, NTDS General, or Microsoft-Windows-ActiveDirectory_DomainService events with the five status are logged in the Directory Services log in Event Viewer.

The following table summarizes Active Directory events that frequently cite the 8524 status.

|Event ID|Source|Event string|
|---|---|---|
|1655|NTDS General|Active Directory tried to communicate with the following global catalog and the attempts were unsuccessful.|
|1925|NTDS KCC|The attempt to establish a replication link for the following writable directory partition failed.|
|1926|NTDS KCC|The attempt to establish a replication link to a read-only directory partition with the following parameters failed.|
  
### Symptom 5

When you right-click the connection object from a source domain controller in Active Directory Sites and Services and then select Replicate Now, the process fails, and you receive the following error:

> Replicate Now
>
> The following error occurred during the attempt to synchronize naming context %**directory partition name**% from Domain Controller **Source DC** to Domain Controller **Destination DC**:
Access is denied.
>
> The operation will not continue.

The following screenshot represents a sample of the error:

:::image type="content" source="media/replications-fail-with-error-5/replicate-now-window.png" alt-text="Screenshot of the Replicate Now window which shows a sample of the error.":::

## Workaround

Use the generic [DCDIAG](https://technet.microsoft.com/library/cc731968.aspx) command-line tool to run multiple tests. Use the DCDIAG /TEST:CheckSecurityErrors  command-line tool to perform specific tests. (These tests include an SPN registration check.) Run the tests to troubleshoot Active Directory operations replication failing with error 5 and error 8453. However, be aware that this tool does not run as part of the default execution of DCDIAG.

To work around this issue, follow these steps:

1. At command prompt, run DCDIAG on the destination domain controller.
2. Run `DCDIAG /TEST:CheckSecurityError`.
3. Run NETDIAG.
4. Resolve any faults that were identified by DCDIAG and NETDIAG.
5. Retry the previously failing replication operation.If replications continue to fail, see the "[Causes and solutions](#causes-and-solutions)" section.

## Causes and solutions

The following causes may result in error 5. Some of them have solutions.  

### Cause 1: The RestrictRemoteClients setting in the registry has a value of 2

 If the Restrictions for Unauthenticated RPC clients policy setting are enabled and is set to Authenticated without exceptions, the RestrictRemoteClients registry value is set to a value of 0x2 in the `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\RPC` registry subkey.

This policy setting enables only authenticated remote procedure call (RPC) clients to connect to RPC servers that are running on the computer on which the policy setting is applied. It doesn't allow for exceptions. If you select this option, a system can't receive remote anonymous calls by using RPC. This setting should never be applied to a domain controller.

Solution

1. Disable the Restrictions for Unauthenticated RPC clients  policy setting that restricts the RestrictRemoteClients registry value to 2.

    > [!NOTE]
    > The policy setting is located in the following path: **Computer Configuration\Administrative Templates\System\Remote Procedure Call\Restrictions for Unauthenticated RPC clients**  

2. Delete the RestrictRemoteClients  registry setting, and then restart.

See [Restrictions for Unauthenticated RPC Clients: The group policy that punches your domain in the face](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/restrictions-for-unauthenticated-rpc-clients-the-group-policy/ba-p/399128).  

### Cause 2: The CrashOnAuditFail setting in the registry of the destination domain controller has a value of 2

 A CrashOnAduitFail value of 2 is triggered if the Audit: Shut down system immediately if unable to log security audits  policy setting in Group Policy is enabled and the local security event log becomes full.

Active Directory domain controllers are especially prone to maximum-capacity security logs when auditing is enabled and the size of the security event log is constrained by the **Do not overwrite events (clear log manually)**  and **Overwrite as needed**  options in Event Viewer or their Group Policy equivalents.

Solution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.
>
> 1. Clear the security event log, and save it to an alternative location as required.
> 2. Reevaluate any size constraints on the security event log. This includes policy-based settings.
> 3. Delete and then re-create a CrashOnAuditFail registry entry as follows:Registry subkey:
    HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA  
    Value Name: CrashOnAuditFail  
    Value Type: REG_DWORD  
    Value Data: 1  
> 4. Restart the destination domain controller.  

### Cause 3: Invalid trust

 If Active Directory replication fails between domain controllers in different domains, you should verify the health of trust relationships along the trust path.

You can try the NetDiag Trust Relationship test to check for broken trusts. The Netdiag.exe utility identifies broken trusts by displaying the following text:

> Trust relationship test. . . . . . : Failed  
Test to ensure DomainSid of domain '**domainname**' is correct.  
[FATAL] Secure channel to domain '**domainname**' is broken.  
[% **variable status code** %]

For example, if you have a multi-domain forest that contains a root domain (`Contoso.COM`), a child domain (`B.Contoso.COM`), a grandchild domain (`C.B.Contoso.COM`), and a tree domain in same forest (`Fabrikam.COM`) and if replication is failing between domain controllers in the grandchild domain (`C.B.Contoso.COM`) and the tree domain (`Fabrikam.COM)`, you should verify trust health between `C.B.Contoso.COM` and `B.Contoso.COM`, between `B.Contoso.COM` and `Contoso.COM`, and then finally between `Contoso.COM` and `Fabrikam.COM`.

If a shortcut trust exists between the destination domains, you don't have to validate the trust path chain. Instead, you should validate the shortcut trust between the destination and source domain.

Check for recent password changes to the trust by running the following command:

```console
Repadmin /showobjmeta * <DN path for TDO in question>
```

Verify that the destination domain controller is transitively inbound replicating the writable domain directory partition where trust password changes may take effect.

Commands to reset trusts from the root domain PDC are as follows:

```console
netdom trust <Root Domain> /Domain:<Child Domain> /UserD:CHILD /PasswordD:* /UserO:ROOT /PasswordO:* /Reset /TwoWay
```

Commands to reset trusts from the child domain PDC are as follows:

```console
netdom trust <Child Domain> /Domain:<Root Domain> /UserD:Root /PasswordD:* /UserO:Child /PasswordO:* /Reset /TwoWay
```  

### Cause 4: Excessive time skew

 Kerberos policy settings in the default domain policy allow for a five-minute difference in system time (this is the default value) between KDC domain controllers and Kerberos target servers to prevent replay attacks. Some documentation states that the system time of the client and that of the Kerberos target must be within five minutes of one another. Other documentation states that, in the context of Kerberos authentication, the time that is important is the delta between the KDC that is used by the caller and the time on the Kerberos target. Also, Kerberos doesn't care whether the system time on the relevant domain controllers matches current time. It cares only that the relative time difference between the KDC and target domain controller is within the maximum time skew that Kerberos policy allows. (The default time is five minutes or less.)

In the context of Active Directory operations, the target server is the source domain controller that is contacted by the destination domain controller. Every domain controller in an Active Directory forest that is currently running the KDC service is a potential KDC. Therefore, you have to consider time accuracy on all other domain controllers against the source domain controller. This includes time on the destination domain controller itself.

You can use the following two commands to check time accuracy:

- `DCDIAG /TEST:CheckSecurityError`
- `W32TM /MONITOR`

You can find sample output from DCDIAG /TEST:CheckSecurityError  in the "[More information](#more-information)" section. This sample shows excessive time skew on Windows Server 2003-based and Windows Server 2008 R2-based domain controllers.

Look for LSASRV 40960 events on the destination domain controller at the time of the failing replication request. Look for events that cite a GUID in the CNAME record of the source domain controller with extended error 0xc000133. Look for events that resemble the following:
> The time at the Primary Domain Controller is different than the time at the Backup Domain Controller or member server by too large an amount

Network traces that capture the destination computer that connects to a shared folder on the source domain controller (and also other operations) may show the "An extended error has occurred" on-screen error, but a network trace displays the following:
> -> KerberosV5 KerberosV5:TGS Request Realm: <- TGS request from source DC  
<- Kerberosvs Kerberosvs:KRB_ERROR - KRB_AP_ERR_TKE_NVV (33) <- TGS response where   "KRB_AP_ERR_TKE_NYV  
<- maps to "Ticket not yet valid" <- maps to "Ticket not yet valid"

The TKE_NYV  response indicates that the date range on the TGS ticket is newer than the time on the target. This indicates excessive time skew.

> [!NOTE]
>
> - W32TM /MONITOR  checks time only on domain controllers in the test computers domain, so you have to run this in each domain and compare time between the domains.
> - When the time difference is too great on Windows Server 2008 R2-based destination domain controllers, the Replicate now command in DSSITE.MSC fails with the "There is a time and / or date difference between the client and the server" on-screen error. This error string maps to error 1398 decimal or 0x576 hexadecimal with the ERROR_TIME_SKEW symbolic error name.  

For more information, see [Setting Clock Synchronization Tolerance to Prevent Replay Attacks](https://technet.microsoft.com/library/cc784130%28ws.10%29.aspx).  

### Cause 5: There's an invalid security channel or password mismatch on the source or destination domain controller

 Validate the security channel by running one of the following commands:

- `nltest /sc:query`
- `netdom verify`

On condition, reset the destination domain controller's password by using NETDOM /RESETPWD.

Solution

1. Disable the Kerberos Key Distribution Center (KDC) service on the domain controller that is restarted.
2. From the console of the destination domain controller, run `NETDOM RESETPWD` to reset the password for the destination domain controller as follows:

    ```console
    c:\>netdom resetpwd /server: server_name /userd: domain_name\administrator /passwordd: administrator_password
    ```

3. Make sure that likely KDCs and the source domain controller (if these are in the same domain) inbound replicate knowledge of the destination domain controller's new password.
4. Restart the destination domain controller to update Kerberos tickets and retry the replication operation.  

See [How to use Netdom.exe to reset machine account passwords of a domain controller](https://support.microsoft.com/help/325850).  

### Cause 6: The "Access this computer from network" user right isn't granted to a user who triggers replication

 In a default installation of Windows, the default domain controller policy is linked to the domain controller's organization unit (OU). The OU grants the Access this computer from network  user right to the following security groups:

|Local policy|Default domain controller policy|
|---|---|
|Administrators|Administrators|
|Authenticated Users|Authenticated Users|
|Everyone|Everyone|
|Enterprise Domain Controllers|Enterprise Domain Controllers|
|[Pre-Windows 2000 compatible Access]|Pre-Windows 2000 compatible Access|

If Active Directory operations fail with error 5, you should verify the following points:

- Security groups in the table are granted the Access this computer from network user right in the default domain controller's policy.
- Domain controller computer accounts are located in the domain controller's OU.
- The default domain controller's policy is linked to the domain controller's OU or to alternative OUs that are hosting computer accounts.
- Group Policy is applied on the destination domain controller that currently logs error 5.
- The Deny access this computer from network user right is enabled or doesn't reference direct or transitive groups that the security context being used by the domain controller or user account that triggering replication.
- Policy precedence, blocked inheritance, Microsoft Windows Management Instrumentation (WMI) filtering, or the like, isn't preventing the policy setting from applying to domain controller role computers.

> [!Note]
>
> - Policy settings can be validated with the RSOP.MSC tool. However, GPRESULT /Z is the preferred tool because it's more accurate.
> - Local policy takes precedence over policy that is defined in sites, domains, and the OU.
> - At one time, it was common for administrators to remove the "Enterprise domain controllers" and "Everyone" groups from the "Access this computer from network" policy setting in the default domain controller's policy. However, removing both groups is fatal. There's no reason to remove "Enterprise domain controllers" from this policy setting, because only domain controllers are a member of this group.

### Cause 7: There's an SMB signing mismatch between the source and destination domain controllers

|Policy setting|Registry path|
|---|---|
|Microsoft network client: Digitally sign communications (if server agrees)|HKEY_LOCAL_MACHINE\SYSTEM\CCS\Services\Lanmanworkstation\Parameters\Enablesecuritysignature|
|Microsoft network client: Digitally sign communications (always)|HKEY_LOCAL_MACHINE\SYSTEM\CCS\Services\Lanmanworkstation\Parameters\Requiresecuritysignature|
|Microsoft network server: Digitally sign communications (if server agrees)|HKEY_LOCAL_MACHINE\SYSTEM\CCS\Services\Lanmanserver\Parameters\Enablesecuritysignature|
|Microsoft network server: Digitally sign communications (always)|HKEY_LOCAL_MACHINE\SYSTEM\CCS\Services\Lanmanserver\Parameters\Requiresecuritysignature|

You should focus on SMB signing mismatches between the destination and source domain controllers. The classic cases involve a setting that is enabled or required on one side but disabled on the other.  

### Cause 8: UDP-formatted Kerberos packet fragmentation

 Network routers and switches may fragment or completely drop large User Datagram Protocol (UDP)-formatted network packets that are used by Kerberos and Extension Mechanisms for DNS (EDNS0). Computers that are running Windows 2000 Server or Windows Server 2003 operating system families are especially vulnerable to UDP fragmentation on computers that are running Windows Server 2008 or Windows Server 2008 R2.

Solution

1. From the console of the destination domain controller, ping the source domain controller by its fully qualified computer name to identify the largest packet supported by the network route. To do this, run the following command:

    ```console
    c:\>Ping <Source_DC_hostname>.<Fully_Qualified_Computer_Name> -f -l 1472
    ```

2. If the largest non-fragmented packet is less than 1,472 bytes, try one of the following methods (in order of preference):
   - Change the network infrastructure to appropriately support large UDP frames. This may require a firmware upgrade or configuration change on routers, switches, or firewalls.
   - Set maxpacketsize (on the destination domain controller) to the largest packet identified by the PING -f -l  command less 8 bytes to account for the TCP header, and then restart the changed domain controller.
   - Set maxpacketsize (on the destination domain controller) to a value of 1  This triggers Kerberos authentication to use a TCP. Restart the changed domain controller to make the change take effect.
3. Retry the failing Active Directory operation.  

### Cause 9: Network adapters have the Large Send Offload feature enabled

Solution

1. On the destination domain controller, open network adapter properties.
2. Click the **Configure** button.
3. Select the **Advanced** tab.
4. Disable the **IPv4 Large Send Offload** property.
5. Restart the domain controller.  

### Cause 10: Invalid Kerberos realm

 The Kerberos realm is invalid if one or more of the following conditions are true:

- The KDCNames registry entry incorrectly contains the local Active Directory domain name.
- The PolAcDmN registry key and the PolPrDmN registry key don't match.

Solutions

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

#### Solution for the incorrect KDCNames registry entry

1. On the destination domain controller, run REGEDIT.
2. Locate the following subkey in the registry: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\Kerberos\Domains`

3. For each <**Fully_Qualified_Domain**> under the subkey, verify that the value for the KdcNames registry entry refers to a valid external Kerberos realm and not to the local domain or another domain in the same Active Directory forest.

#### Solution for mismatching PolAcDmN and PolPrDmN registry keys

> [!NOTE]
> This method is valid only for domain controllers that are running Windows 2000 Server.

1. Start Registry Editor.
2. In the navigation pane, expand **Security**.
3. On the **Security** menu, click **Permissions**  to grant the Administrators local group full control of the SECURITY hive and its child containers and objects.
4. Locate the following subkey in the registry:  
`HKEY_LOCAL_MACHINE\SECURITY\Policy\PolPrDmN`

5. In the right-side pane of Registry Editor, click the ****No Name**: REG_NONE** registry entry one time.
6. On the **View** menu, click **Display Binary Data**.
7. In the **Format** section of the dialog box, click **Byte**.

    The domain name is displayed as a string on the right side of the **Binary Data**  dialog box. The domain name is the same as the Kerberos realm.
8. Locate the following subkey in the registry:  
`HKEY_LOCAL_MACHINE\SECURITY\Policy\PolACDmN`

9. In the right-side pane of Registry Editor, double-click the ****No Name**: REG_NONE** entry.
10. In the **Binary Editor**  dialog box, paste the value from the PolPrDmN registry subkey. (The value from the PolPrDmN registry subkey is the NetBIOS domain name).
11. Restart the domain controller.If the domain controller isn't functioning correctly, see [other methods](https://support.microsoft.com/help/837513).  

### Cause 11: There's a LAN Manager Compatibility (LM Compatibility) mismatch between the source and destination domain controllers

### Cause 12: Service principal names are either not registered or not present because of simple replication latency or a replication failure

### Cause 13: Antivirus software uses a mini-firewall network adapter filter driver on the source or destination domain controller

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

Active Directory errors and events such as those described in the "Symptoms" section can also fail with error 8453 together with the following, similar error string:  
> Replication Access was denied.

The following situations can cause Active Directory operations to fail with error 8453. However, these situations don't cause failures with error 5.

- Naming context (NC) head isn't permitted with the Replicating Directory Changes permission.
- The security principal starting replication isn't a member of a group that is granted the Replicating Directory Changes permission.
- Flags are missing in the UserAccountControl  attribute. These include the SERVER_TRUST_ACCOUNT  flag and the TRUSTED_FOR_DELEGATION  flag.
- The read-only domain controller (RODC) is joined in the domain without the `ADPREP /RODCPREP`  command running first.

### Sample output from DCDIAG /TEST:CheckSecurityError  

 Sample DCDIAG /test:CHECKSECURITYERROR  output from a Windows Server 2008 R2 domain controller follows. This output is caused by excessive time skew.

> Doing primary tests
 Testing server: \<Site_Name>\\<Destination_DC_Name> Starting test: CheckSecurityError  
 Source DC \<Source DC> has possible security error (1398).  
 Diagnosing...  
 Time skew error between client and 1 DCs! ERROR_ACCESS_DENIED  
 or down machine received by:  
 \<Source DC>
 [\<Source DC>] DsBindWithSpnEx() failed with error 1398,  
 There is a time and/or date difference between the client and server..  
 Ignoring DC \<Source DC> in the convergence test of object  
 CN=\<Destination_DC>,OU=Domain Controllers,DC=\<DomainName>,DC=com, because we  
 cannot connect!  
 ......................... \<Destination_DC> failed test CheckSecurityError  

Sample DCDIAG /CHECKSECURITYERROR output from a Windows Server 2003-based domain controller follows. This is caused by excessive time skew.

> Doing primary tests  
 Testing server: \<Site_Name>\\<Destination_DC_Name>  
 Starting test: CheckSecurityError  
 Source DC \<Source DC>has possible security error (5). Diagnosing...  
 Time skew error between client and 1 DCs! ERROR_ACCESS_DENIED or down machine recieved by:
 \<Source DC>  
 Source DC \<Source DC>_has possible security error (5). Diagnosing...  
 Time skew error: 7205 seconds different between:.  
 \<Source DC>  
 \<Destination_DC>  
 [\<Source DC>] DsBindWithSpnEx() failed with error 5,  
 Access is denied..  
 Ignoring DC \<Source DC>in the convergence test of object CN=\<Destination_DC>,OU=Domain  Controllers,DC=\<DomainName>,DC=com, because we cannot connect!  
 ......................... \<Destination_DC>failed test CheckSecurityError  

Sample DCDIAG /CHECKSECURITYERROR  output follows. It shows missing SPN names. (The output could vary from environment to environment.)

> Doing primary tests  
Testing server: \<site name>\\\<dc name>  
Test omitted by user request: Advertising  
Starting test: CheckSecurityError  
\* Dr Auth: Beginning security errors check'  
Found KDC \<KDC DC> for domain \<DNS Name of AD domain> in site \<site name>  
Checking machine account for DC \<DC name> on DC \<DC Name>  
\* Missing SPN :LDAP/\<hostname>.\<DNS domain name>/\<DNS domain name>  
\* Missing SPN :LDAP/\<hostname>.\<DNS domain name>  
\* Missing SPN :LDAP/\<hostname>  
\* Missing SPN :LDAP/\<hostname>.\<DNS domain name>/\<NetBIOS domain name>  
\* Missing SPN :LDAP/bba727ef-be4e-477d-9796-63b6cee3bSf.\<forest root domain DN>  
\* SPN found :E3514235-4B06-I1D1-ABØ4-00c04fc2dcd2/\<NTDS Settings object GUID>/\<forest root domain DNS name>  
\* Missing SPN :HOST/\<hostname>.\<DNS domain name>/\<DNS domain name>  
\* SPN found :HOST/\<hostname>.\<DNS domain name>  
\* SPN found :HOST/\<hostname>  
\* Missing SPN :HOST/\<hostname>.\<DNS domain name>/\<NetBIOS domain name>  
\* Missing SPN :GC/\<hostname>.\<DNS domain name>/\<DNS domain name>
Unable to verify the machine account (\<DN path for Dc machine account>) for \<DC Name> on \<DC name>.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
