---
title: Troubleshooting BitLocker from the Microsoft Endpoint Manager admin center
description: Describes how to 
ms.author: v-dsindona
author: dsindona88
ms.reviewer: saurkosh
ms.date: 11/29/2021
--- 
# Troubleshooting BitLocker from the Microsoft Endpoint Manager admin center

REVISIT AFTER This article can help Intune administrators understand...

we’ll look at troubleshooting encryption settings for BitLocker using the Microsoft Intune Encryption report.

The encryption report is a useful starting point for troubleshooting encryption failures.  In some cases, you will need to investigate the device further to understand the reasons for failure.

To take full advantage of this troubleshooting method and the error details available in the encryption report, you will need to configure a BitLocker policy. If you are currently using a device configuration policy, consider migrating the policy. To perform either task, navigate to the Microsoft Endpoint Manager admin center and select Endpoint security > Disk encryption.

## BitLocker encryption methods

By default, the BitLocker setup wizard prompts users to enable encryption. You can also configure a BitLocker policy that silently enables BitLocker on a device.

> [!NOTE]
> Automatic encryption is not the same thing as silent encryption. Automatic encryption is performed during Out-Of-Box Experience (OOBE) mode on modern standby or on Hardware Security Test Interface (HSTI)-compliant devices. In silent encryption, Intune suppresses the user interaction through BitLocker configuration service provider (CSP) settings. Each method has different prerequisites.

### Prerequisites for BitLocker silent encryption

A Trusted Platform Module (TPM) chip (version 1.2 or 2.0) that must be unlocked.
Windows Recovery Environment (WinRE) must be enabled.
The hard disk must be partitioned into an operating system drive formatted with NTFS and a system drive of at least 350 MB must be formatted as FAT32 for Unified Extensible Firmware Interface (UEFI) and NTFS for BIOS.
UEFI BIOS is required for TPM version 2.0 devices. (Secure boot is not required but will provide more security.)
The Intune enrolled device is connected to Microsoft Azure hybrid services or Azure Active Directory (Azure AD).
 
### Prerequisites for user-enabled encryption

The hard disk must be partitioned into an operating system drive formatted with NTFS and a system drive of at least 350 MB formatted as FAT32 for UEFI and NTFS for BIOS.
Intune enrolled device through hybrid Azure AD join, Azure AD registration, or Azure AD join.

> [!NOTE]
> A TPM chip is not required but is highly recommended for increased security.

## Identifying device status

Intune provides a built-in encryption report that presents details about the encryption status of devices across all managed devices. It is a very useful tool that provides an overview of the encryption status. You can use the report to identify and isolate BitLocker encryption failures, the TPM status, and encryption status of Windows devices.

### Troubleshooting encryption failures

BitLocker encryption failures on Intune enrolled Windows 10 devices can fall into one of the following categories:

- The device hardware or software does not meet the prerequisites for enabling BitLocker.
- The Intune BitLocker policy is misconfigured, causing Group Policy Object (GPO) conflicts.
- The device is already encrypted, and the encryption method doesn’t match policy settings.

To identify the category a failed device encryption falls into, sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431) and select **Devices** > **Monitor** > **Encryption report**.

The report will show a list of enrolled devices. You will be able to answer questions about their encryption status such as:

- Is the device encrypted?
- Does it have a TPM chip?
- Is the device ready for encryption?

IMAGE Encryption report example

> [!NOTE]
> If a Windows 10 device displays a Not ready status, it might still support encryption. For a Ready status, the Windows 10 device must have TPM activated. TPM devices aren't required to support encryption but are highly recommended for increased security.

The above example shows that a device with TPM version 1.2 has been successfully encrypted. Additionally, you can see two devices not ready for encryption and will not be able to be encrypted silently and that one TPM 2.0 device is ready for encryption but not encrypted.

## Common failure scenarios

Next, let’s look at a few common failure scenarios. Each scenario details the encryption report status.

### Scenario 1 – Device is not ready for encryption and not encrypted

