---
title: Custom pages and components failed to load with SDK script error
description: Describes an issue in which custom pages, the Microsoft 365 app launcher, or Power Apps components don't load.
ms.reviewer: rashb
ms.topic: troubleshooting
ms.date: 10/21/2021
ms.author: rashb
---
# Custom pages and client SDK script don't load for Power Apps

_Applies to:_ &nbsp; Power Apps

## Symptoms

Custom pages, the Microsoft 365 app launcher (also known as "the waffle"), or other Power Apps components don't load. A network trace shows various issues that affect calls with request URLs, such as:

- `https://apps.powerapps.com/apphost/clientsdk?version=1`
- `https://content.powerapps.com/resource/webplayer/hashedresources/ikhj4ts3cqjq9/js/PowerAppsHostingSdk.bundle.v1.js`

## Cause

The content delivery network is blocked because of the firewall or network settings on the client. Additionally, an AppHostClient SDK request fails and displays status code **0**. In this case, your organization receives the following error message:

> The script `https://apps.powerapps.com/apphost/clientsdk?version=1` didn't load correct.

## Resolution

To fix this issue, make sure that [all services to which Power Apps Studio talks and their usages](/powerapps/maker/canvas-apps/limits-and-config#required-services) are not blocked by the firewall or network settings.
