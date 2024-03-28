---
title: Troubleshoot and review Wi-Fi device configuration profiles in Intune
description: Understand and troubleshoot Wi-Fi device configuration profile issues on Android, iOS/iPadOS, and Windows devices in Microsoft Intune. Review logs, and see some common issues and possible resolutions.
ms.date: 12/05/2023
ms.reviewer: kaushika, tycast
search.appverid: MET150
ms.custom: sap:Configure Devices - iOS\Wi-Fi settings
---
# Troubleshooting Wi-Fi device configuration profiles in Microsoft Intune

In Intune, you can create device configuration profiles that include connection settings for your WiFi network. Use these settings to connect users' Android, iOS/iPadOS, and Windows devices to the organization network.

This article shows what a Wi-Fi profile looks like when it successfully applies to devices. It also includes log information, common issues, and more. Use this article to help troubleshoot your Wi-Fi profiles.

For more information on Wi-Fi profiles in Intune, see [Add and use Wi-Fi settings on your devices](/mem/intune/configuration/wi-fi-settings-configure).

> [!NOTE]
> The examples in this article use SCEP certificate authentication for the Intune profiles. It also assumes that the Trusted Root and SCEP profiles work correctly on the device.

## Troubleshoot Android Wi-Fi profiles

In this section, we step through the user experience when installing configuration profiles on an Android device. This scenario uses a Nokia 6.1 device. Before the Wi-Fi profile is installed on the device, install the Trusted Root and SCEP profiles.

1. Users receive a notification to install the Trusted Root certificate profile:

    :::image type="content" source="media/troubleshoot-wi-fi-profiles/android-end-user-company-portal-trusted-root.png" alt-text="Screenshot of a notification to install Trusted Root certificate profile.":::

2. The next notification prompts to install the SCEP certificate profile:

    :::image type="content" source="media/troubleshoot-wi-fi-profiles/android-end-user-company-portal-scep-certificate.png" alt-text="Screenshot of a sample Company Portal app notification on Android to install SCEP certificate profile.":::

    > [!TIP]
    > When using a device administrator-managed Android device, there may be multiple certificates listed. When a certificate profile is revoked or removed, the certificate stays on the device. In this scenario, select the newest certificate. It's usually the last certificate shown in the list.
    >
    > This situation doesn't occur on Android Enterprise and Samsung Knox devices. For more information, see [Manage Android work profile devices](/mem/intune/enrollment/android-enterprise-overview) and [Remove SCEP and PKCS certificates](/mem/intune/protect/remove-certificates#android-knox-devices).

3. Next, users receive a notification to install the Wi-Fi profile:

    :::image type="content" source="media/troubleshoot-wi-fi-profiles/android-end-user-install-wifi-profile.png" alt-text="Screenshot of a notification to install the Wi-Fi profile.":::

4. When complete, the Wi-Fi connection is shown as a saved network:

    :::image type="content" source="media/troubleshoot-wi-fi-profiles/android-end-user-saved-networks.png" alt-text="Screenshot of a Wi-Fi connection that's shown as a saved network.":::

### Review Company Portal app logs

On Android, the **Omadmlog.log** file details the activities of the Wi-Fi profile when it's installed on the device. You might have up to five Omadmlog log files. Be sure to get the timestamp of the last sync, as it will help you find the related log entries.

In the following example, use [CMTrace](/mem/configmgr/core/support/cmtrace) to read the logs, and search for "wifimgr":

:::image type="content" source="media/troubleshoot-wi-fi-profiles/android-cmtrace-filter-wifimgr.png" alt-text="Screenshot shows wifimgr is searched in Filter Settings.":::

The following log shows your search results, and shows the Wi-Fi profile successfully applied:

