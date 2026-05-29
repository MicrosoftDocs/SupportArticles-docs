---
title: Fix Microsoft Edge not saving cookies or sign-in sessions
description: Fix Microsoft Edge if cookies and sign-in sessions don't persist after you close the browser. Follow these steps to stop repeated sign-in prompts.
ms.date: 05/29/2026
ms.reviewer: Johnny.Xu, dili, v-shaywood
ms.custom: 'sap:Security and Privacy\Profiles and Sync: Caches, Favorites, Autofill, Wallet'
---

# Fix Microsoft Edge not saving cookies or sign-in sessions across startups

## Summary

This article helps you fix an issue in which cookies or sign-in sessions don't persist in Microsoft Edge across browser startups. After you close and reopen Edge, sites prompt you to sign in again, **Remember me** options have no effect, and cookies disappear when you close the page. Browser privacy settings, tracking prevention, site permissions, enterprise policies, system clock drift, extensions, or a corrupted profile can cause this behavior. Work through the following checks to identify the cause and restore persistent cookies and sessions.

## Symptoms

You experience one or more of the following symptoms across multiple sites (not only one):

- After you close and reopen Microsoft Edge, sites require you to sign in again.
- Cookies that are set by a site disappear when you close the page.
- **Remember me** options on sign-in pages have no effect.

## Solution

Work through the following sections in the given order. After each section, restart Microsoft Edge, and check whether cookies persist before you continue to the next section.

### Verify that Edge isn't set to clear data upon closing

This setting deletes cookies every time that Edge closes. Follow these steps:

1. In Microsoft Edge, go to `edge://settings/privacy/clearBrowsingData/clearOnClose`.
1. Turn off **Cookies and other site data** and any other items you don't want to clear automatically upon closing.

If your organization manages this behavior, the related policies are [ClearBrowsingDataOnExit](/deployedge/microsoft-edge-policies/clearbrowsingdataonexit) and [SaveCookiesOnExit](/deployedge/microsoft-edge-policies/savecookiesonexit).

### Check tracking prevention exceptions

Strict tracking prevention can block third-party authentication cookies. Follow these steps:

1. Go to `edge://settings/privacy/trackingPrevention`.
1. Temporarily change **Tracking prevention** to **Basic**, and then test the site.
1. If the issue is fixed, revert the setting to **Balanced**, and then add the affected sign-in domain to the exceptions list at `edge://settings/privacy/trackingPreventionExceptions`.

For more information about tracking prevention, see [Tracking prevention in Microsoft Edge](/microsoft-edge/web-platform/tracking-prevention).

### Verify that the site isn't blocked from setting cookies

Follow these steps:

1. Go to `edge://settings/content/cookies`.
1. Turn on **Allow sites to save and read cookie data**.
1. Review the **Block** and **Clear on close** lists, and remove the affected site, if it's listed.

### Check enterprise policies

Enterprise policies can control cookie behavior. Follow these steps:

1. Go to `edge://policy`.
1. Look for the following policies:
   - [DefaultCookiesSetting](/deployedge/microsoft-edge-policies/defaultcookiessetting)
   - [CookiesBlockedForUrls](/deployedge/microsoft-edge-policies/cookiesblockedforurls)
   - [CookiesSessionOnlyForUrls](/deployedge/microsoft-edge-policies/cookiessessiononlyforurls).
1. If these policies prevent persistence on the site that you need, contact your administrator.

### Check the system clock and time zone

Authentication cookies often have short expiration periods. A clock skew of more than a few minutes might invalidate them.

1. Open **Settings** > **Time & language** > **Date & time**.
1. Turn on **Set time automatically** and **Set time zone automatically**.
1. Select **Sync now**.

### Disable extensions

A privacy or cookie-management extension can purge cookies in the background. Follow these steps:

1. Go to `edge://extensions/`.
1. Turn off all extensions, and then retest.
1. Turn extensions back on one at a time to identify the one that causes the problem.

### Test in a new profile

1. Go to `edge://settings/profiles`, and then select **Add profile**.
1. Reproduce the scenario in the new profile.
1. If cookies persist in the new profile, the original profile is likely corrupted.

## Data collection

If you have to contact Microsoft Support for more help, collect the following diagnostic information to include in your support request:

- **Microsoft Edge version**: Go to `edge://version`, and note the full version number.
- **Active policies**: Go to `edge://policy`, and export the policy list.
- **Network trace**: Capture a network trace that includes a sign-in and an Edge restart. To capture the trace, go to `edge://net-export/`.

## Related content

- [Diagnose and fix Microsoft Edge sync issues](/deployedge/microsoft-edge-troubleshoot-enterprise-sync)
- [Microsoft Edge sign-in and identity](/deployedge/microsoft-edge-security-identity)
- [Troubleshoot common sign-in problems](troubleshoot-sign-in-issues.md)
