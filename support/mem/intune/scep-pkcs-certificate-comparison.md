---
title: Learn about SCEP and PKCS certificates for authentication
description: Compares Simple Certificate Enrollment Protocol (SCEP) and Public Key Cryptography Standards (PKCS) certificates for authentication, which you can deliver with Microsoft Intune.
author: helenclu
ms.author: luche
ms.reviewer: sausarka
ms.date: 09/08/2021
ms.prod-support-area-path: 
---
# Choose between SCEP and PKCS for authentication

When a user tries to access protected company resources, the process generally involves authentication to determine user identity, and then authorization to confirm the user has access to a protected resource, and what the user can do with that data.

Typically, users authenticate  with a user name and password, via an app with a Wi-Fi or VPN connection. To make this process more seamless for your users, you can [use certificates for authentication](/mem/intune/protect/certificates-configure). Certificates offer more secure authentication and don't require your users to enter their credentials.
> [!NOTE]
> The certificate that the user uses to prove authenticity must come from a trusted certification authority (CA), such as a trusted third-party CA or an on-premises Microsoft CA.

You can use Microsoft Intune to deploy the following types of user or device certificates:

- Simple Certificate Enrollment Protocol (SCEP)
- Public Key Cryptography Standards (PKCS)

Both provide seamless authentication by delivering a certificate from a trusted CA in the intranet to a device that exists anywhere on the internet.

Intune is merely a delivery mechanism that's responsible for providing a certificate from an on-premises CA to devices through the internet. After the certificate is obtained by the device, the device is responsible for using the certificate to prove its authenticity. 

## SCEP versus PKCS

SCEP was originally developed by Cisco. It's based on the HTTP request-and-response model, such as the Get and POST methods. The SCEP certificate contains a private key, and the private key is marked as not exportable.

PKCS #12 is the successor to Microsoft PFX. The terms *PKCS #12* and *PFX* are sometimes used interchangeably. In contrary to SCEP, the PKCS certificate private key is exportable.

The following table lists points of comparison between SCEP and PKCS certificates:

|PKCS certificates|SCEP certificates|
|----------|-----------|
|Can be deployed through Intune.|Can be deployed through Intune.|
|Can be issued to a user who enrolls the device, or any device attribute.|Can be issued to a user who enrolls the device, or any device attribute.|
|Is less secure because the private key is marked as exportable.|Is more secure because the private key never leaves the device and is marked as **not** exportable.|
|Can't be issued to a user-less device, such as Android Enterprise dedicated devices and Apple Automated Device Enrollment (ADE) devices without user affinity. For more information, see [Support Tip: PKCS, SCEP, and, DEP devices without user affinity](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-pkcs-scep-and-dep-devices-without-user-affinity/ba-p/359061).|Can be issued to user-less devices.|
|Is less complex and requires less overhead to configure the [infrastructure](/mem/intune/protect/certificates-pfx-configure#requirements).|Is more complex and requires more overhead to configure the [infrastructure](/mem/intune/protect/certificates-scep-configure#prerequisites-for-using-scep-for-certificates).|
|Devices communicate with the Intune service, which acts as a mediator.|Devices communicate with the Network Device Enrollment Service (NDES) server through an Application Proxy.|
|Can be load balanced, but the process is not seamless.|Can be load balanced more seamlessly by providing URLs of multiple NDES servers in the SCEP profile.|

## Choose between SCEP and PKCS

When you decide which certificate to use, consider the needs of your organization.

On the one hand, PKCS is easier to deploy, and it has fewer components. A possible downside to PKCS is that it offers less security because the private key is marked as exportable. Also, a PKCS certificate can't be issued to a user-less device. On the other hand, SCEP is more secure but has more overhead because it has more components.

Before you decide, it's important to have a discussion within your organization to evaluate the following considerations:

- The kind of certificate that's required.
- The availability of a RADIUS server or VPN to provide authentication.
- The level of security that's required.

> [!TIP]
> SCEP is usually the preferred solution if you can afford the overhead.

For more information about how to configure and use SCEP and PKCS certificates, see [Configure infrastructure to support SCEP with Intune](/mem/intune/protect/certificates-scep-configure) and [Configure and use PKCS certificates with Intune](/en-us/mem/intune/protect/certificates-pfx-configure).
