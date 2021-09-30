---
title: Troubleshooting iOS/iPadOS device enrollment problems in Microsoft Intune
description: Suggestions for troubleshooting some of the most common problems when you enroll iOS/iPadOS devices in Intune.
ms.reviewer: mghadial
ms.date: 09/30/2021
---

# Troubleshoot iOS/iPadOS device enrollment problems in Microsoft Intune

This article helps Intune administrators understand and troubleshoot problems when enrolling iOS/iPadOS devices in Intune. See [Troubleshoot device enrollment in Microsoft Intune](troubleshoot-device-enrollment-in-intune.md) for initial troubleshooting steps for general scenarios.  

## Error messages


### iOS/iPadOS enrollment errors

The following table lists errors that end users might see while enrolling iOS/iPadOS devices in Intune.

|Error message|Issue|Resolution|
|-------------|-----|----------|
|NoEnrollmentPolicy|No enrollment policy found|Check that all enrollment prerequisites, like the Apple Push Notification Service (APNs) certificate, have been set up and that **iOS/iPadOS as a platform** is enabled. For instructions, see [Set up iOS/iPadOS and Mac device management](/mem/intune/enrollment/ios-enroll).|
|DeviceCapReached|Too many mobile devices are enrolled already.|The user must remove one of their currently enrolled mobile devices from the Company Portal before enrolling another. See the instructions for the type of device you're using: [Android](/mem/intune/user-help/unenroll-your-device-from-intune-android), [iOS/iPadOS](/mem/intune/user-help/unenroll-your-device-from-intune-ios), [Windows](/mem/intune/user-help/unenroll-your-device-from-intune-windows).|
|APNSCertificateNotValid|There's a problem with the certificate that lets the mobile device communicate with your company's network.<br /><br />|The Apple Push Notification Service (APNs) provides a channel to contact enrolled iOS/iPadOS devices. Enrollment will fail and this message will appear if:<ul><li>The steps to get an APNs certificate weren't completed, or</li><li>The APNs certificate has expired.</li></ul>Review the information about how to set up users in [Sync Active Directory and add users to Intune](/mem/intune/fundamentals/users-add) and [organizing users and devices](/mem/intune/fundamentals/groups-add).|
|AccountNotOnboarded|There's a problem with the certificate that lets the mobile device communicate with your company's network.<br /><br />|The Apple Push Notification Service (APNs) provides a channel to contact enrolled iOS/iPadOS devices. Enrollment will fail and this message will appear if:<ul><li>The steps to get an APNs certificate weren't completed, or</li><li>The APNs certificate has expired.</li></ul>For more information, review [Set up iOS/iPadOS and Mac management with Microsoft Intune](/mem/intune/enrollment/ios-enroll).|
|DeviceTypeNotSupported|The user might have tried to enroll using a non-iOS device. The mobile device type that you're trying to enroll isn't supported.<br /><br />Confirm that device is running iOS/iPadOS version 8.0 or later.<br /><br />|Make sure that your user's device is running iOS/iPadOS version 8.0 or later.|
|UserLicenseTypeInvalid|The device can't be enrolled because the user's account isn't yet a member of a required user group.<br /><br />|Before users can enroll their devices, they must be members of the right user group. This message means that they have the wrong license type for the mobile device management authority. For example, they'll see this error if both of the following are true:<ol><li>Intune has been set as the mobile device management authority</li><li>they'e using a System Center 2012 R2 Configuration Manager license.</li></ol>Review the following articles for more information:<br /><br />Review [Set up iOS/iPadOS and Mac management with Microsoft Intune](/mem/intune/enrollment/ios-enroll) and information about how to set up users in [Sync Active Directory and add users to Intune](/mem/intune/fundamentals/users-add) and [organizing users and devices](/mem/intune/fundamentals/groups-add).|
|MdmAuthorityNotDefined|The mobile device management authority hasn't been defined.<br /><br />|The mobile device management authority hasn't been set in Intune.<br /><br />Review item #1 in the **Step 6: Enroll mobile devices and install an app** section in [Get started with a 30-day trial of Microsoft Intune](/mem/intune/fundamentals/free-trial-sign-up).|

