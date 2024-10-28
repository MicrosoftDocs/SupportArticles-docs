---
title: Tenant restrictions for Power Automate desktop machine registration
description: Provides a resolution for an error that occurs when you register a machine to a tenant in Power Automate for desktop.
ms.reviewer: guco, johndund, aartigoyle
ms.date: 10/18/2024
ms.custom: sap:Desktop flows\Administration issues
---
# Tenant restrictions for Power Automate desktop machine registration

This article provides guidelines for resolving tenant restrictions when you [register a machine](/power-automate/desktop-flows/manage-machines#register-a-new-machine) to a tenant in Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5017807

## Symptoms

When you try to [register a machine](/power-automate/desktop-flows/manage-machines#register-a-new-machine) to a tenant, the registration might fail with one of the following errors:
- > UnauthorizedTenantSwitching

- > UnauthorizedRegistrationToUnjoinedTenant

- > UnauthorizedRegistrationToNonAllowListedTenant

## Cause

These registration errors occur when you try to register your machine to an unauthorized tenant or don't have the administrator privileges required to perform the action. Administrator privileges are required to:

- Change the tenant that a machine is registered to.
- Register a Microsoft Entra-joined machine to a tenant that's different from its Microsoft Entra ID tenant.

These tenant restrictions prevent malicious actors from using Power Automate for desktop to control a machine over the network. To allow non-administrators to perform these actions, you can configure Windows registry settings as described in the following section.

## Resolution

An administrator can use Windows registry settings to control which tenants can run Power Automate desktop scripts on the machine. In addition, running the registration app as an administrator overrides the tenant restrictions.

Initial machine registration doesn't require administrator privileges but changing the registration restrictions does.

[!INCLUDE [Registry disclaimer](../../../includes/registry-important-alert.md)]

### Allow machine registration to specific tenants

We recommend that you define a list of allowed tenants that your machines can register to and add them to the registration tenants allowlist. Your machine will then always allow registration to the tenants in the allowlist and deny registration to any other tenant.

If you use [connect with sign-in](/power-automate/desktop-flows/desktop-flow-connections#connect-with-sign-in-for-attended-runs) to perform an attended run, and the target machine is Active Directory (AD) domain-joined but not Microsoft Entra-joined, you're required to add the tenant to the **AllowedRegistrationTenants** allowlist. For more information, see [Connect with sign-in security update on AD domain-joined machines](connect-with-sign-in-security-update.md).

> [!IMPORTANT]
> You can use the following steps to add your tenant to the allowlist on a single machine. However, we recommend consulting with your domain administrators to create a Group Policy Object (GPO) that applies the appropriate allowlist across all your machines. Creating such a GPO can centrally specify which tenants are trusted to use Power Automate for desktop on the machines in your tenant.

To define the allowlist:

1. Run the Registry Editor (regedit.exe).
2. Navigate to this key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Registration`.
3. Select **Edit** > **new** > **string value** to create a new string value named **AllowedRegistrationTenants**.
4. Double-click the value and set its data field to a comma separated list of the tenant IDs to which the machine is allowed to register.

   For example: 3EF1d993-CBD4-4DEA-A50E-939AEDB23F21,5B19777D-814C-43F3-9317-CDBAD0846ED8  

   > [!NOTE]
   >
   > - To find your tenant ID from the [Power Automate portal](https://make.powerautomate.com/), see [Allowlist tenants for registration and connect with sign-in connections](/power-automate/desktop-flows/how-to/allowlist-tenant-for-connect-with-sign-in-and-registration).
   > - To find your tenant ID from the [Power Apps portal](https://make.powerapps.com/), go to **Settings** and select **Session details**.

If setting up the tenant allowlist isn't possible for some reasons, see the following sections on how to [allow registration to a tenant other than the machine joined Microsoft Entra tenant](#allow-machine-registration-to-a-tenant-other-than-the-machine-joined-microsoft-entra-tenant) or [allow switching to another tenant](#allow-switching-machine-registration-to-another-tenant).

### Validate machine registration when the service starts

The registration restrictions are only applied when you try to register the machine. Starting with version 2.31, you can configure Power Automate for desktop to check if the current machine registration is allowed when the Power Automate service (UIFlowService) starts. If the registration isn't allowed, the machine can't connect to Power Automate cloud services.

To enable continuous validation:

1. Run the Registry Editor (regedit.exe).
2. Navigate to this key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Registration`.
3. Select **Edit** > **new** > **DWORD (32 bit) value** to create a new DWORD value named **EnforceRegistrationTenantRestrictionsOnServiceStart**.
4. Double-click the new value and set its data field to **1**. Any value other than **1** disables this setting.

### Disallow ability to override tenant restrictions

An administrator can override tenant restrictions and register machines regardless of the registry settings. To disable the ability for an administrator to override tenant restrictions:

1. Run the Registry Editor (regedit.exe).
2. Navigate to this key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Registration`.
3. Create a new DWORD value (**Edit** > **new** > **DWORD (32 bit) value**) named **DisableTenantChangeRegistrationAdminOverride**.
4. Double-click the new value and set its data field to **1**.

### Allow machine registration to a tenant other than the machine joined Microsoft Entra tenant

1. Run the Registry Editor (regedit.exe).
2. Navigate to this key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Registration`.
3. Select **Edit** > **new** > **DWORD (32 bit) value** to create a new DWORD value named **AllowRegisteringOutsideOfAADJoinedTenant**.
4. Double-click the new value and set its data field to **1**. Any value other than **1** disables this setting.

> [!IMPORTANT]
> If you define the allowlist using **AllowedRegistrationTenants** registry setting (recommended method), that setting will override the **AllowRegisteringOutsideOfAADJoinedTenant** setting.

### Allow switching machine registration to another tenant

1. Run the Registry Editor (regedit.exe).
2. Navigate to this key: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Registration`.
3. Select **Edit** > **new** > **DWORD (32 bit) value** to create a new DWORD value named **AllowTenantSwitching**.
4. Double-click the new value and set its data field to **1**. Any value other than **1** disables this setting.

> [!IMPORTANT]
> If you define the allowlist using **AllowedRegistrationTenants** registry setting (recommended method), that setting will override the **AllowTenantSwitching** setting.
