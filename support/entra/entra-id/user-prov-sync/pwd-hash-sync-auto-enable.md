---
title: Password Hash Synchronization is automatically enabled in Microsoft Entra connector
description: Fixes a problem in which Password Hash Synchronization is automatically enabled in Microsoft Entra connector.
ms.date: 05/28/2020
ms.reviewer: 
ms.service: entra-id
ms.custom: sap:Microsoft Entra Connect Sync, no-azure-ad-ps-ref
---
# Password Hash Sync is automatically enabled during Microsoft Entra Connect Pass-through Authentication

This article can help you fix a problem in which Password Hash Synchronization is automatically enabled in Microsoft Entra connector.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 4051623

The following versions of Microsoft Entra Connect have issues that affect the **Change user sign-in** task:

- 1.1.557.0
- 1.1.558.0
- 1.1.561.0
- 1.1.614.0

These issues affect the Pass-through Authentication users who don't want to use Password Hash Synchronization.

The issues are fixed in [Microsoft Entra Connect version 1.1.644.0](/azure/active-directory/connect/active-directory-aadconnect-version-history).

## Problem 1: Password Synchronization is enabled when User sign-in method is set to Pass-through Authentication

### Scenario 1

- You have an existing Microsoft Entra Connect deployment that has both Password Synchronization and Pass-through Authentication disabled.
- After you enable Pass-through Authentication by using the **Change user sign-in** task, Password Hash Synchronization is automatically enabled.

### Scenario 2

- You have an existing Microsoft Entra Connect deployment that has Password Synchronization disabled and Pass-through Authentication enabled.
- After you enable or disable the **Seamless Single Sign-on** option by using the **Change user sign-in** task, Password Hash Synchronization is automatically enabled.

### Background information about this issue

- Prior to Microsoft Entra Connect version 1.1.557.0, Password Synchronization was a prerequisite for enabling Pass-through Authentication. Therefore, Password Synchronization was enabled when Pass-through Authentication was enabled.
- Because Password Synchronization is no longer required for Pass-through Authentication, we changed this process in Microsoft Entra Connect version 1.1.557.0 so that it does not enable Password Synchronization when Pass-through Authentication is enabled during a Microsoft Entra Connect installation.
- However, the same change was not applied to the **Change user sign-in** task. If you use the task to enable Pass-through Authentication to an existing Microsoft Entra Connect deployment, Password Synchronization is automatically enabled. This issue is fixed in [Microsoft Entra Connect version 1.1.644.0](/azure/active-directory/connect/active-directory-aadconnect-version-history) to make sure that Password Hash Synchronization remains disabled when Pass-through Authentication is enabled by using the **Change user sign-in** task.

## Problem 2: Incorrect prompt about disabled Password Synchronization if User sign-in method is set to Pass-through Authentication

- You have an existing Microsoft Entra Connect deployment that has Password Synchronization enabled and Pass-through Authentication disabled.
- After you enable Pass-through Authentication by using the **Change user sign-in** task, Password Hash Synchronization remains enabled.

### Background information about this issue

By design, if Password Hash Synchronization is enabled, changing the user sign-in task to any other option does not disable Password Hash Synchronization. This issue is fixed in [Microsoft Entra Connect version 1.1.644.0](/azure/active-directory/connect/active-directory-aadconnect-version-history) to prevent the display of the prompt window that states that Password Hash Synchronization is disabled.

## Resolution

To resolve this issue, follow these steps:

1. Run Microsoft Entra Connect, and then select **View current configuration**. In the details pane, check whether **Password synchronization** is **enabled** on your tenant.

    :::image type="content" source="media/pwd-hash-sync-auto-enable/password-synchronization.png" alt-text="Screenshot shows the Password synchronization status is enabled.":::

2. Disable the **Password synchronization** feature. To do this, follow these steps:

   1. Run Microsoft Entra Connect, and then select **Configure**.
   2. Select the **Customize synchronization options** task.
   3. On the **Optional features** page, clear the **Password synchronization** feature check box.
   4. Complete the wizard.

Optionally, if you want to clear password hashes that are already synchronized to Microsoft Entra ID, follow these steps:

1. Make sure that the **Password writeback** feature is **disabled** on your tenant. To do that, follow these steps:

   1. Run Microsoft Entra Connect, and then select **Configure**.
   2. Select the **Customize synchronization options** task.
   3. On the **Optional features** page, clear the **Password writeback** feature check box.
   4. Complete the wizard.
2. Use the [Reset-MgUserAuthenticationMethodPassword](/powershell/module/microsoft.graph.identity.signins/reset-mguserauthenticationmethodpassword) cmdlet to set random passwords on all affected users. You have to run this cmdlet five times for each user because Microsoft Entra ID stores the last four password hashes in the password hash history.

>[!NOTE]
> The Reset-MgUserAuthenticationMethod cmdlet does not work if the user is using a federated domain. To clear password hashes for the user in the federated domain, you must change the UPN of the user to a non-federated domain, and then run the cmdlet to set the random password. After that, revert the UPN of the user to the original state.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
