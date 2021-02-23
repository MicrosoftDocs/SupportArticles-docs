---
title: Can't open a web app on iOS
description: Fixes an issue in which you can't open a Web App on an iOS device with the 'Safari cannot open the page because the address is invalid' error message.
ms.date: 03/27/2020
ms.prod-support-area-path: App management
ms.reviewer: joelste, intunecic, stephgil
---
# 'Safari cannot open the page because address is invalid' error when you open a web app on iOS

This article fixes an issue in which you can't open a Web App on an iOS device with the **Safari cannot open the page because the address is invalid** error message.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4487249

## Symptoms

When you select a Web App that's deployed to an Apple iOS device, you receive the following error message:

> Safari cannot open the page because the address is invalid

## Cause

This issue occurs if both the following conditions are true:

- The Web App configuration in the Intune console has the **Require a managed browser to open this link** option set to **Yes**.
- The Intune Managed Browser for iOS app isn't installed on the device.

## Resolution

To fix this issue, either install the Intune Managed Browser on the iOS device or set the **Require a managed browser to open this link** option in the policy to **No**.
