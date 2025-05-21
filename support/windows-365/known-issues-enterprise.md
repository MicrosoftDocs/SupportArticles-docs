---
title: Known issues for Windows 365 Enterprise and Frontline
description: Learn about known issues for Windows 365 Enterprise.
manager: dcscontentpm
ms.date: 05/21/2025
ms.topic: troubleshooting
ms.reviewer: ivivano, erikje, scottduf
ms.custom: get-started
ms.collection:
- M365-identity-device-management
- tier2
---
# Known issues: Windows 365 Enterprise and Frontline

The following items are known issues for Windows 365 Enterprise.

## First-time Cloud PC sign-in triggers Impossible Travel Location alert

When you use Conditional Access, a user who signs in to a Cloud PC for the first time might trigger an impossible travel location alert.

### Solution

[Follow these steps to investigate risk](/entra/id-protection/howto-identity-protection-investigate-risk) and verify that the activity matches the expected behavior of the user, based on their physical location and the location of the Cloud PC.

## Watermarking support in Windows 365

Watermarking support is configured on session hosts and enforced by the Remote Desktop client. The settings for Watermarking support can be configured via Group Policy (GPO) or the Intune Settings Catalog. The default for the QR code embedded content setting doesn't allow administrators to look up device information from leaked images for Cloud PCs.  

### Solution

Ensure that the QR code embedded content setting is configured to **Device ID** either in the GPO or the Intune Settings Catalog for the Intune Configuration profile used to configure Watermarking support.

