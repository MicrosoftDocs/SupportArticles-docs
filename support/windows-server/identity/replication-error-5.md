---
title: AD replication error 5
description: This article describes various reasons of Active Directory replication error 5.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, arrenc, Justintu
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.subservice: active-directory
---
# Active Directory replication error 5 - Access is denied

This article describes the symptoms, cause, and resolution steps for situations where AD operations fail with error 5: Access is denied.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2002013

## Symptoms

1. DCDIAG reports that Active Directory Replications test has failed with error status code (5): **access is denied**.

    ```output
    Testing server: <site name><destination dc name>  
    Starting test: Replications  
    Replications Check  
    [Replications Check,<destination DC name] A recent replication attempt failed:  
    From <source DC> to <destination DC>  
    Naming Context: <directory partition DN path>  
    The replication generated an error (5):  
    Access is denied.  
    The failure occurred at <date> <time>.  
    The last success occurred at <date> <time>.
    3 failures have occurred since the last success.
    ```

2. DCDIAG reports that DsBindWithSpnEx() failed with error 5.

3. REPADMIN.EXE reports that the last replication attempt has failed with status 5.

    `REPADMIN` commands that commonly cite the status 5 include but aren't limited to:  

    - `REPADMIN /KCC`
    - `REPADMIN /REPLICATE`
    - `REPADMIN /REPLSUM`
    - `REPADMIN /SHOWREPL`
    - `REPADMIN /SHOWREPS`
    - `REPADMIN /SYNCALL`

    Sample output from `REPADMIN /SHOWREPS` showing inbound replication from CONTOSO-DC2 to CONTOSO-DC1 failing with the **replication access was denied** error is shown below:

    ```output
    Default-First-Site-Name\CONTOSO-DC1  
    DSA Options: IS_GC  
    Site Options: (none)  
    DSA object GUID: b6dc8589-7e00-4a5d-b688-045aef63ec01  
    DSA invocationID: b6dc8589-7e00-4a5d-b688-045aef63ec01  

    ==== INBOUND NEIGHBORS ======================================  

    DC=contoso, DC=com  
    Default-First-Site-Name\CONTOSO-DC2 via RPC  
    DSA object GUID: 74fbe06c-932c-46b5-831b-af9e31f496b2  
    Last attempt @ <date> <time> failed, result 5 (0x5):  
    Access is denied.  
    <#> consecutive failure(s).  
    Last success @ <date> <time>.
    ```

4. NTDS KCC, NTDS General, or Microsoft-Windows-ActiveDirectory_DomainService events with the status 5 are logged in the directory service event log.

    Active Directory events that commonly cite the 8524 status include but aren't limited to:

    |Event|Source|Event String|
    |---|---|---|
    |NTDS General|1655|Active Directory attempted to communicate with the following global catalog and the attempts were unsuccessful.|
    |NTDS KCC|1925|The attempt to establish a replication link for the following writable directory partition failed.|
    |NTDS KCC|1926|The attempt to establish a replication link to a read-only directory partition with the following parameters failed.|

5. The **replicate now** command in Active Directory Sites and Services returns **Access is denied**.

    Right-clicking on the connection object from a source DC and choosing **replicate now** fails with **Access is denied**. The on-screen error message text and screenshot is shown below:  

6. Dialog title text: **Replicate Now**

    Dialog message text:

    > The following error occurred during the attempt to synchronize naming context <%directory partition name%> from Domain Controller \<Source DC> to Domain Controller \<Destination DC>:
    Access is denied
    >
    > The operation will not continue

    Buttons in Dialog: **OK**

    :::image type="content" source="media/replication-error-5/replicate-now.png" alt-text="Access is denied error shows in the Replicate Now dialog box." border="false":::

## Cause

Valid root causes for error 5: **access is denied** include:

