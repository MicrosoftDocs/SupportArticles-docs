---
title: ASP.NET SignalR application is not working in Azure cloud service
description: Provides information about troubleshooting issues where ASP.NET SignalR application is not working in Azure Cloud Service.
ms.date: 09/26/2022
ms.reviewer: 
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-cloud-services-classic
ms.custom: sap:Development
---
# ASP.NET SignalR application is not working in Azure cloud service

This article provides information about troubleshooting issues where ASP.NET SignalR application is not working in Azure Cloud Service.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464827

> [!NOTE]
> Refer to the article on [Azure Cloud Service Troubleshooting Series](https://support.microsoft.com/help/4466645), this is the eighth scenario of the lab. Make sure you have followed the lab setup instructions for Visitor Tracker application as per [this](https://github.com/prchanda/visitortracker), to recreate the problem.

## Symptoms

Visitor Tracker is an ASP.NET SignalR application that tracks the number of visitors accessing the website. Each user is given a unique tracking ID that is displayed on the browser as the user moves the mouse pointer. As new users keep on visiting the site, the other users will be able to see new tracking IDs on their browsers. Click on the below image to get an idea of the expected output.

:::image type="content" source="media/scenario-8-aspnet-signalr-application-not-work/tracking-id.png" alt-text="Screenshot shows a tracking ID when other user moves the mouse pointer.":::

But after few days the application stopped working i.e users are not able to see their tracking IDs as well as for the other users on the browser.

## Troubleshoot steps

SignalR uses the WebSocket transport where available, and falls back to older transports (Server Sent Events, Forever Frame (for Internet Explorer only), Ajax long polling) where necessary - This is known as SignalR transport negotiation. Refer [this](/aspnet/signalr/overview/getting-started/introduction-to-signalr) article to know more. You can determine what transport your application is using by taking a fiddler or F12 browser trace.

Example of F12 developer trace:

:::image type="content" source="media/scenario-8-aspnet-signalr-application-not-work/developer-trace.png" alt-text="Screenshot of the developer trace." lightbox="media/scenario-8-aspnet-signalr-application-not-work/developer-trace.png":::

From the above developer trace, you can see that client tried to connect over number of transports but all of them failed with 404 error. You can check the server response for the first negotiate request for which you got HTTP 200 response.

`Request URL : http://cloudservicelabs.cloudapp.net:81/tracker/negotiate?clientProtocol=1.3&_=1534347303083`

## Response

```output
{
   "Url": "/tracker",
   "ConnectionToken": "w9ppacqBDsP/uF90AZ97VYm6L+PYAz03iQPlEiU0uIwSZwEDXih+XHb0PV/FO9T+/22xmJp+St+tDlDg/cMUy1U9Of382YCNa94RYOOpRmsm8MNofd2eLpPNDFXXXX",
   "ConnectionId": "GUID",
   "KeepAliveTimeout": 20,
   "DisconnectTimeout": 30,
   "ConnectionTimeout": 110,
   "TryWebSockets": false,
   "ProtocolVersion": "1.3",
   "TransportConnectTimeout": 5,
   "LongPollDelay": 0
}
```

From the above network trace it's clear that client tried to connect over WebSocket but Server doesn't support it. Also note that for SignalR to use WebSocket, IIS 8 must be used, the server must be Windows Server 2012, or later, and WebSocket must be enabled in IIS. You are using Windows Server 2016 but you need to check if WebSocket is enabled in IIS or not. In order to confirm that, log in to one of the instances and opened Add Roles and Features Wizard from Server Manager.

Expand Web Server (IIS) role verify if WebSocket protocol was enabled:

:::image type="content" source="media/scenario-8-aspnet-signalr-application-not-work/websocket-feature.png" alt-text="Screenshot of the Add Roles and Features Wizard that shows the WebSocket protocol status.":::

In order to enable WebSocket feature you can use the below DISM command in a startup task, so that when the role starts it installs the WebSocket feature in IIS.

```console
%SystemRoot%\system32\DISM.exe /Online /Enable-Feature /FeatureName:IIS-WebSockets
```

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
