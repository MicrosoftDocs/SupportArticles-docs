---
title: Troubleshoot device enrollment in Intune
description: Suggestions for troubleshooting device enrollment issues in Microsoft Intune.
ms.date: 12/05/2023
ms.reviewer: kaushika, damionw
search.appverid: MET150
ms.custom: sap:Enroll Device - Windows\Advisory
---
# Troubleshooting device enrollment in Intune

This article provides suggestions for troubleshooting [device enrollment](/mem/intune/enrollment/device-enrollment) issues in Microsoft Intune. Browse other sections of this guide for OS-specific enrollment troubleshooting.

## Initial troubleshooting steps

Before you start troubleshooting, check to make sure that you've configured Intune properly to enable enrollment. You can read about those configuration requirements in our documentation:

- [Set up Intune](/mem/intune/fundamentals/setup-steps)
- [Enroll iOS/iPadOS devices in Intune](/mem/intune/enrollment/ios-enroll)
- [Set up enrollment for macOS devices in Intune](/mem/intune/enrollment/macos-enroll)
- [Set up enrollment for Windows devices in Intune](/mem/intune/enrollment/windows-enroll)
- [Enroll Android devices in Intune](/mem/intune/enrollment/android-enroll) - No additional steps required

### Collect basic information

It's important to collect some basic information to help better understand the problem and reduce the time to find a resolution.

Collect the following information about the problem:

- What is the exact error message?
- Where do you see the error message?
- When did the problem start? Has enrollment ever worked?
- What platform (Android, iOS/iPadOS, Windows) has the problem?
- How many users are affected? Are all users affected or just some?
- How many devices are affected? Are all devices affected or just some?
- What is the MDM authority?
- How is enrollment being performed? For example, is it "Bring your own device" (BYOD) or Apple Automated Device Enrollment (ADE) with enrollment profiles?

### Collect diagnostic logs

Your managed device users can collect enrollment and diagnostic logs for you to review. User instructions for collecting logs are provided in:

- [Send Android enrollment errors to your IT admin](/mem/intune/user-help/send-logs-to-your-it-admin-using-cable-android)
- [Send iOS/iPadOS errors to your IT admin](/mem/intune/user-help/send-errors-to-your-it-admin-ios)

### Check device date and time

You can also make sure that the date and time on the user's device are set correctly:

1. Restart the device.
1. Make sure that the date and time are set close to GMT standards (+ or - 12 hours) for the end user's time zone.
1. Uninstall and reinstall the Intune company portal (if applicable).

## Device cap reached

A user receives an error during enrollment, such as "DeviceCapReached" or a general message such as "Company Portal Temporarily Unavailable".

**Cause:** This error indicates that a user is trying to enroll more devices than the device enrollment limit.

**Solution:** Check and adjust number of devices enrolled and allowed. Use these steps to make sure the user isn't assigned more than the maximum number of devices.

1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Devices** > **Enrollment restrictions** > **Device limit restrictions**. Note the value in the **Device limit** column.
1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), choose **Users** > **All users** > select the user > **Devices**. Note the number of devices the user has enrolled.
1. If the user's number of enrolled devices already equals their device limit restriction, they can't enroll anymore until:
    - [Existing devices are removed](/mem/intune/remote-actions/devices-wipe), or
    - You increase the device limit by [setting device restrictions](/mem/intune/enrollment/enrollment-restrictions-set).

To avoid hitting device caps, be sure to remove stale device records.

> [!NOTE]
>
> You can avoid the device enrollment cap by using Device Enrollment Manager account, as described in [Enroll corporate-owned devices with the Device Enrollment Manager in Microsoft Intune](/mem/intune/enrollment/device-enrollment-manager-enroll).
>
> A user account that is added to Device Enrollment Managers account will not be able to complete enrollment when Conditional Access policy is enforced for that specific user login.

## Company Portal Temporarily Unavailable

Users receive a **Company Portal Temporarily Unavailable** error on their device.

**Cause:** The Company Portal app on the device is out of date or corrupted.

**Solution:**

