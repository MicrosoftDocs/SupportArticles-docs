---
title: Error when browsing your website over the default cloud service domain url
description: Provides information about troubleshooting issues in which you get an error (HTTP Error 503. The service is unavailable.) when accessing your cloud service application.
ms.date: 09/26/2022
ms.reviewer: 
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-cloud-services-classic
ms.custom: sap:Development
---
# Error when browsing your website over the default cloud service domain url: HTTP Error 503. The service is unavailable

This article provides information about troubleshooting issues in which you get an error "HTTP Error 503. The service is unavailable." when accessing your cloud service application.

_Original product version:_ &nbsp; API Management Service  
_Original KB number:_ &nbsp; 4464854

> [!NOTE]
> Refer to the article on [Azure Cloud Service Troubleshooting Series](https://support.microsoft.com/help/4466645), this is the fifth scenario of the lab. Make sure you have followed the lab setup instructions for Super Convertor application as per [this](https://github.com/prchanda/superconvertor), to recreate the problem.

## Symptoms

You are getting HTTP Error 503 response while browsing your cloud service application url (`http://cloudservicelabs.cloudapp.net/`), although your web role 'SuperConvertor' is in running state. Rebooting or Reimaging the role instance is not resolving the issue.

> Service Unavailable
>
> HTTP Error 503. The service is unavailable.

## Troubleshooting steps

When you get 50x errors in your application, it usually means something is broken at the server side. `503 Service Unavailable` server error response code indicates that the server is not ready to handle the request. You must be thinking why suddenly a newly deployed cloud service application suddenly started throwing this error. Is the application crashing? Is the request reaching the IIS server? Is the server under high load?

Firstly, check on-premises IIS server. You can connect to the web role instance using RDP and browse the application locally. Before browsing the site locally, check the Application and System event viewer logs to negate any possibility of IIS ApplicationPool crash  or any other application-related exceptions.

Next, check the IIS logs present under `C:\Resources\directory\{Deployment ID}.SuperConvertor.DiagnosticStore\LogFiles\Web` to check if you can get more information about the HTTP 503 error like substatus code, time taken to execute the request, and so on.

If there are no logs generated, this means the request is not reaching to the IIS at all. As per IIS architecture, HTTP.sys listens for HTTP requests from the network, passes the requests onto IIS for processing, and then returns processed responses to client browsers. By default, IIS provides HTTP.sys as the protocol listener that listens for HTTP and HTTPS requests and any error at HTTP.sys level is logged in this directory - `D:\Windows\System32\LogFiles\HTTPERR`. So let's see what we can find in HTTPErr log:

```console
#Software: Microsoft HTTP API 2.0
#Version: 1.0
#Date: 2018-08-13 03:12:38
#Fields: date time c-ip c-port s-ip s-port cs-version cs-method cs-uri streamid sc-status s-siteid s-reason s-queuename
2018-08-13 03:25:22 293.217.138.127 12052 10.1.2.5 80 HTTP/1.1 GET / - 503 - N/A -
2018-08-13 03:25:22 293.217.138.127 20463 10.1.2.5 80 HTTP/1.1 GET /favicon.ico - 503 - N/A -
```

If you see the above log, HTTP 503 is thrown from HTTP.sys level and the client request is getting rejected from there itself without reaching the IIS. Now we are going to browse the site locally from IIS and see what happens - You might get an error - _This page can't be displayed_.One thing you might notice is that the IIS website was having a binding like below, which means in order to access this particular website you need to access over the custom domain name (`www.cloudservicelabs.com`)

|IP Address| Port| Host Header|
|---|---|---|
| 10.1.2.5| 80| `www.cloudservicelabs.com` |

Websites are accessed by every client using bindings. A typical binding for Websites is in the form of IP:Port:HostHeader. It is a mechanism that tells the server how this site can be reached. The next question that will come to your mind is that from where does this custom hostname came from.

ServiceDefinition.csdef is the place where you can configure the bindings for your web role, and here is what you might see for your application:

```console
<WebRole name="SuperConvertor" vmsize="Standard_D1_v2">
<Sites>
<Site name="Web">
<Bindings>
<Binding name="Endpoint1" endpointName="Endpoint1" hostHeader="www.cloudservicelabs.com"/></Bindings>
</Site>
</Sites>
```

In real world scenario, in order to access your cloud service application over a custom hostname, you need to have a DNS configured for this host header corresponding to the cloud service VIP. For now, you can delete the **hostHeader** attribute from **Binding** element and redeploy your cloud service solution to resolve the issue.

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
