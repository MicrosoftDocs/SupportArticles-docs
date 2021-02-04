---
title: Only one app policy applied to Edge or Managed Browser
description: Fixes an issue in which only one Intune app configuration policy is applied to Edge or Managed Browser.
ms.date: 05/18/2020
ms.prod-support-area-path: iOS app configuration profiles
ms.reviewer: intunecic, Announ.Diall
---
# Only one Intune app configuration policy is applied to Edge or Managed Browser

This article fixes an issue in which only one Intune app configuration policy is applied to Edge or Managed Browser.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4492694

## Symptoms

When you use Microsoft Intune to assign multiple configuration profiles that make the same settings to either Microsoft Edge or the Managed Browser app, only the settings in one of the profiles is applied.

## Cause

Intune does not currently support merging Edge or Managed Browser policies.

## Resolution

To resolve this issue, configure a setting in only a single app configuration policy for each or group. For example, if you want to assign different Edge bookmarks to different groups, you can create and assign a different app configuration policy to each group, and make sure that no users exist in both groups. To do this, follow these steps (for example):

1. Create one app that is assigned to the **All Users** group.
2. Create two different app configuration policies that are associated with the same app.
3. Assign *app configuration policy 1* that has setting **1** to include the **All Users** group, and exclude the selected group that will be targeted to the *app configuration policy 2*.
4. Assign *app configuration policy 2* that uses setting **2** to include the selected group.

## More information

For more information, see the following articles:

- [Manage web access using a Microsoft Intune policy-protected browser](/mem/intune/apps/app-configuration-managed-browser)
- [Manage web access by using Microsoft Edge with Microsoft Intune](/mem/intune/apps/manage-microsoft-edge)
