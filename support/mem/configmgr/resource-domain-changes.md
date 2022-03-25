---
title: Resource domain is changed after installing January 2022 Windows updates
description: Troubleshoot an issue in which domain of discovered resources changes after installing January 2022 Windows updates if the NetBIOS domain is different than FQDN.
ms.date: 03/16/2022
ms.reviewer: jarrettr, brianhun, payur
---
# Domain name of resource is changed after installing January 2022 Windows updates

This article describes how to identify and resolve an issue in which resource domain is changed after you install January 2022 Windows updates.

_Applies to:_ &nbsp; Configuration Manager (current branch)

## Symptoms

After you install January 2022 or later Windows cumulative updates on a Configuration Manager site server, the domain name that is associated with users, groups, or devices may be changed. This issue occurs when the NetBIOS domain name (also known as the pre-Windows 2000 domain name) is different from the first element of the fully qualified domain name (FQDN).

For example, a resource is in a domain with the NetBIOS domain name `AAA`, but with the FQDN `BBB.contoso.com`. The resource is discovered as `AAA\User1` or `AAA\Computer1`. After you install January 2022 Windows updates and the discovery runs, the resource name may be changed to `BBB\User1` or `BBB\Computer1`.

The domain name of the resource may alternate between `AAA` and `BBB`, which removes or adds devices to collections that have rules based on a domain membership.

## Cause

January 2022 Windows updates introduced an NTLM fallback that may [block NTLM authentication if Kerberos authentication isn't successful](https://support.microsoft.com/topic/dd415f99-a30c-4664-ba37-83d33fb071f4), which changes the behavior in Configuration Manager current branch.

## Resolution

This issue is under investigation and will be resolved in a future release of Configuration Manager current branch.

## Workaround

To work around this issue, change collection rules to include both the NetBIOS domain name and the DNS domain name.

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
   …
   VERBOSE: Domain controller name for the SID is: \\DC.fourthcoffee.local
   VERBOSE: full ADs path of member: LDAP://DC.fourthcoffee.local/CN=ChildGroup,CN=Users,DC=fourthcoffee,DC=local~
   …
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
