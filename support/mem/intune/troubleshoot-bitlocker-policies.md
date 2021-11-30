---
title: Troubleshooting BitLocker policies from the client side
description: Describes how to 
ms.author: v-dsindona
author: dsindona88
ms.reviewer: saurkosh
ms.date: 11/29/2021
--- 
# Troubleshooting BitLocker policies from the client side

REVISIT AFTER This article provides guidance on how to troubleshoot problems with BitLocker settings on devices you manage with Intune. 

....discusses common issues when using BitLocker with Intune, and gives steps to help troubleshoot BitLocker encryption on the client side.

For guidance on how to troubleshoot encryption failures in the Microsoft Endpoint Manager admin center, see [Troubleshooting BitLocker with the Intune encryption report](troubleshoot-bitlocker-admin-center).

## BitLocker encryption process
The following steps describe the flow of events that should result in a successful encryption of a Windows 10 device that has not been previously encrypted with BitLocker.

1. An administrator configures a BitLocker policy configured through Endpoint security > Disk encryption with the desired settings and targets a user group or device group.
1. The policy is saved to a tenant in the Intune service.
1. A Windows 10 Mobile Device Management (MDM) client syncs with the Intune service and processes the BitLocker policy settings.
1. The BitLocker MDM policy Refresh scheduled task runs on the device that replicates the BitLocker policy settings to full volume encryption (FVE) registry key.
1. BitLocker encryption is initiated on the drives.

The encryption report identifies common troubleshooting scenarios that are documented in the BitLocker configuration service provider (CSP) status node. However, some status scenarios might not be reported and you will need access to the device to investigate further. 

There is already extensive documentation available for troubleshooting BitLocker encryption policies. You can check out Intune troubleshooting tips or follow guidelines from a Windows perspective to help isolate issues when enabling BitLocker using Intune.

## Gathering data from Windows 10 devices

If you determine that there is no actionable information in the encryption report to understand why BitLocker was not enabled, the next step is to access an affected device and gather the required data to complete the investigation.

If a device is accessible, you can initiate a sync with the Intune service manually from your Windows device by selecting Settings > Accounts> Access work or school > Connect <tenant> Azure AD > Info before collecting the data.

## Event logs

### Mobile device management (MDM) agent event log

The MDM event log is useful to determine if there’s been an issue processing the policy sent from Intune. The OMA DM agent will connect to the Intune service and attempt to process the policies targeted at the user or device. Success and failures processing Intune policies will be found in this log.

Once the sync is complete, collect or review the following information:

LOG > DeviceManagement-Enterprise-Diagnostics-Provider admin  

Location: Right-click on Start Menu > Event Viewer > Applications and Service Logs > Microsoft > Windows > Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider > Admin
File system location: C:\Windows\System32\winevt\Logs\Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider%4Admin.evtx

To filter this log, right-click the event log and select Filter Current Log > Critical/Error/Warning. Then search through the filtered logs for BitLocker (press F3 and enter the text).

Errors in BitLocker settings will follow the format of the BitLocker CSP, so you will see entries like this:

./Device/Vendor/MSFT/BitLocker/RequireDeviceEncryption 

or

./Vendor/MSFT/BitLocker/ConfigureRecoveryPasswordRotation

> [!NOTE]
> You can also enable debug logging for this event log using the Event Viewer for troubleshooting.

### BitLocker-API management event log

This is the main event log for BitLocker. If the policy has been processed by the MDM agent and there are no errors in the DeviceManagement-Enterprise-Diagnostics-Provider admin event log, this is the next log to investigate.

LOG > BitLocker-API management

Location: Right-click on Start Menu > Event Viewer > Applications and Service Logs > Microsoft > Windows > BitLocker-API
File system location: C:\Windows\System32\winevt\Logs\Microsoft-Windows-BitLocker%4BitLocker Management.evtx

Usually, errors are logged here if there are hardware or software prerequisites missing that the policy requires such as Trusted Platform Module (TPM) or Windows Recovery Environment (WinRE).  As you can see in the following example, conflicting policy settings that cannot be implemented during silent encryption and manifest as group policy conflicts are also logged:

