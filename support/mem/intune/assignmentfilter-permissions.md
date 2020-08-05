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

In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), you may notice a new permissions set that is named **AssignmentFilter** when you select **Tenant administration** > **Roles** > a supported role > **Properties**. The AssignmentFilter permissions are included to support an in-development preview feature. They don't affect any production capabilities in Endpoint Manager. Therefore, you can safely ignore them.

## Summary

The AssignmentFilter set includes the following permissions:

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

You can also add these permissions to any new or existing custom roles.
