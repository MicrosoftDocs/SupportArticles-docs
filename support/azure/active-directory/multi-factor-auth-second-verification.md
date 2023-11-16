---
title: Some users who are enabled for Azure Multi-Factor Authentication aren't prompted for a second verification method
description: Describes a scenario in which users who are enabled for Azure Multi-Factor Authentication aren't prompted for a second verification factor when they sign in.
ms.date: 05/22/2020
ms.reviewer: willfid
ms.service: active-directory
ms.subservice: authentication
---
# Some users who are enabled for Azure Multi-Factor Authentication aren't prompted for a second verification method

This article describes a scenario in which users who are enabled for Azure Multi-Factor Authentication aren't prompted for a second verification factor when they sign in.

_Original product version:_ &nbsp; Microsoft Entra ID, Cloud Services (Web roles/Worker roles), Microsoft Intune  
_Original KB number:_ &nbsp; 3124671

## Symptoms

When conditional access policies are set up so that Azure Multi-Factor Authentication is expected to be enforced, some users aren't prompted to verify their identities through a second verification method. This issue may occur in the following two scenarios.

**Scenario 1**: Multi-factor authentication is suspended on a remembered device:

In this scenario, an admin sets up trusted networks for multi-factor authentication and enables the **Allow users to suspend multi-factor authentication by causing a device to be remembered**  option.

**Scenario 2**: The user is a member of the exception group:

In this scenario, the user is a member of an exception group for the app. When an admin sets up multi-factor authentication access policies for an app, an admin can select the **Except** box to set up groups as exceptions. Even though the settings in these scenarios are configured, you expect users to be prompted for the second verification method because of the conditional access policies that you applied.

## Resolution

**For Scenario 1**:

1. Confirm that the **Allow users to suspend multi-factor authentication** option is enabled.
2. If the option is enabled, have the user try one or more of the following:
   - Delete browser cookies.
   - Use a different browser.
   - Use an InPrivate browsing session.

**For Scenario 2**:

- Remove the user from the exception group.
- Remove the group from the list of exception groups.

## More information

**For Scenario 1**:

This option lets users who have successfully authenticated through multi-factor authentication avoid future multi-factor authentication prompts for the next 1-60 days, depending on the value that's configured in the **Days before a device must re-authenticate** setting.

This is true even if the app is set to **Require multi-factor authentication,** **Require multi-factor authentication when not at work**, or **Block access when not at work**, and the user's device isn't on a trusted network.

**For Scenario 2**:

For users who are members of the exception group, the requirement for multi-factor authentication on the user account is overridden.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
