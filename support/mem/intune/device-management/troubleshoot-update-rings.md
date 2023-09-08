---
title: Troubleshoot Update ring policies for Windows 10 and 11 devices
description: Get troubleshooting guidance for configuring Update ring policies for Windows 10 and 11 devices in Intune.
ms.date: 09/09/2023
ms.reviewer: chauntain, helenclu, simonxjx
search.appverid: MET150
---
# Troubleshooting Update rings policies for Windows 10 and 11 devices in Microsoft Intune

This article provides guidelines for addressing issues with Windows Update rings settings to ensure they’re successfully delivered to your organization’s Windows 10 and 11 devices. Update rings settings manage how and when Windows devices will install operating system (OS) updates. To learn more about Update ring policies, see [Update rings for Windows 10 and later policy in Intune | Microsoft Learn](/mem/intune/protect/windows-10-update-rings).

If you’ve experienced an issue while deploying Update ring policies to Windows 10 or 11 devices using Microsoft Intune, you’ll need to determine whether the issue is Intune or Windows-related. Therefore, it’s important to consider whether the Intune policy has been successfully deployed to the targeted device.

Some deployment insights are included in this guide to highlight how OS and policy updates work. Thus, several steps outlined below may be performed independently of others for times when other troubleshooting efforts aren’t providing the desired results.

## What Windows Update ring policies do

Windows Update ring policies define only an update strategy, such as blocking driver installation, setting deferral periods, or setting maintenance times. The update infrastructure itself is provided by the Windows Updates for Business services. The interaction between these services and the device is needed for an actual update to occur. They don’t provide the updated infrastructure itself, meaning that you still need to use your existing update solution, such as Windows Servers Update Service (WSUS), to obtain the actual updates.

Windows Update ring policies created in Intune use the [Windows Policy CSP](/windows/client-management/mdm/policy-configuration-service-provider) for updating Windows devices. Once Intune deploys the Windows Update ring policy to an assigned device, the policy Configuration Services Provider (CSP) will write the appropriate values to the Windows registry to make the policy take effect.

Now that we know what these policies do, let’s look at how we can verify if the Update rings settings have been successfully applied.

## Verifying the prerequisites are met

There are several ways to verify whether the Update rings settings have been successfully applied. Typically, the status in the Intune admin center is sufficient but other verification methods may be helpful when troubleshooting related issues.

