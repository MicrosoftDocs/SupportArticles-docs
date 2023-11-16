---
title: Troubleshooting iOS/iPadOS device enrollment errors in Microsoft Intune
description: Suggestions for troubleshooting some of the most common enrollment and sync token errors when enrolling iOS/iPadOS devices in Intune.
ms.reviewer: kaushika, mghadial
ms.date: 09/30/2021
search.appverid: MET150
---

# Troubleshooting iOS/iPadOS device enrollment errors in Microsoft Intune

This article helps Intune administrators understand and troubleshoot problems when enrolling iOS/iPadOS devices in Intune. See [Troubleshoot device enrollment in Microsoft Intune](troubleshoot-device-enrollment-in-intune.md) for additional, general troubleshooting scenarios.  

## iOS/iPadOS enrollment errors

The following table lists errors that end users might see while enrolling iOS/iPadOS devices in Intune.

|Error message|Issue|Resolution|
|-------------|-----|----------|
|NoEnrollmentPolicy|No enrollment policy found| The Apple Push Notification Service (APNs) certificate is missing, invalid, or expired. Check that enrollment has been set up correctly and that **iOS/iPadOS as a platform** is enabled. For instructions, see [Set up iOS/iPadOS and Mac device management](/mem/intune/enrollment/ios-enroll),[Get an Apple MDM push certificate](/mem/intune/enrollment/apple-mdm-push-certificate-get#steps-to-get-your-certificate), and [Renew Apple MDM push certificate](/mem/intune/enrollment/apple-mdm-push-certificate-get#renew-apple-mdm-push-certificate).|
|DeviceCapReached|Too many mobile devices are enrolled already.|The user must remove one of their currently enrolled mobile devices from the Company Portal before enrolling another. See detailed instructions [here](troubleshoot-device-enrollment-in-intune.md#device-cap-reached).|
|Company Portal Temporarily Unavailable| The Company Portal app on the device is out of date or corrupted.| Remove the app, validate user credentials, and then resinstall the app. See detailed instructions [here](troubleshoot-device-enrollment-in-intune.md#company-portal-temporarily-unavailable).|
|APNSCertificateNotValid|There's a problem with the certificate that lets the mobile device communicate with your company's network.<br /><br />|The Apple Push Notification Service (APNs) provides a channel to contact enrolled iOS/iPadOS devices. Enrollment will fail and this message will appear if:<ul><li>The steps to get an APNs certificate weren't completed, or</li><li>The APNs certificate has expired.</li></ul>Review the information about how to set up users in [Sync Active Directory and add users to Intune](/mem/intune/fundamentals/users-add) and [organizing users and devices](/mem/intune/fundamentals/groups-add).|
|AccountNotOnboarded|There's a problem with the certificate that lets the mobile device communicate with your company's network. Enrollment will fail and this message will appear if:<ul><li>The steps to get an APNs certificate weren't completed, or</li><li>The APNs certificate has expired.</li></ul> | 
Renew the APNs certificate, and then re-enroll the device.<br/>**Important:** Make sure that you renew the APNs certificate. Don't *replace* the APNs certificate. If you replace the certificate, you have to re-enroll all iOS/iPadOS devices in Intune. For Intune standalone, see [Renew Apple MDM push certificate](/mem/intune/enrollment/apple-mdm-push-certificate-get#renew-apple-mdm-push-certificate). For Microsoft 365, see [Create an APNs Certificate for iOS devices](/microsoft-365/admin/basic-mobility-security/create-an-apns-certificate-for-ios-devices).|
|DeviceTypeNotSupported|The user might have tried to enroll using a non-iOS device. The mobile device type that you're trying to enroll isn't supported.<br/><br/>Confirm that device is running iOS/iPadOS version 8.0 or later.<br/><br/>|Make sure that your user's device is running iOS/iPadOS version 8.0 or later.|
|UserLicenseTypeInvalid|The device can't be enrolled because the user's account isn't yet a member of a required user group or the user does not have the correct license.<br/><br/>|Users must have the correct license type for the mobile device management authority. For example, they'll see this error if Intune has been set as the MDM authority, but the user has a System Center 2012 R2 Configuration Manager license.<br/>Review [Set up iOS/iPadOS and Mac management with Microsoft Intune](/mem/intune/enrollment/ios-enroll) and information about how to set up users in [Sync Active Directory and add users to Intune](/mem/intune/fundamentals/users-add) and [organizing users and devices](/mem/intune/fundamentals/groups-add).|
|MdmAuthorityNotDefined|The mobile device management authority hasn't been defined.<br /><br />|The mobile device management authority hasn't been set in Intune.<br /><br />Review item #1 in the **Step 6: Enroll mobile devices and install an app** section in [Get started with a 30-day trial of Microsoft Intune](/mem/intune/fundamentals/free-trial-sign-up).|

## Sync token errors between Intune and ADE

This section includes token sync errors related to Apple Automated Device Enrollment (ADE):

- Apple Business Manager (ABM)
- Apple School Manager (ASM)

|Error message| Cause | Solution|
|-------------|-----|----------|
| Expired or invalid token | The token may be expired, revoked, or malformed. | Expired tokens can be renewed, Invalid token will need to have a new token created in Intune.<br/> The new token can be used on an existing MDM Server in Apple Business Manager/Apple School Manager (ABM/ASM): Edit option > MDM Server settings > Upload public key |
| Access denied | Intune can't talk to Apple anymore. For example, Intune has been removed from the MDM server list in ABM/ASM. The token has possibly expired. | 1. Verify whether your token has expired, and if a new token was created.<br/>2. Check to see if Intune is in the MDM server list |
| Terms and conditions not accepted | New terms and conditions (T&C) need to be accepted in ABM/ASM. | Accept the new T&C in Apple ABM/ASM Portal.<br/>**Note:** This must be done by a user with the Administrator role in ABM/ASM. |
| Internal server error | Needs further investigation | Contact the [Intune support team](/mem/get-support), as additional logs are needed |
| Invalid support phone number | The support phone number is invalid. | Edit the support phone number for your profiles. |
| Invalid configuration profile name | The configuration profile name is either invalid, empty, or too long. | Edit the name of the profile. |
| Invalid cursor | The cursor was rejected by Apple or not found. | Contact the [Intune support team](/mem/get-support). They can retry syncing from the Intune service. |
| Cursor expired | The cursor is expired on Intune's side. | Contact the [Intune support team](/mem/get-support). They can retry syncing from the Intune service. |
| Required cursor | The cursor was not initially set by Intune during the sync. | Contact the [Intune support team](/mem/get-support) to fix the sync and return the cursor. |
| Apple profile not found | Multiple possible causes | Create a new profile, and assign the profile to devices. |
| Invalid department entry | The department field entry is invalid | Edit the department field for your profiles. |

## Other errors and issues

This section provides troubleshooting steps for these additional scenarios:

- [Verify WS-Trust 1.3 is enabled](#verify-ws-trust-13-is-enabled)
- [Workplace Join failed](#workplace-join-failed)
- [User Name Not Recognized](#user-name-not-recognized)
- [XPC_TYPE_ERROR Connection invalid](#xpc_type_error-connection-invalid)
- [The configuration could not be downloaded...Invalid Profile](#the-configuration-for-your-iphoneipad-could-not-be-downloaded-from-company-name-invalid-profile)
- [ADE enrollment doesn't start](#ade-enrollment-doesnt-start)
- [ADE enrollment stuck at user login](#ade-enrollment-stuck-at-user-login)
- [Authentication doesn’t redirect to the government cloud](#authentication-doesnt-redirect-to-the-government-cloud)

### Verify WS-Trust 1.3 is enabled

Enrolling ADE devices with user affinity requires WS-Trust 1.3 Username/Mixed endpoint to be enabled to request user tokens. Active Directory enables this endpoint by default. If WS-Trust 1.3 is not enabled, Automated Device Enrollment (ADE) iOS/iPadOS devices can't be enrolled.

To get a list of enabled endpoints, use the Get-AdfsEndpoint PowerShell cmdlet and looking for the trust/13/UsernameMixed endpoint. For example:

```powershell
Get-AdfsEndpoint -AddressPath "/adfs/services/trust/13/UsernameMixed"
```

For more information, see [Get-AdfsEndpoint documentation](/powershell/module/adfs/get-adfsendpoint) and [Best practices for securing Active Directory Federation Services](/windows-server/identity/ad-fs/deployment/Best-Practices-Securing-AD-FS). For help with determining if WS-Trust 1.3 Username/Mixed is enabled in your identity federation provider, contact Microsoft Support if you use AD FS. Otherwise, contact your third-party identity vendor.

### Workplace Join failed

This error indicates that the Company Portal app is out of date or corrupted.  

**Solution:**

1. Remove the Company Portal app from the device.
2. Download and install the **Microsoft Intune Company Portal** app from **App Store**.
3. Re-enroll the device.

### User Name Not Recognized

The error "User Name Not Recognized. This user account is not authorized to use Microsoft Intune. Contact your system administrator if you think you have received this message in error." indicates that the user who is trying to enroll the device does not have a valid Intune license.

1. Go to the [Microsoft 365 admin center](https://admin.microsoft.com), and then choose **Users** > **Active Users**.
2. Select the affected user account, and then choose **Product licenses** > **Edit**.
3. Verify that a valid Intune license is assigned to this user.
4. Re-enroll the device.

### XPC_TYPE_ERROR Connection invalid

When you turn on an ADE-managed device that is assigned an enrollment profile, enrollment fails, and you receive the following error message:

```output
asciidoc
mobileassetd[83] <Notice>: 0x1a49aebc0 Client connection: XPC_TYPE_ERROR Connection invalid <error: 0x1a49aebc0> { count = 1, transaction: 0, voucher = 0x0, contents = "XPCErrorDescription" => <string: 0x1a49aee18> { length = 18, contents = "Connection invalid" } }
iPhone mobileassetd[83] <Notice>: Client connection invalid (Connection invalid); terminating connection
iPhone com.apple.accessibility.AccessibilityUIServer(MobileAsset)[288] <Notice>: [MobileAssetError:29] Unable to copy asset information from https://mesu.apple.com/assets/ for asset type com.apple.MobileAsset.VoiceServices.CombinedVocalizerVoices
iPhone mobileassetd[83] <Notice>: 0x1a49aebc0 Client connection: XPC_TYPE_ERROR Connection invalid <error: 0x1a49aebc0> { count = 1, transaction: 0, voucher = 0x0, contents = "XPCErrorDescription" => <string: 0x1a49aee18> { length = 18, contents = "Connection invalid" }
```

**Cause:** There's a connection issue between the device and the Apple ADE service.

**Solution:** Fix the connection issue, or use a different network connection to enroll the device. You may also have to contact Apple if the issue persists.

### The configuration for your iPhone/iPad could not be downloaded from \<Company Name>: Invalid Profile

**Cause:** The enrollment is blocked by a device type restriction.

**Solution:**

1. Sign in to the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431) > **Devices** > **Enroll devices** > **Enrollment restrictions**.
2. Under **Device type restrictions**, select **All Users** > **Properties**.
3. Select **Edit** next to the **Platform settings**.
4. On the **Edit restriction** page, select **Allow** for **iOS/iPadOS** and proceed to the **Review + save** page, then select **Save**.

### ADE enrollment doesn't start

When you turn on an ADE-managed device that is assigned an enrollment profile, the Intune enrollment process isn't initiated.

**Cause:** The enrollment profile is created before the ADE token is uploaded to Intune.

**Solution:**

1. Edit the enrollment profile. You can make any change to the profile. The purpose is to update the modification time of the profile.
2. Synchronize ADE-managed devices: In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **iOS** > **iOS enrollment** > **Enrollment program tokens** > choose a token > **Sync now**. A sync request is sent to Apple.

### ADE enrollment stuck at user login

When you turn on an ADE-managed device that is assigned an enrollment profile, the initial setup sticks after you enter credentials.

**Cause:** Multi-Factor authentication (MFA) is enabled. Currently MFA doesn't work during enrollment on ADE devices.

**Solution:** Disable MFA, and then re-enroll the device.

### Authentication doesn’t redirect to the government cloud 

Government users signing in from another device are redirected to the public cloud for authentication rather than the government cloud. 

**Cause:** Microsoft Entra ID does not yet support redirecting to the government cloud when signing in from another device. 

**Solution:**
Use the iOS Company Portal **Cloud** setting in the **Settings** app to redirect government users’ authentication towards the government cloud. By default, the **Cloud** setting is set to **Automatic** and Company Portal directs authentication towards the cloud that is automatically detected by the device (such as Public or Government). Government users who are signing in from another device will need to manually select the government cloud for authentication. 

Open the **Settings** app and select Company Portal. In the Company Portal settings, select **Cloud**. Set the **Cloud** to Government.

- [Overall Token Sync errors](https://developer.apple.com/documentation/devicemanagement/device_assignment/authenticating_with_a_device_enrollment_program_dep_server/interpreting_error_codes)
- [Profile creation errors](https://developer.apple.com/documentation/devicemanagement/define_a_profile)
