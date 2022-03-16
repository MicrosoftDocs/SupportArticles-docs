---
title: Resource domain is changed after installing January 2022 Windows updates
description: Troubleshoot an issue in which domain of discovered resources changes after installing January 2022 Windows updates if the NetBIOS domain is different than FQDN.
ms.date: 03/16/2022
ms.reviewer: jarrettr, brianhun, payur
---
# Domain name of resource is changed after installing January 2022 Windows updates

This article describes how to identify and resolve an issue in which resource domain is changed after installing January 2022 Windows updates.

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Symptoms

After you install January 2022 or later Windows updates on a Configuration Manager site server, the domain name associated with users, groups, or devices may be changed. This issue occurs when the NetBIOS domain name is different than the first element of the fully qualified domain name (FQDN).

For example, a resource is in a domain with the NetBIOS domain name `AAA`, but with the FQDN `BBB.contoso.com`. This scenario is known as a disjoint namespace. The resource is discovered as `AAA\User1` or `AAA\Computer1`. After you install January 2022 Windows updates and discovery runs, the resource name may be changed to `BBB\User1` or `BBB\Computer1`.

The domain name of the resource may alternate between `AAA` and `BBB`, which has the effect of removing or adding devices to collections that have rules based on a domain membership.

## Cause

January 2022 Windows updates introduced an NTLM fallback that may [block NTLM authentication if Kerberos authentication isn't successful](https://support.microsoft.com/topic/dd415f99-a30c-4664-ba37-83d33fb071f4), which changes the behavior in Configuration Manager current branch versions earlier than 2203.

## Resolution

This issue is fixed in [Configuration Manager current branch, version 2203](/mem/configmgr/core/servers/manage/updates).

## Workaround

To work around this issue, change collection rules to include both the NetBIOS domain name and the DNS domain name.

## Steps to check logs and identify the issue

Here's how to check logs and identify the issue:

1. Increase the size of the _ADSgDis.log_ file to 100 megabytes (MB). Under the following registry key, change the `MaxFileSize` registry value to `104857600` (default value is `2621440`).

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Tracing\SMS_AD_SECURITY_GROUP_DISCOVERY_AGENT`

1. Enable verbose logging for the _ADSgDis.log_ file. Under the following registry key, change the `Verbose Logs` registry value to `1` (default value is `0`).

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_AD_SECURITY_GROUP_DISCOVERY_AGENT`

1. Run a full Active Directory group discovery and make sure the following message is logged in the _ADSgDis.log_ file.

   `INFO: Succeeded running full sync stored procedure`

1. Filter by the thread that logged the above message and find the following message in the filtered logs.

   `VERBOSE : Could not get Domain Name using DSCrackNames, will parse ADs Path to get it`

1. Check the following lines. You'll find a group and its member are from different domains.

   ```output
   INFO: DDR was written for group 'contoso\DSCrackNamesW' - C:\ConfigMgr\inboxes\auth\ddm.box\userddrsonly\asg1607o.DDR at <Date Time>.~ 
   VERBOSE: group has 1 members~
   …
   VERBOSE: Domain controller name for the SID is: \\CM-UDC.fourthcoffee.local
   VERBOSE: full ADs path of member: LDAP://CM-UDC.fourthcoffee.local/CN=UTCGroup5,CN=Users,DC=fourthcoffee,DC=local~
   …
   VERBOSE: Could not get Domain Name using DSCrackNames, will parse ADs Path to get it
   VERBOSE: ParentGroup: "contoso\DSCrackNamesW" ChildGroup: "fourthcoffee\UTCGroup5"
   ```

1. Check the Windows event logs for the time-correlated event ID 40970 as follows. You'll find the domain controller of the Service Principal Name (SPN) and the realm are from different domains. This issue may occur if the Kerberos authentication attempt is cached.

   ```output
   The Security System has detected a downgrade attempt when contacting the 3-part SPN LDAP/CMCB-DC.contoso.local/fourthcoffee.LOCAL with error code "The SAM database on the Windows Server does not have a computer account for this workstation trust relationship. (0xc000018b)".
   Authentication was denied.
   ```

1. If so, you've identified the issue successfully.
