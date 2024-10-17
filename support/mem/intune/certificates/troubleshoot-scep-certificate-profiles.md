---
title: Troubleshoot use of Simple Certificate Enrollment Protocol (SCEP) certificate profiles to provision certificates with Microsoft Intune
description: Troubleshoot the use of SCEP by devices to request certificates for use with Intune, including communication from devices to Network Device Enrollment Service (NDES), NDES to certification authorities, and from the Intune Certificate Connector to the Intune service.  
ms.date: 10/16/2024
ms.reviewer: kaushika, lacranda, cajenk
search.appverid: MET150
ms.custom: sap:Configure Devices - iOS\SCEP Certificates
---
# Troubleshooting SCEP certificate profiles with Intune

This article gives guidance to help you troubleshoot and resolve issues with Simple Certificate Enrollment Protocol (SCEP) certificate profiles in Microsoft Intune. The following sections cover these concepts:

- The architecture and the communication flow of the SCEP process
- Narrowing down where a problem exists in that communication flow
- Identifying the key log files that are referenced in subsequent articles for troubleshooting certificate profiles

The information in this article and related SCEP certificate troubleshooting articles applies to using SCEP certificate profiles with Android, iOS/iPad, and Windows devices. Similar information for macOS isn't available at this time. To troubleshoot Network Device Enrollment Service (NDES), see the following articles:

- [Verify NDES configuration on-premises for SCEP certificates in Intune](verify-ndes-configuration.md)
- [Configure infrastructure to support SCEP with Intune](/mem/intune/protect/certificates-scep-configure)

Before proceeding, ensure you've met the [prerequisites for using SCEP certificate profiles](/mem/intune/protect/certificates-scep-configure#prerequisites-for-using-scep-for-certificates), including the deployment of a root certificate through a trusted certificate profile.

## SCEP communication flow overview

The following image demonstrates a basic overview of the SCEP communication process in Intune. Each step includes a link to an article with more prescriptive guidance.

:::image type="content" source="media/troubleshoot-scep-certificate-profiles/scep-certificate-profile-flow.png" alt-text="Screenshot shows the SCEP certificate profile flow.":::

1. [Deploy a SCEP certificate profile](troubleshoot-scep-certificate-profile-deployment.md). Intune generates a challenge string, which requires a specific user, certificate purpose, and certificate type.

2. [Device to NDES server communication](troubleshoot-scep-certificate-device-to-ndes.md). The device uses the URI for NDES from the profile to contact the NDES server so it can present a challenge.

3. [NDES to policy module communication](troubleshoot-scep-certificate-ndes-policy-module.md). NDES forwards the challenge to the Intune Certificate Connector policy module on the server, which validates the request.

4. [NDES to certification authority](troubleshoot-scep-certificate-ndes-policy-module.md). NDES passes valid requests to issue a certificate to the Certification Authority (CA).

5. [Certificate delivery to the device](troubleshoot-scep-certificate-delivery.md). The certificate is delivered to the device.

6. [Reporting of deployment to Intune](troubleshoot-scep-certificate-reporting.md). The Intune Certificate Connector reports the certificate issuance event to Intune.

## Log files

To identify problems for the communication and certificate provisioning workflow, review log files from both the Server infrastructure, and from devices. Later sections for troubleshooting SCEP certificate profiles refer to log files referenced in this section.

- [Infrastructure and server logs](#logs-for-on-premises-infrastructure)

Device logs depend on the device platform:  

- [iOS and iPadOS](#logs-for-ios-and-ipados-devices)
- [Android](#logs-for-android-devices)
- [Windows](#logs-for-windows-devices)

### Logs for on-premises infrastructure
  
On-premises infrastructure that supports use of SCEP certificate profiles for certificate deployments includes the Microsoft Intune Certificate Connector, NDES that runs on a Windows Server, and the certification authority.

Log files for these roles include Windows Event Viewer, considered as Intune connector logs, and Internet Information Services (IIS) logs:

- **Intune connector logs**:

  These logs show all requests and communications from the devices and Intune cloud services.

  Location: On the server that hosts NDES, open **Event Viewer** > **Applications and Services Logs** > **Microsoft** > **Intune** > **CertificateConnectors** > **Admin** and **Operational**.

- **IIS logs**:

  IIS logs show the certificate requests from mobile devices entering NDES.

  Location: On the server that hosts NDES at *c:\inetpub\logs\LogFiles\W3SVC1*.

### Logs for Android devices

> [!NOTE]
> Before you collect and review logs, ensure [Verbose Logging](/mem/intune/user-help/use-verbose-logging-to-help-your-it-administrator-fix-device-issues-android) is enabled, and then reproduce the issue.

Depending on the enrollment type:

- Personally owned devices with a work profile (BYOD): review the *OMADM.log* file.

  To collect the *OMADM.log* file from a device, see [Upload and email logs using a USB cable](/mem/intune/user-help/send-logs-to-your-it-admin-using-cable-android).

  You can also [upload and email logs](/mem/intune/user-help/send-logs-to-your-it-admin-by-email-android#upload-and-email-logs-from-microsoft-intune-app) to support.

- Corporate-owned work profile (COPE), fully managed (COBO), or dedicated devices (COSU): review the *CloudExtension.log* file.

### Logs for iOS and iPadOS devices

For devices that run iOS/iPadOS, collect console logs on a Mac computer:

1. Connect the iOS/iPadOS device to Mac, and then go to **Applications** > **Utilities** to open the Console app.

2. Under **Action**, select **Include Info Messages** and **Include Debug Messages**.

    :::image type="content" source="media/troubleshoot-scep-certificate-profiles/message-options.png" alt-text="Screenshot shows the Include Info Messages and Include Debug Messages options are selected.":::

3. Reproduce the problem, and then save the logs to a text file:
   1. Select **Edit** > **Select All** to select all the messages on the current screen, and then select **Edit** > **Copy** to copy the messages to the clipboard.
   2. Open the TextEdit application, paste the copied logs into a new text file, and then save the file.

The Company Portal log for iOS and iPadOS devices doesn't contain information about SCEP certificate profiles.

### Logs for Windows devices

For devices that run Windows, use the Windows Event logs to diagnose enrollment or device management issues for devices that you manage with Intune.

On the device, open **Event Viewer** > **Applications and Services Logs** > **Microsoft** > **Windows** > **DeviceManagement-Enterprise-Diagnostics-Provider**.

:::image type="content" source="media/troubleshoot-scep-certificate-profiles/windows-event-log.png" alt-text="Screenshot of the Windows event logs in Event Viewer.":::

## Next steps

[Troubleshoot deployment of a SCEP certificate profile to devices in Microsoft Intune](troubleshoot-scep-certificate-profile-deployment.md)
