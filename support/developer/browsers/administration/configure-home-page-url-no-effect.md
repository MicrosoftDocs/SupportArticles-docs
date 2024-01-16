---
title: Configure the home page URL takes no effect
description: This article provides a resolution for the problem where the Policy Configure the home page URL takes no effect in Microsoft Edge.
ms.date: 01/29/2021
ms.custom: sap:Administration
ms.reviewer: heikom, daleche
ms.topic: troubleshooting
---
# Policy "Configure the home page URL" takes no effect in Microsoft Edge

[!INCLUDE [](../../../includes/browsers-important.md)]

_Original product version:_ &nbsp; Edge for Mac, Edge for Windows  
_Original KB number:_ &nbsp; 4570005

## Symptoms

As an Administrator, you configured the Group Policy **Configure the home page URL** under `Administrative Templates\Microsoft Edge\Startup` in both the home page and the new tab page.

The policy is applied to the user, but the home page button directs to the new tab page.

## Cause

Microsoft Edge can be configured to open a custom home page or a new tab page.

You will find the configuration settings here: **edge://settings/appearance** in Microsoft Edge.

## Resolution

Set the additional policy **Set the new tab page as the home page** to **Disabled** in Microsoft Edge.
