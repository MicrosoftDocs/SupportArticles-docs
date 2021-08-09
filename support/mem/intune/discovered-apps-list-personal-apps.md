---
title: The Discovered apps list seems to list personal apps
description: Describes a behavior that the Discovered apps list seems to list personal apps on Android work profile devices.
ms.date: 05/20/2020
ms.prod-support-area-path: Monitor apps 
---
# Intune Discovered apps list seems to list personal apps on Android work profile devices

This article describes a by design behavior that the **Discovered apps** list seems to show personal apps on an Android Enterprise work profile device.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4508002

## Symptoms

When you view the details of an Android Enterprise work profile device in Microsoft Intune in the Azure portal, some of the apps that you see in **Discovered apps** seem to be personal apps.

The following screenshot shows an example **Discovered apps** list.

:::image type="content" source="media/discovered-apps-list-personal-apps/discovered-apps.png" alt-text="screenshot of Discovered apps":::

## More information

This is expected behavior. What seem to be personal apps are actually system apps and services that are duplicated in the work profile. To view these apps on the Android Enterprise work profile device, tap **Settings** > **Work Profile** > **Apps**. Work apps are indicated by a briefcase icon.

:::image type="content" source="media/discovered-apps-list-personal-apps/work-apps.png" alt-text="screenshot of Work apps":::

Intune can't inventory apps that are installed within the personal profile, even if the device is configured as corporate-owned.
