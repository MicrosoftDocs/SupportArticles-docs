---
# required metadata
title: Troubleshoot issues with the Windows 365 app
titleSuffix:
description: Provides solutions, tips or best practices to resolve the issues with the Windows 365 app.
keywords:
author: ErikjeMS
ms.author: erikje
manager: dougeby
ms.date: 01/13/2025
ms.topic: how-to
ms.service: windows-365
ms.subservice: windows-365-enterprise
ms.localizationpriority: high
ms.assetid: 

# optional metadata

#ROBOTS:
#audience:

ms.reviewer: chbrinkhoff
ms.suite: ems
search.appverid: MET150
#ms.tgt_pltfrm:
ms.custom: intune-azure; get-started
ms.collection:
- M365-identity-device-management
- tier2
---
# Troubleshoot issues with the Windows 365 app

This article helps you identify and solve issues with the [Windows 365 app](https://support.microsoft.com/topic/cbb0d4d5-69d4-4f00-b050-6dc7a02d02d0).

## Limitations

> [!NOTE]
> The Windows 365 app currently doesn't support:
>
> - [Windows 11 IoT](/lifecycle/products/windows-11-iot-enterprise)
> - Configuring [Remote Desktop Protocol (RDP) properties](/azure/virtual-desktop/rdp-properties)

## "Can't connect to Cloud PC" error

When you select the **Connect** button to connect to your Cloud PC, you might receive a "Can't connect to Cloud PC" error.

To fix this issue:

1. In the **Settings** app on your Windows device, select **Apps** > **Default apps**.
2. Find the **AVD host app** and update the default app for **.avd** files.
3. Run the following command to clear the old Remote Desktop Client cache:

   `reg delete "HKEY_CLASSES_ROOT\progF3672D4C2FFE4422A53C78C345774E2D" /f`

## The Windows 365 app asks to select a new default app

When a [Remote Desktop client is installed](/windows-365/end-user-access-cloud-pc#install-the-microsoft-remote-desktop-app), you might see a file type association message after trying to connect to your Cloud PC. Make sure to select the **Azure Virtual Desktop (HostApp)** option to launch the Cloud PC session.

:::image type="content" source="media/troubleshoot-windows-365-app/azure-virtual-desktop.png" alt-text="Screenshot that shows the Azure Virtual Desktop (HostApp) option that should be selected.":::

## Change Cloud PC session from full screen to window mode  

The Windows 365 app supports window mode to work more efficiently side-by-side with your local PC. To activate window mode, select the **Window mode** button on the connection bar.

## No Cloud PCs displayed in Windows 365 app

If the Windows 365 app doesn't show any Cloud PCs, you might sign in with the wrong user account. Ensure you sign in with an account enrolled with the Microsoft Entra account that has Cloud PCs provisioned.

## More information

[Learn more about Windows 365 App](https://support.microsoft.com/topic/cbb0d4d5-69d4-4f00-b050-6dc7a02d02d0).
