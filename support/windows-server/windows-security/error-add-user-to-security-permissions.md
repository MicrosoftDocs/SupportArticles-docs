---
title: Maximum number of access control entries in the access control list
description: Describes an issue that occurs when you reach the maximum size of the access control list.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: jlambert, kaushika
ms.custom: sap:Windows Security Technologies\AD Object Permissions, access control, delegation, AdminSDHolder and auditing, csstroubleshoot
---
# Maximum number of access control entries in the access control list

This article describes an issue that occurs when you reach the maximum size of the access control list.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 166348

## Symptoms

When you add users or groups to the security permissions of an object share, file, or directory, you may receive the following error message:

> You have exceeded the operating system's limit on the number of users and groups that can be in a security information structure. Remove some users or groups and try the operation again.

Additionally, when you use Cacls.exe to perform this function, you may receive the following error message:

> The parameter is incorrect.

## Cause

This issue occurs when you reach the maximum size of the access control list (ACL). The size of an ACL varies with the number and size of its access control entries (ACEs). The maximum size of an ACL is 64 kilobytes (KB), or approximately 1,820 ACEs. However, for performance reasons, the maximum size isn't practical.  

## More information

For more information about security descriptors and ACLs, go to the following Microsoft website:

[How Access Control Works in Active Directory Domain Services](/windows/win32/ad/how-access-control-works-in-active-directory-domain-services)
