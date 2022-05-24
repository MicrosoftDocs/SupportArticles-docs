---
title: Can't use HTTPS protocol in Release Management
description: This article describes the problem that can occur when you configure a Release Management server to use the HTTPS protocol, and provides a resolution.
ms.date: 04/27/2020
ms.reviewer: achand, daleche, muthuk, sriramb, ronai, ans, leov
---
# Deployment fails when you use the HTTPS protocol in Release Management

This update helps you resolve the problem where you have no option to use the HTTPS protocol in the Release Management Server Configuration tool.

_Original product version:_ &nbsp; Release Management Client for Visual Studio 2013, Release Management Visual Studio 2013, Release Management for Team Foundation Server 2013  
_Original KB number:_ &nbsp; 2905743

## Symptoms

Consider the following scenario:

- You install Microsoft Release Management for Visual Studio 2013.
- You install an HTTPS certificate.
- You configure Internet Information Services (IIS) to use the HTTPS certificate.
- You try to configure Release Management to use the HTTPS protocol by using the Release Management Server Configuration tool.

In this scenario, you don't have an option to use the HTTPS protocol in the Release Management Server Configuration tool. Therefore, you can't use the installed HTTPS certificate.

## Resolution

To resolve this issue, use one of the following methods:

- Download and install [Visual Studio 2013 Update 1](https://support.microsoft.com/help/2911573).
- Manually configure the Release Management services website and components to use the HTTPS protocol. To do this, follow these steps:

   1. In IIS, configure the Release Management services website bindings to use the installed HTTPS certificate.
   2. Locate the following code in the Release Management service *Web.config* file.

        > [!NOTE]
        > The Release Management service *Web.config* file is located in the `<Release_Management_server>/services/` directory.

        ```xml
        <basicHttpBinding>
            <binding name="fileTransferServiceBinding" transferMode="Streamed" messageEncoding="Mtom" maxReceivedMessageSize="10067108864">
                <!-- TODO: Set security mode to "TransportCredentialOnly" for HTTP or "Transport" for HTTPS. -->
                <security mode="TransportCredentialOnly">
                    <transport clientCredentialType="Windows"/>
                </security>
            </binding>
        < /basicHttpBinding>
        ```

   3. Change the `security mode` value to **Transport** as in the following sample code:

      ```xml
      <basicHttpBinding>
          <binding name="fileTransferServiceBinding" transferMode="Streamed" messageEncoding="Mtom" maxReceivedMessageSize="10067108864">
              <!-- TODO: Set security mode to "TransportCredentialOnly" for HTTP or "Transport" for HTTPS. -->
              <security mode="Transport">
                  <transport clientCredentialType="Windows"/>
              </security>
          </binding>
      </basicHttpBinding>
      ```

   4. Configure the URLs in the following files to use the HTTPS protocol and the correct port number:
      - The *Web.config* file that is located in the `Release_Management_server\services\` folder.
      - The *Web.config* file that is located in the `Release_Management_server\web\` folder.
      - The *Microsoft.TeamFoundation.Release.Data.dll.config* file that is located in the `Microsoft_Deployment_Agent\bin\` folder.
   5. Recycle the Release Management Application Pool.
   6. Restart the Release Management Monitor Service and the Microsoft Deployment Agent Service in the Services item in Control Panel.

## References

[known issues that you may experience after you install Release Management for Visual Studio 2013](https://support.microsoft.com/help/2905736)
