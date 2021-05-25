---
title: You can't sign in to Lync clients on devices that don't support SNI
description: Explains that users on devices that don't support Server Name Indication (SNI) can't sign in to Skype for Business or Lync clients, when you use Active Directory Federation Services 3.0 (ADFS). Provides a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: romanma, dahans
appliesto:
- Skype for Business Online
---

# You can't sign in to Skype for Business or Lync clients on devices that don't support Server Name Indication (SNI)

## Problem

When you use Active Directory Federation Services 3.0 (ADFS) as an identity federation provider, devices that don't support Server Name Indication (SNI) won't be able to sign in.

> [!NOTE]
> This issue currently occurs on Polycom CX phone devices and some Lync Phone Edition devices.

## Workaround

To work around this issue as a Skype for Business administrator, associate the SSL certificate with the ADFS web URL for each ADFS server in your environment. To do this, follow these steps:

1. Run the following command on the ADFS servers: 

    ```powershell
    netsh http show sslcert 
    ```
   The application ID and certificate hash is returned in the output. The website URL is also reported. If there's more than one website configured on the server, search for the website URL first, and then obtain the corresponding application ID and certificate hash.
1. Run the following commands in the same window:netsh

    ```powershell
    HTTP
    
    add SSLCert IPPORT=0.0.0.0:443 certhash=certhash appid=appid 
    ```
    > [!NOTE]
    > - Replace the IP address in this command (0.0.0.0) with the IP address that you want to specify. Also replace the port value with the specific port that's configured for the website. This is typically 443 for ADFS 3.0. For most customers, binding the SSL certificate to all IP addresses is recommended.   
    > - The **appid** value must include the braces.    
   
For more information about these commands, go to the following Microsoft websites:

- [How to publish Lync Server 2013 Web Services with Windows Server 2012 R2 Web application proxy](/archive/blogs/dodeitte/how-to-publish-lync-server-2013-web-services-with-windows-server-2012-r2-web-application-proxy)   
- [How to: Configure a port with an SSL certificate](/dotnet/framework/wcf/feature-details/how-to-configure-a-port-with-an-ssl-certificate)   

## More Information

This issue occurs when the following conditions are true:

- You have a Windows Server 2012 R2-based server that has ADFS 3.0 installed.    
- There's a new Server Name Indication (SNI) feature in ADFS 3.0, but some platforms don't support this yet. Support for SNI depends on the device's operating system in question. Although the clients themselves support this new feature, the device platform may not.   

> [!NOTE]
> If you need help configuring ADFS 3.0, we recommend that you contact ADFS 3.0 technical support. We also recommended that you run the most recent versions of the ADFS 3.0 components. 

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).