### Devices are inactive or the admin console can't communicate with them

**Issue:** iOS/iPadOS devices aren't checking in with the Intune service. Devices must check in periodically with the service to maintain access to protected corporate resources. If devices don't check in:

- They can't receive policy, apps, and remote commands from the Intune service.
- They show a Management State of **Unhealthy** in the administrator console.
- Users who are protected by Conditional Access policies might lose access to corporate resources.

**Resolution:** Share the following resolutions with your end users to help them regain access to corporate resources.

When users start the iOS/iPadOS Company Portal app, it can tell if their device has lost contact with Intune. If it detects that there's no contact, it automatically tries to sync with Intune to reconnect (users will see the **Trying to sync…** message).

  ![Trying to sync notification](./media/troubleshoot-device-enrollment-in-intune/ios_cp_app_trying_to_sync_notification.png)

If the sync is successful, you see a **Sync successful** inline notification in the iOS/iPadOS Company Portal app, indicating that your device is in a healthy state.

  ![Sync successful notification](./media/troubleshoot-device-enrollment-in-intune/ios_cp_app_sync_successful_notification.png)

If the sync is unsuccessful, users see an **Unable to sync** inline notification in the iOS/iPadOS Company Portal app.

  ![Unable to sync notification](./media/troubleshoot-device-enrollment-in-intune/ios_cp_app_unable_to_sync_notification.png)

To fix the issue, users must select the **Set up** button, which is to the right of the **Unable to sync** notification. The **Set up** button takes users to the Company Access Setup flow screen, where they can follow the prompts to enroll their device.

  ![Company Access Setup screen](./media/troubleshoot-device-enrollment-in-intune/ios_cp_app_company_access_setup.png)

Once enrolled, the devices return to a healthy state and regain access to company resources.

### Verify WS-Trust 1.3 is enabled

**Issue** Automated Device Enrollment (ADE) iOS/iPadOS devices can't be enrolled

Enrolling ADE devices with user affinity requires WS-Trust 1.3 Username/Mixed endpoint to be enabled to request user tokens. Active Directory enables this endpoint by default. To get a list of enabled endpoints, use the Get-AdfsEndpoint PowerShell cmdlet and looking for the trust/13/UsernameMixed endpoint. For example:

```powershell
Get-AdfsEndpoint -AddressPath "/adfs/services/trust/13/UsernameMixed"
```

For more information, see [Get-AdfsEndpoint documentation](/powershell/module/adfs/get-adfsendpoint).

For more information, see [Best practices for securing Active Directory Federation Services](/windows-server/identity/ad-fs/deployment/Best-Practices-Securing-AD-FS). For help with determining if WS-Trust 1.3 Username/Mixed is enabled in your identity federation provider:

- contact Microsoft Support if you use AD FS
- contact your third-party identity vendor.

### Profile installation failed

**Issue:** A user receives a **Profile installation failed** error on an iOS/iPadOS device.

### Troubleshooting steps for failed profile installation

1. Confirm that the user is assigned an appropriate license for the version of the Intune service that you're using.

2. Confirm that the device isn't already enrolled with another MDM provider.

3. Confirm the device doesn't already have a management profile installed.

4. Navigate to [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com) and try to install the profile when prompted.

5. Confirm that Safari for iOS/iPadOS is the default browser and that cookies are enabled.

### User's iOS/iPadOS device is stuck on an enrollment screen for more than 10 minutes

**Issue**: An enrolling device may get stuck in either of two screens:

- Awaiting final configuration from "Microsoft"
- Guided Access app unavailable. Please contact your administrator.

This issue can happen if:

- there's a temporary outage with Apple services, or
- iOS/iPadOS enrollment is set to use VPP tokens as shown in the table but there's something wrong with the VPP token.

| Enrollment settings | Value |
| ---- | ---- |
| Platform | iOS/iPadOS |
| User Affinity | Enroll with User Affinity |
|Authenticate with Company Portal instead of Apple Setup Assistant | Yes |
| Install Company Portal with VPP | Use token: token address |
| Run Company Portal in Single App Mode until authentication | Yes |