Failed to enable Silent Encryption. 

Error: BitLocker Encryption cannot be applied to this drive because of conflicting Group Policy settings. When write access to drives not protected by BitLocker is denied, the use of a USB startup key cannot be required. Please have your system administrator resolve these policy conflicts before attempting to enable BitLocker.

Resolution: Configuring the compatible TPM startup PIN to Blocked will resolve conflicting Group Policy settings when using silent encryption.

Configuring the TPM startup PIN and startup key to Allowed and other startup key and PIN setting to Blocked for user interaction and will result in a conflicting Group Policy error in BitLocker-AP event log.

Also, if you configure TPM startup PIN or startup key to require user interaction, it will cause silent encryption to fail. You must set the PIN and TPM startup key to Blocked if silent encryption is required.

Configuring any of the compatible TPM settings to Required will cause silent encryption to fail.

IMAGE Microsoft Endpoint Manager - BitLocker | OS Drive Settings

### TPM not available

Another common errorin the BitLocker-API log is that the TPM is not available. The following example shows that TPM is a requirement for silent encryption:

Failed to enable Silent Encryption. TPM is not available 

Error: A compatible Trusted Platform Module (TPM) Security Device cannot be found on this computer.

Resolution: Ensure there is a TPM available on the device and if it is present check the status via TPM.msc or the PowerShell cmdlet get-tpm.

### Un-Allowed DMA capable bus

If the BitLocker-API log displays the status: Un-Allowed DMA capable bus/device(s) detected, it means that Windows has detected an attached Direct memory access (DMA)-capable device that might expose a DMA threat.

Resolution: To remediate this issue, first verify that the device has no external DMA ports with the original equipment manufacturer (OEM). Then follow these steps to add the device to the allowed list. Note: Only add a DMA device to the allowed list if it is an internal DMA interface/bus.

### System event log

If you’re having hardware-related issues—such as problems with the TPM—errors will appear in the system event log for TPM from the TPMProvisioningService or TPM-WMI source.

LOG > System event

Location: Right-click on Start Menu > Event Viewer > Windows Logs > System
File system location: C:\Windows\System32\winevt\Logs\System.evtx

IMAGE Filtering properties for the System event log

Resolution: Filter on these event sources to help identify any hardware-related issues that the device may be experiencing with the TPM and check with the OEM manufacturer whether there are any firmware updates available.

### Task scheduler operational event log

The task scheduler operational event log is useful for troubleshooting scenarios where the policy has been received from Intune, but BitLocker encryption has not successfully initiated. BitLocker MDM policy refresh is a scheduled task that should run successfully when the MDM agent syncs with the Intune service.

The log is worth investigating when:

The BitLocker policy appears in the DeviceManagement-Enterprise-Diagnostics-Provider admin event log, in MDM diagnostics, and the registry.  

There are no errors (i.e., the policy has been picked up successfully from Intune).  

Nothing is logged in the BitLocker-API event log to show that encryption was even attempted.

LOG > Task scheduler operational event

Location: Event Viewer > Applications and Service Logs > Microsoft > Windows > TaskScheduler 
File system location: C:\Windows\System32\winevt\Logs\Microsoft-Windows-TaskScheduler%4Operational.evtx

> [!IMPORTANT]
> You must manually enable this event log before logging anything because the log will identify any problems running the BitLocker MDM policy Refresh scheduled task.

To enable this log, Right-click on Start Menu > Event Viewer> Applications and Services > Microsoft > Windows > TaskScheduler > Operational.

IMAGE Screenshot of the TaskScheduler - Operational Logs

Then enter task scheduler in the Windows search box, select Task Scheduler > Microsoft > Windows > BitLocker. Right-click on BitLocker MDM policy Refresh and choose Run.

When the run is complete, inspect the Last Run Result column for any error codes and examine the task schedule event log for errors.

