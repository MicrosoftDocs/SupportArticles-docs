---
title: Troubleshoot update ring policies for Windows devices
description: Provides troubleshooting guidance for configuring update ring policies for Windows 11 and Windows 10 devices in Intune.
ms.date: 09/22/2023
ms.reviewer: chauntain, helenclu, simonxjx
search.appverid: MET150
---
# Troubleshoot update rings for Windows 11 and Windows 10 in Microsoft Intune

This article provides guidelines for troubleshooting issues with the Windows update ring settings to ensure they're successfully delivered to your organization's Windows 11 or Windows 10 devices. Update ring settings manage how and when Windows devices install operating system (OS) updates. For more information about update ring policies, see [Update rings for Windows 10 and later policy in Intune](/mem/intune/protect/windows-10-update-rings).

If you experience an issue while deploying update ring policies to Windows 11 or Windows 10 devices using Microsoft Intune, determine whether the issue is Intune or Windows-related. Therefore, it's important to consider whether the Intune policy has been successfully deployed to the target device.

Some deployment insights are included in this guide to highlight how OS and policy updates work. The following steps may be performed independently of others for times when other troubleshooting efforts don't provide the desired results.

## What Windows update ring policies do

Windows update ring policies define only an update strategy, such as blocking driver installation, setting deferral periods, or setting maintenance times. The update ring policy doesn't update the infrastructure itself. This means that it needs an existing update solution to obtain the actual updates, such as Windows Updates for Business.

Windows update ring policies created in Intune use the [Windows Policy CSP](/windows/client-management/mdm/policy-configuration-service-provider) for updating Windows devices. Once Intune deploys the Windows update ring policy to an assigned device, the Policy configuration services provider (CSP) writes the appropriate values to the Windows registry to make the policy take effect.

Now that you know what these policies do, you can verify if the update ring settings have been successfully applied.

## Verify the prerequisites are met

There are several ways to verify whether the update ring settings have been successfully applied. Typically, the status in the Intune admin center is sufficient but other verification methods may be helpful when troubleshooting related issues.