To begin, review the OS prerequisites. See the [Prerequisites](/mem/intune/protect/windows-10-update-rings#prerequisites) section of [Update rings for Windows 10 and later policy in Intune |Microsoft Learn](/mem/intune/protect/windows-10-update-rings) to assist with this review.

Run Windows 10, version 1607 or later, or Windows 11.

Versions:

- Windows 10/11 Pro
- Windows 10/11 Enterprise
- Windows 10/11 Team (for Surface Hub devices)
- Windows Holographic for Business—supports only a subset of settings for Windows updates, including:
  - Automatic update behavior
  - Microsoft product updates
  - Servicing channel (any update build that is generally available)
 For more information, see [Manage and use different device management features on Windows Holographic and HoloLens devices with Intune | Microsoft Learn](/mem/intune/fundamentals/windows-holographic-for-business).
- Enterprise Long Term Servicing Channel (LTSC)
  - Only a subset of settings apply. See [Windows 10 Enterprise LTSC](/windows/whats-new/ltsc/overview) for details.

>[!NOTE]
>Update rings can also be used to upgrade your eligible Windows 10 devices to Windows 11. When creating a policy, navigate to **Devices** > **Windows** > **Update rings for Windows 10 and later** and configure the **Upgrade Windows 10 devices to Latest Windows 11 release** setting to *Yes*.

## Troubleshooting in the Intune admin center

The best practice for troubleshooting policy issues is to always check its status in the Intune admin center.

Navigate to **Devices** > **Windows** > **Update rings for Windows 10 and later** and select the Update ring policy to review. You’ll see the **Overview** of that policy with colored charts reflecting the profile deployment information.

:::image type="content" source="media/Troubleshoot-Update-rings/1.UpdateRingOverviewPane.jpg" alt-text="A screenshot of the Default Update Ring Overview pane in the Intune admin center.":::

Check the individual device to confirm that the Update rings policy has been successfully applied.

- Navigating to **Device status**, **User Status**, or **End user update status** provides an overview of the list of devices the policy has been applied to. This is useful for quickly identifying whether a specific device has received the update policy.
- To see whether a specific device has the Update Ring policy applied, navigate to the device in the Intune admin center, and then to **Device Configuration status** > **Update rings policy**.

When reviewing the Update rings policy for an affected device, there may be two entries for it depending on the type of user devices being managed. This happens because, when Intune deploys a policy (any policy, not just Update rings), the settings are delivered against both the logged-on user and the system context of the device, causing the two entries, which is normal. However, if you manage Kiosk-type devices with Auto-logon or a local-account user type, only the system account will be displayed.

:::image type="content" source="media/Troubleshoot-Update-rings/2.DeviceStatusPane.jpg" alt-text="A screenshot of the Device status pane on the Default_UpdateRing page.":::

For more information, see the [Drill down for more details](/mem/intune/protect/compliance-policy-monitor#drill-down-for-more-details) section of [Monitor results of your Intune Device compliance policies | Microsoft Learn](/mem/intune/protect/compliance-policy-monitor).

Refer to the **Device Configuration** report to see whether a policy has been applied successfully to the device. If there are issues, or to simply confirm, verify the settings on the target device itself.

:::image type="content" source="media/Troubleshoot-Update-rings/3.ProfileSettingsReport.jpg" alt-text="A screenshot of the Profile settings report for the example device.":::

## Verifying settings on the device

To confirm that the policies have applied to the device locally, navigate to Windows (10/11) **Settings** > **Accounts** and select the **Work or School account**. You’ll see which policies are applied to the device from Intune and whether they’re managed by your organization.

:::image type="content" source="media/Troubleshoot-Update-rings/4.PoliciesOnTheDevice.jpg" alt-text="A screenshot of the policies on the device in the “Managed by Organization” pane.":::

On the Windows device, navigate to **Settings** > **Windows Updates** > **View Configured Update Policies** to view the policies managed by your organization.

:::image type="content" source="media/Troubleshoot-Update-rings/5.ViewConfigureUpdatePolicies.jpg" alt-text="A screenshot of the Windows Update pane, Advanced options, highlighting the "Configured update policies" option.":::

Verify that the **Policy type** is *mobile device management*.

:::image type="content" source="media/Troubleshoot-Update-rings/6.MDMasType.jpg" alt-text="A screenshot of the Configured update policies pane with the "Set when Active Hours start” setting showing Mobile Device Management as the type.":::

The update policies are configured by your mobile device management (MDM) solution, which is Intune in this scenario. However, it's possible that the update policy is coming from the on-premises Active Directory, which would have *Group Policy* as the **Policy type**.

:::image type="content" source="media/Troubleshoot-Update-rings/7.AllowUpdatesToBeManagedBy.jpg" alt-text="A screenshot of the Configured update policies pane with the "Allow updates to be downloaded automatically over metered connections” setting showing the Group Policy as the type.":::

### Common conflicts between MDM and group policies

Mixed deployments between Intune MDM policies and group policies (GPO) can create conflicts. Many group policies are old and cached and you may not even be aware they still exist. It’s also possible some of the group policies come from System Center Configuration Manager (SCCM).

The best way to validate what policies are delivered through GPO is with the "gpresult” command. To learn more, see [gpresult | Microsoft Learn](/windows-server/administration/windows-commands/gpresult).

:::image type="content" source="media/Troubleshoot-Update-rings/8.GPResultOutput.jpg" alt-text="A screenshot of the gpresultoutput from an example device.":::

If the policy source is "Local Group Policy," it's likely being set by SCCM. If it's not, you'll see the group policy object from the Active Directory infrastructure and can edit it to remove the conflicting values.

A policy conflict between MDM and group policies appears as unexpected scenarios with the update process. Updates will either not happen or they’ll happen in an unplanned manner. For example, a device might be stuck on an earlier version of Windows and won't be able to upgrade.

Some of these conflicts can be resolved using the ControlPolicyConflict CSP. Generally, if the update process is not working as expected, you’ll need to investigate for a policy conflict. See [Policy CSP – ControlPolicyConflict | Microsoft Learn](/windows/client-management/mdm/policy-csp-controlpolicyconflict) for more information about how to use the CSP.

### Confirm that the correct registry keys have been updated

If the Windows Update ring policies are successfully deployed by Intune to the target device, you’ll be able to see those settings in the Registry under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Update.

:::image type="content" source="media/Troubleshoot-Update-rings/9.RegistryDeployment.jpg" alt-text="A screenshot of an example registry showing the successfully deployed policies in the Update folder.":::

These values should match the [Policy CSP description](/windows/client-management/mdm/policy-csp-update) and the configuration deployed in the Update ring policy from Intune.

### Check the MDM diagnostics report

Another method to verify whether the Update ring policy was deployed to the device is to check the MDM diagnostic report. On the Windows device, navigate to **Settings** > **Accounts** > **Access work or school** and then select the **Export** button. The report includes the Intune deployed policies. If the Update ring policy is in the report, the policy was successfully deployed.

:::image type="content" source="media/Troubleshoot-Update-rings/10.MDMReport.jpg" alt-text="A screenshot of an example MDM diagnostic report.":::

### Review the Event Viewer log for Intune events

Review the Event Viewer log to see how the PolicyCSP data is being delivered to the device in real-time. On the device, navigate to the **Event Viewer** application and then go to **Applications and Services** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostics** > **Admin**.

:::image type="content" source="media/Troubleshoot-Update-rings/11.EventViewer.jpg" alt-text="A screenshot of the Admin pane for MDM Policy Manager in the Event Viewer with the policies deployed to the device highlighted.":::

If the policy was successfully deployed (for example, look for the Set action), there won't be any errors or warnings.

## Optional troubleshooting methods

There may be instances when you’ll need to troubleshoot Update ring policies from the device side instead of, or in addition to, Intune.

### Review the Windows Update Client

When using the Windows Update Client, you might find errors that could help pinpoint what to do next. For example, you might see that the updates successfully downloaded (as illustrated below) which would indicate that it isn't a downloading issue. Other issues you may see here include the device not being able to scan Windows update’s URLs for new downloads or the device still scanning against WSUS after the workload has been switched to Intune.

To access Event Viewer, on the device, find the **Event Viewer** app in the Windows Start menu and then select **Applications and Services logs** > **Microsoft** > **Windows** > **Windows Update Client**.

:::image type="content" source="media/Troubleshoot-Update-rings/12.EventViewerUpdates.jpg" alt-text="A screenshot of the Event Viewer showing the message, "Windows Update successfully found 6 updates.”":::

:::image type="content" source="media/Troubleshoot-Update-rings/13.EventViewerUpdatesExample.jpg" alt-text="A screenshot of the WindowsUpdateClient with a notification about error 0x80072EE6 preventing update checks.":::

### Check the Windows Update Registry Keys source

Monitor the Windows side of things by reviewing the Windows Update source registry keys. Intune is responsible solely for deploying the values to the HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Update registry hive.

To review other configured settings for Windows Update on the device, access the Registry Editor app and navigate to: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate or Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU.

:::image type="content" source="media/Troubleshoot-Update-rings/14.UpdatesRegistryKeys.jpg" alt-text="A screenshot of the Registry Editor for Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU.":::

:::image type="content" source="media/Troubleshoot-Update-rings/15.UpdatesRegistryKeys2.jpg" alt-text="A screenshot of the Registry Editor for Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate.":::

From here, find additional information about the deployed policies that might come from group policy. For example, you might see the registry keys and the Windows Update (WU) service pointing towards WSUS rather than towards WU servers while also having Dual Scan Disabled. This would result in the device scanning against WSUS instead of WU. See [Use Windows Update for Business and WSUS together | Microsoft Learn](/windows/deployment/update/wufb-wsus), for more details.

## Considerations

If the previous options didn’t provide the results needed to identify the issue and the devices are still not updating, or are doing it erratically, then consider the following:

- Is Telemetry enabled for the devices? Telemetry can be delivered from Intune to the device in multiple ways. However, the most common method is with a [Device Restriction policy](/mem/intune/configuration/device-restrictions-windows-10#reporting-and-telemetry), either through Intune or group policy.
  - See the [Manage diagnostic data using Group Policy and MDM](/windows/privacy/configure-windows-diagnostic-data-in-your-organization#manage-diagnostic-data-using-group-policy-and-mdm) section of [Configure Windows diagnostic data in your organization | Microsoft Learn](/windows/privacy/configure-windows-diagnostic-data-in-your-organization).
- Is there an active network connection on the device? If the device is in airplane mode, turned off, or the user has the device in a location with no service, the policy will not apply until network connectivity is established.
- Does the device not upgrade past a specific version? Check for a conflicting [TargetReleaseVersion](/windows/client-management/mdm/policy-csp-update#targetreleaseversion) value through other means, such as Group policy or Settings catalog, found in the Windows Update registry keys mentioned below.
- Verify that feature and quality updates are configured to be delivered by Windows Update. If UpdateServiceUrl (see screenshot below) is populated in the Registry, verify that DisableDualScan is set to 0. On the device, access the Registry Editor app and navigate to Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate.
- Is the device co-managed? Make sure the [workload for Windows Updates has been switched to Intune](/mem/configmgr/comanage/workloads#windows-update-policies).

:::image type="content" source="media/Troubleshoot-Update-rings/16.Workloads.png" alt-text="A screenshot of the Properties dialog highlighting the Windows Update policies slider on the Workloads tab.":::

- Make sure you’re not deploying conflicting Windows Update for Business (WUfB) settings from another Update ring or from a Settings Catalog policy. Confirm your assigned Settings Catalog policies for WUfB settings that may end up being deployed.
  - For Update ring policies, you should see a “Conflict” reporting in the Device Configuration pane for the device or in the colored charts.

:::image type="content" source="media/Troubleshoot-Update-rings/17.ConflictReport.png" alt-text="A screenshot of the colored Profile assignment status – Windows 10 and later devices chart with the Succeeded and Conflict data highlighted.":::

- Be sure that the Windows Update ring policy is deployed to the correct user/device group. This is a fairly common issue that’s easy to correct.
- Determine whether the entire policy deployment fails or only certain settings aren’t being applied. Do this by navigating to **Device** > **Device Configuration** > **Update ring report**. You might see a specific setting in the list that shows an error rather than a success message (similar to the image below).

:::image type="content" source="media/Troubleshoot-Update-rings/18.ErrorExample.jpg" alt-text="A screenshot of the Profile Settings, “Automatic update behavior” and "Microsoft Product Updates,” showing a Setting status as "Conflict."":::

- Check the actual wording for the setting that’s getting the error status. For example, there may be some specific values applicable only on certain Windows versions or editions.

:::image type="content" source="media/Troubleshoot-Update-rings/19.CSPExample.jpg" alt-text="A screenshot of the Profile Settings, “A screenshot of the SetDisableUXWUAccess setting with the “User” value for Scope showing as an error.":::

See the description of each setting in [Settings for Windows Update that you can manage through Intune policy for Update rings | Microsoft Learn](/mem/intune/protect/windows-update-settings).

## Additional resources

If you have made it through this troubleshooting guide and haven’t been able to pinpoint the Windows Update ring policy as the issue, it may be an issue with the interaction between the device locally and the Windows Update services. Refer to the following resources to troubleshoot Windows Update policy issues:

- [Windows Update issues troubleshooting](/troubleshoot/windows-client/deployment/windows-update-issues-troubleshooting)
- [Windows Update common errors and mitigation](/troubleshoot/windows-client/deployment/common-windows-update-errors)
- [Windows Update troubleshooting guidance](/troubleshoot/windows-client/deployment/troubleshoot-windows-update-issues)

If you’d like to raise a support request, see the [Windows Update log](/windows/deployment/update/windows-update-logs) files to learn about the data the support engineer may need you to provide. Including this data in the support ticket could help expedite the troubleshooting process.
