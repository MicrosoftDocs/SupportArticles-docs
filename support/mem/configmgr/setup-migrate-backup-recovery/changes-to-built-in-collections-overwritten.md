---
title: Changes to built-in collections are overwritten
description: Describes an issue in which built-in collections that are changed in System Center 2012 Configuration Manager are reset to the default settings when you upgrade to System Center 2012 Configuration Manager SP1.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi
---
# Changes to built-in collections are overwritten when you upgrade to System Center 2012 Configuration Manager SP1

This article provides a workaround for the issue that built-in collections that are changed in Microsoft System Center 2012 Configuration Manager are reset to the default settings when you upgrade to System Center 2012 Configuration Manager Service Pack 1 (SP1).

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2739984

## Symptoms

Consider this scenario:

- You have System Center 2012 Configuration Manager installed.
- You change one or more of the built-in collections.
- You try to upgrade to System Center 2012 Configuration Manager SP1.

In this scenario, you receive the following warning message during the prerequisites check:

> One or more of the built-in collections has been modified. If you ignore this warning, these modifications will be overwritten by Configuration Manager setup.

If you proceed with the upgrade, the built-in collections are reset to the default settings during the upgrade process.

## Cause

This issue occurs because built-in collections are read-only and cannot be changed in System Center 2012 Configuration Manager SP1.

> [!NOTE]
> In System Center 2012 Configuration Manager, some built-in collections can be changed by administrators.

## Workaround

To work around the issue, copy the changed built-in collections before you upgrade to System Center 2012 Configuration Manager SP1, and then re-create the deployment after the upgrade process is complete.