When you click on a device that is not encrypted, Intune displays a summary of its status. In the example below, there are multiple profiles targeting the device: an endpoint protection policy, a Mac operating system policy (which is not applicable to this device), and a Microsoft Defender Advanced Threat Protection (ATP) baseline.

IMAGE Scenario 1 - Device is not ready for encryption and not encrypted

**Encryption status explained:**

The messages under Status details are codes returned by the BitLocker CSP’s status node from the device. The encryption status is in an error state because the OS volume is not encrypted. Additionally, the BitLocker policy has requirements for a TPM that are not satisfied by the device.

The messages mean that the device is not encrypted because it doesn’t have a TPM present and the policy requires one.

### Scenario 2 – Device is ready but not encrypted

This example shows that the TPM 2.0 device is not encrypted.

IMAGE Scenario 2 – Device is ready but not encrypted.

**Encryption status explained:**

This device has a BitLocker policy that is configured for user interaction rather than silent encryption. The user has not started or completed the encryption process (the user receives a notification message), so the drive remains unencrypted.

### Scenario 3 – Device is not ready and will not encrypt silently

If an encryption policy is configured to suppress user interaction and encrypt silently and the encryption report Encryption readiness state is Not applicable or Not ready, it is likely the TPM is not ready for BitLocker.

IMAGE Scenario 3 – Device is not ready and will not encrypt silently.

Clicking on the device reveals the following reason:

IMAGE Scenario 3 - Device encryption status

**Encryption status explained:**

If the TPM is not ready on the device, it could be because it is disabled in the firmware or needs to be cleared or reset. Running the TPM management console (TPM.msc) from the command line on the affected device will help you understand and resolve the TPM state.

### Scenario 4 – The device is ready but not encrypted

There are several reasons that a device targeted with silent encryption is ready and not encrypted.

IMAGE Scenario 4 – The device is ready but not encrypted.

**Encryption status explained:**

One explanation is that WinRE is not enabled on the device, which is a prerequisite. You can validate the status of WinRE on the device using the reagentc.exe/info command as an administrator: 

IMAGE Command Prompt output of reagentc.exe/info

If WinRE is disabled, run the reagentc.exe/info command as administrator.

IMAGE Enabling WinRE in Command Prompt

The **Status details** page will display the following information if WinRE is not configured correctly:

The user logged into the device does not have admin rights. 

Another reason could be administrative rights. If your BitLocker policy is targeting a user who does not have administrative rights and Allow standard users to enable encryption during Autopilot is set to not configured, you will see the following in the encryption status:

IMAGE Device encryption status - User that does not have admin rights.

**Encryption status explained:**

Switching Allow standard users to enable encryption during Autopilot to Yes will resolve this issue for Azure AD joined devices.

### Scenario 5 – The device is in an error state but encrypted

In this common scenario, if the Intune policy is configured for XTS-AES 128-bit encryption and the device it is targeting is encrypted is using XTS-AES 256-bit encryption (or the reverse), you will receive the error shown below.

IMAGE Scenario 5 – The device is in an error state but encrypted.

**Encryption status explained:**

This happens when a device that has already been encrypted using another method—either manually by the user, with Microsoft BitLocker Administration and Monitoring (MBAM), or by the Microsoft Endpoint Configuration Manager before enrollment.

To rectify this, decrypt the device manually or by using Windows PowerShell. Then let the Intune BitLocker encrypt the device again the next time the policy reaches it.

### Scenario 6 – The device is encrypted but the profile state is in error

Occasionally a device appears encrypted but has an error state in the summary.

IMAGE Scenario 6 – The device is encrypted but the profile state is in error.

**Encryption status explained:**

This usually occurs when the device has been encrypted by another means (possibly manually). The settings match the current policy, but Intune has not initiated the encryption.

 

More info and feedback
For further resources on this subject, please see the links below.

Encrypt Windows 10 devices with BitLocker in Intune

Intune endpoint security disk encryption policy settings

Microsoft Defender for Endpoint

BitLocker cannot encrypt a drive known TPM issues

Troubleshooting tips for BitLocker policies in Microsoft Intune