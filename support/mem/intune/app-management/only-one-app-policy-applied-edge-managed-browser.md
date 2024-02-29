---
title: Only one Intune app policy applied to Edge or Managed Browser
description: Fixes an issue in which only one Microsoft Intune app configuration policy is applied to Edge or Managed Browser.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:iOS app configuration profiles
ms.reviewer: kaushika, intunecic, Announ.Diall
---
# Only one Intune app configuration policy is applied to Edge or Managed Browser

This article fixes an issue in which only one Microsoft Intune app configuration policy is applied to Edge or Managed Browser. For the most recent guidance, see [Manage web access by using Edge for iOS and Android ](/mem/intune/apps/manage-microsoft-edge).

## Symptoms

When you use Intune to assign multiple configuration profiles that make the same settings to either Microsoft Edge or the Managed Browser app, only the settings in one of the profiles is applied.

## Cause

Intune does not currently support merging Edge or Managed Browser policies.

## Solution

To resolve this issue, configure a setting in only a single app configuration policy for each or group. For example, if you want to assign different Edge bookmarks to different groups, you can create and assign a different app configuration policy to each group, and make sure that no users exist in both groups. To do this, follow these steps (for example):

1. Create one app that is assigned to the **All Users** group.
2. Create two different app configuration policies that are associated with the same app.
3. Assign *app configuration policy 1* that has setting **1** to include the **All Users** group, and exclude the selected group that will be targeted to the *app configuration policy 2*.
4. Assign *app configuration policy 2* that uses setting **2** to include the selected group.
