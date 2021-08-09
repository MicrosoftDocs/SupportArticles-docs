---
title: Understand and troubleshoot the Enrollment Status Page
description: Describes the implementation and workflow behind ESP and provides general troubleshooting guide.
author: helenclu
ms.author: luche
ms.reviewer: ybao
ms.date: 08/24/2020
ms.prod-support-area-path: Windows enrollment
---
# Understand and troubleshoot the Enrollment Status Page

The Enrollment Status Page (ESP) displays the provisioning progress when a new device is enrolled, as well as when new users sign into the device. ESP enables users to track both the completed and remaining tasks in the provisioning process. It also enables IT administrators to block access to the device until the required security policies and applications are installed.

The ESP can be used as part of any Windows Autopilot provisioning scenario. It can also be used separately from Windows Autopilot as part of the default out-of-box experience (OOBE) for Azure Active Directory (Azure AD) Join. For more information about how to configure the ESP, see [Set up the Enrollment Status Page](/mem/intune/enrollment/windows-enrollment-status)

## The ESP implementation

ESP uses the [EnrollmentStatusTracking configuration service provider (CSP)](/windows/client-management/mdm/enrollmentstatustracking-csp) and [FirstSyncStatus CSP](/windows/client-management/mdm/dmclient-csp) to track the installation of different apps.

- **EnrollmentStatusTracking CSP**: ./Vendor/MSFT/EnrollmentStatusTracking
  
  The `EnrollmentStatusTracking` CSP is supported in Windows 10 version 1903 and later versions. It's used to track the installation of the SideCar agent (Intune Management Extension) and Win32 apps.
- **FirstSyncStatus CSP**: ./Vendor/MSFT/DMClient/Provider/*ProviderID*/FirstSyncStatus

  The `FirstSyncStatus` CSP is supported in Windows 10, versions 1709 and later versions. It's responsible for delivering the ESP payload that's configured from Intune. The payload includes ESP settings such as the timeout period, applications that are required to be installed and so on. It also delivers the expected MSI (LOB) applications, Microsoft Store for Business apps, Wi-Fi profiles, and SCEP certificate profile.

## Phases tracked by ESP

There are three phases for which the ESP tracks information.

### Device preparation

The device preparation phase contains the following steps.

> [!NOTE]
> The first three steps depend on the Windows Autopilot deployment scenario. In user-drive mode, these steps are immediately reported as being completed because they either aren't required or have finished before ESP starts.

1. Secure the hardware

   This step isn't required in Windows Autopilot user-driven mode. It's required in self-deploying mode and white glove deployment.

   At this step, the device completes the Trusted Platform Module (TPM) attestation process and sends its hardware hash to Azure AD to prove its identity. When the hardware hash is imported, the Device Directory Service (DDS) creates the computer object. Then, Azure AD sends a device token to the device. This is the token that will be used in Azure AD join.

   If the device isn't identified by Azure AD, this step will time out and you'll receive a **Securing your hardware failed with error (0x800705b4)** error message. This error may also be caused by an issue that's related to TPM attestation.
2. Azure AD join

   In user-driven mode, this step is already completed before ESP starts when the user enters the corporate credentials. It's required in self-deploying mode and white glove deployment.

   At this step, the device joins Azure AD by using the token it received in the previous step.
3. Intune (MDM) enrollment
  
   In user-driven mode, this step is already completed before ESP starts when the user enters the corporate credentials. It's required in self-deploying mode and white glove deployment.

   At this step, the device is enrolled in Intune.

   This step may fail and return error **0x801c0003** for one of the following reasons:

    - The user or device is not authorized
    - In self-deploying mode and white glove deployment, the TPM doesn't meet the minimum requirements. For example, the TPM version isn't 2.0 or the TPM EK certificate is missing.
  
   If you receive this error message, check the User Device Registration event logs. Also check the MDM diagnostic log file for any TPM-related error in CertReq_Enrollaik.txt and TpmHliInfo.txt.
4. Prepare the device for MDM

   At this step, the device calculates the policies and apps that are required to be tracked. In Windows 10, version 1903 and later versions, the device also creates the tracking policy for the SideCar agent, and installs the Intune Management Extension.

