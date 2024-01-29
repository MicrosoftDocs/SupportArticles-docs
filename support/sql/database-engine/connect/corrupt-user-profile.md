---
title: Troubleshooting the corrupt user profile 
description: This article provides symptoms, cause, and resolution for the Windows user profile being corrupted.
ms.date: 01/29/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Windows user profile can't be loaded

This article helps you to resolve issues that might arise because of the Windows user profile being corrupted.

## Symptoms

You might see the following error message:

> The User Profile Service service failed the sign-in. User profile cannot be loaded.

## Cause

If you log in as the affected user, you'll get a [temporary profile](/windows/win32/shell/temporary-user-profiles). This is a good indication that the profile is corrupt or you're a guest user. If you're a guest user, then you must be added to the appropriate groups.

## Resolution

If you aren't a guest user, follow the steps explained in [Fix a corrupted user profile in Windows](https://support.microsoft.com/windows/fix-a-corrupted-user-profile-in-windows-1cf41c18-7ce3-12f9-8e1d-95896661c5c9) to either (a) repair the profile or (b) delete and recreate the profile.
