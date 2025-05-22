---
# required metadata
title: Windows 365 Switch known issues
description: Learn about known issues with Windows 365 Switch, including workarounds and updated fixes.
manager: dcscontentpm
ms.date: 01/20/2025
ms.topic: troubleshooting
ms.reviewer: elluthra, erikje
ms.custom: intune-azure, get-started
ms.collection:
- M365-identity-device-management
- tier2
---

# Windows 365 Switch known issues

This article provides troubleshooting steps for the recent known issues with [Windows 365 Switch](/windows-365/enterprise/windows-365-switch-overview).

## Support for only one Cloud PC

Currently, Windows 365 Switch only supports one Switch-enabled Cloud PC. The user is automatically signed in to the first available Switch-supported Cloud PC from the list of assigned Cloud PCs. To sign in to a different Cloud PC, users can select the ellipses (...), choose the Cloud PC, and then select **Add to Task view**. Only one Cloud PC can be added to the Task view at a time. If you try to pin multiple Cloud PCs to the Task view, they're added in a stack fashion. For example, if you remove the first Cloud PC you added, the second one takes its place. Because only the first Cloud PC added is displayed in the Task view, we don't recommend pinning more than one Cloud PC to the Task view.

## Remove or replace a stale Cloud PC from the Task view

If your Task view has a Cloud PC that you no longer have access to, you can remove and replace it.

### Solution

1. Uninstall the [Windows App](/windows-app/overview).
2. Reinstall the Windows App.
3. Select the Windows App **Add to Task view** button on the Cloud PC you want to add.

## Limited gestures

Some gestures, such as three-finger gestures to change apps or four-finger gestures to bring up the Task view and show the desktop, aren't supported in the Cloud PC. These gestures are triggered on the physical device instead. All other usual Windows 11 gestures are supported.

## Bluetooth and hardware settings can't be managed from the Cloud PC

Cloud PCs lack hardware components like Bluetooth adapters. Users can't change the settings from the Cloud PC **Settings** app or [quick settings](https://support.microsoft.com/windows/change-notification-and-quick-settings-in-windows-ddcbbcd4-0a02-f6e4-fe14-6766d850f294).

### Solution

Users must switch back to their physical device and change the settings in the **Settings** app.

## Reconnect button not working

If the **Reconnect** option in the disconnect message dialog is used, reconnecting might not work as expected or result in an unusable Cloud PC session.

### Solution

Let the disconnect complete, and then launch a new connection using **Task view**.

## Cloud PC disconnects while focused on local PC

Cloud PCs that are connected via Windows **Task view** quietly disconnect to avoid disrupting the local PC session. The disconnected Cloud PC session shows a black screen with a message box.

### Solution

When the re-connectable error message is displayed, you can reconnect through the message box that reassemble the following screenshot:

:::image type="content" source="./media/windows-365-switch-known-issues/screenshot-prompting-to-reconnect-to-the-remote-session.png" alt-text="Screenshot prompting to reconnect to the remote session.":::

## Navigation between sign-in prompts and your Cloud PC

After you select a Cloud PC from the Task view, users might be prompted to sign in using their account credentials. In some builds of Windows, after providing the credentials, users might not be returned to the Cloud PC connection.

### Solution

Select the **Task view** button for the Cloud PC again. The connection continues in the background. The user should be connected to their Cloud PC within a few minutes.

## Local PC missing from Cloud PC Task view bar

If the local PC is missing from the Cloud PC's Task view bar, the Azure Virtual Desktop (HostApp) might be outdated.

### Solution

Uninstall and reinstall the Azure Virtual Desktop (HostApp) app from the [Microsoft Store](ms-windows-store://pdp/?productid=9NRNM1N926MN).

## Next steps

[Troubleshooting Windows 365 issues](/windows-365/enterprise/troubleshooting)
