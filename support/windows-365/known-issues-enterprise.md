---
title: Windows 365 Enterprise and Frontline Known issues
description: Learn about known issues for Windows 365 Enterprise and Frontline.
manager: dcscontentpm
ms.date: 11/17/2025
ms.topic: troubleshooting
ms.reviewer: msft-jasonparker, stulimat, scottduf
ms.custom:
- pcy:WinComm User Experience
- sap:Onboarding issues
ms.collection:
- M365-identity-device-management
- tier2
---

# Windows 365 Enterprise and Frontline known issues

The following items are known issues for Windows 365 Enterprise and Frontline.

## First-time Cloud PC sign-in triggers an impossible travel location alert

When you use Conditional Access, a user who signs in to a Cloud PC for the first time might trigger an impossible travel location alert.

### Solution

[Follow these steps to investigate risk](/entra/id-protection/howto-identity-protection-investigate-risk) and verify that the activity matches the expected behavior of the user, based on their physical location and the location of the Cloud PC.

## Watermarking support in Windows 365

Watermarking support is configured on session hosts and enforced by the Remote Desktop client. You can configure Watermarking support by configuring a Group Policy Object (GPO) or the Intune Settings Catalog. The default for the QR code embedded content setting doesn't allow administrators to look up device information from leaked images for Cloud PCs.  

### Solution

Check the GPO or the Intune Settings Catalog for the Intune Configuration profile that you used to configure Watermarking support. Make sure that the QR code embedded content setting is configured to **Device ID**.

