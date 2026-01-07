---
title: Delta AD Group Discovery skips the membership discovery for a group scope in child OU of other group scope
description: Troubleshoot an issue when AD Delta Discovery fails to detect group membership change.
ms.date: 01/06/2026
ms.reviewer: kaushika, jarrettr, brianhun, payur
ms.custom: sap:Boundary Groups, Discovery and Collections\Active Directory Discovery (all types)
---
# Delta AD Group Discovery skips detecting the membership change for a group scope in child OU of other group in discovery scopes

This article describes how to identify and resolve an issue in which Active Directory Group Discovery fails to detect group membership changes.

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Symptoms

You set up an Active Directory Group Discovery to target specific AD Groups as discovery scopes as per [Configure Active Directory Group Discovery](https://learn.microsoft.com/en-us/intune/configmgr/core/servers/deploy/configure/configure-discovery-methods#bkmk_config-adgd).

You notice that AD Group Delta Discovery fails to catch the changes in certain group membership. At the same time, forcing a Full Discovery cycle resolves the issue.

In particular, this happens when the following conditions are met:

- Scope A: Group A located in organizational unit OU-A
- Scope B: Group B located in organizational unit OU-B
- OU-B is located under OU-A (being, then, a child OU)

If all above conditions are met, changes in Group B's membership are not detected by AD Group Delta Discovery.

## Cause

During AD Group Delta Discovery, Configuration Manager detects the organizational units (OUs) of the target groups in discovery scopes and builds a tree structure of OUs. It ignores the child OUs of the target groups' OUs.

## Resolution

This issue is fixed in [Configuration Manager current branch, version 2203](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2203).

If the issue still occurs after upgrading to version 2203 and later versions, make sure that you meet the requirements for establishing the Kerberos connection from the site server to the domain controllers of the target domain. For example:

- TCP traffic on port 88 (Kerberos) is allowed.
- TCP and UDP traffic on port 389 (LDAP and CLDAP) is allowed.
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