IMAGE Example screenshot of BitLocker tasks in Task Scheduler

In the example above, 0x0 has run successfully. The error 0x41303 this means the task has never previously run.

> [!NOTE]
> Check out this article for more information about Task Scheduler error messages.

## Checking BitLocker settings

### MDM Diagnostics Report

You can create a report of MDM logs to diagnose enrollment or device management issues in Windows 10 devices managed by Intune. The MDM Diagnostic Report contains useful information about an Intune enrolled device and the policies deployed to it.

Location: YouTube video: How to create an Intune MDM diagnostic report on Windows devices. This video describe...

File system location: C:\Users\Public\Documents\MDMDiagnostics

The operating system (OS) build and edition in encryption failures: It’s important to investigate the OS build and edition because some CSPs were introduced on specific versions of Windows and will only work on a certain edition. For example, the bulk of BitLocker CSP settings were introduced in Windows 10, version 1703 but these settings weren’t supported on Windows 10 Pro until Windows 10, version 1809.

Additionally, there are settings such as AllowStandardUserEncryption (added in version 1809), ConfigureRecoveryPasswordRotation (added in version 1909), RotateRecoveryPasswords (added in version 1909), and Status (added in version 1903).

Checking if your Windows version and edition supports the settings configured in your policy is the first step in understanding why they are not applying correctly.

Investigating with the EntDMID: This is a unique device ID for Intune enrollment. You can use the EntDMID to search through the All Devices view in the Microsoft Endpoint Manager admin center to identify a specific device. It is also a crucial piece of information for Microsoft support to enable further troubleshooting on the service side if a support case is required.

You can also use the MDM Diagnostic Report to identify whether a policy has been successfully sent to the device with the settings the administrator configured. By using the BitLocker CSP as a reference, you can decipher which settings have been picked up when syncing with the Intune service. This article discusses this topic in more detail. You can use the report to determine if the policy is targeting the device and identify what settings have been configured using the BitLocker CSP documentation.

### MSINFO32

MSINFO32 is an information tool that contains device data you can use to determine if a device satisfies BitLocker prerequisites. The required prerequisites will depend on BitLocker policy settings and the required outcome. For example, silent encryption for TPM 2.0 requires a TPM and Unified Extensible Firmware Interface (UEFI).

Location: In the Search box, enter msinfo32, right-click System Information in the search results and select Run as administrator.
File system location: C:\Windows\System32\Msinfo32.exe.

However, if this item doesn’t meet the prerequisites, it doesn’t necessarily mean that you can’t encrypt the device using an Intune policy.

If you have configured the BitLocker policy to encrypt silently and the device is using TPM 2.0, it is important to verify that BIOS mode is UEFI. If the TPM is 1.2, then having the BIOS mode in UEFI is not a requirement. 
Secure boot, DMA protection, and PCR7 configuration are not required for silent encryption but might be highlighted in Device Encryption Support. This is to ensure support for automatic encryption. 
BitLocker policies that are configured to not require a TPM and have user interaction rather than encrypt silently will also not have prerequisites to check in MSINFO32.

### TPM.MSC file

TPM.msc is a Microsoft Management Console (MMC) Snap-in file. You can use TPM.msc to determine whether your device has a TPM, to identity the version, and whether it is ready for use.

Location: In the Search box enter, tpm.msc, right-click and select Run as administrator.
File system location: MMC Snap-in C:\Windows\System32\mmc.exe.

As we discussed in previous blogs, having a TPM is not a prerequisite for BitLocker but is highly recommended due to the increased security it provides.

Having a TPM is required for silent and automatic encryption. If you’re trying to encrypt silently with Intune and there are TPM errors in the BitLocker-API and system event logs, TPM.msc will help you understand the problem.

The following example shows a healthy TPM 2.0 status. Note the specification version 2.0 in the bottom right and that the status is ready for use.

IMAGE Example screenshot of a healthy TPM 2.0 status in the Trusted Platform Module console

This example shows an unhealthy status when the TPM is disabled in the BIOS:

