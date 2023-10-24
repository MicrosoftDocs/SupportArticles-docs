---
title: Troubleshoot Windows activation error codes
description: Provides troubleshooting information to help you respond to error messages that you may receive when you try to use a Multiple Activation Key (MAK) or the Key Management Service (KMS) to perform Volume Activation on one or more Windows-based computers.
ms.date: 10/20/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:activation, csstroubleshoot
ms.technology: windows-server-deployment
---
# Troubleshoot Windows activation error codes

This article provides troubleshooting information to help you respond to error messages that you may receive when you try to use a Multiple Activation Key (MAK) or the Key Management Service (KMS) to perform Volume Activation on one or more Windows-based computers.

> [!NOTE]
> This article is intended for technical support agents and IT professionals. If you're looking for more information about Windows activation error messages, see [Get help with Windows activation errors](https://support.microsoft.com/help/10738/windows-10-get-help-with-activation-errors).

Look for the error code in the following tables, then select the link to see more information about that error code and how to resolve it.

For more information about volume activation, see [Plan for volume activation](/windows/deployment/volume-activation/plan-for-volume-activation-client).

For more information about volume activation for current and recent versions of Windows, see [Volume Activation [client]](/windows/deployment/volume-activation/volume-activation-windows-10).

For more information about volume activation for older versions of Windows, see [Volume Activation information for Windows Vista, Windows Server 2008, Windows Server 2008 R2 and Windows 7](/windows/deployment/volume-activation/volume-activation-windows-10).