1. Remove the Intune Company Portal app from the device.
1. On the device, open the browser, browse to [https://portal.manage.microsoft.com](https://portal.manage.microsoft.com), and try a user login.
1. If the user fails to sign in, they should try another network.
1. If that fails, validate that the user's credentials have synced correctly with Microsoft Entra ID.
1. If the user successfully logs in, an iOS/iPadOS device will prompt you to install the Intune Company Portal app and enroll. On an Android device, you'll need to manually install the Intune Company Portal app, after which you can retry enrolling.

> [!NOTE]
> This error can also occur if the user is attempting to enroll more devices than device enrollment is configured to allow. If these steps do not resolve the issue, follow the solution steps for [Device cap reached](#device-cap-reached).

## MDM authority not defined

A user receives an "MDM authority not defined" error.

**Cause:**  Either the MDM Authority has not been set or there is a user credential issue.

**Solution:**

1. Verify that the MDM Authority has been [set appropriately](/mem/intune/fundamentals/mdm-authority-set).
1. Verify that the user's credentials have synced correctly with Microsoft Entra ID. You can verify that the user's UPN matches the Active Directory information in the Microsoft 365 admin center.
    If the UPN doesn't match the Active Directory information:

    1. Turn off DirSync on the local server.
    1. Delete the mismatched user from the **Intune Account Portal** user list.
    1. Wait about one hour to allow the Azure service to remove the incorrect data.
    1. Turn on DirSync again and check if the user is now synced properly.

## Unable to create policy or enroll devices if the company name contains special characters

You can't create policy or enroll devices.

**Solution:** In the [Microsoft 365 admin center](https://admin.microsoft.com/), remove the special characters from the company name and save the company information.

## Unable to sign in or enroll devices when you have multiple verified domains

This problem may occur when you add a second verified domain to your Active Directory Federation Services  (AD FS). Users with the user principal name (UPN) suffix of the second domain may not be able to log into the portals or enroll devices.

**Solution:** Microsoft 365 customers are required to deploy a separate instance of the AD FS 2.0 Federation Service for each suffix if they:

- use single sign-on (SSO) through AD FS 2.0, and
- have multiple top-level domains for users' UPN suffixes within their organization (for example, @contoso.com or @fabrikam.com).

A [rollup for AD FS 2.0](https://support.microsoft.com/help/2607496) works in conjunction with the `SupportMultipleDomain` switch to enable the AD FS server to support this scenario without requiring additional AD FS 2.0 servers. For more information, see [this blog](/archive/blogs/abizerh/supportmultipledomain-switch-when-managing-sso-to-office-365).

## Profile installation failed

**Issue:** A user receives a "Profile installation failed" error.

**Solution:**

1. Confirm that the user is assigned an appropriate license for the version of the Intune service that you're using.
1. Confirm that the device isn't already enrolled with another MDM provider.
1. Confirm that the device doesn't already have a management profile installed.
1. For iOS/iPadOS devices, confirm that Safari is the default browser and that cookies are enabled. For Android devices, confirm that Chrome is the default browser and that cookies are enabled.

## IT admin needs to assign license for access

Users see the message "Your IT admin hasn't given you access to use this app. Get help from your IT admin or try again later."

**Cause:** The device can't be enrolled because the user's account doesn't have the necessary license. The user is either missing a license or has the wrong license type for the MDM authority. For example, they'll see this error if both of the following are true:

- Intune has been set as the mobile device management authority.
- They're using a System Center 2012 R2 Configuration Manager license.

**Solution:**
Assign the appropriate license to the user. For more information, see [Assign Intune licenses to your user accounts](/mem/intune/fundamentals/licenses-assign).

## IT admin needs to set MDM authority

Users see the message "Looks like your IT admin hasn't set an MDM authority. Get help from your IT admin or try again later."

**Cause:** The mobile device management authority hasn't been defined in Intune.

**Solution:** [Set the mobile device management authority](/mem/intune/fundamentals/mdm-authority-set).|

## Enrollment error codes

|Error code|Possible problem|Suggested resolution|
|--------------|--------------------|----------------------------------------|
|0x80CF0437 |The clock on the client computer isn't set to the correct time.|Make sure that the clock and the time zone on the client computer are set to the correct time and time zone.|
|0x80240438, 0x80CF0438, 0x80CF402C|can't connect to the Intune service. Check the client proxy settings.|Verify that Intune supports the proxy configuration on the client computer. Verify that the client computer has Internet access.|
|0x80240438, 0x80CF0438|Proxy settings in Internet Explorer and Local System aren't configured.|can't connect to the Intune service. Check the client proxy settings. Verify that Intune supports the proxy configuration on the client computer. Verify that the client computer has Internet access.|
|0x80043001, 0x80CF3001, 0x80043004, 0x80CF3004|Enrollment package is out of date.|Download and install the current client software package from the Administration workspace.|
|0x80043002, 0x80CF3002|Account is in maintenance mode.|You can't enroll new client computers when the account is in maintenance mode. To view your account settings, sign in to your account.|
|0x80043003, 0x80CF3003|Account is deleted.|Verify that your account and subscription to Intune is still active. To view your account settings, sign in to your account.|
|0x80043005, 0x80CF3005|The client computer has been retired.|Wait a few hours, remove any older versions of the client software from the computer, and then retry the client software installation.|
|0x80043006, 0x80CF3006|The maximum number of seats allowed for the account has been reached.|Your organization must buy additional seats before you can enroll more client computers in the service.|
|0x80043007, 0x80CF3007|Couldn't find the certificate file in the same folder as the installer program.|Extract all files before you start the installation. Do not rename or move any of the extracted files: all files must exist in the same folder or the installation will fail.|
|0x8024D015, 0x00240005, 0x80070BC2, 0x80070BC9, 0x80CFD015|The software can't be installed because a restart of the client computer is pending.|Restart the computer and then retry the client software installation.|
|0x80070032|One or more prerequisites for installing the client software weren't found on the client computer.|Make sure that all required updates are installed on the client computer and then retry the client software installation.|
|0x80043008, 0x80CF3008|Failed to start the Microsoft Online Management Updates service.|Contact Microsoft Support as described in [How to get support in Microsoft Intune](/mem/get-support).|
|0x80043009, 0x80CF3009|The client computer is already enrolled into the service.|You must retire the client computer before you can re-enroll it in the service.|
|0x8004300B, 0x80CF300B|The client software installation package can't run because the version of Windows that is running on the client isn't supported.|Intune doesn't support the version of Windows that is running on the client computer.|
|0xAB2|The Windows Installer couldn't access VBScript run time for a custom action.|This error is caused by a custom action that is based on Dynamic-Link Libraries (DLLs).|
|0x80cf0440|The connection to the service endpoint terminated.|Trial or paid account is suspended. Create a new trial or paid account and re-enroll.|
