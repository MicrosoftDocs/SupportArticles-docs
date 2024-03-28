---
title: Using ADAL to authenticate from Android devices fails if additional certificate downloads are required
description: Describes an issue in which ADAL authentication from Android devices fails if additional certificate downloads are required. Provides a resolution.
ms.date: 05/22/2020
ms.reviewer: 
ms.service: entra-id
ms.subservice: authentication
---
# Using ADAL to authenticate from Android devices fails if additional certificate downloads are required

This article describes an issue in which Azure Active Directory Authentication Library (ADAL) authentication from Android devices fails if additional certificate downloads are required.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3203929

## Symptoms

When you try to authenticate by using the ADAL for Android, Federation sign-in may fail. Specifically, the application triggers an AuthenticationException error when it tries to display the login page. In Google Chrome, the STS login page might be called out as unsafe. This issue occurs only on Android devices, for any application that uses ADAL for Android to connect to a Federation server.

To determine whether you are experiencing this issue, run the following test:

1. Obtain your Security Token Service (STS) server's fully qualified domain name (FQDN). To do this, follow these steps:

   1. Go to [https://login.microsoftonline.com](https://login.microsoftonline.com) on a non-Android device.
   2. Enter your work or school account.
   3. When you're redirected to your federated STS login page, note the URL address in the browser. It looks like `https://sts.contoso.com`. The FQDN is `sts.contoso.com`.

2. Go to the following URL, replacing \<STS_SERVER_FQDN_HERE> with your STS FQDN:

    `https://www.ssllabs.com/ssltest/analyze.html?d=<STS_SERVER_FQDN_HERE>&hideResults=on&latest`

    For example:

    `https://www.ssllabs.com/ssltest/analyze.html?d=sts.contoso.com&hideResults=on&latest`
3. See whether any of the following messages are displayed:
   - Extra download
   - Sent by server
   - In trust store

    If any of the SSL certificates displays the "Extra download" message, you are experiencing the issue that's described earlier in this section, per the following screenshot:

    :::image type="content" source="media/adal-authenticate-android-devices-fail/extra-download-message.png" alt-text="Screenshot of the extra download message." border="false":::

    Here's a screenshot showing a certificate with the "Sent by server" message, illustrating successful authentication on an Android device:

    :::image type="content" source="media/adal-authenticate-android-devices-fail/sent-by-server-message.png" alt-text="Screenshot of the Sent by server message." border="false":::

## Cause

Android does not support downloading additional certificates from the **authorityInformationAccess** field of the certificate. This is true across all Android versions and devices, and for the Chrome browser. Any server authentication certificate that's marked for extra download based on the **authorityInformationAccess**  field will trigger this error if the entire certificate chain is not passed from Active Directory Federation Services (AD FS).

## Resolution

To resolve this issue, configure your STS and Web Application Proxy (WAP) servers to send the necessary intermediate certificates together with the SSL certificate. To do this, follow these steps:

1. When you export the SSL certificate from a computer to the computer's personal store of the AD FS and WAP server (or servers), make sure that you export the Private key and that you select **Personal Information Exchange - PKCS #12**. Also make sure that the Include all certificates in the certificate path if possible  and Export all extended properties check boxes are selected.
2. Run `certlm.msc`  on the Windows servers, and then import the *.PFX file into the computer's personal certificate store. When you do this, the server will pass the entire certificate chain when a client application uses ADAL for authentication.

> [!NOTE]
> The certificate store of Network Load Balancers should also be updated to include the entire certificate chain.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
