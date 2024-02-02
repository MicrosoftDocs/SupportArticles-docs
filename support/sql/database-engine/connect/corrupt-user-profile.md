---
title: Troubleshooting the Windows user profile issue 
description: This article provides a resolution for issues that are caused by a corrupted Windows user profile.
ms.date: 01/29/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Windows user profile can't be loaded

This article helps you resolve issues that occur because of because of a corrupted Windows user profile.

## Symptoms

You receive the following error message:

> The User Profile Service service failed the sign-in. User profile cannot be loaded.

## Cause

If you log in as the affected user, you'll get a [temporary profile](/windows/win32/shell/temporary-user-profiles). This is a good indication that the user profile is corrupted or that you're a guest user.

## Resolution

If you're a guest user, then you must be added to the appropriate groups.

If you aren't a guest user, follow the steps in [Fix a corrupted user profile in Windows](https://support.microsoft.com/windows/fix-a-corrupted-user-profile-in-windows-1cf41c18-7ce3-12f9-8e1d-95896661c5c9) to either repair the profile or delete and re-create the profile.
