---
title: Troubleshoot the Enrollment Status Page (ESP)
description: General troubleshooting guide for the Enrollment Status Page (ESP) for Windows Autopilot or OOBE for Microsoft Entra join.
author: helenclu
ms.author: luche
ms.reviewer: kaushika, ybao
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Autopilot\ESP - AccountSetup - Apps
---

# Troubleshooting the Enrollment Status Page

This article gives guidance for troubleshooting the Enrollment Status Page (ESP). The ESP can be used as part of any Windows Autopilot provisioning scenario. It can also be used separately from Windows Autopilot as part of the default out-of-box experience (OOBE) for Microsoft Entra join. For more information about how to configure the ESP, see [Set up the Enrollment Status Page](/mem/intune/enrollment/windows-enrollment-status).

To troubleshoot ESP issues, it's important to get more information about the ESP settings that are received by the device, and the applications and policies that are tracked at each stage. All ESP settings and tracking information are logged in the device registry. In this article, we'll show you how to collect MDM diagnostic log files and look for information in the registry.

See the Windows Autopilot documentation for a list of [known issues](/mem/autopilot/known-issues) and additional [troubleshooting guidance](/windows/deployment/windows-autopilot/troubleshooting).

## Collect logs

You can enable the ability for users to collect ESP logs in the ESP policy. When a timeout occurs in the ESP, the user can select the option to **Collect logs**. Log files can be copied to a USB drive.

You can also collect logs through a Command Prompt window on the device. If you are in OOBE on a non-S mode device, press Shift+F10.

Enter the appropriate command, based on your scenario:

- For all Autopilot scenarios and ESP:

  On Windows 10 versions earlier than 1809, enter `licensingdiag.exe`.

  On Windows 10, version 1809 and later versions:

  - For user-driven mode, enter the following command:

    ```console
    mdmdiagnosticstool.exe -area Autopilot -cab <pathToOutputCabFile>
    ```
  
  - For self-deploying, white glove, and any other scenarios in which a physical device is used, enter the following command:

    ```console
    mdmdiagnosticstool.exe -area Autopilot;TPM -cab <pathToOutputCabFile>
    ```

- For runtime provisioning

  On Windows 10 versions earlier than 1809, collect the following log files:

  - `%windir%\System32\winevt\Logs\Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider%4Admin.evtx`
  - `%windir%\System32\winevt\Logs\Microsoft-Windows-Provisioning-Diagnostics-Provider%4Admin.evtx`
  - `%windir%\System32\winevt\Logs\Microsoft-Windows-AAD%4Operational.evtx`

  > [!NOTE]
  > Depending on the nature of the error, all files in `%windir%\system32\winevt\logs` may be useful.

  On Windows 10, version 1809 and later versions, enter the following command:
  
  ```console
  mdmdiagnosticstool.exe -area DeviceProvisioning -cab <pathToOutputCabFile>
  ```

The generated cab file contains several files and event logs. For ESP troubleshooting, the `MDMDiagReport_RegistryDump.Reg` file contains all registry keys that are related to MDM enrollment, such as enrollment information, Windows Autopilot profile settings, policies, and applications that are being installed by Intune.

You can find the ESP settings under the following registry subkey in the `MDMDiagReport_RegistryDump.Reg` file:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Enrollments\{EnrollmentGUID}\FirstSync`

:::image type="content" source="media/understand-troubleshoot-esp/firstsync.png" alt-text="Screenshot show the location of the FirstSync key.":::

> [!NOTE]
> In some cases, you may notice that the account setup or device setup phase is skipped. This occurs if one the following custom CSPs is configured to skip that phase:
>
> - ./Vendor/MSFT/DMClient/Provider/*ProviderID*/FirstSyncStatus/SkipUserStatusPage
> - ./Vendor/MSFT/DMClient/Provider/*ProviderID*/FirstSyncStatus/SkipDeviceStatusPage
>
> In this case, the value of `SkipUserStatusPage` or `SkipDeviceStatusPage` is set to `0xffffffff` under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Enrollments\{EnrollmentGUID}\FirstSync`.

Here is a short video that shows how to collect Windows Autopilot MDM logs:

