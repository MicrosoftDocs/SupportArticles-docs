---
title: Power Automate needs an update but we're unable to apply the update right now
description: Provides a resolution for an issue where Power Automate for desktop can't be updated when you open it for the first time.
ms.reviewer: chtzirtz, iomimtso, adanas, v-shaywood
ms.date: 04/03/2026
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# "Power Automate needs an update" message occurs when opening Power Automate for desktop

_Applies to:_ &nbsp; Power Automate

## Summary

When you open Power Automate for desktop for the first time, you might receive a "Power Automate needs an update, but we're unable to apply the update right now" message. This problem typically occurs because the Windows Update service isn't running or is disabled. This article helps you resolve the problem by enabling the Windows Update service, running the Windows Update troubleshooter, or reinstalling Power Automate from the Microsoft Store.

## Symptoms

When you try to open Power Automate for desktop for the first time, you receive the following message:

> Power Automate needs an update, but we're unable to apply the update right now.

:::image type="content" source="media/cannot-update-power-automate-for-desktop/power-automate-needs-an-update.png" alt-text="Screenshot of the message that states Power Automate needs an update but we're unable to apply the update right now.":::

To verify the problem, check if you have an active internet connection and go to **Windows Services** to confirm that the **Windows Update** service isn't running.

## Cause

This problem occurs because the **Windows Update** service isn't running or is disabled.

## Solution

To resolve this problem, try one of the following solutions:

### Enable the Windows Update service

1. Go to **Windows Services** and enable the **Windows Update** service.
1. Launch Power Automate.

### Run the Windows Update troubleshooter

1. Open the **Settings** app in Windows.
1. Select **System** > **Troubleshoot** > **Other troubleshooters**.
1. Run the Windows Update troubleshooter and wait for it to complete.
1. Launch Power Automate.

### Reinstall Power Automate from the Microsoft Store

1. Uninstall Power Automate.
1. Open Microsoft Store and [install Power Automate](/power-automate/desktop-flows/install#install-power-automate-from-microsoft-store).

## Related content

- [Install Power Automate](/power-automate/desktop-flows/install)
- [Update Power Automate for desktop](/power-automate/desktop-flows/install#update-power-automate-for-desktop)
- [Power Automate for desktop logs](how-to-get-power-automate-desktop-installer-logs.md)