```log
2019-08-01T19:22:46.7340000    VERB    com.microsoft.omadm.platforms.android.wifimgr.WifiProfile    15118    04142    Starting to parse Wifi Profile XML with name '<profile ID>'.
2019-08-01T19:22:46.7490000    VERB    com.microsoft.omadm.platforms.android.wifimgr.OneX    15118    04142    Starting to parse OneX from Wifi XML.
2019-08-01T19:22:46.8100000    VERB    com.microsoft.omadm.platforms.android.wifimgr.OneX    15118    04142    Completed parsing OneX from Wifi XML.
2019-08-01T19:22:46.8209999    VERB    com.microsoft.omadm.platforms.android.wifimgr.WifiProfile    15118    04142    Completed parsing Wifi Profile XML with name '<profile ID>'.
2019-08-01T19:22:46.8240000    INFO    com.microsoft.omadm.utils.CertificateSelector    15118    04142    Selected ca certificate with alias: 'user:205xxxxx.0' and thumbprint '<thumbprint>'.
2019-08-01T19:22:47.0990000    VERB    com.microsoft.omadm.platforms.android.certmgr.CertificateChainBuilder    15118    04142    Complete certificate chain built with Complete certs.
2019-08-01T19:22:47.1010000    VERB    com.microsoft.omadm.utils.CertUtils    15118    04142    1 cert(s) matched criteria: User<ID>[i:<ID>,17CECEA1D337FAA7D167AD83A8CC7A8FCBF9xxxx;eku:1.3.6.1.5.5.7.3.1,1.3.6.1.5.5.7.3.2]
2019-08-01T19:22:47.1090000    VERB    com.microsoft.omadm.utils.CertUtils    15118    04142    0 cert(s) excluded by criteria:
2019-08-01T19:22:47.1110000    INFO    com.microsoft.omadm.utils.CertificateSelector    15118    04142    Selected client cert with alias 'User<ID>' and requestId 'ModelName=<ModelName>%2FLogicalName_<LogicalName>;Hash=-912418295'.
2019-08-01T19:22:47.4120000    VERB    com.microsoft.omadm.Services    15118    04142    Successfully applied, enabled and saved wifi profile '<profile ID>'
2019-08-01T19:22:47.4240000    VERB    com.microsoft.omadm.platforms.android.wifimgr.OneX    15118    04142    Starting to parse OneX from Wifi XML.
2019-08-01T19:22:47.4910000    VERB    com.microsoft.omadm.platforms.android.wifimgr.OneX    15118    04142    Completed parsing OneX from Wifi XML.
2019-08-01T19:22:47.4970000    VERB    com.microsoft.omadm.platforms.android.wifimgr.WifiProfile    15118    04142    Starting to parse Wifi Profile XML with name '<profile ID>'.
2019-08-01T19:22:47.5080000    VERB    com.microsoft.omadm.platforms.android.wifimgr.OneX    15118    04142    Starting to parse OneX from Wifi XML.
2019-08-01T19:22:47.5820000    VERB    com.microsoft.omadm.platforms.android.wifimgr.OneX    15118    04142    Completed parsing OneX from Wifi XML.
2019-08-01T19:22:47.5900000    VERB    com.microsoft.omadm.platforms.android.wifimgr.WifiProfile    15118    04142    Completed parsing Wifi Profile XML with name '<profile ID>'.
2019-08-01T19:22:47.5910000    INFO    com.microsoft.omadm.platforms.android.wifimgr.WifiProfileManager    15118    04142    Applied profile <profile ID>

```

## Troubleshoot iOS/iPadOS Wi-Fi profiles

After the Wi-Fi profile is installed on the device, it's shown in the **Management Profile**:

:::image type="content" source="media/troubleshoot-wi-fi-profiles/ios-management-profile.png" alt-text="Screenshot of Management Profile on iOS/iPadOS device in Intune.":::

:::image type="content" source="media/troubleshoot-wi-fi-profiles/ios-wifi-connection-in-management-profile.png" alt-text="Screenshot of Wi-Fi connection that shows as a Wi-Fi network on iOS/iPadOS device in Intune.":::

