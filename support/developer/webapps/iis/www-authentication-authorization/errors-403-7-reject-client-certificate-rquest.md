---
title: IIS may reject requests with HTTP 403.7 or 403.16 errors
description: This article provides resolutions for the problem where IIS 8 may reject client certificate requests with HTTP 403.7 or 403.16 errors.
ms.date: 12/11/2020
ms.custom: sap:WWW Authentication and Authorization
ms.reviewer: emmanubo
ms.technology: www-authentication-authorization
---
# IIS may reject client certificate requests with HTTP 403.7 or 403.16 errors

This article helps you resolve the problem where Internet Information Services (IIS) 8 may reject client certificate requests with HTTP 403.7 or 403.16 errors.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2802568

## Symptoms

Consider the following scenario. You have an IIS 8 web application that is configured to use SSL and client certificate authentication. You install a certificate that is not self-signed, such as an Intermediate CA certificate, into the Local Computer --> **Trusted Root Certification Authorities certificate** store on the IIS server. When a user then sends an HTTP request to the web application and attempts to authenticate using a client certificate, one of the following error messages may be sent as a response by the IIS server:

> HTTP 403.16 - Client certificate is untrusted or invalid.

OR

> HTTP 403.7 - Client certificate required.

## Cause

The problem's symptoms may vary depending on the configuration and use of a Certificate Trust List (CTL) on the IIS server:

- *SCENARIO 1 - HTTP 403.16 error*

    If IIS is not configured to use a CTL, SSL client certificate authentication will fail with the 403.16 error condition. This error occurs because SChannel.dll wrongly considers the client certificate to be untrusted.

    > [!NOTE]
    > Having no CTL in use is the default configuration of IIS 8.0. This is configured by having no `SendTrustedIssuerList` present or by `setting SendTrustedIssuerList=0`.

    In this scenario, the IIS log typically shows a value of 2148204809 in the `sc-win32-status` field. This translates to error code 0x800b0109, which is defined as `CERT_E_UNTRUSTEDROOT`.

- *SCENARIO 2 - HTTP 403.7 error*  

    If you configure IIS to use a CTL (`SendTrustedIssuerList=1`), client certificate authentication fails with the 403.7 error condition. This error occurs because the CTL sent by IIS does not contain the Trusted Root Certificate for the user's client certificate, therefore Internet Explorer is not able to present the user with any valid client certificates to choose from.

## Workaround

To work around these issues, uninstall the non-self-signed certificate from the Local Computer --> **Trusted root Certification authorities certificate** store on the IIS server.

## More information

This issue has the same root cause as the problem described in Lync Server: [Lync Server 2013 Front-End service cannot start in Windows Server 2012](https://support.microsoft.com/help/2795828).

You may consider using the PowerShell script provided in the above article to detect the non-self-signed certificates installed in the **Trusted Root Certification Authorities certificate** store.
