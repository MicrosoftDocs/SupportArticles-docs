---
title: Power Automate needs an update but we're unable to apply the update right now
description: Provides a resolution for an issue where Power Automate for desktop can't be updated when you open it for the first time.
ms.reviewer: pefelesk
ms.date: 07/13/2023
ms.subservice: power-automate-desktop-flows
---
# "Power Automate needs an update" message occurs when opening Power Automate for desktop

This article provides a resolution for an issue where Power Automate for desktop needs an update, but it can't be updated.

_Applies to:_ &nbsp; Power Automate

## Symptoms

When you try to open Power Automate for desktop for the first time, you receive the following message:

> Power Automate needs an update, but we're unable to apply the update right now.

:::image type="content" source="media/cannot-update-power-automate-for-desktop/power-automate-needs-an-update.png" alt-text="Screenshot of the message that states Power Automate needs an update but we're unable to apply the update right now.":::

## Verifying issue

1. Check if you have an active internet connection.
2. Go to **Windows Services** and check if the **Windows Update** service isn't running.

## Cause

This issue might occur because the **Windows Update** service isn't running or is disabled.

## Resolution

To solve this issue, take one of these options:

#### Option 1

1. Go to **Windows Services** and enable the **Windows Update** service.
2. Launch Power Automate.

#### Option 2

1. Open the **Settings** app in Windows.
2. Select **System** > **Troubleshoot** > **Other troubleshooters**.
3. Run the Windows Update troubleshooter and wait for it to complete.
4. Launch Power Automate.

#### Option 3 

1. Uninstall Power Automate.
2. Open Microsoft Store and install Power Automate.
