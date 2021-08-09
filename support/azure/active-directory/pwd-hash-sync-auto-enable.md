---
title: Password Hash Synchronization is automatically enabled in Azure AD connector
description: Fixes a problem in which Password Hash Synchronization is automatically enabled in Azure AD connector.
ms.date: 05/28/2020
ms.prod-support-area-path: 
ms.reviewer: 
---
# Password Hash Sync is automatically enabled during Azure AD Connect Pass-through Authentication

This article can help you fix a problem in which Password Hash Synchronization is automatically enabled in Azure AD connector.

_Original product version:_ &nbsp; Azure Active Directory  
_Original KB number:_ &nbsp; 4051623

The following versions of Microsoft Azure Active Directory (AD) Connect have issues that affect the **Change user sign-in** task:

- 1.1.557.0
- 1.1.558.0
- 1.1.561.0
- 1.1.614.0

These issues affect the Pass-through Authentication users who don't want to use Password Hash Synchronization.

The issues are fixed in [Azure AD Connect version 1.1.644.0](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnect-version-history).

## Problem 1: Password Synchronization is enabled when User sign-in method is set to Pass-through Authentication

### Scenario 1

- You have an existing Azure AD Connect deployment that has both Password Synchronization and Pass-through Authentication disabled.
- After you enable Pass-through Authentication by using the **Change user sign-in** task, Password Hash Synchronization is automatically enabled.

### Scenario 2

- You have an existing Azure AD Connect deployment that has Password Synchronization disabled and Pass-through Authentication enabled.
- After you enable or disable the **Seamless Single Sign-on** option by using the **Change user sign-in** task, Password Hash Synchronization is automatically enabled.

### Background information about this issue

- Prior to Azure AD Connect version 1.1.557.0, Password Synchronization was a prerequisite for enabling Pass-through Authentication. Therefore, Password Synchronization was enabled when Pass-through Authentication was enabled.
- Because Password Synchronization is no longer required for Pass-through Authentication, we changed this process in Azure AD Connect version 1.1.557.0 so that it does not enable Password Synchronization when Pass-through Authentication is enabled during an Azure AD Connect installation.
- However, the same change was not applied to the **Change user sign-in** task. If you use the task to enable Pass-through Authentication to an existing Azure AD Connect deployment, Password Synchronization is automatically enabled. This issue is fixed in [Azure AD Connect version 1.1.644.0](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnect-version-history) to make sure that Password Hash Synchronization remains disabled when Pass-through Authentication is enabled by using the **Change user sign-in** task.

## Problem 2: Incorrect prompt about disabled Password Synchronization if User sign-in method is set to Pass-through Authentication

- You have an existing Azure AD Connect deployment that has Password Synchronization enabled and Pass-through Authentication disabled.
- After you enable Pass-through Authentication by using the **Change user sign-in** task, Password Hash Synchronization remains enabled.

### Background information about this issue

By design, if Password Hash Synchronization is enabled, changing the user sign-in task to any other option does not disable Password Hash Synchronization. This issue is fixed in [Azure AD Connect version 1.1.644.0](https://docs.microsoft.com/azure/active-directory/connect/active-directory-aadconnect-version-history) to prevent the display of the prompt window that states that Password Hash Synchronization is disabled.

## Resolution

To resolve this issue, follow these steps:

1. Run Azure AD Connect, and then select **View current configuration**. In the details pane, check whether **Password synchronization** is **enabled** on your tenant.

   :::image type="content" source="./media/password-hash-sync-auto-enable-pass-through-auth/4051644_en_1.png" alt-text="Screenshot of checking Password synchronization status.":::

2. Disable the **Password synchronization** feature. To do this, follow these steps:

   1. Run Azure AD Connect, and then select **Configure**.
   2. Select the **Customize synchronization options** task.
   3. On the **Optional features** page, clear the **Password synchronization** feature check box.
   4. Complete the wizard.

Optionally, if you want to clear password hashes that are already synchronized to Azure AD, follow these steps:

1. Make sure that the **Password writeback** feature is **disabled** on your tenant. To do that, follow these steps:

   1. Run Azure AD Connect, and then select **Configure**.
   2. Select the **Customize synchronization options** task.
   3. On the **Optional features** page, clear the **Password writeback** feature check box.
   4. Complete the wizard.
2. Use the [Set-MsolUserPassword](https://docs.microsoft.com/powershell/module/msonline/set-msoluserpassword?view=azureadps-1.0&preserve-view=true) cmdlet to set random passwords on all affected users. You have to run this cmdlet five times for each user because Azure AD stores the last four password hashes in the password hash history.

>[!NOTE]
> The Set-MsolUserPassword cmdlet does not work if the user is using a federated domain. To clear password hashes for the user in the federated domain, you must change the UPN of the user to a non-federated domain, and then run the cmdlet to set the random password. After that, revert the UPN of the user to the original state.
