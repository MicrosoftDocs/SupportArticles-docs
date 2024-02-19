---
title: Fail to activate Windows Server over the Internet
description: Provides help to solve an error that occurs when you activate Windows Server 2003 over the Internet fails.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, willgloy
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# Error when you try to activate Windows Server 2003 over the Internet: Message Number 32777

This article provides workarounds to an issue where you see an error when you activate Microsoft Windows Server 2003 over the Internet fails.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 816897

## Symptoms

When you try to activate Windows Server 2003 over the Internet, Windows Product Activation may be unsuccessful and you may experience the following issues:

- You receive a message that prompts you for a user name and password.
- You receive the following error message:

    > Unable to establish a connection with the activation server. Please check your network settings and confirm that you are able to connect to the Internet, then try again. Message number 32777.

Windows Product Activation is unsuccessful whether or not you enter your user name and password.

## Cause

This issue occurs if both of the following conditions are true:

- Microsoft Internet Explorer's Enhanced Security Configuration is enabled on the server.
- You connect to the Internet through a proxy server where Basic Authentication is enabled.

The Internet Explorer Enhanced Security Configuration (also known as *Internet Explorer hardening*) uses certificate revocation. This certificate revocation lookup process involves a URL retrieval operation. In this case, the URL retrieval goes through the proxy server and occurs outside the explicit context of the logged-on user. Therefore, Basic Authentication mistakenly prompts you for a user account name and password. As the user, you are typically not aware that certificates are being validated, and you may be prompted repeatedly during the validation of a series of certificates.

To work around this issue, use one of the following methods.

> [!NOTE]
> The following methods are listed in the order of the most preferred to least preferred, with the most preferred method appearing first.

## Workaround 1: Don't use Basic Authentication

Avoid using Basic Authentication on the proxy server. If you must use Basic Authentication, exclude the URLs for the certificate revocation lists (CRLs) from the requirement for basic authentication. To do this, configure the following list of CRLs to be unauthenticated on the proxy server:

- `http://crl.microsoft.com/pki/crl/productsMicrosoftProductSecureServer.crl`
- `http://crl.microsoft.com/pki/crl/products/MicrosoftProductSecureCommunications.crl`
- `http://crl.microsoft.com/pki/crl/products/MicrosoftRootAuthority.crl`
- `http://www.microsoft.com/pki/crl/productsMicrosoftProductSecureServer.crl`
- `http://www.microsoft.com/pki/crl/products/MicrosoftProductSecureCommunications.crl`
- `http://www.microsoft.com/pki/crl/products/MicrosoftRootAuthority.crl`

## Workaround 2: Activate by using the telephone

If you receive the error message described in the [Symptoms](#symptoms) section of this article when you try to activate Windows, click the **Telephone** button in the Activate Windows Wizard to activate Windows over the telephone.

## Workaround 3: Turn off certificate revocation in Internet Explorer

Turn off certificate revocation in Internet Explorer to permit Windows activation to succeed. To do so, follow these steps.

> [!NOTE]
> Microsoft recommends that you do not turn off certificate revocation in Internet Explorer.

1. Start Internet Explorer.
2. On the **Tools** menu, click **Internet Options**.
3. Click the **Advanced** tab, and then clear the following check boxes in the **Settings** list:

    - **Check for publisher's certificate revocation**  
    - **Check for server certificate revocation (requires restart)**  

4. Click **Apply**, and then click **OK**.
5. Quit and then restart Internet Explorer.
6. Activate Windows.
7. In Internet Explorer, click **Internet Options** on the **Tools** menu.
8. Click the **Advanced** tab, and then select the following check boxes in the **Settings** list:

    - **Check for publisher's certificate revocation**  
    - **Check for server certificate revocation (requires restart)**  

9. Click **Apply**, and then click **OK**.
10. Quit and then restart Internet Explorer.

## More information

Because other issues may generate error message number 32777, you can view the Setuplog.txt file to determine whether the issue described in this article is the cause of this error. Status code 407 typically indicates the occurrence of the issue described in this article. The following is an example of Status code 407 as it appears in a Setuplog.txt file:

> *\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobmain\msobmain.cpp,4423,,DISPID_EXTERNAL_CONNECTEDTOINTERNETEx  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobcomm\connmgr.cpp,1560,,tries to connect to the WPA HTTP server  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobcomm\connmgr.cpp,2170,,Disabled RAS Autodial for current logon session  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobcomm\connmgr.cpp,1480,,HTTP status code from WPA HTTP server 407  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobcomm\connmgr.cpp,2184,,Restore value of RAS Autodial for current logon session  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobcomm\connmgr.cpp,1657,,could connect to WPA HTTP server  
*\<DateTime>*,OOBE Trace,0,,GetPreferredConnection: null  
*\<DateTime>*,OOBE Trace,0,,UseModem: false  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobmain\msobmain.cpp,3049,,DISPID_EXTERNAL_CONNECT  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobmain\msobmain.cpp,3054,,DISPID_EXTERNAL_RECONNECT  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobmain\msobmain.cpp,4500,,DISPID_EXTERNAL_ACTIVATE  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobmain\msobmain.cpp,6979,,Waiting for response from m_pLicenseAgent->AsyncProcessHandshakeRequest()  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobmain\msobmain.cpp,5724,,m_pLicenseAgent->AsyncProcessHandshakeRequest() failed. Error = 32777  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobmain\msobmain.cpp,311,,Windows Product Activation error.  
*\<DateTime>*,d:\dnsrv\base\ntsetup\oobe\msobmain\msobmain.cpp,313,,ReturnActivationStatus: Status = 7, Detail = 32777  
*\<DateTime>*,OOBE Trace,0,,Activation failed. Error = 7

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