**Resolution**: To fix the problem, you must:

1. Determine if there's something wrong with the VPP token and fix it.
2. Identify which devices are blocked.
3. Wipe the affected devices.
4. Tell the user to restart the enrollment process.

#### Determine if there's something wrong with the VPP token

1. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **iOS/iPadOS** > **iOS enrollment** > **Enrollment program tokens** > token name > **Profiles** > profile name > **Manage** > **Properties**.
2. Review the properties to see if any errors similar to the following appear:
    - This token has expired.
    - This token is out of Company Portal licenses.
    - This token is being used by another service.
    - This token is being used by another tenant.
    - This token was deleted.
3. Fix the issues for the token.

#### Identify which devices are blocked by the VPP token

1. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **iOS/iPadOS**k > **iOS enrollment** > **Enrollment program tokens** > token name > **Devices**.
2. Filter the **Profile status** column by **Blocked**.
3. Make a note of the serial numbers for all the devices that are **Blocked**.

#### Remotely wipe the blocked devices

After you've fixed the issues with the VPP token, you must wipe the devices that are blocked.

1. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **All devices** > **Columns** > **Serial number** > **Apply**.
2. For each blocked device, choose it in the **All devices** list and then choose **Wipe** > **Yes**.

#### Tell the users to restart the enrollment process

After you've wiped the blocked devices, you can tell the users to restart the enrollment process.

### Profile Installation Failed. A Network Error Has Occurred.

**Cause:** There's an unspecified problem with iOS/iPadOS on the device.

#### Resolution

