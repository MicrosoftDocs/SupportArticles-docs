---
title: The Intune discovered apps list seems to include personal apps
description: Describes a behavior that the Microsoft Intune discovered apps list seems to show personal apps on Android work profile devices.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Reporting\Intune reporting
ms.reviewer: kaushika
---
# Intune discovered apps list seems to list personal apps on Android work profile devices

This article describes a by-design behavior that the [discovered apps](/mem/intune/apps/app-discovered-apps) list in Microsoft Intune seems to show personal apps on an Android Enterprise work profile device.

## Symptoms

When you view the details of an Android Enterprise work profile device in the Microsoft Intune admin center, some of the apps that you see in **Discovered apps** seem to be personal apps.

The following screenshot shows an example **Discovered apps** list.

:::image type="content" source="media/discovered-apps-list-personal-apps/discovered-apps.png" alt-text="Screenshot of Discovered apps list.":::

## More information

This is expected behavior. What seem to be personal apps are actually system apps and services that are duplicated in the work profile. To view these apps on the Android Enterprise work profile device, tap **Settings** > **Work Profile** > **Apps**. Work apps are indicated by a briefcase icon.

:::image type="content" source="media/discovered-apps-list-personal-apps/work-apps.png" alt-text="Screenshot of Work apps list.":::

Intune can't inventory apps that are installed within the personal profile, even if the device is configured as corporate-owned.
