---
title: No assets appear or assets aren't as expected in the HoloLens app
description: Resolves an issue where the assets in the HoloLens app for Microsoft Dynamics 365 Remote Assist aren't as expected or don't appear.
ms.author: davepinch
author: davepinch
ms.date: 10/27/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---
# Assets don't appear or aren't as expected in Dynamics 365 Remote Assist

This article provides a resolution for an issue where the assets don't appear or aren't shown as expected in Microsoft Dynamics 365 Remote Assist.

## Symptoms

In the HoloLens app, when you select the **Assets** tab, the assets aren't as expected or no assets appear.

## Cause 1: You might have access to more than one environment with Dynamics 365 Remote Assist installed

#### Resolution

To solve this issue, follow the steps:

1. Select **Settings** > **Dynamics 365 environment**.
1. Select the environment.
1. Select the **Assets** tab.
1. Select **Retry** if you're prompted on the **Assets** tab.

## Cause 2: Asset records aren't created in the environment

#### Resolution

To solve this issue, follow the steps:

1. Ensure that the environment you're using has [asset records](/dynamics365/mixed-reality/remote-assist/asset-capture-create-asset).
2. Select **Retry** if you're prompted on the **Assets** tab.

## Cause 3: Asset records are added while Dynamics 365 Remote Assist is open

This issue occurs when asset records are added from a model-driven app while Dynamics 365 Remote Assist is already open on your HoloLens or mobile device.

#### Resolution

To solve this issue, close the app and reopen it to install the latest updates.