### Device setup

The device creates the tracking policy for this phase, calculates all apps and policies targeted to the device context and starts the installation. Before the tracking policy is created, you will see all subtasks in the **Identifying** state.

- Security policies

  ESP doesn't track any security policies such as device restriction. However, these policies are installed in the background. You will always see **(1 of 1) completed** in the UI.

- Certificate profiles

   Only SCEP certificate profiles deployed in device context are installed. If the device can't get the certificate profiles, it will keep trying until a time-out occurs. In this situation, ESP fails.

- Network profiles

   Only Wi-Fi profiles that are deployed in device context are installed. If the Wi-Fi profiles can't be installed, the device will keep trying until a time-out occurs. In this situation, ESP fails.

- Applications

  All LOB, Microsoft Store for Business and Win32 apps that are deployed in device context are installed.

  >[!NOTE]
  > It's preferable to deploy the offline-licensed Microsoft Store for Business apps. Don't mix LOB and Win32 apps. Both LOB (MSI) and Win32 installers use TrustedInstaller which doesn't allow simultaneous installations. If the OMA DM agent starts an MSI installation, the Intune Management Extension plugin starts a Win32 app installation by using the same TrustedInstaller. In this situation, Win32 app installation fails and returns an **Another installation is in progress, please try again later** error message. In this situation, ESP fails. Therefore, don't mix LOB and Win32 apps in any type of Autopilot enrollment.

### Account setup

The device creates the tracking policy for this phase, calculates all apps and policies that are targeted to the user context, and then starts the installation. Before the tracking policy is created, you will see all subtasks in the **Identifying** state.

- Join the organization

  In hybrid Azure AD Autopilot deployment, the device should have been hybrid Azure AD joined by this time. In user-driven mode for hybrid Azure AD join, the user is redirected to the Windows sign-in screen to enter the on-premises credentials to obtain the Primary Refresh Token (PRT). After authentication is completed, the user is brought back to the ESP to finish the remaining subtasks. By using the PRT, the user can communicate with the service and start installing the targeted policies and apps.
  
  Typically, it takes Azure AD Connect up to 40 minutes to sync the device from on-premises Active Directory to Azure AD. If the device hasn't been synced, the user can still authenticate but the PRT isn't obtained. Therefore, the user can't communicate with the service to evaluate the targeted apps and policies. Therefore, the account setup is stuck on **Identifying** until the ESP times out and fails.
  
  Sometimes, the time that's required to install applications in the device setup phase isn't long enough for Azure AD Connect to sync the device. In this situation, we recommend that you send a custom CSP to disable the account setup phase to avoid the potential time-out.

- Security policies

  Similar to the device setup phase, ESP doesn't track any security policies such as device restriction. However, these policies are installed in the background. You will always see **(1 of 1) completed** in the UI.

- Certificate profiles

   Only SCEP certificate profiles that are deployed in user context are installed. If the device can't get the certificate profiles, it will keep trying until a time-out occurs. In this situation, ESP fails.

- Network profiles

   Only Wi-Fi profiles that are deployed in user context are installed. If the Wi-Fi profiles can't be installed, the device will keep trying until a time-out occurs. In this situation, ESP fails.

- Applications

  All LOB, Microsoft Store for Business and Win32 apps that are deployed in user context are installed. Online-licensed Microsoft Store for Business apps that are deployed in user context can be installed. Again, don't mix LOB and Win32 apps.

## Troubleshooting

