---
title: Can't uninstall apps in Intune that were installed from Apple App Store
description: Gives a workaround solution to help uninstall apps that are installed from the Apple App Store can't be uninstalled in Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Add apps
ms.reviewer: kaushika
---
# Intune can't uninstall apps that are installed from Apple App Store

This article gives a workaround solution to help you uninstall apps in Microsoft Intune that were installed from the Apple App Store.

## Symptoms

An iOS device that's enrolled in Intune contains some apps that are installed from the Apple App Store. In this scenario, these apps can't be uninstalled by using Intune.

This behavior is by design. Intune can uninstall only apps that are deployed through the mobile device management (MDM) channel.

## Solution

To work around this issue, follow these steps:

1. [Add the apps](/mem/intune/apps/store-apps-ios) to Intune, then [assign the apps](/mem/intune/apps/apps-deploy) as **Available** or **Required**.

    > [!NOTE]
    > After the apps are assigned, you are prompted to allow Intune to take over management of the apps on the device.

2. To remove the apps from devices in the assigned group, change the assignment type to **Uninstall**.

    > [!NOTE]
    > Depending on the installation type and number of devices, it may take some time before you can safely change the assignment type to **Uninstall**. Use a phased approach, if it's necessary.

## More information

To prevent access to the App Store on supervised devices, see [App Store, Doc Viewing, Gaming](/mem/intune/configuration/device-restrictions-ios#app-store-doc-viewing-gaming).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
