---
title: Fix Microsoft Edge profile that won't load or is locked
description: Fix a Microsoft Edge profile that won't load, is locked, or shows a profile error message at startup. Follow these steps to recover your profile.
ms.date: 05/29/2026
ms.reviewer: Johnyy.Xu, dili, v-shaywood
ms.custom: 'sap:Security and Privacy\Profiles and Sync: Caches, Favorites, Autofill, Wallet'
---

# Fix a Microsoft Edge profile that won't load or shows an error

## Summary

This article helps you recover a Microsoft Edge user profile that won't load, appears locked, or shows a profile error message at startup. Use these steps if Edge experiences an error when it starts, doesn't switch profiles, opens by having empty bookmarks or history or extensions, or blocks you from creating a new profile. Common causes include a profile folder that's in use by another process, a read-only user data folder, sync problems, and restrictive enterprise policies.

## Symptoms

You experience one or more of the following symptoms:

- A banner appears at startup that reads as follows:

  > Your profile cannot be opened correctly. Some features may be unavailable.

- If you switch to another profile, you receive the following error message:

  > Something went wrong

- Bookmarks, history, or extensions appear empty after startup.
- You can't create a profile.

## Solution

Work through the following sections in the given order. After each section, restart Edge, and check whether the profile loads cleanly before you continue.

### Verify that no other Edge process holds the profile

Follow these steps:

1. Open Task Manager: Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd>.
1. End all `msedge.exe` processes.
1. Restart Edge.

### Check that the user data folder is writable

Roaming profile storage or aggressive antivirus software can make the user data folder read-only. Follow these steps:

1. Right-click *%LOCALAPPDATA%\Microsoft\Edge\User Data*, and then select **Properties**.
1. On the **General** tab, verify that **Read-only** is cleared.
1. On the **Security** tab, verify that the current user has **Modify** permission.

### Reset sync for the profile

1. Go to `edge://settings/profiles`.
1. Select the affected profile, select **Sign out**, and then sign back in.

For broader sync problems, see [Diagnose and fix Microsoft Edge sync issues](/deployedge/microsoft-edge-troubleshoot-enterprise-sync).

### Create another profile and migrate data manually

1. Close Edge.
1. Go to *%LOCALAPPDATA%\Microsoft\Edge\User Data*, and rename the affected profile folder (for example, rename *Default* to *Default.bak*).
1. Start Edge to create a fresh profile.
1. Close Edge, and then copy individual files (such as *Bookmarks*) from the backup folder to the new profile folder.

### Check enterprise policies that restrict profile creation

1. Go to `edge://policy`.
1. Look for the following policies:
   - [BrowserSignin](/deployedge/microsoft-edge-policies/browsersignin)
   - [RestrictSigninToPattern](/deployedge/microsoft-edge-policies/restrictsignintopattern)
   - [BrowserAddProfileEnabled](/deployedge/microsoft-edge-policies/browseraddprofileenabled)
   - [EdgeAllowedAccountOnly](/deployedge/microsoft-edge-policies/edgeallowedaccountonly).
1. If any of these policies block the profile that you need, contact your administrator.

## Data collection

If you have to contact Microsoft Support for more help, collect the following diagnostic information to include in your support request:

- **Microsoft Edge version**: Go to `edge://version`, and note the full version number.
- **Active policies**: Go to `edge://policy`, and select **Export to JSON** to export the policy list.
- **Profile folder contents**: Capture a directory listing of *%LOCALAPPDATA%\Microsoft\Edge\User Data\\\<ProfileFolder>* that shows file sizes and timestamps.

## Related content

- [Troubleshoot common sign-in problems](troubleshoot-sign-in-issues.md)
- [Create Microsoft Edge user data directory variables](/deployedge/edge-learnmore-create-user-directory-vars)
