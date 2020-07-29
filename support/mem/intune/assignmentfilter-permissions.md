---
title: AssignmentFilter permissions in Endpoint Manager admin center
description: Introduces the new AssignmentFilter permissions added in Endpoint Manager admin center to support an in-development feature.
author: helenclu
ms.author: luche
ms.reviewer: jchornbe
ms.date: 07/29/2020
ms.prod-support-area-path: Administrator roles
---
# AssignmentFilter permissions in Endpoint Manager admin center

In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), when you select **Tenant administration**, you may notice a new set of permissions, which is called **AssignmentFilter**. These permissions are included in support of an in-development preview feature. They don't impact any production capabilities in Endpoint Manager and can be safely ignored.

## Summary

The AssignmentFilter permissions include the following permissions:

- Create
- Delete
- Read
- Update

These permissions apply to the following built-in roles:

| Role | Permissions |
| --- | :---: |
| Policy and Profile Manager | Create, Delete, Read, Update |
| School Administrator | Create, Delete, Read, Update |
| Help Desk Operator | Read |
| Application Manager | Create, Delete, Read, Update |
| Endpoint Security Manager | Read |
| Read Only Operator | Read |

These permissions can also be added to any new or existing custom roles.
