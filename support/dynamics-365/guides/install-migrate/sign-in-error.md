---
title: Sign-in error when trying to sign into Guides on a shared HoloLens device 
description: Learn how to resolve an error when trying to sign into Dynamics 365 Guides on a shared device license
author: davepinch
ms.author: davepinch
ms.topic: troubleshooting-general 
ms.date: 09/09/2023
ms.custom: bap-template
---

# Can't sign in to the Guides PC or HoloLens app

## Symptoms

Common problems that might occur when trying to log into the Guides PC app or HoloLens app.

## Cause 1: Wrong account used

Your using a Microsoft account (an account used for Outlook.com, Windows Store, or other Microsoft products) or your corporate credentials to sign in.

### Resolution

You must use the Dynamics 365 Guides sign-in credentials for your organization. For example: `johndoe@contoso.onmicrosoft.com`.

## Cause 2: Network isn't configured correctly

Connection through a proxy or VPN isn't configured correctly.

### Resolution

[Configure a VPN or proxy for Dynamics 365 Guides](/dynamics365/mixed-reality/guides/admin-deployment-playbook#vpn-or-proxy-configuration).

## Cause 3: Don't have permission

You might not have permission to access Guides or it isn't set up correctly.

### Resolution

Contact your admin.

## Cause 4: Wrong version

Your client app version doesn't support your Guides solution version.

### Resolution

Update your client app or contact your admin.

## Cause 4: No license

You don't have a license to use Guides.

### Resolution

Contact your admin or [sign up for a free trial subscription](dynamics365/mixed-reality/guides/setup).