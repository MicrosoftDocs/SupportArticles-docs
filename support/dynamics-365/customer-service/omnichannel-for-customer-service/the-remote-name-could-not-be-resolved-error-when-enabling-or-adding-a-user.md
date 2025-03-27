---
title: The Remote Name Could Not Be Resolved Error When Enabling Or Adding a user
description: Solves the "The remote name could not be resolved" error when enabling or adding a user in Microsoft Dynamics 365 Contact Center.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/27/2025
ms.reviewer: skarkouti, vparanjape, srubinstein
ms.custom: sap:Voice channel , DFM
---
# "The remote name could not be resolved" error when enabling or adding a user

This article provides guidance on resolving the "The remote name could not be resolved"  error that occurs when you try to enable or add a user in an environment in Dynamics 365 Contact Center.

## Symptoms

When you try to enable or add a user, you receive the following error message:

> The remote name could not be resolved.

## Cause

This issue can occur due to an out-of-the-box plugin associated with Omnichannel that can affect the user synchronization process.

## Resolution

To resolve the issue, follow these steps:

1. Open the Customer Service admin center.

2. Open the browser console using the shortcut <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>I</kbd>.

3. Check the current app setting by running the following command in the console:

    `Xrm.Utility.getGlobalContext().getCurrentAppSetting("msdyn_IsCCaaSOrURProvisioned");`

    If the returned value is `true`, proceed to the next step.

4. Update the setting to `false` by running the following command in the console:

    `Xrm.Utility.getGlobalContext().saveSettingValue('msdyn_IsCCaaSOrURProvisioned', false);`

5. Wait approximately 15 minutes for the setting to update.

6. Refresh the browser page or sign out and sign back in to the Customer Service admin center.

7. Rerun the initial command to confirm the returned value is now `false`:

    `Xrm.Utility.getGlobalContext().getCurrentAppSetting("msdyn_IsCCaaSOrURProvisioned");`

8. Once the setting update is confirmed, attempt to enable or add the user again.