1. To prevent data loss in the following steps (restoring iOS/iPadOS deletes all data on the device), make sure to back up your data.
2. Put the device in recovery mode and then restore it. Make sure that you set it up as a new device. For more information about how to restore iOS/iPadOS devices, see [https://support.apple.com/HT201263](https://support.apple.com/HT201263).
3. Re-enroll the device.

### Profile Installation Failed. Connection to the server could not be established.

**Cause:** Your Intune tenant is configured to only allow corporate-owned devices. 

#### Resolution
1. Sign in to the Azure portal.
2. Select **More Services**, search for Intune, and then select **Intune**.
3. Select **Device enrollment** > **Enrollment restrictions**.
4. Under **Device Type Restrictions**, select the restriction that you want to set > **Properties** > **Select platforms** > select **Allow** for **iOS**, and then click **OK**.
5. Select **Configure platforms**, select **Allow** for personally owned iOS/iPadOS devices, and then click **OK**.
6. Re-enroll the device.

**Cause:** You enroll a device that was previously enrolled with a different user account, and the previous user was not appropriately removed from Intune.

#### Resolution
1. Cancel any current profile installation.
2. Open [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com) in Safari.
3. Re-enroll the device.

> [!NOTE]
> If enrollment still fails, remove cookies in Safari (don't block cookies), then re-enroll the device.

**Cause:** The device is already enrolled with another MDM provider.

#### Resolution
1. Open **Settings** on the iOS/iPadOS device, go to **General > Device Management**.
2. Remove any existing management profile.
3. Re-enroll the device.

**Cause:** The user who is trying to enroll the device does not have a Microsoft Intune license.

#### Resolution
1. Go to the [Microsoft 365 Admin Center](https://admin.microsoft.com), and then choose **Users > Active Users**.
2. Select the user account that you want to assign an Intune user license to, and then choose **Product licenses > Edit**.
3. Switch the toggle to the **On** position for the license that you want to assign to this user, and then choose **Save**.
4. Re-enroll the device.

### This Service is not supported. No Enrollment Policy.

**Cause**: An Apple MDM push certificate isn't configured in Intune, or the certificate is invalid. 

#### Resolution

- If the MDM push certificate isn't configured, follow the steps in [Get an Apple MDM push certificate](/mem/intune/enrollment/apple-mdm-push-certificate-get#steps-to-get-your-certificate).
- If the MDM push certificate is invalid, follow the steps in [Renew Apple MDM push certificate](/mem/intune/enrollment/apple-mdm-push-certificate-get#renew-apple-mdm-push-certificate).

### Company Portal Temporarily Unavailable. The Company Portal app encountered a problem. If the problem persists, contact your system administrator.

**Cause:** The Company Portal app is out of date or corrupted.

#### Resolution
1. Remove the Company Portal app from the device.
2. Download and install the **Microsoft Intune Company Portal** app from **App Store**.
3. Re-enroll the device.

> [!NOTE]
> This error can also occur if the user is attempting to enroll more devices than device enrollment is configured to allow. Follow the resolutions steps for **Device Cap Reached** below if these steps do not resolve the issue.

### Device Cap Reached

**Cause:** The user tries to enroll more devices than the device enrollment limit.

#### Resolution
1. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **All Devices**, and check the number of devices the user has enrolled.
    > [!NOTE]
    > You should also have the affected user logon to the [Intune user portal](https://portal.manage.microsoft.com/) and check devices that have enrolled. There may be devices that appear in the [Intune user portal](https://portal.manage.microsoft.com/) but not in the [Intune admin portal](https://portal.azure.com/?Microsoft_Intune=1&Microsoft_Intune_DeviceSettings=true&Microsoft_Intune_Enrollment=true&Microsoft_Intune_Apps=true&Microsoft_Intune_Devices=true#blade/Microsoft_Intune_DeviceSettings/ExtensionLandingBlade/overview), such devices also count toward the device enrollment limit.
2. In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **Enrollment restrictions** > check the device enrollment limit. By default, the limit is set to 15. 
3. If the number of devices enrolled has reached the limit, remove unnecessary devices, or increase the device enrollment limit. Because every enrolled device consumes an Intune license, we recommend that you always remove unnecessary devices first.
4. Re-enroll the device.

### Workplace Join failed

**Cause:** The Company Portal app is out of date or corrupted.  

#### Resolution
1. Remove the Company Portal app from the device.
2. Download and install the **Microsoft Intune Company Portal** app from **App Store**.
3. Re-enroll the device.

### User License Type Invalid

**Cause:** The user who is trying to enroll the device does not have a valid Intune license.

#### Resolution
1. Go to the [Microsoft 365 admin center](https://admin.microsoft.com), and then choose **Users** > **Active Users**.
2. Select the affected user account > **Product licenses** > **Edit**.
3. Verify that a valid Intune license is assigned to this user.
4. Re-enroll the device.

### User Name Not Recognized. This user account is not authorized to use Microsoft Intune. Contact your system administrator if you think you have received this message in error.

**Cause:** The user who is trying to enroll the device does not have a valid Intune license.

1. Go to the [Microsoft 365 admin center](https://admin.microsoft.com), and then choose **Users** > **Active Users**.
2. Select the affected user account, and then choose **Product licenses** > **Edit**.
3. Verify that a valid Intune license is assigned to this user.
4. Re-enroll the device.

### Profile Installation Failed. The new MDM payload does not match the old payload.

**Cause:** A management profile is already installed on the device.

#### Resolution

1. Open **Settings** on the iOS/iPadOS device > **General** > **Device Management**.
2. Tap the existing management profile, and tap **Remove Management**.
3. Re-enroll the device.

### NoEnrollmentPolicy

**Cause:** The Apple Push Notification Service (APNs) certificate is missing, invalid, or expired.

#### Resolution
Verify that a valid APNs certificate is added to Intune. For more information, see [Set up iOS/iPadOS enrollment](/mem/intune/enrollment/ios-enroll).

### AccountNotOnboarded

**Cause:** There's a problem with the Apple Push Notification service (APNs) certificate configured in Intune.

#### Resolution
Renew the APNs certificate, and then re-enroll the device.

> [!IMPORTANT]
> Make sure that you renew the APNs certificate. Don't replace the APNs certificate. If you replace the certificate, you have to re-enroll all iOS/iPadOS devices in Intune.

- To renew the APNs certificate in Intune standalone, see [Renew Apple MDM push certificate](/mem/intune/enrollment/apple-mdm-push-certificate-get#renew-apple-mdm-push-certificate).
- To renew the APNs certificate in Microsoft 365, see [Create an APNs Certificate for iOS/iPadOS devices](https://support.office.com/article/Create-an-APNs-Certificate-for-iOS-devices-522b43f4-a2ff-46f6-962a-dd4f47e546a7).

### XPC_TYPE_ERROR Connection invalid

When you turn on a ADE-managed device that is assigned an enrollment profile, enrollment fails, and you receive the following error message:

```output
asciidoc
mobileassetd[83] <Notice>: 0x1a49aebc0 Client connection: XPC_TYPE_ERROR Connection invalid <error: 0x1a49aebc0> { count = 1, transaction: 0, voucher = 0x0, contents = "XPCErrorDescription" => <string: 0x1a49aee18> { length = 18, contents = "Connection invalid" } }
iPhone mobileassetd[83] <Notice>: Client connection invalid (Connection invalid); terminating connection
iPhone com.apple.accessibility.AccessibilityUIServer(MobileAsset)[288] <Notice>: [MobileAssetError:29] Unable to copy asset information from https://mesu.apple.com/assets/ for asset type com.apple.MobileAsset.VoiceServices.CombinedVocalizerVoices
iPhone mobileassetd[83] <Notice>: 0x1a49aebc0 Client connection: XPC_TYPE_ERROR Connection invalid <error: 0x1a49aebc0> { count = 1, transaction: 0, voucher = 0x0, contents = "XPCErrorDescription" => <string: 0x1a49aee18> { length = 18, contents = "Connection invalid" }
```

**Cause:** There's a connection issue between the device and the Apple ADE service.

#### Resolution
Fix the connection issue, or use a different network connection to enroll the device. You may also have to contact Apple if the issue persists.

### The configuration for your iPhone/iPad could not be downloaded from \<Company Name>: Invalid Profile.

**Cause:** The enrollment is blocked by a device type restriction.

#### Resolution

1. Sign in to the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431) > **Devices** > **Enroll devices** > **Enrollment restrictions**.
2. Under **Device type restrictions**, select **All Users** > **Properties**.
3. Select **Edit** next to the **Platform settings**.
4. On the **Edit restriction** page, select **Allow** for **iOS/iPadOS** and proceed to the **Review + save** page, then select **Save**.

## Sync token errors between Intune and ADE (DEP)

This section includes token sync errors with:

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

## Other issues

### ADE enrollment doesn't start
When you turn on a ADE-managed device that is assigned an enrollment profile, the Intune enrollment process isn't initiated.

**Cause:** The enrollment profile is created before the ADE token is uploaded to Intune.

#### Resolution

1. Edit the enrollment profile. You can make any change to the profile. The purpose is to update the modification time of the profile.
2. Synchronize ADE-managed devices: In the [Microsoft Endpoint Manager admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **iOS** > **iOS enrollment** > **Enrollment program tokens** > choose a token > **Sync now**. A sync request is sent to Apple.

### ADE enrollment stuck at user login
When you turn on a ADE-managed device that is assigned an enrollment profile, the initial setup sticks after you enter credentials.

**Cause:** Multi-Factor authentication (MFA) is enabled. Currently MFA doesn't work during enrollment on ADE devices.

#### Resolution
Disable MFA, and then re-enroll the device.

### Authentication doesn’t redirect to the government cloud 

Government users signing in from another device are redirected to the public cloud for authentication rather than the government cloud. 

**Cause:** Azure AD does not yet support redirecting to the government cloud when signing in from another device. 

#### Resolution 
Use the iOS Company Portal **Cloud** setting in the **Settings** app to redirect government users’ authentication towards the government cloud. By default, the **Cloud** setting is set to **Automatic** and Company Portal directs authentication towards the cloud that is automatically detected by the device (such as Public or Government). Government users who are signing in from another device will need to manually select the government cloud for authentication. 

Open the **Settings** app and select Company Portal. In the Company Portal settings, select **Cloud**. Set the **Cloud** to Government.

- [Overall Token Sync errors](https://developer.apple.com/documentation/devicemanagement/device_assignment/authenticating_with_a_device_enrollment_program_dep_server/interpreting_error_codes)
- [Profile creation errors](https://developer.apple.com/documentation/devicemanagement/define_a_profile)
