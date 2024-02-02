---
title: Give users access to Group Policy Objects
description: Describes how to give users permission to access the Group Policy object if the Access Control List (ACL) has been modified so that Read and Apply permissions are restricted.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, ROBINGER
ms.custom: sap:group-policy-management-gpmc-or-agpm, csstroubleshoot
ms.subservice: group-policy
---
# How to give users access to Group Policy Objects

This article describes how to give users permission to access the Group Policy object if the Access Control List (ACL) has been modified so that Read and Apply permissions are restricted.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 273857

## Summary

You may not be able to apply a Group Policy object if the Access Control List (ACL) has been configured to restrict Read and Apply permissions for the Group Policy object.

## More information

By default, if you're a member of the Authenticated Users group, you have access to Group Policy objects. The Authenticated Users group has Read and Apply Group Policy permissions on Group Policy objects. If the Authenticated Users group is removed from the ACL on the Group Policy object, then you don't have Read and Apply permissions for that Group Policy object.

As an administrator, you can give users access to the Group Policy object by using either of the following methods:

- Add the user to the ACL on the Group Policy object explicitly, and then give this user Read and Apply Group Policy permissions.
- Give the Authenticated Users group Read and Apply Group Policy permissions.
- Create a security group, add the necessary users to this group, and then give this group Read and Apply Group Policy permissions on the ACL of the Group Policy object.

> [!NOTE]
> You must also ensure that the user, or the group that the user belongs to, isn't explicitly denied access to the Group Policy object. An explicit Deny permission always overrides an Allow permission.
