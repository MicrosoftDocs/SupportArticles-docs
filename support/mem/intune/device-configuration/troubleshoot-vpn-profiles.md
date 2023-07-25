---
title: Troubleshoot VPN profile issues
description: Understand and troubleshoot VPN profile issues on Android, iOS, and Windows devices in Microsoft Intune. Review logs and see some common issues and resolutions.
ms.date: 12/06/2022
ms.reviewer: jarrettr, v-six
---
# Troubleshooting VPN profile issues in Microsoft Intune

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4519426

## Introduction

This guide helps you understand and troubleshoot VPN profile issues that may occur when you use Microsoft Intune.

The examples in this guide use Simple Certificate Enrollment Protocol (SCEP) certificate authentication for profiles. The examples also assume that the Trusted Root and SCEP profiles work correctly on the device. In the examples, the Trusted Root and SCEP profiles are named as follows:

|Profile types|Android|iOS|Windows|
|-|-|-|-|
|Trusted Root profile|AndroidRoot|iOSRoot|WindowsRoot2|
|SCEP profile|AndroidSCEP|iOSSCEP|WindowsSCEP2|

## Overview of VPN profiles

Virtual private networks (VPNs) give users secure remote access to an organization's network. Devices use a VPN connection profile to start a connection with the VPN server. In Intune, VPN profiles assign VPN settings to users and devices in the organization. Then, the users can easily and securely connect to the organizational network.

For example, if you want to configure all iOS devices with the required settings to connect to a file share on the organization's network, you can create a VPN profile that includes these settings and assign this profile to all users who have iOS devices. After that, the users can see the VPN connection in the list of available networks and connect with minimal effort.

You can create VPN profiles by using different VPN connection types.

> [!NOTE]
> Before you can use VPN profiles assigned to a device, you must install the applicable VPN app for the profile.

## How to create VPN profiles

