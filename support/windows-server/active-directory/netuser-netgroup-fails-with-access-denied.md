---
title: NetUser/NetGroup APIs fail with ACCESS DENIED
description: An ACCESS DENIED error occurs with down-level APIs of the NetUser or NetGroup class like NetUserGetInfo or NetGroupGetInfo.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, herbertm, josefh
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Applications using NetUserGetInfo and similar APIs rely on read access to certain AD objects

This article discusses an issue where applications that use down-level APIs of the NetUser or NetGroup class like `NetUserGetInfo` or `NetGroupGetInfo` fails with the ACCESS DENIED error.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2281774

## Summary

You have an application that uses the down-level APIs of the NetUser or NetGroup class like `NetUserGetInfo`, `NetUserSetInfo`, `NetUserEnum`, `NetGroupGetInfo`, `NetGroupSetInfo`, `NetGroupEnum`, `NetLocalGroupGetInfo`, `NetLocalGroupSetInfo`, and `NetLocalGroupEnum`. In this scheme, the NetUser class APIs are also used to manage computer account.

The same APIs are used when you invoke the ADSI WINNT provider.

These APIs may fail with ACCESS DENIED although the calling account has sufficient permissions on the target accounts. The reason for this is that the client-side API implementation does not have a 1:1 relationship with Security Account Manager (SAM) RPC APIs. The client side performs additional checks and preparation for these calls that require additional permissions in Active Directory.

One application that uses these APIs is the cluster service, and in the cluster service log you will see:

> 00000a78.000021b8::2010/06/15-00:00:47.911 WARN [RES] Network Name \<cluster-resource1>: Couldn't determine if computer account cluster-resource1 is already disabled. status 5  

Another symptom of this effect might be excessive audit records in the Security Eventlog of your DCs for these API calls and the objects quoted below, if successful or failure access auditing for the calling account is enabled.

## More information

The implementation of the APIs uses multiple RPC calls directed at the Domain Controller, to set up the session and verify the domain. It accesses the following objects with read access:

- Domain Root Object: It looks up the primary domain of the Domain Controller and opens the domain for reading, which in turn opens the AD object for the domain, like DC=contoso,dc=com.

- Builtin container: This is the root object of the builtin domain. It is opened as the caller wants to verify its existence. Thus the caller needs read access to the container CN=Builtin,DC=contoso,dc=com.

- SAM server object: This object stores general permissions about general SAM account access and enumeration. It will be used on certain calls only. The object name is cn=server,cn=system,DC=contoso,dc=com.

In most Active Directory domains, permissions to these objects are granted based on the membership in generic groups like Authenticated Users, Everyone or the Pre-Windows 2000 Compatible Access group. The change to trigger the problem may have been that the user was removed from the last group (maybe together with Everyone, and/or the permissions on the objects listed were removed in a move to harden the Active Directory permissions.

The approaches to resolve the problem are to either grant the required read permissions or to change the application to use LDAP instead of the older APIs or the ADSI WINNT provider. LDAP will not touch the objects above and it will also support the granular permissions you may have set on the target object.

### Excessive auditing

When you have auditing enabled on these objects, you will see up to three audit records for the objects above for both opening and closing the objects, plus the actual target object access. If the events are logged excessively, it makes sense to remove the entries in the Auditing ACL so these generic access types are not logged anymore. The problem is that the Domain Root object and the Builtin Container inherit to many subordinate objects.

To solve this, you need to break inheritance at the builtin container and redefine the ACEs that inherit to only apply to this object. You also need to touch the ACEs on the Domain Root object so the problem SACEs don't apply to the domain root object anymore. The exact steps depend on the actual SACL settings that are in effect in your environment.
