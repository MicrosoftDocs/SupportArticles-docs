---
title: Troubleshooting app installation issues with Intune
description: How to use the Microsoft Intune troubleshooting pane to help you troubleshoot app installation issues.
ms.date: 10/14/2021
ms.reviewer: kaushika, mghadial
search.appverid: MET150
---
# Troubleshooting Intune app installation issues

This article gives troubleshooting guidance for when app installations fail for Microsoft Intune-managed apps. The Intune **Troubleshoot** pane provides failure details, including details about managed apps, to help you address user help requests. For detailed information, see [Use the troubleshooting portal to help users at your company](/mem/intune/fundamentals/help-desk-operators). In the **Managed Apps** pane, you can find information about the end-to-end lifecycle of an app for each individual device. You can view installation issues, such as when the app was created, modified, targeted, and delivered to a device.

> [!NOTE]
> For specific app installation error code information, see [Intune app installation error reference](app-install-error-codes.md).

## Get app troubleshooting details

Intune provides app troubleshooting details based on the apps installed on a specific user's device.

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431).
2. Select **Troubleshoot + support**.
3. Click **Select user** to go to the **Select users** pane.
4. Type the name or email address of the user you want to troubleshoot, and then click **Select** at the bottom of the pane. The troubleshooting information for the user is displayed in the **Troubleshoot** pane.
5. Select the device that you want to troubleshoot from the **Devices** list.

    :::image type="content" source="media/troubleshoot-app-install/devices.png" alt-text="Screenshot of the Intune Troubleshooting pane." border="false" lightbox="media/troubleshoot-app-install/devices.png":::

6. Select **Managed Apps** from selected device pane. A list of managed apps is displayed.

    :::image type="content" source="media/troubleshoot-app-install/managed-apps.png" alt-text="Screenshot of the details of a specific device managed by Intune." border="false" lightbox="media/troubleshoot-app-install/managed-apps.png":::

7. Select an app from the list where **Installation Status** indicates a failure.

    :::image type="content" source="media/troubleshoot-app-install/select-app.png" alt-text="Screenshot of a selected app that shows installation failure details." border="false" lightbox="media/troubleshoot-app-install/select-app.png":::

    > [!Note]  
    > The same app could be assigned to multiple groups but with different intended actions (intents) for the app. For instance, a resolved intent for an app will show **excluded** if the app is excluded for a user during app assignment. For more information, see [How conflicts between app intents are resolved](/mem/intune/apps/apps-deploy#how-conflicts-between-app-intents-are-resolved).  
    > If an installation failure occurs for a required app, either you or your help desk will be able to sync the device and retry the app install.

The app installation error details will indicate the problem. You can use these details to determine the best action to take to resolve the problem. For more information about troubleshooting app installation issues, see [Android app installation errors](app-install-error-codes.md#android-app-installation-errors) and [iOS app installation errors](app-install-error-codes.md#ios-and-ipados-app-installation-errors).

> [!Note]  
> You can also access the **Troubleshoot** directly in your browser with this URL: [https://aka.ms/intunetroubleshooting](https://aka.ms/intunetroubleshooting).

## User Group targeted app installation does not reach device

If you have app installation problems, consider the following actions:

- If the app does not display in the Company Portal, ensure the app is deployed with **Available** intent and that the user is accessing the Company Portal with the device type supported by the app.
- For Windows BYOD devices, the user needs to add a Work account to the device.
- Check if the user is over the Microsoft Entra device limit:
  1. Navigate to [Microsoft Entra Device Settings](https://portal.azure.com/#pane/Microsoft_AAD_IAM/DevicesMenupane/DeviceSettings/menuId).
  2. Make note of the value set for **Maximum devices per user**.
  3. Navigate to [Microsoft Entra users](https://portal.azure.com/#pane/Microsoft_AAD_IAM/UsersManagementMenupane/AllUsers).
  4. Select the affected user and click **Devices**.
  5. If user is over the set limit then delete any stale records that are no longer needed.
- For iOS/iPadOS ADE devices, ensure that the user is listed as **Enrolled by User** in the Intune devices **Overview** pane. If it shows NA, then deploy a config policy for the Intune Company Portal. For more information, see [Configure the Company Portal app](/mem/intune/apps/app-configuration-policies-use-ios#configure-the-company-portal-app-to-support-ios-and-ipados-dep-devices).

## App types supported on ARM64 devices

App types that are supported on ARM64 devices include the following:

- Web apps that do not require a managed browser to open.
- Microsoft Store for Business apps or Windows Universal LOB apps (`.appx`) with any of the following combination of `TargetDeviceFamily` and  `ProcessorArchitectures` elements:
  - `TargetDeviceFamily` includes Desktop apps, Universal apps and Windows8x apps. Windows8x apps apply only as Online Microsoft Store for Business apps.
  - `ProcessorArchitecture` includes x86 apps, ARM apps, ARM64 apps, and neutral apps.
- Windows Store apps
- Mobile MSI LOB apps
- Win32 apps with the requirement rule of 32-bit.
- Windows Office click-to-run apps if 32-bit or x86 architecture is selected.

> [!NOTE]
> To better recognize ARM64 apps in the Company Portal, consider adding **ARM64** to the name of your ARM64 apps.
