---
title: Troubleshoot configuration service provider (CSP) custom settings
description: Troubleshooting guidance for CSP custom setting issues for Windows 10 computers enrolled in Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Device configuration
ms.reviewer: kaushika
---
# Troubleshooting CSP custom settings for Windows 10 computers enrolled in Intune

This article gives troubleshooting guidance for configuration service provider (CSP) custom settings for Windows 10 computers enrolled in Intune. To learn more about custom settings, see [Use custom settings for Windows 10 devices in Intune](/mem/intune/configuration/custom-settings-windows-10). For more information on CSPs, see [Configuration service providers for IT pros](/windows/configuration/provisioning-packages/how-it-pros-can-use-configuration-service-providers).

## Collect data from Intune

The first step in troubleshooting is to collect information. Use these steps to collect error information about a CSP.

1. Find the status of a CSP custom profile deployment.

   In the Microsoft Endpoind Manager admin center, go to **Device Configuration** > **Assignment Status**. Here you can find the following information:

   - Display name
   - Type
   - Devices with Errors
   - Devices Failed
   - Devices Succeeded

2. Go to **Device Configuration** > **Profiles**, and then select the profile that shows **Devices with Errors** or **Devices Failed** as listed in Step 1.
3. If you deploy the profile to a device, go to the **Device Status** section under **Monitor**. Here you can find the following information:

   - Device
   - User
   - Deployment status

4. If you deploy the profile to a user, go to the **User Status** section under **Monitor**. Here you can find the following information:

   - User
   - Device count
   - Deployment status
   - Last check-in

5. Sometimes an issue occurs because of a specific custom setting for the profile. To check the status of each setting, go to the **Per-Settings status** section under **Monitor**. Here you can find the following information:

   - Setting
   - Description
   - Remediation
   - Conflict
   - Unknown
   - Error
   - Not Applicable

After you collect information and identify the device that has the issue, the next step is to collect logs for that device to further troubleshoot.

## Collect logs from a Windows 10 computer

You can collect Windows 10 logs to review for detailed information about the errors and status that you collect from the Intune Azure portal. Use these steps to collect logs from a Windows 10 computer.

1. Open Event Viewer and select **Show Analytic and Debug Logs** on the **View** menu to enable Debug logs.
1. Navigate to **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider**.
1. To collect Admin logs, do the following:

   1. Right-click the **Admin** node.
   1. Select **Save all events as**.
   1. Select a location and enter a file name.
   1. Click **Save**.
   1. Select **Display information for these languages** and then select **English**.
   1. Click **Ok**.

1. To collect Debug logs, do the following:

   1. Right-click the **Debug** node.
   1. Select **Save all events as**.
   1. Select a location and enter a file name.
   1. Click **Save**.
   1. Select **Display information for these languages**, and then select **English**.
   1. Click **Ok**.

<a name='collect-azure-ad-logs'></a>

## Collect Microsoft Entra logs

If you experience issues such as those related to communication with Microsoft Entra ID, authentication, or workplace join, you may want to collect Microsoft Entra logs. To do this, use these steps.

1. Open Event Viewer and go to **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID**.
2. To collect analytic logs, do the following:

   1. Right-click the **Analytic** node.
   1. Select **Save all events as**.
   1. Select a location and enter a file name.
   1. Click **Save**.
   1. Select **Display information for these languages** and then select **English**.
   1. Click **Ok**.

3. To collect operational logs, do the following:

   1. Right-click the **Operational** node.
   1. Select **Save all events as**.
   1. Select a location and enter a file name.
   1. Click **Save**.
   1. Select **Display information for these languages** and then select **English**.
   1. Click **Ok**.
