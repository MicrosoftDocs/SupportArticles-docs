---
title: Troubleshooting BitLocker policies from the client side
description: How to troubleshoot BitLocker encryption issues on the client side for Windows devices you manage with Microsoft Intune.
ms.reviewer: kaushika, luker
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Configure Devices - Windows\Endpoint Protection
--- 
# Troubleshooting BitLocker policies from the client side

This article provides guidance on how to troubleshoot BitLocker encryption on the client side. While the Microsoft Intune [encryption report](troubleshoot-bitlocker-admin-center.md) can help you identify and troubleshoot common encryption issues, some status data from the BitLocker configuration service provider (CSP) might not be reported. In these scenarios, you will need to access the device to investigate further.

## BitLocker encryption process

The following steps describe the flow of events that should result in a successful encryption of a Windows 10 device that has not been previously encrypted with BitLocker.

1. An administrator [configures a BitLocker policy in Intune](/mem/intune/protect/encrypt-devices#create-an-endpoint-security-policy-for-bitlocker) with the desired settings, and targets a user group or device group.
1. The policy is saved to a tenant in the Intune service.
1. A Windows 10 Mobile Device Management (MDM) client syncs with the Intune service and processes the BitLocker policy settings.
1. The BitLocker MDM policy Refresh scheduled task runs on the device that replicates the BitLocker policy settings to full volume encryption (FVE) registry key.
1. BitLocker encryption is initiated on the drives.

The [encryption report](/mem/intune/protect/encryption-monitor) will show encryption status details for each targeted device in Intune. For detailed guidance on how to use this information for troubleshooting, see [Troubleshooting BitLocker with the Intune encryption report](troubleshoot-bitlocker-admin-center.md).

## Initiate a manual sync

If you've determined that there is no actionable information in the encryption report, you'll need to gather data from the affected device to complete the investigation.

Once you have access to the device, the *first step* is to [initiate a sync](/mem/intune/user-help/sync-your-device-manually-windows) with the Intune service manually before collecting the data. On your Windows device, select **Settings** > **Accounts** > **Access work or school** > &lt;Select your work or school account&gt; > **Info**. Then under **Device sync status**, select **Sync**.

After the sync is complete, continue to the following sections.

## Collecting event log data

The following sections explain how to collect data from different logs to help troubleshoot encryption status and policies. Make sure you complete a manual sync before you collect log data.

### Mobile device management (MDM) agent event log

The MDM event log is useful to determine if there was an issue processing the Intune policy or applying CSP settings. The OMA DM agent will connect to the Intune service and attempt to process the policies targeted at the user or device. This log will show success and failures processing Intune policies.

Collect or review the following information:

**LOG** > **DeviceManagement-Enterprise-Diagnostics-Provider admin**

- Location: Right-click on **Start Menu** > **Event Viewer** > **Applications and Service Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostics-Provider** > **Admin**
- File system location: C:\Windows\System32\winevt\Logs\Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider%4Admin.evtx

To filter this log, right-click the event log and select **Filter Current Log** > **Critical/Error/Warning**. Then search through the filtered logs for BitLocker (press F3 and enter the text).

Errors in BitLocker settings will follow the format of the BitLocker CSP, so you will see entries like this:

> ./Device/Vendor/MSFT/BitLocker/RequireDeviceEncryption 

or

> ./Vendor/MSFT/BitLocker/ConfigureRecoveryPasswordRotation

> [!NOTE]
> You can also enable debug logging for this event log using the Event Viewer for troubleshooting.

### BitLocker-API management event log

This is the main event log for BitLocker. If the MDM agent processed the policy successfully and there are no errors in the DeviceManagement-Enterprise-Diagnostics-Provider admin event log, this is the next log to investigate.

**LOG** > **BitLocker-API management**

- Location: Right-click on **Start Menu** > **Event Viewer** > **Applications and Service Logs** > **Microsoft** > **Windows** > **BitLocker-API**
- File system location: C:\Windows\System32\winevt\Logs\Microsoft-Windows-BitLocker%4BitLocker Management.evtx

Usually, errors are logged here if there are hardware or software prerequisites missing that the policy requires such as Trusted Platform Module (TPM) or Windows Recovery Environment (WinRE).  

#### Error: Failed to enable Silent Encryption

As shown in the following example, conflicting policy settings that cannot be implemented during silent encryption and manifest as group policy conflicts are also logged:

> Failed to enable Silent Encryption.

> Error: BitLocker Encryption cannot be applied to this drive because of conflicting Group Policy settings. When write access to drives not protected by BitLocker is denied, the use of a USB startup key cannot be required. Please have your system administrator resolve these policy conflicts before attempting to enable BitLocker.

**Solution:** Configure the compatible TPM startup PIN to **Blocked**. This will resolve conflicting Group Policy settings when using silent encryption.

You must set the PIN and TPM startup key to **Blocked** if silent encryption is required. Configuring the TPM startup PIN and startup key to **Allowed** and other startup key and PIN setting to **Blocked** for user interaction and will result in a *conflicting* Group Policy error in BitLocker-AP event log. Also, if you configure TPM startup PIN or startup key to require user interaction, it will cause silent encryption to fail.

Configuring any of the compatible TPM settings to **Required** will cause silent encryption to fail.

:::image type="content" source="media\troubleshoot-bitlocker-policies\os-drive-settings.png" alt-text="BitLocker OS Drive Settings that shows Compatible TPM startup set to Required.":::

#### Error: TPM not available

Another common error in the BitLocker-API log is that the TPM is not available. The following example shows that TPM is a requirement for silent encryption:

> Failed to enable Silent Encryption. TPM is not available.

> Error: A compatible Trusted Platform Module (TPM) Security Device cannot be found on this computer.

**Solution:** Ensure there is a TPM available on the device and if it is present, check the status via TPM.msc or the PowerShell cmdlet get-tpm.

#### Error: Un-Allowed DMA capable bus

If the BitLocker-API log displays the following status, it means that Windows has detected an attached Direct memory access (DMA)-capable device that might expose a DMA threat.

> Un-Allowed DMA capable bus/device(s) detected

**Solution:** To remediate this issue, first verify that the device has no external DMA ports with the original equipment manufacturer (OEM). Then follow these steps to add the device to the allowed list. Note: Only add a DMA device to the allowed list if it is an internal DMA interface/bus.

### System event log

If you're having hardware-related issues—such as problems with the TPM—errors will appear in the system event log for TPM from the TPMProvisioningService or TPM-WMI source.

**LOG** > **System event**

- Location: Right-click on **Start Menu** > **Event Viewer** > **Windows Logs** > **System**
- File system location: C:\Windows\System32\winevt\Logs\System.evtx

:::image type="content" source="media\troubleshoot-bitlocker-policies\filtering-properties.png" alt-text="Filtering properties for the System event log.":::

Filter on these event sources to help identify any hardware-related issues that the device may be experiencing with the TPM and check with the OEM manufacturer whether there are any firmware updates available.

### Task scheduler operational event log

The task scheduler operational event log is useful for troubleshooting scenarios where the policy has been received from Intune (has been processed in DeviceManagement-Enterprise), but BitLocker encryption has not successfully initiated. BitLocker MDM policy refresh is a scheduled task that should run successfully when the MDM agent syncs with the Intune service.

Enable and run the operational log in the following scenarios:

- The BitLocker policy appears in the DeviceManagement-Enterprise-Diagnostics-Provider admin event log, in MDM diagnostics, and the registry.  
- There are no errors (the policy has been picked up successfully from Intune).  
- Nothing is logged in the BitLocker-API event log to show that encryption was even attempted.

**LOG** > **Task scheduler operational event**

- Location: **Event Viewer** > **Applications and Service Logs** > **Microsoft** > **Windows** > **TaskScheduler**
- File system location: C:\Windows\System32\winevt\Logs\Microsoft-Windows-TaskScheduler%4Operational.evtx

#### Enable and run the operational event log

> [!IMPORTANT]
> You must manually enable this event log before logging any data because the log will identify any problems running the BitLocker MDM policy Refresh scheduled task.

1. To enable this log, right-click on **Start Menu** > **Event Viewer** > **Applications and Services** > **Microsoft** > **Windows** > **TaskScheduler** > **Operational**.

    :::image type="content" source="media\troubleshoot-bitlocker-policies\operational-logs.png" alt-text="Screenshot of the TaskScheduler - Operational Logs.":::

1. Then enter task scheduler in the Windows search box, and select **Task Scheduler** > **Microsoft** > **Windows** > **BitLocker**. Right-click on BitLocker MDM policy Refresh and choose **Run**.

1. When the run is complete, inspect the **Last Run Result** column for any error codes and examine the task schedule event log for errors.

   :::image type="content" source="media\troubleshoot-bitlocker-policies\task-scheduler.png" alt-text="Example screenshot of BitLocker tasks in Task Scheduler.":::

    In the example above, 0x0 has run successfully. The error 0x41303 this means the task has never previously run.

> [!NOTE]
> For more information about Task Scheduler error messages, see [Task Scheduler Error and Success Constants](/windows/win32/taskschd/task-scheduler-error-and-success-constants).

## Checking BitLocker settings

The following sections explain the different tools you can use to check your encryption settings and status.

### MDM Diagnostics Report

You can create a report of MDM logs to diagnose enrollment or device management issues in Windows 10 devices managed by Intune. The MDM Diagnostic Report contains useful information about an Intune enrolled device and the policies deployed to it.

For a tutorial of this process, see the YouTube video [How to create an Intune MDM diagnostic report on Windows devices](https://www.youtube.com/watch?v=WKxlcjV4TNE)

- File system location: C:\Users\Public\Documents\MDMDiagnostics

#### OS build and edition

The first step in understanding why your encryption policy is not applying correctly is to check whether the Windows OS version and edition supports the settings you configured. Some CSPs were introduced on specific versions of Windows and will only work on a certain edition. For example, the bulk of BitLocker CSP settings were introduced in Windows 10, version 1703 but these settings weren't supported on Windows 10 Pro until Windows 10, version 1809.

Additionally, there are settings such as AllowStandardUserEncryption (added in version 1809), ConfigureRecoveryPasswordRotation (added in version 1909), RotateRecoveryPasswords (added in version 1909), and Status (added in version 1903).

#### Investigating with the EntDMID

The EntDMID is a unique device ID for Intune enrollment. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), you can use the EntDMID to search through the **All Devices** view and identify a specific device. It is also a crucial piece of information for Microsoft support to enable further troubleshooting on the service side if a support case is required.

You can also use the MDM Diagnostic Report to identify whether a policy has been successfully sent to the device with the settings the administrator configured. By using the BitLocker CSP as a reference, you can decipher which settings have been picked up when syncing with the Intune service. You can use the report to determine if the policy is targeting the device and use the [BitLocker CSP documentation](/windows/client-management/mdm/bitlocker-csp) to identify what settings have been configured.

### MSINFO32

MSINFO32 is an information tool that contains device data you can use to determine if a device satisfies BitLocker prerequisites. The required prerequisites will depend on BitLocker policy settings and the required outcome. For example, silent encryption for TPM 2.0 requires a TPM and Unified Extensible Firmware Interface (UEFI).

- Location: In the Search box, enter **msinfo32**, right-click **System Information** in the search results, and select **Run as administrator**.
- File system location: C:\Windows\System32\Msinfo32.exe.

However, if this item doesn't meet the prerequisites, it doesn't necessarily mean that you can't encrypt the device using an Intune policy.

- If you have configured the BitLocker policy to encrypt silently and the device is using TPM 2.0, it is important to verify that BIOS mode is UEFI. If the TPM is 1.2, then having the BIOS mode in UEFI is not a requirement.
- Secure boot, DMA protection, and PCR7 configuration are not required for silent encryption but might be highlighted in **Device Encryption Support**. This is to ensure support for automatic encryption. 
- BitLocker policies that are configured to not require a TPM and have user interaction rather than encrypt silently will also not have prerequisites to check in MSINFO32.

### TPM.MSC file

TPM.msc is a Microsoft Management Console (MMC) Snap-in file. You can use TPM.msc to determine whether your device has a TPM, to identity the version, and whether it is ready for use.

- Location: In the Search box, enter **tpm.msc**, and then right-click and select **Run as administrator**.
- File system location: MMC Snap-in C:\Windows\System32\mmc.exe.

TPM is not a prerequisite for BitLocker but is highly recommended due to the increased security it provides. However, TPM is required for silent and automatic encryption. If you're trying to encrypt silently with Intune and there are TPM errors in the BitLocker-API and system event logs, TPM.msc will help you understand the problem.

The following example shows a healthy TPM 2.0 status. Note the specification version 2.0 in the bottom right and that the status is ready for use.

:::image type="content" source="media\troubleshoot-bitlocker-policies\healthy-tpm.png" alt-text="Example screenshot of a healthy TPM 2.0 status in the Trusted Platform Module console.":::

This example shows an unhealthy status when the TPM is disabled in the BIOS:

:::image type="content" source="media\troubleshoot-bitlocker-policies\unhealthy-tpm.png" alt-text="Example screenshot of an unhealthy TPM 2.0 status in the Trusted Platform Module console.":::

Configuring a policy to require a TPM and expecting BitLocker to encrypt when the TPM is missing or unhealthy is one of the most common issues.

### Get-Tpm cmdlet

A cmdlet is a lightweight command in the Windows PowerShell environment. In addition to running TPM.msc, you can verify the TPM using the Get-Tpm cmdlet. You will need to run this cmdlet with administrator rights.

- Location: In the Search box enter **cmd**, and then right-click and select **Run as administrator** > **PowerShell** > **get-tpm**.

:::image type="content" source="media\troubleshoot-bitlocker-policies\tpm-ps.png" alt-text="Example screenshot of a present and active TPM in a PowerShell window.":::

In the example above, you can see that the TPM is present and active in the PowerShell window. The values equal True. If the values were set to False, it would indicate a problem with the TPM. BitLocker will not be able to use the TPM until it is present, ready, enabled, activated, and owned.

### Manage-bde command-line tool

Manage-bde is a BitLocker encryption command-line tool included in Windows. It's designed to help with administration after BitLocker is enabled.

- Location: In the Search box, enter **cmd**, right-click and select **Run as administrator**, and then enter **manage-bde -status**.
- File system location: C:\Windows\System32\manage-bde.exe.

:::image type="content" source="media\troubleshoot-bitlocker-policies\manage-bde.png" alt-text="Example screenshot of the manage-bde.exe command in a Command Prompt window.":::

You can use manage-bde to discover the following information about a device:

- Is it encrypted? If reporting in the Microsoft Intune admin center indicates a device is not encrypted, this command-line tool can identify the encryption status.
- Which encryption method has been used? You can compare information from the tool to the encryption method in the policy to make sure they match. For example, if the Intune policy is configured to XTS-AES 256-bit and the device is encrypted using XTS-AES 128-bit, this will result in errors in Microsoft Intune admin center policy reporting.
- What specific protectors are being used? There are several [combinations of protectors](/windows/security/operating-system-security/data-protection/bitlocker/planning-guide). Knowing which protector is used on a device will help you understand if the policy has been applied correctly.

In the following example, the device is not encrypted:

:::image type="content" source="media\troubleshoot-bitlocker-policies\not-encrypted.png" alt-text="Example screenshot of a device not encrypted with BitLocker.":::

## BitLocker registry locations

This is the first place in the registry to look when you want to decipher the policy settings picked up by Intune:

- Location: Right-click on **Start** > **Run** and then enter **regedit** to open the Registry Editor.  
- Default file system location:
Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\BitLocker

The MDM agent registry key will help you identify the Globally Unique Identifier (GUID) in the PolicyManager that contains the actual BitLocker policy settings.

:::image type="content" source="media\troubleshoot-bitlocker-policies\registry-location.png" alt-text="BitLocker registry location in the Registry Editor.":::

The GUID is highlighted in the above example. You can include the GUID (it will be different for each tenant) in the following registry subkey to troubleshoot BitLocker policy settings:

> Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Providers\<GUID>\default\Device\BitLocker

:::image type="content" source="media\troubleshoot-bitlocker-policies\registry-editor.png" alt-text="Screenshot of the Registry Editor displaying the BitLocker policy settings configured by the MDM agent":::

This report shows the BitLocker policy settings that have been picked up by the MDM agent (OMADM client). These are the same settings that you will see in the MDM Diagnostic report, so this is an alternative way of identifying settings that the client has picked up.

Example of **EncryptionMethodByDriveType** registry key:

```
<enabled/><data id="EncryptionMethodWithXtsOsDropDown_Name" value="6"/><data id="EncryptionMethodWithXtsFdvDropDown_Name" value="6"/><data id="EncryptionMethodWithXtsRdvDropDown_Name" value="3"/>
```

Example of **SystemDrivesRecoveryOptions**:

```
<enabled/><data id="OSAllowDRA_Name" value="true"/><data id="OSRecoveryPasswordUsageDropDown_Name" value="2"/><data id="OSRecoveryKeyUsageDropDown_Name" value="2"/><data id="OSHideRecoveryPage_Name" value="false"/><data id="OSActiveDirectoryBackup_Name" value="true"/><data id="OSActiveDirectoryBackupDropDown_Name" value="1"/><data id="OSRequireActiveDirectoryBackup_Name" value="true"/> 
```

### BitLocker registry key

The settings in the policy provider registry key will be duplicated into the main BitLocker registry key. You can compare the settings to ensure they match what appears in the policy settings in the user interface (UI), MDM log, MDM diagnostics and the policy registry key.

- Registry key location: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE

This is an example of the FVE registry key:

:::image type="content" source="media\troubleshoot-bitlocker-policies\registry-keys.png" alt-text="Screenshot of the BitLocker registry keys found in the Registry Editor.":::

- **A:** EncryptionMethodWithXtsOs, EncryptionMethodWithXtsFdv and EncryptionMethodWithXtsRdv have the following possible values:
  - 3 = AES-CBC 128
  - 4 = AES-CBC 256
  - 6 = XTS-AES 128
  - 7 = XTS-AES 256
- **B:** UseTPM, UseTPMKey, UseTPMKeyPIN, USeTPMPIN are all set to 2, which means they are all set to allow.
- **C:** Notice that most of the keys are divided into groups of settings for the operating system drive (OS), fixed drive (FDV) and removable drive (FDVR).
- **D:** OSActiveDirectoryBackup has a value of 1 and is enabled.
- **E:** OSHideRecoveryPage is equal to 0 and not enabled.

Use the [BitLocker CSP documentation](/windows/client-management/mdm/bitlocker-csp) to decode all of the setting names in the registry.

### REAgentC.exe command-line tool

REAgentC.exe is a command-line executable tool that you can use to configure the Windows Recovery Environment (Windows RE). WinRE is a prerequisite for enabling BitLocker in certain scenarios such as silent or automatic encryption.

- Location: Right-click on **Start** > **Run**, enter **cmd**. Then right-click **cmd** and select **Run as administrator** > **reagentc /info**.
- File system location: C:\Windows\System32\ReAgentC.exe.

> [!TIP]
> If you see error messages in the BitLocker-API about WinRe not being enabled, run the **reagentc /info** command on the device to determine the WinRE status.

:::image type="content" source="media\troubleshoot-bitlocker-policies\reagentc-output.png" alt-text="Output of the ReAgentC.exe command in Command Prompt.":::

If the WinRE status is disabled, run the **reagentc /enable** command as an administrator to enable it manually:

:::image type="content" source="media\troubleshoot-bitlocker-policies\reagentc-enable.png" alt-text="Example screenshot to enable ReAgentC.exe in Command Prompt. Run the command reagentc /enable":::

## Summary

When BitLocker fails to enable on a Windows 10 device using an Intune policy, in most cases, the hardware or software prerequisites are not in place. Examining the BitLocker-API log will help you identify which prerequisite is not satisfied. The most common issues are:

- TPM is not present
- WinRE is not enabled
- UEFI BIOS is not enabled for TPM 2.0 devices

Policy misconfiguration can also cause encryption failures. Not all Windows devices can encrypt silently so think about the users and devices that you're targeting.

Configuring a startup key or PIN for a policy intended for silent encryption will not work because of the user interaction required when enabling BitLocker. Keep this in mind when configuring the BitLocker policy in Intune.

Verify whether the policy settings have been picked up by the device to determine whether the targeting has been successful.

It is possible to identify the policy settings using MDM diagnostics, registry keys, and the device management enterprise event log to verify if settings were successfully applied. The BitLocker CSP documentation can help you decipher these settings to understand whether they match what has been configured in the policy.