For more information, see [Administrative template for Azure Virtual Desktop](/azure/virtual-desktop/administrative-template?tabs=intune#configure-the-administrative-template).

[!INCLUDE [Missing Start menu and taskbar when using iPad and the Remote Desktop app to access a Cloud PC](includes/known-issues.md)]

## In-place Windows upgrade might change the computer name

Upgrading an existing Cloud PC between release versions of Windows 10 to Windows 11 might cause the computer name to change to a name that has a prefix of "pps." The Intune device name remains unchanged.

### Solution

Find and manage the Cloud PC in Microsoft Intune by using the unchanged Intune device name, either through the **Devices** > **All devices** list or the **Devices** > **Windows 365** > **All Cloud PCs** list.

## Windows 365 provisioning fails<!--38483005-->

Windows 365 provisioning might fail if both of the following conditions are met:

- The Desired State Configuration (DSC) extension isn't signed.
- The PowerShell Execution policy is set to **AllSigned** in the GPO.

### Solution

1. Check if the Azure network connection (ANC) fails with the error "An internal error occurred. The virtual machine deployment timed out." If yes, review the related GPO.
1. Check if the PowerShell Execution policy is set to **AllSigned**. If it is, either remove the GPO or reset the PowerShell Execution policy to **Unrestricted**.
1. Retry the ANC health check. If the check succeeds, retry provisioning.

## Cloud PC reports as not compliant with the compliance policy

The following device compliance settings report as **Not applicable** when being evaluated for a Cloud PC:

- **Trusted Platform Module (TPM)**
- **Require encryption of data storage on device**

The following device compliance settings might report as **Not Compliant** when being evaluated for a Cloud PC:

- **Require BitLocker**
- **Require Secure Boot to be enabled on the device**. Cloud PC support for the [Secure boot](/windows-hardware/design/device-experiences/oem-secure-boot) functionality is now available to all customers.

### Solution

To enable secure boot on the Cloud PC, reprovision the specific Cloud PC. for more information, see see [Reprovision a Cloud PC](/windows-365/enterprise/reprovision-cloud-pc)

To remove the "not compliant" settings:

1. [Create a filter for all Cloud PCs](/windows-365/enterprise/create-filter#create-a-filter-for-all-cloud-pcs).
1. For any existing device compliance policies that both evaluate to a Cloud PC and contain either of the **Not Compliant** settings, use this new filter to exclude Cloud PCs from the policy assignment.
1. Create a new device compliance policy without either of the **Not Compliant** settings and use this new filter to include Cloud PCs for the policy assignment.

## Single sign-on users see a dialog to allow remote desktop connection during the connection attempt <!--42499792-->

When you enable single sign-on, users see a prompt to authenticate to Microsoft Entra ID and allow the Remote Desktop connection when launching a connection to a new Cloud PC. Microsoft Entra remembers up to 15 devices for 30 days before prompting again. To connect, users select **Yes** in this dialog.

To prevent this dialog from appearing, you can create a preconsented device group. To get started, follow the instructions to [configure a target device group](/azure/virtual-desktop/configure-single-sign-on#configure-the-target-device-groups).

<a name='single-sign-on-user-connections-are-being-denied-through-azure-ad-conditional-access---42317382--'></a>

## Single sign-on user connections are being denied through Microsoft Entra Conditional Access <!--42317382-->

### Possible cause

To sign in by using single sign-on, the Remote Desktop client requests an access token to the Microsoft Remote Desktop app from Microsoft Entra. In issue in this request process might cause the failed connection.

### Troubleshooting steps

Follow the steps in [troubleshoot sign-in problems](/azure/active-directory/conditional-access/troubleshoot-conditional-access).

## When a Cloud PC locks, it immediately disconnects single sign-on users

When single sign-on isn't used, users can see the Cloud PC lock screen and enter credentials to unlock their Windows session. However, when single sign-on is used, the Cloud PC fully disconnects the session to enable the following capabilities:

- Users can use passwordless authentication to unlock their Cloud PC.
- Conditional Access policies and multifactor authentication can be enforced when unlocking the Cloud PC.

<a name='single-sign-on-users-arent-asked-to-reauthenticate-to-azure-ad-when-connecting-from-an-unmanaged-device---35593334--'></a>

## When single sign-on users connect from an unmanaged device, they aren't asked to reauthenticate to Microsoft Entra ID <!--35593334-->

When you use single sign-on, all authentication behavior (including supported credential types and sign-in frequency) is driven through Microsoft Entra ID.

### Solution

To enforce periodic reauthentication through Microsoft Entra ID, create a Conditional Access policy using the [sign-in frequency control](/windows-365/enterprise/set-conditional-access-policies#configure-sign-in-frequency).

## I don't see the Cloud PC reports on the Devices > Overview page in the Intune admin center

If you turn on the **Use Devices preview** setting in the Intune admin center, the **Cloud PC performance (preview)** tab, **Cloud PCs with connection quality issues** report, and **Cloud PCs with low utilization** report aren't on the **Overview** page.

### Solution

In the upper-right corner of the **Devices** > **Overview** page, turn off **Use Devices preview**.

## Cloud PC is stuck in a restart loop after a restore or resize action

### Possible cause

This issue might occur for Cloud PCs provisioned before July 2022 that use either of the following mechanisms:

- Microsoft Attack Surface Reduction rules (for example, [Manage attack surface reduction settings with endpoint security policies in Microsoft Intune](/mem/intune/protect/endpoint-security-asr-policy)), or
- Third-party solutions that block the install language script execution during the post-provisioning process.  

Cloud PCs provisioned after July 2022 don't encounter this issue.

### Troubleshooting steps

Determine the root cause:

1. Search the Windows Event log. If the system shows the following reboot event (1074), continue to step 2.

   ```output
   The process C:\WINDOWS\system32\wbem\wmiprvse.exe (<CPC Name>) has initiated the restart of computer <CPC Name> on behalf of user NT AUTHORITY\SYSTEM for the following reason: Application: Maintenance (Planned)
   Reason Code: 0x80040001
   Shutdown Type: restart
   Comment: DSC is restarting the computer.
   ```

1. In an administrative Windows PowerShell Command Prompt window, run `Get-DscConfigurationStatus`. If the result shows that a restart is pending for a job, continue to step 3.
1. At the administrative command prompt, run `Get-DscConfiguration`. If the results show the DSC that installs the language, continue to the "Solution" section.

### Solution

To stop the restart loop, try either of these options:

- Remove the Azure Site Recovery policies or switch the policies to Audit mode, and then apply the new policies to the Cloud PC.
- In an elevated command window, run the following command to reboot the job:

  ```powershell
  `Remove-DSCConfiguration -Stage Pending,Current,Previous -Verbose`
  ```

## Cloud PC connection issues for GCC High government customers<!--47633105-->

Some GCC High government customers, whose resources are deployed to the `microsoft.us` environments, might encounter issues connecting to their Cloud PC when they use web clients or the Safari browser.

### Possible cause

The issue occurs when the web client or the Safari browser blocks third-party cookies. Third-party cookies are cookies set by a domain other than the one you're visiting.  

For GCC High customers whose resources are deployed to `microsoft.us` environments, the web client or Safari browser uses the Cloud PC's domain name, which is different from `microsoft.us`, to determine the first-party domain. As a result, the web client or the Safari browser considers the `microsoft.us` cookies to be third-party cookies. If the web client or Safari browser blocks third-party cookies, it can't store the `microsoft.us` cookies or use them for authentication and authorization.

As a result, the affected customers can't connect to their Cloud PC sessions.

### Solution

Allow third-party cookies from `microsoft.us` in your Web client settings, Safari browser settings, or Group Policy.

This change lets the web client or Safari browser store and use the `microsoft.us` cookies to connect to your Cloud PC session.  

## Windows 365 authentication issues that occur in government environments when clients use Windows App on macOS

- Government customers (GCC, GCC High) who use Windows 365 on macOS might encounter authentication failures when they use the Windows App to add a work or school account.
- Web browser access to Windows 365 remains unaffected.
- The Windows App on macOS doesn't properly detect the GCC High Windows 365 environment during discovery.
- Required workspace URL (`https://rdweb.wvd.azure.us/api/arm/feeddiscovery`) isn't automatically identified during authentication.

### Possible Cause

This behavior is by design. To add a device, government customers have to select **Add workspace** instead of **Work or School Account**.

### Solution

1. Instead of selecting **Add Account**, select **Add Workspace**.
1. Manually enter the following URL: `https://rdweb.wvd.azure.us/api/arm/feeddiscovery`.

The Windows 365 devices should now be discovered and added.

## Windows Security reports "Memory Integrity is off. Your device may be vulnerable." <!--48643259-->

Windows Security reports "Memory Integrity is off. Your device may be vulnerable."

In the Cloud PC's Windows Systems Information, you might also see that the Virtualization-based security (VBS) row shows **Enabled but not running**.

This issue can occur when nested virtualization is turned on. Nested virtualization requires a running nested hypervisor, which inhibits Direct Memory Access (DMA) protections. DMA protections are required when running VBS.

### Solution

1. For each Cloud PC, turn off nested virtualization.
1. Policies that enforce VBS also enforce DMA protection.

Another option is to not require DMA for VBS because they're incompatible with each other.

## Microsoft Teams isn't enforcing screen capture protection<!-- 49423094 -->

When screen capture protection is enabled, Microsoft Teams on Windows 365 Cloud PCs doesn't enforce screen capture protection.

### Troubleshooting steps

- Confirm that the WebRTC version is up-to-date.
- Confirm that the screen capture protection policy is configured correctly to protect both the client and server:

  1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Devices** > **Configuration**, and then select the policy.
  1. Under **Configuration settings**, select **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Azure Virtual Desktop**, and then configure the following settings:
     - **Enable screen capture protection** = **Enable**
     - **Screen Capture Protection Options** = **Block screen capture on client and server**

## Windows 365 scope tags and nested groups

Windows 365 doesn't support nested security groups. If you apply a scope tag to the top of a nested security group, Cloud PCs in inner nested groups aren't assigned scope tags.

### Solution

Apply the scope tag individually to each group in the nested security group.

## Windows 365 doesn't support editing scope tags for individual Cloud PCs

The Windows 365 user interface and Graph API don't support the editing of scope tags for individual Cloud PCs.

### Solution

To sync the scope tag associations to the Windows 365 service, edit scope tags for individual Cloud PCs on Intune's **All Devices** blade.

## Can't edit scope tags for custom images

Top-level administrators can't add or edit scope tags that are applied to custom images.

### Solution

When a scoped admin creates a custom image, the custom image is tagged with the same scope tags that are associated with the scoped admin.  

For example, if a scoped admin who's associated with the "Scope Tag A" scope tag creates a custom image, the created custom image is automatically tagged by using "Scope Tag A."  

## WebRTC Redirector Service is missing from the latest Windows 365 Cloud PC gallery images

The May 21, 2024 updates for Cloud PC gallery images lack the WebRTC Redirector Service. Without this component, Teams media redirection doesn't work.

This applies to the following gallery images:

- Windows 11 23H2 with Microsoft 365 apps
- Windows 11 22H2 with Microsoft 365 apps

### Troubleshooting steps

For newly provisioned Cloud PCs, verify that WebRTC is available. If it's not, you can use either of the following options:

- To add the WebRTC Redirector Service app to the list of apps to install by default onto Cloud PCs, follow the steps in [Add Microsoft 365 Apps to Windows 10/11 devices with Microsoft Intune](/mem/intune/apps/apps-add-office365).

- To add the WebRTC Redirector Service app to an individual Cloud PC, follow the steps in [Install the Remote Desktop WebRTC Redirector Service](/azure/virtual-desktop/teams-on-avd#install-the-remote-desktop-webrtc-redirector-service). To get the most up-to-date installer, see [https://aka.ms/msrdcwebrtcsvc/msi](https://aka.ms/msrdcwebrtcsvc/msi).

## Windows 365 Frontline issues

The following items are known issues for Windows 365 Frontline.

### Users can't access Frontline Cloud PCs that are in shared mode

When Frontline Cloud PCs in shared mode are assigned to a Microsoft Entra ID group that has more than 10,000 members, some users might not receive access and don't see the Cloud PC cards in the Windows app client.

#### Solution

Reduce the Microsoft Entra ID group membership to fewer than 10,000 users.

### Can't decrease the Cloud PC count when all Cloud PCs fail provisioning

If a Windows Autopilot Device Preparation Profile (DPP) failure causes Cloud PC provisioning to fail, and all Cloud PCs show no successfully provisioned devices, administrators can't decrease the number of Cloud PCs in the assignment configuration.

#### Solution

Perform a reprovisioning action in the provisioning policy:

1. Go to **Microsoft Intune admin center** > **Devices** > **Windows 365**.
1. Select **Provisioning policies**.
1. Select the affected provisioning policy.
1. To reset the deployment state, elect **Reprovision**.
1. After the reprovisioning process completes, you can adjust the Cloud PC count as needed.

### Scheduled reprovisioning doesn't recover after license changes

When Frontline Cloud PCs are provisioned in shared mode, and licenses expire or are removed from the tenant, the Cloud PCs are deprovisioned. After you add back valid licenses, Cloud PCs provision according to the policy configurations. However, both scheduled reprovisioning and manual reprovisioning functionality remain disabled.

#### Solution

To restore full reprovisioning functionality after you restore expired licenses:

1. **Remove the provisioning policy assignment:**
   1. Go to the affected provisioning policy.
   1. Go to the **Assignments** tab, and the remove all group assignments.


1. **Re-add the assignment:**
   1. Wait 5-10 minutes for the removal to process.
   1. Add the group assignments back to the policy.
   1. Verify that the reprovisioning options are now available.

### Can't decrease Cloud PC count due to pooled user storage limits

You can't reduce the number of Cloud PCs for Frontline Cloud PCs in shared mode if the operation would cause the amount of pooled user storage to exceed its limit.

#### Solution

1. To determine a new pooled user storage limit, multiply the number of Cloud PCs that you want by the size of the operating system disks (in GB) that you want to use.
1. Delete individual user storage to comply with new limit.

### Autopilot Device Preparation (DPP) initially shows as failed if timeout limit is reached

After you create the provisioning policy, you receive the `DevicePreparationProfileTimeout` error code. This means that the Cloud PC provisioning process reached the initial DPP timeout but hasn't successfully applied Autopilot Device Preparation.

#### Solution

Wait for the process to continue. Autopilot Device Preparation continues to install in the background after the initial timeout period.

### Windows Autopilot Device Preparation deployment status doesn't immediately show Cloud PC serial numbers

Immediately after provisioning, the status information for the Autopilot Device Preparation profile doesn't include the Cloud PC serial numbers.

#### Solution

Wait for the process to continue. Cloud PC serial numbers can take up to 30 minutes to appear in the status information.

## Next steps

[Troubleshoot Windows 365 Enterprise Cloud PC](/windows-365/enterprise/troubleshooting)
