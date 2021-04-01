---
title: Error after installing Dynamics CRM phone
description: Provides a solution to an error that occurs when you configure Dynamics CRM for phones and tablets.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# You receive an error message while configuring Microsoft Dynamics CRM for phones and tablets

This article provides a solution to an error that occurs when you configure Dynamics CRM for phones and tablets.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2016, Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 2899983

## Symptoms

You've installed the Microsoft Dynamics CRM phone and tablet app, then receive the following error when you try to connect to your Microsoft Dynamics CRM organization:

Windows / iOS Application:
> "Your server is not available or does not support this application"

Android:
> "This operation failed because you're offline. Reconnect and try again."

## Cause

This error can occur in an on-premises environment if the certificate for the Microsoft Dynamics CRM website or federation server, such as ADFS, isn't trusted.

This error can occur with an online organization if your organization is federated with Office 365 and the certificate for your federation server, such as ADFS, isn't trusted.

## Resolution

Make sure the SSL (Secure Sockets Layer) certificate used is trusted by using a publicly trusted certificate or add the Certificate Authority certificate for the certificate of the Microsoft Dynamics CRM website and the federation server to the device.

Adding the Certificate Authority certificate to the proper device will require you to export the Certificate Authority certificate from a device that has it and then import it. In most cases, you can get the exported certificate on the device and open it to install/import it.

## More information

If you capture tracing, the following error is logged:

Windows 8:

> "Security certificate required to access this resource is invalid"

iPad:  

> "Loading app failed due to SSL error"

For more information about installing the Certificate Authority certificate, see the following articles:

- Windows - [How to Use the Certificates Console](https://social.technet.microsoft.com/wiki/contents/articles/2167.how-to-use-the-certificates-console.aspx)
- Android - [Add & remove certificates](https://support.google.com/pixelphone/answer/2844832)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
