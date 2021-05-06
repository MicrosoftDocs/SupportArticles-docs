---
title: Error when users navigate to Office Groups in IE11
description: This article provides a resolution for the problem that occurs when users navigate to Office Groups in IE11 in Microsoft Dynamics CRM Online 2016 Update 0.1.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# When users navigate to Office Groups in IE11 in Microsoft Dynamics CRM Online 2016 Update 0.1, the users may receive a prompt (Sign in to Office 365)

This article helps you resolve the problem that occurs when users navigate to Office Groups in IE11 in Microsoft Dynamics CRM Online 2016 Update 0.1.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 3146979

## Symptoms

When users navigate to Office 365 Groups in IE11 in Microsoft Dynamics CRM Online 2016 Update 0.1, users may receive a **Sign in to Office 365** prompt. When choosing to **Sign In** the dialog redirects to a blank page.

## Cause

This issue occurs when `*.dynamics.com` is in the Trusted Sites in IE 11, but `https://login.microsoftonline.com` and `https://login.windows.net` are not in the Trusted Sites. These sites need to be in the same security zone for the authentication to work as expected.

## Resolution

Verify all three of the following sites are listed in IE's Trusted Sites. To do this follow these steps:

1. Open Internet Explorer
1. Click the gear icon in the top-right corner
1. Click **Internet Options**
1. Click the **Security** tab
1. Click **Trusted Sites**
1. Click on the **Sites** button
1. Add the following URLs:

    - `*.dynamics.com`
    - `https://login.microsoftonline.com`
    - `https://login.windows.net`

## More information

This issue occurs when using Microsoft Dynamics CRM Online 2016 Update 0.1.
