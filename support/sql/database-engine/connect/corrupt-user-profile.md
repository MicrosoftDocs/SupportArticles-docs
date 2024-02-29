---
title: Troubleshooting the corrupt user profile error 
description: This article provides symptoms and resolution for the corrupt user profile error.
ms.date: 12/15/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Corrupt user file error

This article helps you to resolve the corrupt user profile error.

## Symptoms

If you log in as the affected user, you'll get a temporary profile. This is a good indication that the profile is corrupt or you're a guest user. If you're a guest user, then you must be added to the appropriate groups.

## Resolution

If you aren't a guest user, follow the steps explained in [Fix a corrupted user profile in Windows](https://support.microsoft.com/windows/fix-a-corrupted-user-profile-in-windows-1cf41c18-7ce3-12f9-8e1d-95896661c5c9) to either (a) repair the profile or (b) delete and recreate the profile.

## See also

[Troubleshoot consistent authentication issues](consistent-authentication-connectivity-issues.md)
---
title: Troubleshooting Windows user profile issue in SQL Server
description: This article addresses SQL Server consistent authentication issues related to the Windows user profile.
ms.date: 02/28/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Windows user profile can't be loaded in SQL Server

This article helps you resolve issues that occur because of a corrupted Windows user profile.

## Symptoms

You receive the following error message:

> The User Profile Service service failed the sign-in. User profile cannot be loaded.

## Cause

If you log in as the affected user, you'll get a [temporary profile](/windows/win32/shell/temporary-user-profiles). This is a good indication that the user profile is corrupted or that you're a guest user.

## Resolution

If you're a guest user, then you must be added to the appropriate groups. For more information, see [Add or delete users](/entra/fundamentals/add-users).

If you aren't a guest user, follow the steps in [Fix a corrupted user profile in Windows](https://support.microsoft.com/windows/fix-a-corrupted-user-profile-in-windows-1cf41c18-7ce3-12f9-8e1d-95896661c5c9) to either repair the profile or delete and re-create the profile.