You can also try [our Virtual Agent](https://vsa.services.microsoft.com/v1.0/?partnerId=7d74cf73-5217-4008-833f-87a1a278f2cb&flowId=DMC&initialQuery=winact), which can help you quickly identify and troubleshoot issues related to KMS and MAK activation.

## Diagnostic tool

> [!NOTE]
> This tool is intended to resolve Windows activation issues on computers that run Enterprise, Professional, or Server editions of Windows.

Microsoft Support and Recovery Assistant (SaRA) simplifies Windows KMS Activation troubleshooting.

> [!div class="nextstepaction"]
> [Download the Assistant](https://aka.ms/SaRA-WindowsActivation)

The SaRA tool troubleshoots by attempting to start up Windows. If Windows returns an activation error code, the tool then displays targeted solutions for the following known error codes:

- 0xC004F038
- 0xC004F039
- 0xC004F041
- 0xC004F074
- 0xC004C008
- 0x8007007b
- 0xC004C003
- 0x8007232B

## Summary of error codes

The following table lists known error codes for Windows Activation, and includes links to relevant sections later in this article that can help you resolve related issues.

|Error code |Error message |Activation type|
|-----------|--------------|----------------|
|[0x8004FE21](#0x8004fe21-this-computer-isnt-running-genuine-windows) |This computer is not running genuine Windows.  |MAK<br />KMS client |
|[0x80070005](#0x80070005-access-denied) |Access denied. The requested action requires elevated privileges. |MAK<br />KMS client<br />KMS host |
|[0x8007007b](#0x8007007b-dns-name-doesnt-exist) |0x8007007b DNS name does not exist. |KMS client |
|[0x80070490](#0x80070490-the-product-key-didnt-work) |The product key you entered did not work. Check the product key and try again, or enter a different one. |MAK |
|[0x800706BA](#0x800706ba-the-rpc-server-is-unavailable) |The RPC server is unavailable. |KMS client |
|[0x8007232A](#0x8007232a-dns-server-failure) |DNS server failure.  |KMS host  |
|[0x8007232B](#0x8007232b-dns-name-doesnt-exist) |DNS name does not exist. |KMS client |
|[0x8007251D](#0x8007251d-no-records-found-for-dns-query) |No records found for DNS query. |KMS client |
|[0x80092328](#0x80092328-dns-name-doesnt-exist) |DNS name does not exist.  |KMS client |
|[0xC004B100](#0xc004b100-the-activation-server-determined-that-the-computer-couldnt-be-activated) |The activation server determined that the computer could not be activated. |MAK |
|[0xC004C001](#0xc004c001-the-activation-server-determined-the-specified-product-key-is-invalid) |The activation server determined the specified product key is invalid. |MAK|
|[0xC004C003](#0xc004c003-the-activation-server-determined-the-specified-product-key-is-blocked) |The activation server determined the specified product key is blocked. |MAK |
|[0xC004C008](#0xc004c008-the-activation-server-determined-that-the-specified-product-key-couldnt-be-used) |The activation server determined that the specified product key could not be used. |KMS |
|[0xC004C020](#0xc004c020-the-activation-server-reported-that-the-multiple-activation-key-has-exceeded-its-limit) |The activation server reported that the Multiple Activation Key has exceeded its limit. |MAK |
|[0xC004C021](#0xc004c021-multiple-activation-key-extension-limit-exceeded) |The activation server reported that the Multiple Activation Key extension limit has been exceeded. |MAK |
|[0xC004F009](#0xc004f009-the-software-protection-service-reported-that-the-grace-period-expired) |The Software Protection Service reported that the grace period expired. |MAK |
|[0xC004F00F](#0xc004f00f-hardware-id-binding-is-beyond-level-of-tolerance) |The Software Licensing Server reported that the hardware ID binding is beyond level of tolerance. |MAK<br />KMS client<br />KMS host |
|[0xC004F014](#0xc004f014-the-software-protection-service-reported-that-the-product-key-isnt-available) |The Software Protection Service reported that the product key is not available. |MAK<br />KMS client |
|[0xC004F02C](#0xc004f02c-the-format-for-the-offline-activation-data-is-incorrect) |The Software Protection Service reported that the format for the offline activation data is incorrect. |MAK<br />KMS client |
|[0xC004F035](#0xc004f035-invalid-volume-license-key) |The Software Protection Service reported that the computer could not be activated with a Volume license product key. |KMS client<br />KMS host |
|[0xC004F038](#0xc004f038-the-count-reported-by-your-key-management-service-kms-is-insufficient) |The Software Protection Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator. |KMS client |
|[0xC004F039](#0xc004f039-the-key-management-service-kms-isnt-enabled) |The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) is not enabled. |KMS client |
|[0xC004F041](#0xc004f041-the-software-protection-service-determined-that-the-key-management-server-kms-isnt-activated) |The Software Protection Service determined that the Key Management Server (KMS) is not activated. KMS needs to be activated.  |KMS client |
|[0xC004F042](#0xc004f042-the-specified-key-management-service-kms-cant-be-used) |The Software Protection Service determined that the specified Key Management Service (KMS) cannot be used. |KMS client |
|[0xC004F050](#0xc004f050-the-software-protection-service-reported-that-the-product-key-is-invalid) |The Software Protection Service reported that the product key is invalid. |MAK<br />KMS<br />KMS client |
|[0xC004F051](#0xc004f051-the-software-protection-service-reported-that-the-product-key-is-blocked) |The Software Protection Service reported that the product key is blocked. |MAK<br />KMS |
|[0xC004F064](#0xc004f064-the-software-protection-service-reported-that-the-non-genuine-grace-period-expired) |The Software Protection Service reported that the non-genuine grace period expired. |MAK |
|[0xC004F065](#0xc004f065-the-application-is-running-within-the-valid-non-genuine-period) |The Software Protection Service reported that the application is running within the valid non-genuine period. |MAK<br />KMS client |
|[0xC004F06C](#0xc004f06c-the-request-timestamp-is-invalid) |The Software Protection Service reported that the computer could not be activated. The Key Management Service (KMS) determined that the request timestamp is invalid.  |KMS client |
|[0xC004F074](#0xc004f074-no-key-management-service-kms-could-be-contacted) |The Software Protection Service reported that the computer could not be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information.  |KMS client |

To resolve the errors, see the following causes of each error message and troubleshooting steps.

### 0x8004FE21 This computer isn't running genuine Windows

When you receive this error, you see this error message:

> This computer is not running genuine Windows.

**Causes:**

This issue can occur for several reasons:

- A user or program installed language packs (MUI) on computers running editions of Windows not licensed for extra language packs.

  > [!NOTE]
  > This issue doesn't necessarily indicate tampering. Some applications can install multilingual support even when that edition of Windows isn't licensed for those language packs.

- When malware modifies Windows in order to install more features.
- Certain system files are corrupted.

**Solution:**

To resolve this issue, you must reinstall the operating system.

### 0x80070005 Access denied

The full text of this error message is:

> Access denied. The requested action requires elevated privileges.

**Cause:**

User Account Control (UAC) prohibits activation processes from running in a non-elevated command prompt window.

**Solution:**

1. Open the Start menu and search for **Command Prompt**.
2. Right-click **Command Prompt**, and select **Run as administrator**.
3. In the command prompt, run `slmgr.vbs`.

### 0x8007007b DNS name doesn't exist

When you encounter this error, you see this error message:

> DNS name does not exist.

**Cause:**

This issue can occur if the KMS client can't find the KMS SRV resource records in DNS.

**Solution:**

For more information about troubleshooting such DNS-related issues, see [Common troubleshooting procedures for KMS and DNS issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns).

### 0x80070490 The product key didn't work

When you encounter this issue, you see this error message:

> The product key that you entered didn't work. Check the product key and try again, or enter a different one.

**Causes:**

There are two possible reasons why you may encounter this issue:

- The Multiple Activation Key (MAK) wasn't valid.
- A known issue in Windows Server 2019 interfered with authenticating the product key.

**Solution:**

To work around this issue and activate the computer:

1. Open the Start menu and search for **Command Prompt**.
2. Right-click **Command Prompt**, and select **Run as administrator**.
3. In the command prompt, run the following command:

   ```console
   slmgr -ipk <5x5 key>
   ```

### 0x800706BA The RPC server is unavailable

When you encounter this error, you see this error message:

> The RPC server is unavailable.

**Cause:**

You can encounter this issue because of the following things:

- The KMS host doesn't have configured firewall settings.
- DNS SRV records are stale.

**Solution 1:**

On the KMS host, make sure you've enabled the firewall exception for the Key Management Service on TCP port 1688.

**Solution 2:**

Check your DNS SRV records and make sure they point to a valid KMS host.

**Solution 3:**

If you still see this error after performing solutions 1 and 2, check your network connections to make sure you can access the server.

You can also follow the instructions in [Common troubleshooting procedures for KMS and DNS issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns).

### 0x8007232A DNS server failure

When you encounter this issue,  you see this error message:

> DNS server failure.

**Cause:**

You can encounter this issue when the system has network or DNS issues.

**Solution:**

To resolve this issue, troubleshoot your network connections and DNS by following the instructions in [Common troubleshooting procedures for KMS and DNS issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns).

### 0x8007232B DNS name doesn't exist

When you encounter this error, you see this error message:

> DNS name does not exist.

**Cause:**

This error message appears when the KMS client can't find KMS server resource records (SRV RRs) in DNS.

**Solution 1:**

Make sure you've installed a KMS and the DNS publishing is enabled (default). If the DNS isn't available, point the KMS client to the KMS host by opening an elevated command prompt and running the following command:

```console
slmgr.vbs /skms <kms_host_name>
```

**Solution 2:**

If you don't have a KMS host, get and install an MAK, then try activating the system again.

If these solutions don't resolve the issue, see the instructions in [Common troubleshooting procedures for KMS and DNS issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns).

### 0x8007251D No records found for DNS query

When you encounter this error, you see this error message:

> No records found for DNS query.

**Cause:**

This error message appears when the KMS client can't find the KMS SRV records in the DNS.

**Solution:**

To resolve this issue, follow the instructions in [Common troubleshooting procedures for KMS and DNS issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns) to troubleshoot your network connections and DNS.

### 0x80092328 DNS name doesn't exist

When you encounter this error, you see this error message:

> DNS name does not exist.

**Cause:**

You can encounter this issue if the KMS client can't find the KMS SRV resource records in DNS.

**Solution:**

To resolve this issue, follow the instructions in [Common troubleshooting procedures for KMS and DNS issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns) to troubleshoot your network connections and DNS.

### 0xC004B100 The activation server determined that the computer couldn't be activated

When you encounter this error, you see this error message:

> The activation server determined that the computer could not be activated.

**Cause:**

You can encounter this issue when Microsoft doesn't support the MAK you're using.

**Solution:**

To troubleshoot this issue, verify that the MAK you're using is the same MAK that Microsoft provided to you. To verify that the MAK is valid, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004C001 The activation server determined the specified product key is invalid

When you encounter this error, you see this error message:

> The activation server determined the specified product key is invalid.

**Cause:**

You can encounter this issue when the MAK you enter isn't valid.

**Solution:**

You can try reentering the MAK to make sure you entered the correct information. Otherwise, verify the MAK you're using is valid by contacting the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004C003 The activation server determined the specified product key is blocked

When you encounter this error, you see this error message:

> The activation server determined the specified product key is blocked.

**Cause:**

You can encounter this issue if the MAK is blocked on the activation server.

**Solution:**

Contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers) to obtain a new MAK. After you obtain the new MAK, try installing and activating Windows again.

### 0xC004C008 The activation server determined that the specified product key couldn't be used

When you encounter this error, you see this error message:

> The activation server determined that the specified product key could not be used.

**Cause:**

This error message appears when the KMS key has exceeded its activation limit. You can only activate KMS host keys up to 10 times on no more than six different computers.

**Solution:**

Contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers) to request more activations for activation server permission.

### 0xC004C020 The activation server reported that the Multiple Activation Key has exceeded its limit

When you encounter this error, you see this error message:

> The activation server reported that the Multiple Activation Key has exceeded its limit.

**Cause:**

This error message appears when the MAK exceeds its activation limit. By design, you can only activate a MAK a limited number of times.

**Solution:**

Request more activations to increase limit. If you require more activations, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004C021 Multiple Activation Key extension limit exceeded

When you encounter this error, you see this error message:

> The activation server reported that teh Multiple Activation Key extension limit has been exceeded.

**Cause:**

This error message appears when the MAK exceeds its activation limit. By design, you can only activate a MAK a limited number of times.

**Solution:**

Request more activations to increase extension limit. If you need more activations, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004F009 The Software Protection Service reported that the grace period expired

When you encounter this error, you see this error message:

> The Software Protection Service reported that the grace period expired.

**Cause:**

This error message appears when the grace period expires before you activate the system. The system is currently in the Notifications state.

**Solution:**

For assistance, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers).

### 0xC004F00F hardware ID binding is beyond level of tolerance

When you encounter this error, you see this error message:

> The Software Licensing Server reported that the Hardware ID binding is beyond level of tolerance.

**Cause:**

This error message appears when the system hardware changes or its drivers update.

**Solution 1:**

If you're using MAK activation, reactivate the system phone by using either online or phone activation during the Out of Tolerance (OOT) grace period.

**Solution 2:**

If you're using KMS activation, try one of the following things:

- Restart Windows.
- Open an elevated command prompt and run the following command:
  
   ```console
   slmgr.vbs /ato
   ```

### 0xC004F014 The Software Protection Service reported that the product key isn't available

When you encounter this error, you see this error message:

> The Software Protection Service reported that the product key is not available.

**Cause:**

This issue happens when no product keys are installed on the system.

**Solution:**

If you're using MAK activation, install a MAK product key.

If you're using KMS activation:

1. Check the *Pid.txt* file located on the installation media in the *\\sources* folder for a KMS Setup key.
2. Install the key.

### 0xC004F02C the format for the offline activation data is incorrect

When you encounter this error, you see this error message:

> The Software Protection Service reported that the format for the offline activation data is incorrect.

**Cause:**

This error message appears when the system detects the data entered during phone activation isn't valid.

**Solution:**

To resolve this issue, make sure you entered the caller ID (CID) correctly.

### 0xC004F035 Invalid Volume License Key

When you encounter this error, you see this error message:

> Error: Invalid Volume License Key. In order to activate, you need to change your product key to a valid Multiple Activation Key (MAK) or Retail key. You must have a qualifying operating system license AND a Volume license Windows 7 upgrade license, or a full license for Windows 7 from a retail source. ANY OTHER INSTALLATION OF THIS SOFTWARE IS IN VIOLATION OF YOUR AGREEMENT AND APPLICABLE COPYRIGHT LAW.

This error message indicates that the computer doesn't have a Windows marker in its BIOS that identifies it as an OEM system running a qualifying edition of Windows. In short, this message means the Volume License Key is invalid. This information is required for KMS client activation.

**Cause:**

Microsoft only licenses Windows 7 Volume editions for upgrade. Microsoft doesn't support installing a Volume operating system on a computer that doesn't already have a qualifying operating system installed.

**Solution:**

Activate your Volume License Key by using the following steps:

1. Change your product key to a valid Multiple Activation Key (MAK) or Retail key. To change your key, you must have both a qualifying operating system license and a Volume license Windows 7 upgrade license, or a full license for Windows 7 from a retail source.
2. Try to activate your key again.

If you see error message 0x80072ee2 when you attempt to activate your key again, you need to activate your key by phone.

To activate your key by phone:

1. Open a command prompt and run `slmgr /dti`, then record the value of the Installation ID.
2. Contact the [Microsoft Licensing Activation Center](https://www.microsoft.com/Licensing/existing-customer/activation-centers) and provide the Installation ID in order to receive a Confirmation ID.
3. To activate by using the Confirmation ID, run `slmgr /atp <Confirmation ID>`.

### 0xC004F038 The count reported by your Key Management Service (KMS) is insufficient

When you encounter this issue, you see this error message:

> The Software Protection Service reported that the computer couldn't be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator.

**Cause:**

You normally encounter this issue when the count on the KMS host isn't high enough. For Windows Server, the KMS count must be greater than or equal to five. For Windows (client), the KMS count must be greater than or equal to 25.

**Solution:**

Add computers to the KMS pool. Before you can use KMS to activate Windows, you must have more computers in the KMS pool. To obtain the current count on the KMS host, run `Slmgr.vbs /dli`.

### 0xC004F039 The Key Management Service (KMS) isn't enabled

When you encounter this issue, you see this error message:

> The Software Protection Service reported that the computer couldn't be activated. The Key Management Service (KMS) isn't enabled.

**Cause:**

This issue occurs when KMS doesn't respond to a KMS request.

**Solution:**

To resolve this issue, troubleshoot the network connection between the KMS host and the client. Make sure that a firewall isn't blocking or otherwise filtering TCP port 1688 (default).

### 0xC004F041 The Software Protection Service determined that the Key Management Server (KMS) isn't activated

When you encounter this issue, you see this error message:

> The Software Protection Service determined that the Key Management Server (KMS) isn't activated. KMS needs to be activated.

**Cause:**

This issue occurs when the KMS host hasn't been activated.

**Solution:**

To resolve this issue, activate the KMS host by using either [online or telephone activation](/windows/deployment/volume-activation/activate-using-key-management-service-vamt#configure-kms-in-windows-10).

### 0xC004F042 the specified Key Management Service (KMS) can't be used

When you encounter this error, you see this error message:

> The Software Protection Service determined that teh specified Key Management Service cannot be read.

**Cause:**

You may encounter this issue when the KMS client tried to contact a KMS host that couldn't activate the client software. This scenario is common in mixed environments with application-specific and operating system-specific KMS hosts.

**Solution:**

To resolve this issue, make sure your KMS clients are connection to the correct hosts, especially if you're using specific KMS hosts to activate specific applications or OSes.

### 0xC004F050 The Software Protection Service reported that the product key is invalid

When you encounter this error, you see this error message:

> The Software Protection Service reported that the product key is invalid.

**Cause:**

You can encounter an issue if there was a typo or if you try to use a Beta key on a generally available version of the operating system.

**Solution:**

To resolve this issue, make sure you're installing the correct KMS key on the corresponding version of Windows. Make sure you've entered the correct characters and numbers. If you're copying and pasting the key, make sure the Clipboard didn't replace the hyphens with em-dashes.

### 0xC004F051 The Software Protection Service reported that the product key is blocked

When you encounter this error, you see this error message:

> The Software Protection Service reported that the product key is blocked.

**Cause:**

This error message appears when Microsoft blocks the product key.

**Solution:**

To resolve this issue, get a new MAK or KMS key, install it on the system, then try activating again.

### 0xC004F064 The Software Protection Service reported that the non-genuine grace period expired

When you encounter this error, you see this error message:

> The Software Protection Service reported that teh non-genuine grace period expired.

**Cause:**

This error occurs when Windows Activation Tools (WAT) determines that a system that's trying to be activated isn't authentic.

**Solution:**

To resolve this issue, contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers) for assistance.

### 0xC004F065 the application is running within the valid non-genuine period

When you encounter this error, you see this error message:

> The Software Protection Service reported that the application is running within the valid non-genuine period.

**Cause:**

You may encounter this error message because WAT has determined the system trying to activate isn't genuine. However, because of the Non-Genuine Grace Period, the system continues to run.

**Solution:**

To resolve this issue, you must get and install a genuine product key, then activate the system before the grace period ends. If you don't, the system goes into the Notification state at the end of the grace period.

### 0xC004F06C The request timestamp is invalid

When you encounter this issue, you see this error message:

> The Software Protection Service reported that the computer couldn't be activated. The Key Management Service (KMS) determined that the request timestamp is invalid.

**Cause:**

You can encounter this issue if the system time on the client computer is too different from the time on the KMS host. Time synchronization is important to system and network security, so desynchronization can cause issues to occur.

**Solution:**

To resolve this issue, you need to change the system time on the client to match the KMS host. We recommend you use a Network Time Protocol (NTP) time source or Active Directory Domain Services for time synchronization. This issue uses UTP time, so time zone selection doesn't affect it.

### 0xC004F074 No Key Management Service (KMS) could be contacted

When you encounter this issue, you see this error message:

> The Software Protection Service reported that the computer couldn't be activated. No Key Management Service (KMS) could be contacted. Please see the Application Event Log for additional information.

**Cause:**

This issue occurs when all the KMS host systems your client tires to contact return errors.

**Solution:**

To resolve this issue:

1. Open the **Application Event Log**.
2. Identify each event associated with the activation attempt that has an Event ID of 12288.
3. Troubleshoot each of these errors by following the instructions in [Common troubleshooting procedures for KMS and DNS issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns).