1. The **RestrictRemoteClients** setting in the registry has a value of **2**.
2. The **Access this computer from network** user right isn't granted to the **Enterprise Domain Controllers** group or the administrator triggering immediate replication.
3. The **CrashOnAuditFail** setting in the registry of the destination DC has a value of **2**.
4. There's a time difference between the Key Distribution Center (KDC) used by the destination DC and the source DC. The time difference exceeds the maximum time skew that's allowed by Kerberos defined in Default Domain policy.
5. There's an SMB signing mismatch between the source and destination DCs.
6. There's an **LMCompatiblity** mismatch between the source and destination DCs.
7. Service principal names are either not registered or not present because of simple replication latency or a replication failure.
8. UDP formatted Kerberos packets are being fragmented by network infrastructure devices like routers and switches.
9. The secure channel on the source or destination DC is invalid.
10. Trust relationships in the trust chain are broken or invalid.
11. The **KDCNames** setting in the `HKLM\System\CurrentControlSet\Control\LSA\Kerberos\Domains` section of the registry incorrectly contains the local Active Directory domain name.
12. Some network adapters have a **Large Send Offload** feature.
13. Antivirus software that uses a mini-firewall network adapter filter driver on the source or destination DC.

Active Directory errors and events like those cited in the symptoms section of this KB can also fail with error 8453 with similar error string **Replication Access was denied**. The following root cause reasons can cause AD operations to fail with 8453: **replication access was denied** but don't cause failures with error 5: **replication is denied**:

1. NC head not permitted with the **replicating directory changes** permission.
2. The security principal starting replication not a member of a group that has been granted **replicating directory changes**.
3. Missing flags in the `UserAccountControl` attribute including `SERVER_TRUST_ACCOUNT` and `TRUSTED_FOR_DELEGATION`.
4. RODC promoted into domain without having first run `ADPREP /RODCPREP`.

## Resolution

AD Replication failing with error 5 has multiple root causes. Solve the problem initially using tools like:

- DCDIAG
- DCDIAG /TEST: CheckSecurityError
- NETDIAG that exposes common problems

If still unresolved, walk the known causes list in most common, least complex, least disruptive order to least common, most complex, most disruptive order.

### Run DCDIAG, DCDIAG /TEST:CheckSecurityError, and NETDIAG

The generic DCDIAG runs multiple tests.

`DCDIAG /TEST:CheckSecurityErrors` was written to do specific tests (including an SPN registration check) to troubleshoot Active Directory operations replication failing with:

- error 5: **access is denied**
- error 8453: **replication access was denied**

`DCDIAG /TEST:CheckSecurityErrors` isn't run as part of the default execution of DCDIAG.

1. Run DCDIAG on the destination DC
2. Run DCDIAG /TEST:CheckSecurityError
3. Run NETDIAG
4. Resolve any faults identified by DCDIAG and NETDIAG. Retry the previously failing replication operation. If still failing, continue to **the long way around**.

#### The long way around

1. `RestrictRemoteClients` value is set to **2**

    This registry value `RestrictRemoteClients` is set to a value of **0x2** in `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\RPC`.

    To resolve this issue:

    1. Disable the policy that enforces this setting.

    2. Delete the `RestrictRemoteClients` registry setting and reboot.

        For more information on this setting, see [RestrictRemoteClients registry key is enabled](/previous-versions/office/exchange-server-analyzer/aa995844(v=exchg.80)).

        The `RestrictRemoteClients` registry value is set by the following group policy setting:

        **Computer Configuration** > **Administrative Templates** > **System** > **Remote Procedure Call** - **Restrictions for Unauthenticated RPC clients**

        A registry value of **0x2** is applied if the policy setting is enabled and set to **Authenticated without exceptions**.

        This option allows only authenticated RPC clients to connect to RPC servers running on the computer on which the policy setting is applied. It doesn't permit exceptions. If you select this option, a system can't receive remote anonymous calls using RPC. This setting should never be applied to a domain controller.