There are some [known issues](/mem/intune/enrollment/windows-enrollment-status#known-issues) related to the ESP.

To troubleshoot ESP issues, it's important to get more information about the ESP settings that are received by the device, and the applications and policies that are tracked at each stage. All ESP settings and tracking information are logged in the device registry. In this section, we'll show you how to collect MDM diagnostic log files and look for information in the registry.

### Collect logs

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

The generated cab file contains several files and event logs. For ESP troubleshooting, the `MDMDiagReport_RegistryDump.Reg` file contains all registry keys that are related to MDM enrollment, such as enrollment information, Autopilot profile settings, policies, and applications that are being installed by Intune.

You can find the ESP settings under the following registry subkey in the `MDMDiagReport_RegistryDump.Reg` file:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Enrollments\{EnrollmentGUID}\FirstSync`

:::image type="content" source="media/understand-troubleshoot-esp/firstsync.png" alt-text="The FirstSync key":::

> [!NOTE]
> In some cases, you may notice that the account setup or device setup phase is skipped. This occurs if one the following custom CSPs is configured to skip that phase:
>
> - ./Vendor/MSFT/DMClient/Provider/*ProviderID*/FirstSyncStatus/SkipUserStatusPage
> - ./Vendor/MSFT/DMClient/Provider/*ProviderID*/FirstSyncStatus/SkipDeviceStatusPage
>
> In this case, the value of `SkipUserStatusPage` or `SkipDeviceStatusPage` is set to `0xffffffff` under `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Enrollments\{EnrollmentGUID}\FirstSync`.

Here is a short video that shows how to collect Windows Autopilot MDM logs:

> [!VIDEO https://www.youtube.com/embed/ry88Vur6dhE]

### Diagnose Autopilot issues

Use the [Get-AutopilotDiagnostics](https://www.powershellgallery.com/packages/Get-AutopilotDiagnostics/5.6) script to review log files that are captured by using the MDM Diagnostics Tool.

To install the script, run the following PowerShell command:

```powershell
Install-Script -Name Get-AutopilotDiagnostics -Force
```

To use the script to examine the generated log file, run the following PowerShell command:

```powershell
Get-AutopilotDiagnostics -CABFile <pathToOutputCabFile>
```

### Check the registry for app deployment failures during ESP

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

:::image type="content" source="media/understand-troubleshoot-esp/enrollmentstatustracking.png" alt-text="The EnrollmentStatusTracking key":::

#### The Device subkey

This subkey contains information about the last step in the device preparation phase and the Win32 apps deployment information in the device setup phase.

:::image type="content" source="media/understand-troubleshoot-esp/device.png" alt-text="The device key":::

This subkey contains the following subkeys:

- `DevicePreparation`
  
  Under this subkey, you can find the installation state of the Intune Management Extension (SideCar) and the type of resources this SideCar provider tracks.

  :::image type="content" source="media/understand-troubleshoot-esp/sidecar.png" alt-text="The Sidecar key":::

  The following are available values of the installation state:

  - 1 (NotInstalled)
  - 2 (NotRequired)
  - 3 (Completed)
  - 4 (Error)

  During ESP, SideCar tracks only Win32 apps (no PowerShell scripts).

  :::image type="content" source="media/understand-troubleshoot-esp/trackedresourcetypes.png" alt-text="Tracked resource types":::
- `Setup`
  
  When the device setup phase starts, this subkey contains the creation status of the tracking policy and the Win32 apps being tracked by the SideCar provider. It also contains the final installation state of each app and indicates whether a restart is required.

  :::image type="content" source="media/understand-troubleshoot-esp/setup.png" alt-text="The Setup key":::

  The `Locked` value under the `Apps` subkey shows whether the device usage is blocked until this stage is completed.

  :::image type="content" source="media/understand-troubleshoot-esp/locked.png" alt-text="The Locked value":::

  The `TrackingPoliciesCreated` value under the `Apps\PolicyProviders\Sidecar` subkey shows the status of tracking policies created for the device setup phase.

  :::image type="content" source="media/understand-troubleshoot-esp/trackingpoliciescreated.png" alt-text="The TrackingPoliciesCreated value":::

  The `InstallationState` value under each `Apps\Tracking\Sidecar\Win32App_{AppID}` subkey shows the installation status of the Win32 app that's deployed in device context.

  :::image type="content" source="media/understand-troubleshoot-esp/appinstallationstate.png" alt-text="The app installation status":::

  Available values for `InstallationState` are:

  - 1 (NotInstalled)
  - 2 (NotRequired)
  - 3 (Completed)
  - 4 (Error)

  If the value of `InstallationState` for any app is 4, ESP stops installing applications. In this case, check the Intune Management Extension log file for the cause.

#### The `ESPTrackingInfo` subkey

This subkey contains diagnostics information for all applications and policies that are tracked by ESP and the status of each app and policy during specific timestamps for the device setup and account setup phases.

:::image type="content" source="media/understand-troubleshoot-esp/diagnostics.png" alt-text="The diagnostics information":::

- For each LOB (MSI) app, a subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedMSIAppPackages` to record the installation status. The name of the subkey is the date and time when the status of the app is logged. If no MSI app is targeted, the subkey contains only the state of the Intune Management Extension application package.

  :::image type="content" source="media/understand-troubleshoot-esp/msiapp.png" alt-text="MSI app status":::

- For each Wi-Fi profile, a subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedNetworkProfiles` to record the installation status. The name of the subkey is the date and time when the status of the Wi-Fi profile is logged.

  :::image type="content" source="media/understand-troubleshoot-esp/wifiprofile.png" alt-text="Wi-Fi profile status":::

- For each SCEP certificate profile, a subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedCertificateProfiles` to record the installation status. The name of the subkey is the date and time when the status of the SCEP certificate profile is logged.

- Because ESP doesn't track security policies, only one subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedPolicies` for the dummy policy **EntDMID**.

  :::image type="content" source="media/understand-troubleshoot-esp/securitypolicies.png" alt-text="Security policy status":::
  
- For each Microsoft Store for Business app that's deployed in device context, a subkey is created under `ESPTrackingInfo\Diagnostics\ExpectedModernAppPackages` to record the installation status. The name of the subkey is the date and time when the status of the app is logged. If the app is deployed in user context, this subkey is created under `ESPTrackingInfo\Diagnostics\{User_SID}\ExpectedModernAppPackages`.

  In the following example, the registry value is 0. This means that the app isn't installed at 16:17:42.430Z.

  :::image type="content" source="media/understand-troubleshoot-esp/msfbapp1.png" alt-text="Microsoft Store for Business app status one":::

  In the following example, the registry value is 1. This means that the app is installed at 16:19:18.153Z.

  :::image type="content" source="media/understand-troubleshoot-esp/msfbapp2.png" alt-text="Microsoft Store for Business app status two":::

#### The {*User_SID*} subkey

This subkey is created during the account setup phase if the device setup phase is completed successfully. It  contains the installation state of Win32 apps that are deployed in user context, and the creation status of the tracking policy for the account setup phase.

:::image type="content" source="media/understand-troubleshoot-esp/usersid.png" alt-text="The user SID subkey":::

### Common questions for troubleshooting ESP-related issues

#### Why were my applications not installed and tracked by using the ESP

To guarantee that applications are installed and tracked by using the ESP, make sure that the following conditions are true:

- The apps are assigned to an Azure AD group that contains the device (for device-targeted apps) or the user (for user-targeted apps), by using a **required** assignment. (Device-targeted apps are tracked during the device setup phase, and user-targeted apps are tracked during the user setup phase.)
- You either specify **Block device use until all apps and profiles are installed** or include the app in the **Block device use until these required apps are installed** list.
- The apps install in device context, and they have no user-context applicability rules.

#### Why is the ESP showing for non-Autopilot deployments, such as when a user logs in for the first time on a Configuration Manager co-management enrolled device

The ESP lists the installation status for all enrollment methods, including:

- Autopilot
- Configuration Manager co-management
- when any new user logs into the device that has ESP policy applied for the first time
- when the **Only show page to devices provisioned by out-of-box experience (OOBE)** setting is on and the policy is set, only the first user who signs into the device gets the ESP

#### How can I disable the ESP if it has been configured on the device

ESP policy is set on a device at the time of enrollment. To disable the ESP, you must disable the user Enrollment Status Page section. To disable the section, create custom OMA-URI settings by using the following configurations:

- Disable user Enrollment Status Page:

  Name:  Disable User ESP (choose any name that you want)  
  Description:  (enter a description)  
  OMA-URI:  ./Vendor/MSFT/DMClient/Provider/*ProviderID*/FirstSyncStatus/SkipUserStatusPage  
  Data type:  Boolean  
  Value:  True  
