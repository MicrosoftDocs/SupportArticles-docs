---
title: Troubleshoot auto-enrolling existing Configuration Manager devices in Intune
description: Helps you understand and troubleshoot issues when you set up co-management by taking Path 1 - Auto-enroll existing Configuration Manager-managed devices into Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Co-management with System Center Configuration Manager\Prepare Windows 10 devices for co-management
ms.reviewer: kaushika, luche
---
# Troubleshoot co-management: Auto-enroll existing Configuration Manager-managed devices into Intune

This article helps you understand and troubleshoot issues that you may encounter when you set up co-management by [auto-enrolling existing Configuration Manager-managed devices into Intune](/mem/configmgr/comanage/quickstart-paths#bkmk_path1).

In this scenario, you can continue to manage Windows 10 devices by using Configuration Manager, or you can selectively move workloads to Microsoft Intune as you want. For more information about how to configure workloads, see [Support Tip: Configuring workloads in a co-managed environment](https://techcommunity.microsoft.com/t5/Intune-Customer-Success/Support-Tip-Configuring-workloads-in-a-co-managed-environment/ba-p/707221).

## Before you start

Before you start troubleshooting, it's important to collect some basic information about the issue and make sure that you follow all required configuration steps. It helps you better understand the problem and reduce the time to find a resolution. To do this, follow this checklist of pre-troubleshooting questions:

- Did you have the required [permissions and roles](/mem/configmgr/comanage/overview#permissions-and-roles) to configure co-management?
- Which [Microsoft Entra hybrid identity option](/azure/active-directory/hybrid/plan-connect-user-signin#choosing-the-user-sign-in-method-for-your-organization) did you select?
- What is your [current MDM authority](/mem/intune/fundamentals/mdm-authority-set)?
- Did you [install and configure Microsoft Entra Connect](/mem/configmgr/comanage/tutorial-co-manage-clients#set-up-azure-ad-connect)?
- Did you [assign a Microsoft Entra ID P1 or P2 license](/azure/active-directory/fundamentals/license-users-groups) to the UPN that you used for configuration?
- Did you [assign Intune licenses](/mem/intune/fundamentals/licenses-assign) to the users?
- Did you configure Microsoft Entra hybrid join for [managed domains](/azure/active-directory/devices/hybrid-azuread-join-managed-domains) or [federated domains](/azure/active-directory/devices/hybrid-azuread-join-federated-domains)?
- Did you [configure the Configuration Manager client agent settings](/mem/configmgr/comanage/tutorial-co-manage-clients#configure-client-settings-to-direct-clients-to-register-with-azure-ad) for Microsoft Entra hybrid join?
- Did you [configure auto-enrollment](/mem/configmgr/comanage/tutorial-co-manage-clients#configure-auto-enrollment-of-devices-to-intune) in your Intune tenant?
- Did you [enable co-management in Configuration Manager](/mem/configmgr/comanage/tutorial-co-manage-clients#enable-co-management-in-configuration-manager)?

Most issues occur because one or more of these steps were not completed. If you find that a step was skipped or was not completed successfully, check the details of each step, or see the following tutorial: [Enable co-management for existing Configuration Manager clients](/mem/configmgr/comanage/tutorial-co-manage-clients).

Use the following log file on Windows 10 devices to troubleshoot co-management issues on the client:

`%WinDir%\CCM\logs\CoManagementHandler.log`

<a name='troubleshooting-hybrid-azure-ad-configuration'></a>

## Troubleshooting hybrid Microsoft Entra configuration

If you are experiencing issues that affect either Microsoft Entra hybrid identity or Microsoft Entra Connect, refer to the following troubleshooting guides:

- [Troubleshoot Microsoft Entra Connect install issues](/azure/active-directory/hybrid/tshoot-connect-install-issues)
- [Troubleshoot errors during Microsoft Entra Connect synchronization](/azure/active-directory/hybrid/tshoot-connect-sync-errors)
- [Troubleshoot password hash synchronization with Microsoft Entra Connect Sync](/azure/active-directory/hybrid/tshoot-connect-password-hash-synchronization)
- [Troubleshoot Microsoft Entra seamless single sign-on](/azure/active-directory/hybrid/tshoot-connect-sso)
- [Troubleshoot Microsoft Entra pass-through authentication](/azure/active-directory/hybrid/tshoot-connect-pass-through-authentication)
- [Troubleshoot single sign-on issues with Active Directory Federation Services](https://support.microsoft.com/help/4034932)

If you are experiencing issues that affect Microsoft Entra hybrid join for managed domains or federated domains, refer to the following troubleshooting guides:

- [Troubleshooting Microsoft Entra hybrid joined devices](/azure/active-directory/devices/troubleshoot-hybrid-join-windows-current)
- [Troubleshooting devices using the dsregcmd command](/azure/active-directory/devices/troubleshoot-device-dsregcmd)

## Common issues  

<a name='clients-did-not-receive-the-policy-from-configuration-manager-management-point-to-start-the-registration-process-with-azure-ad-and-intune'></a>

### Clients did not receive the policy from Configuration Manager management point to start the registration process with Microsoft Entra ID and Intune

This issue occurs because of an issue in Configuration Manager and not Intune. You can use the [client log files](/mem/configmgr/core/plan-design/hierarchy/log-files#BKMK_ClientLogs) to troubleshoot such issues.

<a name='the-configuration-manager-client-is-installed-however-the-device-isnt-registering-with-azure-ad-and-no-errors-are-seen'></a>

### The Configuration Manager client is installed. However, the device isn't registering with Microsoft Entra ID and no errors are seen

This issue usually occurs because the Configuration Manager client agent settings aren't configured to direct the clients to register.

To fix the issue, verify that you follow the steps in [Configure Client Settings to direct clients register with Microsoft Entra ID](/mem/configmgr/comanage/tutorial-co-manage-clients#configure-client-settings-to-direct-clients-to-register-with-azure-ad).

<a name='the-configuration-manager-client-is-installed-and-the-device-is-registered-successfully-with-azure-ad-however-the-device-isnt-automatically-enrolled-in-intune-and-no-errors-are-seen'></a>

### The Configuration Manager client is installed and the device is registered successfully with Microsoft Entra ID. However, the device isn't automatically enrolled in Intune and no errors are seen

This issue usually occurs when auto-enrollment is misconfigured in your Intune tenant under **Microsoft Entra ID** > **Mobility (MDM and MAM)** > **Microsoft Intune**.

To fix the issue, follow the steps in [Configure auto-enrollment of devices to Intune](/mem/configmgr/comanage/tutorial-co-manage-clients#configure-auto-enrollment-of-devices-to-intune).  

### You can't locate the co-management node under Administration > Cloud Services in the Configuration Manager console

This issue occurs if your version of Configuration Manager is earlier than version 1906.

To fix the issue, update Configuration Manager to version 1906 or a later version.

<a name='hybrid-azure-ad-joined-devices-fail-to-enroll-and-generate-error-0x8018002a'></a>

### Microsoft Entra hybrid joined devices fail to enroll and generate error 0x8018002a

When this issue occurs, you also notice the following symptoms:

- The following error message is logged in the **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider** > **Admin log** in the Event Viewer:

  > Auto MDM Enroll: Failed (Unknown Win32 Error code: **0x8018002a**)

- The following error message is logged in **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID** > **Operational log** in the Event Viewer:

  > Error: 0xCAA2000C The request requires user interaction.  
  > Code: interaction_required  
  > Description: AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multifactor authentication to access.

This issue occurs when multifactor authentication (MFA) is **Enforced**. It prevents the Configuration Manager client agent from enrolling the device by using the logged-in user credentials.

> [!NOTE]
> There is a difference between having MFA **Enabled** and **Enforced**. For more information about the difference, see [Microsoft Entra multifactor authentication user states](/azure/active-directory/authentication/howto-mfa-userstates#azure-ad-multi-factor-authentication-user-states). This scenario works by having MFA **Enabled** but not having MFA **Enforced**. 

To fix the issue, use one of the following methods:

- Set MFA to **Enabled** but not **Enforced**. For more information, see [Set up multifactor authentication](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication).
- Temporarily disable MFA during enrollment in [Trusted IPs](/azure/active-directory/authentication/howto-mfa-mfasettings#trusted-ips).  

### Devices fail to sync after auto-enrollment

Starting in Configuration Manager version 1906, a co-managed device running Windows 10 version 1803 or a later version automatically enrolls to the Microsoft Intune service based on its Microsoft Entra device tokens. However, the device fails to sync, and you receive the following error message in **Settings** > **Accounts** > **Access work or school**:

> Sync wasn't fully successful because we weren't able to verify your credentials. Select Sync to sign in and try again.

:::image type="content" source="media/troubleshoot-co-management-auto-enrolling/device-sync-failure.png" alt-text="Screenshot of the Sync wasn't fully successful message.":::

When this issue occurs, the following error message is logged in **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider** > **Admin log** in the Event Viewer:

> MDM Session: Failed to get Microsoft Entra Token for sync session User Token: (Unknown Win32 Error code: 0xcaa2000c) Device Token: (Incorrect function).

The following error message is logged in **Applications and Services Logs** > **Microsoft** > **Windows** > **Microsoft Entra ID** > **Operational log** in the Event Viewer:

> Error: 0xCAA2000C The request requires user interaction.  
> Code: interaction_required  
> Description: AADSTS50076: Due to a configuration change made by your administrator, or because you moved to a new location, you must use multifactor authentication to access.

This issue occurs when MFA is **Enabled** or **Enforced**, or Microsoft Entra Conditional Access policies that require MFA are applied to all cloud apps. It prevents user association with the device in the portal.

:::image type="content" source="media/troubleshoot-co-management-auto-enrolling/user-association-blocked.png" alt-text="Screenshot shows the user association is prevented.":::

To fix the issue, use one of the following methods:

- If MFA is **Enabled** or **Enforced**:
    - Set MFA to **Disabled**. For more information, see [Turn off legacy per-user MFA](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication#turn-off-legacy-per-user-mfa).
    - Bypass MFA by using [Trusted IPs](/azure/active-directory/authentication/howto-mfa-mfasettings#trusted-ips).
- If Microsoft Entra Conditional Access policies are used, exclude the Microsoft Intune app from the policies that require MFA to allow device sync by using the user credentials.

<a name='a-hybrid-azure-ad-joined-windows-10-device-fails-to-enroll-in-intune-with-error-0x800706d9-or-0x80180023'></a>

### A Microsoft Entra hybrid joined Windows 10 device fails to enroll in Intune with error 0x800706D9 or 0x80180023

When this issue occurs, you typically see the following error message in **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider** > **Admin log** in the Event Viewer:

> MDM Enroll: OMA-DM client configuration failed. RAWResult: (0x800706D9) Result: (Unknown Win32 Error code: 0x80180023).  
> MDM Enroll: Provisioning failed. Result: (Unknown Win32 Error code: 0x80180023).  
> MDM Enroll: Failed (Unknown Win32 Error code: 0x80180023)  
> Auto MDM Enroll: Device Credential (0x80180023), Failed (%2)  
> MDM Unenroll: Error sending unenroll alert to server. Result: (Incorrect function.).  
> MDM Unenroll: Changing dmwappushservice startup type to demand-start failed. Result: (The specified service does not exist as an installed service.)

This issue occurs if the `dmwappushservice` service is missing from the device. To verify, run `services.msc` to look for this service.

To fix this issue, follow these steps:

1. On a working device that runs the same version of Windows 10 as the affected device, [export](/windows-server/administration/windows-commands/reg-export) the following registry key:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\dmwappushservice`

2. Log on to the affected device as a local administrator, copy the *.reg* file to the affected device, and then merge it with the local registry.
3. Restart the affected device.
4. Delete the old Microsoft Entra registration, and then update Group Policy.
5. Restart the affected device again. The device should be able to register with Microsoft Entra ID and enroll in Intune automatically.

<a name='hybrid-azure-ad-join-fails-in-a-managed-domain-with-error-0x801c03f2'></a>

### Microsoft Entra hybrid join fails in a managed domain with error 0x801c03f2

When you run `dsregcmd /status` from a command prompt on the device, you can see that it's domain joined but not Microsoft Entra hybrid joined. The following error message is logged in **Application and Service Logs** > **Microsoft** > **Windows** > **User Device Registration** > **Admin log** in the Event Viewer:

> Server response was: {"ErrorType":"DirectoryError","Message":"**The public key user certificate is not found on the device object with id \<DeviceID>**".

This issue occurs in one of the following situations:

- The device object is missing in Microsoft Entra ID.
- The `Usercertificate` attribute doesn't have the device certificate in the on-premises Active Directory or Microsoft Entra ID.

For Windows 10 device registration to work in a managed domain, the device object must be synced first. The registration process works as follows:

- The Windows 10 device starts for the first time after it's on-premises domain joined.
- Device registration is triggered and a certificate request is created.
- When the request is created, the public key of the certificate is published in the on-premises AD for the device object. This updates the `Usercertificate` attribute on the device objects. At the same time, the signed device registration request is sent to Microsoft Entra ID.
- The registration fails because Microsoft Entra ID can't authenticate the device object or verify the signed request.
- The next time that the sync cycle runs, it finds the device object that has the `Usercertificate` attribute populated, and syncs the device object to Microsoft Entra ID.
- The next time the registration service is triggered (this runs every hour), the device will send a new request that's signed by the private key.
- Azure verifies the signature on the request by using the public certificate that was received from the on-premises domain during the sync cycle. If Microsoft Entra ID can verify the signature on the request, the device registration succeeds.

To fix the issue, follow these steps:

1. In the on-premises AD, make sure that the `Usercertificate` attribute is populated and has the correct certificate.
2. Check the back-end device object and make sure that the `Usercertificate` attribute exists and is populated.
3. If the certificate is missing, or someone deleted the certificate from the on-premises AD (which, in turn deletes the certificate from Microsoft Entra ID), the device registration fails. To fix this issue, do the following on the client device:

   1. Open an elevated Command Prompt window, and then run the following command:

      ```console
      dsregcmd /leave
      ```

   2. Run `certlm.msc` to open the local computer certificate store.
   3. Make sure that the computer certificate that's issued by **MS-Organization-Access** is deleted.
   4. Restart the client device to trigger a fresh device registration.
   5. After the device is restarted, make sure that the new certificate public key is updated on the device object in the on-premises AD. If there are multiple domain controllers, make sure that the attribute is replicated to all domain controllers.
   6. Trigger a delta sync on the Microsoft Entra Connect server.
   7. After the sync is completed, you can trigger device registration by restarting the client, running the `dsregcmd /debug` command, or running the scheduled task **Automatic-Device-Join** under **Workplace Join**.  

### Automatic device registration fails with error 0x80280036

When this issue occurs, the following error message is logged in **Application and Service Logs** > **Microsoft** > **Windows** > **User Device Registration** > **Admin log** in the Event Viewer:

> DeviceRegistrationApi::BeginJoin failed with error code: 0x80280036
>
> Description:  
> The initialization of the join request failed with exit code: The TPM is attempting to execute a command only available when in FIPS mode.

This issue occurs if the TPM chip on the client device has FIPS mode enabled. FIPS mode isn't supported or recommended for Azure device registration. For more information, see [Why We're Not Recommending "FIPS Mode" Anymore](/archive/blogs/secguide/why-were-not-recommending-fips-mode-anymore).  

<a name='hybrid-azure-ad-join-fails-with-error-0x80090016'></a>

### Microsoft Entra hybrid join fails with error 0x80090016

Hybrid Microsoft Entra registration of a Windows 10 device fails, and you receive the following error message:

> Something went wrong. Confirm you are using the correct sign-in information and that your organization uses this feature. You can try to do this again or contact your system administrator with the error code 0x80090016

The error message of 0x80090016 is **Keyset does not exist**. This means that the device registration could not save the device key because the TPM keys were not accessible.

This issue occurs if Windows isn't the owner of the TPM. Starting with Windows 10, the operating system automatically initializes and takes ownership of the TPM. However, if this process fails, Windows won't be the owner and will result in the issue.

To fix this issue, clear the TPM and restart the client device. To clear the TPM, follow these steps:

1. Open the Windows Security app.
2. Select **Device security**.
3. Select **Security processor details**.
4. Select **Security processor troubleshooting**.
5. Click **Clear TPM**.

   > [!IMPORTANT]
   > Before you clear the TPM, be aware of the following:
   >
   > - Clearing TPM can result in data loss. You will lose all created keys that are associated with the TPM and data that's protected by those keys, such as a virtual smart card, a logon PIN or BitLocker keys.
   > - If BitLocker is enabled on the device, make sure that you disable BitLocker before you clear the TPM.
   > - Make sure that you have a backup and recovery method for any data that's protected or encrypted by the TPM.

6. Restart the device when you are prompted.

   > [!NOTE]
   > During the restart, you may be prompted by the UEFI to press a button to confirm that you want to clear the TPM. After the restart is completed, the TPM will be automatically prepared for use by Windows 10.

After the device restarts, Microsoft Entra hybrid join should be successful. To verify, run `dsregcmd /status` command at a command prompt. The following result indicates a successful join:

```output
AzureAdJoined : YES  
DomainName : \<on-prem Domain name>
```

For more information, see [Troubleshoot the TPM](/windows/security/information-protection/tpm/initialize-and-configure-ownership-of-the-tpm).

## More information

For more information about troubleshooting co-management issues, see the following articles:

- [Troubleshoot co-management: Bootstrap with modern provisioning](troubleshoot-co-management-bootstrap.md)
- [Troubleshoot co-management workloads](troubleshoot-co-management-workloads.md)

For more information about Intune and Configuration Manager co-management, see the following articles:

- [Overview of Windows 10 co-management](/mem/configmgr/comanage/overview)
- [Getting Started: Paths to co-management](/mem/configmgr/comanage/quickstart-paths#bkmk_path1)
- [Quickstarts for co-management](/mem/configmgr/comanage/quickstarts)
- [Tutorial: Enable co-management for existing Configuration Manager clients](/mem/configmgr/comanage/tutorial-co-manage-clients)