### Review the iOS/iPadOS console and device logs

On iOS/iPadOS devices, the Company Portal app log doesn't include information about Wi-Fi profiles. To see installation details of your Wi-Fi profiles, use the Console/Device Logs:

1. Connect the iOS/iPadOS device to Mac. Go to **Applications** > **Utilities**, and open the Console app.
2. Under **Action**, select **Include Info Messages** and **Include Debug Messages**:

    :::image type="content" source="media/troubleshoot-wi-fi-profiles/ios-console-app-include-info-debug-messages.png" alt-text="Screenshot of the Include Info Messages and Include Debug Messages options in iOS/iPadOS console app.":::

3. Reproduce the scenario, and save the logs to a text file:

    1. Select all the messages on the current screen: **Edit** > **Select All**.
    2. Copy the messages: **Edit** > **Copy**.
    3. Paste the log data in a text editor, and save the file.

4. Search the saved log file to see detailed information. When the profile successfully installs, your output looks similar to the following log:

    ```log
    Line 390870: debug    11:19:58.994815 -0400    profiled    Adding dependent www.windowsintune.com.wifi.Contoso to parent Microsoft.Profiles.MDM in domain ManagingProfileToManagedProfile to system\
    Line 390872: debug    11:19:58.995210 -0400    profiled    Adding dependent Microsoft.Profiles.MDM to parent www.windowsintune.com.wifi.Contoso in domain ManagedProfileToManagingProfile to system\
    Line 392346: default    11:19:59.360460 -0400    profiled    Profile \'93www.windowsintune.com.wifi.Contoso\'94 installed.\
    ```

## Troubleshoot Windows Wi-Fi profiles

After the Wi-Fi profile is installed on the device, go to **Settings** > **Accounts** > **Access work or school** > Select your account > **Info**:

:::image type="content" source="media/troubleshoot-wi-fi-profiles/windows-access-work-school-info.png" alt-text="Screenshot of the Access work or school pane. Info button is highlighted on Windows device.":::

In **Areas managed by Microsoft**, **WiFi** is shown:

:::image type="content" source="media/troubleshoot-wi-fi-profiles/windows-wifi-areas-managed-by-microsoft.png" alt-text="Screenshot of the Areas managed by Microsoft, where WiFi is listed on Windows.":::

To see the Wi-Fi connection, go to **Settings** > **Network & Internet**  > **Wi-Fi**:

:::image type="content" source="media/troubleshoot-wi-fi-profiles/windows-wifi-connection-known-networks.png" alt-text="Screenshot of the Wi-Fi settings on Windows, where the Wi-Fi connection is a known network.":::

### Review event viewer logs

On Windows devices, the details about Wi-Fi profiles are logged in the Event Viewer:

1. Open the **Event Viewer** app.
2. On the **View** menu, select **Show Analytic and Debug Logs**.
3. Expand **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider** > **Admin**

Your output similar to the following logs:

```log
Log Name:      Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin
Source:        Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider
Date:          8/7/2019 8:01:41 PM
Event ID:      1506
Task Category: (1)
Level:         Information
Keywords:      (2)
User:          SYSTEM
Computer:      <Computer Name>
Description:
WiFiConfigurationServiceProvider: Node set value, type: (0x4), Result: (The operation completed successfully.).
```

## Common issues

This section provides troubleshooting guidance for the following scenarios:

