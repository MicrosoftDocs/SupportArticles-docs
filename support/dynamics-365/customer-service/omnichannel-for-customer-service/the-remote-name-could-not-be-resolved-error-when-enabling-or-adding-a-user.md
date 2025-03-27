---
title: The remote name could not be resolved error when enabling or adding a user
description: Solves the error "The remote name could not be resolved" when enabling or adding a user in Dynamics 365 Contact Center.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/27/2025
ms.reviewer: skarkouti, vparanjape, srubinstein
ms.custom: sap:Voice channel , DFM
---
# "The remote name could not be resolved" error when enabling or adding a user

This article provides guidance on resolving the error message "The remote name could not be resolved" when attempting to enable or add a user in the environment.

## Symptoms

When attempting to enable or add a user, the following error message is displayed:

> The remote name could not be resolved.

## Cause

This issue can occur due to an out-of-the-box plugin associated with Omnichannel, that can affect the user synchronization process.

## Solution

Follow these steps to resolve the issue:

1. Open the Customer Service Admin application.

2. Open the browser console using the shortcut <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>I</kbd>.

3. Execute the following command in the console to check the current app setting:

    `Xrm.Utility.getGlobalContext().getCurrentAppSetting("msdyn_IsCCaaSOrURProvisioned");`

    If the returned value is `true`, proceed to the next step.

4. Execute the following command in the console to update the setting to `false`:

    `Xrm.Utility.getGlobalContext().saveSettingValue('msdyn_IsCCaaSOrURProvisioned', false);`

5. Wait approximately 15 minutes for the setting to update.

6. Refresh the browser page or log out and log back into the Customer Service Admin application.

7. Re-execute the initial command to confirm the returned value is now `false`:

    `Xrm.Utility.getGlobalContext().getCurrentAppSetting("msdyn_IsCCaaSOrURProvisioned");`

8. Once the setting is confirmed to be updated, attempt to enable or add the user again.
