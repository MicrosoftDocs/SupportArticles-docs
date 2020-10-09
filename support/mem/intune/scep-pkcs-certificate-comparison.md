---
title: Use certificates for authentication
description: Compares Simple Certificate Enrollment Protocol (SCEP) and Public Key Cryptography Standards (PKCS) certificates for authentication. Helps you decide which one is better for your organization.
author: helenclu
ms.author: luche
ms.reviewer: sausarka
ms.date: 10/09/2020
ms.prod-support-area-path: 
---
# Support Tip: Use certificates for authentication and choose between SCEP and PKCS

When you try to access protected company resources, generally you must go through the following two phases:

- Authentication: The process of determining your identity.
- Authorization: The process of determining whether you have access to a resource. It specifies what data you're allowed to access and what you can do with that data.   

Typically, authentication for an app, a Wi-Fi or VPN connection is done by entering a username and password. To make this process more seamless for your users, use certificates for authentication. Using certificates for authentication has the following advantages:

- It provides more secured authentication.
- Your end users won't need to enter usernames and passwords.  

> [!NOTE]
> The certificate that the user uses to prove authenticity must come from a trusted Certification Authority (CA), such as a trusted third-party CA or an on-premises Microsoft CA.

You can deploy two types of user or device certificates using Intune: Simple Certificate Enrollment Protocol (SCEP) and Public Key Cryptography Standards (PKCS). Both of them provide seamless authentication by delivering a certificate from a trusted CA in the intranet to a device present anywhere over the Internet. 

Intune is simply a delivery mechanism responsible for providing a certificate from an on-premises CA to devices through the Internet. Once the certificate is acquired by the device, it's up to the device to use it when proving its authenticity.

## SCEP versus PKCS

SCEP was originally developed by Cisco. It's based on the HTTP request/response model like the Get and POST methods. The SCEP certificate contains a private key, and the private key is marked as not exportable.

PKCS #12 is the successor to Microsoft's PFX. The terms *PKCS #12* and *PFX* are sometimes used interchangeably. In contrary to SCEP, the PKCS certificate private key is exportable.

The following table lists a comparison between SCEP and PKCS certificates:

|PKCS certificates|SCEP certificates|
|----------|-----------|
|Can be deployed through Intune|Can be deployed through Intune|
|Can be issued to a user who enrolls the device, or any device attribute|Can be issued to a user who enrolls the device, or any device attribute|
|Less secured as the private key is marked as exportable|More secured as the private key never leaves the device and is marked as **not** exportable|
|Can't be issued to a user-less device, such as Android Enterprise dedicated devices and Apple Automated Device Enrollment (ADE) devices without user affinity. For more information, see [Support Tip: PKCS, SCEP, and, DEP devices without user affinity](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-pkcs-scep-and-dep-devices-without-user-affinity/ba-p/359061).|Can be issued to user-less devices|
|Less complex and lower overhead to configure the [infrastructure](/mem/intune/protect/certificates-pfx-configure#requirements)|More complex and higher overhead to configure the [infrastructure](/mem/intune/protect/certificates-scep-configure#prerequisites-for-using-scep-for-certificates)|
|Devices communicate with the Intune service, which acts as a mediator|Devices communicate with the Network Device Enrollment Service (NDES) server through an Application Proxy|
|Can be load balanced but not very seamless|Can be load balanced more seamlessly by providing URLs of multiple NDES servers in the SCEP profile|

## Choose between SCEP and PKCS

When you decide which one to use, consider the needs of your organization.

On one hand, PKCS is easier to deploy and has fewer components involved. A possible downside is that it offers comparatively less security because the private key is marked as exportable. And a PKCS certificate can't be issued to a user-less device. On the other hand, SCEP is comparatively more secure but it has higher overhead because of more components.

Before you make the decision, it's important to have a discussion within your organization to evaluate the following aspects:

- What type of certificate is needed.
- The availability of a RADIUS server or VPN to provide authentication.
- The level of security required.

> [!TIP]
> In most situations, SCEP is the preferred solution if the overhead can be afforded.

For more information about how to configure and use SCEP and PKCS certificates, see [Configure infrastructure to support SCEP with Intune](/mem/intune/protect/certificates-scep-configure) and [Configure and use PKCS certificates with Intune](/en-us/mem/intune/protect/certificates-pfx-configure).
