---
title: Set user permissions in the Opalis Integration Server client
description: Describes how to set user permissions on folders, policies, computer groups, variables, counters, and schedules in the Opalis Integration Server client.
ms.date: 08/03/2020
ms.prod-support-area-path: 
---
# Set user permissions in the Opalis Integration Server client

This article describes how to set user permissions on folders, policies, computer groups, variables, counters, and schedules in the Opalis Integration Server client.

_Original product version:_ &nbsp; System Center Orchestrator  
_Original KB number:_ &nbsp; 2023523

## Summary

By default the Opalis Integration Server system is configured to allow only members of the local Administrators group on the management server computer to view, modify and manage folders, policies, computer groups, variables, counters, and schedules. However, these permissions can be changed on object basis or inherited from a parent object using Access Control Lists (ACL) much like Windows NTFS permissions.

Permissions can be directly set to any folder, policy, computer group, variable, counter, or schedule. When working with folders, permissions can be set directly to the folder as well allowing any child objects to inherit the permissions.

## Set object permissions

To set permissions, do the following steps:

1. Right-click the folder, policy, computer group, variable, counter, or schedule to be modified and select the **Permissions...** button.
2. Add or remove users or groups as needed and grant the wanted permissions to each user/group.
3. Select the **Apply** button for the changes to take effect.
4. Click the **OK** button to close the **Permissions for...** dialog.

Any new explicit permission entries that are added are applied only to the specific object. To allow new permission entries to be applied to child objects, inheritance must be configured as outlined in [Set permission inheritance](#set-permission-inheritance).

## Set permission inheritance

Permission inheritance works in two parts:

- First the child object must be configured to allow permissions to be inherited from the parent (this is the default).
- Secondly the parent object must be configured to allow permissions to be inherited by child objects.

To configure the child object to allow inherited permissions from the parent object, do the following steps:

1. Right-click the folder to be modified and select the **Permissions...** button.
1. Select the **Advanced** button.
1. Select the checkbox **Allow inheritable permissions from the parent to propagate to this object and all child objects. Include these with entries explicitly defined here**.

1. Select the **Apply** button for the changes to take effect.
1. Click the **OK** button to close the **Advanced Security Settings for...** dialog.
1. Click the **OK** button to close the **Permissions for...** dialog.

To configure the parent object to allow permissions to be inherited by child items, do the following steps:

1. Right-click the folder to be modified and select the **Permissions...** button.
1. Select the **Advanced** button.
1. To allow permissions that this object inherited to be applied to child objects, select the checkbox **Allow inheritable permissions from the parent to propagate to this object and all child objects. Include these with entries explicitly defined here**.

1. Select one of your explicit entries from the **Permission entries** window, and then select the **Edit...** button.
1. From the **Apply onto** drop-down list, select **This object and all child objects**.
1. Repeat steps 4 and 5 for any additional explicit permission entries.
1. Select the **Apply** button for the changes to take effect.
1. Click the **OK** button to close the **Advanced Security Settings for...** dialog.
1. Click the **OK** button to close the **Permissions for...** dialog.
