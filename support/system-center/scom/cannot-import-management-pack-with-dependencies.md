---
title: Can't import a management pack with dependencies
description: Fixes an issue that importing a management pack in System Center Operations Manager fails when a dependent management pack isn't imported.
ms.date: 04/15/2024
---
# Importing a management pack fails in Operations Manager if a dependent management pack isn't imported

This article provides a workaround to solve the issue that you can't import a management pack if a dependent management pack isn't imported in System Center Operations Manager.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager, System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2698846

## Summary

When importing a management pack in System Center Operations Manager that has a dependency on another management pack, the import may fail with the following message:

> \<ManagementPackName> could not be imported.
>
> If any management packs in the Import list are dependent on this management pack, the installation of the dependent management packs will fail.  
> The requested management pack was invalid. See inner exception for details.  
> Parameter name: managementPack

## Workaround

This issue occurs because a management pack that the management pack being imported depends on isn't imported in the management group. In order to work around this problem, import the dependent management packs first then import the management packs that depend on them.

> [!NOTE]
> If you're unsure of the dependencies for a management pack, see [Management pack libraries and dependencies](/system-center/scom/manage-overview-management-pack#management-pack-libraries-and-dependencies).