IMAGE Example screenshot of an unhealthy TPM 2.0 status in the Trusted Platform Module console

Configuring a policy to require a TPM and expecting BitLocker to encrypt when the TPM is missing or unhealthy is one of the most common issues.

### Get-Tpm cmdlet

A cmdlet is a lightweight command in the Windows PowerShell environment. In addition to running TPM.msc, you can verify the TPM using the Get-Tpm cmdlet. You will need to run this cmdlet with administrator rights.

Location: In the Search box enter cmd, right-click and select Run as administrator > PowerShell > get-tpm.

IMAGE Example screenshot of a present and active TPM in a PowerShell window

In the example above, you can see that the TPM is present and active in the PowerShell window. The values equal True. If the values were set to False, it would indicate a problem with the TPM. BitLocker will not be able to use the TPM until it is present, ready, enabled, activated, and owned.

### Manage-bde command-line tool

Manage-bde is a BitLocker encryption command line tool included in Windows. It’s designed to help with administration after BitLocker is enabled.

Location: In the Search box, enter cmd, right-click and select Run as administrator > enter manage-bde -status.
File system location: C:\Windows\System32\manage-bde.exe.

IMAGE Example screenshot of the manage-bde.exe command in a Command Prompt window

You can use manage-bde to discover the following information about a device:

Is it encrypted? If reporting in the Microsoft Endpoint Manager admin center indicates a device is not encrypted, this command line tool can identify the encryption status.
Which encryption method has been used? You can compare information from the tool to the encryption method in the policy to make sure they match. For example, if the Intune policy is configured to XTS-AES 256-bit and the device is encrypted using XTS-AES 128-bit, this will result in errors in Microsoft Endpoint Manager admin center policy reporting.
What specific protectors are being used? There are several combination of protectors. Knowing which protector is used on a device will help you understand if the policy has been applied correctly.

In the following example, the device is not encrypted:

IMAGE Example screenshot of a device not encrypted with BitLocker

## BitLocker registry locations

This is the first place in the registry to look when you want to decipher the policy settings picked up by Intune.

Location: Right click on Start > RUN > enter regedit to open the Registry Editor.  
Default file system location:
Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\BitLocker

The MDM agent registry key will help you identify the Globally Unique Identifier (GUID) in the PolicyManager that contains the actual BitLocker policy settings.

IMAGE BitLocker registry location in the Registry Editor

The GUID is highlighted in the above example. You can include the GUID (it will be different for each tenant) in the following registry subkey to troubleshoot BitLocker policy settings:

Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\Providers\<GUID>\default\Device\BitLocker

IMAGE Screenshot of the Registry Editor displaying the BitLocker policy settings configured by the MDM agent

This report shows the BitLocker policy settings that have been picked up by the MDM agent (OMADM client). These are the same settings that you will see in the MDM Diagnostic report, so this is an alternative way of identifying settings that the client has picked up.

Example of EncryptionMethodByDriveType registry key:

<enabled/><data id="EncryptionMethodWithXtsOsDropDown_Name" value="6"/><data id="EncryptionMethodWithXtsFdvDropDown_Name" value="6"/><data id="EncryptionMethodWithXtsRdvDropDown_Name" value="3"/>

SystemDrivesRecoveryOptions:

<enabled/><data id="OSAllowDRA_Name" value="true"/><data id="OSRecoveryPasswordUsageDropDown_Name" value="2"/><data id="OSRecoveryKeyUsageDropDown_Name" value="2"/><data id="OSHideRecoveryPage_Name" value="false"/><data id="OSActiveDirectoryBackup_Name" value="true"/><data id="OSActiveDirectoryBackupDropDown_Name" value="1"/><data id="OSRequireActiveDirectoryBackup_Name" value="true"/> 

## BitLocker registry key

The settings in the policy provider registry key will be duplicated into the main BitLocker registry key. You can compare the settings to ensure they match what appears in the policy settings in the user interface (UI), MDM log, MDM diagnostics and the policy registry key.