> [!VIDEO https://www.youtube.com/embed/ry88Vur6dhE]

## Diagnose Windows Autopilot issues

Use the [Get-AutopilotDiagnostics](https://www.powershellgallery.com/packages/Get-AutopilotDiagnostics/5.6) script to review log files that are captured by using the MDM Diagnostics Tool.

To install the script, run the following PowerShell command:

```powershell
Install-Script -Name Get-AutopilotDiagnostics -Force
```

To use the script to examine the generated log file, run the following PowerShell command:

```powershell
Get-AutopilotDiagnostics -CABFile <pathToOutputCabFile>
```

## Identify unexpected reboots

Reboots are supported on the ESP during the device setup phase (not supported during the account setup phase). Reboots during the device ESP process must be managed by Intune. For example, in the created package, you should specify the return codes to perform a reboot by Intune. There are some policies that conflict with the ESP and Microsoft is aware of them. For unexpected reboots, you can use the reboot-URI CSP to detect what triggers a reboot. In Event Viewer, an event is logged as follows:

```output
channel="MDM_DIAGNOSTICS_ADMIN_CHANNEL"
level="win:Informational"
message="$(string.EnterpriseDiagnostics.RebootRequiredURI)"
symbol="RebootRequiredURI"
template="OneString"
value="2800"
```

The following sample event indicates which URI triggers a coalesced reboot:

`"[ETW [2022-08-02T13:28:10.3350735Z] [Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider] [Informational] - The following URI has triggered a reboot: (./Device/Vendor/MSFT/Policy/Config/Update/ManagePreviewBuilds)"`

For more information about how to identify unexpected reboots during the OOBE flow, see [Troubleshooting unexpected reboots](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-troubleshooting-unexpected-reboots-during-new-pc/ba-p/3896960).

## Check the registry for app deployment failures during ESP

App deployment failures can cause ESP to time out. These failures can occur because of incorrect app configuration, network connectivity issues or device-specific issues.

However, ESP time-out during app deployment usually occurs because the time-out value that's set in the ESP profile isn't enough to deploy all required apps. For example, the time-out is set to five minutes when more than 15 applications are required to be installed on the device. In this case, it's unlikely that the installation can finish before time-out occurs.

Starting in Windows 10, version 1903, a new CSP [EnrollmentStatusTracking](/windows/client-management/mdm/enrollmentstatustracking-csp) is added. This CSP adds the following tracking information and installation status to the device registry:

- Intune Management Extension installation status
- Tracking policies creation status for the device setup and account setup phases
- Win32 apps installation status during the device setup and account setup phases
- Installation status of LOB and Microsoft Store for Business apps, Wi-Fi profiles, and SCEP certificate profile during the device setup and account setup phases

You can find the `EnrollmentStatusTracking` settings under the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Autopilot\EnrollmentStatusTracking`

The `EnrollmentStatusTracking` registry subkey contains the following subkeys:

- [Device](#the-device-subkey)
- [ESPTrackingInfo](#the-esptrackinginfo-subkey)
- [The security identifier (SID) of the logged-in user](#the-user_sid-subkey). This subkey is created in the account setup phase. It won't be created if the device setup phase fails.

:::image type="content" source="media/understand-troubleshoot-esp/enrollmentstatustracking.png" alt-text="Screenshot shows the location of the EnrollmentStatusTracking key.":::

### The Device subkey

This subkey contains information about the last step in the device preparation phase and the Win32 apps deployment information in the device setup phase.

:::image type="content" source="media/understand-troubleshoot-esp/device.png" alt-text="Screenshot shows the location of the device subkey.":::

This subkey contains the following subkeys:

- `DevicePreparation`
  
  Under this subkey, you can find the installation state of the Intune Management Extension (SideCar) and the type of resources this SideCar provider tracks.

  :::image type="content" source="media/understand-troubleshoot-esp/sidecar.png" alt-text="Screenshot shows the location and information of the Sidecar subkey.":::

  The following are available values of the installation state:

  - 1 (NotInstalled)
  - 2 (NotRequired)
  - 3 (Completed)
  - 4 (Error)

  During ESP, SideCar tracks only Win32 apps (no PowerShell scripts).

  :::image type="content" source="media/understand-troubleshoot-esp/trackedresourcetypes.png" alt-text="Screenshot shows the tracked resource types of SideCar.":::
- `Setup`
  
  When the device setup phase starts, this subkey contains the creation status of the tracking policy and the Win32 apps being tracked by the SideCar provider. It also contains the final installation state of each app and indicates whether a restart is required.

  :::image type="content" source="media/understand-troubleshoot-esp/setup.png" alt-text="Screenshot shows the content of the Setup key.":::

  The `Locked` value under the `Apps` subkey shows whether the device usage is blocked until this stage is completed.

  :::image type="content" source="media/understand-troubleshoot-esp/locked.png" alt-text="Screenshot shows the Locked value under Apps subkey.":::

  The `TrackingPoliciesCreated` value under the `Apps\PolicyProviders\Sidecar` subkey shows the status of tracking policies created for the device setup phase.

  :::image type="content" source="media/understand-troubleshoot-esp/trackingpoliciescreated.png" alt-text="Screenshot shows the TrackingPoliciesCreated value under the Sidecar subkey.":::

  The `InstallationState` value under each `Apps\Tracking\Sidecar\Win32App_{AppID}` subkey shows the installation status of the Win32 app that's deployed in device context.

  :::image type="content" source="media/understand-troubleshoot-esp/appinstallationstate.png" alt-text="Screenshot shows the app installation status.":::

  Available values for `InstallationState` are:

  - 1 (NotInstalled)
  - 2 (InProgress)
  - 3 (Completed)
  - 4 (Error)

  If the value of `InstallationState` for any app is 4, ESP stops installing applications. In this case, check the Intune Management Extension log file for the cause.

### The `ESPTrackingInfo` subkey

This subkey contains diagnostics information for all applications and policies that are tracked by ESP and the status of each app and policy during specific timestamps for the device setup and account setup phases.

:::image type="content" source="media/understand-troubleshoot-esp/diagnostics.png" alt-text="Screenshot shows the diagnostics information.":::

- For each LOB (MSI) app, a subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedMSIAppPackages` to record the installation status. The name of the subkey is the date and time when the status of the app is logged. If no MSI app is targeted, the subkey contains only the state of the Intune Management Extension application package.

  :::image type="content" source="media/understand-troubleshoot-esp/msiapp.png" alt-text="Screenshot shows the MSI app status.":::

- For each Wi-Fi profile, a subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedNetworkProfiles` to record the installation status. The name of the subkey is the date and time when the status of the Wi-Fi profile is logged.

  :::image type="content" source="media/understand-troubleshoot-esp/wifiprofile.png" alt-text="Screenshot shows the Wi-Fi profile status.":::

- For each SCEP certificate profile, a subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedCertificateProfiles` to record the installation status. The name of the subkey is the date and time when the status of the SCEP certificate profile is logged.

- Because ESP doesn't track security policies, only one subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedPolicies` for the dummy policy **EntDMID**.

  :::image type="content" source="media/understand-troubleshoot-esp/securitypolicies.png" alt-text="Screenshot shows the Security policy status.":::
  
- For each Microsoft Store for Business app that's deployed in device context, a subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedModernAppPackages` to record the installation status. The name of the subkey is the date and time when the status of the app is logged. If the app is deployed in user context, this subkey is created under `ESPTrackingInfo\Diagnostics\{User_SID}\ExpectedModernAppPackages`.

  In the following example, the registry value is 0. This means that the app isn't installed at 16:17:42.430Z.

  :::image type="content" source="media/understand-troubleshoot-esp/msfbapp-0.png" alt-text="Screenshot shows the first Microsoft Store for Business app status.":::

  In the following example, the registry value is 1. This means that the app is installed at 16:19:18.153Z.

  :::image type="content" source="media/understand-troubleshoot-esp/msfbapp-1.png" alt-text="Screenshot shows the second Microsoft Store for Business app status.":::

### The {*User_SID*} subkey

This subkey is created during the account setup phase if the device setup phase is completed successfully. It  contains the installation state of Win32 apps that are deployed in user context, and the creation status of the tracking policy for the account setup phase.

:::image type="content" source="media/understand-troubleshoot-esp/usersid.png" alt-text="Screenshot shows the information of the user SID subkey.":::

## Common questions for ESP troubleshooting

### Why were my applications not installed and tracked by using the ESP?

To guarantee that applications are installed and tracked by using the ESP, make sure that the following conditions are true:

- The apps are assigned to a Microsoft Entra group that contains the device (for device-targeted apps) or the user (for user-targeted apps), by using a **required** assignment. (Device-targeted apps are tracked during the device setup phase, and user-targeted apps are tracked during the user setup phase.)
- You either specify **Block device use until all apps and profiles are installed** or include the app in the **Block device use until these required apps are installed** list.
- The apps install in device context, and they have no user-context applicability rules.

### Why is the ESP showing for deployments not related to Windows Autopilot, such as when a user logs in for the first time on a Configuration Manager co-management enrolled device?

The ESP lists the installation status for all enrollment methods, including:

- Windows Autopilot
- Configuration Manager co-management
- when any new user logs into the device that has ESP policy applied for the first time
- when the **Only show page to devices provisioned by out-of-box experience (OOBE)** setting is on and the policy is set, only the first user who signs into the device gets the ESP

### How can I disable the user ESP portion of the Enrollment Status Page (ESP) if an ESP has been configured on the device?

ESP policy is set on a device at the time of enrollment. To disable the user ESP portion of the Enrollment Status Page (ESP), create a custom OMA-URI setting by using the following configuration:

- Disable user Enrollment Status Page:

  Name:  Disable User ESP (choose any name that you want)  
  Description:  (enter a description)  
  OMA-URI:  ./Vendor/MSFT/DMClient/Provider/MS DM Server/FirstSyncStatus/SkipUserStatusPage  
  Data type:  Boolean  
  Value:  True  
