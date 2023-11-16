---
title: Apps and APIs require access
description: Explains that some applications and APIs must have access to the token-groups-global-and-universal (TGGAU) attribute on user account objects, or on computer account objects in the Active Directory directory service.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, davemm
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Some applications and APIs require access to authorization information on account objects

This article describes some applications and application programming interfaces (APIs) must have access to the token-groups-global-and-universal (TGGAU) attribute on user account objects, or on computer account objects in the Active Directory directory service.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 331951

## Summary

Some applications have features that read the token-groups-global-and-universal (TGGAU) attribute on user account objects or on computer account objects in the Microsoft Active Directory directory service. Some Win32 functions make it easier to read the TGGAU attribute. Applications that read this attribute or that call an API (referred to as a function in the rest of this article) that reads this attribute don't succeed if the calling security context doesn't have access to the attribute.

By default, access to the TGGAU attribute is determined by the **Permission Compatibility** decision (made when the domain was created during the DCPromo.exe process). The default permission compatibility for new Windows Server 2003 domains doesn't grant broad access to the TGGAU attribute. Access to read the TGGAU attribute can be granted as required to the new **Windows Authorization Access** (WAA) group in Windows Server 2003.

## More information

The token-groups-global-and-universal (TGGAU) attribute is a dynamically computed value on computer account objects and on user account objects in Active Directory. This attribute enumerates the global group memberships and the universal group memberships for the corresponding user account or computer account. Applications can use the group information that is provided by the TGGAU attribute to make various decisions about a specific user when the user isn't logged on.

For example, an application can use this information to determine whether a user has been granted access to a resource that the application controls access for. Applications that require this information can read the TGGAU attribute directly by using either Lightweight Directory Access Protocol interfaces or Active Directory Services Interfaces. However, Microsoft Windows Server 2003 introduced several functions (including the AuthzInitializeContextFromSid function and the LsaLogonUser function) that simplify reading and interpretation of the TGGAU attribute. Therefore, applications that use these functions may unknowingly be reading the TGGAU attribute.

For applications to be able to directly read this attribute or indirectly read this attribute (through the use of an API), the security context that the application runs in must have been granted read access to the TGGAU object on the user objects and on the computer objects. You do not expect applications to assume that they have access to TGGAU. Therefore, you can expect applications to be unsuccessful when access is denied. In this situation, you (the user) may receive an error message or a log entry that explains that access was denied while trying to read this information, and that provides instructions about how to obtain access (as described later in this article).

Several existing applications depend on the information that is provided by TGGAU because the information is available by default in Microsoft Windows NT 4.0 and in earlier operating systems. So on Microsoft Windows 2000 and Windows Server 2003 operating systems, read access to the TGGAU attribute is granted to the **Pre-Windows 2000 Compatible Access** group.

For domains that use existing applications, you can handle these applications by adding the security contexts that those applications run as to the **Pre-Windows 2000 Compatible Access** group. Instead, you can select the **"Permissions compatible with pre-Windows 2000 servers"** option during the DCPromo process when you create a domain. (On Windows Server 2003, this option is worded as follows: **"Permissions compatible with pre-Windows 2000 server operating systems"**.) This selection adds the **Everyone** group to the **Pre-Windows 2000 Compatible Access** group, and thereby grants the **Everyone** group read access to the TGGAU attribute and to many other domain objects.

When a new Windows Server 2003 domain is created, the default access compatibility selection is **Permissions compatible only with Windows 2000 or Windows Server 2003 operating systems**. When this option is set, the **Pre-Windows 2000 Compatibility Access** group includes only the Authenticated Users built-in security identifier, and read access to the TGGAU attribute on objects is limited. In this case, applications that require access to the TGGAU group are denied access unless the account under which the applications run has domain administrator rights or similar user rights.

## Enabling Applications to read the TGGAU attribute

To simplify the process of granting read access on the token-groups-global-and-universal (TGGAU) attribute to users who must read the attribute, Windows Server 2003 introduces the Windows Authorization Access (WAA) group.

On new installations of Windows Server 2003 domains, the WAA group is granted access to the read TGGAU attribute on user objects and on group objects.

### Windows 2000 Domains

If the domain is in pre-Windows 2000 compatibility access mode, the **Everyone** group has read access to the TGGAU attribute on user account objects and on computer account objects. In this mode, applications and functions have access to TGGAU.

If the domain isn't in pre-Windows 2000 compatibility access mode, you may have to enable certain applications to read the TGGAU. Because the **Windows Authorization Access Group** doesn't exist on Windows 2000, it's recommended that you create a domain local group for this purpose, and that you add the user or computer account that requires access to the TGGAU attribute to that group. This group would have to be given access to the `tokenGroupsGlobalAndUniversal` attribute on user objects, on computer objects, and on `iNetOrgPerson` objects.

### Mixed mode domains and upgraded domains

When a Windows Server 2003 domain controller is added to a Windows 2000 domain, the access compatibility selection that was previously selected isn't changed. So mixed mode domains and domains that were upgraded to Windows Server 2003 that were in pre-Windows 2000 compatibility access mode continue to have the **Everyone** group in the **Pre-Windows 2000 Compatibility Access** group. Additionally, the **Everyone** group still has access to the TGGAU attribute. In this mode, applications and functions have access to TGGAU.

If the mixed mode domain isn't in pre-Windows 2000 compatibility access mode, you can grant permissions by means of the WAA group:

- The WAA group is automatically created when a Windows Server 2003 domain controller is promoted to the Floating Single Master Operations Server.
- The WAA group isn't automatically granted access to the TGGAU attribute on mixed-mode domains and on upgraded domains.

After the Windows Authorization Access (WAA) group has access to the TGGAU attribute, you can place the accounts that require access in the WAA group.

### New Windows Server 2003 Domains

If the domain is in pre-Windows 2000 compatibility access mode, the **Everyone** group has read access to the TGGAU attribute on user account objects and on computer account objects. In this mode, applications and functions have access to TGGAU.

If the domain isn't in pre-Windows 2000 compatibility access mode, add to the WAA group those accounts that require access to TGGAU. In new installations of Windows Server 2003, the WAA group already has read access to TGGAU on user objects and on computer objects.