2. Check **Access this computer from network** rights.

    In a default installation of Windows, the default domain controllers policy is linked to the domain controllers OU container. It grants the **access this computer from network** user right to the following security groups:

    |Local Policy|Default Domain controllers policy|
    |---|---|
    |Administrators|Administrators|
    |Authenticated Users|Authenticated Users|
    |Everyone|Everyone|
    |Enterprise Domain Controllers|Enterprise Domain Controllers|
    |[Pre-Windows 2000 compatible Access]|[Pre-Windows 2000 compatible Access]|

    If Active Directory operations are failing with error 5: **access is denied**, verify that:

    - Security groups in the list above have been granted the **access this computer from network right** in default domain controllers policy.
    - Domain controller computer accounts are located in the domain controllers OU.
    - Default domain controllers policy is linked to the domain controllers OU or alternate OUs hosting computer accounts.  
    - Group policy is applying on the destination domain controller currently logging error 5.  
    - **Deny Access this computer from network** user right hasn't been enabled or doesn't reference failing direct or nested groups.
    - Policy precedence, blocked inheritance, WMI filtering, or the like, is NOT preventing the policy setting from applying to DC role computers.

    Policy settings can be validated with RSOP.MSC but `GPRESULT /Z` is the preferred tool because it's more accurate.

    > [!NOTE]
    > Local policy takes precedence over policy defined in Sites, Domains, and OU.

    > [!NOTE]
    > At one time it was common for administrators to remove the **enterprise domain controllers** and **everyone** groups from the **access this computer from network** right in default domain controllers policy. Removing both is fatal. There is no reason to remove **enterprise domain controllers** from this right as only DCs are a member of this group.

3. `CrashOnAuditFail` = **2**  

    AD Replication fails when `HKLM\System\CurrentControlSet\Control\LSA\CrashOnAuditFail` = has a value of **2**,

    A `CrashOnAduitFail` value of **2** is triggered when the **Audit: Shut down system immediately if unable to log security audits** setting in Group Policy has been enabled, and the local security event log becomes full.

    Active Directory domain controllers are especially prone to maximum capacity security logs when auditing has been enabled, and the size of the security event log has been constrained by the **Do not overwrite events** (clear log manually) or **Overwrite as needed** options in Event Viewer or group policy equivalents.

    User Action:

    If `HKLM\System\CCS\Control\LSA\CrashOnAuditFail` = **2**:

    - Clear the security event log (save to alternate location as required)
    - Re-evalaute any size constraints on the security event log, including policy-based settings.
    - Recreate `CrashOnAuditFail (REG_DWORD)` = **1**
    - Reboot

    On seeing a `CrashOnAuditFail` value of **0** or **1**, some CSS engineers have resolved **access is denied** errors by again clearing the security event log, deleting `the CrashOnAuditFail` registry value, and rebooting the destination DC.

    Related Content: [Manage auditing and security log](/windows/security/threat-protection/security-policy-settings/manage-auditing-and-security-log).

4. Excessive time skew

    Kerberos policy settings in the default domain policy allow for a 5-minutes difference (default value) in system time between KDC domain controllers and a Kerberos target server to prevent replay attacks. Some documentation states that time between the client and the Kerberos target must have time within five minutes of each other. Others state that in the context of Kerberos authentication, the time that matters is the delta between the KDC used by the caller and the time on the Kerberos target. Also, Kerberos doesn't care that system time on the relevant DCs matches current time. It only cares that relative time difference between the KDC and target DC is inside the maximum time skew (default five minutes or less) allowed by Kerberos policy.

    In the context of Active Directory operations, the target server is the source DC being contacted by the destination DC. Every domain controller in an Active Directory forest (currently running the KDC service) is a potential KDC. So you'll need to consider time accuracy on all other DCs against the source DC including time on the destination DC itself.

    Two methods to check time accuracy include:  

    ```console
    C:\> DCDIAG /TEST: CheckSecurityError
    ```

    AND

    ```console
    C:\> W32TM /MONITOR
    ```

    Look for LSASRV 40960 events on the destination DC at the time of the failing replication request that cites a GUIDed CNAME record of the source DC with extended error:

    > 0xc000133: the time at the Primary Domain Controller is different than the time at the Backup Domain Controller or member server by too large an amount.

    Network traces capturing the destination computer connecting to a shared folder on the source DC (and other operations) may show the on-screen error **an extended error has occurred**. But a network trace shows:

    > KerberosV5:TGS Request Realm > TGS request from source DC  
    > KerberosV5:KRB_ERROR - KRB_AP_ERR_TKE_NVV (33) > TGS response where KRB_AP_ERR_TKE_NYV > maps to Ticket not yet valid

    The **TKE_NYV** response indicates that the date range on the **TGS** ticket is newer than time on the target, indicating excessive time skew.

    > [!NOTE]
    > `W32TM /MONITOR` only checks time on DCs in the test computers domain so you'll need to run this in each domain and compare time between the domains.

    > [!NOTE]
    > If system time was found to be inaccurate, make an effort to figure out why and what can be done to prevent inaccurate time going forward. Was the forest root PDC configured with an external time source? Are reference time sources online and available on the network? Was the time service running? Are DC role computers configured to use NT5DS hierarchy to source time?

    > [!NOTE]
    > When the time difference is too great on Windows Server 2008 R2 destination DCs, the **replicate now** command in DSSITE.MSC fails with the on-screen error **There is a time and / or date difference between the client and the server**. This error string maps to error 1398 decimal / 0x576 hex with symbolic error name **ERROR_TIME_SKEW**.

    Related Content: [Setting Clock Synchronization Tolerance to Prevent Replay Attacks](/previous-versions/windows/it-pro/windows-server-2003/cc784130(v=ws.10)).

