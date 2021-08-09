---
title: Troubleshoot CSP custom settings
description: Introduces configuration service provider and how to troubleshoot CSP custom setting issues for Windows 10 computers.
ms.date: 05/11/2020
ms.prod-support-area-path: Device configuration
---
# Troubleshoot CSP custom settings for Windows 10 computers enrolled in Intune

This article contains a brief introduction of configuration service provider (CSP) and how to troubleshoot CSP custom settings for Windows 10 computers.

_Original product version:_ &nbsp; Microsoft Intune, Windows 10  
_Original KB number:_ &nbsp; 4055338

## What is CSP

A CSP is an interface in the client operating system between configuration settings that are specified in a provisioning document and configuration settings on the device. CSPs provide an interface to read, set, modify, or delete configuration settings for a given feature. Typically, these settings map to registry keys, files, or permissions. Some of these settings are configurable, and some are read-only.

In Windows 10, the management approach for both desktop and mobile devices converges, taking advantage of the same CSPs to configure and manage all devices that are running Windows 10. Each CSP provides access to specific settings. For example, the WiFi CSP contains the settings to create a WiFi profile.

CSPs are behind many of the management tasks and policies for Windows 10 in Microsoft Intune and non-Microsoft mobile device management (MDM) service providers. CSPs receive configuration policies in the XML-based SyncML format that are pushed to the CSP from an MDM-compliant management server, such as Microsoft Intune. Traditional enterprise management systems, such as System Center Configuration Manager, can also target CSPs by using a client-side Windows Management Instrumentation-to-CSP bridge.

For more information about CSPs, see [Introduction to configuration service providers (CSPs) for IT pros](/windows/configuration/provisioning-packages/how-it-pros-can-use-configuration-service-providers).

## Troubleshoot CSP

### Collect data from Intune portal

The first step in troubleshooting is to collect information. To collect error information about a CSP, follow these steps:

1. Find the status of a CSP custom profile deployment.

   In the Intune Azure portal, go to **Device Configuration** > **Assignment Status**. Here you can find the following information:

   - Display name
   - Type
   - Devices with Errors
   - Devices Failed
   - Devices Succeeded

2. Go to **Device Configuration** > **Profiles**, and then select the profile that shows **Devices with Errors** or **Devices Failed** as listed in step 1.
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

### Collect logs from a Windows 10 computer

To do this, follow these steps:

1. Open Event Viewer and select **Show Analytic and Debug Logs** on the **View** menu to enable Debug logs.
2. Navigate to **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider**.
3. To collect Admin logs, do the following:

   1. Right-click the **Admin** node.
   2. Select **Save all events as**.
   3. Select a location and enter a file name.
   4. Click **Save**.
   5. Select **Display information for these languages** and then select **English**.
   6. Click **Ok**.

4. To collect Debug logs, do the following:

   1. Right-click the **Debug** node.
   2. Select **Save all events as**.
   3. Select a location and enter a file name.
   4. Click **Save**.
   5. Select **Display information for these languages**, and then select **English**.
   6. Click **Ok**.

After you collect these logs, review them for detailed information about the errors and status that you collect from the Intune Azure portal.

### Collect Azure Active Directory (Azure AD) logs

If you experience issues such as those related to communication with Azure AD, authentication, or workplace join, you may want to collect Azure AD logs. To do this, follow these steps:

1. Open Event Viewer and go to **Applications and Services Logs** > **Microsoft** > **Windows** > **AAD**.
2. To collect analytic logs, do the following:

   1. Right-click the **Analytic** node.
   2. Select **Save all events as**.
   3. Select a location and enter a file name.
   4. Click **Save**.
   5. Select **Display information for these languages** and then select **English**.
   6. Click **Ok**.

3. To collect operational logs, do the following:

   1. Right-click the **Operational** node.
   2. Select **Save all events as**.
   3. Select a location and enter a file name.
   4. Click **Save**.
   5. Select **Display information for these languages** and then select **English**.
   6. Click **Ok**.

### Contact Microsoft support

If you still can't resolve the issue, contact [Microsoft Support](https://support.microsoft.com).

## References

- [Create a profile with custom settings in Intune](/mem/intune/configuration/custom-settings-configure)
- [Use custom settings for Windows 10 devices in Intune](/mem/intune/configuration/custom-settings-windows-10)
- [Diagnose MDM failures in Windows 10](/windows/client-management/mdm/diagnose-mdm-failures-in-windows-10)
- [DiagnosticLog CSP](/windows/client-management/mdm/diagnosticlog-csp)
