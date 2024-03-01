---
title: Troubleshooting a missing Android certificate in Intune
description: Troubleshoot when a user's Android device is missing a required certificate and can't enroll in Microsoft Intune.
ms.date: 12/05/2023
search.appverid: MET150
ms.reviewer: kaushika
---

# Android device is missing a required certificate

When a user tries to sign in to the Company Portal app on Microsoft Intune-managed Android device, they receive the error message "You can't sign in because your device is missing a required certificate."

## Cause

The user's device is missing a certificate or intermediate certificate necessary for enrollment, or a certificate has not been installed correctly. Continue through the following sections to diagnose and resolve the problem.

## Solution 1

The user might be able to retrieve the missing certificate. Ask the user to complete the steps in [Install missing certificate required by your organization](/mem/intune/user-help/your-device-is-missing-an-it-required-certificate-android). If the error persists, continue to Solution 2.

## Solution 2

After entering their corporate credentials and getting redirected for federated login, users might still see the missing certificate error. In this case, the error may mean that an intermediate certificate is missing from your Active Directory Federation Services (AD FS) server.

The certificate error occurs because Android devices require intermediate certificates to be included in an [SSL Server hello](/previous-versions/windows/it-pro/windows-server-2003/cc783349(v=ws.10)). Currently, a default AD FS server or WAP - AD FS Proxy server installation sends only the AD FS service SSL certificate in the SSL server hello response to an SSL Client hello.

To fix the issue, import the certificates into the Computers Personal Certificates on the AD FS server or proxies as follows:

1. On the AD FS and proxy servers, right-click **Start** > **Run** > **certlm.msc** to launch the Local Machine Certificate Management Console.
1. Expand **Personal** and choose **Certificates**.
1. Find the certificate for your AD FS service communication (a publicly signed certificate), and double-click to view its properties.
1. Choose the **Certification Path** tab to see the certificate's parent certificate(s).
1. On each parent certificate, choose **View Certificate**.
1. Choose **Details** > **Copy to file…**.
1. Follow the wizard prompts to export or save the public key of the parent certificate to the file location of your choice.
1. Right-click **Certificates** > **All Tasks** > **Import**.
1. Follow the wizard prompts to import the parent certificate(s) to **Local Computer\Personal\Certificates**.
1. Restart the AD FS servers.
1. Repeat the above steps on all of your AD FS and proxy servers.

### Validate that the certificate installed correctly

The following steps describe just one of many methods and tools that you can use to validate that the certificate installed correctly.

1. Go to the [free Digicert tool](https://www.digicert.com/help/).
2. In the **Server Address** box, enter your AD FS server's fully qualified domain name (for example, `sts.contoso.com`) and select **CHECK SERVER**.

If the Server certificate is installed correctly, you see all check marks in the results. If the problem above exists, you see a red X in the **Certificate Name Matches** and the **SSL Certificate is correctly Installed** sections of the report.

## Solution 3

The users are unable to authenticate in Company Portal, but they can authenticate in Microsoft Authenticator and web browsers. This issue occurs if your AD FS server uses a user certificate rather than a certificate issued by a public certificate authority (CA).

There are two certificate stores in Android devices:

- The user certificate store
- The system certificate store

Staring in Android 7.0, apps ignore user certificates by default, unless the apps explicitly opt in. For more information, see [Changes to Trusted Certificate Authorities in Android Nougat](https://android-developers.googleblog.com/2016/07/changes-to-trusted-certificate.html).

To fix this issue, use a certificate that chains to a publicly trusted root CA in your AD FS server. A list of public CAs on Android can be found at [https://android.googlesource.com/platform/system/ca-certificates/+/master/files/](https://android.googlesource.com/platform/system/ca-certificates/+/master/files/).