5. SMB signing mismatch

    The best compatibility matrix for SMB signing is defined by four policy settings and their registry-based equivalents:

    |Policy setting|Registry Path|
    |---|---|
    |Microsoft network client: Digitally sign communications (if server agrees)|HKLM\SYSTEM\CCS\Services\Lanmanworkstation\Parameters\Enablesecuritysignature|
    | Microsoft network client: Digitally sign communications (always)|HKLM\SYSTEM\CCS\Services\Lanmanworkstation\Parameters\Requiresecuritysignature|
    | Microsoft network server: Digitally sign communications (if server agrees)|HKLM\SYSTEM\CCS\Services\Lanmanserver\Parameters\Enablesecuritysignature|
    | Microsoft network server: Digitally sign communications (always)|HKLM\SYSTEM\CCS\Services\Lanmanserver\Parameters\Requiresecuritysignature|

    Focus on SMB signing mismatches between the destination and source domain controllers with the classic cases being the setting enabled or required on one side but disabled on the other.

    > [!NOTE]
    > Internal testing showed SMB signing mismatches causing replication to fail with error 1722: **The RPC Server is unavailable**.

6. UDP formatted Kerberos packet fragmentation

    Network routers and switches may fragment or completely drop large UDP formatted network packets used by Kerberos and EDNS0 (DNS). Computers running Windows 2000 and Windows 2003 operating system families are vulnerable to UDP fragmentation comparing to computers running Windows Server 2008 and 2008 R2.  

    User Action:

    - From the console of the destination DC, ping the source DC by its fully qualified computer name to identify the largest packet supported by the network route.

      ```console
      c:\> Ping <source DC hostname.>. <fully qualified computer name> -f -l 1472
      ```

    - If the largest non-fragmented packet is less than 1,472 bytes, either (in order of preference)

      - Modify your network infrastructure to properly support large UDP frames. It may require a firmware upgrade or config change on routers, switches, or firewalls.

        OR

      - Set maxpacketsize (on the destination DC) to the largest packet identified by the PING -f -l command less 8 bytes to account for the TCP header and reboot the modified DC.

        OR
      - Set maxpacketsize (on the destination DC) to a value of "1" which triggers Kerberos to use a TCP. Reboot the modified DC to make the change take effect.  

### Retry the failing Active Directory operation

1. Invalid Secure channel / Password Mismatch

    Validate the secure channel with `nltest /sc: query` or `netdom verify`.

    For more information about reset the destination DC's password with `NETDOM / RESETPWD`, see [How to use Netdom.exe to reset machine account passwords of a Windows Server domain controller](https://support.microsoft.com/help/325850).

    User Action:

    - Disable the KDC service on the DC being rebooted.
    - From the console of the destination DC, run NETDOM RESETPWD to reset the password for the destination DC:

      ```console
      c:\>netdom resetpwd /server: server_name /userd: domain_name \administrator /passwordd: administrator_password
      ```

    - Ensure that likely KDCs AND the source DC (if in the same domain) inbound replicate knowledge of the destination DCs new password.
    - Reboot the destination DC to flush Kerberos tickets and retry the replication operation.

