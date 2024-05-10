---
title: Application Initialization fails with SSL
description: This article provides resolutions for the problem that Application Initialization module isn't working for web site configured to require SSL.
ms.date: 04/07/2020
ms.custom: sap:Performance
---
# Application Initialization module fails when web site requires SSL

This article helps you resolve the problem where Application Initialization module isn't working for web site configured to require Secure Sockets Layer (SSL).

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 2843964

## Symptoms

Application Initialization module formerly known as *Application Warmup* isn't working for web site configured to require SSL.

## Cause

This behavior is by design.

The warm-up module sends the request using Hypertext Transfer Protocol (HTTP) and not with Hypertext Transfer Protocol Secure (HTTPS). The workaround suggested will allow HTTP requests to localhost from warm-up module but it redirects to the HTTPS for the rest of the requests so by design here means that the warm-up module makes requests over HTTP.

## Resolution

To work around this limitation, you may consider enabling HTTP (unchecked the **Require SSL** setting under **IIS Manager** > **SSL Settings**) and use a URL Rewrite rule to redirect HTTP requests to HTTPS with the exception of the request coming from the warm-up module:

```xml
<rewrite>
    <rules>
        <rule name="No redirect on warmup request (request from localhost with warmup user agent)"
        stopProcessing="true">
            <match url=".*" />
            <conditions>
                <add input="{HTTP_HOST}" pattern="localhost" />
                <add input="{HTTP_USER_AGENT}" pattern="Initialization" />
            </conditions>
            <action type="Rewrite" url="{URL}" />
        </rule>
        <rule name="HTTP to HTTPS redirect for all requests" stopProcessing="true">
            <match url="(.*)" />
            <conditions>
                <add input="{HTTPS}" pattern="off" />
            </conditions>
            <action type="Redirect" url="https://{HTTP_HOST}/{R:1}" />
        </rule>
    </rules>
</rewrite>
```