- [The Wi-Fi profile isn't deployed to the device](#the-wi-fi-profile-isnt-deployed-to-the-device)
- [The Wi-Fi profile is deployed to the device, but the device can't connect to the network](#the-wi-fi-profile-is-deployed-to-the-device-but-the-device-cant-connect-to-the-network)
- [Users don't get new profile after changing password on existing profile](#users-dont-get-new-profile-after-changing-password-on-existing-profile)
- [All Wi-Fi profiles report as failing](#all-wi-fi-profiles-report-as-failing)
- [A Wi-Fi profile reports as failing, but seems to be working](#a-wi-fi-profile-reports-as-failing-but-seems-to-be-working)

### The Wi-Fi profile isn't deployed to the device

- Confirm the Wi-Fi profile is assigned to the correct group:

    1. In the [Microsoft Intune admin center](https://go.microsoft.com/fwlink/?linkid=2109431), select **Devices** > **Configuration profiles**.
    2. Select your profile > **Assignments**. Confirm the selected groups are correct.
    3. In the Intune, select **Troubleshooting + Support**. Review the **Assignments** information.

- In the Intune, select **Troubleshooting + Support**. Confirm the device can sync with Intune by checking the **Last check in** time.

- If the Wi-Fi profile is linked to the Trusted Root and SCEP profiles, confirm both profiles are deployed to the device. The Wi-Fi profile has a dependency on these profiles.

- On Windows 10 and newer devices, review the MDM Diagnostic Information log:

  1. Go to **Settings** > **Accounts** > **Access work or school**.
  2. Select your work or school account > **Info**.
  3. At the bottom of the **Settings** page, select **Create report**.
  4. A window opens that shows the path to the log files. Select **Export**.
  5. Go to the `\Users\Public\Documents\MDMDiagnostics` path, and view the report:

  > [!TIP]
  > For more information, see [Diagnose MDM failures in Windows 10](/windows/client-management/mdm/diagnose-mdm-failures-in-windows-10).

- On Android devices, if the Trusted Root and SCEP profiles aren't installed on the device, you see the following entry in the Company Portal app Omadmlog file:

  ``` log
  2019-08-01T19:18:13.5120000    INFO    com.microsoft.omadm.platforms.android.wifimgr.WifiProfileManager    15118    04105    Skipping Wifi profile <profile ID> because it is pending certificates.
  ```

  - When the Trusted Root and SCEP profiles are on the Android device and compliant, the Wi-Fi profile might not be on the device. This issue happens when the **CertificateSelector** provider from the Company Portal app doesn't find a certificate that matches the specified criteria. The specific criteria can be in the Certificate Template or in the SCEP profile.

    If the matching certificate isn't found, the certificates on the device aren't installed. The Wi-Fi profile isn't applied because it doesn't have the correct certificate. In this scenario, you see the following entry in the Company Portal app Omadmlog file:

    `Skipping Wifi profile <profile ID> because it is pending certificates.`

    The following sample log shows certificates being excluded because the **Any Purpose** Extended Key Usage (EKU) criteria was specified. But, the certificates assigned to the device don't have that EKU:

    ```log
    2018-11-27T21:10:37.6390000    VERB     com.microsoft.omadm.utils.CertUtils      14210    00948    Excluding cert with alias User<ID1> and requestId <requestID1> as it does not have any purpose EKU.
    2018-11-27T21:10:37.6400000    VERB     com.microsoft.omadm.utils.CertUtils      14210    00948    Excluding cert with alias User<ID2> and requestId <requestID2> as it does not have any purpose EKU.
    2018-11-27T21:10:37.6400000    VERB     com.microsoft.omadm.utils.CertUtils      14210    00948    0 cert(s) matched criteria:
    2018-11-27T21:10:37.6400000    VERB     com.microsoft.omadm.utils.CertUtils      14210    00948    2 cert(s) excluded by criteria:
    2018-11-27T21:10:37.6400000    INFO       com.microsoft.omadm.platforms.android.wifimgr.WifiProfileManager       14210                00948     Skipping Wifi profile <profile ID> because it is pending certificates.
    ```

    The following sample shows the SCEP profile entered the **Any Purpose** EKU. But, it's not entered in the Certificate Template on the certificate authority (CA). To fix the issue, add the **Any Purpose** option to the certificate template. Or, remove the **Any Purpose** option from the SCEP profile.

    :::image type="content" source="media/troubleshoot-wi-fi-profiles/android-add-any-purpose-eku.png" alt-text="Screenshot shows steps to add Any Purpose to certificate template on the certificate authority." lightbox="media/troubleshoot-wi-fi-profiles/android-add-any-purpose-eku.png":::

    :::image type="content" source="media/troubleshoot-wi-fi-profiles/android-any-purpose-scep-device-config-profile.png" alt-text="Screenshot shows adding Any Purpose to SCEP certificate configuration profile in Intune." lightbox="media/troubleshoot-wi-fi-profiles/android-any-purpose-scep-device-config-profile.png":::

  - Confirm that all required certificates in the complete certificate chain are on the Android device. Otherwise, the Wi-Fi profile can't be installed on the device. For more information, see [Missing intermediate certificate authority](https://developer.android.com/training/articles/security-ssl#MissingCa) (opens Android's web site).
  - Filter Omadmlog with keywords to look for information, such as which certificate is used in the Wi-Fi profile, and if the profile successfully applied.

    For example, use [CMTrace](/mem/configmgr/core/support/cmtrace) to read the logs. Use the search string to filter "wifimgr":

    :::image type="content" source="media/troubleshoot-wi-fi-profiles/cmtrace-filter-wifimgr.png" alt-text="Screenshot shows filtering CMTrace to look for WiFiMgr configuration profiles on Android devices.":::

    The output looks similar to the following log:

    :::image type="content" source="media/troubleshoot-wi-fi-profiles/cmtrace-sample-log-output.png" alt-text="Screenshot of a sample CMTrace log output that shows WiFi Intune configuration profile successfully applied on devices." lightbox="media/troubleshoot-wi-fi-profiles/cmtrace-sample-log-output.png":::

    If you see an error in the log, copy the time stamp of the error and unfilter the log. Then, use the "find" option with the time stamp to see what happened right before the error.

### The Wi-Fi profile is deployed to the device, but the device can't connect to the network

Typically, this issue is caused by something outside of Intune. The following tasks may help you understand and troubleshoot connectivity issues:

- Manually connect to the network using a certificate with the same criteria that's in the Wi-Fi profile.

  If you can connect, look at the certificate properties in the manual connection. Then, update the Intune Wi-Fi profile with the same certificate properties.
- Connectivity errors are usually logged in the Radius server log. For example, it should show if the device tried to connect with the Wi-Fi profile.

### Users don't get new profile after changing password on existing profile

You create a corporate Wi-Fi profile, deploy the profile to a group, change the password, and save the profile. When the profile changes, some users may not get the new profile.

To mitigate this issue, set up guest Wi-Fi. If the corporate Wi-Fi fails, users can connect to the guest Wi-Fi. Be sure to enable any automatically connect settings. Deploy the guest Wi-Fi profile to all users.

Some additional recommendations:  

- If the Wi-Fi network you're connecting to uses a password or passphrase, make sure you can connect to the Wi-Fi router directly. You can test with an iOS/iPadOS device.
- After you successfully connect to the Wi-Fi endpoint (Wi-Fi router), note the SSID and the credential used (this value is the password or passphrase).
- Enter the SSID and credential (password or passphrase) in the Pre-Shared Key field.
- Deploy to a test group that has limited number of users, preferably only the IT team.
- Sync your iOS/iPadOS device to Intune. Enroll if you haven't already enrolled.
- Test connecting to the same Wi-Fi endpoint (as mentioned in the first step) again.
- Roll out to larger groups and eventually to all expected users in your organization.

### All Wi-Fi profiles report as failing

For Android Enterprise fully managed, dedicated, and corporate-owned work profile devices, you might get a report that all profiles have failed. This can occur when you deploy more than one Wi-Fi profile. In this case, when one fails, all the profiles you deployed will report as failing (even if they are still working).

### A Wi-Fi profile reports as failing, but seems to be working

If a Wi-Fi profile is working correctly on an Android device, but reports as failing, it may be a reporting error. To fix this, update to the Intune app version 2021.05.02 or later.
