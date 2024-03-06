---
title: Can't open a web app on iOS
description: Fixes an issue in which you can't open a web app on an iOS device with the 'Safari cannot open the page because the address is invalid' error message.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:App management
ms.reviewer: kaushika, joelste, intunecic, stephgil
---
# Address is invalid error when opening a web app on iOS

This article fixes an issue in which you can't open a web app on an iOS device, and receive the error message: **Safari cannot open the page because the address is invalid**.

## Symptoms

When you select a web app that's deployed to an iOS device, you receive the following error message:

> Safari cannot open the page because the address is invalid

## Cause

This issue occurs if both the following conditions are true:

- The web app configuration in the Intune console has the **Require a managed browser to open this link** option set to **Yes**.
- The Intune Managed Browser for iOS app isn't installed on the device.

## Solution

To fix this issue, either install the Intune Managed Browser on the iOS device or set the **Require a managed browser to open this link** option in the policy to **No**.
