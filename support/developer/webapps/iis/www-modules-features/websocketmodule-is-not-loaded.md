---
title: WebSocketModule isn't loaded in IIS 8.0
description: This article provides resolutions to enable the WebSocket Protocol feature and avoid the WebSocketModule is not loaded error in IIS 8.0.
ms.date: 04/15/2020
ms.custom: sap:WWW modules and features
ms.subservice: www-modules-features
ms.reviewer: piyushjo
---
# WebSocketModule is not loaded when you use WebSockets with WCF 4.5 or ASP.NET in IIS 8.0

This article helps you resolve the error (WebSocketModule is not loaded) that occurs when the WebSocket Protocol feature isn't enabled in Microsoft Internet Information Services (IIS) 8.0.

_Original product version:_ &nbsp; Internet Information Services 8.0, ASP.NET on .NET Framework 4.5.2  
_Original KB number:_ &nbsp; 2778043

## Symptoms

The following error message occurs when you try to communicate with a Windows Communication Foundation (WCF) service configured with `NetHttpBinding` (for WebSockets) or an ASP.NET website over WebSockets protocol when hosted in IIS 8.0:

> The WebSocketModule is not loaded. Check if the WebSocket feature is installed and the WebSocketModule is enabled in the list of IIS modules (see [https://go.microsoft.com/fwlink/?LinkId=231398](https://go.microsoft.com/fwlink/?linkid=231398) for details).

## Cause

This problem can occur if the WebSocket Protocol feature isn't enabled in IIS 8.0.

## Resolution

To resolve this problem, enable the WebSocket Protocol feature in IIS 8.0. To achieve this, choose one of the following options:

1. From an administrative command prompt, run the following command:

    ```console
    %SystemRoot%\system32\dism.exe /online /enable-feature /featurename:IIS-WebSockets
    ```

2. To enable the WebSocket Protocol feature using the UI on Windows 8, navigate to **Control Panel** > **Programs** > **Turn Windows features on or off** > **Internet Information Services** > **World Wide Web Services** > **Application Development Features** > **WebSocket Protocol**.

3. To enable the WebSocket Protocol feature using the UI on Windows Server 2012, navigate to **Server Roles** > **Web Server (IIS)** > **Web Server** > **Application Development** > **WebSocket Protocol**.

4. To enable the WebSocket Protocol feature using a startup task in Azure:

   - Create a *Startup.cmd* file with the following command in the cloud service project:

        ```console
        %SystemRoot%\system32\dism.exe /online /enable-feature /featurename:IIS-WebSockets
        ```

   - Set **Build Action** to **None** and set **Copy to Output Directory** to **Copy Always** on this *Startup.cmd* file.

   - Add the following in the *ServiceDefinition.csdef* file:

    ```xml
    <Startup>
        <Task commandLine="Startup.cmd"
        executionContext="elevated" taskType="simple"/>
    </Startup>
    ```