2. Invalid trust

    If AD replication is failing between DCs in different domains, verify trust relationships health along the trust path

    When able, use the **NETDIAG Trust Relationship** test to check for broken trusts. NETDIAG identifies broken trusts with the following text:  

    > Trust relationship test. . . . . . : Failed Test to ensure DomainSid of domain \<domainname> is correct. [FATAL] Secure channel to domain \<domainname> is broken. [<%variable status code%>]

    For example, you have a multi-domain forest containing:

    - root domain `Contoso.COM`
    - child domain `B.Contoso.COM`
    - grandchild domain `C.B.Contoso.COM`
    - **tree domain in same forest** `Fabrikam.COM`

    If replication is failing between DCs in grandchild domain `C.B.Contoso.COM` and tree domain `Fabrikam.COM`, verify trust health in the following order:

    - between `C.B.Contoso.COM` and `B.Contoso.COM`
    - between `B.Contoso.COM` and `Contoso.COM`
    - between `Contoso.COM` and `Fabrikam.COM`

    If a short cut trust exists between the destination domains, the trust path chain doesn't have to be validated. Instead validate the short cut trust between the destination and source domain.

    Check for recent password changes to the trust with `Repadmin /showobjmeta * \<DN path for TDO in question>` Trusted Domain Object (TDO) verify that the destination DC is transitively inbound replicating the writable domain directory partition where trust password changes may take place.

    Commands to reset trusts:

    - From root domain PDC:

      ```console
      netdom trust <Root Domain> /Domain:<Child Domain> /UserD:CHILD /PasswordD:* /UserO:ROOT /PasswordO:* /Reset /TwoWay
      ```

    - From Child domain PDC:

      ```console
      netdom trust <Child Domain> /Domain:<Root Domain> /UserD:Root/PasswordD:*/UserO:Child /PasswordO:* /Reset /TwoWay
      ```

3. Invalid Kerberos realm - PolAcDmN / PolPrDmN (no repro when article written)

    Copied from [Domain controller is not functioning correctly](https://support.microsoft.com/help/837513).

    1. Start Registry Editor.
    2. In the left pane, expand **Security**.
    3. On the **Security** menu, select **Permissions** to grant the Administrators local group Full Control of the SECURITY hive and its child containers and objects.
    4. Locate the `HKEY_LOCAL_MACHINE\SECURITY\Policy\PolPrDmN` key.
    5. In the right pane of Registry Editor, select the **\<No Name>: REG_NONE** entry one time.
    6. On the **View** menu, select **Display Binary Data**. In the Format section of the dialog box, select **Byte**.
    7. The domain name appears as a string in the right side of the **Binary Data** dialog box. The domain name is the same as the Kerberos realm.
    8. Locate the `HKEY_LOCAL_MACHINE\SECURITY\Policy\PolACDmN` registry key.
    9. In the right pane of Registry Editor, double-click the **\<No Name>: REG_NONE** entry.
    10. In the **Binary Editor** dialog box, paste the value from **PolPrDmN**. (The value from PolPrDmN will be the NetBIOS domain name).
    11. Restart the domain controller.

4. Invalid Kerberos realm - KdcNames  

    User Action:

    - On the console of the destination DC, run REGEDIT.
    - Locate the following path in the registry: `HKLM\system\ccs\control\lsa\kerberos\domains`.
    - For each \<fully qualified domain> under `HKLM\system\ccs\control\lsa\kerberos\domains`, verify that the value for `KdcNames` refers to a valid external Kerberos realm and NOT the local domain or another domain in the same Active Directory forest.

5. Network Adapters with **IPv4 Large Send Offload** enabled:

    User Action:

    - Open **Network Adapter** card properties.
    - Select **Configure** button.
    - Select **Advanced** tab.
    - Disable **IPv4 Large Send Offload**.
    - Reboot.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