For more information, see [Administrative template for Azure Virtual Desktop](/azure/virtual-desktop/administrative-template?tabs=intune#configure-the-administrative-template).

[!INCLUDE [Missing Start menu and taskbar when using iPad and the Remote Desktop app to access a Cloud PC](includes/known-issues.md)]

## In-place Windows upgrade might change the computer name

Upgrading an existing Cloud PC between release versions of Windows 10 to Windows 11 might cause the computer name to be changed to a name with a prefix of "pps" while leaving the Intune device name unchanged.

### Solution

Find and manage the Cloud PC in Microsoft Intune by using the unchanged Intune device name, either through the **Devices** > **All devices** list or the **Devices** > **Windows 365** > **All Cloud PCs** list.

## Windows 365 provisioning fails<!--38483005-->

Windows 365 provisioning failures might occur if both of the following conditions are met:

- The Desired State Configuration (DSC) extension isn't signed.
- The PowerShell Execution policy is set to **AllSigned** in the GPO.

### Solution

1. Check if the Azure network connection (ANC) fails with the error "An internal error occurred. The virtual machine deployment timed out." If yes, review the related GPO.
2. Check if the PowerShell Execution policy is set to **AllSigned**. If it is, either remove the GPO or reset the PowerShell Execution policy to **Unrestricted**.
3. Retry the ANC health check. If the check succeeds, retry provisioning.

## Cloud PC reports as not compliant with compliance policy

The following device compliance settings report as **Not applicable** when being evaluated for a Cloud PC:

- **Trusted Platform Module (TPM)**
- **Require encryption of data storage on device**

The following device compliance settings might report as **Not Compliant** when being evaluated for a Cloud PC:

- **Require BitLocker**
- **Require Secure Boot to be enabled on the device**. Cloud PC support for the [Secure boot](/windows-hardware/design/device-experiences/oem-secure-boot) functionality is now available to all customers.

### Solution

To enable secure boot on the Cloud PC, see [Reprovision](/windows-365/enterprise/reprovision-cloud-pc) the specific Cloud PC.

To remove not compliant settings:

1. [Create a filter for all Cloud PCs](/windows-365/enterprise/create-filter#create-a-filter-for-all-cloud-pcs).
2. For any existing device compliance policies that both evaluate to a Cloud PC and contain either of the **Not Compliant** settings, use this new filter to exclude Cloud PCs from the policy assignment.
3. Create a new device compliance policy without either of the **Not Compliant** settings and use this new filter to include Cloud PCs for the policy assignment.

## Single sign-on users see a dialog to allow remote desktop connection during the connection attempt <!--42499792-->

When you enable single sign-on, a prompt appears to authenticate to Microsoft Entra ID and allow the Remote Desktop connection when launching a connection to a new Cloud PC. Microsoft Entra remembers up to 15 devices for 30 days before prompting again. If you see this dialog, select **Yes** to connect.

To prevent this dialog from appearing, you can create a preconsented device group. Follow the instructions to [configure a target device group](/azure/virtual-desktop/configure-single-sign-on#configure-the-target-device-groups) to get started.

<a name='single-sign-on-user-connections-are-being-denied-through-azure-ad-conditional-access---42317382--'></a>

## Single sign-on user connections are being denied through Microsoft Entra Conditional Access <!--42317382-->

### Possible cause

To sign in through single sign-on, the remote desktop client requests an access token to the **Microsoft Remote Desktop** app in Microsoft Entra, which might be the cause of the failed connection.

### Troubleshooting steps

Follow the steps in [troubleshoot sign-in problems](/azure/active-directory/conditional-access/troubleshoot-conditional-access).

## Single sign-on users are immediately disconnected when the Cloud PC locks

When single sign-on isn't used, users can see the Cloud PC lock screen and enter credentials to unlock their Windows session. However, when single sign-on is used, the Cloud PC fully disconnects the session so that:

- Users can use passwordless authentication to unlock their Cloud PC.
- Conditional Access policies and multifactor authentication can be enforced when unlocking the Cloud PC.

<a name='single-sign-on-users-arent-asked-to-reauthenticate-to-azure-ad-when-connecting-from-an-unmanaged-device---35593334--'></a>

## Single sign-on users aren't asked to reauthenticate to Microsoft Entra ID when connecting from an unmanaged device <!--35593334-->

When you use single sign-on, all authentication behavior (including supported credential types and sign-in frequency) is driven through Microsoft Entra ID.

### Solution

To enforce periodic reauthentication through Microsoft Entra ID, create a Conditional Access policy using the [sign-in frequency control](/windows-365/enterprise/set-conditional-access-policies#configure-sign-in-frequency).

## I don't see the Cloud PC reports on the Devices > Overview page in the Intune admin center

If you turn on the **Use Devices preview** setting in the Intune admin center, the **Cloud PC performance (preview)** tab, **Cloud PCs with connection quality issues** report, and **Cloud PCs with low utilization** report aren't on the **Overview** page.

### Solution

Turn off the **Use Devices preview** toggle in the upper-right corner of the **Devices** > **Overview** page.

## Cloud PC is stuck in a restart loop after a restore or resize action

### Possible cause

This issue might occur for Cloud PCs provisioned before July 2022 that use either:

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

2. Run `Get-DscConfigurationStatus` in an elevated command window. If the result shows a reboot pending for a job, continue to step 3.
3. Run `Get-DscConfiguration` in an elevated command window. If the results show the DSC that installs the language, continue to the next section.

### Solution

To stop the restart loop, try either of these options:

- Remove the Azure Site Recovery policies or switch the policies to Audit mode, and then apply the new policies to the Cloud PC.
- In an elevated command window, run the following command to reboot the job:

    `Remove-DSCConfiguration -Stage Pending,Current,Previous -Verbose`

## Cloud PC connection issues for GCC High government customers<!--47633105-->

Some GCC High government customers whose resources are deployed to `microsoft.us` environments might encounter issues connecting to their Cloud PC using web clients or the Safari browser.

### Possible cause

The issue occurs when the web client or the Safari browser blocks third-party cookies. Third-party cookies are cookies set by a domain other than the one you're visiting.  

For GCC High customers with resources deployed to `microsoft.us` environments, the `microsoft.us` cookies are considered third-party cookies by the web client or the Safari browser. This consideration is because the web client or Safari browser uses the Cloud PC's domain name, which is different from `microsoft.us`, to determine the first-party domain. If the web client or Safari browser blocks third-party cookies, it prevents the `microsoft.us` cookies from:

- Being stored.
- Used for authentication and authorization.

As a result, you can't connect to your Cloud PC session.

### Solution

Allow third-party cookies from `microsoft.us` in your Web client settings, Safari browser settings, or Group Policy.

This change lets the web client or Safari browser store and use the `microsoft.us` cookies to connect to your Cloud PC session.  

## Windows Security reports "Memory Integrity is off. Your device may be vulnerable." <!--48643259-->

Windows Security reports "Memory Integrity is off. Your device may be vulnerable."

In the Cloud PC's Windows Systems Information, you might also see that the Virtualization-based security (VBS) row shows **Enabled but not running**.

This issue can be caused when nested virtualization is turned on. When nested virtualization is turned on, it requires a running nested hypervisor, which inhibits Direct Memory Access (DMA) protections. DMA protections are required when running VBS.

### Solution

Make sure that:

- Nested virtualization was turned off for the Cloud PC.
- Policies have VBS enabled with DMA protection.

Another option is to not require DMA for VBS because they're incompatible with each other.

## Microsoft Teams isn't enforcing screen capture protection<!-- 49423094 -->

When screen capture protection is enabled, Microsoft Teams on Windows 365 Cloud PCs isn't enforcing screen capture protection.

### Troubleshooting steps

- Confirm that the WebRTC version is up-to-date.
- Confirm that the screen capture protection policy is configured correctly to have the client and server selected:

  1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Devices** > **Configuration**, and then choose the policy.
  2. Under  **Configuration settings**, select **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Azure Virtual Desktop**, and then make sure the following is set:
      - **Enable screen capture protection** = **Enable**
      - **Screen Capture Protection Options** = **Block screen capture on client and server**

## Windows 365 scope tags and nested groups

Windows 365 doesn't support nested security groups. If you apply a scope tag to the top of a nested security group, Cloud PCs in inner nested groups aren't assigned scope tags.

### Solution

Apply the scope tag individually to each group in the nested security group.

## Windows 365 doesn't support editing scope tags for individual Cloud PCs

The Windows 365 user interface and Graph API don't support the editing of scope tags for individual Cloud PCs.

### Solution

Edit scope tags for individual Cloud PCs on Intune's **All Devices** blade to sync the scope tag associations to the Windows 365 service.

## Scope tags for custom images can't be edited

Scope tags applied to custom images can't be edited or directly added by top-level admins.

### Solution

When scoped admins create custom images, those custom images are tagged with the same scope tags that are associated with the scoped admin.  

For example, if an admin scoped with the scope tag "Scope Tag A" creates a custom image, the created custom image is automatically tagged with "Scope Tag A."  

## WebRTC Redirector Service is missing from the latest Windows 365 Cloud PC gallery images

The May 21, 2024 updates for Cloud PC gallery images lack the WebRTC Redirector Service. Without this component, Teams media redirection doesn't work.

This applies to the following gallery images:

- Windows 11 23H2 with Microsoft 365 apps
- Windows 11 22H2 with Microsoft 365 apps

### Troubleshooting steps

For newly provisioned Cloud PCs, verify that WebRTC is available. If it's not, you can use either of the following options:

- To add the WebRTC Redirector Service app to the list of apps to install by default onto Cloud PCs, follow the steps in [Add Microsoft 365 Apps to Windows 10/11 devices with Microsoft Intune](/mem/intune/apps/apps-add-office365).

- To add the WebRTC Redirector Service app to an individual Cloud PC, follow the steps in [Install the Remote Desktop WebRTC Redirector Service](/azure/virtual-desktop/teams-on-avd#install-the-remote-desktop-webrtc-redirector-service). To get the most up-to-date installer, use this link: [https://aka.ms/msrdcwebrtcsvc/msi]( https://aka.ms/msrdcwebrtcsvc/msi).

## Windows 365 Frontline issues

The following are issues for Windows 365 Frontline:

### Users may not be able to access Frontline Cloud PCs in shared mode

When Frontline Cloud PCs in shared mode are assigned to an Entra ID Group with more than 10,000 members, some users might not receive access and might not see the Cloud PC cards in the Windows app.

#### Solution

Reduce the Entra ID group membership to be fewer than 10,000 users.

### Number of cloud PCs for Frontline Cloud PCs in shared mode cannot be decreased when all Cloud PC provisioning fails

If provisioning fails due to an Autopilot Device Preparation Profile (DPP) (Preview) failure and results in all Cloud PCs showing no successfully provisioned devices, admins will not be able to decrease the number of Cloud PCs in the reprovision assignments option.

#### Solution

Perform reprovision in the provisioning policy.

### Scheduled reprovisioning doesn't recover if Frontline licenses are removed or expire from a tenant and then are added back

If Frontline Cloud PCs are provisioned in shared mode and then licenses expire or are removed from the tenant, the Cloud PCs will be deprovisioned until valid licenses are added. After the licenses are added back, the Cloud PCs will be provisioned according to the configurations defined in the provisioning policy. If you have configured a scheduled reprovision for a provisioning policy, the scheduled reprovision won't be reactivated. Manual reprovision action will also fail.

#### Solution

To recover full functionality of manual and scheduled reprovision after license expiration, remove and then re-add the provisioning policy assignment.

## Next steps

[Troubleshoot Windows 365 Enterprise Cloud PC](/windows-365/enterprise/troubleshooting)
