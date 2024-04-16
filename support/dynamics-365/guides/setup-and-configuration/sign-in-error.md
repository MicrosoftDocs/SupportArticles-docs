---
title: Can't sign in to the Guides PC or HoloLens app 
description: Provides a resolution for an issue where you can't sign in to the Dynamics 365 Guides PC app or the HoloLens app.
author: davepinch
ms.author: davepinch
ms.reviewer: v-wendysmith, mhart
ms.date: 10/27/2023
ms.custom: sap:Setup and configuration
---
# Can't sign in to the Dynamics 365 Guides PC app or the HoloLens app

This article lists common issues that cause failures when you try to sign in to the Microsoft Dynamics 365 Guides PC app or the Microsoft HoloLens app.

## Cause 1: Wrong account used

You use a Microsoft account (an account used for `Outlook.com`, Windows Store, or other Microsoft products) or your corporate credentials to sign in.

#### Resolution

You must use the Dynamics 365 Guides sign-in credentials for your organization. For example, `johndoe@contoso.onmicrosoft.com`.

## Cause 2: Network isn't configured correctly

Connection through a proxy or VPN isn't configured correctly.

#### Resolution

To solve this issue, see [configure a VPN or proxy for Dynamics 365 Guides](/dynamics365/mixed-reality/guides/admin-deployment-playbook#vpn-or-proxy-configuration).

## Cause 3: Don't have permission

You might not have permission to access Dynamics 365 Guides or your permission isn't set up correctly.

#### Resolution

To solve this issue, contact your administrator.

## Cause 4: Wrong version

Your client app version doesn't support your Dynamics 365 Guides solution version.

#### Resolution

To solve this issue, update your PC and HoloLens apps by installing the latest version from the Microsoft Store or contact your administrator.

## Cause 5: No license

You don't have a license to use Dynamics 365 Guides.

#### Resolution

To solve this issue, [sign up for a free trial subscription](/dynamics365/mixed-reality/guides/setup) or contact your administrator.