To create a VPN profile, follow the steps in [Create a device profile](/intune/vpn-settings-configure#create-a-device-profile).

For examples, see the following screenshots:

> [!NOTE]
> In the examples, the connection type for Android and iOS VPN profiles is Cisco AnyConnect, and the one for Windows 10 is Automatic. The VPN profile is linked to the SCEP profile.

### [Android (Personally owned work profile)](#tab/android)

:::image type="content" source="media/troubleshoot-vpn-profiles/create-vpn-profile-android.png" alt-text="Screenshot that shows how to create a VPN profile for Android.":::

### [iOS](#tab/ios)

:::image type="content" source="media/troubleshoot-vpn-profiles/create-vpn-profile-ios.png" alt-text="Screenshot that shows how to create a VPN profile for iOS.":::

### [Windows](#tab/windows)

:::image type="content" source="media/troubleshoot-vpn-profiles/create-vpn-profile-windows.png" alt-text="Screenshot that shows how to create a VPN profile for Windows.":::

For information about how to create an Extensible Authentication Protocol (EAP) configuration XML for the VPN profile, see [EAP configuration](/windows/client-management/mdm/eap-configuration).

---

## How to assign VPN profiles

After you create a VPN profile, [assign the profile](/intune/device-profile-assign#assign-a-device-profile) to selected groups.

> [!NOTE]
> Group-type deployment (user group or device group) is important, and it must be consistent across all the policies involving this resource policy (Trusted Certificates, SCEP, and VPN). It will depend on the type of certificate you're deploying. If you're deploying a user certificate, all the deployments should be to a user group and vice versa. If the certificate deployed is a device type one, use a device group.

For examples, see the following screenshot:

:::image type="content" source="media/troubleshoot-vpn-profiles/assign-vpn-profile.png" alt-text="Screenshot that shows how to assign a profile.":::

## What successful VPN profiles look like

### [Android](#tab/android)

This scenario uses an Android device enrolled as a Personally owned work profile. Since the Trusted Root and SCEP profiles are already installed on the device, you won't be prompted to install the SCEP certificates.

1. You receive a notification to install the corporate VPN profile:

    :::image type="content" source="media/troubleshoot-vpn-profiles/notification-install-vpn-profile-android.png" alt-text="Screenshot that shows the notification to install the VPN profile.":::

   If you don't receive the notification, tap the **Change Settings** button to enable the **External Control** option in the AnyConnect app. Then, you will receive the notification.

    :::image type="content" source="media/troubleshoot-vpn-profiles/change-settings-android.png" alt-text="Screenshot that shows the Change Settings button.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/external-control-setting.png" alt-text="Screenshot that shows the External Control option.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/external-control-setting-enabled.png" alt-text="Screenshot that shows that the External Control option is enabled.":::

1. Select the SCEP certificate in the AnyConnect app:

    :::image type="content" source="media/troubleshoot-vpn-profiles/choose-certificate.png" alt-text="Screenshot that shows the page to choose certificates.":::

    > [!NOTE]
    > When using a device administrator-managed Android device, there may be multiple certificates because the certificates aren't revoked or removed when a certificate profile is changed or removed. In this scenario, select the newest certificate. It's usually the last certificate displayed in the list.

    This situation doesn't occur on Android Enterprise and Samsung Knox devices. For more information, see [Manage Android work profile devices with Intune](/intune/android-enterprise-overview) and [Remove SCEP and PKCS certificates in Microsoft Intune](/intune/remove-certificates#android-knox-devices).

1. The VPN connection is successfully created.

    :::image type="content" source="media/troubleshoot-vpn-profiles/successfully-created-vpn-connection.png" alt-text="Screenshot that shows a VPN connection is created successfully.":::

### [iOS](#tab/ios)

After the VPN profile is installed on the device, it's displayed in **Management Profile**:

:::image type="content" source="media/troubleshoot-vpn-profiles/vpn-profile-management-profile.png" alt-text="Screenshot that shows that Management Profile has the VPN profile.":::

:::image type="content" source="media/troubleshoot-vpn-profiles/vpn-profile-setting-management-profile.png" alt-text="Screenshot that shows that the VPN profile is listed in Management Profile.":::

:::image type="content" source="media/troubleshoot-vpn-profiles/vpn-profile-service-name.png" alt-text="Screenshot that shows the service name of the VPN profile in Management Profile.":::

The VPN connection is displayed in **Settings** > **General** > **VPN**:

:::image type="content" source="media/troubleshoot-vpn-profiles/vpn-status-not-connected.png" alt-text="Screenshot that shows that the VPN status is Not Connected in iOS.":::

:::image type="content" source="media/troubleshoot-vpn-profiles/created-vpn-status-not-connected.png" alt-text="Screenshot that shows that the created VPN isn't connected.":::

The VPN connection is displayed in the AnyConnect app:

:::image type="content" source="media/troubleshoot-vpn-profiles/vpn-connection-anyconnect.png" alt-text="Screenshot that shows the VPN connection in the AnyConnect app.":::

### [Windows](#tab/windows)

After the VPN profile is installed on the device, select **Settings** > **Accounts** > **Access work or school**, then select the work or school account, and then select **Info**.

:::image type="content" source="media/troubleshoot-vpn-profiles/installed-vpn-profile-windows.png" alt-text="Screenshot that shows the installed VPN profile in Windows.":::

You can see **VPN** is listed under **Areas managed by Microsoft**.

:::image type="content" source="media/troubleshoot-vpn-profiles/areas-managed-by-microsoft-vpn.png" alt-text="Screenshot that shows the VPN under Areas managed by Microsoft.":::

The VPN profile is listed under **Settings** > **Network & Internet** > **VPN**.

:::image type="content" source="media/troubleshoot-vpn-profiles/vpn-profile-windows.png" alt-text="Screenshot that shows the VPN profile in Network & Internet.":::

The VPN connection is listed in **Network Connections**.

:::image type="content" source="media/troubleshoot-vpn-profiles/network-connections-vpn.png" alt-text="Screenshot that shows the VPN connection in Network Connections.":::

---

## Company Portal logs of successful VPN profile deployment

### [Android](#tab/android)

On an Android device, the *Omadmlog.log* file logs detailed activities of the VPN profile when it's processed on the device. Depending on how long the Company Portal app has been installed, you may have up to five *Omadmlog.log* files, and the timestamp of the last sync can help you find the related entries.

The following example uses [CMTrace](/mem/configmgr/core/support/cmtrace) to read the logs and searches for `android.vpn.client`.

:::image type="content" source="media/troubleshoot-vpn-profiles/cmtrace-android.png" alt-text="Screenshot that shows an example that uses CMTrace to read logs, and searches for android.vpn.client.":::

Sample log:

```output
<Date Time>    INFO    com.microsoft.omadm.platforms.android.vpn.client.IntentVpnProfileProvisionStateMachine    13229    00622    Notifying to provision vpn profile 'AnyConnect'.
<Date Time>    INFO    com.microsoft.omadm.platforms.android.vpn.client.IntentVpnProfileProvisionStateMachine    13229    00622    VPN Profile "AnyConnect" state changed from RECEIVED to PENDING_USER_INSTALL
<Date Time>    VERB    com.microsoft.omadm.platforms.android.vpn.client.VpnClient    13229    00002    Creating VPN Provision Intent: anyconnect://create/?host=VPN.contoso.com&name=AnyConnect&usecert=true&keychainalias=UserID
<Date Time>    INFO    com.microsoft.omadm.platforms.android.vpn.client.IntentVpnProfileProvisionStateMachine    13229    00002    Vpn profile 'AnyConnect' provisioned and complete.
<Date Time>    INFO    com.microsoft.omadm.platforms.android.vpn.client.IntentVpnProfileProvisionStateMachine    13229    00002    VPN Profile "AnyConnect" state changed from PENDING_USER_INSTALL to PROVISIONED
```

### [iOS](#tab/ios)

On an iOS device, Company Portal logs don't contain any information about VPN profiles. To see installation details of the VPN profiles, check the console or device logs as follows:

1. Connect the iOS device to Mac, and then select **Applications** > **Utilities** to open the Console app.
1. Under **Action**, check the **Include Info Messages** and **Include Debug Messages** options.

    :::image type="content" source="media/troubleshoot-vpn-profiles/action-menu-ios.png" alt-text="Screenshot that shows that the Include Info Messages and Include Debug Messages options are checked.":::

1. Reproduce the scenario, and save the logs to a text file:

    1. Select all the messages on the current screen: **Edit** > **Select All**.
    1. Copy the messages: **Edit** > **Copy**.
    1. Paste the log data in a text editor, and save the file.

1. To view detailed information, use the VPN profile name to search the file.

Sample log:

```output
debug    <Time> -0400    profiled    createConfigurationFromPayload type com.apple.vpn.managed.applayer, name 'ContosoVPN', atom \{\
    PayloadDisplayName = "VPN Profile - ContosoVPN";\
    UserDefinedName = ContosoVPN;\
        RemoteAddress = "Contoso.com";\
    PayloadDisplayName = "VPN Profile - ContosoVPN";\
    UserDefinedName = ContosoVPN;\
        RemoteAddress = "Contoso.com";\
    PayloadDisplayName = "VPN Profile - ContosoVPN";\
    UserDefinedName = ContosoVPN;\
        RemoteAddress = "Contoso.com";\
    RemoteAddress = "Contoso.com";\
debug    <Time> -0400    profiled    configurePluginWithPayload: done, serverAddress Contoso.com, providerConfiguration \{\
    RemoteAddress = "Contoso.com";\
        serverAddress = Contoso.com\
    PayloadDisplayName = "VPN Profile - ContosoVPN";\
    UserDefinedName = ContosoVPN;\
        RemoteAddress = "Contoso.com";\
        serverAddress = Contoso.com\
debug    <Time> -0400    profiled    NEConfiguration initWithAppLayerVPNPayload: done, serverAddress Contoso.com\
    PayloadIdentifier = "www.windowsintune.com.vpn.ContosoVPN";\
debug    <Time> -0400    profiled    NEProfileIngestion saveConfiguration: 'ContosoVPN'\
default    <Time> -0400    profiled     Saving configuration ContosoVPN with existing signature (null)\
default    <Time> -0400    profiled     Successfully saved configuration ContosoVPN\
default    <Time> -0400    profiled    Profile \'93www.windowsintune.com.vpn.ContosoVPN\'94 installed.\
```

### [Windows](#tab/windows)

On a Windows device, the details about VPN profiles are logged in the following locations in the Event Viewer:

- **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider** > **Admin**
- **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostic-Provider** > **Debug**

> [!NOTE]
> You must select the **Show Analytic and Debug Logs** option in the Event Viewer to see these logs.

Sample log:

```output
Event 6165
  Log Name: Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Debug
  Source: Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider
  Date: <Date Time>
  Event ID: 401
  Task: N/A
  Level: Information
  Opcode: Info
  Keyword: N/A
  User: SID
  User Name: NT AUTHORITY\SYSTEM
  Computer: <Computer Name>
  Description: 
MDM ConfigurationManager: CSP Node Operation. Configuration Source ID: (ID), Enrollment Name: (MDMFullWithAAD), Provider Name: (VPNv2), Operation: (Add), CSP URI: (./User/Vendor/MSFT/VPNv2), Child URI: (Contoso), Result: (The operation completed successfully.).
```

---

## Troubleshooting common issues

### Issue 1: The VPN profile isn't deployed to the device

#### [Android](#tab/android)

1. Verify that the VPN profile is assigned to the correct group.

    In the Intune portal, select **Device configuration** > **Profiles**, then select the profile, and then select **Assignments** to verify the selected groups.

    :::image type="content" source="media/troubleshoot-vpn-profiles/assign-vpn-profile-android.png" alt-text="Screenshot that shows the assigned VPN profile of a group for Android.":::

1. Verify that the device can sync with Intune by checking the **LAST CHECK IN** time on the **Troubleshoot** pane.

    :::image type="content" source="media/troubleshoot-vpn-profiles/troubleshoot-pane-android.png" alt-text="Screenshot that shows the LAST CHECK IN time on the Troubleshoot pane for Android." lightbox="media/troubleshoot-vpn-profiles/troubleshoot-pane-android.png":::

1. If the VPN profile is linked to the Trusted Root and SCEP profiles, verify that both profiles have been deployed to the device. The VPN profile has a dependency on these profiles.

    If the Trusted Root and SCEP profiles aren't installed on the device, you will see the following entry in the Company Portal log file (*Omadmlog.log*):

    `<Date Time>    INFO    com.microsoft.omadm.platforms.android.vpn.client.IntentVpnProfileProvisionStateMachine    14210    00948    Waiting for required certificates for vpn profile 'androidVPN'.`

    > [!NOTE]
    > It's possible that even though the Trusted Root and SCEP profiles are on the device and compliant, the VPN profile is still not on the device. This issue occurs when the `CertificateSelector` provider from the Company Portal app doesn't find a certificate that matches the specified criteria. The specific criteria can be in the certificate template or the SCEP profile. If the matching certificate isn't found, the certificates on the device will be excluded. Therefore, the VPN profile will be skipped because it doesn't have the correct certificate. In this scenario, you see the following entry in the Company Portal log file (*Omadmlog.log*):
    >
    > `Waiting for required certificates for vpn profile 'androidVPN'.`

    The following sample log shows that certificates are excluded because the **Any Purpose** Extended Key Usage (EKU) criteria was specified. However, the certificates that are assigned to the device don't have that EKU:

    ```output
    <Date Time>    VERB     com.microsoft.omadm.utils.CertUtils      14210    00948    Excluding cert with alias User<ID1> and requestId <requestID1> as it does not have any purpose EKU.
    <Date Time>    VERB     com.microsoft.omadm.utils.CertUtils      14210    00948    Excluding cert with alias User<ID2> and requestId <requestID2> as it does not have any purpose EKU.
    <Date Time>    VERB     com.microsoft.omadm.utils.CertUtils      14210    00948    0 cert(s) matched criteria:
    <Date Time>    VERB     com.microsoft.omadm.utils.CertUtils      14210    00948    2 cert(s) excluded by criteria:
    <Date Time>    INFO     com.microsoft.omadm.platforms.android.vpn.client.IntentVpnProfileProvisionStateMachine       14210     00948    Waiting for required certificates for vpn profile '<profile name>'.
    ```

    The following sample shows that the SCEP profile has the option of **Any Purpose** EKU specified. However, it isn't specified in the certificate template on the certificate authority (CA). To fix the issue, add the **Any Purpose** option to the certificate template or remove the **Any Purpose** option from the SCEP profile.

    :::image type="content" source="media/troubleshoot-vpn-profiles/any-purpose-option.png" alt-text="Screenshot that shows how to add the Any Purpose option." lightbox="media/troubleshoot-vpn-profiles/any-purpose-option.png":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/any-purpose-option-vpn-profile.png" alt-text="Screenshot that shows that the Any Purpose option is displayed." lightbox="media/troubleshoot-vpn-profiles/any-purpose-option-vpn-profile.png":::

1. Verify that the **External Control** option of AnyConnect is enabled.

    The **External Control** option must be enabled before the profile is created. When the profile is pushed to the device, the user is prompted to enable the **External Control** option.

    :::image type="content" source="media/troubleshoot-vpn-profiles/external-control-setting.png" alt-text="Screenshot that shows how to check the External Control option.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/external-control-setting-enabled.png" alt-text="Screenshot that shows the External Control option is enabled.":::

1. Verify that all required certificates in the complete certificate chain are on the device. Otherwise, you will see the following entry in the Company Portal log file (*Omadmlog.log*):

    `Waiting for required certificates for vpn profile 'androidVPN'.`

    For more information, see [Missing intermediate certificate authority](https://developer.android.com/training/articles/security-ssl#MissingCa).

#### [iOS](#tab/ios)

1. Verify that the VPN profile is assigned to the correct group.

    In the Intune portal, select **Device configuration** > **Profiles**, then select the profile, and then select **Assignments** to verify the selected groups.

    :::image type="content" source="media/troubleshoot-vpn-profiles/assign-vpn-profile-ios.png" alt-text="Screenshot that shows the assigned VPN profile of a group for iOS.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/assignments-ios.png" alt-text="Screenshot that shows the assignment information on the Troubleshoot pane for iOS":::

1. Verify that the device can sync with Intune by checking the **LAST CHECK IN** time on the **Troubleshoot** pane.

    :::image type="content" source="media/troubleshoot-vpn-profiles/troubleshoot-pane-ios.png" alt-text="Screenshot that shows the LAST CHECK IN time on the Troubleshoot pane for iOS.":::

1. If the VPN profile is linked to the Trusted Root and SCEP profiles, verify that both profiles have been deployed to the device. The VPN profile has a dependency on these profiles.

#### [Windows](#tab/windows)

1. Verify that the VPN profile is assigned to the correct group.

    In the Intune portal, select **Device configuration** > **Profiles**, then select the profile, and then select **Assignments** to verify the selected groups.

    :::image type="content" source="media/troubleshoot-vpn-profiles/assign-vpn-profile-windows.png" alt-text="Screenshot that shows the assigned VPN profile of a group for Windows.":::

1. Verify that the device can sync with Intune by checking the **LAST CHECK IN** time on the **Troubleshoot** pane.

    :::image type="content" source="media/troubleshoot-vpn-profiles/troubleshoot-pane-windows.png" alt-text="Screenshot that shows the LAST CHECK IN time on the Troubleshoot pane for Windows." lightbox="media/troubleshoot-vpn-profiles/troubleshoot-pane-windows.png":::

1. If the VPN profile is linked to the Trusted Root and SCEP profiles, verify that both profiles have been deployed to the device. The VPN profile has a dependency on these profiles.

1. For Windows 10 devices, check the MDM Diagnostic Information log.

    1. [Download the MDM Diagnostic Information log](/windows/client-management/mdm/diagnose-mdm-failures-in-windows-10#download-the-mdm-diagnostic-information-log-from-windows-10-pcs).
    1. To check the report, navigate to the *C:\Users\Public\Documents\MDMDiagnostics* folder.

    :::image type="content" source="media/troubleshoot-vpn-profiles/mdmdiagnostics-folder.png" alt-text="Screenshot that shows the MDMDiagnostics folder.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/mdm-diagnostic-information.png" alt-text="Screenshot that shows the MDM Diagnostic information.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/mdm-diagnostic-information-configuration-source.png" alt-text="Screenshot that shows the MDM Diagnostic information for configuration resource.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/mdm-connection-vpn-profiles.png" alt-text="Screenshot that shows the VPN profiles that are managed by the MDM connection.":::

---

### Issue 2: The VPN profile is deployed to the device, but the device can't connect to the network

Typically, this connectivity issue isn't an Intune issue, and there can be many causes. The following items may help you understand and troubleshoot the issue:

- Can you manually connect to the network by using a certificate that has the same criteria in the VPN profile?

    If you can, check the properties of the certificate that you used in the manual connection, and make changes to the Intune VPN profile.

- For Android and iOS devices, did the VPN client Application logs show that the device tried to connect to the VPN profile?

    Usually, connectivity errors are logged in VPN client application logs.

- For Windows devices, did the Radius server logs show that the device tried to connect to the VPN profile?

    Usually, connectivity errors are logged in Radius server logs.

## How to view logs in the AnyConnect app

To view logs, see the following two examples for Android and iOS devices.

### Example 1: View logs on Android devices

1. Select **Menu** > **Diagnostics**.

    :::image type="content" source="media/troubleshoot-vpn-profiles/diagnostics-function.png" alt-text="Screenshot that shows the Diagnostics function.":::

1. To view certificates, select **Certificate Management**.

    :::image type="content" source="media/troubleshoot-vpn-profiles/diagnostics-certificate-management.png" alt-text="Screenshot that shows the Certificate Management function.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/diagnostics-certificate-information.png" alt-text="Screenshot that shows the certificate information.":::

1. To view logs to analyze AnyConnect issues, select **Logging and System Information** > **Debug** .

    :::image type="content" source="media/troubleshoot-vpn-profiles/logging-and-system-information.png" alt-text="Screenshot that shows the Logging and System Information function.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/debug-information.png" alt-text="Screenshot that shows the debug information.":::

1. To send logs, select **Menu** > **Send Logs** > **Report to Administrator**.

    :::image type="content" source="media/troubleshoot-vpn-profiles/send-logs.png" alt-text="Screenshot that shows the Send Logs function.":::

    :::image type="content" source="media/troubleshoot-vpn-profiles/report-to-administrator.png" alt-text="Screenshot that shows the Report to Administrator function.":::

1. After you get the debug logs, check the *debug_logs_unfiltered.txt* file for profile creation and connection information.

Sample log for VPN creation:

```output
<Date Time> I/AnyConnect(14530): URIHandlerActivity: Received command: anyconnect://create?host=VPN.Contoso.com&name=AnyConnect&usecert=true&keychainalias=UserID
<Date Time> I/AnyConnect(14530): VpnService: VpnService is being created.
```

Sample log for VPN connection failure:

```output
<Date Time> I/vpnapi  (14530): Message type information sent to the user: Contacting VPN.Contoso.com.
<Date Time> I/vpnapi  (14530): Initiating VPN connection to the secure gateway https://VPN.Contoso.com
<Date Time> I/acvpnagent(14592): Using default preferences. Some settings (e.g. certificate matching) may not function as expected if a local profile is expected to be used. Verify that the selected host is in the server list section of the profile and that the profile is configured on the secure gateway.
<Date Time> I/acvpnagent(14592): Function: processConnectNotification File: MainThread.cpp Line: 14616 Received connect notification (host VPN.Contoso.com, profile N/A)
<Date Time> W/acvpnagent(14592): Function: getHostIPAddrByName File: SocketSupport.cpp Line: 344 Invoked Function: ::getaddrinfo Return Code: 11 (0x0000000B) Description: unknown 
<Date Time> W/acvpnagent(14592): Function: resolveHostName File: HostLocator.cpp Line: 710 Invoked Function: CSocketSupport::getHostIPAddrByName Return Code: -31129588 (0xFE25000C) Description: SOCKETSUPPORT_ERROR_GETADDRINFO 
<Date Time> W/acvpnagent(14592): Function: ResolveHostname File: HostLocator.cpp Line: 804 Invoked Function: CHostLocator::resolveHostName Return Code: -31129588 (0xFE25000C) Description: SOCKETSUPPORT_ERROR_GETADDRINFO failed to resolve host name VPN.Contoso.com to IPv4 address
<Date Time> I/vpnapi  (14530): Message type warning sent to the user: Connection attempt has failed.
<Date Time> E/vpnapi  (14530): Function: processIfcData File: ConnectMgr.cpp Line: 3399 Content type (unknown) received. Response type (DNS resolution failed) from VPN.Contoso.com: DNS resolution failed
<Date Time> I/vpnapi  (14530): Message type warning sent to the user: Unable to contact VPN.Contoso.com.
<Date Time> E/vpnapi  (14530): Function: processIfcData File: ConnectMgr.cpp Line: 3535 Unable to contact VPN.Contoso.com DNS resolution failed
<Date Time> I/vpnapi  (14530): Message type error sent to the user: The VPN connection failed due to unsuccessful domain name resolution.
```

### Example 2: View logs on iOS devices

1. To view the user certificate, select **Diagnostics** > **Certificates**.

    :::image type="content" source="media/troubleshoot-vpn-profiles/diagnostics-certificates.png" alt-text="Screenshot that shows imported certificates.":::

1. To view log messages, select **Diagnostics**, enable the **VPN Debug Logs** option to enable logging, and then select **Logs**.

    - To display the service debug log messages, select **Service**.
    - To display the application debug log messages, select **App**.

    :::image type="content" source="media/troubleshoot-vpn-profiles/vpn-dubug-logs.png" alt-text="Screenshot that shows the VPN Debug Logs option.":::

1. To send logs, select **Share Logs** in the **Diagnostics** window, enter the information about the problem, and then select **Send**.

    :::image type="content" source="media/troubleshoot-vpn-profiles/share-logs.png" alt-text="Screenshot that shows the Share Logs function.":::

1. After you get the debug logs, check the files for profile creation and connection information.

    :::image type="content" source="media/troubleshoot-vpn-profiles/debug-log-files.png" alt-text="Screenshot that shows the folder that has the debug log files.":::

Sample log of the *AnyConnect_App_Debug_Logs.txt* file that shows the VPN profile:

```output
[<Date Time>] Info: Function: SaveSettings File: AppleVpnConfig.mm Line: 198 SaveSettings {type = mutable dict, count = 3, entries => 0 : {contents = "RemoteAddress"} = {contents = "Contoso.com"} 1 : {contents = "AuthenticationMethod"} = {contents = "Certificate"} 2 : {contents = "LocalCertificate"} = <69646e74 00000000 000002d3> }
[<Date Time>] Info: Function: GetSettings File: AppleVpnConfig.mm Line: 175 GetSettings { AuthenticationMethod = Certificate; LocalCertificate = <69646e74 00000000 000002d3>; RemoteAddress = "Contoso.com"; }
[<Date Time>] Info: Function: -[AppleVpnConfigBatch startBatchSaveToSystem] File: AppleVpnConfigBatch.mm Line: 43 Invoking save to system with 0x28202fd60
[<Date Time>] Info: Function: saveToSystem_block_invoke File: AxtVpnConfig.mm Line: 222 Successfully saved profile for Contoso.com
[<Date Time>] Info: Function: -[AppleVpnConfigBatch startBatchSaveToSystem] File: AppleVpnConfigBatch.mm Line: 36 completed!.
```

Sample log of the *AnyConnect_Messages.txt* file that shows VPN connection failure:

```output
[<Date Time>] [VPN] - Contacting Contoso.com.
[<Date Time>] [VPN] - Connection attempt has failed.
[<Date Time>] [VPN] - Unable to contact CoolBreeze.com.
[<Date Time>] [VPN] - Connection attempt has timed out. Please verify Internet connectivity.
```

Sample log of the *AnyConnect_Plugin_Debug_Logs.txt* file that shows VPN connection failure:

```output
[<Date Time>] Info: Message type information sent to the user: Contacting Contoso.com.
[<Date Time>] Info: Initiating VPN connection to the secure gateway https://Contoso.com
[<Date Time>] Info: Function: NoticeCB File: AnyConnectAuthenticator.cpp Line: 2116 Sending notice Contacting Contoso.com. to App
[<Date Time>] Error: Function: SendRequest File: CTransportCurlStatic.cpp Line: 2046 Invoked Function: curl_easy_perform Return Code: -29949904 (0xFE370030) Description: CTRANSPORT_ERROR_TIMEOUT 28 : Error
[<Date Time>] Error: Function: TranslateStatusCode File: ConnectIfc.cpp Line: 3169 Invoked Function: TranslateStatusCode Return Code: -29949904 (0xFE370030) Description: CTRANSPORT_ERROR_TIMEOUT Connection attempt has timed out. Please verify Internet connectivity.
[<Date Time>] Error: Function: doConnectIfcConnect File: ConnectMgr.cpp Line: 2442 Invoked Function: ConnectIfc::connect Return Code: -29949904 (0xFE370030) Description: CTRANSPORT_ERROR_TIMEOUT 
[<Date Time>] Info: Message type warning sent to the user: Connection attempt has failed.
[<Date Time>] Error: Function: processIfcData File: ConnectMgr.cpp Line: 3407 Content type (unknown) received. Response type (host unreachable) from Contoso.com: 
[<Date Time>] Info: Message type warning sent to the user: Unable to contact Contoso.com.
[<Date Time>] Info: Function: NoticeCB File: AnyConnectAuthenticator.cpp Line: 2116 Sending notice Connection attempt has failed. to App
[<Date Time>] Error: Function: processIfcData File: ConnectMgr.cpp Line: 3543 Unable to contact Contoso.com 
[<Date Time>] Info: Function: NoticeCB File: AnyConnectAuthenticator.cpp Line: 2116 Sending notice Unable to contact Contoso.com. to App
[<Date Time>] Info: Message type error sent to the user: Connection attempt has timed out. Please verify Internet connectivity.
```

## More information

If you're still looking for a solution to a related issue, or if you want more information about Microsoft Intune, post a question in the [Microsoft Intune forum](https://social.technet.microsoft.com/Forums/en-US/home?forum=microsoftintuneprod%2Cwindowsintuneprod&filter=alltypes&sort=lastpostdesc). Many support engineers, MVPs, and members of the development team visit the forums. So, there's a good chance you can find someone with the information you need.

If you want to open a support request to the Microsoft Intune product support team, see [How to get support for Microsoft Intune](/intune/get-support).

For more information about VPN profiles in Intune, see the following articles:

- [Android device settings to configure VPN in Intune](/intune/vpn-settings-android)
- [Configure VPN settings on iOS devices in Microsoft Intune](/intune/vpn-settings-ios)
- [Windows 10 and Windows Holographic device settings to add VPN connections using Intune](/intune/vpn-settings-windows-10)
- [Support Tip - How to configure NDES for SCEP certificate deployments in Intune](https://techcommunity.microsoft.com/t5/Intune-Customer-Success/Support-Tip-How-to-configure-NDES-for-SCEP-certificate/ba-p/455125)
- [Troubleshooting SCEP certificate profile deployment in Microsoft Intune](../certificates/troubleshoot-scep-certificate-profiles.md)
- [Troubleshooting NDES configuration for use with Microsoft Intune certificate profiles](/mem/intune/protect/certificates-scep-configure)

For all the latest news, information, and tech tips, visit the official blogs:

- [The Microsoft Intune Support Team Blog](https://techcommunity.microsoft.com/t5/Intune-Customer-Success/bg-p/IntuneCustomerSuccess)
- [The Microsoft Enterprise Mobility and Security Blog](https://cloudblogs.microsoft.com/enterprisemobility)
