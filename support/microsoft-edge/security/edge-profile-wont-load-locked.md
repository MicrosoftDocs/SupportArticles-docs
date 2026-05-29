---
title: Fix Microsoft Edge Profile That Won't Load or Is Locked
description: Fix a Microsoft Edge profile that won't load, is locked, or shows a profile error on launch. Follow these steps to recover your profile now.
ms.date: 05/29/2026
ms.reviewer: Johnyy.Xu, dili, v-shaywood
ms.custom: 'sap:Security and Privacy\Profiles and Sync: Caches, Favorites, Autofill, Wallet'
---

# Fix a Microsoft Edge profile that won't load or shows an error

## Summary

This article helps you recover a Microsoft Edge user profile that won't load, appears locked, or shows a profile error on launch. Use these steps if Edge shows a profile error on launch, fails to switch profiles, opens with empty bookmarks, history, or extensions, or blocks you from creating a new profile. Common causes include a profile folder that's in use by another process, a read-only user data folder, sync problems, and restrictive enterprise policies.

## Symptoms

You experience one or more of the following symptoms:

- A banner on launch says:

  > Your profile cannot be opened correctly. Some features may be unavailable.

- Switching profiles shows the following error:

  > Something went wrong

- Bookmarks, history, or extensions appear empty after launch.
- You can't create a new profile.

## Solution

Work through the following sections in order. After each section, relaunch Edge and check whether the profile loads cleanly before you continue.

### Confirm no other Edge process holds the profile

1. Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Esc</kbd> to open Task Manager.
1. End all `msedge.exe` processes.
1. Relaunch Edge.

### Check that the user data folder is writable

Roaming profile storage or aggressive antivirus software can make the user data folder read-only.

1. Right-click *%LOCALAPPDATA%\Microsoft\Edge\User Data*, and then select **Properties**.
1. On the **General** tab, confirm that **Read-only** is cleared.
1. On the **Security** tab, confirm that the current user has **Modify** permission.

### Reset sync for the profile

1. Go to `edge://settings/profiles`.
1. Select the affected profile, select **Sign out**, and then sign back in.

For broader sync issues, see [Diagnose and fix Microsoft Edge sync issues](/deployedge/microsoft-edge-troubleshoot-enterprise-sync).

### Create a new profile and migrate data manually

1. Close Edge.
1. Go to *%LOCALAPPDATA%\Microsoft\Edge\User Data* and rename the affected profile folder (for example, rename *Default* to *Default.bak*).
1. Launch Edge to create a fresh profile.
1. Close Edge, and then copy individual files (like *Bookmarks*) from the backup folder to the new profile folder.

### Check enterprise policies that restrict profile creation

1. Go to `edge://policy`.
1. Look for [BrowserSignin](/deployedge/microsoft-edge-policies/browsersignin), [RestrictSigninToPattern](/deployedge/microsoft-edge-policies/restrictsignintopattern), [BrowserAddProfileEnabled](/deployedge/microsoft-edge-policies/browseraddprofileenabled), and [EdgeAllowedAccountOnly](/deployedge/microsoft-edge-policies/edgeallowedaccountonly).
1. If any of these policies block the profile you need, contact your administrator.

## Data collection

If you need to contact Microsoft Support for more help, collect the following diagnostic information and include it with your support request.

- **Microsoft Edge version**: Go to `edge://version`, and note the full version number.
- **Active policies**: Go to `edge://policy`, and select **Export to JSON** to export the policy list.
- **Profile folder contents**: Capture a directory listing of *%LOCALAPPDATA%\Microsoft\Edge\User Data\\\<ProfileFolder>* that shows file sizes and timestamps.

## Related content

- [Troubleshoot common sign-in problems](troubleshoot-sign-in-issues.md)
- [Create Microsoft Edge user data directory variables](/deployedge/edge-learnmore-create-user-directory-vars)
