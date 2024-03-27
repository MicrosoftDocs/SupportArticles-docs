---
title: Resource domain is changed after installing January 2022 Windows updates
description: Troubleshoot an issue in which domain of discovered resources changes after installing January 2022 Windows updates if the NetBIOS domain is different than FQDN.
ms.date: 12/05/2023
ms.reviewer: kaushika, jarrettr, brianhun, payur
ms.custom: sap:Boundary Groups, Discovery and Collections\Active Directory Discovery (all types)
---
# Domain name of resource is changed after installing January 2022 Windows updates

This article describes how to identify and resolve an issue in which resource domain is changed after you install January 2022 Windows updates.

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Symptoms

After you install January 2022 or later Windows cumulative updates on a Configuration Manager site server, the domain name that is associated with users, groups, or devices may be changed. This issue occurs when the NetBIOS domain name (also known as the pre-Windows 2000 domain name) is different from the first element of the fully qualified domain name (FQDN).

For example, a resource is in a domain with the NetBIOS domain name `AAA`, but with the FQDN `BBB.contoso.com`. The resource is discovered as `AAA\User1` or `AAA\Computer1`. After you install January 2022 Windows updates and the discovery runs, the resource name may be changed to `BBB\User1` or `BBB\Computer1`.

The domain name of the resource may alternate between `AAA` and `BBB`, which removes or adds devices to collections that have query rules based on a domain membership.

> [!NOTE]
> Direct membership rules are not affected.

## Cause

January 2022 Windows updates introduced an NTLM fallback that may [block NTLM authentication if Kerberos authentication isn't successful](https://support.microsoft.com/topic/dd415f99-a30c-4664-ba37-83d33fb071f4), which changes the behavior in Configuration Manager current branch.

## Resolution

This issue is fixed in [Configuration Manager current branch, version 2203](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2203).

If the issue still occurs after upgrading to version 2203 and later versions, make sure that you meet the requirements for establishing the Kerberos connection from the site server to the controllers of the target domain. For example:

- TCP port 88 (Kerberos) is accessible.
- The site server can resolve service location (SRV) records for Kerberos services. For example:

    ```output
    _kerberos._tcp.contoso.com
    _kerberos._udp.contoso.com
    _kerberos._tcp.dc._msdcs.contoso.com
    ```

## Workaround

To work around this issue, change collection rules to include both the NetBIOS domain name and the DNS domain name. For example:

`select * from SMS_R_System where SMS_R_System.SystemGroupName in ("AAA\\Group1","BBB\\Group1")`

## Identify the issue

Here are the steps to check logs and identify the issue:

1. Increase the size of the _ADSgDis.log_ file to 100 megabytes (MB) or more to accommodate a full Active Directory group discovery. Under the following registry key, change the `MaxFileSize` registry value to `104857600` (the default value is `2621440`).

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SMS_AD_SECURITY_GROUP_DISCOVERY_AGENT`

1. Enable verbose logging for the _ADSgDis.log_ file. Under the following registry key, change the `Verbose Logs` registry value to `1` (the default value is `0`).

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_AD_SECURITY_GROUP_DISCOVERY_AGENT`

1. Run a full Active Directory group discovery and make sure the following message is logged in the _ADSgDis.log_ file upon completion.

   `INFO: Succeeded running full sync stored procedure`

1. Filter by the thread ID that logged the above message and find the following message in the filtered logs.

   `VERBOSE : Could not get Domain Name using DSCrackNames, will parse ADs Path to get it`

1. Check the following lines around. You'll find a group and its member are from different domains.

   ```output
   INFO: DDR was written for group 'contoso\ParentGroup' - C:\ConfigMgr\inboxes\auth\ddm.box\userddrsonly\asg1607o.DDR at <Date Time>.~ 
   VERBOSE: group has 1 members~
   ...
   VERBOSE: Domain controller name for the SID is: \\DC.fourthcoffee.local
   VERBOSE: full ADs path of member: LDAP://DC.fourthcoffee.local/CN=ChildGroup,CN=Users,DC=fourthcoffee,DC=local~
   ...
   VERBOSE: Could not get Domain Name using DSCrackNames, will parse ADs Path to get it
   VERBOSE: ParentGroup: "contoso\ParentGroup" ChildGroup: "fourthcoffee\ChildGroup"
   ```

1. Check the Windows system event logs of the time-correlated event ID 40970 as follows. You'll find the domain controller of the Service Principal Name (SPN) and the realm are from different domains. This event may not occur if the Kerberos authentication attempt is cached.

   ```output
   The Security System has detected a downgrade attempt when contacting the 3-part SPN LDAP/DC.contoso.local/fourthcoffee.LOCAL
   with error code "The SAM database on the Windows Server does not have a computer account for this workstation trust relationship. (0xc000018b)".
   Authentication was denied.
   ```

1. If so, you've identified the issue successfully.

## Additional information

This issue can also occur if the **Discover objects within Active Directory groups** option is enabled in System or User Discovery scope settings. In this case, here are the steps to check logs and identify the issue. You can also temporarily disable the option for the discovery scopes in which you have groups with members from other domains.

1. Increase the size of the _ADSysDis.log_ or _ADUsrDis.log_ file to 100 megabytes (MB) or more to accommodate a full Active Directory system or user discovery. Under one of the following registry keys, change the `MaxFileSize` registry value to `104857600` (the default value is `2621440`).

   - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SMS_AD_SYSTEM_DISCOVERY_AGENT`

   - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SMS_AD_USER_DISCOVERY_AGENT`

1. Enable verbose logging for the _ADSysDis.log_ or _ADUsrDis.log_ file. Under one of the following registry keys, change the `Verbose Logs` registry value to `1` (the default value is `0`).

   - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_AD_SYSTEM_DISCOVERY_AGENT`

   - `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_AD_USER_DISCOVERY_AGENT`

1. Run a full Active Directory system or user discovery and make sure the following message is logged in the _ADSysDis.log_ or _ADUsrDis.log_ file upon completion.

   `INFO: CADSource::fullSync returning 0x00000000~`

1. Filter by the thread ID that logged the above message and find the following message in the filtered logs.

   `VERBOSE : Could not get Domain Name using DSCrackNames, will parse ADs Path to get it`

1. Check the following lines around. You'll find a group and its member are from different domains.

   ```output
   INFO: Processing discovered group object with ADsPath = 'LDAP://DC1.CONTOSO.COM/CN=GROUP1,OU=OU,DC=CONTOSO,DC=COM'~
   VERBOSE: group not found in discovered group list~
   VERBOSE: Bound to group.~
   VERBOSE: group has 3 members~
   ...
   VERBOSE: full ADs path of member: LDAP://DC2.fourthcoffee.com/CN=Machine1,OU=US,DC=fourthcoffee,DC=com~
   ...
   VERBOSE: Could not get Domain Name using DsCrackNames, will parse ADs Path to get it
   VERBOSE: domain = 'FourthCoffee' full domain name = 'fourthcoffee.com'
   INFO: DDR was written for system 'Machine1' - C:\ConfigMgr\inboxes\auth\ddm.box\adsqznjr.DDR at <Date Time>.~
   ```

1. If so, you've identified the issue successfully.
