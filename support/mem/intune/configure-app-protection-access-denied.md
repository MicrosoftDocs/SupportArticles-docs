---
title: Access denied when configuring MAM
description: Fixes an issue in which an administrator receives the Access Denied error when they configure Intune App Protection Conditional Access.
ms.date: 05/11/2020
ms.prod-support-area-path: App management
---
# Intune Service Administrator gets Access Denied when trying to configure MAM

This article fixes the **Access Denied** error when an administrator configures Intune App Protection **Conditional Access**.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4025997

## Symptoms

Assume that an administrator isn't in the Global Administrator role but is in the Intune Service Administrator role. When they try to configure Intune App Protection (MAM) **Conditional Access**, an **Access Denied** error occurs.

## Cause

The Intune Service Administrator must be given explicit **Contributor** role permission to access MAM Conditional Access blades.

## Resolution

To fix this issue, grant the permission under **Intune App Protection** -> **Settings** -> **Exchange Online** -> **Resource Management** -> **Users**.

![Screenshot of user permission.](./media/configure-app-protection-access-denied/permission.png)

## Reference

For more information, see [Administrator role permissions in Azure Active Directory](/azure/active-directory/users-groups-roles/directory-assign-admin-roles).