This is an example of the FVE registry key: 

Registry key location: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE

IMAGE Screenshot of the BitLocker registry keys found in the Registry Editor

EncryptionMethodWithXtsOs, EncryptionMethodWithXtsFdv and EncryptionMethodWithXtsRdv have the following possible values:
3 = AES-CBC 128
4 = AES-CBC 256
6 = XTS-AES 128
7 = XTS-AES 256
UseTPM, UseTPMKey, UseTPMKeyPIN, USeTPMPIN are all set to 2,which means they are all set to allow.
Notice that most of the keys are divided into groups of settings for the operating system drive (OS), fixed drive (FDV) and removable drive (FDVR).
OSActiveDirectoryBackup has a value of 1 and is enabled.
OSHideRecoveryPage is equal to 0 and not enabled.

You can decode all of the setting names in the registry using the BitLocker CSP documentation.

### REAgentC.exe command line tool

REAgentC.exe is a command line executable tool that you can use to configure the Windows Recovery Environment (Windows RE). WinRE is a prerequisite for enabling BitLocker in certain scenarios such as silent or automatic encryption.

Location: Right-click on Start > Run > enter cmd > right-click cmd and select Run as administrator > reagnetc /info.

File system location: C:\Windows\System32\ReAgentC.exe.

> [!TIP]
> If you see error messages in the BitLocker-API about WinRe not being enabled, run the following command on the device to determine the WinRE status:

IMAGE Output of the ReAgentC.exe command in Command Prompt

If the WinRE status is disabled, it is possible to enable it manually using the following command line as an administrator:

IMAGE Example screenshot to enable ReAgentC.exe in Command Prompt

## Conclusion
When BitLocker fails to enable on a Windows 10 device using an Intune policy, in most cases, the hardware or software prerequisites are not in place. Examining the BitLocker-API log will help you identify which prerequisite is not satisfied. The most common issues are:

TPM is not present
WinRE is not enabled
UEFI BIOS is not enabled for TPM 2.0 devices
Policy misconfiguration can also cause encryption failures. Not all Windows devices can encrypt silently so think about the users and devices that you’re targeting.

Configuring a startup key or PIN for a policy intended for silent encryption will not work because of the user interaction required when enabling BitLocker. Keep this in mind when configuring the BitLocker policy in Intune.

It is useful to be able to verify whether the policy settings have been picked up by the device to determine whether the targeting has been successful.

It is possible to identify the policy settings using MDM diagnostics, registry keys and the device management enterprise event log to verify if the settings have been successfully applied. The BitLocker CSP documentation can help you decipher these settings to understand whether they match what has been configured in the policy.

There are multiple places to configure BitLocker settings in the Microsoft Endpoint Manager admin center – Security baselines, Endpoint security, and Configuration profiles. It’s not a good idea to have conflicting policies. The preferred and recommended approach is to use Endpoint security > Disk encryption.

Reference
Here’s an overview of the logs, diagnostic checks, and command-line tools discussed in this post:

Logs

DeviceManagement-Enterprise-Diagnostics-Provider admin event log: Use this log for MDM policy processing and errors applying the CSP settings. 
BitLocker-API and system event log: Investigate this log if the policy has been processed successfully and Windows is now attempting to implement the settings. 
Task scheduler operational event log: Check this log if the policy has been processed in DeviceManagement-Enterprise but nothing has happened in BitLocker-API. 
Collect diagnostics remote action: Use Intune to collect logs remotely without interrupting the user.

BitLocker settings checks

MDM Diagnostics report: Use this report to verify if BitLocker settings have been applied and what they are configuring.
Registry keys: Use to verify if the policy received from MDM provider has applied to Windows correctly.

Command line/Powershell tools

Get-Tpm cmdlet: Check the TPM status of the device.
Tpm.msc: Check the TPM status of the device.
REAgentc.exe: Check WinRE status of the device.
MSINFO32.exe: Check the hardware prerequisites for BitLocker.
Manage-bde.exe: Check the BitLocker encryption status of the device.