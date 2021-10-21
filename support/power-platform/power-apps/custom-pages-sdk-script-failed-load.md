---
title: Custom pages and components failed to load with SDK script error
description: Describes an issue in which custom pages, Microsoft 365 app launcher, or Power Apps components failed to load.
ms.reviewer: rashb
ms.topic: troubleshooting
ms.date: 10/21/2021
author: simonxjx
ms.author: v-six
---
# Custom pages and SDK script failed to load for Power Apps

_Applies to:_ &nbsp; Power Apps

## Symptoms

Custom pages, Microsoft 365 app launcher (sometimes called the waffle), or other Power Apps components are not loading. If you collect a network trace, you will find there are issues for calls with request URLs that look like the following.

- `https://apps.powerapps.com/apphost/clientsdk?version=1`
- `https://content.powerapps.com/resource/webplayer/hashedresources/ikhj4ts3cqjq9/js/PowerAppsHostingSdk.bundle.v1.js`

## Cause

The content delivery network is blocked because of the firewall or network setting on the client, and AppHostClient SDK request fails with the status code 0. Your organization experiences the following error message when monitoring failures.

> The script `https://apps.powerapps.com/apphost/clientsdk?version=1` didn't load correct.

## Resolution

To fix this issue, make sure that [all services to which Power Apps Studio talks and their usages](/powerapps/maker/canvas-apps/limits-and-config#required-services) are not blocked by the firewall or network setting.