To begin, review the OS prerequisites. For more information, see the [Prerequisites](/mem/intune/protect/windows-10-update-rings#prerequisites) section of [Update rings for Windows 10 and later policy in Intune](/mem/intune/protect/windows-10-update-rings) to assist with this review.

Run Windows 10, version 1607 or later, or Windows 11.

Versions:

- Windows 10/11 Pro
- Windows 10/11 Enterprise
- Windows 10/11 Team (for Surface Hub devices)
- Windows Holographic for Business-supports only a subset of settings for Windows updates, including:

  - Automatic update behavior
  - Microsoft product updates
  - Servicing channel (any update build that is generally available)

  For more information, see [Manage and use different device management features on Windows Holographic and HoloLens devices with Intune](/mem/intune/fundamentals/windows-holographic-for-business).

- Enterprise Long Term Servicing Channel (LTSC)
  - Only a subset of settings apply. For more information, see [Windows 10 Enterprise LTSC](/windows/whats-new/ltsc/overview).

> [!NOTE]
> Update rings can also be used to upgrade your eligible Windows 10 devices to Windows 11. When creating a policy, navigate to **Devices** > **Windows** > **Update rings for Windows 10 and later**, and then configure the **Upgrade Windows 10 devices to latest Windows 11 release** setting to **Yes**.

## Troubleshoot in the Intune admin center

The best practice for troubleshooting policy issues is to always check its status in the Intune admin center.

Navigate to **Devices** > **Windows** > **Update rings for Windows 10 and later**, and then select the update ring policy to review. The policy **Overview** appears with colored charts reflecting the profile deployment information.

:::image type="content" source="media/troubleshoot-update-rings/update-ring-overview-pane.png" alt-text="A screenshot of the default update ring overview pane in the Intune admin center." lightbox="media/troubleshoot-update-rings/update-ring-overview-pane.png":::

Check the individual device to confirm that the update ring policy has been successfully applied.

- Navigate to **Device status**, **User status**, or **End user update status** for an overview of the list of devices the policy has been applied to. This list is useful for quickly identifying whether a specific device has received the update policy.
- Navigate to the device in the Intune admin center, then to **Device configuration status** > **Update ring policy** to see whether a specific device has the update ring policy applied.

Review the update ring policy for an affected device. There may be two entries for the policy depending on the type of user device being managed. When Intune deploys a policy (any policy, not just update rings), the settings are delivered against both the logged-on user and the system context of the device. This causes the two entries, which is a normal occurrence. However, if you manage Kiosk-type devices with Autologon or a local-account user type, only the system account is displayed.

:::image type="content" source="media/troubleshoot-update-rings/device-status-pane.png" alt-text="A screenshot of the Device status pane on the Default_UpdateRing page." lightbox="media/troubleshoot-update-rings/device-status-pane.png":::

For more information, see the [View report](/mem/intune/protect/compliance-policy-monitor#view-report) section of [Monitor results of your Intune Device compliance policies](/mem/intune/protect/compliance-policy-monitor).

Refer to the **Device configuration** report to see whether a policy has been applied successfully to the device. If there are issues, or to confirm, verify the settings on the target device itself.

:::image type="content" source="media/troubleshoot-update-rings/profile-settings-report.png" alt-text="A screenshot of the Profile settings report for the example device.":::

## Verify settings on the device

To confirm that the policies have been applied to the device locally, navigate to **Settings** > **Accounts** > **Access work or school**. The list of policies applied to the device from Intune will include whether they're managed by your organization.

:::image type="content" source="media/troubleshoot-update-rings/policies-on-the-device.png" alt-text="A screenshot of the policies on the device in the Managed by Organization pane.":::

To view the policies managed by your organization on the Windows device, navigate to **Settings** > **Windows Updates** > **Advanced options** > **Configured update policies**.

:::image type="content" source="media/troubleshoot-update-rings/view-configured-update-policies.png" alt-text="A screenshot of the Advanced options in the Windows Update pane, highlighting the Configured update policies option.":::

Verify that the policy type is **Mobile Device Management**.

:::image type="content" source="media/troubleshoot-update-rings/mdm-as-type.png" alt-text="A screenshot of the Configured update policies pane with the 'Set when Active Hours start' setting showing Mobile Device Management as the type.":::

Your mobile device management (MDM) solution configures the update policies, which is Intune in this scenario. However, it's possible that the update policy is coming from the on-premises Active Directory, which would have **Group Policy** as the policy type.

:::image type="content" source="media/troubleshoot-update-rings/allow-updates-to-be-managed-by.png" alt-text="A screenshot of the Configured update policies pane with the 'Allow updates to be downloaded automatically over metered connections' setting showing Group Policy as the type.":::

### Common conflicts between MDM and group policies

Mixed deployments between Intune MDM policies and group policies (GPO) can create conflicts. Many group policies are old and cached, and you may not even be aware they still exist. It's also possible some of the group policies come from System Center Configuration Manager (SCCM).

The best way to validate what policies are delivered through GPO is with the [gpresult](/windows-server/administration/windows-commands/gpresult) command.

:::image type="content" source="media/troubleshoot-update-rings/gpresult-output.png" alt-text="A screenshot of the gpresult output from an example device." lightbox="media/troubleshoot-update-rings/gpresult-output.png":::

If the policy source is "Local Group Policy," SCCM could have set it. If it's not, edit the group policy object from the Active Directory infrastructure to remove the conflicting values.

A policy conflict between MDM and group policies appears as unexpected scenarios with the update process. Updates won't happen or will happen in an unplanned manner. For example, a device might be stuck on an earlier version of Windows and unable to upgrade.

Some of these conflicts can be resolved using the `ControlPolicyConflict` CSP. Generally, if the update process isn't working as expected, investigate for a policy conflict. For more information, see [Policy CSP - ControlPolicyConflict](/windows/client-management/mdm/policy-csp-controlpolicyconflict).

### Confirm that the correct registry keys have been updated

If Intune successfully deploys the Windows update ring policies to the target device, those settings appear in the Registry Editor under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Update`.

:::image type="content" source="media/troubleshoot-update-rings/registry-deployment.png" alt-text="A screenshot of an example registry showing the successfully deployed policies in the Update folder.":::

These values should match the [Policy CSP description](/windows/client-management/mdm/policy-csp-update) and the configuration deployed in the update ring policy from Intune.

### Check the MDM diagnostics report

Another method to verify whether the update ring policy was deployed to the device is to check the MDM diagnostic report. On the Windows device, navigate to **Settings** > **Accounts** > **Access work or school**, and then select the **Export** button. The report includes the Intune deployed policies. If the update ring policy is in the report, the policy was successfully deployed.

:::image type="content" source="media/troubleshoot-update-rings/mdm-report.png" alt-text="A screenshot of an example MDM diagnostic report." lightbox="media/troubleshoot-update-rings/mdm-report.png":::

### Review the Event Viewer log for Intune events

Review the Event Viewer log to see how the Policy CSP data is being delivered to the device in real-time. On the device, navigate to the **Event Viewer** application and then go to **Applications and Services logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostics-Provider** > **Admin**.

:::image type="content" source="media/troubleshoot-update-rings/event-viewer.png" alt-text="A screenshot of the Admin pane for MDM Policy Manager in the Event Viewer with 'policies deployed to the device' highlighted." lightbox="media/troubleshoot-update-rings/event-viewer.png":::

Successfully deployed policies (Set action) won't have errors or warnings.

## Optional troubleshooting methods

Certain instances may require troubleshooting the update ring policies from the device side instead of, or in addition to Intune.

### Review the Windows Update Client

When you use the Windows Update Client, there may be errors that could help pinpoint what to do next. For example, you might see that the updates successfully downloaded, which would indicate the issue isn't related to downloading the update. Other issues may include the device not being able to scan Windows update's URLs for new downloads or the device still scanning against Windows Server Update Services (WSUS) after the workload has been switched to Intune.

To access Event Viewer, on the device, find the **Event Viewer** app in the Windows Start menu and then select **Applications and Services logs** > **Microsoft** > **Windows** > **WindowsUpdateClient**.

:::image type="content" source="media/troubleshoot-update-rings/event-viewer-updates.png" alt-text="A screenshot of the 'Windows Update successfully found six updates' message in the Event Viewer." lightbox="media/troubleshoot-update-rings/event-viewer-updates.png":::

:::image type="content" source="media/troubleshoot-update-rings/event-viewer-updates-example.png" alt-text="A screenshot of the Windows Update client with a notification about error 0x80072EE6 preventing update checks." lightbox="media/troubleshoot-update-rings/event-viewer-updates-example.png":::

### Check the Windows Update registry keys source

Monitor the Windows side of things by reviewing the Windows Update (WU) source registry keys. Intune is responsible solely for deploying the values to the following registry hive:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Update`

To review other configured settings for Windows Update on the device, access the Registry Editor app and navigate to the following registry keys:

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU`

:::image type="content" source="media/troubleshoot-update-rings/updates-registry-keys.png" alt-text="A screenshot of the Registry Editor for HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU.":::

`HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate`

:::image type="content" source="media/troubleshoot-update-rings/second-updates-registry-keys.png" alt-text="A screenshot of the Registry Editor for HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate.":::

From here, find additional information about the deployed policies that might come from group policy. For example, the registry keys and the Windows Update service may point towards WSUS rather than towards WU servers while also having dual-scan disabled. The service misdirection would result in the device scanning against WSUS instead of WU. For more information, see [Use Windows Update for Business and WSUS together](/windows/deployment/update/wufb-wsus).

## Considerations

If the previous options didn't provide the results needed to identify the issue and the devices are still not updating, or are doing it erratically, then consider the following questions:

- Is reporting and telemetry enabled for the devices? Intune can deliver telemetry to the device in multiple ways. However, the most common method is with a [Device Restriction policy](/mem/intune/configuration/device-restrictions-windows-10#reporting-and-telemetry), either through Intune or group policy.

    For more information, see the [Manage diagnostic data using Group Policy and MDM](/windows/privacy/configure-windows-diagnostic-data-in-your-organization#manage-diagnostic-data-using-group-policy-and-mdm) section of [Configure Windows diagnostic data in your organization](/windows/privacy/configure-windows-diagnostic-data-in-your-organization).

- Is there an active network connection on the device? If the device is in airplane mode, is turned off, or the user has the device in a location with no service, the policy won't apply until it's connected to a network.
- Does the device not upgrade past a specific version? Check for a conflicting [TargetReleaseVersion](/windows/client-management/mdm/policy-csp-update#targetreleaseversion) value through other means, such as Group policy or Settings catalog, found in the Windows Update registry keys.
- Verify that Windows Update is configured to deliver feature and quality updates. If `UpdateServiceUrl` is populated in the Registry, verify that `DisableDualScan` is set to `0`. On the device, access the Registry Editor app and navigate to `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate`.
- Is the device co-managed? Make sure the [workload for Windows Updates has been switched to Intune](/mem/configmgr/comanage/workloads#windows-update-policies).

    :::image type="content" source="media/troubleshoot-update-rings/workloads.png" alt-text="A screenshot of the Properties dialog highlighting the Windows Update policies slider on the Workloads tab.":::

- Make sure you're not deploying conflicting Windows Update for Business settings from another update ring or from a Settings Catalog policy. Confirm your assigned Settings Catalog policies for Windows Update for Business settings that may end up being deployed.

    For update ring policies, you should see a "Conflict" reporting in the Device Configuration pane for the device or in the colored charts.

    :::image type="content" source="media/troubleshoot-update-rings/conflict-report.png" alt-text="A screenshot of the colored Profile assignment status - Windows 10 and later devices chart with the Succeeded and Conflict data highlighted.":::

- Be sure that the Windows update ring policy is deployed to the correct user/device group.
- Determine whether the entire policy deployment fails or only certain settings aren't being applied. Navigate to **Device** > **Device configuration** > **Update ring report**. There may be a specific setting in the list that shows an error rather than a success message.

    :::image type="content" source="media/troubleshoot-update-rings/error-example.png" alt-text="A screenshot of the 'Automatic update behavior' and 'Microsoft Product Updates' profile settings showing a conflict status." lightbox="media/troubleshoot-update-rings/error-example.png":::

- Check the actual wording for the setting that's getting the error status. For example, there may be some specific values applicable only on certain Windows versions or editions.

    :::image type="content" source="media/troubleshoot-update-rings/csp-example.png" alt-text="A screenshot of the SetDisableUXWUAccess setting with the Scope User value showing as an error.":::

See the description of each setting in [Settings for Windows Update that you can manage through Intune policy for update rings](/mem/intune/protect/windows-update-settings).

## Other considerations

If you've made it through this troubleshooting guide, and haven't been able to pinpoint the Windows update ring policy as the issue, it may be an issue between the device locally and the Windows Update services. Refer to the following resources to troubleshoot Windows Update policy issues:

- [Windows Update issues troubleshooting](../../../windows-client/deployment/windows-update-issues-troubleshooting.md)
- [Windows Update common errors and mitigation](../../../windows-client/deployment/common-windows-update-errors.md)
- [Windows Update troubleshooting guidance](../../../windows-client/deployment/troubleshoot-windows-update-issues.md)

If you'd like to raise a support request, see the [Windows Update log](/windows/deployment/update/windows-update-logs) files to learn about the data the support engineer may need you to provide. Including this data in the support ticket could help expedite the troubleshooting process.
