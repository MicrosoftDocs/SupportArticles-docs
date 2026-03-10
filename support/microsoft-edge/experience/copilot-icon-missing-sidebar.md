---
title: Troubleshoot Copilot Icon Not Showing in Edge Sidebar
description: Resolve the missing Copilot icon in Microsoft Edge sidebar with step-by-step troubleshooting for settings, policies, browser updates, and account availability.
ms.date: 03/10/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: "sap:Experiences and Services\AI Experiences: Copilot and Sidebar"
---

# Copilot icon doesn't appear in Microsoft Edge sidebar

## Summary

This article helps you troubleshoot the issue where the Copilot icon doesn't appear in the Microsoft Edge sidebar. The icon might be missing because the sidebar is disabled, Copilot is turned off in sidebar settings, Group Policy blocks Copilot or the sidebar, the Edge version is outdated, or Copilot isn't available for your region or account. Follow the steps in this article to identify and resolve the issue.

## Symptoms

You experience one or more of the following issues:

- The Edge sidebar isn't visible.
- The Edge sidebar is visible, but there's no Copilot entry in it.
- The Copilot icon was previously visible in the sidebar but disappeared after a browser update, policy change, or profile switch.

## Solution

Work through the following checks in order. After each section, check whether the Copilot icon appears in the sidebar before you proceed to the next.

### Verify that the Edge sidebar is enabled

The sidebar might be turned off entirely. When the sidebar is disabled, all sidebar apps, including Copilot, are hidden.

1. Open Microsoft Edge and go to `edge://settings/appearance/copilotAndSidebar`.
1. Select **Always on**.

> [!NOTE]
> If the sidebar settings are unavailable, a Group Policy might be controlling this setting. Skip to [Check Group Policy and organization settings](#check-group-policy-and-organization-settings).

### Verify that Copilot is enabled in sidebar app settings

The sidebar might be enabled, but the Copilot app could be individually turned off.

1. Open Microsoft Edge and go to `edge://settings/appearance/copilotAndSidebar`.
1. Under **App specific settings**, find and select **Copilot**.
1. Make sure the toggle for **Show Copilot button on the toolbar** is turned on.
1. If Copilot doesn't appear in the app list, restart Microsoft Edge.

### Check Group Policy and organization settings

Your IT administrator might have configured policies that disable the sidebar, block Copilot, or block the Copilot extension.

#### Check sidebar and Copilot policies

1. Open Microsoft Edge and go to `edge://policy` to view all active policies.
1. Search for the [HubsSidebarEnabled](/deployedge/microsoft-edge-policies#hubssidebarenabled) policy and check its value. If set to **Disabled**, the entire sidebar is hidden, including Copilot.
1. If the policy is set to **Disabled**, contact your IT administrator to set it to **Enabled** or **Not Configured**.

#### Check the ExtensionInstallBlocklist policy

1. In `edge://policy`, search for **ExtensionInstallBlocklist** and check whether:
   - A wildcard (`*`) entry blocks all extensions
   - The Copilot extension ID `ofefcgjbeghpigppfmkologfjadafddi` is explicitly listed.
1. If the Copilot extension ID `ofefcgjbeghpigppfmkologfjadafddi` is in the block list, contact your IT administrator to remove it.
1. If a wildcard (`*`) is used, make sure the Copilot extension ID (`ofefcgjbeghpigppfmkologfjadafddi`) is added to the [ExtensionInstallAllowlist](/deployedge/microsoft-edge-policies#extensioninstallallowlist) policy.

After any policy changes, restart Microsoft Edge for the changes to take effect.

> [!TIP]
> You can export all applied policies from `edge://policy` and share the export file with your IT administrator for review.

### Update Microsoft Edge to the latest version

Copilot in the Edge sidebar requires a recent version of Microsoft Edge (version 111 or later). An outdated browser might not have the Copilot feature available.

1. Open Microsoft Edge and go to `edge://settings/help`.
1. Wait for Edge to check for updates and install the latest version.
1. Restart Microsoft Edge after the update is complete.

### Verify regional availability and account type

Copilot might not be available in your region or for your account type. Availability depends on geographic location, license assignments, and tenant-level settings.

1. Go to `edge://settings/profiles` and confirm that you're signed in with a valid Microsoft account (personal, work, or school).
1. Check whether Copilot is available in your region. For details, see [Supported regions and languages in Microsoft Copilot](https://support.microsoft.com/topic/supported-regions-and-languages-in-microsoft-copilot-26de43a1-c176-4908-bef7-29c8c37ac7ce).
1. If you're using a work or school account, check with your IT administrator to confirm whether Copilot is enabled for your organization's Microsoft 365 tenant.
1. Try signing out and signing back in, or try a different account to determine whether the issue is account-specific.

### Test in a new browser profile

A corrupted browser profile or conflicting settings from other extensions might prevent the Copilot icon from appearing.

1. Select the profile icon in the upper-left corner of Microsoft Edge.
1. Select **Add profile** > **Add**.
1. In the new profile, check whether the Copilot icon appears in the sidebar.
1. If the icon appears in the new profile, the issue is related to your original profile. To resolve it in the original profile, follow these steps:
   1. Go to `edge://settings/reset`.
   1. Select **Restore settings to their default values**.

> [!CAUTION]
> Resetting browser settings restores the startup page, new tab page, search engine, and pinned tabs to their defaults. It also disables all extensions and clears temporary data such as cookies. Your favorites, history, and saved passwords aren't affected.

## Data collection

If you need to contact Microsoft Support for further assistance, collect the following diagnostic information:

- **Microsoft Edge version**: Go to `edge://settings/help` and note the full version number.
- **Active policies**: Go to `edge://policy` and export the policy list.
- **Sidebar settings**: Go to `edge://settings/sidebar` and take a screenshot of the current settings.
- **Account type**: Note whether you're using a personal, work, or school account.
- **Operating system version**: In Windows, go to **Settings** > **System** > **About** and note the OS version.

## Related content

- [Manage the sidebar in Microsoft Edge](/deployedge/microsoft-edge-sidebar)
- [Configure Microsoft Edge policy settings](/deployedge/configure-microsoft-edge)
- [Microsoft Copilot in Edge](/copilot/edge)
